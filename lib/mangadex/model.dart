import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/cache.dart';
import 'package:gagaku/mangadex/config.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/util.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mutex/mutex.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'model.g.dart';

abstract class MangaDexEndpoints {
  static final api = Uri.https('api.mangadex.org', '');

  static const apiQueryLimit = 50;
  static const apiSearchLimit = 10;

  // For future OAuth
  static final provider =
      Uri.parse('https://auth.mangadex.org/realms/mangadex');
  static const login = '/auth/login';
  static const logout = '/auth/logout';
  static const refresh = '/auth/refresh';

  /// App Client ID
  /// TODO change this when client ID reg becomes available
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
}

abstract class CacheLists {
  static const latestChapters = 'latestChapters';
  static const latestGlobalChapters = 'latestGlobalChapters';
  static const library = 'userLibrary';
  static const tags = 'tags';
}

@Riverpod(keepAlive: true)
MangaDexModel mangadex(MangadexRef ref) {
  return MangaDexModel(ref);
}

class MangaDexModel {
  MangaDexModel(this.ref) {
    _future = refreshToken();
  }

  final Ref ref;
  //TokenResponse? _token;
  OldToken? _token;
  final _tokenMutex = ReadWriteMutex();
  http.Client _client = RateLimitedClient();
  late Future _future;
  Future get future => _future;

  final CacheManager _cache = CacheManager();

  // void _urlLauncher(String url) async {
  //   var uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri) || Platform.isAndroid) {
  //     await launchUrl(uri);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // bool _tokenExpired(TokenResponse token) {
  //   return token.expiresAt != null
  //       ? (DateTime.now().difference(token.expiresAt!).inMinutes > -5)
  //       : false;
  // }

  Future<Duration?> timeUntilTokenExpiry() async {
    return await _tokenMutex.protectRead(() async {
      if (_token == null) {
        return null;
      }

      return _token!.timeUntilExpiry;
    });
  }

  Future<bool> tokenExpired() async {
    return await _tokenMutex.protectRead(() async {
      if (_token == null) {
        return false;
      }

      return _token!.expired;
    });
  }

  Future<bool> loggedIn() async {
    return await _tokenMutex.protectRead(() async {
      return (_token != null && _client is AuthenticatedClient);
    });
  }

  // Future<void> refreshToken() async {
  //   const storage = FlutterSecureStorage();
  //   bool accessTokenSaved = await storage.read(key: 'accessToken') != null;

  //   if (accessTokenSaved) {
  //     final tt = await storage.read(key: 'tokenType');
  //     final rt = await storage.read(key: 'refreshToken');
  //     final it = await storage.read(key: 'idToken');

  //     var issuer = await Issuer.discover(MangaDexEndpoints.provider);
  //     var client = Client(issuer, MangaDexEndpoints.clientId);

  //     var credential = client.createCredential(
  //       accessToken: null, // force use refresh to get new token
  //       tokenType: tt,
  //       refreshToken: rt,
  //       idToken: it,
  //     );

  //     credential.validateToken(validateClaims: true, validateExpiry: true);

  //     try {
  //       final token = await credential.getTokenResponse();
  //       _saveToken(token);

  //       _token = token;
  //       _client = credential.createHttpClient();
  //     } catch (e) {
  //       print("Error during token refresh: ${e.toString()}");
  //     }
  //   }
  // }

  Future<void> refreshToken() async {
    await _tokenMutex.protectWrite(() async {
      // Clear old data
      _token = null;

      final storage = Hive.box(gagakuBox);
      String? strken = await storage.get('oldtoken') as String?;

      if (strken != null) {
        final jstr = json.decode(strken);
        OldToken token = OldToken.fromJson(jstr);

        if (token.isValid) {
          Map<String, String> payload = {'token': token.refresh};

          final response = await http.post(
              MangaDexEndpoints.api.replace(path: MangaDexEndpoints.refresh),
              headers: {'Content-Type': 'application/json'},
              body: json.encode(payload));

          if (response.statusCode == 200) {
            Map<String, dynamic> body = json.decode(response.body);

            if (body['result'] == 'ok') {
              OldToken t = OldToken.fromJson(body['token']);

              if (t.isValid) {
                await _saveToken(t);
                _token = t;
                _client = AuthenticatedClient(RateLimitedClient(), t);
                logger.i("refreshToken(): MangaDex token refreshed");
                return;
              }
            }
          }

          logger.w("refreshToken() returned code ${response.statusCode}",
              error: response.body);
        }
      }

      // If any steps fail, assign a default client
      _client = RateLimitedClient();
    });
  }

  // Future<void> authenticate() async {
  //   var issuer = await Issuer.discover(MangaDexEndpoints.provider);
  //   var client = Client(issuer, MangaDexEndpoints.clientId);

  //   var authenticator = Authenticator(
  //     client,
  //     scopes: ['openid', 'profile'],
  //     //redirectUri: Uri.parse('https://localhost/'),
  //     port: 3000,
  //     urlLancher: _urlLauncher,
  //   );

  //   var credential = await authenticator.authorize();

  //   if (Platform.isAndroid || Platform.isIOS) {
  //     closeInAppWebView();
  //   }

