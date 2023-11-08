import 'dart:collection';
import 'dart:convert';

import 'package:gagaku/cache.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/web/types.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.g.dart';

@Riverpod(keepAlive: true)
ProxyHandler proxy(ProxyRef ref) {
  return ProxyHandler(ref);
}

class ProxyHandler {
  ProxyHandler(this.ref) {
    _cache = ref.watch(cacheProvider);
  }

  final Ref ref;
  final http.Client _client = http.Client();
  late final CacheManager _cache;

  Future<void> invalidateCacheItem(String item) async {
    if (await _cache.exists(item)) {
      await _cache.remove(item);
    }
  }

  Future<void> invalidateAll(String startsWith) async {
    await _cache.invalidateAll(startsWith);
  }

  ProxyInfo? parseUrl(String url) {
    var src = url.substring(24);
    var proxy = src.split('/');
    proxy.removeWhere((element) => element.isEmpty);

    if (proxy.length < 2) {
      return null;
    }

    if (proxy.length >= 3) {
      return ProxyInfo(proxy: proxy[0], code: proxy[1], chapter: proxy[2]);
    }

    return ProxyInfo(proxy: proxy[0], code: proxy[1]);
  }

  Future<ProxyData> handleProxy(ProxyInfo info) async {
    ProxyData p = ProxyData();

    switch (info.proxy) {
      // case 'gist':
      //   final manga = await _getMangaFromGist(info.code);
      //   p.manga = manga;
      //   break;
      case 'imgur':
        final code = '/read/api/imgur/chapter/${info.code}';
        p.code = code;
        break;
      default:
        // Generic proxy
        final manga = await _getMangaFromProxy(info);
        p.manga = manga;
        break;
    }

    return p;
  }

  Future<WebManga> _getMangaFromProxy(ProxyInfo info) async {
    final key = info.getKey();
    final url =
        "https://cubari.moe/read/api/${info.proxy}/series/${info.code}/";

    if (await _cache.exists(key)) {
      logger.d('CacheManager: retrieving entry $key');
      return _cache.get<WebManga>(key, WebManga.fromJson);
    }

    final response = await _client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final manga = WebManga.fromJson(body);

      logger.d('CacheManager: caching entry $key');
      _cache.put(key, body, true, const Duration(days: 1));

      return manga;
    }

    throw Exception("Failed to download manga data");
  }

  // Future<WebManga> _getMangaFromGist(ProxyInfo info) async {
  //   var url = '';

  //   if (info.code.length > 5) {
  //     // Pretty bad way of determining whether its an old git.io link but w/e
  //     Codec<String, String> b64 = utf8.fuse(base64Url);
  //     String link = b64.decode(base64.normalize(info.code));
  //     final schema = link.split('/');
  //     var baseUrl = 'https://raw.githubusercontent.com/';

  //     if (schema.isEmpty || schema.length < 3) {
  //       throw Exception("Bad url/gist code ${info.code}");
  //     }

  //     switch (schema[0]) {
  //       case 'raw':
  //         baseUrl = 'https://raw.githubusercontent.com/';
  //         break;
  //       case 'gist':
  //         baseUrl = 'https://gist.githubusercontent.com/';
  //         break;
  //       default:
  //         throw Exception("Unknown schema ${schema[0]}");
  //     }

  //     url = '$baseUrl${link.substring(link.indexOf('/') + 1)}';
  //   } else {
  //     url = 'https://git.io/${info.code}';
  //   }

  //   if (url.isNotEmpty) {
  //     final key = info.getKey();

  //     if (await _cache.exists(key)) {
  //       logger.d('CacheManager: retrieving entry $key');
  //       return _cache.get<WebManga>(key, WebManga.fromJson);
  //     }

  //     final response = await _client.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       final body = json.decode(response.body);
  //       final manga = WebManga.fromJson(body);

  //       logger.d('CacheManager: caching entry $key');
  //       _cache.put(key, body, true, const Duration(days: 1));

  //       return manga;
  //     }
  //   }

  //   // Throw if failure
  //   throw Exception("Failed to download manga data");
  // }

  Future<List<String>> getChapter(String code) async {
    final url = "https://cubari.moe$code";

    final response = await _client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      if (body is List) {
        if (code.contains('imgur')) {
          final imgurlist = body.map((e) => ImgurPage.fromJson(e)).toList();
          final pageList = imgurlist.map((e) => e.src).toList();

          return pageList;
        }

        final pageList = body.map((e) => e as String).toList();
        return pageList;
      }
    }

    throw Exception("Failed to chapter data");
  }
}

