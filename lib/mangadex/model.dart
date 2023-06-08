import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:gagaku/mangadex/cache.dart';
import 'package:gagaku/mangadex/config.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'model.g.dart';

abstract class MangaDexEndpoints {
  static final api = Uri.https('api.mangadex.org', '');

  static const apiQueryLimit = 100;
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

  /// Gets cover art
  static const cover = '/cover';
}

abstract class CacheLists {
  static const latestChapters = 'latestChapters';
  static const latestGlobalChapters = 'latestGlobalChapters';
  static const library = 'userLibrary';
  static const tags = 'tags';
}

final mangadexProvider = Provider(MangaDexModel.new);

class MangaDexModel {
  MangaDexModel(this.ref) {
    _initFuture = _init();
  }

  final Ref ref;
  //TokenResponse? _token;
  OldToken? _token;
  http.Client _client = http.Client();
  late Future _initFuture;
  Future get initialized => _initFuture;

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

  bool _tokenExpired(OldToken? token) {
    if (token == null) {
      return false;
    }

    return token.expired;
  }

  bool loggedIn() => (_token != null && _client is AuthenticatedClient);

  Future _init() async {
    await refreshToken();
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
              _client = AuthenticatedClient(http.Client(), t);
              return;
            }
          }
        }
      }
    }

    // If any steps fail, assign a default client
    _client = http.Client();
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
          await _saveToken(t);
          _token = t;
          _client = AuthenticatedClient(http.Client(), t);
          return;
        }
      }
    }
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
    if (loggedIn()) {
      final response = await _client
          .post(MangaDexEndpoints.api.replace(path: MangaDexEndpoints.logout));

      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);

        if (body['result'] == 'ok') {
          _token = null;
          _client = http.Client();

          final storage = Hive.box(gagakuBox);
          await storage.delete('oldtoken');
        }
      }
    }
  }

  /// Invalidates a cache item so that it can be refreshed from the API
  ///
  /// [item] - key of the item to be invalidated
  Future<void> invalidateCacheItem(String item) async {
    if (_cache.exists(item)) {
      _cache.remove(item);
    }
  }

  /// Fetches the latest chapters feed of the MangaDex user
  ///
  /// Each operation that queries the MangaDex API is limited to
  /// [MangaDexEndpoints.apiQueryLimit] number of items.
  ///
  /// [offset] denotes the nth item to start fetching from.
  ///
  /// If [wholeList] is true, the operation always returns the entire list
  /// up to the latest data requested by offset. Otherwise, the range of items
  /// from [offset, min(offset + MangaDexEndpoints.apiQueryLimit, list.length))
  /// is returned. Ranged return may be empty if the latest fetch returned
  /// all available data (list.length < apiQueryLimit)
  ///
  /// Do not use directly. The provider [latestChaptersFeedProvider] should be
  /// used instead as it provides auto state management.
  Future<Iterable<Chapter>> fetchChapterFeed(
      [int offset = 0, bool wholeList = false]) async {
    if (!loggedIn()) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_tokenExpired(_token)) {
      await refreshToken();
    }

    var list = <Chapter>[];

    // Grab it from the cache if it exists
    if (_cache.exists(CacheLists.latestChapters)) {
      var cached =
          _cache.getSpecialList<Chapter>(CacheLists.latestChapters).toList();

      // If requested offset is less than the total length of the cached list,
      // return the cropped list of range [offset, min(offset + apiQueryLimit, cached.length))
      // (or the entire list if requested)
      if (offset < cached.length) {
        if (!wholeList) {
          return cached.getRange(offset,
              min(offset + MangaDexEndpoints.apiQueryLimit, cached.length));
        } else {
          return cached;
        }
      }

      // If cache.length < apiQueryLimit, then the latest fetch returned
      // all available data, so return nothing (or the entire list if requested)
      if (cached.length < MangaDexEndpoints.apiQueryLimit) {
        if (!wholeList) {
          return [];
        } else {
          return cached;
        }
      }

      // Otherwise, if offset >= cache.length and cache.length >= apiQueryLimit,
      // then we need to fetch more data from the api
      list.addAll(cached);
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
      'includes[]': 'scanlation_group'
    };
    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.feed, queryParameters: queryParams);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final result = ChapterList.fromJson(body);

      // Cache the data
      _cache.putAllAPIResolved(result.data);

      // Add data to the list
      list.addAll(result.data);

      // Cache the list
      _cache.putSpecialList(CacheLists.latestChapters, list, resolve: false);

      if (!wholeList) {
        return list.getRange(
            offset, min(offset + MangaDexEndpoints.apiQueryLimit, list.length));
      } else {
        return list;
      }
    }

    // Throw if failure
    throw Exception("Failed to download latest chapters");
  }

  /// Fetches the mangas with the latest chapter uploads on MangaDex
  ///
  /// Each operation that queries the MangaDex API is limited to
  /// [MangaDexEndpoints.apiQueryLimit] number of items.
  ///
  /// [offset] denotes the nth item to start fetching from.
  ///
  /// If [wholeList] is true, the operation always returns the entire list
  /// up to the latest data requested by offset. Otherwise, the range of items
  /// from [offset, min(offset + MangaDexEndpoints.apiQueryLimit, list.length))
  /// is returned. Ranged return may be empty if the latest fetch returned
  /// all available data (list.length < apiQueryLimit)
  ///
  /// Do not use directly. The provider [latestGlobalFeedProvider] should be
  /// used instead as it provides auto state management.
  Future<Iterable<Chapter>> fetchLatestGlobalFeed(
      [int offset = 0, bool wholeList = false]) async {
    if (_tokenExpired(_token)) {
      await refreshToken();
    }

    var list = <Chapter>[];

    // Grab it from the cache if it exists
    if (_cache.exists(CacheLists.latestGlobalChapters)) {
      var cached = _cache
          .getSpecialList<Chapter>(CacheLists.latestGlobalChapters)
          .toList();

      // If requested offset is less than the total length of the cached list,
      // return the cropped list of range [offset, min(offset + apiQueryLimit, cached.length))
      // (or the entire list if requested)
      if (offset < cached.length) {
        if (!wholeList) {
          return cached.getRange(offset,
              min(offset + MangaDexEndpoints.apiQueryLimit, cached.length));
        } else {
          return cached;
        }
      }

      // If cache.length < apiQueryLimit, then the latest fetch returned
      // all available data, so return nothing (or the entire list if requested)
      if (cached.length < MangaDexEndpoints.apiQueryLimit) {
        if (!wholeList) {
          return [];
        } else {
          return cached;
        }
      }

      // Otherwise, if offset >= cache.length and cache.length >= apiQueryLimit,
      // then we need to fetch more data from the api
      list.addAll(cached);
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
      'includes[]': 'scanlation_group'
    };
    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.chapter, queryParameters: queryParams);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final result = ChapterList.fromJson(body);

      // Cache the data
      _cache.putAllAPIResolved(result.data);

      // Add data to the list
      list.addAll(result.data);

      // Cache the list
      _cache.putSpecialList(CacheLists.latestGlobalChapters, list,
          resolve: false);

      if (!wholeList) {
        return list.getRange(
            offset, min(offset + MangaDexEndpoints.apiQueryLimit, list.length));
      } else {
        return list;
      }
    }

    // Throw if failure
    throw Exception("Failed to download latest global chapters");
  }

  /// Fetches chapter data of the given chapter [uuids]
  Future<Iterable<Chapter>> fetchChapters(Iterable<String> uuids) async {
    if (_tokenExpired(_token)) {
      await refreshToken();
    }

    final settings = ref.read(mdConfigProvider);

    final list = <Chapter>[];

    final fetch = uuids.where((id) => (!_cache.exists(id))).toList();

    if (fetch.isNotEmpty) {
      int start = 0, end = 0;

      var queryParams = {
        'limit': MangaDexEndpoints.apiQueryLimit.toString(),
        'includeFutureUpdates': '0',
        //'order[publishAt]': 'desc',
        'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
        'includes[]': ['scanlation_group']
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
          throw Exception("Failed to download manga data");
        }
      }
    }

    // Craft the list
    for (var id in uuids) {
      // Assume that all elements are cache satisfied at this point
      list.add(_cache.get<Chapter>(id));
    }

    return list;
  }

  /// Fetches manga data of the given manga [uuids]
  Future<Iterable<Manga>> fetchManga(Iterable<String> uuids) async {
    if (_tokenExpired(_token)) {
      await refreshToken();
    }

    final settings = ref.read(mdConfigProvider);

    Set<Manga> list = <Manga>{};

    final fetch = uuids.where((id) => (!_cache.exists(id))).toList();

    if (fetch.isNotEmpty) {
      int start = 0, end = 0;

      var queryParams = {
        'limit': MangaDexEndpoints.apiQueryLimit.toString(),
        'order[latestUploadedChapter]': 'desc',
        'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
        'includes[]': ['cover_art', 'author', 'artist']
      };

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
          throw Exception("Failed to download manga data");
        }
      }
    }

    // Craft the list
    for (var id in uuids) {
      // Assume that all elements are cache satisfied at this point
      list.add(_cache.get<Manga>(id));
    }

    return list;
  }

  /// Gets whether or not the user is following [manga]
  Future<bool> getMangaFollowing(Manga manga) async {
    if (!loggedIn()) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_tokenExpired(_token)) {
      await refreshToken();
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
    throw Exception("Failed to retrieve manga following status");
  }

  /// Sets the manga's following status [setFollow] of the [manga]
  Future<bool> setMangaFollowing(Manga manga, bool setFollow) async {
    if (!loggedIn()) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_tokenExpired(_token)) {
      await refreshToken();
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

    return false;
  }

  /// Gets the user's reading status for [manga]
  Future<MangaReadingStatus?> getMangaReadingStatus(Manga manga) async {
    if (!loggedIn()) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_tokenExpired(_token)) {
      await refreshToken();
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
    throw Exception("Failed to retrieve manga reading status");
  }

  /// Sets the manga's reading status [status] of the [manga]
  Future<bool> setMangaReadingStatus(
      Manga manga, MangaReadingStatus? status) async {
    if (!loggedIn()) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_tokenExpired(_token)) {
      await refreshToken();
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

    return false;
  }

  /// Fetches read chapter data of given [mangas]
  ///
  /// Do not use directly. Prefer [readChaptersProvider] for its caching and
  /// state management.
  Future<ReadChaptersMap> fetchReadChapters(Iterable<Manga> mangas) async {
    if (!loggedIn()) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_tokenExpired(_token)) {
      await refreshToken();
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
            map[m.id] = <String>{};
          }

          return map;
        }

        final cmap = body['data'] as Map<String, dynamic>;

        final readmap = cmap.map((key, value) => MapEntry(
            key, (value as List<dynamic>).map((e) => e.toString()).toSet()));

        return readmap;
      } else {
        // Throw if failure
        throw Exception("Failed to download read chapters data");
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
    if (_tokenExpired(_token)) {
      await refreshToken();
    }

    var list = <Chapter>[];

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
      'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
      'order[chapter]': 'desc',
      'includes[]': 'scanlation_group'
    };
    final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.mangaFeed.replaceFirst('{id}', manga.id),
        queryParameters: queryParams);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final result = ChapterList.fromJson(body);

      // Cache the data
      _cache.putAllAPIResolved(result.data);

      // Add data to the list
      list.addAll(result.data);

      return list;
    }

    // Throw if failure
    throw Exception("Failed to download manga chapters");
  }

  /// Sets the chapter read status [setRead] of the [chapters]
  Future<bool> setChaptersRead(
      Manga manga, Iterable<Chapter> chapters, bool setRead) async {
    if (!loggedIn()) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_tokenExpired(_token)) {
      await refreshToken();
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

    throw Exception("Failed to get relay server");
  }

  /// Fetches the user's manga library
  Future<LibraryMap?> fetchUserLibrary() async {
    if (!loggedIn()) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_tokenExpired(_token)) {
      await refreshToken();
    }

    if (_cache.exists(CacheLists.library)) {
      return _cache.get<LibraryMap>(CacheLists.library);
    }

    final uri = MangaDexEndpoints.api.replace(path: MangaDexEndpoints.library);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      if (body['statuses'] is List) {
        // If the api returns a List, then the result is null
        return null;
      }

      final mlist = body['statuses'] as Map<String, dynamic>;

      final libMap = mlist.map(
          (key, value) => MapEntry(key, MangaReadingStatusExt.parse(value)));

      _cache.put(CacheLists.library, libMap, true);

      return libMap;
    }

    // Throw if failure
    throw Exception("Failed to download user library data");
  }

  /// Retrieve all MangaDex tags
  Future<Iterable<Tag>> getTagList() async {
    if (_tokenExpired(_token)) {
      await refreshToken();
    }

    if (_cache.exists(CacheLists.tags)) {
      return _cache.getSpecialList<Tag>(CacheLists.tags);
    }

    final uri = MangaDexEndpoints.api.replace(path: MangaDexEndpoints.tag);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final result = TagResponse.fromJson(body);

      // Cache the data and list
      _cache.putSpecialList(CacheLists.tags, result.data,
          resolve: true, expiry: 65535);

      return result.data;
    }

    // Throw if failure
    throw Exception("Failed to download tag list");
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
    if (_tokenExpired(_token)) {
      await refreshToken();
    }

    // Return nothing if empty search term
    if (searchTerm.isEmpty) {
      return [];
    }

    final settings = ref.read(mdConfigProvider);

    List<Manga> list = [];

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
      'title': searchTerm
    };

    queryParams.addAll(filter.getMap());

    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.manga, queryParameters: queryParams);

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final mlist = MangaList.fromJson(body);

      list.addAll(mlist.data);

      // Cache the data
      _cache.putAllAPIResolved(mlist.data);
    } else {
      // Throw if failure
      throw Exception("Failed to search manga");
    }

    return list;
  }

  /// Fetches statistics of given [mangas]
  ///
  /// Do not use directly. Prefer [statisticsProvider] for its caching and
  /// state management.
  Future<Map<String, MangaStatistics>> fetchStatistics(
      Iterable<Manga> mangas) async {
    if (_tokenExpired(_token)) {
      await refreshToken();
    }

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
        throw Exception("Failed to download manga statistics");
      }
    }

    return {};
  }

  /// Retrieve cover art for a specific manga
  Future<List<Cover>> getCoverList(Manga manga, [int offset = 0]) async {
    if (_tokenExpired(_token)) {
      await refreshToken();
    }

    // Download missing data
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

      return result.data;
    }

    // Throw if failure
    throw Exception("Failed to download covers");
  }
}