  //   final token = await credential.getTokenResponse();
  //   _saveToken(token);

  //   _token = token;
  //   _client = credential.createHttpClient();
  // }

  Future<void> authenticate(String user, String pass) async {
    Map<String, String> payload = {'username': user, 'password': pass};

    final response = await http.post(
        MangaDexEndpoints.api.replace(path: MangaDexEndpoints.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      if (body['result'] == 'ok') {
        OldToken t = OldToken.fromJson(body['token']);

        if (t.isValid) {
          return await _tokenMutex.protectWrite(() async {
            await _saveToken(t);
            _token = t;
            _client = AuthenticatedClient(RateLimitedClient(), t);

            logger.i("authenticate(): MangaDex user logged in");
          });
        }
      }
    }

    logger.w("authenticate() returned code ${response.statusCode}",
        error: response.body);
  }

  // Future<void> _saveToken(TokenResponse token) async {
  //   final storage = Hive.box(gagakuBox);

  //   await storage.put('accessToken', token.accessToken);
  //   await storage.put('refreshToken', token.refreshToken);
  //   await storage.put('tokenType', token.tokenType);
  //   await storage.put(
  //       'idToken', token.idToken.toCompactSerialization());
  // }

  Future<void> _saveToken(OldToken token) async {
    final storage = Hive.box(gagakuBox);
    await storage.put('oldtoken', json.encode(token.toJson()));
  }

  // Future<void> logout() async {
  //   _token = null;
  //   _client = null;

  //   final storage = Hive.box(gagakuBox);
  //   await storage.delete('accessToken');
  //   await storage.delete('refreshToken');
  //   await storage.delete('tokenType');
  //   await storage.delete('idToken');
  // }

  Future<void> logout() async {
    if (await loggedIn()) {
      final response = await _client
          .post(MangaDexEndpoints.api.replace(path: MangaDexEndpoints.logout));

      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);

        if (body['result'] == 'ok') {
          return await _tokenMutex.protectWrite(() async {
            _token = null;
            _client = RateLimitedClient();

            final storage = Hive.box(gagakuBox);
            await storage.delete('oldtoken');

            logger.i("logout(): MangaDex user logged out");
          });
        }
      }

      logger.w("logout() returned code ${response.statusCode}",
          error: response.body);
    }
  }

  /// Invalidates a cache item so that it can be refreshed from the API
  ///
  /// [item] - key of the item to be invalidated
  Future<void> invalidateCacheItem(String item) async {
    if (await _cache.exists(item)) {
      await _cache.remove(item);
    }
  }

  Future<void> invalidateAll(String startsWith) async {
    await _cache.invalidateAll(startsWith);
  }

  /// Fetches the latest chapters feed of the MangaDex user
  ///
  /// Each operation that queries the MangaDex API is limited to
  /// [MangaDexEndpoints.apiQueryLimit] number of items.
  ///
  /// [offset] denotes the nth item to start fetching from.
  ///
  /// Do not use directly. The provider [latestChaptersFeedProvider] should be
  /// used instead as it provides auto state management.
  Future<Iterable<Chapter>> fetchUserFeed([int offset = 0]) async {
    if (!await loggedIn()) {
      throw Exception(
          "fetchUserFeed() called on invalid token/login. Shouldn't ever get here");
    }

    final key = 'fetchUserFeed($offset)';

    if (await _cache.exists(key)) {
      return _cache.getSpecialList<Chapter>(key, Chapter.fromJson);
    }

    final settings = ref.read(mdConfigProvider);

    // Download missing data
    final queryParams = {
      'limit': MangaDexEndpoints.apiQueryLimit.toString(),
      'offset': offset.toString(),
      'translatedLanguage[]': settings.translatedLanguages
          .map(const LanguageConverter().toJson)
          .toList(),
      'originalLanguage[]': settings.originalLanguage
          .map(const LanguageConverter().toJson)
          .toList(),
      'includeFutureUpdates': '0',
      'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
      'order[publishAt]': 'desc',
      'includes[]': ['scanlation_group', 'user']
    };

    if (settings.groupBlacklist.isNotEmpty) {
      queryParams['excludedGroups[]'] = settings.groupBlacklist.toList();
    }

    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.feed, queryParameters: queryParams);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final result = ChapterList.fromJson(body);

      // Cache the data and list
      _cache.putSpecialList(key, result.data, resolve: true);

      return result.data;
    }

    // Throw if failure
    final msg = "fetchUserFeed() failed. Response code: ${response.statusCode}";
    logger.e(msg, error: response.body);
    throw Exception(msg);
  }

  /// Fetches the chapter feed based on the given parameters
  ///
  /// Each operation that queries the MangaDex API is limited to
  /// [MangaDexEndpoints.apiQueryLimit] number of items.
  ///
  /// [offset] denotes the nth item to start fetching from.
  ///
  /// [group] specifies a specific scanlation group to retrieve the feed for.
  /// Regular options apply.
  ///
  /// Do not use directly. The provider [latestGlobalFeedProvider] should be
  /// used instead as it provides auto state management.
  Future<Iterable<Chapter>> fetchChapterFeed(
      {int offset = 0, Group? group}) async {
    final settings = ref.read(mdConfigProvider);

    final key = 'fetchChapterFeed(${group?.id},$offset)';

    if (await _cache.exists(key)) {
      return _cache.getSpecialList<Chapter>(key, Chapter.fromJson);
    }

    // Download missing data
    final queryParams = {
      'limit': MangaDexEndpoints.apiQueryLimit.toString(),
      'offset': offset.toString(),
      'translatedLanguage[]': settings.translatedLanguages
          .map(const LanguageConverter().toJson)
          .toList(),
      'originalLanguage[]': settings.originalLanguage
          .map(const LanguageConverter().toJson)
          .toList(),
      'includeFutureUpdates': '0',
      'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
      'order[publishAt]': 'desc',
      'includes[]': ['scanlation_group', 'user']
    };

    if (group != null) {
      queryParams['groups[]'] = group.id;
    } else if (settings.groupBlacklist.isNotEmpty) {
      queryParams['excludedGroups[]'] = settings.groupBlacklist.toList();
    }

    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.chapter, queryParameters: queryParams);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final result = ChapterList.fromJson(body);

      // Cache the data and list
      _cache.putSpecialList(key, result.data, resolve: true);

      return result.data;
    }

    // Throw if failure
    final msg =
        "fetchChapterFeed() failed. Response code: ${response.statusCode}";
    logger.e(msg, error: response.body);
    throw Exception(msg);
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
        'limit': MangaDexEndpoints.apiQueryLimit.toString(),
        'includeFutureUpdates': '0',
        //'order[publishAt]': 'desc',
        'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
        'includes[]': ['scanlation_group', 'user']
      };

      while (end < fetch.length) {
        start = end;
        end += min(fetch.length - start, MangaDexEndpoints.apiQueryLimit);

        queryParams['ids[]'] = fetch.getRange(start, end);

        final uri = MangaDexEndpoints.api.replace(
            path: MangaDexEndpoints.chapter, queryParameters: queryParams);

        final response = await _client.get(uri);

        if (response.statusCode == 200) {
          final Map<String, dynamic> body = json.decode(response.body);

          final result = ChapterList.fromJson(body);

          // Cache the data
          _cache.putAllAPIResolved(result.data);
        } else {
          // Throw if failure
          final msg =
              "fetchChapters() failed. Response code: ${response.statusCode}";
          logger.e(msg, error: response.body);
          throw Exception(msg);
        }
      }
    }

    // Craft the list
    for (final id in uuids) {
      if (await _cache.exists(id)) {
        list.add(_cache.get<Chapter>(id, Chapter.fromJson));
      }
    }

    return list;
  }

  /// Fetches a list of manga data given the query parameters
  Future<Iterable<Manga>> fetchManga(
      {Iterable<String>? ids, MangaDexUUID? filterId, int offset = 0}) async {
    final settings = ref.read(mdConfigProvider);

    final queryParams = {
      'limit': MangaDexEndpoints.apiQueryLimit.toString(),
      'order[latestUploadedChapter]': 'desc',
      'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
      'includes[]': ['cover_art', 'author', 'artist']
    };

    Set<Manga> list = <Manga>{};

    if (ids != null) {
      final fetch =
          (await ids.whereAsync((id) async => !await _cache.exists(id)))
              .toList();

      if (fetch.isNotEmpty) {
        int start = 0, end = 0;

        while (end < fetch.length) {
          start = end;
          end += min(fetch.length - start, MangaDexEndpoints.apiQueryLimit);

          queryParams['ids[]'] = fetch.getRange(start, end);

          final uri = MangaDexEndpoints.api.replace(
              path: MangaDexEndpoints.manga, queryParameters: queryParams);

          final response = await _client.get(uri);

          if (response.statusCode == 200) {
            final Map<String, dynamic> body = json.decode(response.body);

            final mangalist = MangaList.fromJson(body);

            // Cache the data
            _cache.putAllAPIResolved(mangalist.data);
          } else {
            // Throw if failure
            final msg =
                "fetchManga(ids) failed. Response code: ${response.statusCode}";
            logger.e(msg, error: response.body);
            throw Exception(msg);
          }
        }
      }

      // Craft the list
      for (final id in ids) {
        if (await _cache.exists(id)) {
          list.add(_cache.get<Manga>(id, Manga.fromJson));
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
          const msg = "fetchManga(filterId) failed. Invalid filter type.";
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
        _cache.putAllAPIResolved(mangalist.data);

        list.addAll(mangalist.data);
      } else {
        // Throw if failure
        final msg =
            "fetchManga(filterId) failed. Response code: ${response.statusCode}";
        logger.e(msg, error: response.body);
        throw Exception(msg);
      }
    }

    return list;
  }

  /// Searches for manga using the MangaDex API with the search term [searchTerm].
  ///
  /// Each operation that queries the MangaDex API is limited to
  /// [MangaDexEndpoints.apiSearchLimit] number of items.
  ///
  /// [offset] denotes the nth item to start fetching from.
  Future<List<Manga>> searchManga(
    String searchTerm, {
    required MangaFilters filter,
    int offset = 0,
  }) async {
    final settings = ref.read(mdConfigProvider);

    Map<String, dynamic> queryParams = {
      'limit': MangaDexEndpoints.apiSearchLimit.toString(),
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
      _cache.putAllAPIResolved(mlist.data);

      return mlist.data;
    }

    // Throw if failure
    final msg = "searchManga() failed. Response code: ${response.statusCode}";
    logger.e(msg, error: response.body);
    throw Exception(msg);
  }

  /// Gets whether or not the user is following [manga]
  Future<bool> getMangaFollowing(Manga manga) async {
    if (!await loggedIn()) {
      throw Exception(
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
      throw Exception(
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
      throw Exception(
          "getMangaReadingStatus() called on invalid token/login. Shouldn't ever get here");
    }

    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.status.replaceFirst('{id}', manga.id));

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);

      if (body['result'] == 'ok') {
        MangaReadingStatus? status;

        if (body['status'] != null) {
          status = MangaReadingStatusExt.parse(body['status']);
        }

        return status;
      }
    } else if (response.statusCode == 404) {
      return null;
    }

    // Throw if failure
    final msg =
        "getMangaReadingStatus() failed. Response code: ${response.statusCode}";
    logger.e(msg, error: response.body);
    throw Exception(msg);
  }

  /// Sets the manga's reading status [status] of the [manga]
  Future<bool> setMangaReadingStatus(
      Manga manga, MangaReadingStatus? status) async {
    if (!await loggedIn()) {
      throw Exception(
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
      throw Exception(
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
        final msg =
            "fetchReadChapters() failed. Response code: ${response.statusCode}";
        logger.e(msg, error: response.body);
        throw Exception(msg);
      }
    }

    return {};
  }

  /// Fetches the latest chapters of a specific [manga]
  ///
  /// Each operation that queries the MangaDex API is limited to
  /// [MangaDexEndpoints.apiQueryLimit] number of items.
  ///
  /// [offset] denotes the nth item to start fetching from.
  ///
  /// Do not use directly. The [mangaChaptersProvider] provider should
  /// be used instead as it provides results caching and auto state
  /// management.
  Future<Iterable<Chapter>> fetchMangaChapters(Manga manga,
      [int offset = 0]) async {
    final settings = ref.read(mdConfigProvider);

    final key = 'fetchMangaChapters(${manga.id},$offset)';

    if (await _cache.exists(key)) {
      return _cache.getSpecialList<Chapter>(key, Chapter.fromJson);
    }

    // Download missing data
    final queryParams = {
      'limit': MangaDexEndpoints.apiQueryLimit.toString(),
      'offset': offset.toString(),
      'translatedLanguage[]': settings.translatedLanguages
          .map(const LanguageConverter().toJson)
          .toList(),
      'originalLanguage[]': settings.originalLanguage
          .map(const LanguageConverter().toJson)
          .toList(),
      'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
      'order[chapter]': 'desc',
      'includes[]': ['scanlation_group', 'user']
    };

    if (settings.groupBlacklist.isNotEmpty) {
      queryParams['excludedGroups[]'] = settings.groupBlacklist.toList();
    }

    final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.mangaFeed.replaceFirst('{id}', manga.id),
        queryParameters: queryParams);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final result = ChapterList.fromJson(body);

      // Cache the data
      _cache.putSpecialList(key, result.data, resolve: true);

      return result.data;
    }

    // Throw if failure
    final msg =
        "fetchMangaChapters() failed. Response code: ${response.statusCode}";
    logger.e(msg, error: response.body);
    throw Exception(msg);
  }

  /// Sets the chapter read status [setRead] of the [chapters]
  Future<bool> setChaptersRead(
      Manga manga, Iterable<Chapter> chapters, bool setRead) async {
    if (!await loggedIn()) {
      throw Exception(
          "setChaptersRead() called on invalid token/login. Shouldn't ever get here");
    }

    Map<String, dynamic> params = {};

    if (setRead) {
      params['chapterIdsRead'] = chapters.map((e) => e.id).toList();
    } else {
      params['chapterIdsUnread'] = chapters.map((e) => e.id).toList();
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
        "setChaptersRead(${manga.id}, ${chapters.toString()}, $setRead) returned code ${response.statusCode}",
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
    final msg =
        "getChapterServer() failed. Response code: ${response.statusCode}";
    logger.e(msg, error: response.body);
    throw Exception(msg);
  }

  /// Fetches the user's manga library
  Future<LibraryMap?> fetchUserLibrary() async {
    if (!await loggedIn()) {
      throw Exception(
          "fetchUserLibrary() called on invalid token/login. Shouldn't ever get here");
    }

    decoder(String key, value) =>
        MapEntry(key, MangaReadingStatusExt.parse(value));

    if (await _cache.exists(CacheLists.library)) {
      return _cache.get<LibraryMap>(CacheLists.library, (decoded) {
        return decoded.map(decoder);
      });
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

      _cache.put(CacheLists.library, mlist, true);

      return libMap;
    }

    // Throw if failure
    final msg =
        "fetchUserLibrary() failed. Response code: ${response.statusCode}";
    logger.e(msg, error: response.body);
    throw Exception(msg);
  }

  /// Retrieve all MangaDex tags
  Future<Iterable<Tag>> getTagList() async {
    if (await _cache.exists(CacheLists.tags)) {
      return _cache.getSpecialList<Tag>(CacheLists.tags, Tag.fromJson);
    }

    final uri = MangaDexEndpoints.api.replace(path: MangaDexEndpoints.tag);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final result = TagResponse.fromJson(body);

      // Cache the data and list
      _cache.putSpecialList(CacheLists.tags, result.data,
          resolve: true, expiry: const Duration(days: 7));

      return result.data;
    }

    // Throw if failure
    final msg = "getTagList() failed. Response code: ${response.statusCode}";
    logger.e(msg, error: response.body);
    throw Exception(msg);
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
        final msg =
            "fetchStatistics() failed. Response code: ${response.statusCode}";
        logger.e(msg, error: response.body);
        throw Exception(msg);
      }
    }

    return {};
  }

  /// Retrieve cover art for a specific manga
  Future<Iterable<Cover>> getCoverList(Manga manga, [int offset = 0]) async {
    final key = 'getCoverList(${manga.id},$offset)';

    if (await _cache.exists(key)) {
      return _cache.getSpecialList<Cover>(key, CoverArt.fromJson);
    }

    final queryParams = {
      'limit': MangaDexEndpoints.apiSearchLimit.toString(),
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
      _cache.putSpecialList(key, result.data, resolve: true);

      return result.data;
    }

    // Throw if failure
    final msg = "getCoverList() failed. Response code: ${response.statusCode}";
    logger.e(msg, error: response.body);
    throw Exception(msg);
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

        final resp = SelfRatingResponse.fromJson(body);

        return resp.ratings;
      } else {
        // Throw if failure
        final msg =
            "fetchRating() failed. Response code: ${response.statusCode}";
        logger.e(msg, error: response.body);
        throw Exception(msg);
      }
    }

    return {};
  }

  /// Sets the [manga]'s self-rating
  Future<bool> setMangaRating(Manga manga, int? rating) async {
    if (!await loggedIn()) {
      throw Exception(
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
        'limit': MangaDexEndpoints.apiQueryLimit.toString(),
      };

      while (end < fetch.length) {
        start = end;
        end += min(fetch.length - start, MangaDexEndpoints.apiQueryLimit);

        queryParams['ids[]'] = fetch.getRange(start, end);

        final uri = MangaDexEndpoints.api.replace(
            path: MangaDexEndpoints.group, queryParameters: queryParams);

        final response = await _client.get(uri);

        if (response.statusCode == 200) {
          final Map<String, dynamic> body = json.decode(response.body);

          final result = GroupList.fromJson(body);

          // Cache the data
          _cache.putAllAPIResolved(result.data);
        } else {
          // Throw if failure
          final msg =
              "fetchGroups() failed. Response code: ${response.statusCode}";
          logger.e(msg, error: response.body);
          throw Exception(msg);
        }
      }
    }

    // Craft the list
    for (final id in uuids) {
      if (await _cache.exists(id)) {
        list.add(_cache.get<Group>(id, ScanlationGroup.fromJson));
      }
    }

    return list;
  }

  /// Fetches group info of the given group [uuids]
  Future<List<CreatorType>> fetchCreators(Iterable<String> uuids) async {
    final list = <CreatorType>[];

    final fetch =
        (await uuids.whereAsync((id) async => !await _cache.exists(id)))
            .toList();

    if (fetch.isNotEmpty) {
      int start = 0, end = 0;

      var queryParams = <String, dynamic>{
        'limit': MangaDexEndpoints.apiQueryLimit.toString(),
      };

      while (end < fetch.length) {
        start = end;
        end += min(fetch.length - start, MangaDexEndpoints.apiQueryLimit);

        queryParams['ids[]'] = fetch.getRange(start, end);

        final uri = MangaDexEndpoints.api.replace(
            path: MangaDexEndpoints.creator, queryParameters: queryParams);

        final response = await _client.get(uri);

        if (response.statusCode == 200) {
          final Map<String, dynamic> body = json.decode(response.body);

          final result = CreatorList.fromJson(body);

          // Cache the data
          _cache.putAllAPIResolved(result.data);
        } else {
          // Throw if failure
          final msg =
              "fetchGroups() failed. Response code: ${response.statusCode}";
          logger.e(msg, error: response.body);
          throw Exception(msg);
        }
      }
    }

    // Craft the list
    for (final id in uuids) {
      if (await _cache.exists(id)) {
        list.add(_cache.get<CreatorType>(id, Author.fromJson));
      }
    }

    return list;
  }
}

