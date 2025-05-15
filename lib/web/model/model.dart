import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/util/http.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/server.dart' show port;
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:native_dio_adapter/native_dio_adapter.dart' hide URLRequest;
import 'package:riverpod_annotation/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.g.dart';

@Riverpod(keepAlive: true)
ProxyHandler proxy(Ref ref) {
  return ProxyHandler(ref);
}

class ProxyHandler {
  ProxyHandler(this.ref) {
    _cache = ref.watch(cacheProvider);

    _dio.interceptors.add(RateLimitingInterceptor());
  }

  final Ref ref;

  final _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        validateStatus: (status) => true,
      ),
    )
    ..httpClientAdapter = NativeAdapter(
      createCronetEngine: () => createCronetEngine(getUserAgent(false)),
    );

  late final CacheManager _cache;

  Future<void> invalidateCacheItem(String item) async {
    if (await _cache.exists(item)) {
      await _cache.remove(item);
    }
  }

  Future<void> invalidateAll(String startsWith) async {
    await _cache.invalidateAll(startsWith);
  }

  Future<bool> handleUrl({
    required String url,
    required BuildContext context,
  }) async {
    if (url.startsWith('https://imgur.com/a/')) {
      final src = url.substring(20);
      final code = '/read/api/imgur/chapter/$src';
      AutoRouter.of(context).push(
        ProxyWebSourceReaderRoute(
          proxy: 'imgur',
          code: src,
          chapter: '1',
          page: '1',
          readerData: WebReaderData(
            source: code,
            handle: SourceHandler(
              type: SourceType.proxy,
              sourceId: 'imgur',
              location: src,
            ),
          ),
        ),
      );

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
        AutoRouter.of(context).push(
          ProxyWebSourceReaderRoute(
            proxy: info.sourceId,
            code: info.location,
            chapter: info.chapter!,
            page: '1',
          ),
        );
      } else {
        AutoRouter.of(context).push(
          WebMangaViewRoute(
            sourceId: info.sourceId,
            mangaId: info.location,
            handle: info,
          ),
        );
      }

      return true;
    }

    final installed = ref.watch(
      webConfigProvider.select((cfg) => cfg.installedSources),
    );
    for (final src in installed) {
      if (url.startsWith('${src.id}/')) {
        final parts = url.split('/');
        if (parts.length != 2) {
          continue;
        }
        final loc = parts[1];
        if (!context.mounted) return false;

        AutoRouter.of(context).push(
          WebMangaViewRoute(
            sourceId: src.id,
            mangaId: loc,
            handle: SourceHandler(
              type: SourceType.source,
              sourceId: src.id,
              location: loc,
              parser: src,
            ),
          ),
        );

        return true;
      }
    }

    return false;
  }

  Future<SourceHandler?> parseUrl(String url) async {
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
          return SourceHandler(
            type: SourceType.proxy,
            sourceId: proxy[1],
            location: proxy[2],
            chapter: proxy[3],
          );
        }

        return SourceHandler(
          type: SourceType.proxy,
          sourceId: proxy[1],
          location: proxy[2],
        );
      default:
        logger.d('ProxyHandler: retrieving url $url');

        final response = await _dio.getUri(
          Uri.parse(url),
          options: Options(followRedirects: false),
        );

        if (response.statusCode != 302 ||
            !response.headers.map.containsKey('location') ||
            response.headers['location']!.isEmpty) {
          return null;
        }

        final location = response.headers['location']!.first;

        if (!location.startsWith('/read/')) {
          return null;
        }

        logger.d('ProxyHandler: location $location');

        return parseUrl(location);
    }
  }

  Future<WebManga?> handleSource(SourceHandler handle) async {
    switch (handle.type) {
      case SourceType.source:
        if (handle.parser != null) {
          return await ref
              .read(extensionSourceProvider(handle.parser!.id).notifier)
              .getManga(handle.location);
        } else {
          final installed = await ref.watch(extensionInfoListProvider.future);
          for (final src in installed) {
            if (handle.sourceId == src.id) {
              return await ref
                  .read(extensionSourceProvider(handle.sourceId).notifier)
                  .getManga(handle.location);
            }
          }
        }

        return null;
      case SourceType.proxy:
        return await _getMangaFromProxy(handle);
    }
  }

  Future<WebManga> _getMangaFromProxy(SourceHandler handle) async {
    final key = handle.getKey();
    final url =
        "https://cubari.moe/read/api/${handle.sourceId}/series/${handle.location}/";

    if (await _cache.exists(key)) {
      logger.d('CacheManager: retrieving entry $key');
      return _cache.get<WebManga>(key, WebManga.fromJson);
    }

    final response = await _dio.getUri(Uri.parse(url));

    if (response.statusCode == 200) {
      final manga = WebManga.fromJson(response.data);

      const expiry = Duration(minutes: 15);

      logger.d('CacheManager: caching entry $key for ${expiry.toString()}');
      _cache.put(key, json.encode(manga.toJson()), manga, true, expiry: expiry);

      return manga;
    }

    throw Exception(
      "Failed to download manga data.\nServer returned response code ${response.statusCode}: ${response.statusMessage}",
    );
  }

  Future<dynamic> getProxyAPI(String path) async {
    final url = "https://cubari.moe$path";

    final response = await _dio.getUri(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.data;
    }

    throw Exception(
      "Failed to download API data.\nServer returned response code ${response.statusCode}: ${response.statusMessage}",
    );
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
      return {cfg.defaultCategory: links};
    } else if (content is Map) {
      final map = (content as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List).map((e) => HistoryLink.fromJson(e)).toList(),
        ),
      );

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
  Future<void> clear() async {
    await future;
    final empty = <String, List<HistoryLink>>{};

    final box = Hive.box(gagakuBox);
    await box.put('web_favorites', json.encode(empty));

    state = AsyncData(empty);
  }

  @mutation
  Future<Map<String, List<HistoryLink>>> add(
    String category,
    HistoryLink link,
  ) async {
    final oldstate = await future;
    final list = oldstate[category];

    while (list?.contains(link) ?? false) {
      list?.remove(link);
    }

    oldstate[category] = [link, ...?list];

    final udp = {...oldstate};

    final box = Hive.box(gagakuBox);
    await box.put('web_favorites', json.encode(udp));

    state = AsyncData(udp);

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

    state = AsyncData(udp);

    return udp;
  }

  @mutation
  Future<Map<String, List<HistoryLink>>> remove(
    String category,
    HistoryLink link,
  ) async {
    final oldstate = await future;

    final categoriesToEdit =
        category == 'all' ? oldstate.keys.toList() : [category];

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

    state = AsyncData(udp);

    return udp;
  }

  @mutation
  Future<Map<String, List<HistoryLink>>> updateList(
    String category,
    int oldIndex,
    int newIndex,
  ) async {
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

    state = AsyncData(udp);

    return udp;
  }

  @mutation
  Future<Map<String, List<HistoryLink>>> reconfigureCategories(
    List<WebSourceCategory> categories,
    String defaultCategory,
  ) async {
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

    state = AsyncData(udp);

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

    state = AsyncData(empty);

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

    state = AsyncData(cpy);

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

    state = AsyncData(cpy);

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

    state = AsyncData(empty);

    return empty;
  }

  @mutation
  Future<Map<String, Set<String>>> set(
    String manga,
    String chapter,
    bool setRead,
  ) async {
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

    final converted = oldstate.map(
      (key, value) => MapEntry(key, value.toList()),
    );

    final box = Hive.box(gagakuBox);
    await box.put('web_read_history', json.encode(converted));

    state = AsyncData({...oldstate});

    return oldstate;
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

    final converted = oldstate.map(
      (key, value) => MapEntry(key, value.toList()),
    );

    final box = Hive.box(gagakuBox);
    await box.put('web_read_history', json.encode(converted));

    state = AsyncData({...oldstate});

    return oldstate;
  }

  @mutation
  Future<Map<String, Set<String>>> deleteKey(String manga) async {
    final oldstate = await future;
    final keyExists = oldstate.containsKey(manga);

    // Refresh
    if (keyExists) {
      oldstate.remove(manga);
    }

    final converted = oldstate.map(
      (key, value) => MapEntry(key, value.toList()),
    );

    final box = Hive.box(gagakuBox);
    await box.put('web_read_history', json.encode(converted));

    state = AsyncData({...oldstate});

    return oldstate;
  }
}