@Riverpod(keepAlive: true)
class LatestChaptersFeed extends _$LatestChaptersFeed {
  int _offset = 0;
  bool _atEnd = false;

  ///Fetch the latest chapters list based on offset
  Future<List<Chapter>> _fetchLatestChapters(int offset) async {
    final api = ref.watch(mangadexProvider);
    var chapters = await api.fetchChapterFeed(offset, true);

    return chapters.toList();
  }

  @override
  FutureOr<List<Chapter>> build() async {
    return _fetchLatestChapters(0);
  }

  /// Fetch more latest chapters if more data exists
  Future<void> getMore() async {
    if (_atEnd) {
      return;
    }

    final oldstate =
        state.maybeWhen(data: (data) => data.length, orElse: () => 0);
    // If there is more content, get more
    if (oldstate == _offset + MangaDexEndpoints.apiQueryLimit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        _offset += MangaDexEndpoints.apiQueryLimit;
        final chapters = await _fetchLatestChapters(_offset);

        if (chapters.isEmpty) {
          _atEnd = true;
        }

        return chapters;
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
      api.invalidateCacheItem(CacheLists.latestChapters);
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
    var chapters = await api.fetchLatestGlobalFeed(offset, true);

    return chapters.toList();
  }

  @override
  FutureOr<List<Chapter>> build() async {
    return _fetchLatestChapters(0);
  }

  /// Fetch more latest chapters if more data exists
  Future<void> getMore() async {
    if (_atEnd) {
      return;
    }

    final oldstate =
        state.maybeWhen(data: (data) => data.length, orElse: () => 0);
    // If there is more content, get more
    if (oldstate == _offset + MangaDexEndpoints.apiQueryLimit && !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        _offset += MangaDexEndpoints.apiQueryLimit;
        final chapters = await _fetchLatestChapters(_offset);

        if (chapters.isEmpty) {
          _atEnd = true;
        }

        return chapters;
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
      api.invalidateCacheItem(CacheLists.latestGlobalChapters);
      _offset = 0;
      _atEnd = false;
      return _fetchLatestChapters(_offset);
    });
  }
}

