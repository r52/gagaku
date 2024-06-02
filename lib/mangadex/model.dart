import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:gagaku/log.dart';
import 'package:gagaku/cache.dart';
import 'package:gagaku/mangadex/cache.dart';
import 'package:gagaku/mangadex/config.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/types.dart';
import 'package:gagaku/util.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:mutex/mutex.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'model.g.dart';

abstract class MangaDexEndpoints {
  static final api = Uri.https('api.mangadex.org', '');

  static const breakLimit = 50;
  static const searchLimit = 32;
  static const chapterLimit = 100;

  // OAuth provider
  static final provider =
      Uri.parse('https://auth.mangadex.org/realms/mangadex');

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
  static const listFollows = '/user/follows/list';

  /// (Future) Follow/unfollow CustomList
  static const followList = '/list/{id}/follow';

  /// Logged in user details
  static const me = '/user/me';
}

abstract class CacheLists {
  static const library = 'userLibrary';
  static const tags = 'tags';
}

extension TokenHelper on TokenResponse {
  bool get isValid => accessToken != null && refreshToken != null;
}

@Riverpod(keepAlive: true)
MangaDexModel mangadex(MangadexRef ref) {
  return MangaDexModel(ref);
}

class MangaDexModel {
  MangaDexModel(this.ref) {
    _cache = ref.watch(cacheProvider);
    _future = refreshToken();
  }

  final Ref ref;
  TokenResponse? _token;
  Credential? _credential;
  final _tokenMutex = ReadWriteMutex();
  http.Client _client = RateLimitedClient();
  late Future _future;
  Future get future => _future;

  late final CacheManager _cache;

