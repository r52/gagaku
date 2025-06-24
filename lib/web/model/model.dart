import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
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
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:native_dio_adapter/native_dio_adapter.dart' hide URLRequest;
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.g.dart';

void openWebSource(BuildContext context, SourceHandler handle) {
  if (handle.chapter != null) {
    WebReaderData? readerData;

    if (handle.sourceId == 'imgur') {
      final code = '/read/api/imgur/chapter/${handle.location}';
      readerData = WebReaderData(source: code, handle: handle);
    }

    AutoRouter.of(context).push(
      ProxyWebSourceReaderRoute(
        proxy: handle.sourceId,
        code: handle.location,
        chapter: handle.chapter!,
        page: '1',
        readerData: readerData,
      ),
    );
  } else {
    AutoRouter.of(context).push(
      WebMangaViewRoute(
        sourceId: handle.sourceId,
        mangaId: handle.location,
        handle: handle,
      ),
    );
  }
}

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

  Future<HistoryLink> handleLink(HistoryLink link) async {
    if (link.handle != null) {
      final handle = link.handle!;

      if (handle.type == SourceType.source && handle.parser == null) {
        final installed = ref.watch(
          webConfigProvider.select((cfg) => cfg.installedSources),
        );

        final src = installed.firstWhereOrNull(
          (ext) => handle.sourceId == ext.id,
        );

        handle.parser = src;
      }

      return link;
    }

    final handle = await handleUrl(url: link.url);

    if (handle == null) {
      logger.w('Failed to process url ${link.url}');
      return link;
    }

    final updatedLink = link.copyWith(handle: handle);

    webSourceHistoryMutation.run(ref, (ref) async {
      return await ref.get(webSourceHistoryProvider.notifier).add(updatedLink);
    });

    webSourceFavoritesMutation.run(ref, (ref) async {
      return await ref
          .get(webSourceFavoritesProvider.notifier)
          .updateAll(updatedLink);
    });

    return updatedLink;
  }

  Future<SourceHandler?> handleUrl({required String url}) async {
    if (url.startsWith('https://imgur.com/a/')) {
      final src = url.substring(20);
      final handle = SourceHandler(
        type: SourceType.proxy,
        sourceId: 'imgur',
        location: src,
        chapter: '1',
      );

      webSourceHistoryMutation.run(ref, (ref) async {
        return await ref
            .get(webSourceHistoryProvider.notifier)
            .add(HistoryLink(title: url, url: url, handle: handle));
      });

      return handle;
    }

    if (url.startsWith('https://cubari.moe/')) {
      final handle = await _parseProxyUrl(url);
      return handle;
    }

    final installed = ref.watch(
      webConfigProvider.select((cfg) => cfg.installedSources),
    );

    final src = installed.firstWhereOrNull(
      (ext) => url.startsWith('${ext.id}/'),
    );

    if (src == null) {
      logger.w('Extension not found. url: $url');
      return null;
    }

    final parts = url.split('/');
    if (parts.length != 2) {
      logger.w('Invalid extension url $url');
      return null;
    }

    final loc = parts[1];
    final handle = SourceHandler(
      type: SourceType.source,
      sourceId: src.id,
      location: loc,
      parser: src,
    );

    return handle;
  }

  Future<SourceHandler?> _parseProxyUrl(String url) async {
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

        return _parseProxyUrl(location);
    }
  }

  Future<WebManga?> getMangaFromSource(SourceHandler handle) async {
    switch (handle.type) {
      case SourceType.source:
        String? sourceId;
        if (handle.parser != null) {
          sourceId = handle.parser!.id;
        } else {
          final installed = await ref.watch(extensionInfoListProvider.future);
          for (final src in installed) {
            if (handle.sourceId == src.id) {
              sourceId = handle.sourceId;
              break;
            }
          }
        }

        if (sourceId != null) {
          final key = handle.getKey();

          if (await _cache.exists(key)) {
            logger.d('CacheManager: retrieving entry $key');
            final manga = _cache.get<WebManga>(key, WebManga.fromJson);
            return manga;
          }

          final manga = await ref
              .read(extensionSourceProvider(sourceId).notifier)
              .getManga(handle.location);

          if (manga != null) {
            const expiry = Duration(days: 1);

            logger.d(
              'CacheManager: caching entry $key for ${expiry.toString()}',
            );
            _cache.put(
              key,
              json.encode(manga.toJson()),
              manga,
              true,
              expiry: expiry,
            );
          }

          return manga;
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

      const expiry = Duration(days: 1);

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
    final box = Hive.box(gagakuDataBox);
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

  Future<Map<String, List<HistoryLink>>> clear() async {
    await future;
    final empty = <String, List<HistoryLink>>{};

    final box = Hive.box(gagakuDataBox);
    await box.put('web_favorites', json.encode(empty));

    state = AsyncData(empty);

    return empty;
  }

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

    final box = Hive.box(gagakuDataBox);
    await box.put('web_favorites', json.encode(udp));

    state = AsyncData(udp);

    return udp;
  }

  Future<Map<String, List<HistoryLink>>> updateAll(HistoryLink link) async {
    final oldstate = await future;
    for (final cat in oldstate.keys) {
      final idx = oldstate[cat]!.indexOf(link);

      if (idx != -1) {
        oldstate[cat]![idx] = link;
      }
    }

    final udp = {...oldstate};

    final box = Hive.box(gagakuDataBox);
    await box.put('web_favorites', json.encode(udp));

    state = AsyncData(udp);

    return udp;
  }

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

    final box = Hive.box(gagakuDataBox);
    await box.put('web_favorites', json.encode(udp));

    state = AsyncData(udp);

    return udp;
  }

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

    final box = Hive.box(gagakuDataBox);
    await box.put('web_favorites', json.encode(udp));

    state = AsyncData(udp);

    return udp;
  }

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

    final box = Hive.box(gagakuDataBox);
    await box.put('web_favorites', json.encode(udp));

    state = AsyncData(udp);

    return udp;
  }
}