@Riverpod(keepAlive: true)
class LatestChaptersFeed extends _$LatestChaptersFeed {
  int _offset = 0;
  bool _atEnd = false;

  ///Fetch the latest chapters list based on offset
  Future<List<Chapter>> _fetchLatestChapters(int offset) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return [];
    }

    final api = ref.watch(mangadexProvider);
    final chapters = await api.fetchUserFeed(offset);

    return chapters.toList();
  }

  @override
  FutureOr<List<Chapter>> build() async {
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

    final oldstate = state.valueOrNull ?? [];
    // If there is more content, get more
    if (oldstate.length == _offset + MangaDexEndpoints.apiQueryLimit &&
        !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final chapters = await _fetchLatestChapters(
            _offset + MangaDexEndpoints.apiQueryLimit);
        _offset += MangaDexEndpoints.apiQueryLimit;

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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await api.invalidateAll('fetchUserFeed');
      _offset = 0;
      _atEnd = false;
      return _fetchLatestChapters(_offset);
    });
  }
}

@Riverpod(keepAlive: true)
class LatestGlobalFeed extends _$LatestGlobalFeed {
  int _offset = 0;
  bool _atEnd = false;

  ///Fetch the latest chapters list based on offset
  Future<List<Chapter>> _fetchLatestChapters(int offset) async {
    final api = ref.watch(mangadexProvider);
    final chapters = await api.fetchChapterFeed(offset: offset);

    return chapters.toList();
  }