  // void _urlLauncher(String url) async {
  //   var uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri) || Platform.isAndroid) {
  //     await launchUrl(uri);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  Future<Duration?> timeUntilTokenExpiry() async {
    return await _tokenMutex.protectRead(() async {
      if (_token == null) {
        return null;
      }

      return _token!.expiresIn;
    });
  }

  Future<bool> tokenExpired() async {
    return await _tokenMutex.protectRead(() async {
      if (_token == null) {
        return false;
      }

      return _token!.expiresIn!.inSeconds <= 0;
    });
  }

  Future<bool> loggedIn() async {
    return await _tokenMutex.protectRead(() async {
      return (_token != null && _credential != null && _token!.isValid);
    });
  }

  Future<void> refreshToken() async {
    return await _tokenMutex.protectWrite(() async {
      // Clear old data
      _token = null;

      final storage = Hive.box(gagakuBox);
      bool accessTokenSaved = storage.get('accessToken') != null;

      if (accessTokenSaved) {
        final tt = storage.get('tokenType') as String;
        final rt = storage.get('refreshToken') as String;
        final it = storage.get('idToken') as String;
        final clientId = storage.get('clientId') as String;
        final clientSecret = storage.get('clientSecret') as String;

        final issuer = _credential?.client.issuer ??
            await Issuer.discover(MangaDexEndpoints.provider,
                httpClient: _client);
        final client = _credential?.client ??
            Client(issuer, clientId, clientSecret: clientSecret);

        final credential = _credential ??
            client.createCredential(
              accessToken: null, // force use refresh to get new token
              tokenType: tt,
              refreshToken: rt,
              idToken: it,
            );

        try {
          credential.validateToken(validateClaims: true, validateExpiry: true);
          final token = await credential.getTokenResponse();
          if (token.isValid) {
            _saveToken(token);

            _token = token;
            _client = credential.createHttpClient(_client);
            _credential = credential;
            logger.i("refreshToken(): MangaDex token refreshed");
            return;
          }

          // If any steps fail, assign a default client
          logger.w("refreshToken() returned error ${token['error']}",
              error: token.toString());
          _client = RateLimitedClient();
        } catch (e) {
          logger.w("refreshToken() error ${e.toString()}", error: e);
          _client = RateLimitedClient();
        }
      }
    });
  }

  Future<void> authenticate(
      String user, String pass, String clientId, String clientSecret) async {
    final issuer =
        await Issuer.discover(MangaDexEndpoints.provider, httpClient: _client);

    final client = Client(issuer, clientId, clientSecret: clientSecret);

    final flow = Flow.password(client);

    final credential =
        await flow.loginWithPassword(username: user, password: pass);

    final token = await credential.getTokenResponse();

    if (token.isValid) {
      return await _tokenMutex.protectWrite(() async {
        await _saveToken(token);
        await _saveCredentials(user, clientId, clientSecret);
        _token = token;
        _client = credential.createHttpClient(_client);
        _credential = credential;

        logger.i("authenticate(): MangaDex user logged in");
      });
    }

    logger.w("authenticate() returned error ${token['error']}",
        error: token.toString());
  }

  Future<void> _saveCredentials(
      String username, String clientId, String clientSecret) async {
    final storage = Hive.box(gagakuBox);

    await storage.put('username', username);
    await storage.put('clientId', clientId);
    await storage.put('clientSecret', clientSecret);
  }

  Future<void> _saveToken(TokenResponse token) async {
    final storage = Hive.box(gagakuBox);

    await storage.put('accessToken', token.accessToken);
    await storage.put('refreshToken', token.refreshToken);
    await storage.put('tokenType', token.tokenType);
    await storage.put('idToken', token.idToken.toCompactSerialization());
  }

  Future<void> logout() async {
    if (await loggedIn() && _credential != null) {
      final logoutUrl = _credential!.generateLogoutUrl();
      if (logoutUrl != null) {
        final response = await _client.post(logoutUrl);

        if (response.statusCode == 200) {
          return await _tokenMutex.protectWrite(() async {
            _token = null;
            _client = RateLimitedClient();
            _credential = null;

            final storage = Hive.box(gagakuBox);
            await storage.delete('accessToken');
            await storage.delete('refreshToken');
            await storage.delete('tokenType');
            await storage.delete('idToken');

            logger.i("logout(): MangaDex user logged out");
          });
        }

        logger.w("logout() returned code ${response.statusCode}",
            error: response.body);
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

  Exception createException(String msg, http.Response response) {
    if (response.statusCode == 503) {
      msg = 'MangaDex is down for maintanence';
    }

    final message =
        "$msg\nServer returned ${response.statusCode}: ${response.reasonPhrase}";

    if (response.statusCode >= 500) {
      logger.e(message);
      return Exception(message);
    }

    // MD API error
    final body = json.decode(response.body);
    final err = ErrorResponse.fromJson(body);
    final ex = MangaDexException(msg, err.errors);
    logger.e(msg, error: ex);
    return ex;
  }

  /// Fetches a generic [ChapterList] feed based on given parameters, respecting
  /// user settings.
  ///
  /// [path]      the path to the feed on the MangaDex API
  /// [feedKey]   sets the key for caching purposes
  /// [limit]     limits number of items per query
  /// [offset]    denotes the nth item to start fetching from.
  /// [entity]    a [MangaDexUUID] entity that the feed corresponds to
  /// [orderKey]  order scheme
  /// [order]     order direction
  ///
  /// Use specific providers that determine the feed to fetch
  Future<Iterable<Chapter>> fetchFeed({
    required String path,
    required String feedKey,
    required int limit,
    int offset = 0,
    MangaDexUUID? entity,
    String orderKey = 'publishAt',
    String order = 'desc',
  }) async {
    final key =
        '$feedKey(${entity != null ? '${entity.id},' : ''}$offset,$orderKey,$order)';

    if (await _cache.exists(key)) {
      return (await _cache.getSpecialList(key, Chapter.fromJson))
          .map((e) => e.get<Chapter>());
    }

    final settings = ref.read(mdConfigProvider);

    // Download missing data
    final queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'translatedLanguage[]': settings.translatedLanguages
          .map(const LanguageConverter().toJson)
          .toList(),
      'originalLanguage[]': settings.originalLanguage
          .map(const LanguageConverter().toJson)
          .toList(),
      'includeFutureUpdates': '0',
      'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
      'order[$orderKey]': order,
      'includes[]': ['scanlation_group', 'user']
    };

    if (entity != null && entity is Group) {
      queryParams['groups[]'] = entity.id;
    } else if (settings.groupBlacklist.isNotEmpty) {
      queryParams['excludedGroups[]'] = settings.groupBlacklist.toList();
    }

    final uri =
        MangaDexEndpoints.api.replace(path: path, queryParameters: queryParams);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final result = ChapterList.fromJson(body);

      // Cache the data and list
      await _cache.putSpecialList(key, result.data, resolve: true);

      return result.data;
    }

    // Throw if failure
    throw createException("$feedKey() failed.", response);
  }

  /// Fetches chapter data of the given chapter [uuids]
  Future<Iterable<Chapter>> fetchChapters(Iterable<String> uuids) async {
    final settings = ref.read(mdConfigProvider);

    final list = <Chapter>[];

    final fetch =
        (await uuids.whereAsync((id) async => !await _cache.exists(id)))
            .toList();

    if (fetch.isNotEmpty) {
      int start = 0, end = 0;

      var queryParams = {
        'limit': MangaDexEndpoints.breakLimit.toString(),
        'includeFutureUpdates': '0',
        //'order[publishAt]': 'desc',
        'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
        'includes[]': ['scanlation_group', 'user']
      };

      while (end < fetch.length) {
        start = end;
        end += min(fetch.length - start, MangaDexEndpoints.breakLimit);

        queryParams['ids[]'] = fetch.getRange(start, end);

        final uri = MangaDexEndpoints.api.replace(
            path: MangaDexEndpoints.chapter, queryParameters: queryParams);

        final response = await _client.get(uri);

        if (response.statusCode == 200) {
          final Map<String, dynamic> body = json.decode(response.body);
          final result = ChapterList.fromJson(body);

          // Cache the data
          await _cache.putAllAPIResolved(result.data);
        } else {
          // Throw if failure
          throw createException("fetchChapters() failed.", response);
        }
      }
    }

    // Craft the list
    for (final id in uuids) {
      if (await _cache.exists(id)) {
        list.add(_cache.get(id, Chapter.fromJson).get<Chapter>());
      }
    }

    return list;
  }

  /// Fetches a list of manga data given the query parameters
  Future<List<Manga>> fetchManga({
    required int limit,
    Iterable<String>? ids,
    MangaDexUUID? filterId,
    int offset = 0,
  }) async {
    final settings = ref.read(mdConfigProvider);

    final queryParams = {
      'limit': limit.toString(),
      'order[latestUploadedChapter]': 'desc',
      'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
      'includes[]': ['cover_art', 'author', 'artist']
    };

    final list = <Manga>[];

    if (ids != null) {
      final fetch =
          (await ids.whereAsync((id) async => !await _cache.exists(id)))
              .toList();

      if (fetch.isNotEmpty) {
        int start = 0, end = 0;

        while (end < fetch.length) {
          start = end;
          end += min(fetch.length - start, limit);

          queryParams['ids[]'] = fetch.getRange(start, end);

          final uri = MangaDexEndpoints.api.replace(
              path: MangaDexEndpoints.manga, queryParameters: queryParams);

          final response = await _client.get(uri);

          if (response.statusCode == 200) {
            final Map<String, dynamic> body = json.decode(response.body);
            final mangalist = MangaList.fromJson(body);

            // Cache the data
            await _cache.putAllAPIResolved(mangalist.data);
          } else {
            // Throw if failure
            throw createException("fetchManga(ids) failed.", response);
          }
        }
      }

      // Craft the list
      for (final id in ids) {
        if (await _cache.exists(id)) {
          list.add(_cache.get(id, Manga.fromJson).get<Manga>());
        }
      }
    } else if (filterId != null) {
      queryParams['offset'] = offset.toString();

      switch (filterId) {
        case Author(:final id) || Artist(:final id):
          queryParams['authorOrArtist'] = id;
          break;
        case Group(:final id):
          queryParams['group'] = id;
          break;
        default:
          final msg =
              "fetchManga(filterId) failed. Invalid filter type ${filterId.runtimeType}.";
          logger.e(msg);
          throw Exception(msg);
      }

      final uri = MangaDexEndpoints.api
          .replace(path: MangaDexEndpoints.manga, queryParameters: queryParams);

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final mangalist = MangaList.fromJson(body);

        // Cache the data
        await _cache.putAllAPIResolved(mangalist.data);

        return mangalist.data;
      } else {
        // Throw if failure
        throw createException("fetchManga(filterId) failed.", response);
      }
    }

    return list;
  }

  /// Searches for manga using the MangaDex API with the search term [searchTerm].
  ///
  /// Each operation that queries the MangaDex API is limited to
  /// [limit] number of items.
  ///
  /// [offset] denotes the nth item to start fetching from.
  Future<List<Manga>> searchManga(
    String searchTerm, {
    required int limit,
    required MangaFilters filter,
    int offset = 0,
  }) async {
    final settings = ref.read(mdConfigProvider);

    Map<String, dynamic> queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'availableTranslatedLanguage[]': settings.translatedLanguages
          .map(const LanguageConverter().toJson)
          .toList(),
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

    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.manga, queryParameters: queryParams);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final mlist = MangaList.fromJson(body);

      // Cache the data
      await _cache.putAllAPIResolved(mlist.data);

      return mlist.data;
    }

    // Throw if failure
    throw createException("searchManga() failed.", response);
  }

  /// Gets whether or not the user is following [manga]
  Future<bool> getMangaFollowing(Manga manga) async {
    if (!await loggedIn()) {
      throw StateError(
          "getMangaFollowing() called on invalid token/login. Shouldn't ever get here");
    }

    final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.follows.replaceFirst('{id}', manga.id));

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      // User follows the manga
      return true;
    } else if (response.statusCode == 404) {
      // User doesn't follow the manga
      return false;
    }

    // Throw if failure
    final msg =
        "getMangaFollowing() failed. Response code: ${response.statusCode}";
    logger.e(msg, error: response.body);
    throw Exception(msg);
  }

  /// Sets the manga's following status [setFollow] of the [manga]
  Future<bool> setMangaFollowing(Manga manga, bool setFollow) async {
    if (!await loggedIn()) {
      throw StateError(
          "setMangaFollowing() called on invalid token/login. Shouldn't ever get here");
    }

    final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.setFollow.replaceFirst('{id}', manga.id));

    http.Response response;

    if (setFollow) {
      response = await _client.post(uri);
    } else {
      response = await _client.delete(uri);
    }

    if (response.statusCode == 200) {
      // Success
      return true;
    }

    // Log the failure
    logger.w(
        "setMangaFollowing(${manga.id}, $setFollow) returned code ${response.statusCode}",
        error: response.body);

    return false;
  }

  /// Gets the user's reading status for [manga]
  Future<MangaReadingStatus?> getMangaReadingStatus(Manga manga) async {
    if (!await loggedIn()) {
      throw StateError(
          "getMangaReadingStatus() called on invalid token/login. Shouldn't ever get here");
    }

    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.status.replaceFirst('{id}', manga.id));

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

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
      Manga manga, MangaReadingStatus? status) async {
    if (!await loggedIn()) {
      throw StateError(
          "setMangaReadingStatus() called on invalid token/login. Shouldn't ever get here");
    }

    final params = {
      'status': (status != null && status != MangaReadingStatus.remove)
          ? status.name
          : null
    };

    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.status.replaceFirst('{id}', manga.id));

    final response = await _client.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(params));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);

      if (body['result'] == 'ok') {
        return true;
      }
    }

    // Log the failure
    logger.w(
        "setMangaReadingStatus(${manga.id}, $status) returned code ${response.statusCode}",
        error: response.body);

    return false;
  }

  /// Fetches read chapter data of given [mangas]
  ///
  /// Do not use directly. Prefer [readChaptersProvider] for its caching and
  /// state management.
  Future<ReadChaptersMap> fetchReadChapters(Iterable<Manga> mangas) async {
    if (!await loggedIn()) {
      throw StateError(
          "fetchReadChapters() called on invalid token/login. Shouldn't ever get here");
    }

    final fetch = mangas.map((e) => e.id);

    if (fetch.isNotEmpty) {
      final queryParams = {'ids[]': fetch, 'grouped': 'true'};

      final uri = MangaDexEndpoints.api.replace(
          path: MangaDexEndpoints.getRead, queryParameters: queryParams);

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);

        if (body['data'] is List) {
          // Since grouped = true, if the api returns a List, then the result
          // is null
          ReadChaptersMap map = {};

          for (var m in mangas) {
            map[m.id] = ReadChapterSet(m.id, {});
          }

          return map;
        }

        final cmap = body['data'] as Map<String, dynamic>;

        final readmap = cmap.map((key, value) => MapEntry(
            key,
            ReadChapterSet(
                key, List<String>.from(value as List<dynamic>).toSet())));

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
    if (!await loggedIn()) {
      throw StateError(
          "setChaptersRead() called on invalid token/login. Shouldn't ever get here");
    }

    Map<String, dynamic> params = {};

    if (read != null && read.isNotEmpty) {
      params['chapterIdsRead'] = read.map((e) => e.id).toList();
    }

    if (unread != null && unread.isNotEmpty) {
      params['chapterIdsUnread'] = unread.map((e) => e.id).toList();
    }

    final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.setRead.replaceFirst('{id}', manga.id));

    final response = await _client.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(params));

    if (response.statusCode == 200) {
      // Success
      return true;
    }

    // Log the failure
    logger.w(
        "setChaptersRead(${manga.id}, ${read.toString()}, ${unread.toString()}) returned code ${response.statusCode}",
        error: response.body);

    return false;
  }

  /// Fetches the relay server for [chapter] pages
  Future<PageData> getChapterServer(Chapter chapter) async {
    // If chapter links to external site, return nothing
    if (chapter.attributes.externalUrl != null) {
      return const PageData('', []);
    }

    final settings = ref.read(mdConfigProvider);

    final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.server.replaceFirst('{id}', chapter.id));

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final apidat = ChapterAPI.fromJson(body);

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
  Future<LibraryMap?> fetchUserLibrary() async {
    if (!await loggedIn()) {
      throw StateError(
          "fetchUserLibrary() called on invalid token/login. Shouldn't ever get here");
    }

    decoder(String key, value) =>
        MapEntry(key, MangaReadingStatus.values.byName(value));

    if (await _cache.exists(CacheLists.library)) {
      logger.d("Retrieving cached user library");
      final libMap = _cache.get(CacheLists.library, (decoded) {
        return decoded.map(decoder);
      }).get<LibraryMap>();
      return libMap;
    }

    final uri = MangaDexEndpoints.api.replace(path: MangaDexEndpoints.library);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      if (body['statuses'] is List) {
        // If the api returns a List, then the result is null
        return null;
      }

      final mlist = body['statuses'] as Map<String, dynamic>;

      final libMap = mlist.map(decoder);

      logger.d("Caching user library");
      await _cache.put(CacheLists.library, json.encode(mlist), libMap, true);

      return libMap;
    }

    // Throw if failure
    throw createException("fetchUserLibrary() failed.", response);
  }

  /// Retrieve all MangaDex tags
  Future<Iterable<Tag>> getTagList() async {
    if (await _cache.exists(CacheLists.tags)) {
      return (await _cache.getSpecialList(CacheLists.tags, Tag.fromJson))
          .map((e) => e.get<Tag>());
    }

    final uri = MangaDexEndpoints.api.replace(path: MangaDexEndpoints.tag);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final result = TagResponse.fromJson(body);

      // Cache the data and list
      await _cache.putSpecialList(CacheLists.tags, result.data,
          resolve: true, expiry: const Duration(days: 7));

      return result.data;
    }

    // Throw if failure
    throw createException("getTagList() failed.", response);
  }

  /// Fetches statistics of given [mangas]
  ///
  /// Do not use directly. Prefer [statisticsProvider] for its caching and
  /// state management.
  Future<Map<String, MangaStatistics>> fetchStatistics(
      Iterable<Manga> mangas) async {
    final fetch = mangas.map((e) => e.id);

    if (fetch.isNotEmpty) {
      final queryParams = {'manga[]': fetch.toList()};

      final uri = MangaDexEndpoints.api.replace(
          path: MangaDexEndpoints.statistics, queryParameters: queryParams);

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final resp = MangaStatisticsResponse.fromJson(body);

        return resp.statistics;
      } else {
        // Throw if failure
        throw createException("fetchStatistics() failed.", response);
      }
    }

    return {};
  }

  /// Retrieve cover art for a specific manga
  Future<Iterable<CoverArt>> getCoverList(
    Manga manga, {
    required int limit,
    int offset = 0,
  }) async {
    final key = 'CoverList(${manga.id},$offset)';

    if (await _cache.exists(key)) {
      return (await _cache.getSpecialList(key, CoverArt.fromJson))
          .map((e) => e.get<CoverArt>());
    }

    final queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'order[volume]': 'asc',
      'manga[]': manga.id,
    };
    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.cover, queryParameters: queryParams);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final result = CoverList.fromJson(body);

      // Cache the data
      await _cache.putSpecialList(key, result.data, resolve: true);

      return result.data;
    }

    // Throw if failure
    throw createException("getCoverList() failed.", response);
  }

  /// Fetches the user's self-rating of given [mangas]
  ///
  /// Do not use directly. Prefer [ratingsProvider] for its caching and
  /// state management.
  Future<Map<String, SelfRating>> fetchRatings(Iterable<Manga> mangas) async {
    final fetch = mangas.map((e) => e.id);

    if (fetch.isNotEmpty) {
      final queryParams = {'manga[]': fetch.toList()};

      final uri = MangaDexEndpoints.api.replace(
          path: MangaDexEndpoints.getRating, queryParameters: queryParams);

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);

        if (body['ratings'] is List) {
          // If the api returns a List, then the result is null
          Map<String, SelfRating> map = {};

          for (final m in mangas) {
            map[m.id] = SelfRating(rating: -1, createdAt: DateTime.now());
          }

          return map;
        }

        final resp = SelfRatingResponse.fromJson(body);

        Map<String, SelfRating> map = resp.ratings;

        for (final m in mangas) {
          if (!map.containsKey(m.id)) {
            map[m.id] = SelfRating(rating: -1, createdAt: DateTime.now());
          }
        }

        return map;
      } else {
        // Throw if failure
        throw createException("fetchRating() failed.", response);
      }
    }

    return {};
  }

  /// Sets the [manga]'s self-rating
  Future<bool> setMangaRating(Manga manga, int? rating) async {
    if (!await loggedIn()) {
      throw StateError(
          "setMangaRating() called on invalid token/login. Shouldn't ever get here");
    }

    final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.setRating.replaceFirst('{id}', manga.id));

    http.Response? response;

    if (rating != null) {
      final params = {
        'rating': rating,
      };

      response = await _client.post(uri,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(params));
    } else {
      response = await _client.delete(uri);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);

      if (body['result'] == 'ok') {
        return true;
      }
    }

    // Log the failure
    logger.w(
        "setMangaRating(${manga.id}, $rating) returned code ${response.statusCode}",
        error: response.body);

    return false;
  }

  /// Fetches group info of the given group [uuids]
  Future<List<Group>> fetchGroups(Iterable<String> uuids) async {
    final list = <Group>[];

    final fetch =
        (await uuids.whereAsync((id) async => !await _cache.exists(id)))
            .toList();

    if (fetch.isNotEmpty) {
      int start = 0, end = 0;

      var queryParams = <String, dynamic>{
        'limit': MangaDexEndpoints.breakLimit.toString(),
      };

      while (end < fetch.length) {
        start = end;
        end += min(fetch.length - start, MangaDexEndpoints.breakLimit);

        queryParams['ids[]'] = fetch.getRange(start, end);

        final uri = MangaDexEndpoints.api.replace(
            path: MangaDexEndpoints.group, queryParameters: queryParams);

        final response = await _client.get(uri);

        if (response.statusCode == 200) {
          final Map<String, dynamic> body = json.decode(response.body);
          final result = GroupList.fromJson(body);

          // Cache the data
          await _cache.putAllAPIResolved(result.data);
        } else {
          // Throw if failure
          throw createException("fetchGroups() failed.", response);
        }
      }
    }

    // Craft the list
    for (final id in uuids) {
      if (await _cache.exists(id)) {
        list.add(_cache.get(id, Group.fromJson).get<Group>());
      }
    }

    return list;
  }

  /// Fetches creator info of the given [uuids]
  Future<List<CreatorType>> fetchCreators(Iterable<String> uuids) async {
    final list = <CreatorType>[];

    final fetch =
        (await uuids.whereAsync((id) async => !await _cache.exists(id)))
            .toList();

    if (fetch.isNotEmpty) {
      int start = 0, end = 0;

      var queryParams = <String, dynamic>{
        'limit': MangaDexEndpoints.breakLimit.toString(),
      };

      while (end < fetch.length) {
        start = end;
        end += min(fetch.length - start, MangaDexEndpoints.breakLimit);

        queryParams['ids[]'] = fetch.getRange(start, end);

        final uri = MangaDexEndpoints.api.replace(
            path: MangaDexEndpoints.creator, queryParameters: queryParams);

        final response = await _client.get(uri);

        if (response.statusCode == 200) {
          final Map<String, dynamic> body = json.decode(response.body);
          final result = CreatorList.fromJson(body);

          // Cache the data
          await _cache.putAllAPIResolved(result.data);
        } else {
          // Throw if failure
          throw createException("fetchCreators() failed.", response);
        }
      }
    }

    // Craft the list
    for (final id in uuids) {
      if (await _cache.exists(id)) {
        list.add(_cache.get(id, Author.fromJson).get<CreatorType>());
      }
    }

    return list;
  }

  /// Fetches a [CustomList] by id
  Future<CRef?> fetchListById(String listId) async {
    if (listId.isEmpty) {
      logger.w('Invalid listId $listId');
      return null;
    }

    if (await _cache.exists(listId)) {
      return _cache.get(listId, CustomList.fromJson);
    }

    final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.modifyList.replaceFirst('{id}', listId));

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final result = CustomList.fromJson(body['data']);

      // Cache the result
      return _cache.put(listId, json.encode(result.toJson()), result, true,
          unserializer: CustomList.fromJson);
    } else if (response.statusCode == 404) {
      // List not found
      return null;
    }

    // Throw if unknown code
    throw createException("fetchListById() failed.", response);
  }

  /// Fetches logged user's [CustomList] list
  ///
  /// [offset] denotes the nth item to start fetching from.
  ///
  /// Do not use directly. Use [userListsProvider] instead
  Future<Iterable<CRef>> fetchUserList(
      {required int limit, int offset = 0}) async {
    if (!await loggedIn()) {
      throw StateError(
          "fetchUserList() called on invalid token/login. Shouldn't ever get here");
    }

    // Download missing data
    final queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
    };

    final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.userList, queryParameters: queryParams);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final result = CustomListList.fromJson(body);

      // Cache entries
      await _cache.putAllAPIResolved(result.data);

      final list = <CRef>[];

      for (final e in result.data) {
        list.add(_cache.get(e.id, CustomList.fromJson));
      }

      return list;
    }

    // Throw if failure
    throw createException("fetchUserList() failed.", response);
  }

  /// Adds/removes a [Manga] from a [CustomList]
  Future<bool> updateMangaInCustomList(CRef list, Manga manga, bool add) async {
    if (!await loggedIn()) {
      throw StateError(
          "updateMangaInCustomList() called on invalid token/login. Shouldn't ever get here");
    }

    final id = list.get<CustomList>().id;

    final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.updateMangaInList
            .replaceFirst('{id}', manga.id)
            .replaceFirst('{listId}', id));

    http.Response? response;

    if (add) {
      response = await _client.post(uri);
    } else {
      response = await _client.delete(uri);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);

      if (body['result'] == 'ok') {
        return true;
      }
    }

    // Log the failure
    logger.w(
        "updateMangaInCustomList($id, ${manga.id}, $add) returned code ${response.statusCode}",
        error: response.body);

    return false;
  }

  /// Deletes a [CustomList]
  Future<bool> deleteList(CRef list) async {
    if (!await loggedIn()) {
      throw StateError(
          "deleteList() called on invalid token/login. Shouldn't ever get here");
    }

    final id = list.get<CustomList>().id;

    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.modifyList.replaceFirst('{id}', id));

    http.Response? response;

    response = await _client.delete(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);

      if (body['result'] == 'ok') {
        // Remove the cache
        _cache.remove(id);
        return true;
      }
    }

    // Log the failure
    logger.w("deleteList($id) returned code ${response.statusCode}",
        error: response.body);

    return false;
  }

  /// Creates a new [CustomList]
  Future<CRef?> createNewList(String name, CustomListVisibility visibility,
      Iterable<String> mangaIds) async {
    if (!await loggedIn()) {
      throw StateError(
          "createNewList() called on invalid token/login. Shouldn't ever get here");
    }

    final uri =
        MangaDexEndpoints.api.replace(path: MangaDexEndpoints.createList);

    final params = {
      'name': name,
      'visibility': visibility.name,
      'manga': mangaIds.toList(),
    };

    final response = await _client.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(params));

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final Map<String, dynamic> body = json.decode(response.body);

      if (body['result'] == 'ok') {
        // Process new list
        final nlist = CustomList.fromJson(body['data']);

        // Cache the result
        return _cache.put(nlist.id, json.encode(nlist.toJson()), nlist, true,
            unserializer: CustomList.fromJson);
      }
    }

    // Log the failure
    logger.w(
        "createNewList($name, ${visibility.name}) returned code ${response.statusCode}",
        error: response.body);

    return null;
  }

  /// Creates a new [CustomList]
  Future<CRef> editList(CRef list, String name, CustomListVisibility visibility,
      Iterable<String> mangaIds) async {
    if (!await loggedIn()) {
      throw StateError(
          "editList() called on invalid token/login. Shouldn't ever get here");
    }

    final id = list.get<CustomList>().id;

    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.modifyList.replaceFirst('{id}', id));

    final params = {
      'name': name,
      'visibility': visibility.name,
      'manga': mangaIds.toList(),
      'version': list.get<CustomList>().attributes.version,
    };

    final response = await _client.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(params),
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final Map<String, dynamic> body = json.decode(response.body);

      if (body['result'] == 'ok') {
        // Process new list
        final nlist = CustomList.fromJson(body['data']);

        // Cache the result
        return _cache.put(nlist.id, json.encode(nlist.toJson()), nlist, true,
            unserializer: CustomList.fromJson);
      }
    }

    // Throw if failure
    throw createException(
        "editList($id, ${visibility.name}) failed.", response);
  }

  /// Get logged in user details
  Future<User> getLoggedUser() async {
    if (!await loggedIn()) {
      throw StateError(
          "getLoggedUser() called on invalid token/login. Shouldn't ever get here");
    }

    final uri = MangaDexEndpoints.api.replace(path: MangaDexEndpoints.me);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

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

@riverpod
class LatestChaptersFeed extends _$LatestChaptersFeed {
  int _offset = 0;
  bool _atEnd = false;
  static const feedKey = 'LatestChaptersFeed';
  static const limit = MangaDexEndpoints.searchLimit;

  ///Fetch the latest chapters list based on offset
  Future<List<Chapter>> _fetchLatestChapters(int offset) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return [];
    }

    final api = ref.watch(mangadexProvider);
    final chapters = await api.fetchFeed(
      path: MangaDexEndpoints.feed,
      feedKey: feedKey,
      limit: limit,
      offset: offset,
    );

    return chapters.toList();
  }

  @override
  Future<List<Chapter>> build() async {
    return _fetchLatestChapters(0);
  }

  /// Fetch more latest chapters if more data exists
  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = await future;
    // If there is more content, get more
    if (oldstate.length == _offset + limit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final chapters = await _fetchLatestChapters(_offset + limit);
        _offset += limit;

        if (chapters.isEmpty) {
          _atEnd = true;
        }

        return [...oldstate, ...chapters];
      });
    } else {
      // Otherwise, do nothing because there is no more content
      _atEnd = true;
    }
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    final api = ref.watch(mangadexProvider);
    await api.invalidateAll(feedKey);
    _offset = 0;
    _atEnd = false;
    ref.invalidateSelf();
  }
}

