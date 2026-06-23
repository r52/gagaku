import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/reader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

void main() {
  setUpAll(() {
    logger = Logger(level: Level.off);
  });

  group('WebSourceBroker execution dispatch', () {
    late _RecordingWebSourceTransport transport;
    late _MemoryCacheManager cache;
    late ProviderContainer container;
    late WebSourceBroker broker;
    var extensionFetches = 0;

    setUp(() {
      transport = _RecordingWebSourceTransport();
      cache = _MemoryCacheManager();
      extensionFetches = 0;

      final provider = Provider<WebSourceBroker>((ref) {
        return WebSourceBroker(
          ref,
          transport: transport,
          cache: cache,
          extensionMangaFetcher: (sourceId, mangaId) async {
            extensionFetches++;
            return _cubariManga(title: '$sourceId/$mangaId');
          },
        );
      });
      container = ProviderContainer();
      addTearDown(container.dispose);
      broker = container.read(provider);
    });

    test(
      'dispatches extension manga fetches and caches by series key',
      () async {
        final handle = SourceHandler(
          type: SourceType.source,
          sourceId: 'source-1',
          location: 'manga-1',
        );

        final first = await broker.getMangaFromSource(handle);
        final second = await broker.getMangaFromSource(handle);

        expect(first?.title, 'source-1/manga-1');
        expect(second, same(first));
        expect(extensionFetches, 1);
        expect(transport.requests, isEmpty);
        expect(cache.values, contains(handle.getKey()));
      },
    );

    test(
      'dispatches proxy manga fetches through the local transport',
      () async {
        transport.enqueue(statusCode: 200, data: _cubariResponse());
        final handle = SourceHandler(
          type: SourceType.proxy,
          sourceId: 'gist',
          location: 'series-1',
        );

        final manga = await broker.getMangaFromSource(handle);

        expect(manga?.title, 'Proxy series');
        expect(
          transport.requests.single.uri.toString(),
          'https://cubari.moe/read/api/gist/series/series-1/',
        );
        expect(cache.values, contains(handle.getKey()));
      },
    );

    test('proxy chapter API failures remain observable', () async {
      transport.enqueue(
        statusCode: 503,
        statusMessage: 'Unavailable',
        data: {'error': 'offline'},
      );

      await expectLater(
        broker.getProxyAPI('/read/api/imgur/chapter/album-1'),
        throwsA(
          isA<Exception>().having(
            (error) => error.toString(),
            'message',
            contains('Failed to download API data'),
          ),
        ),
      );
    });
  });

  group('reader route reconstruction', () {
    test('proxy parameters are temporarily packed into SourceHandler', () {
      final handle = proxyReaderRouteHandle(
        proxy: 'gist',
        code: 'series-1',
        chapter: '12-5',
      );

      expect(handle.type, SourceType.proxy);
      expect(handle.sourceId, 'gist');
      expect(handle.location, 'series-1');
      expect(handle.chapter, '12.5');
    });

    test('extension parameters are temporarily packed into SourceHandler', () {
      final handle = extensionReaderRouteHandle(
        sourceId: 'source-1',
        mangaId: 'manga-1',
        chapterId: 'chapter-1',
      );

      expect(handle.type, SourceType.source);
      expect(handle.sourceId, 'source-1');
      expect(handle.location, 'manga-1');
      expect(handle.chapter, 'chapter-1');
    });
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
        ..dbHandle = json.encode(
          SourceHandler(
            type: SourceType.source,
            sourceId: 'source-1',
            location: 'manga-1',
            chapter: 'temporary-chapter',
          ).toJson(),
        );

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

class _RecordedWebRequest {
  const _RecordedWebRequest(this.uri, this.followRedirects);

  final Uri uri;
  final bool followRedirects;
}

class _QueuedWebResponse {
  const _QueuedWebResponse({
    required this.statusCode,
    required this.data,
    required this.statusMessage,
    required this.headers,
  });

  final int? statusCode;
  final dynamic data;
  final String? statusMessage;
  final Map<String, List<String>> headers;
}

class _RecordingWebSourceTransport implements WebSourceTransport {
  final Queue<_QueuedWebResponse> _responses = Queue();
  final List<_RecordedWebRequest> requests = [];

  void enqueue({
    required int? statusCode,
    dynamic data,
    String? statusMessage,
    Map<String, List<String>> headers = const {},
  }) {
    _responses.add(
      _QueuedWebResponse(
        statusCode: statusCode,
        data: data,
        statusMessage: statusMessage,
        headers: headers,
      ),
    );
  }

  @override
  Future<Response<dynamic>> getUri(
    Uri uri, {
    bool followRedirects = true,
  }) async {
    requests.add(_RecordedWebRequest(uri, followRedirects));
    if (_responses.isEmpty) {
      throw StateError('No local response queued for $uri');
    }
    final response = _responses.removeFirst();
    return Response<dynamic>(
      requestOptions: RequestOptions(path: uri.toString()),
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      headers: Headers.fromMap(response.headers),
    );
  }
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

WebManga _cubariManga({required String title}) {
  return WebManga.cubari(
    title: title,
    description: 'Description',
    artist: 'Artist',
    author: 'Author',
    cover: 'https://example.com/cover.jpg',
    cubariChapters: const [],
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
