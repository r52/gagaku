import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/reader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

void main() {
  setUpAll(() {
    logger = Logger(level: Level.off);
  });

  group('WebSourceBroker', () {
    late Queue<({int statusCode, Object? data})> responses;
    late List<RequestOptions> requests;
    late _MemoryCacheManager cache;
    late _TestExtensionSource extension;
    late WebSourceBroker broker;

    setUp(() {
      responses = Queue();
      requests = [];
      cache = _MemoryCacheManager();
      extension = _TestExtensionSource(_extensionManga('Original title'));
      final dio = Dio(BaseOptions(validateStatus: (_) => true));
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            requests.add(options);
            final response = responses.removeFirst();
            handler.resolve(
              Response<dynamic>(
                requestOptions: options,
                statusCode: response.statusCode,
                data: response.data,
              ),
            );
          },
        ),
      );
      addTearDown(dio.close);
      final container = ProviderContainer(
        overrides: [
          cacheProvider.overrideWithValue(cache),
          webSourceDioProvider.overrideWithValue(dio),
          extensionSourceProvider('source-1').overrideWith(() => extension),
        ],
      );
      addTearDown(container.dispose);
      broker = container.read(webSourceBrokerProvider);
    });

    test('serves cached extension manga until invalidated', () async {
      const series = WebSeriesRef.extension(
        sourceId: 'source-1',
        mangaId: 'manga-1',
      );

      expect((await broker.getManga(series))?.title, 'Original title');
      extension._manga = _extensionManga('Updated title');
      expect((await broker.getManga(series))?.title, 'Original title');

      await broker.invalidateAll(series.key);
      expect((await broker.getManga(series))?.title, 'Updated title');
      expect(requests, isEmpty);
    });

    test(
      'fetches and caches proxy manga independently of extensions',
      () async {
        responses.add((statusCode: 200, data: _cubariResponse()));
        const series = WebSeriesRef.proxy(
          proxyId: 'gist',
          seriesId: 'series-1',
        );

        final manga = await broker.getManga(series);
        final cached = await broker.getManga(series);

        expect(manga?.title, 'Proxy series');
        expect(cached?.title, 'Proxy series');
        expect(
          requests.single.uri.toString(),
          'https://cubari.moe/read/api/gist/series/series-1/',
        );
      },
    );

    test('refetches a corrupt cache entry', () async {
      const series = WebSeriesRef.proxy(proxyId: 'gist', seriesId: 'series-1');
      cache.values[series.key] = 'invalid cached manga';
      responses.add((statusCode: 200, data: _cubariResponse()));

      expect((await broker.getManga(series))?.title, 'Proxy series');
      expect((await broker.getManga(series))?.title, 'Proxy series');
      expect(requests, hasLength(1));
    });

    test('does not cache an unsuccessful proxy manga response', () async {
      const series = WebSeriesRef.proxy(proxyId: 'gist', seriesId: 'series-1');
      responses.add((statusCode: 503, data: null));
      expect(await broker.getManga(series), isNull);

      responses.add((statusCode: 200, data: _cubariResponse()));
      expect((await broker.getManga(series))?.title, 'Proxy series');
    });

    test('reports proxy chapter API failures with their status', () async {
      responses.add((statusCode: 503, data: {'error': 'offline'}));

      await expectLater(
        broker.getProxyAPI('/read/api/imgur/chapter/album-1'),
        throwsA(
          isA<ApiException>().having(
            (error) => error.statusCode,
            'statusCode',
            503,
          ),
        ),
      );
    });
  });

  group('reader route reconstruction', () {
    test('proxy route parameters reconstruct a typed chapter reference', () {
      final chapter = proxyReaderRouteRef(
        proxy: 'gist',
        code: 'series-1',
        chapter: '12-5',
      );

      expect(
        chapter.series,
        const WebSeriesRef.proxy(proxyId: 'gist', seriesId: 'series-1'),
      );
      expect(chapter.chapterId, '12.5');
    });

    test(
      'extension route parameters reconstruct a typed chapter reference',
      () {
        final chapter = extensionReaderRouteRef(
          sourceId: 'source-1',
          mangaId: 'manga-1',
          chapterId: 'chapter-1',
        );

        expect(
          chapter.series,
          const WebSeriesRef.extension(
            sourceId: 'source-1',
            mangaId: 'manga-1',
          ),
        );
        expect(chapter.chapterId, 'chapter-1');
      },
    );
  });

  group('HistoryLink legacy persistence', () {
    late Store store;

    setUpAll(() {
      store = Store(
        getObjectBoxModel(),
        directory: 'memory:gagaku_source_broker_test_db',
      );
      GagakuData().store = store;
    });

    setUp(() {
      store.box<HistoryLink>().removeAll();
      store.box<WebFavoritesList>().removeAll();
      store.box<WebFavoritesList>().put(
        WebFavoritesList(id: historyListUUID, name: 'extension_history'),
      );
    });

    tearDownAll(() {
      store.close();
    });

    test('ObjectBox round-trip writes the versioned series payload', () {
      final link = HistoryLink.fromSeries(
        title: 'Series',
        series: const WebSeriesRef.extension(
          sourceId: 'source-1',
          mangaId: 'manga-1',
        ),
      );

      store.box<HistoryLink>().put(link);
      final restored = store.box<HistoryLink>().get(link.dbid);

      expect(restored, isNotNull);
      expect(restored!.series, link.series);
      expect(json.decode(restored.dbHandle!), {
        'version': 2,
        'series': {
          'sourceId': 'source-1',
          'mangaId': 'manga-1',
          'type': 'extension',
        },
      });
    });

    test('legacy chapter-bearing DB payload decodes as series-only', () {
      final link = HistoryLink(title: 'Series', url: 'source-1/manga-1')
        ..dbHandle = json.encode({
          'type': 'source',
          'sourceId': 'source-1',
          'location': 'manga-1',
          'chapter': 'temporary-chapter',
        });

      expect(
        link.series,
        const WebSeriesRef.extension(sourceId: 'source-1', mangaId: 'manga-1'),
      );
      expect(link.dbHandle, isNot(contains('temporary-chapter')));
    });

    test('legacy backup JSON decodes and rewrites as a typed series', () {
      final link = HistoryLink.fromJson({
        'title': 'Series',
        'url': 'source-1/manga-1',
        'handle': {
          'type': 'source',
          'sourceId': 'source-1',
          'location': 'manga-1',
          'chapter': 'temporary-chapter',
        },
        'lastAccessed': null,
      });

      expect(
        link.series,
        const WebSeriesRef.extension(sourceId: 'source-1', mangaId: 'manga-1'),
      );
      expect(link.toJson(), isNot(contains('handle')));
      expect(json.encode(link.toJson()), isNot(contains('temporary-chapter')));
    });

    test(
      'history recording rejects links without a series reference',
      () async {
        final link = HistoryLink(
          title: 'Unresolved',
          url: 'https://example.com/unresolved',
        );

        await expectLater(
          WebHistoryManager().record(link, preserveHistory: false),
          throwsArgumentError,
        );
      },
    );

    test('history recording applies the preserve-history policy', () async {
      final manager = WebHistoryManager();
      final recorded = HistoryLink.fromSeries(
        title: 'Recorded',
        series: const WebSeriesRef.extension(
          sourceId: 'source-1',
          mangaId: 'recorded',
        ),
      );
      final omitted = HistoryLink.fromSeries(
        title: 'Omitted',
        series: const WebSeriesRef.extension(
          sourceId: 'source-1',
          mangaId: 'omitted',
        ),
      );
      final existing = HistoryLink.fromSeries(
        title: 'Old title',
        series: const WebSeriesRef.extension(
          sourceId: 'source-1',
          mangaId: 'existing',
        ),
      );
      store.box<HistoryLink>().put(existing);
      final updated = HistoryLink.fromSeries(
        title: 'Updated title',
        series: existing.requireSeries,
      );

      await manager.record(recorded, preserveHistory: true);
      await manager.record(omitted, preserveHistory: false);
      await manager.record(updated, preserveHistory: false);

      final listQuery = store
          .box<WebFavoritesList>()
          .query(WebFavoritesList_.id.equals(historyListUUID))
          .build();
      final history = listQuery.findUnique()!;
      listQuery.close();

      expect(history.list, contains(recorded));
      expect(history.list, isNot(contains(omitted)));
      final omittedQuery = store
          .box<HistoryLink>()
          .query(HistoryLink_.url.equals(omitted.url))
          .build();
      expect(omittedQuery.findUnique(), isNull);
      omittedQuery.close();

      final updatedQuery = store
          .box<HistoryLink>()
          .query(HistoryLink_.url.equals(updated.url))
          .build();
      expect(updatedQuery.findUnique()?.title, 'Updated title');
      updatedQuery.close();
    });

    test('normal extension factories create series-level references', () {
      final source = WebSourceInfo(
        id: 'source-1',
        name: 'Source',
        repo: 'repo',
        version: SupportedVersion.v0_9,
        icon: '',
      );
      final link = HistoryLink.fromSearchReultItem(
        source,
        SearchResultItem(
          mangaId: 'manga-1',
          title: 'Series',
          imageUrl: 'https://example.com/cover.jpg',
          subtitle: null,
        ),
      );

      expect(link.url, 'source-1/manga-1');
      expect(link.series?.key, link.url);
    });
  });
}