@riverpod
class LatestGlobalFeed extends _$LatestGlobalFeed {
  int _offset = 0;
  bool _atEnd = false;
  static const feedKey = 'LatestGlobalFeed';
  static const limit = MangaDexEndpoints.searchLimit;

  ///Fetch the latest chapters list based on offset
  Future<List<Chapter>> _fetchLatestChapters(int offset) async {
    final api = ref.watch(mangadexProvider);
    final chapters = await api.fetchFeed(
      path: MangaDexEndpoints.chapter,
      feedKey: feedKey,
      limit: limit,
      offset: offset,
    );

    return chapters.toList();
  }

  @override
  Future<List<Chapter>> build() async {
    return _fetchLatestChapters(0);
  }

  /// Fetch more latest chapters if more data exists
  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = await future;
    // If there is more content, get more
    if (oldstate.length == _offset + limit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final chapters = await _fetchLatestChapters(_offset + limit);
        _offset += limit;

        if (chapters.isEmpty) {
          _atEnd = true;
        }

        return [...oldstate, ...chapters];
      });
    } else {
      // Otherwise, do nothing because there is no more content
      _atEnd = true;
    }
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    final api = ref.watch(mangadexProvider);
    await api.invalidateAll(feedKey);
    _offset = 0;
    _atEnd = false;
    ref.invalidateSelf();
  }
}

