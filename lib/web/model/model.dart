import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/util/http.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/server.dart' show port;
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.g.dart';

@Riverpod(keepAlive: true)
ProxyHandler proxy(Ref ref) {
  return ProxyHandler(ref);
}

class ProxyHandler {
  ProxyHandler(this.ref) {
    _cache = ref.watch(cacheProvider);
  }

  final Ref ref;
  final http.Client client = CustomClient();
  late final CacheManager _cache;

  Future<void> invalidateCacheItem(String item) async {
    if (await _cache.exists(item)) {
      await _cache.remove(item);
    }
  }

  Future<void> invalidateAll(String startsWith) async {
    await _cache.invalidateAll(startsWith);
  }

  Future<bool> handleUrl({required String url, required BuildContext context}) async {
    if (url.startsWith('https://imgur.com/a/')) {
      final src = url.substring(20);
      final code = '/read/api/imgur/chapter/$src';
      GoRouter.of(context).push('/read/imgur/$src/1/1/',
          extra: WebReaderData(source: code, info: SourceInfo(type: SourceType.proxy, source: 'imgur', location: src)));
      ref.read(webSourceHistoryProvider.add)(HistoryLink(title: url, url: url));
      return true;
    }

    if (url.startsWith('https://cubari.moe/')) {
      final info = await parseUrl(url);

      if (info == null) {
        return false;
      }

      if (!context.mounted) return false;
      if (info.chapter != null) {
        GoRouter.of(context).push('/read/${info.source}/${info.location}/${info.chapter}/1/');
      } else {
        GoRouter.of(context).push('/read/${info.source}/${info.location}', extra: info);
      }

      return true;
    }

    final sourceMgr = await ref.watch(webSourceManagerProvider.future);
    for (final src in sourceMgr) {
      if (url.startsWith('${src.id}/')) {
        final parts = url.split('/');
        if (parts.length != 2) {
          continue;
        }
        final loc = parts[1];
        if (!context.mounted) return false;
        GoRouter.of(context).push('/read/${src.id}/$loc',
            extra: SourceInfo(type: SourceType.source, source: src.id, location: loc, parser: src));
        return true;
      }
    }

    return false;
  }

  Future<SourceInfo?> parseUrl(String url) async {
    var src = cleanBaseDomains(url);

    if (!src.startsWith('/')) {
      return null;
    }

    var proxy = src.split('/');
    proxy.removeWhere((element) => element.isEmpty);

    if (proxy.length < 2) {
      return null;
    }

    switch (proxy[0]) {
      case 'read':
        if (proxy.length >= 4) {
          return SourceInfo(
            type: SourceType.proxy,
            source: proxy[1],
            location: proxy[2],
            chapter: proxy[3],
          );
        }

        return SourceInfo(
          type: SourceType.proxy,
          source: proxy[1],
          location: proxy[2],
        );
      default:
        logger.d('ProxyHandler: retrieving url $url');
        final response = await client.send((http.Request('GET', Uri.parse(url))..followRedirects = false));

        if (response.statusCode != 302 || !response.headers.containsKey('location')) {
          return null;
        }

        final location = response.headers['location']!;

        if (!location.startsWith('/read/')) {
          return null;
        }

        logger.d('ProxyHandler: location $location');

        return parseUrl(location);
    }
  }

  Future<WebManga?> handleSource(SourceInfo info) async {
    switch (info.type) {
      case SourceType.source:
        final srcMgr = await ref.watch(webSourceManagerProvider.future);

        if (info.parser != null) {
          return await ref.read(webSourceManagerProvider.notifier).getManga(info.parser!.id, info.location);
        } else {
          for (final src in srcMgr) {
            if (info.source == src.id) {
              return await ref.read(webSourceManagerProvider.notifier).getManga(src.id, info.location);
            }
          }
        }

        return null;
      case SourceType.proxy:
        return await _getMangaFromProxy(info);
    }
  }