@Riverpod(keepAlive: true)
class WebSourceHistory extends _$WebSourceHistory {
  final _numItems = 50;

  Future<Queue<HistoryLink>> _fetch() async {
    final box = Hive.box(gagakuBox);
    final str = box.get('web_history');

    if (str == null || (str as String).isEmpty) {
      return Queue<HistoryLink>();
    }

    final content = json.decode(str) as List<dynamic>;
    final links = content.map((e) => HistoryLink.fromJson(e));

    return Queue.of(links);
  }

  @override
  FutureOr<Queue<HistoryLink>> build() async {
    return _fetch();
  }

  Future<void> clear() async {
    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final empty = Queue<HistoryLink>();
      final links = empty.toList();

      final box = Hive.box(gagakuBox);
      await box.put('web_history', json.encode(links));

      return empty;
    });
  }

  Future<void> add(HistoryLink link) async {
    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    final oldstate = state.valueOrNull ?? Queue<HistoryLink>();
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final cpy = Queue.of(oldstate);

      while (cpy.contains(link)) {
        cpy.remove(link);
      }

      cpy.addFirst(link);

      while (cpy.length > _numItems) {
        cpy.removeLast();
      }

      final links = cpy.map((e) => e.toJson()).toList();

      final box = Hive.box(gagakuBox);
      await box.put('web_history', json.encode(links));

      return cpy;
    });
  }

  Future<void> remove(HistoryLink link) async {
    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    final oldstate = state.valueOrNull ?? Queue<HistoryLink>();
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final cpy = Queue.of(oldstate);

      while (cpy.contains(link)) {
        cpy.remove(link);
      }

      while (cpy.length > _numItems) {
        cpy.removeLast();
      }

      final links = cpy.map((e) => e.toJson()).toList();

      final box = Hive.box(gagakuBox);
      await box.put('web_history', json.encode(links));

      return cpy;
    });
  }
}

@Riverpod(keepAlive: true)
class WebReadMarkers extends _$WebReadMarkers {
  Future<Map<String, Set<String>>> _fetch() async {
    final box = Hive.box(gagakuBox);
    final str = box.get('web_read_history');

    if (str == null || (str as String).isEmpty) {
      return <String, Set<String>>{};
    }

    Map<String, dynamic> content = json.decode(str);
    final markers = content.map((m, s) => MapEntry(m, Set<String>.from(s)));

    return markers;
  }

  @override
  FutureOr<Map<String, Set<String>>> build() async {
    return _fetch();
  }

  Future<void> clear() async {
    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final empty = <String, Set<String>>{};

      final box = Hive.box(gagakuBox);
      await box.put('web_read_history', json.encode({}));

      return empty;
    });
  }

  Future<void> set(String manga, String chapter, bool setRead) async {
    // If state is loading, wait for it first
    if (state.isLoading || state.isReloading) {
      await future;
    }

    final oldstate = state.valueOrNull ?? <String, Set<String>>{};
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final keyExists = oldstate.containsKey(manga);

      // Refresh
      if (keyExists) {
        switch (setRead) {
          case true:
            oldstate[manga]?.add(chapter);
            break;
          case false:
            oldstate[manga]?.remove(chapter);
            break;
        }

        if (oldstate[manga]!.isEmpty) {
          oldstate.remove(manga);
        }
      } else {
        if (setRead) {
          oldstate[manga] = {chapter};
        }
      }

      final converted =
          oldstate.map((key, value) => MapEntry(key, value.toList()));

      final box = Hive.box(gagakuBox);
      await box.put('web_read_history', json.encode(converted));

      return {...oldstate};
    });
  }
}