@riverpod
class GroupFeed extends _$GroupFeed with AutoDisposeExpiryMix {
  int _offset = 0;
  bool _atEnd = false;
  static const feedKey = 'GroupFeed';
  static const limit = MangaDexEndpoints.searchLimit;

  Future<List<Chapter>> _fetchChapters(int offset) async {
    final api = ref.watch(mangadexProvider);
    final chapters = await api.fetchFeed(
      path: MangaDexEndpoints.chapter,
      feedKey: feedKey,
      limit: limit,
      offset: offset,
      entity: group,
    );

    disposeAfter(const Duration(minutes: 5));

    return chapters.toList();
  }

  @override
  Future<List<Chapter>> build(Group group) async {
    return _fetchChapters(0);
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = await future;
    // If there is more content, get more
    if (oldstate.length == _offset + limit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final chapters = await _fetchChapters(_offset + limit);
        _offset += limit;

        if (chapters.isEmpty) {
          _atEnd = true;
        }

        return [...oldstate, ...chapters];
      });
    } else {
      // Otherwise, do nothing because there is no more content
      _atEnd = true;
    }
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    final api = ref.watch(mangadexProvider);
    await api.invalidateAll('$feedKey(${group.id}');
    _offset = 0;
    _atEnd = false;
    ref.invalidateSelf();
  }
}

