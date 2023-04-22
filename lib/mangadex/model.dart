import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:gagaku/mangadex/cache.dart';
import 'package:gagaku/mangadex/config.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../model.dart';

part 'model.g.dart';

enum MangaDexTab {
  mangaFeed,
  chapterFeed,
  libraryView,
}

final mangadexTabProvider = StateProvider((ref) => MangaDexTab.mangaFeed);

abstract class MangaDexEndpoints {
  static final api = Uri.https('api.mangadex.org', '');

  static const apiQueryLimit = 100;
  static const apiSearchLimit = 10;

  static final provider =
      Uri.parse('https://auth.mangadex.dev/realms/mangadex');
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
}

abstract class CacheLists {
  static const latestChapters = 'latestChapters';
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
  http.Client? _client;
  late Future _initFuture;
  Future get initialized => _initFuture;

  final CacheManager _cache = CacheManager();

  _urlLauncher(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri) || Platform.isAndroid) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  // bool _tokenExpired(TokenResponse token) {
  //   return token.expiresAt != null
  //       ? (DateTime.now().difference(token.expiresAt!).inMinutes > -5)
  //       : false;
  // }

  bool _tokenExpired(OldToken token) {
    return token.expired;
  }

  bool loggedIn() => (_token != null && _client != null);

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
    final storage = Hive.box(gagakuBox);
    String? strken = await storage.get('oldtoken') as String?;

    if (strken != null) {
      var jstr = json.decode(strken);
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
            }
          }
        }
      }
    }
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
      final response = await _client!
          .post(MangaDexEndpoints.api.replace(path: MangaDexEndpoints.logout));

      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);

        if (body['result'] == 'ok') {
          _token = null;
          _client = null;

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

    if (_tokenExpired(_token!)) {
      await refreshToken();
    }

    var list = <Chapter>[];

    // Grab it from the cache if it exists
    if (_cache.exists(CacheLists.latestChapters)) {
      // dev.log('Getting latest chapters from cache');
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
    // dev.log('Downloading latest chapters');
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
      'order[publishAt]': 'desc',
      'includes[]': 'scanlation_group'
    };
    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.feed, queryParameters: queryParams);

    // dev.log('query', error: uri.toString());

    final response = await _client!.get(uri);

    if (response.statusCode == 200) {
      // dev.log('response', error: response.body);
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

  /// Fetches manga data of the given manga [uuids]
  Future<Iterable<Manga>> fetchManga(Iterable<String> uuids) async {
    if (!loggedIn()) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_tokenExpired(_token!)) {
      await refreshToken();
    }

    final settings = ref.read(mdConfigProvider);

    Set<Manga> list = <Manga>{};

    var fetch = uuids.where((id) => (!_cache.exists(id))).toList();

    if (fetch.isNotEmpty) {
      // dev.log('Retrieving Manga info');

      int start = 0, end = 0;

      var queryParams = {
        'limit': MangaDexEndpoints.apiQueryLimit.toString(),
        'order[latestUploadedChapter]': 'desc',
        // 'availableTranslatedLanguage[]':
        //     _settings.translatedLanguages.map(const LanguageConverter().toJson).toList(),
        // 'originalLanguage[]':
        //     _settings.originalLanguage.map(const LanguageConverter().toJson).toList(),
        'contentRating[]': settings.contentRating.map((e) => e.name).toList(),
        'includes[]': ['cover_art', 'author', 'artist']
      };

      while (end < fetch.length) {
        start = end;
        end += min(fetch.length, MangaDexEndpoints.apiQueryLimit);

        queryParams['ids[]'] = fetch.getRange(start, end);

        final uri = MangaDexEndpoints.api.replace(
            path: MangaDexEndpoints.manga, queryParameters: queryParams);

        // dev.log('query', error: uri.toString());

        final response = await _client!.get(uri);

        if (response.statusCode == 200) {
          // dev.log('response', error: response.body);
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

    if (_tokenExpired(_token!)) {
      await refreshToken();
    }

    final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.follows.replaceFirst('{id}', manga.id));

    var response = await _client!.get(uri);

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

    if (_tokenExpired(_token!)) {
      await refreshToken();
    }

    final uri = MangaDexEndpoints.api.replace(
        path: MangaDexEndpoints.setFollow.replaceFirst('{id}', manga.id));

    http.Response response;

    if (setFollow) {
      response = await _client!.post(uri);
    } else {
      response = await _client!.delete(uri);
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

    if (_tokenExpired(_token!)) {
      await refreshToken();
    }

    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.status.replaceFirst('{id}', manga.id));

    var response = await _client!.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);

      if (body['result'] == 'ok') {
        MangaReadingStatus status = MangaReadingStatus.reading;

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

    if (_tokenExpired(_token!)) {
      await refreshToken();
    }

    final params = {'status': (status?.name)};

    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.status.replaceFirst('{id}', manga.id));

    var response = await _client!.post(uri,
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
  Future<Set<String>> fetchReadChapters(Iterable<Manga> mangas) async {
    if (!loggedIn()) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_tokenExpired(_token!)) {
      await refreshToken();
    }

    var fetch = mangas.map((e) => e.id);

    if (fetch.isNotEmpty) {
      final queryParams = {'ids[]': fetch};

      final uri = MangaDexEndpoints.api.replace(
          path: MangaDexEndpoints.getRead, queryParameters: queryParams);

      final response = await _client!.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);

        var clist = body['data'] as List<dynamic>;

        var strlist = clist.map((e) => e.toString());

        return strlist.toSet();
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
    if (!loggedIn()) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_tokenExpired(_token!)) {
      await refreshToken();
    }

    var list = <Chapter>[];

    final settings = ref.read(mdConfigProvider);

    // Download missing data
    // dev.log('Downloading latest chapters');
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

    final response = await _client!.get(uri);

    if (response.statusCode == 200) {
      // dev.log('response', error: response.body);
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

    if (_tokenExpired(_token!)) {
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

    var response = await _client!.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(params));

    if (response.statusCode == 200) {
      // Success
      return true;
    }

    return false;
  }
}

@Riverpod(keepAlive: true)
class LatestChaptersFeed extends _$LatestChaptersFeed {
  int _offset = 0;

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
    var oldstate =
        state.maybeWhen(data: (data) => data.length, orElse: () => 0);
    // If there is more content, get more
    if (oldstate == _offset + MangaDexEndpoints.apiQueryLimit) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        _offset += MangaDexEndpoints.apiQueryLimit;
        return _fetchLatestChapters(_offset);
      });
    }

    // Otherwise, do nothing because there is no more content
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    final api = ref.watch(mangadexProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      api.invalidateCacheItem(CacheLists.latestChapters);
      _offset = 0;
      return _fetchLatestChapters(_offset);
    });
  }
}