@Riverpod(keepAlive: true)
class MangaChapters extends _$MangaChapters {
  int _offset = 0;
  bool _atEnd = false;

  ///Fetch the manga chapters list based on offset
  Future<List<Chapter>> _fetchMangaChapters(int offset) async {
    final api = ref.watch(mangadexProvider);
    final chapters = await api.fetchMangaChapters(manga, offset);

    return chapters.toList();
  }

  @override
  FutureOr<List<Chapter>> build(Manga manga) async {
    return _fetchMangaChapters(0);
  }

  /// Fetch more chapters if more data exists
  Future<void> getMore() async {
    if (_atEnd) {
      return;
    }

    final oldstate = state.maybeWhen(data: (data) => data, orElse: () => null);
    // If there is more content, get more
    if (oldstate?.length == _offset + MangaDexEndpoints.apiQueryLimit &&
        !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        _offset += MangaDexEndpoints.apiQueryLimit;
        final chapters = await _fetchMangaChapters(_offset);

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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
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

  ///Fetch the manga chapters list based on offset
  Future<List<Cover>> _fetchCovers(int offset) async {
    final api = ref.watch(mangadexProvider);
    final covers = await api.getCoverList(manga, offset);

    return covers.toList();
  }

  @override
  FutureOr<List<Cover>> build(Manga manga) async {
    return _fetchCovers(0);
  }

  /// Fetch more chapters if more data exists
  Future<void> getMore() async {
    if (_atEnd) {
      return;
    }

    final oldstate =
        state.maybeWhen(data: (data) => data, orElse: () => <Cover>[]);
    // If there is more content, get more
    if (oldstate.length == _offset + MangaDexEndpoints.apiSearchLimit &&
        !_atEnd) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        _offset += MangaDexEndpoints.apiSearchLimit;
        final covers = await _fetchCovers(_offset);

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
}

@Riverpod(keepAlive: true)
class ReadChapters extends _$ReadChapters {
  ///Fetch the latest chapters list based on offset
  Future<ReadChaptersMap> _fetchReadChapters(Iterable<Manga> mangas) async {
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
    final oldstate = state.maybeWhen(
        data: (data) => data, orElse: () => <String, Set<String>>{});
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final mg = mangas.where((m) => !oldstate.containsKey(m.id));
      final map = await _fetchReadChapters(mg);
      return {...oldstate, ...map};
    });
  }

  /// Sets a list of chapters for a manga read or unread
  Future<void> set(
      Manga manga, Iterable<Chapter> chapters, bool setRead) async {
    final chapIdSet = chapters.map((e) => e.id).toSet();
    final api = ref.watch(mangadexProvider);

    final oldstate = state.maybeWhen(
        data: (data) => data, orElse: () => <String, Set<String>>{});

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      bool result = await api.setChaptersRead(manga, chapters, setRead);

      if (result) {
        final keyExists = oldstate.containsKey(manga.id);

        // Refresh
        if (setRead) {
          if (keyExists) {
            oldstate[manga.id]?.addAll(chapIdSet);
          } else {
            oldstate[manga.id] = chapIdSet;
          }
        } else {
          if (keyExists) {
            oldstate[manga.id]?.removeAll(chapIdSet);
          } else {
            oldstate[manga.id] = {};
          }
        }
      }

      return oldstate;
    });
  }
}