@riverpod
class GroupTitles extends _$GroupTitles {
  int _offset = 0;
  bool _atEnd = false;
  static const limit = MangaDexEndpoints.searchLimit;

  Future<List<Manga>> _fetchManga(int offset) async {
    final api = ref.watch(mangadexProvider);
    final manga =
        await api.fetchManga(limit: limit, offset: offset, filterId: group);

    return manga;
  }

  @override
  Future<List<Manga>> build(Group group) async {
    return _fetchManga(0);
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = await future;
    // If there is more content, get more
    if (oldstate.length == _offset + limit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final manga = await _fetchManga(_offset + limit);
        _offset += limit;

        if (manga.isEmpty) {
          _atEnd = true;
        }

        return [...oldstate, ...manga];
      });
    } else {
      // Otherwise, do nothing because there is no more content
      _atEnd = true;
    }
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    _offset = 0;
    _atEnd = false;
    ref.invalidateSelf();
  }
}

@riverpod
class CreatorTitles extends _$CreatorTitles {
  int _offset = 0;
  bool _atEnd = false;
  static const limit = MangaDexEndpoints.searchLimit;

  Future<List<Manga>> _fetchManga(int offset) async {
    final api = ref.watch(mangadexProvider);
    final manga =
        await api.fetchManga(limit: limit, offset: offset, filterId: creator);

    return manga;
  }