@Riverpod(keepAlive: true)
class MangaChapters extends _$MangaChapters {
  int _offset = 0;

  ///Fetch the manga chapters list based on offset
  Future<List<Chapter>> _fetchMangaChapters(int offset) async {
    final api = ref.watch(mangadexProvider);
    var chapters = await api.fetchMangaChapters(manga, offset);

    return chapters.toList();
  }

  @override
  FutureOr<List<Chapter>> build(Manga manga) async {
    return _fetchMangaChapters(0);
  }

  /// Fetch more chapters if more data exists
  Future<void> getMore() async {
    var oldstate = state.maybeWhen(data: (data) => data, orElse: () => null);
    // If there is more content, get more
    if (oldstate?.length == _offset + MangaDexEndpoints.apiQueryLimit) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        _offset += MangaDexEndpoints.apiQueryLimit;
        var chapters = await _fetchMangaChapters(_offset);
        return [...oldstate!, ...chapters];
      });
    }

    // Otherwise, do nothing because there is no more content
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      _offset = 0;
      return _fetchMangaChapters(_offset);
    });
  }
}

@Riverpod(keepAlive: true)
class ReadChapters extends _$ReadChapters {
  ///Fetch the latest chapters list based on offset
  Future<Set<String>> _fetchReadChapters(Iterable<Manga> mangas) async {
    final api = ref.watch(mangadexProvider);
    var list = await api.fetchReadChapters(mangas);

    return list;
  }

  @override
  FutureOr<Set<String>> build() async {
    return {};
  }

  /// Fetch read chapters for the provided list of mangas
  Future<void> get(Iterable<Manga> mangas) async {
    var oldstate =
        state.maybeWhen(data: (data) => data, orElse: () => <String>{});
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      var chapters = await _fetchReadChapters(mangas);
      return {...oldstate, ...chapters};
    });
  }

  /// Sets a list of chapters for a manga read or unread
  Future<void> set(
      Manga manga, Iterable<Chapter> chapters, bool setRead) async {
    final chapIdSet = chapters.map((e) => e.id).toSet();
    final api = ref.watch(mangadexProvider);

    var oldstate =
        state.maybeWhen(data: (data) => data, orElse: () => <String>{});

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      bool result = await api.setChaptersRead(manga, chapters, setRead);

      if (result) {
        // Refresh
        if (setRead) {
          return {...oldstate, ...chapIdSet};
        } else {
          return oldstate
              .where((element) => !chapIdSet.contains(element))
              .toSet();
        }
      }

      return oldstate;
    });
  }
}

@riverpod
Future<MangaReadingStatus?> fetchReadingStatus(
    FetchReadingStatusRef ref, Manga manga) async {
  final api = ref.watch(mangadexProvider);
  var status = await api.getMangaReadingStatus(manga);

  ref.keepAlive();

  return status;
}

@riverpod
Future<bool> fetchFollowingManga(
    FetchFollowingMangaRef ref, Manga manga) async {
  final api = ref.watch(mangadexProvider);
  var status = await api.getMangaFollowing(manga);

  ref.keepAlive();

  return status;
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