class _TestExtensionSource extends ExtensionSource {
  _TestExtensionSource(this._manga);

  WebManga _manga;

  @override
  Future<WebSourceInfo> build(String sourceId) async =>
      WebSourceInfo(id: sourceId, name: 'Test source', repo: 'test', icon: '');

  @override
  Future<WebManga?> getManga(String mangaId) async => _manga;
}

class _MemoryCacheManager implements CacheManager {
  final Map<String, Object?> values = {};

  @override
  Future<bool> exists(String key) async => values.containsKey(key);

  @override
  T get<T>(String key, [UnserializeCallback? unserializer]) => values[key] as T;

  @override
  Future<T> put<T>(
    String key,
    String data,
    T reference, {
    Duration expiry = const Duration(minutes: 15),
    UnserializeCallback? unserializer,
  }) async {
    values[key] = reference;
    return reference;
  }

  @override
  Future<void> remove(String key) async {
    values.remove(key);
  }

  @override
  Future<void> invalidateAll(String startsWith) async {
    values.removeWhere((key, _) => key.startsWith(startsWith));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

WebManga _extensionManga(String title) {
  return WebManga.extension(
    data: SourceManga(
      mangaId: 'manga-1',
      mangaInfo: MangaInfo(
        thumbnailUrl: 'https://example.com/cover.jpg',
        synopsis: 'Description',
        primaryTitle: title,
        secondaryTitles: const [],
        contentRating: ContentRating.EVERYONE,
      ),
    ),
    chaptersList: const [],
  );
}

Map<String, dynamic> _cubariResponse() {
  return {
    'title': 'Proxy series',
    'description': 'Description',
    'artist': 'Artist',
    'author': 'Author',
    'cover': 'https://example.com/cover.jpg',
    'chapters': <String, dynamic>{},
  };
}