  @override
  Future<List<Manga>> build(CreatorType creator) async {
    return _fetchManga(0);
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = await future;
    // If there is more content, get more
    if (oldstate.length == _offset + limit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final manga = await _fetchManga(_offset + limit);
        _offset += limit;

        if (manga.isEmpty) {
          _atEnd = true;
        }

        return [...oldstate, ...manga];
      });
    } else {
      // Otherwise, do nothing because there is no more content
      _atEnd = true;
    }
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    _offset = 0;
    _atEnd = false;
    ref.invalidateSelf();
  }
}

final mangaChaptersListSortProvider =
    StateProvider((ref) => ListSort.descending);

@riverpod
class MangaChapters extends _$MangaChapters with AutoDisposeExpiryMix {
  int _offset = 0;
  bool _atEnd = false;
  static const feedKey = 'MangaChapters';
  static const limit = MangaDexEndpoints.chapterLimit;

  Future<List<Chapter>> _fetchMangaChapters(int offset) async {
    final api = ref.watch(mangadexProvider);
    final sort = ref.watch(mangaChaptersListSortProvider);
    final chapters = await api.fetchFeed(
      path: MangaDexEndpoints.mangaFeed.replaceFirst('{id}', manga.id),
      feedKey: feedKey,
      limit: limit,
      offset: offset,
      entity: manga,
      orderKey: 'chapter',
      order: sort.order,
    );

    disposeAfter(const Duration(minutes: 5));

    return chapters.toList();
  }

  @override
  Future<List<Chapter>> build(Manga manga) async {
    return _fetchMangaChapters(0);
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = await future;
    // If there is more content, get more
    if (oldstate.length == _offset + limit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final chapters = await _fetchMangaChapters(_offset + limit);
        _offset += limit;

        if (chapters.isEmpty) {
          _atEnd = true;
        }

        return [...oldstate, ...chapters];
      });
    } else {
      // Otherwise, do nothing because there is no more content
      _atEnd = true;
    }
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    final api = ref.watch(mangadexProvider);
    await api.invalidateAll('$feedKey(${manga.id}');
    _offset = 0;
    _atEnd = false;
    ref.invalidateSelf();
  }
}

@riverpod
class MangaCovers extends _$MangaCovers with AutoDisposeExpiryMix {
  int _offset = 0;
  bool _atEnd = false;
  static const limit = MangaDexEndpoints.searchLimit;

  Future<List<CoverArt>> _fetchCovers(int offset) async {
    final api = ref.watch(mangadexProvider);
    final covers = await api.getCoverList(manga, limit: limit, offset: offset);

    disposeAfter(const Duration(minutes: 5));

    return covers.toList();
  }

  @override
  Future<List<CoverArt>> build(Manga manga) async {
    return _fetchCovers(0);
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = await future;
    // If there is more content, get more
    if (oldstate.length == _offset + limit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final covers = await _fetchCovers(_offset + limit);
        _offset += limit;

        if (covers.isEmpty) {
          _atEnd = true;
        }

        return [...oldstate, ...covers];
      });
    } else {
      // Otherwise, do nothing because there is no more content
      _atEnd = true;
    }
  }

  Future<void> clear() async {
    final api = ref.watch(mangadexProvider);
    await api.invalidateAll('CoverList(${manga.id}');
    _offset = 0;
    _atEnd = false;
    ref.invalidateSelf();
  }
}

@Riverpod(keepAlive: true)
class ReadChapters extends _$ReadChapters {
  Future<ReadChaptersMap> _fetchReadChapters(Iterable<Manga> mangas) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return {};
    }

    final api = ref.watch(mangadexProvider);
    final map = await api.fetchReadChapters(mangas);
    return map;
  }

  @override
  Future<ReadChaptersMap> build() async {
    return {};
  }

  /// Fetch read chapters for the provided list of mangas
  Future<void> get(Iterable<Manga> mangas) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return;
    }

    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final mg = mangas.where((m) =>
          !oldstate.containsKey(m.id) || oldstate[m.id]?.isExpired() == true);
      final map = await _fetchReadChapters(mg);
      return {...oldstate, ...map};
    });
  }

  /// Sets a list of chapters for a manga read or unread
  Future<void> set(
    Manga manga, {
    Iterable<Chapter>? read,
    Iterable<Chapter>? unread,
  }) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return;
    }

    final api = ref.watch(mangadexProvider);
    final oldstate = await future;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      bool result =
          await api.setChaptersRead(manga, read: read, unread: unread);

      if (result) {
        final keyExists = oldstate.containsKey(manga.id);

        // Refresh
        if (keyExists) {
          if (read != null) {
            oldstate[manga.id]?.addAll(read.map((e) => e.id));
          }

          if (unread != null) {
            oldstate[manga.id]?.removeAll(unread.map((e) => e.id));
          }
        } else {
          if (read != null) {
            oldstate[manga.id] =
                ReadChapterSet(manga.id, read.map((e) => e.id).toSet());
          }

          if (unread != null) {
            oldstate[manga.id] = ReadChapterSet(manga.id, {});
          }
        }
      }

      return {...oldstate};
    });
  }
}

@riverpod
class UserLibrary extends _$UserLibrary with AutoDisposeExpiryMix {
  @override
  Future<Map<String, MangaReadingStatus>> build() async {
    final loggedin = await ref.watch(authControlProvider.future);
    if (!loggedin) {
      return {};
    }

    final api = ref.watch(mangadexProvider);
    final library = await api.fetchUserLibrary();

    if (library == null) {
      return {};
    }

    disposeAfter(const Duration(minutes: 5));

    return library;
  }

  Future<void> set(Manga manga, MangaReadingStatus? status) async {
    final oldstate = await future;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (status == null) {
        oldstate.remove(manga.id);
      } else {
        oldstate[manga.id] = status;
      }

      return {...oldstate};
    });
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    final api = ref.watch(mangadexProvider);
    await api.invalidateCacheItem(CacheLists.library);

    ref.invalidateSelf();
  }
}

