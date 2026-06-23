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

  group('WebSourceBroker link handling', () {
    late _RecordingWebSourceTransport transport;
    late _MemoryCacheManager cache;
    late List<HistoryLink> history;
    late ProviderContainer container;
    late WebSourceBroker broker;

    setUp(() {
      transport = _RecordingWebSourceTransport();
      cache = _MemoryCacheManager();
      history = [];

      final provider = Provider<WebSourceBroker>((ref) {
        return WebSourceBroker(
          ref,
          transport: transport,
          cache: cache,
          extensionExists: (sourceId) async => sourceId == 'installed',
          extensionMangaFetcher: (sourceId, mangaId) async =>
              _cubariManga(title: '$sourceId/$mangaId'),
          historySink: history.add,
        );
      });
      container = ProviderContainer();
      addTearDown(container.dispose);
      broker = container.read(provider);
    });

    test(
      'recognizes an extension series without remote source loading',
      () async {
        final handle = await broker.handleUrl(url: 'installed/manga-1');

        expect(
          handle,
          SourceHandler(
            type: SourceType.source,
            sourceId: 'installed',
            location: 'manga-1',
          ),
        );
        expect(transport.requests, isEmpty);
        expect(history, isEmpty);
      },
    );

    test('rejects missing and malformed extension links locally', () async {
      expect(await broker.handleUrl(url: 'missing/manga-1'), isNull);
      expect(await broker.handleUrl(url: 'installed'), isNull);
      expect(transport.requests, isEmpty);
    });

    test('recognizes Cubari series and direct chapter links', () async {
      final series = await broker.handleUrl(
        url: 'https://cubari.moe/read/imgur/album/',
      );
      final chapter = await broker.handleUrl(
        url: 'https://cubari.moe/read/imgur/album/4/',
      );

      expect(
        series,
        SourceHandler(
          type: SourceType.proxy,
          sourceId: 'imgur',
          location: 'album',
        ),
      );
      expect(
        chapter,
        SourceHandler(
          type: SourceType.proxy,
          sourceId: 'imgur',
          location: 'album',
          chapter: '4',
        ),
      );
      expect(transport.requests, isEmpty);
    });

    test(
      'resolves a proxy redirect without following it automatically',
      () async {
        transport.enqueue(
          statusCode: 302,
          headers: {
            'location': ['/read/gist/series-1/7/'],
          },
        );

        final handle = await broker.handleUrl(
          url: 'https://cubari.moe/legacy-link',
        );

        expect(
          handle,
          SourceHandler(
            type: SourceType.proxy,
            sourceId: 'gist',
            location: 'series-1',
            chapter: '7',
          ),
        );
        expect(transport.requests.single.followRedirects, isFalse);
      },
    );

    test(
      'rejects proxy redirects that do not target a Cubari read path',
      () async {
        transport.enqueue(
          statusCode: 302,
          headers: {
            'location': ['https://example.com/not-supported'],
          },
        );

        expect(
          await broker.handleUrl(url: 'https://cubari.moe/legacy-link'),
          isNull,
        );
      },
    );

    test('normalizes an Imgur album into a one-chapter proxy handle', () async {
      final handle = await broker.handleUrl(url: 'https://imgur.com/a/album-1');

      expect(
        handle,
        SourceHandler(
          type: SourceType.proxy,
          sourceId: 'imgur',
          location: 'album-1',
          chapter: '1',
        ),
      );
      expect(history, hasLength(1));
      expect(history.single.url, 'https://imgur.com/a/album-1');
      expect(history.single.handle, handle);
    });
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
          extensionExists: (_) async => true,
          extensionMangaFetcher: (sourceId, mangaId) async {
            extensionFetches++;
            return _cubariManga(title: '$sourceId/$mangaId');
          },
          historySink: (_) {},
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
    });

    tearDownAll(() {
      store.close();
    });

    test('ObjectBox round-trip preserves the legacy handler payload', () {
      final link = HistoryLink(
        title: 'Series',
        url: 'source-1/manga-1',
        handle: SourceHandler(
          type: SourceType.source,
          sourceId: 'source-1',
          location: 'manga-1',
          chapter: 'temporary-chapter',
        ),
      );

      store.box<HistoryLink>().put(link);
      final restored = store.box<HistoryLink>().get(link.dbid);

      expect(restored, isNotNull);
      expect(restored!.handle, link.handle);
      expect(restored.dbHandle, json.encode(link.handle!.toJson()));
    });

    test('normal extension factories create series-level handlers', () {
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

      expect(link.handle?.chapter, isNull);
      expect(link.url, 'source-1/manga-1');
      expect(link.handle?.getKey(), link.url);
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
