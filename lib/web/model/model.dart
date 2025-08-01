import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/util/http.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:http/http.dart' as http;
import 'package:native_dio_adapter/native_dio_adapter.dart' hide URLRequest;
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.g.dart';

const historyListUUID = 'd6f79229-6f8e-4872-9610-5200a54aef8f';

void openWebSource(BuildContext context, SourceHandler handle) {
  if (handle.chapter != null) {
    WebReaderData? readerData;

    if (handle.sourceId == 'imgur') {
      final code = '/read/api/imgur/chapter/${handle.location}';
      readerData = WebReaderData(source: code, handle: handle);
    }

    context.router.push(
      ProxyWebSourceReaderRoute(
        proxy: handle.sourceId,
        code: handle.location,
        chapter: handle.chapter!,
        page: '1',
        readerData: readerData,
      ),
    );
  } else {
    context.router.push(
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

  final _dio =
      Dio(
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
      return link;
    }

    final handle = await handleUrl(url: link.url);

    if (handle == null) {
      logger.w('Failed to process url ${link.url}');
      return link;
    }

    final updatedLink = link.copyWith(handle: handle);

    WebHistoryManager().add(updatedLink);

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

      WebHistoryManager().add(
        HistoryLink(
          title: url,
          url: url,
          handle: handle,
          lastAccessed: DateTime.now(),
        ),
      );

      return handle;
    }

    if (url.startsWith('https://cubari.moe/')) {
      final handle = await _parseProxyUrl(url);
      return handle;
    }

    final parts = url.split('/');
    if (parts.length != 2) {
      logger.w('Invalid extension url $url');
      return null;
    }

    final srcId = parts[0];

    final installed = await ref.watch(extensionInfoListProvider.future);
    final src = installed[srcId];

    if (src == null) {
      logger.w('Extension not found. url: $url');
      return null;
    }

    final loc = parts[1];
    final handle = SourceHandler(
      type: SourceType.source,
      sourceId: src.id,
      location: loc,
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
        final key = handle.getKey();

        if (await _cache.exists(key)) {
          logger.d('CacheManager: retrieving entry $key');
          final manga = _cache.get<WebManga>(key, WebManga.fromJson);
          return manga;
        }

        final manga = await ref
            .read(extensionSourceProvider(handle.sourceId).notifier)
            .getManga(handle.location);

        if (manga != null) {
          const expiry = Duration(days: 1);

          logger.d('CacheManager: caching entry $key for ${expiry.toString()}');
          _cache.put(
            key,
            json.encode(manga.toJson()),
            manga,
            true,
            expiry: expiry,
          );
        }

        return manga;

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
  @override
  Stream<List<WebFavoritesList>> build() async* {
    final box = GagakuData().store.box<WebFavoritesList>();
    final stream = box
        .query(WebFavoritesList_.id.notEquals(historyListUUID))
        .order(WebFavoritesList_.sortOrder)
        .watch(triggerImmediately: true)
        .map((query) => query.find());

    await for (final items in stream) {
      yield items;
    }
  }

  Future<void> add(WebFavoritesList list, HistoryLink link) async {
    await GagakuData().store.runInTransactionAsync(TxMode.write, (store, _) {
      final linkBox = store.box<HistoryLink>();
      final listBox = store.box<WebFavoritesList>();

      // Add/update link
      link.resolveDb(store: store, copyParams: true);
      linkBox.put(link);

      // Add link to list
      if (list.list.contains(link)) {
        // noop if link already exists
        return;
      }

      list.list.add(link);
      listBox.put(list);
    }, null);
  }

  Future<void> remove(WebFavoritesList list, HistoryLink link) async {
    await GagakuData().store.runInTransactionAsync(TxMode.write, (store, _) {
      final listBox = store.box<WebFavoritesList>();
      link.resolveDb(store: store);

      list.list.remove(link);
      listBox.put(list);
    }, null);
  }

  Future<void> removeFromAll(HistoryLink link) async {
    await GagakuData().store.runInTransactionAsync(TxMode.write, (store, _) {
      final listBox = store.box<WebFavoritesList>();
      link.resolveDb(store: store);

      final listQuery = listBox
          .query(WebFavoritesList_.id.notEquals(historyListUUID))
          .order(WebFavoritesList_.sortOrder)
          .build();
      final lists = listQuery.find();

      for (final l in lists) {
        l.list.remove(link);
      }

      listBox.putMany(lists);
    }, null);
  }
}

final webSourceFavoritesMutation = Mutation<void>();

class WebHistoryManager {
  static final WebHistoryManager _instance = WebHistoryManager._internal();

  static const _numItems = 250;

  WebHistoryManager._internal() {
    final store = GagakuData().store;
    final listBox = store.box<WebFavoritesList>();

    final query = listBox
        .query(WebFavoritesList_.id.equals(historyListUUID))
        .build();

    WebFavoritesList? historyList;
    historyList = query.findUnique();
    query.close();

    if (historyList == null) {
      historyList = WebFavoritesList(
        id: historyListUUID,
        name: 'extension_history',
      );
      listBox.put(historyList);
    }
  }

  factory WebHistoryManager() {
    return _instance;
  }

  Future<void> clear() async {
    await GagakuData().store.runInTransactionAsync(TxMode.write, (store, _) {
      final listBox = store.box<WebFavoritesList>();
      final query = listBox
          .query(WebFavoritesList_.id.equals(historyListUUID))
          .build();

      final list = query.findUnique()!;
      query.close();

      list.list.clear();
      listBox.put(list);
    }, null);
  }

  Future<void> add(HistoryLink link) async {
    await GagakuData().store.runInTransactionAsync(TxMode.write, (store, _) {
      final listBox = store.box<WebFavoritesList>();
      final linkBox = store.box<HistoryLink>();
      final listquery = listBox
          .query(WebFavoritesList_.id.equals(historyListUUID))
          .build();

      final list = listquery.findUnique()!;
      listquery.close();

      // Add/update link
      link.resolveDb(store: store);
      linkBox.put(link);

      // Add to list
      if (list.list.contains(link)) {
        // noop if link already exists
        return;
      }

      list.list.add(link);

      if (list.list.length > _numItems) {
        final items = list.list.toList();
        items.sort(HistoryLink.lastAccessCompare);

        final toRemove = items.sublist(250);

        for (final i in toRemove) {
          list.list.remove(i);
        }
      }

      listBox.put(list);
    }, null);
  }

  Future<void> remove(HistoryLink link) async {
    await GagakuData().store.runInTransactionAsync(TxMode.write, (store, _) {
      final listBox = store.box<WebFavoritesList>();
      final query = listBox
          .query(WebFavoritesList_.id.equals(historyListUUID))
          .build();

      final list = query.findUnique()!;
      query.close();

      link.resolveDb(store: store);

      if (list.list.contains(link)) {
        list.list.remove(link);
      }

      if (list.list.length > _numItems) {
        final items = list.list.toList();
        items.sort(HistoryLink.lastAccessCompare);

        final toRemove = items.sublist(250);

        for (final i in toRemove) {
          list.list.remove(i);
        }
      }

      listBox.put(list);
    }, null);
  }
}

@Riverpod(keepAlive: true)
class WebReadMarkers extends _$WebReadMarkers {
  Future<ReadMarkersDB> _fetch() async {
    final box = GagakuData().store.box<ReadMarkersDB>();
    final query = box.query().build();

    ReadMarkersDB? db;
    db = query.findUnique();
    query.close();

    if (db == null) {
      db = ReadMarkersDB();
      box.put(db);
    }

    return db;
  }

  @override
  FutureOr<ReadMarkersDB> build() async {
    return _fetch();
  }

  Future<ReadMarkersDB> clear() async {
    ReadMarkersDB db = await future;
    db.markers.clear();

    final box = GagakuData().store.box<ReadMarkersDB>();
    db = db.copyWith();
    box.put(db);

    state = AsyncData(db);

    return db;
  }

  Future<ReadMarkersDB> set(String manga, String chapter, bool setRead) async {
    ReadMarkersDB db = await future;
    final keyExists = db.markers.containsKey(manga);

    // Refresh
    if (keyExists) {
      switch (setRead) {
        case true:
          db.markers[manga]?.add(chapter);
          break;
        case false:
          db.markers[manga]?.remove(chapter);
          break;
      }

      if (db.markers[manga]!.isEmpty) {
        db.markers.remove(manga);
      }
    } else {
      if (setRead) {
        db.markers[manga] = {chapter};
      }
    }

    final box = GagakuData().store.box<ReadMarkersDB>();
    db = db.copyWith();
    box.put(db);

    state = AsyncData(db);

    return db;
  }

  Future<ReadMarkersDB> setBulk(
    String manga, {
    Iterable<String>? read,
    Iterable<String>? unread,
  }) async {
    ReadMarkersDB db = await future;
    final keyExists = db.markers.containsKey(manga);

    // Refresh
    if (keyExists) {
      if (read != null) {
        db.markers[manga]?.addAll(read);
      }

      if (unread != null) {
        db.markers[manga]?.removeAll(unread);
      }

      if (db.markers[manga]!.isEmpty) {
        db.markers.remove(manga);
      }
    } else {
      if (read != null) {
        db.markers[manga] = {...read};
      }

      if (unread != null) {
        db.markers[manga] = {};
      }
    }

    final box = GagakuData().store.box<ReadMarkersDB>();
    db = db.copyWith();
    box.put(db);

    state = AsyncData(db);

    return db;
  }

  Future<ReadMarkersDB> deleteKey(String manga) async {
    ReadMarkersDB db = await future;
    final keyExists = db.markers.containsKey(manga);

    // Refresh
    if (keyExists) {
      db.markers.remove(manga);
    }

    final box = GagakuData().store.box<ReadMarkersDB>();
    db = db.copyWith();
    box.put(db);

    state = AsyncData(db);

    return db;
  }
}

final webReadMarkerMutation = Mutation<ReadMarkersDB>();

@riverpod
Stream<List<WebSourceInfo>> installedSources(Ref ref) async* {
  final box = GagakuData().store.box<WebSourceInfo>();
  final stream = box
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  await for (final items in stream) {
    yield items;
  }
}

@Riverpod(keepAlive: true)
class ExtensionSource extends _$ExtensionSource {
  HeadlessInAppWebView? _view;
  InAppWebViewController? get _controller =>
      (_view?.isRunning() ?? false) ? _view?.webViewController : null;

  List<SearchFilter>? _filters;
  final Map<String, SettingsForm> _forms = {};

  @override
  Future<WebSourceInfo> build(String sourceId) async {
    WebSourceInfo? source;
    try {
      final box = GagakuData().store.box<WebSourceInfo>();
      final query = box.query(WebSourceInfo_.id.equals(sourceId)).build();
      source = await query.findUniqueAsync();
      if (source == null) {
        throw Exception("Source $sourceId failed to initialize: not installed");
      }
    } catch (e) {
      logger.e('Error retrieving source info from database', error: e);
      rethrow; // Re-throw to prevent further execution
    }

    final completer = Completer<void>();

    try {
      _view = HeadlessInAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(source.baseUrl ?? 'about:blank'),
        ),
        initialSettings: InAppWebViewSettings(isInspectable: kDebugMode),
        onWebViewCreated: (controller) {
          _setupJavaScriptHandlers(controller, sourceId);
        },
        onLoadStop: (controller, url) =>
            _onWebViewLoadStop(controller, url, source!, completer),
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

  void _setupJavaScriptHandlers(
    InAppWebViewController controller,
    String sourceId,
  ) {
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
  }

  Future<void> _onWebViewLoadStop(
    InAppWebViewController controller,
    Uri? url,
    WebSourceInfo source,
    Completer<void> completer,
  ) async {
    try {
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

      final sourceId = source.id;

      final initScript = switch (source.version) {
        SupportedVersion.v0_8 =>
          "var ${source.id} = window.CompatWrapper({registerHomeSectionsInInitialise: true}, new window.Sources['${source.id}'](window.cheerio));",
        SupportedVersion.v0_9 =>
          "var ${source.id} = window.source.${source.id};",
      };
      await controller.evaluateJavascript(source: initScript);

      // Set extension state
      final extstate = ref
          .read(extensionStateProvider.notifier)
          .getExtensionState(sourceId);
      await controller.callAsyncJavaScript(
        arguments: {'extstate': extstate},
        functionBody: "window.Application.createExtensionState(extstate);",
      );

      final extsecstate = ref
          .read(extensionStateProvider.notifier)
          .getExtensionState(sourceId);
      await controller.callAsyncJavaScript(
        arguments: {'extstate': extsecstate},
        functionBody:
            "window.Application.createExtensionSecureState(extstate);",
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
    } catch (e) {
      logger.e('Error during WebView load stop', error: e);
      completer.completeError(e);
    }
  }

  Future<dynamic> callBinding(
    String bindingId, [
    List<dynamic> args = const [],
  ]) async {
    await future;

    final arg = args.map((e) => json.encode(e)).toList().join(",");
    final result = await _controller?.callAsyncJavaScript(
      functionBody:
          "return await window.Application.callBinding('$bindingId', $arg)",
    );

    return result?.value;
  }

  Future<SettingsForm> getSettingsForm() async {
    final source = await future;

    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw Exception("Source does not support settings");
    }

    final result = await _controller?.callAsyncJavaScript(
      functionBody:
          """
var form = await ${source.id}.getSettingsForm();
form.formWillAppear?.();
var id = await window.Application.initializeForm("main", form);
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
var form = window.Application.getForm(formid);
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
      source: "window.Application.uninitializeForms();",
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
      throw Exception("Source does not support discover sections");
    }

    final result = await _controller?.callAsyncJavaScript(
      arguments: {'section': section.toJson(), 'metadata': metadata},
      functionBody:
          """
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
      functionBody:
          """
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
      functionBody:
          """
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
    final chapmap = chapters
        .map(
          (e) => ChapterEntry(
            name: e.chapNum.toString(),
            chapter: WebChapter(
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
  Future<Map<String, WebSourceInfo>> build() async {
    final installed = await ref.watch(installedSourcesProvider.future);

    final list = await Future.wait(
      installed.map((i) => ref.watch(extensionSourceProvider(i.id).future)),
    );

    final map = <String, WebSourceInfo>{for (var e in list) e.id: e};

    return map;
  }
}

@Riverpod(retry: noRetry)
Future<WebSourceInfo> getExtensionFromId(Ref ref, String sourceId) async {
  final sources = await ref.watch(extensionInfoListProvider.future);

  if (sources.containsKey(sourceId)) {
    return sources[sourceId]!;
  }

  throw Exception("Invalid missing/source '$sourceId'");
}

class SettingsForm with ChangeNotifier {
  SettingsForm({required this.id, required InAppWebViewController controller})
    : _controller = controller;

  final FormID id;
  final InAppWebViewController _controller;

  Future<List<FormSectionElement>> getSections() async {
    final result = await _controller.callAsyncJavaScript(
      functionBody:
          """
var form = window.Application.getForm("$id");
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
      window.Application.initializeForm(i.id, i.form);
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

    final sections = (result.value as List<dynamic>)
        .map((e) => FormSectionElement.fromJson(e))
        .toList();

    return sections;
  }

  Future<bool> requiresExplicitSubmission() async {
    final result = await _controller.callAsyncJavaScript(
      arguments: {'formid': id},
      functionBody: """
var form = window.Application.getForm(formid);
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
      functionBody:
          """
var form = window.Application.getForm(formid);
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
var form = window.Application.getForm(formid);
if (typeof form === "undefined") {
  return;
}

form.formWillAppear?.();
""",
    );

    notifyListeners();
  }

  void uninitialize() {
    _controller.evaluateJavascript(
      source: "window.Application.uninitializeForms();",
    );
  }
}