@riverpod
class UserLists extends _$UserLists with AutoDisposeExpiryMix {
  int _offset = 0;
  bool _atEnd = false;
  static const limit = MangaDexEndpoints.breakLimit;

  Future<List<CRef>> _fetch(int offset) async {
    final loggedin = await ref.watch(authControlProvider.future);
    if (!loggedin) {
      return [];
    }

    final api = ref.watch(mangadexProvider);
    final lists = await api.fetchUserList(limit: limit, offset: offset);

    disposeAfter(const Duration(minutes: 5));

    return lists.toList();
  }

  @override
  Future<List<CRef>> build() async {
    return _fetch(0);
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = await future;
    // If there is more content, get more
    if (oldstate.length == _offset + limit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final lists = await _fetch(_offset + limit);
        _offset += limit;

        if (lists.isEmpty) {
          _atEnd = true;
        }

        return [...oldstate, ...lists];
      });
    } else {
      // Otherwise, do nothing because there is no more content
      _atEnd = true;
    }
  }

  Future<void> updateList(CRef list, Manga manga, bool add) async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    final api = ref.watch(mangadexProvider);

    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await api.updateMangaInCustomList(list, manga, add);

      if (result) {
        if (add) {
          list.get<CustomList>().add(manga.id);
        } else {
          list.get<CustomList>().remove(manga.id);
        }
      }

      return [...oldstate];
    });
  }

  Future<bool> editList(CRef list, String name, CustomListVisibility visibility,
      Iterable<String> mangaIds) async {
    if (state.isLoading || state.isReloading) {
      return false;
    }

    final api = ref.watch(mangadexProvider);

    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // Should theoretically return the same ref so don't care about
      // the result
      final result = await api.editList(list, name, visibility, mangaIds);

      logger.d("state contains edited list?: ${oldstate.contains(result)}");

      return [...oldstate];
    });

    return !state.hasError;
  }

  Future<bool> deleteList(CRef list) async {
    if (state.isLoading || state.isReloading) {
      return false;
    }

    final api = ref.watch(mangadexProvider);

    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      Iterable<CRef> set = oldstate;

      final result = await api.deleteList(list);

      if (result) {
        set = oldstate.where((element) =>
            element.get<CustomList>().id != list.get<CustomList>().id);
      }

      return [...set];
    });

    return (state.value ?? []).length != oldstate.length;
  }

  Future<bool> newList(String name, CustomListVisibility visibility,
      Iterable<String> mangaIds) async {
    if (state.isLoading || state.isReloading) {
      return false;
    }

    final api = ref.watch(mangadexProvider);

    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await api.createNewList(name, visibility, mangaIds);

      if (result != null) {
        return [...oldstate, result];
      }

      return [...oldstate];
    });

    return (state.value ?? []).length != oldstate.length;
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    _offset = 0;
    _atEnd = false;
    ref.invalidateSelf();
  }
}

@riverpod
class CustomListFeed extends _$CustomListFeed with AutoDisposeExpiryMix {
  int _offset = 0;
  bool _atEnd = false;
  static const feedKey = 'CustomListFeed';
  static const limit = MangaDexEndpoints.searchLimit;

  Future<List<Chapter>> _fetchChapters(int offset) async {
    final api = ref.watch(mangadexProvider);
    final chapters = await api.fetchFeed(
      path: MangaDexEndpoints.listFeed.replaceFirst('{id}', list.id),
      feedKey: feedKey,
      limit: limit,
      offset: offset,
      entity: list,
    );

    disposeAfter(const Duration(minutes: 5));

    return chapters.toList();
  }

  @override
  Future<List<Chapter>> build(CustomList list) async {
    return _fetchChapters(0);
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = await future;
    // If there is more content, get more
    if (oldstate.length == _offset + limit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final chapters = await _fetchChapters(_offset + limit);
        _offset += limit;

        if (chapters.isEmpty) {
          _atEnd = true;
        }

        return [...oldstate, ...chapters];
      });
    } else {
      // Otherwise, do nothing because there is no more content
      _atEnd = true;
    }
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    final api = ref.watch(mangadexProvider);
    await api.invalidateAll('$feedKey(${list.id}');
    _offset = 0;
    _atEnd = false;
    ref.invalidateSelf();
  }
}

@riverpod
Future<List<Manga>> getMangaListByPage(
    GetMangaListByPageRef ref, Iterable<String> list, int page) async {
  final start = page * MangaDexEndpoints.searchLimit;
  final end = min((page + 1) * MangaDexEndpoints.searchLimit, list.length);

  final range = list.toList().getRange(start, end);

  final api = ref.watch(mangadexProvider);
  final mangas =
      await api.fetchManga(limit: MangaDexEndpoints.searchLimit, ids: range);

  await ref.watch(statisticsProvider.notifier).get(mangas);

  return mangas;
}

@riverpod
class ListById extends _$ListById {
  @override
  Future<CRef?> build(String listId) async {
    final api = ref.watch(mangadexProvider);
    final list = await api.fetchListById(listId);
    return list;
  }
}

@riverpod
class TagList extends _$TagList with AutoDisposeExpiryMix {
  ///Fetch the global tag list
  @override
  Future<Iterable<Tag>> build() async {
    final api = ref.watch(mangadexProvider);

    final list = await api.getTagList();

    disposeAfter(const Duration(minutes: 5));

    return list;
  }
}

@riverpod
class MangaSearch extends _$MangaSearch {
  int _offset = 0;
  bool _atEnd = false;
  static const limit = MangaDexEndpoints.searchLimit;

  Future<List<Manga>> _searchManga() async {
    final api = ref.watch(mangadexProvider);

    final manga = await api.searchManga(params.query,
        limit: limit, filter: params.filter, offset: _offset);

    if (manga.isNotEmpty) {
      await ref.read(statisticsProvider.notifier).get(manga);
    }

    return manga;
  }

  @override
  Future<List<Manga>> build(MangaSearchParameters params) async {
    return _searchManga();
  }

  bool isAtEnd() {
    return _atEnd;
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = await future;
    // If there is more content, get more
    if (oldstate.length == _offset + limit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        _offset += limit;
        final list = await _searchManga();

        if (list.isEmpty) {
          _atEnd = true;
        }

        return [...oldstate, ...list];
      });
    } else {
      // Otherwise, do nothing because there is no more content
      _atEnd = true;
    }
  }
}

@Riverpod(keepAlive: true)
class Statistics extends _$Statistics {
  Future<Map<String, MangaStatistics>> _fetchStatistics(
      Iterable<Manga> mangas) async {
    final api = ref.watch(mangadexProvider);
    final map = await api.fetchStatistics(mangas);

    return map;
  }

  @override
  Future<Map<String, MangaStatistics>> build() async {
    return {};
  }

  /// Fetch statistics for the provided list of mangas
  Future<void> get(Iterable<Manga> mangas) async {
    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final mg = mangas.where((m) => !oldstate.containsKey(m.id));
      final map = await _fetchStatistics(mg);
      return {...oldstate, ...map};
    });
  }
}

