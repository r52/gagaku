import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:async/async.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:gagaku/util/authentication.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/util/http.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/mangadex/model/cache.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/util/util.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'package:objectbox/objectbox.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'model.g.dart';
part 'auth_state.dart';
part 'batch_cache.dart';
part 'chapter_state.dart';
part 'custom_list_state.dart';
part 'history_state.dart';
part 'library_state.dart';
part 'reference_state.dart';
part 'statistics_state.dart';

abstract class MangaDexEndpoints {
  static final api = Uri.https('api.mangadex.org', '');

  static const breakLimit = 50;
  static const searchLimit = 32;
  static const chapterLimit = 100;

  // OAuth provider
  static final provider = Uri.parse(
    'https://auth.mangadex.org/realms/mangadex',
  );

  /// App Client ID
  /// TODO change this when public clients become available
  static const clientId = 'thirdparty-oauth-client';

  /// User chapter feed. Returns [Chapter]s
  static const feed = '/user/follows/manga/feed';

  /// Manga data. Returns [Manga]
  static const manga = '/manga';

  /// Chapter data. Returns [Chapter]
  static const chapter = '/chapter';

  /// Manga read markers. Returns chapter ids
  static const getRead = '/manga/read';

  /// Mark chapters read/unread. {id} = [Manga.id]
  static const setRead = '/manga/{id}/read';

  /// Get server URL. {id} = [Chapter.id]
  static const server = '/at-home/server/{id}';

  /// Manga chapter feed. Returns [Chapter]s. {id} = [Chapter.id]
  static const mangaFeed = '/manga/{id}/feed';

  /// Check if logged User follows a Manga. {id} = [Manga.id]
  static const follows = '/user/follows/manga/{id}';

  /// Set user manga follow. {id} = [Manga.id]
  static const setFollow = '/manga/{id}/follow';

  /// User manga reading status. {id} = [Manga.id]
  static const status = '/manga/{id}/status';

  /// Get all Manga reading status for logged User
  static const library = '/manga/status';

  /// Gets the universal tag list
  static const tag = '/manga/tag';

  /// Gets statistics for given manga
  static const statistics = '/statistics/manga';

  /// Gets statistics for given chapter
  static const chapterStats = '/statistics/chapter';

  /// Gets self-ratings for given mangas
  static const getRating = '/rating';

  /// Sets self-ratings for given manga
  static const setRating = '/rating/{id}';

  /// Gets cover art
  static const cover = '/cover';

  /// Gets scanlation group info
  static const group = '/group';

  /// Gets author/creator info
  static const creator = '/author';

  /// Gets logged user [CustomList] list
  static const userList = '/user/list';

  /// Adds/removes manga to/from CustomList
  static const updateMangaInList = '/manga/{id}/list/{listId}';

  /// Create list
  static const createList = '/list';

  /// Get/update/delete CustomList
  static const modifyList = '/list/{id}';

  /// [CustomList] manga feed
  static const listFeed = '/list/{id}/feed';

  /// Get logged User followed [CustomList] list
  static const followedList = '/user/follows/list';

  /// Follow/unfollow CustomList
  static const followList = '/list/{id}/follow';

  /// Logged in user details
  static const me = '/user/me';
}

class FeedInfo {
  const FeedInfo(this.key, this.limit, this.path);

  final String key;
  final int limit;
  final String? path;
}

abstract interface class MangaDexTransport {
  Future<Response<dynamic>> getUri(Uri uri);

  Future<Response<dynamic>> postUri(Uri uri, {Object? data});

  Future<Response<dynamic>> putUri(Uri uri, {Object? data});

  Future<Response<dynamic>> deleteUri(Uri uri, {Object? data});
}

enum _MangaDexRequestMethod { get, post, put, delete }

class _DioMangaDexTransport implements MangaDexTransport {
  const _DioMangaDexTransport(this.dio);

  final Dio dio;

  @override
  Future<Response<dynamic>> getUri(Uri uri) => dio.getUri(uri);

  @override
  Future<Response<dynamic>> postUri(Uri uri, {Object? data}) =>
      dio.postUri(uri, data: data);

  @override
  Future<Response<dynamic>> putUri(Uri uri, {Object? data}) =>
      dio.putUri(uri, data: data);

  @override
  Future<Response<dynamic>> deleteUri(Uri uri, {Object? data}) =>
      dio.deleteUri(uri, data: data);
}

abstract class MangaDexFeeds {
  static const recentlyAdded = FeedInfo(
    'RecentlyAdded',
    MangaDexEndpoints.searchLimit,
    null,
  );
  static const popularTitles = FeedInfo('PopularTitles', 15, null);
  static const latestChapters = FeedInfo(
    'LatestChaptersFeed',
    MangaDexEndpoints.searchLimit,
    MangaDexEndpoints.feed,
  );
  static const globalFeed = FeedInfo(
    'LatestGlobalFeed',
    MangaDexEndpoints.searchLimit,
    MangaDexEndpoints.chapter,
  );
  static const creatorTitles = FeedInfo(
    'CreatorTitles',
    MangaDexEndpoints.searchLimit,
    null,
  );
  static const groupTitles = FeedInfo(
    'GroupTitles',
    MangaDexEndpoints.searchLimit,
    null,
  );
  static const groupFeed = FeedInfo(
    'GroupFeed',
    MangaDexEndpoints.searchLimit,
    MangaDexEndpoints.chapter,
  );
  static const customListFeed = FeedInfo(
    'CustomListFeed',
    MangaDexEndpoints.searchLimit,
    MangaDexEndpoints.listFeed,
  );
  static const mangaCovers = FeedInfo(
    'CoverList',
    MangaDexEndpoints.searchLimit,
    MangaDexEndpoints.cover,
  );
  static const mangaChapters = FeedInfo(
    'MangaChapters',
    MangaDexEndpoints.chapterLimit,
    MangaDexEndpoints.mangaFeed,
  );
  static const userLists = FeedInfo(
    'UserLists',
    100,
    MangaDexEndpoints.userList,
  );
  static const followedLists = FeedInfo(
    'FollowedLists',
    100,
    MangaDexEndpoints.followedList,
  );
  static const search = FeedInfo(
    'SearchManga',
    MangaDexEndpoints.searchLimit,
    MangaDexEndpoints.manga,
  );
  static const library = FeedInfo('UserLibrary', -1, MangaDexEndpoints.library);
  static const tags = FeedInfo('Tags', -1, MangaDexEndpoints.tag);
}