@Riverpod(keepAlive: true)
class ExtensionSource extends _$ExtensionSource {
  HeadlessInAppWebView? _view;
  InAppWebViewController? get _controller =>
      (_view?.isRunning() ?? false) ? _view?.webViewController : null;

  List<TagSection>? _tags;

  @override
  Future<WebSourceInfo> build(String sourceId) async {
    final completer = Completer<void>();

    // Let this throw here if not found
    final source = ref.watch(
      webConfigProvider.select(
        (cfg) => cfg.installedSources.firstWhere((e) => e.id == sourceId),
      ),
    );

    _view = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri("http://localhost:$port")),
      initialSettings: InAppWebViewSettings(isInspectable: kDebugMode),
      onWebViewCreated: (controller) {
        controller.addJavaScriptHandler(
          handlerName: 'getState',
          callback: (JavaScriptHandlerFunctionData data) {
            return ref
                .read(extensionStateProvider.notifier)
                .getState(sourceId, data.args[0]);
          },
        );

        controller.addJavaScriptHandler(
          handlerName: 'setState',
          callback: (JavaScriptHandlerFunctionData data) {
            ref
                .read(extensionStateProvider.notifier)
                .setState(sourceId, data.args[0], data.args[1]);
          },
        );

        controller.addJavaScriptHandler(
          handlerName: 'getSecureState',
          callback: (JavaScriptHandlerFunctionData data) {
            return ref
                .read(extensionSecureStateProvider.notifier)
                .getState(sourceId, data.args[0]);
          },
        );

        controller.addJavaScriptHandler(
          handlerName: 'setSecureState',
          callback: (JavaScriptHandlerFunctionData data) {
            ref
                .read(extensionSecureStateProvider.notifier)
                .setState(sourceId, data.args[0], data.args[1]);
          },
        );
      },
      // onConsoleMessage: (controller, consoleMessage) {
      //   logger.d('Console Message: ${consoleMessage.message}');
      // },
      onLoadStop: (controller, url) async {
        final scriptUrl = '${source.repo}/${source.id}/source.js';
        final response = await http.get(Uri.parse(scriptUrl));

        if (response.statusCode != 200) {
          final err = "Failed to load $scriptUrl";
          logger.d(err);
          completer.completeError(err);
          return;
        }

        final script = response.body;
        await controller.evaluateJavascript(source: script);

        await controller.evaluateJavascript(
          source:
              "var ${source.id} = new window.Sources['${source.id}'](window.cheerio);",
        );

        // Get tags
        final result = await _controller?.callAsyncJavaScript(
          functionBody: "return await ${source.id}?.getSearchTags();",
        );

        if (result == null || result.error != null) {
          throw Exception('JavaScript error: ${result?.error}');
        }

        if (result.value != null) {
          final rsec = result.value as List<dynamic>;
          _tags = rsec.map((e) => TagSection.fromJson(e)).toList();
        }

        logger.d("Extension ${source.name} ready");
        completer.complete();
      },
    );

    await _view?.run();
    await completer.future;

    ref.onDispose(() {
      _view?.dispose();
    });

    return source;
  }

  Future<dynamic> callBinding(
    String bindingId, [
    List<dynamic> args = const [],
  ]) async {
    await future;

    final arg = args.map((e) => json.encode(e)).toList().join(",");
    final result = await _controller?.callAsyncJavaScript(
      functionBody: "return await window.callBinding('$bindingId', $arg)",
    );

    return result?.value;
  }

  Future<DUISection> getSourceMenu() async {
    final source = await future;

    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw Exception("Source does not support settings");
    }

    final result = await _controller?.callAsyncJavaScript(
      functionBody: "return await window.processSourceMenu($sourceId)",
    );

    if (result == null || result.error != null) {
      throw Exception('JavaScript error: ${result?.error}');
    }

    final menu = DUIType.fromJson(result.value);
    if (menu is! DUISection) {
      throw Exception("Source getSourceMenu() did not return a valid menu");
    }

    return menu;
  }

  Future<List<HomeSection>> getHomePage() async {
    final source = await future;

    if (!source.hasCapability(SourceIntents.homepageSections)) {
      throw Exception("Source does not support homepages");
    }

    final result = await _controller?.callAsyncJavaScript(
      functionBody: """
var homesections = [];
var cb = function (section) {
  var idx = homesections.findIndex((e) => e.id == section.id);

  if (idx == -1) {
    homesections.push(section);
  } else {
    homesections[idx] = section;
  }
};

await $sourceId.getHomePageSections(cb);
return homesections;
""",
    );

    if (result == null || result.error != null) {
      throw Exception('JavaScript error: ${result?.error}');
    }

    final rsec = result.value as List<dynamic>;
    final sections = rsec.map((e) => HomeSection.fromJson(e)).toList();

    return sections;
  }

  Future<PagedResults> getHomeSectionMore(
    String homepageSectionId,
    dynamic metadata,
  ) async {
    final source = await future;

    if (!source.hasCapability(SourceIntents.homepageSections)) {
      throw Exception("Source does not support homepages");
    }

    final result = await _controller?.callAsyncJavaScript(
      arguments: {'homepageSectionId': homepageSectionId, 'metadata': metadata},
      functionBody: """
return await $sourceId.getViewMoreItems(homepageSectionId, metadata)
""",
    );

    if (result == null || result.error != null) {
      throw Exception('JavaScript error: ${result?.error}');
    }

    final pmangas = PagedResults.fromJson(result.value);

    return pmangas;
  }

  Future<PagedResults> searchManga(
    SearchRequest query,
    dynamic metadata,
  ) async {
    await future;

    if ((query.title == null || query.title!.isEmpty) &&
        query.includedTags.isEmpty) {
      return const PagedResults();
    }

    final params = query.toJson();
    final result = await _controller?.callAsyncJavaScript(
      arguments: {'query': params, 'metadata': metadata},
      functionBody: """
return await $sourceId.getSearchResults(query, metadata)
""",
    );

    if (result == null || result.error != null) {
      throw Exception('JavaScript error: ${result?.error}');
    }

    final pmangas = PagedResults.fromJson(result.value);

    return pmangas;
  }

  Future<WebManga?> getManga(String mangaId) async {
    await future;

    if (mangaId.isEmpty) {
      return null;
    }

    final mdeets = await _controller?.callAsyncJavaScript(
      functionBody: "return await $sourceId.getMangaDetails('$mangaId')",
    );

    if (mdeets == null || mdeets.error != null) {
      throw Exception('JavaScript error: ${mdeets?.error}');
    }

    final smanga = SourceManga.fromJson(mdeets.value);

    final chaps = await _controller?.callAsyncJavaScript(
      functionBody: """
var p = await $sourceId.getChapters('$mangaId');
p.forEach((e) => e.time = e.time.toISOString());
return p;
""",
    );

    if (chaps == null || chaps.error != null) {
      throw Exception('JavaScript error: ${chaps?.error}');
    }

    final clist = chaps.value as List<dynamic>;
    final chapters = clist.map((e) => Chapter.fromJson(e)).toList();
    final chapmap = Map.fromEntries(
      chapters.map(
        (e) => MapEntry(
          e.chapNum.toString(),
          WebChapter(
            title: e.name,
            volume: e.volume?.toString(),
            groups: {e.group ?? sourceId: e},
            releaseDate: e.time,
            data: e,
          ),
        ),
      ),
    );

    final manga = WebManga(
      title: smanga.mangaInfo.titles.first,
      description: smanga.mangaInfo.desc,
      artist: smanga.mangaInfo.artist ?? 'Unknown',
      author: smanga.mangaInfo.author ?? 'Unknown',
      cover: smanga.mangaInfo.image,
      chapters: chapmap,
      data: smanga,
    );

    // logger.d(result);

    return manga;
  }

  Future<List<String>> getChapterPages(String mangaId, String chapterId) async {
    await future;

    if (mangaId.isEmpty || chapterId.isEmpty) {
      return [];
    }

    final cdeets = await _controller?.callAsyncJavaScript(
      functionBody:
          "return await $sourceId.getChapterDetails('$mangaId', '$chapterId')",
    );

    if (cdeets == null || cdeets.error != null) {
      throw Exception('JavaScript error: ${cdeets?.error}');
    }

    final chapterd = ChapterDetails.fromJson(cdeets.value);

    return chapterd.pages;
  }

  Future<String?> getMangaURL(String mangaId) async {
    await future;

    if (mangaId.isEmpty) {
      return null;
    }

    final result = await _controller?.evaluateJavascript(
      source: "$sourceId?.getMangaShareUrl('$mangaId')",
    );

    return result;
  }

  Future<List<TagSection>?> getTags() async {
    await future;
    return _tags;
  }
}

@riverpod
class ExtensionInfoList extends _$ExtensionInfoList {
  @override
  Future<List<WebSourceInfo>> build() async {
    final installed = ref.watch(
      webConfigProvider.select((cfg) => cfg.installedSources),
    );

    return await Future.wait(
      installed.map((i) => ref.watch(extensionSourceProvider(i.id).future)),
    );
  }
}

@Riverpod(retry: noRetry)
Future<WebSourceInfo> getExtensionFromId(Ref ref, String sourceId) async {
  final sources = await ref.watch(extensionInfoListProvider.future);

  return sources.firstWhere((e) => e.id == sourceId);
}
