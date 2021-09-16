import 'dart:convert';
import 'dart:io';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

typedef LocalizedString = Map<String, String>;

enum CoverArtQuality { best, medium, small }

abstract class MangaDexEndpoints {
  static final api = Uri.https('api.mangadex.org', '');

  static const apiQueryLimit = 100;

  static const login = '/auth/login';
  static const logout = '/auth/logout';
  static const refresh = '/auth/refresh';

  static const feed = '/user/follows/manga/feed';
  static const manga = '/manga';
}

abstract class CacheLists {
  static const latestChapters = 'latestChapters';
}

class Token {
  final String session;
  final String refresh;
  final DateTime createdAt;

  Token({this.session = "", this.refresh = ""}) : createdAt = DateTime.now();

  factory Token.fromJson(Map<String, dynamic> json) {
    return new Token(
        session: json['session'] ?? "", refresh: json['refresh'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {"session": this.session, "refresh": this.refresh};
  }

  bool get isValid => (this.session.isNotEmpty && this.refresh.isNotEmpty);
  bool get expired =>
      (DateTime.now().difference(this.createdAt).inMinutes > 14);
}

class MangaDexModel extends ChangeNotifier {
  // Important state
  Token _token = Token();
  bool _loggedIn = false;
  MangaDexClient? _client;

  CacheManager _cache = CacheManager();

  // TODO: Settings
  List<String> _translatedLanguages = ['en'];
  List<String> _originalLanguage = ['ja'];
  List<String> _contentRating = [
    'safe',
    'suggestive',
    'erotica',
    'pornographic'
  ];
  bool _dataSaver = false;

  // Getters
  Token get token => _token;
  bool get loggedIn => _loggedIn;
  MangaDexClient? get client => _client;

  void init() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? tokstr = _prefs.getString('token');
    if (tokstr != null) {
      Map<String, dynamic> parsedJson = jsonDecode(tokstr);
      Token t = Token.fromJson(parsedJson);

      if (t.isValid) {
        Token tok = await refreshToken(t.refresh);
        if (tok.isValid) {
          setToken(tok);
        }
      }
    }
  }

  void setToken(Token tkn) async {
    _token = tkn;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tknstr = jsonEncode(_token.toJson());
    await prefs.setString('token', tknstr);

    if (_token.isValid) {
      _client = MangaDexClient(_token, http.Client());
    }

    if (_token.isValid && !_loggedIn) {
      _loggedIn = true;
      notifyListeners();
    } else if (!_token.isValid && _loggedIn) {
      _client = null;
      _loggedIn = false;
      notifyListeners();
    }
  }

  void removeToken() async {
    _token = Token();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tknstr = jsonEncode(_token.toJson());
    await prefs.setString('token', tknstr);

    _client = null;
    _loggedIn = false;
    notifyListeners();
  }

  Future<Token> refreshToken(String rfshtkn) async {
    Map<String, String> payload = {'token': rfshtkn};

    final response = await http.post(
        MangaDexEndpoints.api.replace(path: MangaDexEndpoints.refresh),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      if (body['result'] == 'ok') {
        Token t = Token.fromJson(body['token']);

        if (t.isValid) {
          return t;
        }
      }
    }

    return Token();
  }

  Future<void> refreshCurrentToken() async {
    if (_token.isValid && _loggedIn) {
      Token tok = await refreshToken(_token.refresh);
      if (tok.isValid) {
        setToken(tok);
      } else {
        removeToken();
      }
    }
  }

  Future<bool> login(String user, String pass) async {
    Map<String, String> payload = {'username': user, 'password': pass};

    final response = await http.post(
        MangaDexEndpoints.api.replace(path: MangaDexEndpoints.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      if (body['result'] == 'ok') {
        Token t = Token.fromJson(body['token']);

        if (t.isValid) {
          setToken(t);
          return true;
        }
      }
    }

    return false;
  }

  Future<bool> logout() async {
    if (_loggedIn && _client != null) {
      final response = await _client!
          .post(MangaDexEndpoints.api.replace(path: MangaDexEndpoints.logout));

      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);

        if (body['result'] == 'ok') {
          removeToken();
          return true;
        }
      }
    }

    return false;
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
  Future<Iterable<Chapter>> fetchChapterFeed(
      [int offset = 0, bool wholeList = false]) async {
    if (!_token.isValid || !_loggedIn) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_token.expired) {
      await refreshCurrentToken();
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

    // Download missing data
    // dev.log('Downloading latest chapters');
    final queryParams = {
      'limit': MangaDexEndpoints.apiQueryLimit.toString(),
      'offset': offset.toString(),
      'translatedLanguage[]': _translatedLanguages,
      'originalLanguage[]': _originalLanguage,
      'contentRating[]': _contentRating,
      'order[publishAt]': 'desc'
    };
    final uri = MangaDexEndpoints.api
        .replace(path: MangaDexEndpoints.feed, queryParameters: queryParams);

    // dev.log('query', error: uri.toString());

    final response = await _client!.get(uri);

    if (response.statusCode == 200) {
      // dev.log('response', error: response.body);
      final Map<String, dynamic> body = jsonDecode(response.body);

      List<dynamic> chlist = body['data'];

      var result = chlist.map((json) => Chapter.fromJson(json)).toList();

      // Cache the data
      _cache.putAllAPIResolved(result);

      // Add data to the list
      list.addAll(result);

      // Cache the list
      _cache.putSpecialList(CacheLists.latestChapters, list, false);

      if (!wholeList) {
        return list.getRange(
            offset, min(offset + MangaDexEndpoints.apiQueryLimit, list.length));
      } else {
        return list;
      }
    }

    // Throw if failure
    throw Exception("Failed to download chapters");
  }

  /// Invalidates a cache item so that it can be refreshed from the API
  ///
  /// [item] - key of the item to be invalidated
  Future<void> invalidateCacheItem(String item) async {
    if (_cache.exists(item)) {
      _cache.remove(item);
    }
  }

  /// Fetches manga data of the given [uuids]
  Future<Iterable<Manga>> fetchManga(Iterable<String> uuids) async {
    if (!_token.isValid || !_loggedIn) {
      throw Exception(
          "Data fetch called on invalid token/login. Shouldn't ever get here");
    }

    if (_token.expired) {
      await refreshCurrentToken();
    }

    Set<Manga> list = Set<Manga>();

    var fetch = uuids.where((id) => (!_cache.exists(id)));

    if (fetch.length > 0) {
      // dev.log('Retrieving Manga info');
      final queryParams = {
        'limit': max(fetch.length, MangaDexEndpoints.apiQueryLimit).toString(),
        'order[latestUploadedChapter]': 'desc',
        'availableTranslatedLanguage[]': _translatedLanguages,
        'originalLanguage[]': _originalLanguage,
        'contentRating[]': _contentRating,
        'includes[]': 'cover_art',
        'ids[]': fetch
      };
      final uri = MangaDexEndpoints.api
          .replace(path: MangaDexEndpoints.manga, queryParameters: queryParams);

      // dev.log('query', error: uri.toString());

      final response = await _client!.get(uri);

      if (response.statusCode == 200) {
        // dev.log('response', error: response.body);
        final Map<String, dynamic> body = jsonDecode(response.body);

        List<dynamic> mlist = body['data'];

        var results = mlist.map((json) => Manga.fromJson(json)).toList();

        // Cache the data
        _cache.putAllAPIResolved(results);
      }
    }

    // Craft the list
    uuids.forEach((id) {
      // Assume that all elements are cache satisfied at this point
      list.add(_cache.get<Manga>(id));
    });

    return list;
  }
}

class MangaDexClient extends http.BaseClient {
  final Token token;
  final http.Client _inner;