final webSourceFavoritesMutation = Mutation<Map<String, List<HistoryLink>>>();

@Riverpod(keepAlive: true)
class WebSourceHistory extends _$WebSourceHistory {
  static const _numItems = 250;

  Future<Queue<HistoryLink>> _fetch() async {
    final box = Hive.box(gagakuDataBox);
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

  Future<Queue<HistoryLink>> clear() async {
    await future;

    final empty = Queue<HistoryLink>();
    final links = empty.toList();

    final box = Hive.box(gagakuDataBox);
    await box.put('web_history', json.encode(links));

    state = AsyncData(empty);

    return empty;
  }

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

    final box = Hive.box(gagakuDataBox);
    await box.put('web_history', json.encode(links));

    state = AsyncData(cpy);

    return cpy;
  }

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

    final box = Hive.box(gagakuDataBox);
    await box.put('web_history', json.encode(links));

    state = AsyncData(cpy);

    return cpy;
  }
}

final webSourceHistoryMutation = Mutation<Queue<HistoryLink>>();

@Riverpod(keepAlive: true)
class WebReadMarkers extends _$WebReadMarkers {
  Future<Map<String, Set<String>>> _fetch() async {
    final box = Hive.box(gagakuDataBox);
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

  Future<Map<String, Set<String>>> clear() async {
    await future;
    final empty = <String, Set<String>>{};

    final box = Hive.box(gagakuDataBox);
    await box.put('web_read_history', json.encode({}));

    state = AsyncData(empty);

    return empty;
  }

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

    final box = Hive.box(gagakuDataBox);
    await box.put('web_read_history', json.encode(converted));

    state = AsyncData({...oldstate});

    return oldstate;
  }

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

    final box = Hive.box(gagakuDataBox);
    await box.put('web_read_history', json.encode(converted));

    state = AsyncData({...oldstate});

    return oldstate;
  }

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

    final box = Hive.box(gagakuDataBox);
    await box.put('web_read_history', json.encode(converted));

    state = AsyncData({...oldstate});

    return oldstate;
  }
}

final webReadMarkerMutation = Mutation<Map<String, Set<String>>>();