  @override
  FutureOr<List<Chapter>> build() async {
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

    final oldstate = state.valueOrNull ?? [];
    // If there is more content, get more
    if (oldstate.length == _offset + MangaDexEndpoints.apiQueryLimit &&
        !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final chapters = await _fetchLatestChapters(
            _offset + MangaDexEndpoints.apiQueryLimit);
        _offset += MangaDexEndpoints.apiQueryLimit;

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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await api.invalidateAll('fetchChapterFeed');
      _offset = 0;
      _atEnd = false;
      return _fetchLatestChapters(_offset);
    });
  }
}

@Riverpod(keepAlive: true)
class GroupFeed extends _$GroupFeed {
  int _offset = 0;
  bool _atEnd = false;

  Future<List<Chapter>> _fetchChapters(int offset) async {
    final api = ref.watch(mangadexProvider);
    final chapters = await api.fetchChapterFeed(offset: offset, group: group);

    return chapters.toList();
  }

  @override
  FutureOr<List<Chapter>> build(Group group) async {
    return _fetchChapters(0);
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = state.valueOrNull ?? [];
    // If there is more content, get more
    if (oldstate.length == _offset + MangaDexEndpoints.apiQueryLimit &&
        !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final chapters =
            await _fetchChapters(_offset + MangaDexEndpoints.apiQueryLimit);
        _offset += MangaDexEndpoints.apiQueryLimit;

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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await api.invalidateAll('fetchChapterFeed(${group.id}');
      _offset = 0;
      _atEnd = false;
      return _fetchChapters(_offset);
    });
  }
}