  MangaDexClient(this.token, this._inner);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers[HttpHeaders.authorizationHeader] =
        'Bearer ' + token.session;
    return _inner.send(request);
  }
}

abstract class MangaDexAPIData {
  final String id;
  final String type;
  final int _cacheExpiration;

  int get cacheExpiration => _cacheExpiration;

  MangaDexAPIData._(this.id, this.type, this._cacheExpiration);
}

class Chapter extends MangaDexAPIData {
  final String? volume;
  final String? chapter;
  final String? title;
  final String translatedLanguage;
  final String hash;
  final List<String> data;
  final List<String> dataSaver;
  final String? externalUrl;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishAt;

  final String mangaId;
  final String? userId;
  final String? groupId;

  Chapter(
      {required String id,
      this.volume,
      this.chapter,
      this.title,
      required this.translatedLanguage,
      required this.hash,
      required this.data,
      required this.dataSaver,
      this.externalUrl,
      required this.version,
      required this.createdAt,
      required this.updatedAt,
      required this.publishAt,
      required this.mangaId,
      this.userId,
      this.groupId})
      : super._(id, 'chapter', 65535);

  factory Chapter.fromJson(Map<String, dynamic> data) {
    if (data['type'] == 'chapter') {
      Map<String, dynamic> attr = data['attributes'];

      String mangaId = '';
      String groupId = '';
      String userId = '';

      List<Map<String, dynamic>> relations =
          List<Map<String, dynamic>>.from(data['relationships']);
      relations.forEach((r) {
        if (r['type'] == 'manga') {
          mangaId = r['id'];
        } else if (r['type'] == 'user') {
          userId = r['id'];
        } else if (r['type'] == 'scanlation_group') {
          groupId = r['id'];
        }
      });

      return Chapter(
          id: data['id'],
          volume: attr['volume'],
          chapter: attr['chapter'],
          title: attr['title'],
          translatedLanguage: attr['translatedLanguage'],
          hash: attr['hash'],
          data: List<String>.from(attr['data']),
          dataSaver: List<String>.from(attr['dataSaver']),
          externalUrl: attr['externalUrl'],
          publishAt: DateTime.parse(attr['publishAt']),
          createdAt: DateTime.parse(attr['publishAt']),
          updatedAt: DateTime.parse(attr['publishAt']),
          version: attr['version'],
          mangaId: mangaId,
          userId: userId,
          groupId: groupId);
    }

    throw ArgumentError('Unexpected data retrieval failure');
  }
}