@Riverpod(keepAlive: true)
class UserLibrary extends _$UserLibrary {
  int _total = 0;
  int _offset = 0;
  bool _atEnd = false;

  ///Fetch the manga chapters list based on offset
  Future<Iterable<Manga>> _fetchUserLibrary() async {
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

    final range =
        min(results.length, _offset + MangaDexEndpoints.apiQueryLimit);
    final mangas = await api.fetchManga(results.getRange(_offset, range));

    if (mangas.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 100));
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

  /// Fetch more chapters if more data exists
  Future<void> getMore() async {
    if (_atEnd) {
      return;
    }

    final oldstate = state.maybeWhen(data: (data) => data, orElse: () => null);
    // If there is more content, get more
    if (oldstate?.length == _offset + MangaDexEndpoints.apiQueryLimit &&
        !_atEnd) {
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

    if (params.query.isEmpty) {
      // No search term
      return [];
    }

    final manga = await api.searchManga(params.query,
        filter: params.filter, offset: _offset);

    if (manga.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 100));
      await ref.read(statisticsProvider.notifier).get(manga);
    }

    return manga;
  }

  @override
  FutureOr<List<Manga>> build(MangaSearchParameters params) async {
    return _searchManga();
  }

  /// Fetch more if more data exists
  Future<void> getMore() async {
    if (_atEnd) {
      return;
    }

    final oldstate = state.maybeWhen(data: (data) => data, orElse: () => null);
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
    final oldstate = state.maybeWhen(
        data: (data) => data, orElse: () => <String, MangaStatistics>{});
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final mg = mangas.where((m) => !oldstate.containsKey(m.id));
      final map = await _fetchStatistics(mg);
      return {...oldstate, ...map};
    });
  }
}

