import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:gagaku/log.dart';
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
      container = ProviderContainer();
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
      transport.enqueue(
        statusCode: 200,
        data: {
          'result': 'ok',
          'response': 'collection',
          'data': <dynamic>[],
          'limit': 100,
          'offset': 0,
          'total': 0,
        },
      );

      final result = await model.getTagList();

      expect(result.data, isEmpty);
      expect(cache.values[MangaDexFeeds.tags.key], result);
      final request = transport.requests.single;
      expect(request.method, _HttpMethod.get);
      expect(request.uri.path, MangaDexEndpoints.tag);
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