  Future<WebManga> _getMangaFromProxy(SourceInfo info) async {
    final key = info.getKey();
    final url = "https://cubari.moe/read/api/${info.source}/series/${info.location}/";

    if (await _cache.exists(key)) {
      logger.d('CacheManager: retrieving entry $key');
      return _cache.get(key, WebManga.fromJson).get<WebManga>();
    }

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final manga = WebManga.fromJson(body);

      const expiry = Duration(minutes: 15);

      logger.d('CacheManager: caching entry $key for ${expiry.toString()}');
      _cache.put(key, json.encode(manga.toJson()), manga, true, expiry: expiry);

      return manga;
    }

    throw Exception(
        "Failed to download manga data.\nServer returned response code ${response.statusCode}: ${response.reasonPhrase}");
  }

  Future<dynamic> getProxyAPI(String path) async {
    final url = "https://cubari.moe$path";

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      return body;
    }

    throw Exception(
        "Failed to download API data.\nServer returned response code ${response.statusCode}: ${response.reasonPhrase}");
  }
}

@Riverpod(keepAlive: true)
class WebSourceFavorites extends _$WebSourceFavorites {
  Future<Map<String, List<HistoryLink>>> _fetch() async {
    final cfg = ref.read(webConfigProvider);
    final box = Hive.box(gagakuBox);
    final str = box.get('web_favorites');

    if (str == null || (str as String).isEmpty) {
      return {};
    }

    final content = json.decode(str);

    if (content is List) {
      final links = content.map((e) => HistoryLink.fromJson(e)).toList();
      return {
        cfg.defaultCategory: links,
      };
    } else if (content is Map) {
      final map = (content as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, (value as List).map((e) => HistoryLink.fromJson(e)).toList()));

      final keys = map.keys.toList();
      for (final key in keys) {
        // If key doesnt exist in current categories, convert the
        // list to default
        if (cfg.categories.indexWhere((e) => e.id == key) == -1) {
          final list = map.remove(key);
          map[cfg.defaultCategory] = [...?map[cfg.defaultCategory], ...?list];
        }
      }

      return map;
    }

    return {};
  }

  @override
  FutureOr<Map<String, List<HistoryLink>>> build() async {
    return _fetch();
  }

  @mutation
  Future<Map<String, List<HistoryLink>>> clear() async {
    await future;
    final empty = <String, List<HistoryLink>>{};

    final box = Hive.box(gagakuBox);
    await box.put('web_favorites', json.encode(empty));

    return empty;
  }

  @mutation
  Future<Map<String, List<HistoryLink>>> add(String category, HistoryLink link) async {
    final oldstate = await future;
    final list = oldstate[category];

    while (list?.contains(link) ?? false) {
      list?.remove(link);
    }

    oldstate[category] = [link, ...?list];

    final udp = {...oldstate};

    final box = Hive.box(gagakuBox);
    await box.put('web_favorites', json.encode(udp));

    return udp;
  }

  @mutation
  Future<Map<String, List<HistoryLink>>> updateAll(HistoryLink link) async {
    final oldstate = await future;
    for (final cat in oldstate.keys) {
      final idx = oldstate[cat]!.indexOf(link);

      if (idx != -1) {
        oldstate[cat]![idx] = link;
      }
    }

    final udp = {...oldstate};

    final box = Hive.box(gagakuBox);
    await box.put('web_favorites', json.encode(udp));

    return udp;
  }

  @mutation
  Future<Map<String, List<HistoryLink>>> remove(String category, HistoryLink link) async {
    final oldstate = await future;

    final categoriesToEdit = category == 'all' ? oldstate.keys.toList() : [category];

    for (final c in categoriesToEdit) {
      final list = oldstate[c];

      while (list?.contains(link) ?? false) {
        list?.remove(link);
      }

      oldstate[c] = [...?list];
    }

    final udp = {...oldstate};

    final box = Hive.box(gagakuBox);
    await box.put('web_favorites', json.encode(udp));

    return udp;
  }

  @mutation
  Future<Map<String, List<HistoryLink>>> updateList(String category, int oldIndex, int newIndex) async {
    final oldstate = await future;
    if (oldIndex < newIndex) {
      // removing the item at oldIndex will shorten the list by 1.
      newIndex -= 1;
    }

    if (oldstate.containsKey(category)) {
      final element = oldstate[category]!.removeAt(oldIndex);
      oldstate[category]!.insert(newIndex, element);
    }

    final udp = {...oldstate};

    final box = Hive.box(gagakuBox);
    await box.put('web_favorites', json.encode(udp));

    return udp;
  }

  @mutation
  Future<Map<String, List<HistoryLink>>> reconfigureCategories(
      List<WebSourceCategory> categories, String defaultCategory) async {
    final oldstate = await future;

    // Move all deleted category lists to default
    final oldkeys = oldstate.keys.toList();
    for (final oldcat in oldkeys) {
      if (categories.indexWhere((e) => e.id == oldcat) == -1) {
        final list = oldstate.remove(oldcat);
        oldstate[defaultCategory] = [...?oldstate[defaultCategory], ...?list];
      }
    }

    final udp = {...oldstate};

    final box = Hive.box(gagakuBox);
    await box.put('web_favorites', json.encode(udp));

    return udp;
  }
}

