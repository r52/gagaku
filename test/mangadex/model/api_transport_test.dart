import 'dart:async';
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/util/authentication.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/util/http.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';

void main() {
  setUpAll(() {
    logger = Logger();
  });

  group('MangaDexModel transport seam', () {
    late ProviderContainer container;
    late _RecordingTransport transport;
    late _MemoryCacheManager cache;
    late MangaDexModel model;

    setUp(() {
      transport = _RecordingTransport();
      cache = _MemoryCacheManager();
      container = ProviderContainer(
        overrides: [
          mdConfigProvider.overrideWithValue(
            MangaDexConfig(
              translatedLanguages: {Language.en},
              originalLanguage: {Language.ja},
              contentRating: {ContentRating.safe},
              groupBlacklist: {'blocked-group'},
            ),
          ),
        ],
      );
      model = container.read(
        Provider(
          (ref) => MangaDexModel(
            ref,
            transport: transport,
            cache: cache,
            authenticationCheck: () async => true,
          ),
        ),
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('records GET query parameters without network access', () async {
      transport.enqueue(statusCode: 200, data: {'data': <dynamic>[]});
      final first = Manga(id: 'manga-1');
      final second = Manga(id: 'manga-2');

      final result = await model.fetchReadChapters([first, second]);

      expect(result.keys, unorderedEquals([first.id, second.id]));
      expect(transport.requests, hasLength(1));
      final request = transport.requests.single;
      expect(request.method, _HttpMethod.get);
      expect(request.uri.host, 'api.mangadex.org');
      expect(request.uri.path, MangaDexEndpoints.getRead);
      expect(
        request.uri.queryParametersAll['ids[]'],
        unorderedEquals([first.id, second.id]),
      );
      expect(request.uri.queryParameters['grouped'], 'true');
      expect(request.data, isNull);
    });

    test('records POST body', () async {
      transport.enqueue(statusCode: 200, data: {'result': 'ok'});
      final manga = Manga(id: 'manga-1');

      expect(
        await model.setMangaReadingStatus(manga, MangaReadingStatus.completed),
        isTrue,
      );

      final request = transport.requests.single;
      expect(request.method, _HttpMethod.post);
      expect(request.uri.path, '/manga/${manga.id}/status');
      expect(request.data, {'status': MangaReadingStatus.completed.name});
    });

    test('records DELETE request', () async {
      transport.enqueue(statusCode: 200, data: {'result': 'ok'});
      final manga = Manga(id: 'manga-1');

      expect(await model.setMangaFollowing(manga, false), isTrue);

      final request = transport.requests.single;
      expect(request.method, _HttpMethod.delete);
      expect(request.uri.path, '/manga/${manga.id}/follow');
      expect(request.data, isNull);
    });

    test('boolean mutations preserve false-on-failure contracts', () async {
      final manga = Manga(id: 'manga-1');
      final list = _customList('list-1', name: 'List');
      transport
        ..enqueue(statusCode: 200, data: {'result': 'not-ok'})
        ..enqueue(statusCode: 404, data: {'result': 'error'})
        ..enqueue(statusCode: 403, data: {'result': 'error'})
        ..enqueue(statusCode: 200, data: {'result': 'not-ok'});

      expect(await model.setMangaFollowing(manga, true), isFalse);
      expect(await model.setMangaRating(manga, 8), isFalse);
      expect(await model.setFollowList(list, false), isFalse);
      expect(
        await model.setMangaReadingStatus(manga, MangaReadingStatus.reading),
        isFalse,
      );

      expect(transport.requests.map((request) => request.method), [
        _HttpMethod.post,
        _HttpMethod.post,
        _HttpMethod.delete,
        _HttpMethod.post,
      ]);
    });

    test('rating and list-follow toggles preserve verbs and bodies', () async {
      final manga = Manga(id: 'manga-1');
      final list = _customList('list-1', name: 'List');
      for (var i = 0; i < 4; i++) {
        transport.enqueue(statusCode: 200, data: {'result': 'ok'});
      }

      expect(await model.setMangaRating(manga, 9), isTrue);
      expect(await model.setMangaRating(manga, null), isTrue);
      expect(await model.setFollowList(list, true), isTrue);
      expect(await model.setFollowList(list, false), isTrue);

      expect(transport.requests[0].method, _HttpMethod.post);
      expect(transport.requests[0].uri.path, '/rating/${manga.id}');
      expect(transport.requests[0].data, {'rating': 9});
      expect(transport.requests[1].method, _HttpMethod.delete);
      expect(transport.requests[1].data, isNull);
      expect(transport.requests[2].method, _HttpMethod.post);
      expect(transport.requests[2].uri.path, '/list/${list.id}/follow');
      expect(transport.requests[3].method, _HttpMethod.delete);
    });

    test('reading and chapter markers preserve request bodies', () async {
      final manga = Manga(id: 'manga-1');
      final read = _chapter('chapter-1');
      final unread = _chapter('chapter-2');
      transport
        ..enqueue(statusCode: 200, data: {'result': 'ok'})
        ..enqueue(statusCode: 200, data: {'result': 'ignored'});

      expect(
        await model.setMangaReadingStatus(manga, MangaReadingStatus.remove),
        isTrue,
      );
      expect(
        await model.setChaptersRead(manga, read: [read], unread: [unread]),
        isTrue,
      );

      expect(transport.requests[0].data, {'status': null});
      expect(transport.requests[1].uri.path, '/manga/${manga.id}/read');
      expect(transport.requests[1].data, {
        'chapterIdsRead': [read.id],
        'chapterIdsUnread': [unread.id],
      });
    });

    test('records PUT body and completes the cache write', () async {
      final original = _customList('list-1', name: 'Original');
      final edited = original.copyWith(
        attributes: original.attributes.copyWith(
          name: 'Edited',
          visibility: CustomListVisibility.public,
          version: 2,
        ),
      );
      transport.enqueue(
        statusCode: 200,
        data: {'result': 'ok', 'data': edited.toJson()},
      );

      expect(
        await model.editList(
          original,
          'Edited',
          CustomListVisibility.public,
          const ['manga-1'],
        ),
        edited,
      );

      final request = transport.requests.single;
      expect(request.method, _HttpMethod.put);
      expect(request.uri.path, '/list/${original.id}');
      expect(request.data, {
        'name': 'Edited',
        'visibility': CustomListVisibility.public.name,
        'manga': ['manga-1'],
        'version': original.attributes.version,
      });
      expect(cache.values[edited.id], edited);
    });

    test('creates a list with an explicit payload and caches it', () async {
      final created = _customList('list-1', name: 'Created');
      transport.enqueue(
        statusCode: 201,
        data: {'result': 'ok', 'data': created.toJson()},
      );

      expect(
        await model.createNewList(
          'Created',
          CustomListVisibility.private,
          const ['manga-1'],
        ),
        created,
      );

      final request = transport.requests.single;
      expect(request.method, _HttpMethod.post);
      expect(request.uri.path, MangaDexEndpoints.createList);
      expect(request.data, {
        'name': 'Created',
        'visibility': CustomListVisibility.private.name,
        'manga': ['manga-1'],
      });
      expect(cache.values[created.id], created);
    });

    test('custom-list CRUD throws structured API errors', () async {
      transport.enqueue(
        statusCode: 400,
        data: {
          'result': 'error',
          'errors': [
            {'id': 'error-1', 'status': 400, 'title': 'Invalid list'},
          ],
        },
      );

      await expectLater(
        model.createNewList('Invalid', CustomListVisibility.private, const []),
        throwsA(isA<MangaDexException>()),
      );
    });

    test('list membership projects and caches add/remove results', () async {
      final manga = Manga(id: 'manga-1');
      final original = _customList('list-1', name: 'List');
      transport
        ..enqueue(statusCode: 200, data: {'result': 'ok'})
        ..enqueue(statusCode: 200, data: {'result': 'ok'});

      final added = await model.updateMangaInCustomList(original, manga, true);
      final removed = await model.updateMangaInCustomList(added!, manga, false);

      expect(
        added.relationships.map((entity) => entity.id),
        contains(manga.id),
      );
      expect(
        removed!.relationships.map((entity) => entity.id),
        isNot(contains(manga.id)),
      );
      expect(added.attributes.version, original.attributes.version);
      expect(removed.attributes.version, original.attributes.version);
      expect(cache.values[original.id], removed);
      expect(transport.requests[0].method, _HttpMethod.post);
      expect(
        transport.requests[0].uri.path,
        '/manga/${manga.id}/list/${original.id}',
      );
      expect(transport.requests[1].method, _HttpMethod.delete);
    });

    test('authentication can be denied without issuing a request', () async {
      final unauthenticated = container.read(
        Provider(
          (ref) => MangaDexModel(
            ref,
            transport: transport,
            cache: cache,
            authenticationCheck: () async => false,
          ),
        ),
      );

      await expectLater(
        unauthenticated.getMangaFollowing(Manga(id: 'manga-1')),
        throwsStateError,
      );
      expect(transport.requests, isEmpty);
    });

    test('transport errors are deterministic and remain local', () async {
      final error = StateError('local transport failure');
      transport.enqueueError(error);

      await expectLater(
        model.getMangaFollowing(Manga(id: 'manga-1')),
        throwsA(same(error)),
      );
      expect(transport.requests, hasLength(1));
    });

    test('shared executor returns and caches a successful GET', () async {
      final entity = Manga(id: 'manga-1');
      transport.enqueue(
        statusCode: 200,
        data: _emptyEntityListData(entities: [entity]),
      );

      final result = await model.getTagList();

      expect(result.data, [entity]);
      expect(cache.values[MangaDexFeeds.tags.key], result);
      expect(cache.values, isNot(contains(entity.id)));
      expect(cache.expiries[MangaDexFeeds.tags.key], const Duration(days: 1));
      final request = transport.requests.single;
      expect(request.method, _HttpMethod.get);
      expect(request.uri.path, MangaDexEndpoints.tag);
    });

    test(
      'uncached entity-list GET resolves entities without a list key',
      () async {
        final manga = Manga(id: 'manga-1');
        transport.enqueue(
          statusCode: 200,
          data: _emptyEntityListData(entities: [manga]),
        );

        final result = await model.searchManga(
          'needle',
          limit: 12,
          filter: const MangaFilters(),
          offset: 4,
        );

        expect(result.data, [manga]);
        expect(cache.values[manga.id], manga);
        expect(cache.values, hasLength(1));
        final request = transport.requests.single;
        expect(request.method, _HttpMethod.get);
        expect(request.uri.path, MangaDexEndpoints.manga);
        expect(request.uri.queryParameters['title'], 'needle');
        expect(request.uri.queryParameters['limit'], '12');
        expect(request.uri.queryParameters['offset'], '4');
      },
    );

    test(
      'authenticated entity-list GET preserves query and resolution',
      () async {
        final list = _customList('list-1', name: 'List');
        transport.enqueue(
          statusCode: 200,
          data: _emptyEntityListData(entities: [list]),
        );

        final result = await model.fetchUserList(
          feed: MangaDexFeeds.userLists,
          offset: 100,
        );

        expect(result, [list]);
        expect(cache.values[list.id], list);
        final request = transport.requests.single;
        expect(request.method, _HttpMethod.get);
        expect(request.uri.path, MangaDexEndpoints.userList);
        expect(request.uri.queryParameters, {'limit': '100', 'offset': '100'});
      },
    );

    test('authenticated entity-list GET is guarded before transport', () async {
      final unauthenticated = container.read(
        Provider(
          (ref) => MangaDexModel(
            ref,
            transport: transport,
            cache: cache,
            authenticationCheck: () async => false,
          ),
        ),
      );

      await expectLater(
        unauthenticated.fetchUserList(feed: MangaDexFeeds.userLists),
        throwsStateError,
      );
      expect(transport.requests, isEmpty);
    });

    test(
      'equivalent manga feed requests share a canonical cache key',
      () async {
        transport.enqueue(statusCode: 200, data: _emptyEntityListData());

        final first = await model.fetchMangaList(
          limit: 10,
          feedKey: 'CanonicalMangaFeed',
          extraParams: {
            'originalLanguage[]': ['ja', 'en'],
            'hasAvailableChapters': 'true',
          },
        );
        final second = await model.fetchMangaList(
          limit: 10,
          feedKey: 'CanonicalMangaFeed',
          extraParams: {
            'hasAvailableChapters': 'true',
            'originalLanguage[]': ['en', 'ja'],
          },
        );

        expect(second, same(first));
        expect(transport.requests, hasLength(1));
        final keys = cache.values.keys
            .where((key) => key.startsWith('CanonicalMangaFeed:v2:'))
            .toList();
        expect(keys, hasLength(1));
        expect(keys.single.length, lessThanOrEqualTo(255));
      },
    );

    test('effective request changes produce different cache keys', () async {
      for (var i = 0; i < 4; i++) {
        transport.enqueue(statusCode: 200, data: _emptyEntityListData());
      }

      await model.fetchMangaList(limit: 10, feedKey: 'DistinctMangaFeed');
      await model.fetchMangaList(limit: 20, feedKey: 'DistinctMangaFeed');
      await model.fetchMangaList(
        limit: 10,
        feedKey: 'DistinctMangaFeed',
        offset: 10,
      );
      await model.fetchMangaList(
        limit: 10,
        feedKey: 'DistinctMangaFeed',
        extraParams: const {'hasAvailableChapters': 'true'},
      );

      expect(transport.requests, hasLength(4));
      expect(
        cache.values.keys
            .where((key) => key.startsWith('DistinctMangaFeed:v2:'))
            .toSet(),
        hasLength(4),
      );
    });

    test(
      'chapter feed path and original-language policy affect keys',
      () async {
        for (var i = 0; i < 3; i++) {
          transport.enqueue(statusCode: 200, data: _emptyEntityListData());
        }

        await model.fetchChapterFeed(
          path: MangaDexEndpoints.chapter,
          feedKey: 'DistinctChapterFeed',
          limit: 10,
        );
        await model.fetchChapterFeed(
          path: MangaDexEndpoints.chapter,
          feedKey: 'DistinctChapterFeed',
          limit: 10,
          ignoreOriginalLanguage: true,
        );
        await model.fetchChapterFeed(
          path: '/manga/manga-1/feed',
          feedKey: 'DistinctChapterFeed',
          limit: 10,
        );

        expect(transport.requests, hasLength(3));
        expect(
          cache.values.keys
              .where((key) => key.startsWith('DistinctChapterFeed:v2:'))
              .toSet(),
          hasLength(3),
        );
      },
    );

    test('MangaDex settings changes produce different feed keys', () async {
      transport
        ..enqueue(statusCode: 200, data: _emptyEntityListData())
        ..enqueue(statusCode: 200, data: _emptyEntityListData());

      await model.fetchChapterFeed(
        path: MangaDexEndpoints.chapter,
        feedKey: 'SettingsChapterFeed',
        limit: 10,
      );

      final alternateContainer = ProviderContainer(
        overrides: [
          mdConfigProvider.overrideWithValue(
            MangaDexConfig(
              translatedLanguages: {Language.fr},
              originalLanguage: {Language.ko},
              contentRating: {ContentRating.suggestive},
              groupBlacklist: {'another-blocked-group'},
            ),
          ),
        ],
      );
      addTearDown(alternateContainer.dispose);
      final alternateModel = alternateContainer.read(
        Provider(
          (ref) => MangaDexModel(
            ref,
            transport: transport,
            cache: cache,
            authenticationCheck: () async => true,
          ),
        ),
      );

      await alternateModel.fetchChapterFeed(
        path: MangaDexEndpoints.chapter,
        feedKey: 'SettingsChapterFeed',
        limit: 10,
      );

      expect(transport.requests, hasLength(2));
      expect(
        cache.values.keys
            .where((key) => key.startsWith('SettingsChapterFeed:v2:'))
            .toSet(),
        hasLength(2),
      );
    });

    test('feed namespace invalidation clears every cached page', () async {
      final manga = Manga(id: 'manga-1');
      transport
        ..enqueue(statusCode: 200, data: _emptyEntityListData())
        ..enqueue(statusCode: 200, data: _emptyEntityListData());

      await model.fetchChapterFeed(
        path: '/manga/${manga.id}/feed',
        feedKey: 'PagedChapterFeed',
        limit: 10,
        entity: manga,
      );
      await model.fetchChapterFeed(
        path: '/manga/${manga.id}/feed',
        feedKey: 'PagedChapterFeed',
        limit: 10,
        offset: 10,
        entity: manga,
      );
      cache.values['OtherFeed:v2:keep'] = 'keep';

      final prefix = 'PagedChapterFeed(${manga.id}';
      expect(
        cache.values.keys.where((key) => key.startsWith(prefix)),
        hasLength(2),
      );

      await model.invalidateAll(prefix);

      expect(cache.values.keys.where((key) => key.startsWith(prefix)), isEmpty);
      expect(cache.values['OtherFeed:v2:keep'], 'keep');
    });

    test('shared executor parses MangaDex error responses', () async {
      transport.enqueue(
        statusCode: 400,
        statusMessage: 'Bad Request',
        data: {
          'result': 'error',
          'errors': [
            {
              'id': 'error-1',
              'status': 400,
              'title': 'Invalid request',
              'detail': 'The request was invalid.',
            },
          ],
        },
      );

      await expectLater(
        model.getTagList(),
        throwsA(
          isA<MangaDexException>()
              .having(
                (error) => error.message,
                'message',
                'getTagList() failed.',
              )
              .having(
                (error) => error.errors?.single.status,
                'API error status',
                400,
              ),
        ),
      );
    });

    test(
      'shared executor falls back safely for malformed error bodies',
      () async {
        transport
          ..enqueue(statusCode: 400, statusMessage: 'Bad Request', data: null)
          ..enqueue(
            statusCode: 418,
            statusMessage: "I'm a teapot",
            data: '<html>not a MangaDex error</html>',
          );

        await expectLater(
          model.getTagList(),
          throwsA(
            isA<ApiException>()
                .having((error) => error.statusCode, 'status code', 400)
                .having(
                  (error) => error.statusMessage,
                  'status message',
                  'Bad Request',
                ),
          ),
        );
        await expectLater(
          model.getTagList(),
          throwsA(
            isA<ApiException>()
                .having(
                  (error) => error.message,
                  'message',
                  'getTagList() failed.',
                )
                .having((error) => error.statusCode, 'status code', 418)
                .having(
                  (error) => error.statusMessage,
                  'status message',
                  "I'm a teapot",
                ),
          ),
        );
      },
    );

    test('shared executor handles maintenance and null statuses', () async {
      transport
        ..enqueue(statusCode: 503, data: null)
        ..enqueue(statusCode: null, data: null);

      await expectLater(
        model.getTagList(),
        throwsA(
          isA<ApiException>()
              .having(
                (error) => error.message,
                'message',
                'MangaDex is down for maintenance',
              )
              .having((error) => error.statusCode, 'status code', 503),
        ),
      );
      await expectLater(
        model.getTagList(),
        throwsA(
          isA<ApiException>()
              .having(
                (error) => error.message,
                'message',
                'getTagList() failed.',
              )
              .having((error) => error.statusCode, 'status code', isNull),
        ),
      );
    });

    test('shared executor attributes malformed success responses', () async {
      transport.enqueue(statusCode: 200, data: {'result': 'ok'});

      await expectLater(
        model.getTagList(),
        throwsA(
          isA<ApiException>()
              .having(
                (error) => error.message,
                'message',
                contains('getTagList() failed to parse successful response'),
              )
              .having((error) => error.statusCode, 'status code', 200),
        ),
      );
    });

    test('shared executor handles an authenticated mutation', () async {
      final list = _customList('list-1', name: 'Delete me');
      cache.values[list.id] = list;
      transport.enqueue(statusCode: 200, data: {'result': 'ok'});

      expect(await model.deleteList(list), isTrue);
      expect(cache.values, isNot(contains(list.id)));

      final request = transport.requests.single;
      expect(request.method, _HttpMethod.delete);
      expect(request.uri.path, '/list/${list.id}');
      expect(request.data, isNull);
    });

    test('custom-list cache writes and removals are awaited', () async {
      final created = _customList('list-1', name: 'Created');
      final putGate = Completer<void>();
      cache.putGate = putGate;
      transport.enqueue(
        statusCode: 200,
        data: {'result': 'ok', 'data': created.toJson()},
      );

      var createCompleted = false;
      final create = model
          .createNewList('Created', CustomListVisibility.private, const [])
          .whenComplete(() => createCompleted = true);
      await Future<void>.delayed(Duration.zero);
      expect(createCompleted, isFalse);
      putGate.complete();
      expect(await create, created);

      final removeGate = Completer<void>();
      cache.removeGate = removeGate;
      transport.enqueue(statusCode: 200, data: {'result': 'ok'});

      var deleteCompleted = false;
      final delete = model
          .deleteList(created)
          .whenComplete(() => deleteCompleted = true);
      await Future<void>.delayed(Duration.zero);
      expect(deleteCompleted, isFalse);
      removeGate.complete();
      expect(await delete, isTrue);
    });

    test('shared executor enforces mutation authentication', () async {
      final unauthenticated = container.read(
        Provider(
          (ref) => MangaDexModel(
            ref,
            transport: transport,
            cache: cache,
            authenticationCheck: () async => false,
          ),
        ),
      );

      await expectLater(
        unauthenticated.deleteList(_customList('list-1', name: 'Keep me')),
        throwsStateError,
      );
      expect(transport.requests, isEmpty);
    });

    test('production construction retains its Dio stack', () {
      final production = container.read(
        Provider(
          (ref) => MangaDexModel(
            ref,
            cache: cache,
            tokenStorage: _MemoryTokenStorage(),
          ),
        ),
      );
      final dio = production.debugProductionDio;

      expect(dio, isNotNull);
      expect(dio!.httpClientAdapter, isA<NativeAdapter>());
      expect(
        dio.interceptors.whereType<RateLimitingInterceptor>(),
        hasLength(1),
      );
      expect(dio.interceptors.whereType<Fresh<OIDAuthToken>>(), hasLength(1));
    });
  });
}

enum _HttpMethod { get, post, put, delete }

class _RecordedRequest {
  const _RecordedRequest(this.method, this.uri, this.data);

  final _HttpMethod method;
  final Uri uri;
  final Object? data;
}

class _QueuedResponse {
  const _QueuedResponse.response({
    required this.statusCode,
    required this.data,
    this.statusMessage,
  }) : error = null;

  const _QueuedResponse.error(this.error)
    : statusCode = null,
      statusMessage = null,
      data = null;

  final int? statusCode;
  final String? statusMessage;
  final dynamic data;
  final Object? error;
}

class _RecordingTransport implements MangaDexTransport {
  final Queue<_QueuedResponse> _responses = Queue();
  final List<_RecordedRequest> requests = [];

  void enqueue({
    required int? statusCode,
    required dynamic data,
    String? statusMessage,
  }) {
    _responses.add(
      _QueuedResponse.response(
        statusCode: statusCode,
        statusMessage: statusMessage,
        data: data,
      ),
    );
  }

  void enqueueError(Object error) {
    _responses.add(_QueuedResponse.error(error));
  }

  Future<Response<dynamic>> _send(
    _HttpMethod method,
    Uri uri,
    Object? data,
  ) async {
    requests.add(_RecordedRequest(method, uri, data));
    if (_responses.isEmpty) {
      throw StateError('No local response queued for $method $uri');
    }

    final response = _responses.removeFirst();
    final error = response.error;
    if (error != null) {
      throw error;
    }

    return Response<dynamic>(
      requestOptions: RequestOptions(path: uri.toString()),
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  @override
  Future<Response<dynamic>> getUri(Uri uri) =>
      _send(_HttpMethod.get, uri, null);

  @override
  Future<Response<dynamic>> postUri(Uri uri, {Object? data}) =>
      _send(_HttpMethod.post, uri, data);

  @override
  Future<Response<dynamic>> putUri(Uri uri, {Object? data}) =>
      _send(_HttpMethod.put, uri, data);

  @override
  Future<Response<dynamic>> deleteUri(Uri uri, {Object? data}) =>
      _send(_HttpMethod.delete, uri, data);
}

class _MemoryCacheManager implements CacheManager {
  final Map<String, Object?> values = {};
  final Map<String, Duration> expiries = {};
  Completer<void>? putGate;
  Completer<void>? removeGate;

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
    await putGate?.future;
    putGate = null;
    values[key] = reference;
    expiries[key] = expiry;
    return reference;
  }

  @override
  Future<void> remove(String key) async {
    await removeGate?.future;
    removeGate = null;
    values.remove(key);
  }

  @override
  Future<void> invalidateAll(String startsWith) async {
    values.removeWhere((key, _) => key.startsWith(startsWith));
  }

  @override
  Future<void> putAll(Map<String, CacheEntry> map) async {
    for (final MapEntry(:key, :value) in map.entries) {
      values[key] = value.get();
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MemoryTokenStorage implements TokenStorage<OIDAuthToken> {
  OIDAuthToken? token;

  @override
  Future<void> delete() async {
    token = null;
  }

  @override
  Future<OIDAuthToken?> read() async => token;

  @override
  Future<void> write(OIDAuthToken token) async {
    this.token = token;
  }
}

CustomList _customList(String id, {required String name}) => CustomList(
  id: id,
  attributes: CustomListAttributes(
    name: name,
    visibility: CustomListVisibility.private,
    version: 1,
  ),
  relationships: const [],
);

Chapter _chapter(String id) {
  final now = DateTime.utc(2026);
  return Chapter(
    id: id,
    attributes: ChapterAttributes(
      translatedLanguage: Language.en,
      version: 1,
      createdAt: now,
      updatedAt: now,
      publishAt: now,
    ),
    relationships: const [],
  );
}

Map<String, dynamic> _emptyEntityListData({
  List<MangaDexEntity> entities = const [],
}) => {
  'result': 'ok',
  'response': 'collection',
  'data': entities.map((entity) => entity.toJson()).toList(),
  'limit': 10,
  'offset': 0,
  'total': entities.length,
};