@Riverpod(keepAlive: true)
class GroupTitles extends _$GroupTitles {
  int _offset = 0;
  bool _atEnd = false;

  Future<List<Manga>> _fetchManga(int offset) async {
    final api = ref.watch(mangadexProvider);
    final manga = await api.fetchManga(offset: offset, filterId: group);

    return manga.toList();
  }

  @override
  FutureOr<List<Manga>> build(Group group) async {
    return _fetchManga(0);
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = state.valueOrNull ?? [];
    // If there is more content, get more
    if (oldstate.length == _offset + MangaDexEndpoints.apiQueryLimit &&
        !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final manga =
            await _fetchManga(_offset + MangaDexEndpoints.apiQueryLimit);
        _offset += MangaDexEndpoints.apiQueryLimit;

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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      _offset = 0;
      _atEnd = false;
      return _fetchManga(_offset);
    });
  }
}

@Riverpod(keepAlive: true)
class CreatorTitles extends _$CreatorTitles {
  int _offset = 0;
  bool _atEnd = false;

  Future<List<Manga>> _fetchManga(int offset) async {
    final api = ref.watch(mangadexProvider);
    final manga = await api.fetchManga(offset: offset, filterId: creator);

    return manga.toList();
  }

  @override
  FutureOr<List<Manga>> build(CreatorType creator) async {
    return _fetchManga(0);
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = state.valueOrNull ?? [];
    // If there is more content, get more
    if (oldstate.length == _offset + MangaDexEndpoints.apiQueryLimit &&
        !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final manga =
            await _fetchManga(_offset + MangaDexEndpoints.apiQueryLimit);
        _offset += MangaDexEndpoints.apiQueryLimit;

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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      _offset = 0;
      _atEnd = false;
      return _fetchManga(_offset);
    });
  }
}