@Riverpod(keepAlive: true)
class WebSourceHistory extends _$WebSourceHistory {
  static const _numItems = 250;

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

  @mutation
  Future<Queue<HistoryLink>> clear() async {
    await future;

    final empty = Queue<HistoryLink>();
    final links = empty.toList();

    final box = Hive.box(gagakuBox);
    await box.put('web_history', json.encode(links));

    return empty;
  }

  @mutation
  Future<Queue<HistoryLink>> add(HistoryLink link) async {
    final oldstate = await future;
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
  }

  @mutation
  Future<Queue<HistoryLink>> remove(HistoryLink link) async {
    final oldstate = await future;
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

  @mutation
  Future<Map<String, Set<String>>> clear() async {
    await future;
    final empty = <String, Set<String>>{};

    final box = Hive.box(gagakuBox);
    await box.put('web_read_history', json.encode({}));

    return empty;
  }

  @mutation
  Future<Map<String, Set<String>>> set(String manga, String chapter, bool setRead) async {
    final oldstate = await future;
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

    final converted = oldstate.map((key, value) => MapEntry(key, value.toList()));

    final box = Hive.box(gagakuBox);
    await box.put('web_read_history', json.encode(converted));

    return {...oldstate};
  }

  @mutation
  Future<Map<String, Set<String>>> setBulk(
    String manga, {
    Iterable<String>? read,
    Iterable<String>? unread,
  }) async {
    final oldstate = await future;
    final keyExists = oldstate.containsKey(manga);

    // Refresh
    if (keyExists) {
      if (read != null) {
        oldstate[manga]?.addAll(read);
      }

      if (unread != null) {
        oldstate[manga]?.removeAll(unread);
      }

      if (oldstate[manga]!.isEmpty) {
        oldstate.remove(manga);
      }
    } else {
      if (read != null) {
        oldstate[manga] = {...read};
      }

      if (unread != null) {
        oldstate[manga] = {};
      }
    }

    final converted = oldstate.map((key, value) => MapEntry(key, value.toList()));

    final box = Hive.box(gagakuBox);
    await box.put('web_read_history', json.encode(converted));

    return {...oldstate};
  }

  @mutation
  Future<Map<String, Set<String>>> deleteKey(String manga) async {
    final oldstate = await future;
    final keyExists = oldstate.containsKey(manga);

    // Refresh
    if (keyExists) {
      oldstate.remove(manga);
    }

    final converted = oldstate.map((key, value) => MapEntry(key, value.toList()));

    final box = Hive.box(gagakuBox);
    await box.put('web_read_history', json.encode(converted));

    return {...oldstate};
  }
}

@Riverpod(keepAlive: true)
class WebSourceManager extends _$WebSourceManager {
  HeadlessInAppWebView? _view;
  InAppWebViewController? _controller;