// For redundancy
@riverpod
class MangaStats extends _$MangaStats {
  Future<MangaStatistics> _fetchStatistics() async {
    await ref.watch(statisticsProvider.notifier).get([manga]);
    final stats = await ref.watch(statisticsProvider.future);

    if (stats.containsKey(manga.id)) {
      return stats[manga.id]!;
    }

    throw Exception("Missing stats for manga id ${manga.id}");
  }

  @override
  Future<MangaStatistics> build(Manga manga) async {
    return _fetchStatistics();
  }
}

@Riverpod(keepAlive: true)
class Ratings extends _$Ratings {
  Future<Map<String, SelfRating>> _fetchRatings(Iterable<Manga> mangas) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return {};
    }

    final api = ref.watch(mangadexProvider);
    final map = await api.fetchRatings(mangas);
    return map;
  }

  @override
  Future<Map<String, SelfRating>> build() async {
    return {};
  }

  /// Fetch user's self-ratings for the provided list of mangas
  Future<void> get(Iterable<Manga> mangas) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return;
    }

    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final mg = mangas.where((m) =>
          !oldstate.containsKey(m.id) || oldstate[m.id]?.isExpired() == true);
      final map = await _fetchRatings(mg);
      return {...oldstate, ...map};
    });
  }

  /// Sets a self-rating for a manga
  Future<void> set(Manga manga, int? rating) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return;
    }

    final api = ref.watch(mangadexProvider);
    final oldstate = await future;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      bool result = await api.setMangaRating(manga, rating);

      if (result) {
        switch (rating) {
          case null:
            oldstate[manga.id] =
                SelfRating(rating: -1, createdAt: DateTime.now());
            break;
          case _:
            oldstate[manga.id] =
                SelfRating(rating: rating, createdAt: DateTime.now());
            break;
        }
      }

      return {...oldstate};
    });
  }
}

@riverpod
class ReadingStatus extends _$ReadingStatus with AutoDisposeExpiryMix {
  @override
  Future<MangaReadingStatus?> build(Manga manga) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return null;
    }

    final api = ref.watch(mangadexProvider);
    final status = await api.getMangaReadingStatus(manga);

    disposeAfter(const Duration(minutes: 5));

    return status;
  }

  Future<void> set(MangaReadingStatus? status) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return;
    }

    final api = ref.watch(mangadexProvider);
    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      MangaReadingStatus? resolved =
          status == MangaReadingStatus.remove ? null : status;
      bool success = await api.setMangaReadingStatus(manga, resolved);
      if (success) {
        if (ref.exists(userLibraryProvider)) {
          await ref.read(userLibraryProvider.notifier).set(manga, resolved);
        }

        return resolved;
      }

      return oldstate;
    });
  }
}

@riverpod
class FollowingStatus extends _$FollowingStatus with AutoDisposeExpiryMix {
  @override
  Future<bool> build(Manga manga) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return false;
    }

    final api = ref.watch(mangadexProvider);
    final status = await api.getMangaFollowing(manga);

    disposeAfter(const Duration(minutes: 5));

    return status;
  }

  Future<void> set(bool following) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return;
    }

    final api = ref.watch(mangadexProvider);
    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      bool success = await api.setMangaFollowing(manga, following);
      if (success) {
        return following;
      }

      return oldstate;
    });
  }
}

@Riverpod(keepAlive: true)
class MangaDexHistory extends _$MangaDexHistory {
  static const _numItems = 50;

  @override
  Future<Queue<Chapter>> build() async {
    final box = Hive.box(gagakuBox);
    final str = box.get('mangadex_history');

    if (str == null || (str as String).isEmpty) {
      return Queue<Chapter>();
    }

    final api = ref.watch(mangadexProvider);
    final content = json.decode(str) as List<dynamic>;
    final uuids = List<String>.from(content);

    final chapters = await api.fetchChapters(uuids);

    return Queue.of(chapters);
  }

  Future<void> add(Chapter chapter) async {
    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final cpy = Queue.of(oldstate);

      while (cpy.contains(chapter)) {
        cpy.remove(chapter);
      }

      cpy.addFirst(chapter);

      while (cpy.length > _numItems) {
        cpy.removeLast();
      }

      final uuids = cpy.map((e) => e.id).toList();

      final box = Hive.box(gagakuBox);
      await box.put('mangadex_history', json.encode(uuids));

      return cpy;
    });
  }
}

@Riverpod(keepAlive: true)
class LoggedUser extends _$LoggedUser {
  @override
  Future<User?> build() async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return null;
    }

    final api = ref.watch(mangadexProvider);
    final user = await api.getLoggedUser();

    return user;
  }
}

@Riverpod(keepAlive: true)
class AuthControl extends _$AuthControl with AutoDisposeExpiryMix {
  Future<void> invalidate() async {
    final prevState = await future;

    final refreshed = await build();

    if (refreshed != prevState) {
      state = await AsyncValue.guard(() async {
        return refreshed;
      });
    }
  }

  Future<void> _setStaleTime() async {
    final api = ref.watch(mangadexProvider);

    cancelStaleTime();

    final expireTime = await api.timeUntilTokenExpiry();

    if (expireTime != null) {
      logger.d(
          "AuthControl: setting stale time to ${expireTime.inSeconds} seconds");
      staleTime(expireTime);
    }
  }

  @override
  Future<bool> build() async {
    final api = ref.watch(mangadexProvider);
    await api.future;

    if (await api.tokenExpired()) {
      logger.i("MangaDex token has expired. Refreshing...");
      await api.refreshToken();
    }

    await _setStaleTime();

    return api.loggedIn();
  }

  Future<bool> login(
      String user, String pass, String clientId, String clientSecret) async {
    final api = ref.watch(mangadexProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await api.authenticate(user, pass, clientId, clientSecret);
      await _setStaleTime();
      ref.invalidate(loggedUserProvider);
      return await api.loggedIn();
    });

    return await api.loggedIn();
  }

  Future<void> logout() async {
    final api = ref.watch(mangadexProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await api.logout();
      await _setStaleTime();
      return await api.loggedIn();
    });

    // Invalidate stuff
    ref.invalidate(loggedUserProvider);
    ref.invalidate(userLibraryProvider);
    await api.invalidateCacheItem(CacheLists.library);
    ref.invalidate(readChaptersProvider);
    ref.invalidate(ratingsProvider);
    ref.invalidate(userListsProvider);
    ref.invalidate(readingStatusProvider);
    ref.invalidate(followingStatusProvider);
    ref.invalidate(latestChaptersFeedProvider);
    await api.invalidateAll(LatestChaptersFeed.feedKey);
  }
}

class RateLimitedClient extends http.BaseClient {
  final http.Client baseClient = http.Client();
  final userAgent = PackageInfo.fromPlatform()
      .then((info) => '${info.appName}/${info.version}');
  final _mutex = Mutex();

  RateLimitedClient();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    return await _mutex.protect(() async {
      request.headers[HttpHeaders.userAgentHeader] = await userAgent;
      return baseClient.send(request);
    });
  }
}