extension TokenHelper on TokenResponse {
  bool get isValid => accessToken != null && refreshToken != null;
}

class MangaDexTokenStorage implements TokenStorage<OIDAuthToken> {
  @override
  Future<void> delete() async {
    final storage = Hive.box(gagakuLocalBox);
    await storage.delete('mangadex_tokens');
  }

  @override
  Future<OIDAuthToken?> read() async {
    final storage = Hive.box(gagakuLocalBox);

    final tokenstr = storage.get('mangadex_tokens');
    final token = tokenstr != null
        ? MangaDexTokens.fromJson(json.decode(tokenstr))
        : null;

    if (token != null && token.accessToken != null) {
      return OIDAuthToken(
        accessToken: token.accessToken!,
        refreshToken: token.refreshToken,
        idToken: token.idToken,
      );
    }

    return null;
  }

  @override
  Future<void> write(OIDAuthToken token) async {
    final storage = Hive.box(gagakuLocalBox);

    final mtoken = MangaDexTokens.fromOIDAuthToken(token);
    await storage.put('mangadex_tokens', json.encode(mtoken.toJson()));
  }
}

@Riverpod(keepAlive: true)
MangaDexModel mangadex(Ref ref) {
  return MangaDexModel(ref);
}

class MangaDexModel {
  MangaDexModel(
    this.ref, {
    MangaDexTransport? transport,
    MangaDexTransport? externalTransport,
    CacheManager? cache,
    Future<bool> Function()? authenticationCheck,
    TokenStorage<OIDAuthToken>? tokenStorage,
  }) : _cache = cache ?? ref.read(cacheProvider),
       _authenticationCheck = authenticationCheck {
    if (transport != null) {
      _transport = transport;
    } else {
      final dio =
          Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 5),
                receiveTimeout: const Duration(seconds: 5),
                validateStatus: (status) => true,
              ),
            )
            ..httpClientAdapter = NativeAdapter(
              createCronetEngine: () => createCronetEngine(getUserAgent(true)),
            )
            ..interceptors.add(RateLimitingInterceptor());

      _fresh = Fresh.oAuth2<OIDAuthToken>(
        httpClient: dio.clone(),
        tokenStorage: tokenStorage ?? MangaDexTokenStorage(),
        refreshToken: (token, httpClient) => refreshToken(token),
        shouldRefreshBeforeRequest: (requestOptions, token) {
          if (token == null) {
            return false;
          }

          final expiresAt = token.expiresAt;
          if (expiresAt == null) {
            // Freshly read tokens needs to be refreshed
            return true;
          }

          return expiresAt.difference(DateTime.now()).inSeconds < 30;
        },
      );

      dio.interceptors.add(_fresh!);
      _transport = _DioMangaDexTransport(dio);
    }

    _externalTransport =
        externalTransport ?? transport ?? _DioMangaDexTransport(Dio());
  }

  final Ref ref;
  final CacheManager _cache;
  final Future<bool> Function()? _authenticationCheck;

  late final MangaDexTransport _transport;
  late final MangaDexTransport _externalTransport;

  OIDAuthToken? _token;
  Credential? _credential;

  Fresh<OIDAuthToken>? _fresh;

  @visibleForTesting
  Dio? get debugProductionDio => switch (_transport) {
    _DioMangaDexTransport(:final dio) => dio,
    _ => null,
  };

  // void _urlLauncher(String url) async {
  //   var uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri) || Platform.isAndroid) {
  //     await launchUrl(uri);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  Stream<AuthenticationStatus> get authenticationStatus {
    final fresh = _fresh;
    if (fresh != null) {
      return fresh.authenticationStatus;
    }

    final authenticationCheck = _authenticationCheck;
    if (authenticationCheck != null) {
      return Stream.fromFuture(authenticationCheck()).map(
        (authenticated) => authenticated
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated,
      );
    }

    throw StateError(
      'An authentication check is required with an injected transport.',
    );
  }

  Future<bool> loggedIn() async {
    final authenticationCheck = _authenticationCheck;
    if (authenticationCheck != null) {
      return authenticationCheck();
    }

    final status = await authenticationStatus.firstWhere(
      (status) => status != AuthenticationStatus.initial,
    );
    return status == AuthenticationStatus.authenticated;
  }

  Future<OIDAuthToken> refreshToken(OIDAuthToken? token) async {
    // Clear old data
    _token = null;

    final storage = Hive.box(gagakuLocalBox);

    if (token != null) {
      final tt = token.tokenType;
      final rt = token.refreshToken;
      final it = token.idToken;

      final creds = MangaDexCredentials.fromJson(
        json.decode(storage.get('mangadex_credentials')),
      );
      final clientId = creds.clientId;
      final clientSecret = creds.clientSecret;

      final issuer =
          _credential?.client.issuer ??
          await Issuer.discover(MangaDexEndpoints.provider);
      final client =
          _credential?.client ??
          Client(issuer, clientId, clientSecret: clientSecret);

      final credential =
          _credential ??
          client.createCredential(
            accessToken: null, // force use refresh to get new token
            tokenType: tt,
            refreshToken: rt,
            idToken: it,
          );

      try {
        credential.validateToken(validateClaims: true, validateExpiry: true);
        final tokenresp = await credential.getTokenResponse();
        if (tokenresp.isValid) {
          _token = OIDAuthToken.fromTokenResponse(tokenresp);

          _credential = credential;
          logger.i("refreshToken(): MangaDex token refreshed");
          return _token!;
        }

        // If any steps fail, assign a default client
        logger.w(
          "refreshToken() returned error ${tokenresp['error']}",
          error: tokenresp.toString(),
        );
      } catch (e) {
        logger.w("refreshToken() error ${e.toString()}", error: e);
      }
    }

    throw RevokeTokenException();
  }

  Future<bool> authenticate(
    String user,
    String pass,
    String clientId,
    String clientSecret,
  ) async {
    final issuer = await Issuer.discover(MangaDexEndpoints.provider);

    final client = Client(issuer, clientId, clientSecret: clientSecret);

    final flow = Flow.password(client);

    final credential = await flow.loginWithPassword(
      username: user,
      password: pass,
    );

    final token = await credential.getTokenResponse();

    if (token.isValid) {
      await _saveCredentials(user, clientId, clientSecret);
      _token = OIDAuthToken.fromTokenResponse(token);
      await _fresh!.setToken(_token);
      _credential = credential;

      logger.i("authenticate(): MangaDex user logged in");
      return true;
    }

    logger.w(
      "authenticate() returned error ${token['error']}",
      error: token.toString(),
    );

    throw Exception(token['error']);
  }

  Future<void> _saveCredentials(
    String username,
    String clientId,
    String clientSecret,
  ) async {
    final storage = Hive.box(gagakuLocalBox);

    final creds = MangaDexCredentials(
      username: username,
      clientId: clientId,
      clientSecret: clientSecret,
    );

    await storage.put('mangadex_credentials', json.encode(creds.toJson()));
  }

  Future<void> logout() async {
    if (await loggedIn() && _credential != null) {
      final logoutUrl = _credential!.generateLogoutUrl();
      if (logoutUrl != null) {
        final response = await http.post(logoutUrl);

        if (response.statusCode == 200) {
          _token = null;
          await _fresh!.setToken(null);
          _credential = null;

          logger.i("logout(): MangaDex user logged out");
          return;
        }

        logger.w(
          "logout() returned code ${response.statusCode}",
          error: response.body,
        );
      }
    }
  }

  /// Invalidates a cache item so that it can be refreshed from the API
  ///
  /// [item] - key of the item to be invalidated
  Future<void> invalidateCacheItem(String item) async {
    logger.d("Invalidating cache item: $item");
    await _cache.remove(item);
  }

  Future<void> invalidateAll(String startsWith) async {
    await _cache.invalidateAll(startsWith);
  }

  Exception createException(String msg, Response response) {
    if (response.statusCode == 503) {
      msg = 'MangaDex is down for maintenance';
    }

    final message =
        "$msg\nServer returned ${response.statusCode}: ${response.statusMessage}";
    final details = _describeResponseData(response.data);

    if (response.statusCode == null || response.statusCode! >= 500) {
      final exception = ApiException(
        message: msg,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
      logger.e('$message\nResponse: $details', error: exception);
      return exception;
    }

    try {
      final data = Map<String, dynamic>.from(response.data as Map);
      final error = ErrorResponse.fromJson(data);
      if (error.errors.isNotEmpty) {
        final exception = MangaDexException(msg, error.errors);
        logger.e('$message\nResponse: $details', error: exception);
        return exception;
      }
    } catch (_) {
      // Non-MangaDex and malformed response bodies fall through to the safe
      // generic API exception below.
    }

    final exception = ApiException(
      message: msg,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
    logger.e('$message\nResponse: $details', error: exception);
    return exception;
  }

  String _describeResponseData(Object? data) {
    try {
      final description = data is String ? data : json.encode(data);
      const maxLength = 500;
      return description.length <= maxLength
          ? description
          : '${description.substring(0, maxLength)}…';
    } catch (_) {
      try {
        return data.toString();
      } catch (_) {
        return '<unprintable response>';
      }
    }
  }

  bool _hasOkResult(Response<dynamic> response) {
    final body = response.data;
    return body is Map && body['result'] == 'ok';
  }

  bool _logRejectedMutation(String operation, Response<dynamic> response) {
    logger.w(
      '$operation returned code ${response.statusCode}',
      error: response.data,
    );
    return false;
  }

  String _requestCacheKey({required String namespace, required Uri uri}) {
    final queryParameters = SplayTreeMap<String, List<String>>();
    for (final MapEntry(:key, value: values)
        in uri.queryParametersAll.entries) {
      queryParameters[key] = [...values]..sort();
    }

    final canonicalUri = uri.replace(queryParameters: queryParameters);
    final digest = sha256.convert(utf8.encode(canonicalUri.toString()));
    return '$namespace:v2:$digest';
  }

  String _feedCacheNamespace(String feedKey, [MangaDexUUID? entity]) =>
      entity == null ? feedKey : '$feedKey(${entity.id})';

  Future<MDEntityList> _getEntityList({
    required Uri uri,
    required String operation,
    required bool authenticated,
    required String? cacheKey,
    required bool resolveEntities,
    required Duration expiry,
  }) async {
    if (cacheKey != null && await _cache.exists(cacheKey)) {
      return _cache.getEntityList(cacheKey);
    }

    final result = await _request(
      method: _MangaDexRequestMethod.get,
      uri: uri,
      authenticated: authenticated,
      operation: operation,
      parse: (response) => MDEntityList.fromJson(response.data),
    );

    if (cacheKey != null) {
      await _cache.putEntityList(
        cacheKey,
        result,
        resolve: resolveEntities,
        expiry: expiry,
      );
    } else if (resolveEntities) {
      await _cache.putAllAPIResolved(result.data, expiry);
    }

    return result;
  }

  Future<T> _request<T>({
    required _MangaDexRequestMethod method,
    required Uri uri,
    Object? data,
    bool authenticated = false,
    Set<int> acceptedStatusCodes = const {200},
    required String operation,
    required FutureOr<T> Function(Response<dynamic>) parse,
    FutureOr<T> Function(Response<dynamic>)? onRejectedResponse,
  }) async {
    if (authenticated && !await loggedIn()) {
      throw StateError(
        "$operation called on invalid token/login. Shouldn't ever get here",
      );
    }

    final response = switch (method) {
      _MangaDexRequestMethod.get => await _transport.getUri(uri),
      _MangaDexRequestMethod.post => await _transport.postUri(uri, data: data),
      _MangaDexRequestMethod.put => await _transport.putUri(uri, data: data),
      _MangaDexRequestMethod.delete => await _transport.deleteUri(
        uri,
        data: data,
      ),
    };

    if (!acceptedStatusCodes.contains(response.statusCode)) {
      if (onRejectedResponse != null) {
        return await onRejectedResponse(response);
      }
      throw createException('$operation failed.', response);
    }

    try {
      return await parse(response);
    } catch (error, stackTrace) {
      final exception = ApiException(
        message: '$operation failed to parse successful response: $error',
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
      logger.e(
        '$operation failed while parsing a successful response.\n'
        'Response: ${_describeResponseData(response.data)}',
        error: error,
        stackTrace: stackTrace,
      );
      throw exception;
    }
  }

  /// Fetches MangaDex frontpage data
  Future<FrontPageData> fetchFrontPageData() async {
    const key = 'FrontPageData';

    if (await _cache.exists(key)) {
      return _cache.get<FrontPageData>(key, FrontPageData.fromJson);
    }

    final uri = Uri.parse(
      'https://raw.githubusercontent.com/r52/gagaku/refs/heads/data/mangadex.json',
    );
    final response = await _externalTransport.getUri(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.data);
      final result = FrontPageData.fromJson(body);

      // Cache the data
      await _cache.put(key, response.data, result);

      return result;
    }

    // Throw if failure
    throw createException("fetchFrontPageData() failed.", response);
  }

  /// Fetches a generic [Chapter] list feed based on given parameters, respecting
  /// user settings.
  ///
  /// [path]      the path to the feed on the MangaDex API
  /// [feedKey]   sets the key for caching purposes
  /// [limit]     limits number of items per query
  /// [offset]    denotes the nth item to start fetching from.
  /// [entity]    a [MangaDexEntity] entity that the feed corresponds to
  /// [order]     order scheme and direction
  ///
  /// Use specific providers that determine the feed to fetch
  Future<MDEntityList> fetchChapterFeed({
    required String path,
    required String feedKey,
    required int limit,
    int offset = 0,
    MangaDexEntity? entity,
    ChapterFilterOrder order = ChapterFilterOrder.publishAt_desc,
    bool ignoreOriginalLanguage = false,
  }) async {
    final settings = ref.read(mdConfigProvider);

    // Download missing data
    final ord = order.json;
    final queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'translatedLanguage[]': settings.translatedLanguages
          .map(const LanguageConverter().toJson)
          .toList(),
      if (!ignoreOriginalLanguage)
        'originalLanguage[]': settings.originalLanguage
            .map(const LanguageConverter().toJson)
            .toList(),
      'includeFutureUpdates': '0',
      'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
      ord.key: ord.value,
      'includes[]': ['scanlation_group', 'user'],
    };

    if (entity != null && entity is Group) {
      queryParams['groups[]'] = entity.id;
    } else if (settings.groupBlacklist.isNotEmpty) {
      queryParams['excludedGroups[]'] = settings.groupBlacklist.toList();
    }

    final uri = MangaDexEndpoints.api.replace(
      path: path,
      queryParameters: queryParams,
    );
    final key = _requestCacheKey(
      namespace: _feedCacheNamespace(feedKey, entity),
      uri: uri,
    );

    return _getEntityList(
      uri: uri,
      operation: '$feedKey()',
      authenticated: false,
      cacheKey: key,
      resolveEntities: true,
      expiry: const Duration(minutes: 15),
    );
  }

  /// Generic chunked fetch by IDs.
  ///
  /// Filters out cached IDs, chunks the remainder, fires parallel GET requests,
  /// caches results, and returns all requested entities from the cache.
  Future<List<T>> _fetchByIds<T>({
    required String endpoint,
    required Iterable<String> ids,
    required UnserializeCallback fromJson,
    required int chunkSize,
    required Map<String, dynamic> Function() buildQueryParams,
  }) async {
    // 1. Filter uncached IDs
    final uncached = (await ids.whereAsync(
      (id) async => !await _cache.exists(id),
    )).toList();

    final result = <T>[];

    if (uncached.isEmpty) {
      // All cached — just read from cache
      for (final id in ids) {
        if (await _cache.exists(id)) {
          result.add(_cache.get<T>(id, fromJson));
        }
      }
      return result;
    }

    // 2. Chunk and fire parallel requests
    final futures = <Future<void>>[];
    int start = 0, end = 0;

    while (end < uncached.length) {
      start = end;
      end += min(uncached.length - start, chunkSize);

      final chunkParams = Map<String, dynamic>.from(buildQueryParams());
      chunkParams['ids[]'] = uncached.getRange(start, end);

      final uri = MangaDexEndpoints.api.replace(
        path: endpoint,
        queryParameters: chunkParams,
      );

      futures.add(
        _transport.getUri(uri).then((response) async {
          if (response.statusCode == 200) {
            final parsed = MDEntityList.fromJson(response.data);
            await _cache.putAllAPIResolved(parsed.data);
          } else {
            throw createException(
              "$_fetchByIds() failed for $endpoint.",
              response,
            );
          }
        }),
      );
    }

    // 3. Tolerate partial failures
    final results = await Result.captureAll(futures);
    for (final result in results) {
      if (result.isError) {
        logger.w("A chunk failed to fetch", error: result.asError!.error);
      }
    }

    // 4. Re-read all original IDs from cache
    for (final id in ids) {
      if (await _cache.exists(id)) {
        result.add(_cache.get<T>(id, fromJson));
      }
    }

    return result;
  }

  /// Generic stats/ratings fetch helper.
  ///
  /// Parameters:
  /// - [endpoint]: API path (e.g. `/statistics/manga`)
  /// - [queryParamKey]: Query param key for IDs (e.g. `manga[]`)
  /// - [ids]: IDs to fetch
  /// - [fromJson]: Parser for the response body
  /// - [errorLog]: Factory for error log message
  /// - [preProcess]: Optional pre-parse check; return true to yield empty map
  Future<Map<String, T>> _fetchStats<T>({
    required String endpoint,
    required String queryParamKey,
    required Iterable<String> ids,
    required Map<String, T> Function(Map<String, dynamic>) fromJson,
    required String Function() errorLog,
    bool Function(Map<String, dynamic>)? preProcess,
  }) async {
    if (ids.isEmpty) return {};

    final queryParams = {queryParamKey: ids.toList()};

    final uri = MangaDexEndpoints.api.replace(
      path: endpoint,
      queryParameters: queryParams,
    );

    final response = await _transport.getUri(uri);

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      if (preProcess != null && preProcess(data)) return {};
      return fromJson(data);
    } else {
      throw createException(errorLog(), response);
    }
  }

  /// Fetches chapter data of the given chapter [uuids]
  Future<List<Chapter>> fetchChapters(Iterable<String> uuids) async {
    final settings = ref.read(mdConfigProvider);

    final result = await _fetchByIds<Chapter>(
      endpoint: MangaDexEndpoints.chapter,
      ids: uuids,
      fromJson: Chapter.fromJson,
      chunkSize: MangaDexEndpoints.breakLimit,
      buildQueryParams: () => {
        'limit': MangaDexEndpoints.breakLimit.toString(),
        'includeFutureUpdates': '0',
        'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
        'includes[]': ['scanlation_group', 'user'],
      },
    );

    return result;
  }

  Future<List<Manga>> fetchMangaById({
    required int limit,
    required Iterable<String> ids,
  }) async {
    final settings = ref.read(mdConfigProvider);

    return _fetchByIds<Manga>(
      endpoint: MangaDexEndpoints.manga,
      ids: ids,
      fromJson: Manga.fromJson,
      chunkSize: limit,
      buildQueryParams: () => {
        'limit': limit.toString(),
        'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
        'includes[]': ['cover_art', 'author', 'artist'],
      },
    );
  }

  /// Fetches a list of manga data given the query parameters
  Future<MDEntityList> fetchMangaList({
    required int limit,
    required String feedKey,
    MangaDexUUID? entity,
    int offset = 0,
    MangaFilterOrder order = MangaFilterOrder.latestUploadedChapter_desc,
    Map<String, dynamic>? extraParams,
  }) async {
    final settings = ref.read(mdConfigProvider);

    var queryParams = <String, dynamic>{
      'limit': limit.toString(),
      'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
      'includes[]': ['cover_art', 'author', 'artist'],
      'offset': offset.toString(),
    };

    queryParams.addEntries([order.json]);

    if (extraParams != null) {
      queryParams.addAll(extraParams);
    }

    if (entity != null) {
      switch (entity) {
        case Author(:final id) || Artist(:final id):
          queryParams['authorOrArtist'] = id;
          break;
        case Group(:final id):
          queryParams['group'] = id;
          break;
        case Tag(:final id):
          queryParams['includedTags[]'] = id;
          break;
        default:
          final msg =
              "fetchMangaList() failed. Invalid filter type ${entity.runtimeType}.";
          logger.e(msg);
          throw InvalidDataException(msg);
      }
    }

    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.manga,
      queryParameters: queryParams,
    );
    final key = _requestCacheKey(
      namespace: _feedCacheNamespace(feedKey, entity),
      uri: uri,
    );

    return _getEntityList(
      uri: uri,
      operation: 'fetchManga()',
      authenticated: false,
      cacheKey: key,
      resolveEntities: true,
      expiry: const Duration(minutes: 15),
    );
  }

  /// Searches for manga using the MangaDex API with the search term [searchTerm].
  ///
  /// Each operation that queries the MangaDex API is limited to
  /// [limit] number of items.
  ///
  /// [offset] denotes the nth item to start fetching from.
  Future<MDEntityList> searchManga(
    String searchTerm, {
    required int limit,
    required MangaFilters filter,
    int offset = 0,
  }) async {
    final settings = ref.read(mdConfigProvider);

    Map<String, dynamic> queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      // 'availableTranslatedLanguage[]': settings.translatedLanguages
      //     .map(const LanguageConverter().toJson)
      //     .toList(),
      'originalLanguage[]': settings.originalLanguage
          .map(const LanguageConverter().toJson)
          .toList(),
      'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
      'includes[]': ['cover_art', 'author', 'artist'],
    };

    if (searchTerm.isNotEmpty) {
      queryParams['title'] = searchTerm;
    }

    queryParams.addAll(filter.getMap());

    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.manga,
      queryParameters: queryParams,
    );

    return _getEntityList(
      uri: uri,
      operation: 'searchManga()',
      authenticated: false,
      cacheKey: null,
      resolveEntities: true,
      expiry: const Duration(minutes: 15),
    );
  }

  /// Gets whether or not the user is following [manga]
  Future<bool> getMangaFollowing(Manga manga) async {
    if (!await loggedIn()) {
      throw StateError(
        "getMangaFollowing() called on invalid token/login. Shouldn't ever get here",
      );
    }

    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.follows.replaceFirst('{id}', manga.id),
    );

    final response = await _transport.getUri(uri);

    if (response.statusCode == 200) {
      // User follows the manga
      return true;
    } else if (response.statusCode == 404) {
      // User doesn't follow the manga
      return false;
    }

    // Throw if failure
    throw createException("getMangaFollowing() failed.", response);
  }

  /// Sets the manga's following status [setFollow] of the [manga]
  Future<bool> setMangaFollowing(Manga manga, bool setFollow) async {
    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.setFollow.replaceFirst('{id}', manga.id),
    );
    final operation = 'setMangaFollowing(${manga.id}, $setFollow)';

    return _request(
      method: setFollow
          ? _MangaDexRequestMethod.post
          : _MangaDexRequestMethod.delete,
      uri: uri,
      authenticated: true,
      operation: operation,
      parse: _hasOkResult,
      onRejectedResponse: (response) =>
          _logRejectedMutation(operation, response),
    );
  }

  /// Gets the user's reading status for [manga]
  Future<MangaReadingStatus?> getMangaReadingStatus(Manga manga) async {
    if (!await loggedIn()) {
      throw StateError(
        "getMangaReadingStatus() called on invalid token/login. Shouldn't ever get here",
      );
    }

    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.status.replaceFirst('{id}', manga.id),
    );

    final response = await _transport.getUri(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = response.data;

      if (body['result'] == 'ok') {
        MangaReadingStatus? status;

        if (body['status'] != null) {
          status = MangaReadingStatus.values.byName(body['status']);
        }

        return status;
      }
    } else if (response.statusCode == 404) {
      return null;
    }

    // Throw if failure
    throw createException("getMangaReadingStatus() failed.", response);
  }

  /// Sets the manga's reading status [status] of the [manga]
  Future<bool> setMangaReadingStatus(
    Manga manga,
    MangaReadingStatus? status,
  ) async {
    final params = {
      'status': (status != null && status != MangaReadingStatus.remove)
          ? status.name
          : null,
    };

    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.status.replaceFirst('{id}', manga.id),
    );
    final operation = 'setMangaReadingStatus(${manga.id}, $status)';

    return _request(
      method: _MangaDexRequestMethod.post,
      uri: uri,
      data: params,
      authenticated: true,
      operation: operation,
      parse: _hasOkResult,
      onRejectedResponse: (response) =>
          _logRejectedMutation(operation, response),
    );
  }

  /// Fetches read chapter data of given [mangas]
  ///
  /// Do not use directly. Prefer [readChaptersProvider] for its caching and
  /// state management.
  Future<ReadChaptersMap> fetchReadChapters(Iterable<Manga> mangas) async {
    if (!await loggedIn()) {
      throw StateError(
        "fetchReadChapters() called on invalid token/login. Shouldn't ever get here",
      );
    }

    final fetch = mangas.map((e) => e.id);

    if (fetch.isNotEmpty) {
      final queryParams = {'ids[]': fetch, 'grouped': 'true'};

      final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.getRead,
        queryParameters: queryParams,
      );

      final response = await _transport.getUri(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;

        if (body['data'] is List) {
          // Since grouped = true, if the api returns a List, then the result
          // is null for all queried manga. Return empty sets for all.

          return {for (var m in mangas) m.id: ReadChapterSet(m.id, {})};
        }

        final cmap = body['data'] as Map<String, dynamic>;

        final readmap = cmap.map(
          (key, value) => MapEntry(
            key,
            ReadChapterSet(
              key,
              List<String>.from(value as List<dynamic>).toSet(),
            ),
          ),
        );

        return readmap;
      } else {
        // Throw if failure
        throw createException("fetchReadChapters() failed.", response);
      }
    }

    return {};
  }

  /// Sets the given chapters as [read] or [unread]
  Future<bool> setChaptersRead(
    Manga manga, {
    Iterable<Chapter>? read,
    Iterable<Chapter>? unread,
  }) async {
    Map<String, dynamic> params = {};

    if (read != null && read.isNotEmpty) {
      params['chapterIdsRead'] = read.map((e) => e.id).toList();
    }

    if (unread != null && unread.isNotEmpty) {
      params['chapterIdsUnread'] = unread.map((e) => e.id).toList();
    }

    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.setRead.replaceFirst('{id}', manga.id),
    );
    final operation =
        'setChaptersRead(${manga.id}, ${read.toString()}, ${unread.toString()})';

    return _request(
      method: _MangaDexRequestMethod.post,
      uri: uri,
      data: params,
      authenticated: true,
      operation: operation,
      parse: (_) => true,
      onRejectedResponse: (response) =>
          _logRejectedMutation(operation, response),
    );
  }

  /// Fetches the relay server for [chapter] pages
  Future<PageData> getChapterServer(Chapter chapter) async {
    // If chapter links to external site, return nothing
    if (chapter.attributes.externalUrl != null) {
      return const PageData('', []);
    }

    final settings = ref.read(mdConfigProvider);

    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.server.replaceFirst('{id}', chapter.id),
    );

    final response = await _transport.getUri(uri);

    if (response.statusCode == 200) {
      final apidat = ChapterAPI.fromJson(response.data);

      final chapterUrl = apidat.getUrl(settings.dataSaver);

      var plist = apidat.chapter.data;

      if (settings.dataSaver) {
        plist = apidat.chapter.dataSaver;
      }

      final data = PageData(chapterUrl, plist);

      return data;
    }

    // Throw if failure
    throw createException("getChapterServer() failed.", response);
  }

  /// Fetches the user's manga library
  Future<LibraryMap> fetchUserLibrary(String userId) async {
    if (!await loggedIn()) {
      throw StateError(
        "fetchUserLibrary() called on invalid token/login. Shouldn't ever get here",
      );
    }

    const feed = MangaDexFeeds.library;

    decoder(String key, value) =>
        MapEntry(key, MangaReadingStatus.values.byName(value));

    final cachekey = '${feed.key}($userId)';

    if (await _cache.exists(cachekey)) {
      logger.d("Retrieving cached user library of user $userId");
      final libMap = _cache.get<LibraryMap>(cachekey, (decoded) {
        return decoded.map(decoder);
      });
      return libMap;
    }

    final uri = MangaDexEndpoints.api.replace(path: feed.path);

    final response = await _transport.getUri(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = response.data;

      if (body['statuses'] is List) {
        // If the api returns a List, then the result is null
        return {};
      }

      final mlist = body['statuses'] as Map<String, dynamic>;

      final libMap = mlist.map(decoder);

      logger.d("Caching user library of user $userId");
      await _cache.put(cachekey, json.encode(mlist), libMap);

      return libMap;
    }

    // Throw if failure
    throw createException("fetchUserLibrary() failed.", response);
  }

  /// Retrieve all MangaDex tags
  Future<MDEntityList> getTagList() async {
    final uri = MangaDexEndpoints.api.replace(path: MangaDexFeeds.tags.path);

    return _getEntityList(
      uri: uri,
      operation: 'getTagList()',
      authenticated: false,
      cacheKey: MangaDexFeeds.tags.key,
      resolveEntities: false,
      expiry: const Duration(days: 1),
    );
  }

  /// Fetches statistics of given [mangas]
  ///
  /// Do not use directly. Prefer [statisticsProvider] for its caching and
  /// state management.
  Future<Map<String, MangaStatistics>> fetchStatistics(
    Iterable<Manga> mangas,
  ) async {
    final ids = mangas.map((e) => e.id);
    return _fetchStats(
      endpoint: MangaDexEndpoints.statistics,
      queryParamKey: 'manga[]',
      ids: ids,
      fromJson: (data) => MangaStatisticsResponse.fromJson(data).statistics,
      errorLog: () => "fetchStatistics() failed.",
    );
  }

  /// Fetches statistics of given [chapters]
  ///
  /// Do not use directly. Prefer [chapterStatsProvider] for its caching and
  /// state management.
  Future<Map<String, ChapterStatistics>> fetchChapterStats(
    Iterable<Chapter> chapters,
  ) async {
    final ids = chapters.map((e) => e.id);
    return _fetchStats(
      endpoint: MangaDexEndpoints.chapterStats,
      queryParamKey: 'chapter[]',
      ids: ids,
      fromJson: (data) => ChapterStatisticsResponse.fromJson(data).statistics,
      errorLog: () => "fetchChapterStats() failed.",
    );
  }

  /// Retrieve cover art for a specific manga
  Future<MDEntityList> getCoverList(Manga manga, {int offset = 0}) async {
    final info = MangaDexFeeds.mangaCovers;

    final key = '${info.key}(${manga.id},$offset)';

    final queryParams = {
      'limit': info.limit.toString(),
      'offset': offset.toString(),
      'order[volume]': 'asc',
      'manga[]': manga.id,
    };
    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.cover,
      queryParameters: queryParams,
    );

    return _getEntityList(
      uri: uri,
      operation: 'getCoverList()',
      authenticated: false,
      cacheKey: key,
      resolveEntities: false,
      expiry: const Duration(minutes: 15),
    );
  }

  /// Fetches the user's self-rating of given [mangas]
  ///
  /// Do not use directly. Prefer [ratingsProvider] for its caching and
  /// state management.
  Future<Map<String, SelfRating>> fetchRatings(Iterable<Manga> mangas) async {
    final ids = mangas.map((e) => e.id);
    return _fetchStats(
      endpoint: MangaDexEndpoints.getRating,
      queryParamKey: 'manga[]',
      ids: ids,
      fromJson: (data) => SelfRatingResponse.fromJson(data).ratings,
      errorLog: () => "fetchRating() failed.",
      preProcess: (data) => (data['ratings'] as dynamic) is List,
    );
  }

  /// Sets the [manga]'s self-rating
  Future<bool> setMangaRating(Manga manga, int? rating) async {
    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.setRating.replaceFirst('{id}', manga.id),
    );
    final operation = 'setMangaRating(${manga.id}, $rating)';

    return _request(
      method: rating != null
          ? _MangaDexRequestMethod.post
          : _MangaDexRequestMethod.delete,
      uri: uri,
      data: rating != null ? {'rating': rating} : null,
      authenticated: true,
      operation: operation,
      parse: _hasOkResult,
      onRejectedResponse: (response) =>
          _logRejectedMutation(operation, response),
    );
  }

  /// Fetches group info of the given group [uuids]
  Future<List<Group>> fetchGroups(Iterable<String> uuids) async {
    return _fetchByIds<Group>(
      endpoint: MangaDexEndpoints.group,
      ids: uuids,
      fromJson: Group.fromJson,
      chunkSize: MangaDexEndpoints.breakLimit,
      buildQueryParams: () => {
        'limit': MangaDexEndpoints.breakLimit.toString(),
      },
    );
  }

  /// Fetches creator info of the given [uuids]
  Future<List<CreatorType>> fetchCreators({
    Iterable<String>? uuids,
    String? name,
  }) async {
    assert(uuids != null || name != null);

    if (uuids != null) {
      return _fetchByIds<CreatorType>(
        endpoint: MangaDexEndpoints.creator,
        ids: uuids,
        fromJson: Author.fromJson,
        chunkSize: MangaDexEndpoints.breakLimit,
        buildQueryParams: () => {
          'limit': MangaDexEndpoints.breakLimit.toString(),
        },
      );
    }

    // name search
    final queryParams = <String, dynamic>{'limit': '10', 'name': name};

    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.creator,
      queryParameters: queryParams,
    );

    final result = await _getEntityList(
      uri: uri,
      operation: 'fetchCreators()',
      authenticated: false,
      cacheKey: null,
      resolveEntities: true,
      expiry: const Duration(minutes: 15),
    );
    return result.data.cast<CreatorType>();
  }

  /// Fetches a [CustomList] by id
  Future<CustomList?> fetchListById(String listId) async {
    if (listId.isEmpty) {
      logger.w('Invalid listId $listId');
      return null;
    }

    if (await _cache.exists(listId)) {
      return _cache.get<CustomList>(listId, CustomList.fromJson);
    }

    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.modifyList.replaceFirst('{id}', listId),
    );

    final response = await _transport.getUri(uri);

    if (response.statusCode == 200) {
      final body = response.data as Map<String, dynamic>;
      final result = CustomList.fromJson(body['data']);
      return await _cache.put(
        listId,
        json.encode(result.toJson()),
        result,
        unserializer: CustomList.fromJson,
      );
    }

    if (response.statusCode == 404) {
      // List not found
      return null;
    }

    // Throw if unknown code
    throw createException("fetchListById() failed.", response);
  }

  /// Adds/removes a [CustomList] from user followed list
  Future<bool> setFollowList(CustomList list, bool follow) async {
    final id = list.id;

    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.followList.replaceFirst('{id}', list.id),
    );
    final operation = 'setFollowList($id, $follow)';

    return _request(
      method: follow
          ? _MangaDexRequestMethod.post
          : _MangaDexRequestMethod.delete,
      uri: uri,
      authenticated: true,
      operation: operation,
      parse: _hasOkResult,
      onRejectedResponse: (response) =>
          _logRejectedMutation(operation, response),
    );
  }

  /// Fetches logged user's [CustomList] list
  ///
  /// [feed]    feed to use
  /// [offset]  the nth item to start fetching from
  ///
  /// Do not use directly. Use [userListsProvider] or [followedListsProvider] instead
  Future<List<CustomList>> fetchUserList({
    required FeedInfo feed,
    int offset = 0,
  }) async {
    final queryParams = {
      'limit': feed.limit.toString(),
      'offset': offset.toString(),
    };

    final uri = MangaDexEndpoints.api.replace(
      path: feed.path!,
      queryParameters: queryParams,
    );

    final result = await _getEntityList(
      uri: uri,
      operation: 'fetchUserList()',
      authenticated: true,
      cacheKey: null,
      resolveEntities: true,
      expiry: const Duration(minutes: 15),
    );

    final list = <CustomList>[];
    for (final entity in result.data) {
      list.add(_cache.get<CustomList>(entity.id, CustomList.fromJson));
    }

    return list;
  }

  /// Adds/removes a [Manga] from a [CustomList]
  Future<CustomList?> updateMangaInCustomList(
    CustomList list,
    Manga manga,
    bool add,
  ) async {
    final id = list.id;
    final endpoint = MangaDexEndpoints.updateMangaInList
        .replaceFirst('{id}', manga.id)
        .replaceFirst('{listId}', id);

    final uri = MangaDexEndpoints.api.replace(path: endpoint);
    final operation = 'updateMangaInCustomList($id, ${manga.id}, $add)';
    final succeeded = await _request<bool>(
      method: add ? _MangaDexRequestMethod.post : _MangaDexRequestMethod.delete,
      uri: uri,
      authenticated: true,
      operation: operation,
      parse: _hasOkResult,
      onRejectedResponse: (response) =>
          _logRejectedMutation(operation, response),
    );

    if (!succeeded) {
      return null;
    }

    final relationships = [...list.relationships];
    if (add) {
      relationships.add(Manga(id: manga.id));
    } else {
      relationships.removeWhere((e) => e.id == manga.id);
    }

    final updated = list.copyWith(relationships: relationships);

    return _cache.put(
      updated.id,
      json.encode(updated.toJson()),
      updated,
      unserializer: CustomList.fromJson,
    );
  }

  /// Deletes a [CustomList]
  Future<bool> deleteList(CustomList list) async {
    final id = list.id;
    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.modifyList.replaceFirst('{id}', id),
    );

    final result = await _request(
      method: _MangaDexRequestMethod.delete,
      uri: uri,
      authenticated: true,
      operation: 'deleteList($id)',
      parse: (response) {
        final body = response.data as Map<String, dynamic>;
        if (body['result'] != 'ok') {
          throw const FormatException('Expected result: ok');
        }

        return true;
      },
    );

    await _cache.remove(id);
    return result;
  }

  /// Creates a new [CustomList]
  Future<CustomList> createNewList(
    String name,
    CustomListVisibility visibility,
    Iterable<String> mangaIds,
  ) async {
    final data = {
      'name': name,
      'visibility': visibility.name,
      'manga': mangaIds.toList(),
    };
    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.createList,
    );
    final operation = 'createNewList($name, ${visibility.name})';

    final result = await _request<CustomList>(
      method: _MangaDexRequestMethod.post,
      uri: uri,
      data: data,
      authenticated: true,
      acceptedStatusCodes: const {200, 201},
      operation: operation,
      parse: (response) {
        final body = response.data as Map<String, dynamic>;
        if (body['result'] != 'ok') {
          throw const FormatException('Expected result: ok');
        }
        return CustomList.fromJson(body['data']);
      },
    );

    return _cache.put(
      result.id,
      json.encode(result.toJson()),
      result,
      unserializer: CustomList.fromJson,
    );
  }

  /// Edits an existing [CustomList]
  Future<CustomList> editList(
    CustomList list,
    String name,
    CustomListVisibility visibility,
    Iterable<String> mangaIds,
  ) async {
    final id = list.id;
    final data = {
      'name': name,
      'visibility': visibility.name,
      'manga': mangaIds.toList(),
      'version': list.attributes.version,
    };
    final uri = MangaDexEndpoints.api.replace(
      path: MangaDexEndpoints.modifyList.replaceFirst('{id}', id),
    );
    final operation = 'editList($id, ${visibility.name})';

    final result = await _request<CustomList>(
      method: _MangaDexRequestMethod.put,
      uri: uri,
      data: data,
      authenticated: true,
      operation: operation,
      parse: (response) {
        final body = response.data as Map<String, dynamic>;
        if (body['result'] != 'ok') {
          throw const FormatException('Expected result: ok');
        }
        return CustomList.fromJson(body['data']);
      },
    );

    return _cache.put(
      result.id,
      json.encode(result.toJson()),
      result,
      unserializer: CustomList.fromJson,
    );
  }

  /// Get logged in user details
  Future<User> getLoggedUser() async {
    if (!await loggedIn()) {
      throw StateError(
        "getLoggedUser() called on invalid token/login. Shouldn't ever get here",
      );
    }

    final uri = MangaDexEndpoints.api.replace(path: MangaDexEndpoints.me);

    final response = await _transport.getUri(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = response.data;

      if (body['result'] == 'ok') {
        // Process new list
        final user = User.fromJson(body['data']);

        return user;
      }
    }

    // Throw if failure
    throw createException("getLoggedUser() failed.", response);
  }
}