class Manga extends MangaDexAPIData {
  final LocalizedString title;
  final List<LocalizedString> altTitles;
  final LocalizedString description;
  final Map<String, String> links;
  final String originalLanguage;

  final String? lastVolume;
  final String? lastChapter;
  final String? publicationDemographic;
  final String? status;
  final int? year;
  final String contentRating;
  final List<Tag> tags;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  final String? authorId;
  final String? artistId;

  // Only store the primary cover returned by the API
  final String coverArt;

  Manga(
      {required String id,
      required this.title,
      required this.altTitles,
      required this.description,
      required this.links,
      required this.originalLanguage,
      this.lastVolume,
      this.lastChapter,
      this.publicationDemographic,
      this.status,
      this.year,
      required this.contentRating,
      required this.tags,
      required this.version,
      required this.createdAt,
      required this.updatedAt,
      this.authorId,
      this.artistId,
      required this.coverArt})
      : super._(id, 'manga', 30);

  factory Manga.fromJson(Map<String, dynamic> data) {
    if (data['type'] == 'manga') {
      Map<String, dynamic> attr = data['attributes'];

      // Tags
      List<Map<String, dynamic>> tagData =
          List<Map<String, dynamic>>.from(attr['tags']);

      var tags = tagData.map((e) => Tag.fromJson(e)).toList();

      String authorId = '';
      String artistId = '';
      String coverArt = '';

      // Cover Art
      List<Map<String, dynamic>> relations =
          List<Map<String, dynamic>>.from(data['relationships']);
      relations.forEach((r) {
        if (r['type'] == 'author') {
          authorId = r['id'];
        } else if (r['type'] == 'artist') {
          artistId = r['id'];
        } else if (r['type'] == 'cover_art') {
          Map<String, dynamic> caattrs = r['attributes'];
          coverArt = caattrs['fileName'];
        }
      });

      // Alt titles
      List<Map<String, dynamic>> alt =
          List<Map<String, dynamic>>.from(attr['altTitles']);
      List<LocalizedString> altTitles = alt
          .map((e) => Map.castFrom<String, dynamic, String, String>(e))
          .toList();

      return Manga(
          id: data['id'],
          title: Map.castFrom(attr['title']),
          altTitles: altTitles,
          description: Map.castFrom(attr['description']),
          links: Map.castFrom(attr['links']),
          originalLanguage: attr['originalLanguage'],
          lastVolume: attr['lastVolume'],
          lastChapter: attr['lastChapter'],
          publicationDemographic: attr['publicationDemographic'],
          status: attr['status'],
          year: attr['year'],
          contentRating: attr['contentRating'],
          tags: tags,
          createdAt: DateTime.parse(attr['createdAt']),
          updatedAt: DateTime.parse(attr['updatedAt']),
          version: attr['version'],
          authorId: authorId,
          artistId: artistId,
          coverArt: coverArt);
    }

    throw ArgumentError('Unexpected data retrieval failure');
  }

  String getCovertArtUrl({CoverArtQuality quality = CoverArtQuality.best}) {
    String url = "https://uploads.mangadex.org/covers/$id/$coverArt";

    switch (quality) {
      case CoverArtQuality.best:
        break;
      case CoverArtQuality.medium:
        url += '.512.jpg';
        break;
      case CoverArtQuality.small:
        url += '.256.jpg';
        break;
    }

    return url;
  }
}

class Tag extends MangaDexAPIData {
  final LocalizedString name;
  final String group;
  final int version;

  Tag(
      {required String id,
      required this.name,
      required this.group,
      required this.version})
      : super._(id, 'tag', 65535);

  factory Tag.fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'tag') {
      Map<String, dynamic> attr = json['attributes'];

      return Tag(
        id: json['id'],
        name: Map.castFrom(attr['name']),
        group: attr['group'],
        version: attr['version'],
      );
    }

    throw ArgumentError('Unexpected data retrieval failure');
  }
}