@Riverpod(keepAlive: true)
class MangaChapters extends _$MangaChapters {
  int _offset = 0;
  bool _atEnd = false;

  Future<List<Chapter>> _fetchMangaChapters(int offset) async {
    final api = ref.watch(mangadexProvider);
    final chapters = await api.fetchMangaChapters(manga, offset);

    return chapters.toList();
  }

  @override
  FutureOr<List<Chapter>> build(Manga manga) async {
    return _fetchMangaChapters(0);
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = state.valueOrNull;
    // If there is more content, get more
    if (oldstate?.length == _offset + MangaDexEndpoints.apiQueryLimit &&
        !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final chapters = await _fetchMangaChapters(
            _offset + MangaDexEndpoints.apiQueryLimit);
        _offset += MangaDexEndpoints.apiQueryLimit;

        if (chapters.isEmpty) {
          _atEnd = true;
        }

        return [...oldstate!, ...chapters];
      });
    } else {
      // Otherwise, do nothing because there is no more content
      _atEnd = true;
    }
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    final api = ref.watch(mangadexProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      api.invalidateAll('fetchMangaChapters(${manga.id}');
      _offset = 0;
      _atEnd = false;
      return _fetchMangaChapters(_offset);
    });
  }
}

@Riverpod(keepAlive: true)
class MangaCovers extends _$MangaCovers {
  int _offset = 0;
  bool _atEnd = false;