@Riverpod(keepAlive: true)
class ExtensionSource extends _$ExtensionSource {
  HeadlessInAppWebView? _view;
  InAppWebViewController? get _controller =>
      (_view?.isRunning() ?? false) ? _view?.webViewController : null;

  List<SearchFilter>? _filters;
  final Map<String, SettingsForm> _forms = {};

  @override
  Future<WebSourceInfo> build(String sourceId) async {
    final completer = Completer<void>();

    // Let this throw here if not found
    final source = ref.watch(
      webConfigProvider.select(
        (cfg) => cfg.installedSources.firstWhere((e) => e.id == sourceId),
      ),
    );

    try {
      _view = HeadlessInAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(source.baseUrl ?? 'about:blank'),
        ),
        initialSettings: InAppWebViewSettings(isInspectable: kDebugMode),
        onWebViewCreated: (controller) {
          controller.addJavaScriptHandler(
            handlerName: 'resetAllState',
            callback: (JavaScriptHandlerFunctionData data) {
              ref.read(extensionStateProvider.notifier).resetAllState(sourceId);
            },
          );

          controller.addJavaScriptHandler(
            handlerName: 'setExtensionState',
            callback: (JavaScriptHandlerFunctionData data) {
              ref
                  .read(extensionStateProvider.notifier)
                  .setExtensionState(sourceId, data.args[0]);
            },
          );

          controller.addJavaScriptHandler(
            handlerName: 'setExtensionSecureState',
            callback: (JavaScriptHandlerFunctionData data) {
              ref
                  .read(extensionSecureStateProvider.notifier)
                  .setExtensionState(sourceId, data.args[0]);
            },
          );

          controller.addJavaScriptHandler(
            handlerName: 'formDidChange',
            callback: (JavaScriptHandlerFunctionData data) {
              final formId = data.args[0] as String;

              if (!_forms.containsKey(formId)) {
                logger.w('Tried to refresh non-existent form $formId');
                return;
              }

              _forms[formId]!.reloadForm();
            },
          );

          controller.addJavaScriptHandler(
            handlerName: 'initializeForm',
            callback: (JavaScriptHandlerFunctionData data) {
              final formId = data.args[0] as String;

              _forms.putIfAbsent(
                formId,
                () => SettingsForm(id: formId, controller: controller),
              );
            },
          );

          controller.addJavaScriptHandler(
            handlerName: 'uninitializeForms',
            callback: (JavaScriptHandlerFunctionData data) {
              _forms.clear();
            },
          );
        },
        // onConsoleMessage: (controller, consoleMessage) {
        //   logger.d('Console Message: ${consoleMessage.message}');
        // },
        onLoadStop: (controller, url) async {
          await controller.injectJavascriptFileFromAsset(
            assetFilePath: "assets/extensionhost/bundle.js",
          );

          final sourceFile = switch (source.version) {
            SupportedVersion.v0_8 => 'source.js',
            SupportedVersion.v0_9 => 'index.js',
          };

          final scriptUrl = '${source.repo}/${source.id}/$sourceFile';
          final response = await http.get(Uri.parse(scriptUrl));

          if (response.statusCode != 200) {
            final err = "Failed to load $scriptUrl";
            logger.d(err);
            completer.completeError(Exception(err));
            return;
          }

          final script = response.body;
          await controller.evaluateJavascript(source: script);

          if (source.version == SupportedVersion.v0_8) {
            await controller.evaluateJavascript(
              source:
                  "var ${source.id} = window.CompatWrapper({registerHomeSectionsInInitialise: true}, new window.Sources['${source.id}'](window.cheerio));",
            );
          } else {
            // 0.9
            await controller.evaluateJavascript(
              source: "var ${source.id} = window.source.${source.id};",
            );
          }

          // Set extension state
          final extstate = ref
              .read(extensionStateProvider.notifier)
              .getExtensionState(sourceId);
          await controller.callAsyncJavaScript(
            arguments: {'extstate': extstate},
            functionBody: "window.createExtensionState(extstate);",
          );

          final extsecstate = ref
              .read(extensionStateProvider.notifier)
              .getExtensionState(sourceId);
          await controller.callAsyncJavaScript(
            arguments: {'extstate': extsecstate},
            functionBody: "window.createExtensionSecureState(extstate);",
          );

          // Init
          await controller.callAsyncJavaScript(
            functionBody: "return await ${source.id}.initialise();",
          );

          // Get tags
          final result = await controller.callAsyncJavaScript(
            functionBody: "return await ${source.id}?.getSearchFilters();",
          );

          if (result != null && result.value != null) {
            final rsec = result.value as List<dynamic>;
            _filters = rsec.map((e) => SearchFilter.fromJson(e)).toList();
          }

          logger.d("Extension ${source.name} ready");
          completer.complete();
        },
      );
    } catch (e) {
      logger.w('Error creating extension view', error: e);
      completer.completeError(e);
    }

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

  Future<SettingsForm> getSettingsForm() async {
    final source = await future;

    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw Exception("Source does not support settings");
    }

    final result = await _controller?.callAsyncJavaScript(
      functionBody: """
var form = await ${source.id}.getSettingsForm();
form.formWillAppear?.();
var id = await window.initializeForm("main", form);
return id;
""",
    );

    if (result == null || result.error != null) {
      throw Exception('JavaScript error: ${result?.error}');
    }

    final formid = result.value as FormID;

    if (!_forms.containsKey(formid)) {
      throw Exception('Failed to create form $formid');
    }

    return _forms[formid]!;
  }

  Future<SettingsForm> getForm(FormID id) async {
    final source = await future;

    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw Exception("Source does not support settings");
    }

    final result = await _controller?.callAsyncJavaScript(
      arguments: {'formid': id},
      functionBody: """
var form = window.getForm(formid);
if (typeof form === "undefined") {
  return null;
}

form.formWillAppear?.();

return formid;
""",
    );

    if (result == null || result.error != null) {
      throw Exception('JavaScript error: ${result?.error}');
    }

    final formid = result.value as FormID?;

    if (formid == null) {
      throw Exception('Invalid FormID $id');
    }

    if (!_forms.containsKey(formid)) {
      throw Exception('Failed to create form $formid');
    }

    return _forms[formid]!;
  }

  Future<void> uninitializeForms() async {
    final source = await future;

    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw Exception("Source does not support settings");
    }

    await _controller?.evaluateJavascript(
      source: "window.uninitializeForms();",
    );
  }

  Future<List<DiscoverSection>> getDiscoverSections() async {
    final source = await future;

    if (!source.hasCapability(SourceIntents.discoverSections)) {
      throw Exception("Source does not support discover sections");
    }

    final result = await _controller?.callAsyncJavaScript(
      functionBody: "return await $sourceId.getDiscoverSections();",
    );

    if (result == null || result.error != null) {
      throw Exception('JavaScript error: ${result?.error}');
    }

    final rsec = result.value as List<dynamic>;
    final sections = rsec.map((e) => DiscoverSection.fromJson(e)).toList();

    return sections;
  }

  Future<PagedResults<DiscoverSectionItem>> getDiscoverSectionItems(
    DiscoverSection section,
    dynamic metadata,
  ) async {
    final source = await future;

    if (!source.hasCapability(SourceIntents.discoverSections)) {
      throw Exception("Source does not support homepages");
    }

    final result = await _controller?.callAsyncJavaScript(
      arguments: {'section': section.toJson(), 'metadata': metadata},
      functionBody: """
var p = await $sourceId.getDiscoverSectionItems(section, metadata);
p.items.forEach((e) => {
  if ("publishDate" in e) {
    e.publishDate = e.publishDate?.toISOString();
  }
});
return p;
""",
    );

    if (result == null || result.error != null) {
      throw Exception('JavaScript error: ${result?.error}');
    }

    final items = PagedResults.fromJson(
      result.value,
      (e) => DiscoverSectionItem.fromJson(e as dynamic),
    );

    return items;
  }

  Future<PagedResults<SearchResultItem>> searchManga(
    SearchQuery query,
    dynamic metadata,
  ) async {
    await future;

    if (query.title.isEmpty && query.filters.isEmpty) {
      return PagedResults<SearchResultItem>(items: []);
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

    final pmangas = PagedResults.fromJson(
      result.value,
      (e) => SearchResultItem.fromJson(e as dynamic),
    );

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
      arguments: {'manga': smanga.toJson()},
      functionBody: """
var p = await $sourceId.getChapters(manga);
p.forEach((e) => {
  e.publishDate = e.publishDate?.toISOString();
  e.creationDate = e.creationDate?.toISOString();
});
return p;
""",
    );

    if (chaps == null || chaps.error != null) {
      throw Exception('JavaScript error: ${chaps?.error}');
    }

    final clist = chaps.value as List<dynamic>;
    final chapters = clist.map((e) => Chapter.fromJson(e)).toList();
    final chapmap =
        chapters
            .map(
              (e) => ChapterEntry.entry(
                e.chapNum.toString(),
                WebChapter(
                  title: e.title,
                  volume: e.volume?.toString(),
                  groups: {e.version ?? sourceId: e},
                  releaseDate: e.publishDate,
                ),
              ),
            )
            .toList();
    chapmap.sort((a, b) => compareNatural(b.name, a.name));

    final manga = WebManga(
      title: smanga.mangaInfo.primaryTitle,
      description: smanga.mangaInfo.synopsis,
      artist: smanga.mangaInfo.artist ?? 'Unknown',
      author: smanga.mangaInfo.author ?? 'Unknown',
      cover: smanga.mangaInfo.thumbnailUrl,
      chapters: chapmap,
      data: smanga,
    );

    // logger.d(result);

    return manga;
  }

  Future<List<String>> getChapterPages(Chapter chapter) async {
    await future;

    final cdeets = await _controller?.callAsyncJavaScript(
      arguments: {'chapter': chapter.toJson()},
      functionBody: "return await $sourceId.getChapterDetails(chapter);",
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

  Future<List<SearchFilter>?> getFilters() async {
    await future;

    return _filters?.map((e) => e.copyWith()).toList();
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

class SettingsForm with ChangeNotifier {
  SettingsForm({required this.id, required InAppWebViewController controller})
    : _controller = controller;

  final FormID id;
  final InAppWebViewController _controller;

  Future<List<FormSectionElement>> getSections() async {
    final result = await _controller.callAsyncJavaScript(
      functionBody: """
var form = window.getForm("$id");
if (typeof form === "undefined") {
  return [];
}

var p = form.getSections();
var a = p.map((e) => {
  return {
    id: e.id,
    header: e.header,
    footer: e.footer,
    items: e.items
  };
});

a.forEach((e) => {
  e.items.forEach((i) => {
    if ("form" in i) {
      window.initializeForm(i.id, i.form);
      i.form = i.id;
    }
  });
});

return a;
""",
    );

    if (result == null || result.error != null) {
      throw Exception('JavaScript error: ${result?.error}');
    }

    final sections =
        (result.value as List<dynamic>)
            .map((e) => FormSectionElement.fromJson(e))
            .toList();

    return sections;
  }

  Future<bool> requiresExplicitSubmission() async {
    final result = await _controller.callAsyncJavaScript(
      arguments: {'formid': id},
      functionBody: """
var form = window.getForm(formid);
if (typeof form === "undefined") {
  return false;
}

return form.requiresExplicitSubmission();
""",
    );

    if (result == null || result.error != null) {
      throw Exception('JavaScript error: ${result?.error}');
    }

    return result.value as bool;
  }

  Future<void> call(String method) async {
    await _controller.callAsyncJavaScript(
      arguments: {'formid': id},
      functionBody: """
var form = window.getForm(formid);
if (typeof form === "undefined") {
  return;
}

return form.$method?.();
""",
    );
  }

  void reloadForm() {
    _controller.callAsyncJavaScript(
      arguments: {'formid': id},
      functionBody: """
var form = window.getForm(formid);
if (typeof form === "undefined") {
  return;
}

form.formWillAppear?.();
""",
    );

    notifyListeners();
  }

  void uninitialize() {
    _controller.evaluateJavascript(source: "window.uninitializeForms();");
  }
}