  @override
  Future<List<WebSourceInfo>> build() async {
    final completer = Completer<void>();
    final cfg = ref.watch(webConfigProvider);
    final installed = cfg.installedSources;

    _view = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri("http://localhost:$port")),
      initialSettings: InAppWebViewSettings(isInspectable: kDebugMode),
      onWebViewCreated: (controller) {},
      onConsoleMessage: (controller, consoleMessage) {
        logger.d('Console Message: ${consoleMessage.message}');
      },
      onLoadStop: (controller, url) async {
        for (final source in installed) {
          final scriptUrl = '${source.repo}/${source.id}/source.js';
          final response = await http.get(Uri.parse(scriptUrl));

          if (response.statusCode != 200) {
            logger.d("Failed to load $scriptUrl");
            continue;
          }

          final script = response.body;
          await controller.evaluateJavascript(source: script);

          await controller.evaluateJavascript(
              source: "var ${source.id} = new window.Sources['${source.id}'](window.cheerio);");
        }

        _controller = controller;
        logger.d("Extension host ready");
        completer.complete();
      },
    );

    ref.onDispose(() {
      _view?.dispose();
      _controller = null;
    });

    await _view?.run();
    await completer.future;

    return installed;
  }

  Future<List<HistoryLink>> searchManga(String sourceId, SearchRequest query) async {
    await future;

    if ((query.title == null || query.title!.isEmpty) && query.includedTags == null) {
      return [];
    }

    if (_controller != null) {
      String q = json.encode(query.toJson());
      final result = await _controller!.callAsyncJavaScript(functionBody: """
var query = $q;
return await $sourceId.getSearchResults(query, undefined)
""");

      final pmangas = PagedResults.fromJson(result!.value);

      if (pmangas.results == null) {
        return [];
      }

      final links = pmangas.results!
          .map((e) => HistoryLink(title: e.title, url: '$sourceId/${e.mangaId}', cover: e.image))
          .toList();

      // logger.d(result);

      return links;
    }

    throw Exception("Uninitialized view controller");
  }

  Future<WebManga?> getManga(String sourceId, String mangaId) async {
    await future;

    if (mangaId.isEmpty) {
      return null;
    }

    if (_controller != null) {
      final mdeets =
          await _controller!.callAsyncJavaScript(functionBody: "return await $sourceId.getMangaDetails('$mangaId')");

      final smanga = SourceManga.fromJson(mdeets!.value);

      final chaps = await _controller!.callAsyncJavaScript(
        functionBody: """
var p = await $sourceId.getChapters('$mangaId');
p.forEach((e) => e.time = e.time.toISOString());
return p;
""",
      );

      final clist = chaps!.value as List<dynamic>;
      final chapters = clist.map((e) => Chapter.fromJson(e)).toList();
      final chapmap = Map.fromEntries(chapters.map((e) => MapEntry(
          e.chapNum.toString(),
          WebChapter(
            title: e.name,
            volume: e.volume?.toString(),
            groups: {e.group ?? sourceId: e.id},
            releaseDate: e.time,
          ))));

      final manga = WebManga(
        title: smanga.mangaInfo.titles.first,
        description: smanga.mangaInfo.desc,
        artist: smanga.mangaInfo.artist ?? 'Unknown',
        author: smanga.mangaInfo.author ?? 'Unknown',
        cover: smanga.mangaInfo.image,
        chapters: chapmap,
      );

      // logger.d(result);

      return manga;
    }

    throw Exception("Uninitialized view controller");
  }

  Future<List<String>> getChapterPages(String sourceId, String mangaId, String chapterId) async {
    await future;

    if (mangaId.isEmpty || chapterId.isEmpty) {
      return [];
    }

    if (_controller != null) {
      final cdeets = await _controller!
          .callAsyncJavaScript(functionBody: "return await $sourceId.getChapterDetails('$mangaId', '$chapterId')");

      final chapterd = ChapterDetails.fromJson(cdeets!.value);

      return chapterd.pages;
    }

    throw Exception("Uninitialized view controller");
  }

  Future<String> getMangaURL(String sourceId, String mangaId) async {
    await future;

    if (mangaId.isEmpty) {
      return '';
    }

    if (_controller != null) {
      final result = await _controller!.evaluateJavascript(source: "$sourceId.getMangaShareUrl('$mangaId')");

      return result as String;
    }

    throw Exception("Uninitialized view controller");
  }
}