  Future<List<Cover>> _fetchCovers(int offset) async {
    final api = ref.watch(mangadexProvider);
    final covers = await api.getCoverList(manga, offset);

    return covers.toList();
  }

  @override
  FutureOr<List<Cover>> build(Manga manga) async {
    return _fetchCovers(0);
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = state.valueOrNull ?? [];
    // If there is more content, get more
    if (oldstate.length == _offset + MangaDexEndpoints.apiSearchLimit &&
        !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final covers =
            await _fetchCovers(_offset + MangaDexEndpoints.apiSearchLimit);
        _offset += MangaDexEndpoints.apiSearchLimit;

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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      api.invalidateAll('getCoverList(${manga.id}');
      _offset = 0;
      _atEnd = false;
      return _fetchCovers(_offset);
    });
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
  FutureOr<ReadChaptersMap> build() async {
    return {};
  }

  /// Fetch read chapters for the provided list of mangas
  Future<void> get(Iterable<Manga> mangas) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return;
    }

    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    final oldstate = state.valueOrNull ?? {};
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
      Manga manga, Iterable<Chapter> chapters, bool setRead) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return;
    }

    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    final api = ref.watch(mangadexProvider);
    final oldstate = state.valueOrNull ?? {};

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final chapIdSet = chapters.map((e) => e.id).toSet();
      bool result = await api.setChaptersRead(manga, chapters, setRead);

      if (result) {
        final keyExists = oldstate.containsKey(manga.id);

        // Refresh
        if (keyExists) {
          switch (setRead) {
            case true:
              oldstate[manga.id]?.addAll(chapIdSet);
              break;
            case false:
              oldstate[manga.id]?.removeAll(chapIdSet);
              break;
          }
        } else {
          switch (setRead) {
            case true:
              oldstate[manga.id] = ReadChapterSet(manga.id, chapIdSet);
              break;
            case false:
              oldstate[manga.id] = ReadChapterSet(manga.id, {});
              break;
          }
        }
      }

      return {...oldstate};
    });
  }
}

@Riverpod(keepAlive: true)
class UserLibrary extends _$UserLibrary {
  int _total = 0;
  int _offset = 0;
  int _currentPage = 0;
  bool _atEnd = false;

  Future<Iterable<Manga>> _fetchUserLibrary() async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return [];
    }

    final api = ref.watch(mangadexProvider);
    final library = await api.fetchUserLibrary();

    if (library == null) {
      return [];
    }

    final results = library.entries
        .where((element) => element.value == status)
        .map((e) => e.key)
        .toList();

    _total = results.length;

    if (_offset > _total) {
      // No more items
      return [];
    }

    final range = min(_total, _offset + MangaDexEndpoints.apiQueryLimit);
    final mangas = await api.fetchManga(ids: results.getRange(_offset, range));

    _currentPage += (range - _offset);

    if (mangas.isNotEmpty) {
      await ref.read(statisticsProvider.notifier).get(mangas);
    }

    return mangas;
  }

  Future<Iterable<Manga>> _fetchAndCheck() async {
    final mangas = await _fetchUserLibrary();

    if (mangas.isEmpty) {
      _atEnd = true;
    }

    return mangas;
  }

  @override
  FutureOr<Iterable<Manga>> build(MangaReadingStatus status) async {
    return _fetchAndCheck();
  }

  int total() {
    return _total;
  }

  Future<void> getMore() async {
    if (state.isLoading || state.isReloading) {
      return;
    }

    if (_atEnd) {
      return;
    }

    final oldstate = state.valueOrNull;
    // If there is more content, get more
    if (_currentPage == _offset + MangaDexEndpoints.apiQueryLimit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        _offset += MangaDexEndpoints.apiQueryLimit;
        final mangas = await _fetchAndCheck();

        return [...oldstate!, ...mangas];
      });
    } else {
      // Otherwise, do nothing because there is no more content
      _atEnd = true;
    }
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      _offset = 0;
      _atEnd = false;
      _currentPage = 0;
      return _fetchAndCheck();
    });
  }
}

@Riverpod(keepAlive: true)
class TagList extends _$TagList {
  ///Fetch the global tag list
  Future<Iterable<Tag>> _fetchTagList() async {
    final api = ref.watch(mangadexProvider);

    final list = await api.getTagList();

    return list;
  }

  @override
  FutureOr<Iterable<Tag>> build() async {
    return _fetchTagList();
  }
}

@riverpod
class MangaSearch extends _$MangaSearch {
  int _offset = 0;
  bool _atEnd = false;