@Riverpod(keepAlive: true)
class ReadingStatus extends _$ReadingStatus {
  Future<MangaReadingStatus?> _fetchReadingStatus() async {
    final api = ref.watch(mangadexProvider);
    final status = await api.getMangaReadingStatus(manga);

    return status;
  }

  @override
  FutureOr<MangaReadingStatus?> build(Manga manga) async {
    return _fetchReadingStatus();
  }

  Future<void> set(MangaReadingStatus? status) async {
    final api = ref.watch(mangadexProvider);
    final oldstate = state.maybeWhen(data: (data) => data, orElse: () => null);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      MangaReadingStatus? resolved =
          status == MangaReadingStatus.remove ? null : status;
      bool success = await api.setMangaReadingStatus(manga, resolved);
      if (success) {
        return resolved;
      }

      return oldstate;
    });
  }
}

@Riverpod(keepAlive: true)
class FollowingStatus extends _$FollowingStatus {
  Future<bool> _fetchFollowingStatus() async {
    final api = ref.watch(mangadexProvider);
    final status = await api.getMangaFollowing(manga);

    return status;
  }

  @override
  FutureOr<bool> build(Manga manga) async {
    return _fetchFollowingStatus();
  }

  Future<void> set(bool following) async {
    final api = ref.watch(mangadexProvider);
    final oldstate = state.maybeWhen(data: (data) => data, orElse: () => false);
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

    return Queue<Chapter>.from(chapters);
  }

  @override
  FutureOr<Queue<Chapter>> build() async {
    return _fetch();
  }

  Future<void> add(Chapter chapter) async {
    final oldstate =
        state.maybeWhen(data: (data) => data, orElse: () => Queue<Chapter>());
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      while (oldstate.contains(chapter)) {
        oldstate.remove(chapter);
      }

      oldstate.addFirst(chapter);

      while (oldstate.length > _numItems) {
        oldstate.removeLast();
      }

      final uuids = oldstate.map((e) => e.id).toList();

      final box = Hive.box(gagakuBox);
      await box.put('mangadex_history', json.encode(uuids));

      return oldstate;
    });
  }
}

@riverpod
class AuthControl extends _$AuthControl {
  @override
  FutureOr<bool> build() async {
    final api = ref.watch(mangadexProvider);
    await api.initialized;
    return api.loggedIn();
  }

  Future<bool> login(String user, String pass) async {
    final api = ref.watch(mangadexProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await api.authenticate(user, pass);
      return api.loggedIn();
    });

    return api.loggedIn();
  }

  Future<void> logout() async {
    final api = ref.watch(mangadexProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await api.logout();
      return api.loggedIn();
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