  Future<List<Manga>> _searchManga() async {
    final api = ref.watch(mangadexProvider);

    final manga = await api.searchManga(params.query,
        filter: params.filter, offset: _offset);

    if (manga.isNotEmpty) {
      await ref.read(statisticsProvider.notifier).get(manga);
    }

    return manga;
  }

  @override
  FutureOr<List<Manga>> build(MangaSearchParameters params) async {
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

    final oldstate = state.valueOrNull;
    // If there is more content, get more
    if (oldstate?.length == _offset + MangaDexEndpoints.apiSearchLimit &&
        !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        _offset += MangaDexEndpoints.apiSearchLimit;
        final list = await _searchManga();

        if (list.isEmpty) {
          _atEnd = true;
        }

        return [...oldstate!, ...list];
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
  FutureOr<Map<String, MangaStatistics>> build() async {
    return {};
  }

  /// Fetch statistics for the provided list of mangas
  Future<void> get(Iterable<Manga> mangas) async {
    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    final oldstate = state.valueOrNull ?? {};
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final mg = mangas.where((m) => !oldstate.containsKey(m.id));
      final map = await _fetchStatistics(mg);
      return {...oldstate, ...map};
    });
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
  FutureOr<Map<String, SelfRating>> build() async {
    return {};
  }

  /// Fetch user's self-ratings for the provided list of mangas
  Future<void> get(Iterable<Manga> mangas) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return;
    }

    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    final oldstate = state.valueOrNull ?? {};
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

    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    final api = ref.watch(mangadexProvider);
    final oldstate = state.valueOrNull ?? {};

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      bool result = await api.setMangaRating(manga, rating);

      if (result) {
        switch (rating) {
          case null:
            oldstate.remove(manga.id);
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

@Riverpod(keepAlive: true)
class ReadingStatus extends _$ReadingStatus with AsyncNotifierMix {
  Future<MangaReadingStatus?> _fetchReadingStatus() async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return null;
    }

    final api = ref.watch(mangadexProvider);
    final status = await api.getMangaReadingStatus(manga);

    staleTime(const Duration(minutes: 10));

    return status;
  }

  @override
  FutureOr<MangaReadingStatus?> build(Manga manga) async {
    return _fetchReadingStatus();
  }

  Future<void> set(MangaReadingStatus? status) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return;
    }

    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    final api = ref.watch(mangadexProvider);
    final oldstate = state.valueOrNull;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      MangaReadingStatus? resolved =
          status == MangaReadingStatus.remove ? null : status;
      bool success = await api.setMangaReadingStatus(manga, resolved);
      if (success) {
        await api.invalidateCacheItem(CacheLists.library);
        ref.invalidate(userLibraryProvider);

        return resolved;
      }

      return oldstate;
    });
  }
}

@Riverpod(keepAlive: true)
class FollowingStatus extends _$FollowingStatus with AsyncNotifierMix {
  Future<bool> _fetchFollowingStatus() async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return false;
    }

    final api = ref.watch(mangadexProvider);
    final status = await api.getMangaFollowing(manga);

    staleTime(const Duration(minutes: 10));

    return status;
  }

  @override
  FutureOr<bool> build(Manga manga) async {
    return _fetchFollowingStatus();
  }

  Future<void> set(bool following) async {
    final loggedin = await ref.read(authControlProvider.future);
    if (!loggedin) {
      return;
    }

    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    final api = ref.watch(mangadexProvider);
    final oldstate = state.valueOrNull ?? false;
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
  final _numItems = 50;

  Future<Queue<Chapter>> _fetch() async {
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

  @override
  FutureOr<Queue<Chapter>> build() async {
    return _fetch();
  }

  Future<void> add(Chapter chapter) async {
    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    final oldstate = state.valueOrNull ?? Queue<Chapter>();
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

@riverpod
class AuthControl extends _$AuthControl with AutoDisposeAsyncNotifierMix {
  Future<void> invalidate() async {
    state = await AsyncValue.guard(() async {
      return await _build();
    });
  }

  Future<void> _setStaleTime() async {
    final api = ref.watch(mangadexProvider);

    cancelStaleTime();

    final expireTime = await api.timeUntilTokenExpiry();

    if (expireTime != null) {
      final delay = expireTime + const Duration(seconds: 10);
      logger.d("AuthControl: setting stale time to ${delay.inSeconds} seconds");
      staleTime(delay);
    }
  }

  Future<bool> _build() async {
    final api = ref.watch(mangadexProvider);
    await api.future;

    if (await api.tokenExpired()) {
      logger.i("MangaDex token has expired. Refreshing...");
      await api.refreshToken();
    }

    await _setStaleTime();

    return await api.loggedIn();
  }

  @override
  FutureOr<bool> build() async {
    return await _build();
  }

  Future<bool> login(String user, String pass) async {
    final api = ref.watch(mangadexProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await api.authenticate(user, pass);
      await _setStaleTime();
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

// Deprecated stuff
class AuthenticatedClient extends http.BaseClient {
  final OldToken token;
  final http.Client baseClient;

  AuthenticatedClient(this.baseClient, this.token);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers[HttpHeaders.authorizationHeader] =
        'Bearer ${token.session}';
    return baseClient.send(request);
  }
}
