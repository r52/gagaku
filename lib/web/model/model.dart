import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/util/http.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

    ProxyWebSourceReaderRoute(
      proxy: handle.sourceId,
      code: handle.location,
      chapter: handle.chapter!,
      page: '1',
      $extra: readerData,
    ).push(context);
  } else {
    WebMangaViewRoute(
      sourceId: handle.sourceId,
      mangaId: handle.location,
      handle: handle,
    ).push(context);
  }
}

String _processReferrer(String? baseUrl) {
  String referrer = baseUrl ?? '';

  if (referrer.isNotEmpty) {
    if (!referrer.startsWith('https://')) {
      referrer = 'https://$referrer';
    }

    if (!referrer.endsWith('/')) {
      referrer = '$referrer/';
    }
  }

  return referrer;
}

@riverpod
Map<String, String> extensionReferrer(Ref ref) {
  final refer = ref.watch(
    installedSourcesProvider.select(
      (value) => switch (value) {
        AsyncValue(value: final data?) => {
          for (final ext in data) ext.id: _processReferrer(ext.baseUrl),
        },
        _ => <String, String>{},
      },
    ),
  );

  return UnmodifiableMapView(refer);
}

@Riverpod(keepAlive: true)
ProxyHandler proxy(Ref ref) {
  return ProxyHandler(ref);
}

class ProxyHandler {
  ProxyHandler(this.ref) : _cache = ref.read(cacheProvider);

  final Ref ref;
  final CacheManager _cache;

  late final Dio _dio = _createDio();

  static const _imgurHost = 'imgur.com';
  static const _imgurAlbumUrlPrefix = '/a/';
  static const _cubariHost = 'cubari.moe';
  static const _cubariReadPrefix = '/read/';
  static const _cubariApiBase = 'https://cubari.moe/read/api';

  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        validateStatus: (status) => true,
      ),
    );
    dio.httpClientAdapter = NativeAdapter(
      createCronetEngine: () => createCronetEngine(getUserAgent(false)),
    );
    dio.interceptors.add(RateLimitingInterceptor());
    return dio;
  }

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

  SourceHandler _handleImgurUrl(Uri uri) {
    final src = uri.path.substring(_imgurAlbumUrlPrefix.length);
    final handle = SourceHandler(
      type: SourceType.proxy,
      sourceId: 'imgur',
      location: src,
      chapter: '1',
    );

    WebHistoryManager().add(
      HistoryLink(
        title: uri.toString(),
        url: uri.toString(),
        handle: handle,
        lastAccessed: DateTime.now(),
      ),
    );

    return handle;
  }

  Future<SourceHandler?> _handleExtensionUrl(Uri uri) async {
    final parts = uri.pathSegments.toList();
    if (parts.length != 2) {
      logger.w('Invalid extension url ${uri.toString()}');
      return null;
    }

    final srcId = parts[0];

    WebSourceInfo? src;

    try {
      src = await ref.read(extensionSourceProvider(srcId).future);
    } catch (e) {
      logger.w('extensionSourceProvider($srcId) failed');
      src = null;
    }

    if (src == null) {
      logger.w('Extension not found. url: ${uri.toString()}');
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

  Future<SourceHandler?> _parseCubariReadPath(Uri uri) async {
    if (uri.path.isEmpty || uri.pathSegments.isEmpty) {
      return null;
    }

    var proxy = uri.pathSegments.toList();
    proxy.removeWhere((element) => element.isEmpty);

    if (proxy.length < 2) {
      return null;
    }

    if (proxy[0] != 'read') {
      return null;
    }

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
  }

  Future<SourceHandler?> _handleProxyUrl(Uri uri) async {
    if (!uri.path.startsWith(_cubariReadPrefix)) {
      logger.d('ProxyHandler: retrieving url ${uri.toString()}');

      final response = await _dio.getUri(
        uri,
        options: Options(followRedirects: false),
      );

      if (response.statusCode != 302 ||
          response.headers.value('location') == null ||
          response.headers['location']!.isEmpty) {
        return null;
      }

      final location = response.headers['location']!.first;

      if (!location.startsWith(_cubariReadPrefix)) {
        return null;
      }

      logger.d('ProxyHandler: location $location');

      uri = Uri.parse(location);
    }

    return _parseCubariReadPath(uri);
  }

  Future<SourceHandler?> handleUrl({required String url}) async {
    final uri = Uri.parse(url);

    if (uri.host == _imgurHost && uri.path.startsWith(_imgurAlbumUrlPrefix)) {
      return _handleImgurUrl(uri);
    }

    if (uri.host == _cubariHost) {
      return _handleProxyUrl(uri);
    }

    return _handleExtensionUrl(uri);
  }

  Future<WebManga?> _getCachedMangaOrNull(String key) async {
    if (await _cache.exists(key)) {
      logger.d('CacheManager: retrieving entry $key');
      return _cache.get<WebManga>(key, WebManga.fromJson);
    }

    return null;
  }

  Future<WebManga?> getMangaFromSource(SourceHandler handle) async {
    switch (handle.type) {
      case SourceType.source:
        final key = handle.getKey();
        WebManga? manga;

        manga = await _getCachedMangaOrNull(key);

        if (manga != null) {
          return manga;
        }

        manga = await ref
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

  Future<WebManga?> _getMangaFromProxy(SourceHandler handle) async {
    final key = handle.getKey();
    final url = "$_cubariApiBase/${handle.sourceId}/series/${handle.location}/";

    final cached = await _getCachedMangaOrNull(key);

    if (cached != null) {
      return cached;
    }

    final response = await _dio.getUri(Uri.parse(url));

    if (response.statusCode == 200) {
      final manga = WebManga.fromJson(response.data);

      const expiry = Duration(days: 1);

      logger.d('CacheManager: caching entry $key for ${expiry.toString()}');
      _cache.put(key, json.encode(manga.toJson()), manga, true, expiry: expiry);

      return manga;
    }

    logger.d(
      "Failed to download manga data.\nServer returned response code ${response.statusCode}: ${response.statusMessage}",
    );

    return null;
  }

  Future<dynamic> getProxyAPI(String path) async {
    final url = "https://cubari.moe$path";

    final response = await _dio.getUri(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.data;
    }

    throw ApiException(
      message: 'Failed to download API data',
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }
}

class WebFavoritesManager extends ChangeNotifier {
  static final WebFavoritesManager _instance = WebFavoritesManager._internal();

  List<WebFavoritesList> state = [];
  bool hasData = false;
  late StreamSubscription<Query<WebFavoritesList>> _sub;

  final Map<String, Set<int>> _linkToFavoritesMap = {};

  WebFavoritesManager._internal() {
    final box = GagakuData().store.box<WebFavoritesList>();
    final stream = box
        .query(WebFavoritesList_.id.notEquals(historyListUUID))
        .order(WebFavoritesList_.sortOrder)
        .watch(triggerImmediately: true);

    _sub = stream.listen((query) {
      state = query.find();
      _rebuildLookupMap();
      hasData = true;
      notifyListeners();
    });
  }

  void _rebuildLookupMap() {
    _linkToFavoritesMap.clear();
    for (final favList in state) {
      for (final link in favList.list) {
        if (!_linkToFavoritesMap.containsKey(link.url)) {
          _linkToFavoritesMap[link.url] = {};
        }

        _linkToFavoritesMap[link.url]!.add(favList.dbid);
      }
    }
  }

  Set<int> getFavoritedListIdsOfLink(HistoryLink link) {
    return UnmodifiableSetView(_linkToFavoritesMap[link.url] ?? {});
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  factory WebFavoritesManager() {
    return _instance;
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

@Riverpod(keepAlive: true, retry: noRetry)
class ExtensionSource extends _$ExtensionSource {
  bool _initialized = false;
  String? _extensionBody;
  HeadlessInAppWebView? _view;
  InAppWebViewController? get _controller =>
      (_view?.isRunning() ?? false) ? _view?.webViewController : null;

  List<SearchFilter>? _filters;
  List<SortingOption>? _sortingOptions;
  final Map<String, SettingsForm> _forms = {};

  @override
  Future<WebSourceInfo> build(String sourceId) async {
    WebSourceInfo? source;
    try {
      final box = GagakuData().store.box<WebSourceInfo>();
      final query = box.query(WebSourceInfo_.id.equals(sourceId)).build();
      source = await query.findUniqueAsync();
      if (source == null) {
        throw UnknownSourceException(
          message: "Source failed to initialize: not installed",
          sourceId: sourceId,
        );
      }

      final sourceFile = switch (source.version) {
        SupportedVersion.v0_8 => 'source.js',
        SupportedVersion.v0_9 => 'index.js',
      };

      final scriptUrl = '${source.repo}/${source.id}/$sourceFile';
      final response = await http.get(Uri.parse(scriptUrl));

      if (response.statusCode != 200) {
        final err = "Failed to load $scriptUrl";
        logger.e(err);
        throw ApiException(
          message: err,
          statusCode: response.statusCode,
          statusMessage: response.reasonPhrase,
        );
      }

      _extensionBody = response.body;
    } catch (e) {
      logger.e('Error retrieving source info from database', error: e);
      rethrow; // Re-throw to prevent further execution
    }

    final completer = Completer<void>();

    final contentBlockers = <ContentBlocker>[];

    if (defaultTargetPlatform == TargetPlatform.android) {
      for (final filter in GagakuData().blockers) {
        contentBlockers.add(
          ContentBlocker(
            trigger: ContentBlockerTrigger(urlFilter: filter),
            action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
          ),
        );
      }
    }

    try {
      _view = HeadlessInAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(source.baseUrl ?? 'about:blank'),
        ),
        initialUserScripts: UnmodifiableListView<UserScript>([
          UserScript(
            source: GagakuData().extensionHost,
            injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
            forMainFrameOnly: false,
          ),
          UserScript(
            source: _extensionBody!,
            injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
            forMainFrameOnly: false,
          ),
        ]),
        initialSettings: InAppWebViewSettings(
          contentBlockers: defaultTargetPlatform == TargetPlatform.android
              ? contentBlockers
              : null,
          browserAcceleratorKeysEnabled: false,
          isInspectable: false,
        ),
        onLoadStart: (controller, url) {
          if (_initialized) {
            controller.stopLoading();
          }
        },
        onWebViewCreated: (controller) {
          _setupJavaScriptHandlers(controller, sourceId);
        },
        onLoadStop: (controller, url) =>
            _onWebViewLoadStop(controller, url, source!, completer),
      );

      Timer(const Duration(seconds: 60), () async {
        if (!completer.isCompleted) {
          completer.completeError(Exception('$sourceId load timeout'));
        }
      });
    } catch (e) {
      logger.w('Error creating extension view', error: e);
      completer.completeError(e);
    }

    await _view?.run();
    await completer.future;

    ref.onDispose(() {
      _view?.dispose();
    });

    _initialized = true;

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

    controller.addJavaScriptHandler(
      handlerName: 'executeInWebView',
      callback: (JavaScriptHandlerFunctionData data) async {
        final context = ExecuteInWebViewContext.fromJson(data.args[0]);
        final completer = Completer<Map<String, dynamic>>();

        final temp = HeadlessInAppWebView(
          initialData: InAppWebViewInitialData(
            data: context.source.html,
            baseUrl: WebUri(context.source.baseUrl),
          ),
          initialSettings: InAppWebViewSettings(
            contentBlockers: defaultTargetPlatform == TargetPlatform.android
                ? [
                    if (!context.source.loadCSS)
                      ContentBlocker(
                        trigger: ContentBlockerTrigger(
                          urlFilter: ".*",
                          resourceType: [
                            ContentBlockerTriggerResourceType.STYLE_SHEET,
                          ],
                        ),
                        action: ContentBlockerAction(
                          type: ContentBlockerActionType.BLOCK,
                        ),
                      ),
                    if (!context.source.loadImages)
                      ContentBlocker(
                        trigger: ContentBlockerTrigger(
                          urlFilter: ".*",
                          resourceType: [
                            ContentBlockerTriggerResourceType.IMAGE,
                          ],
                        ),
                        action: ContentBlockerAction(
                          type: ContentBlockerActionType.BLOCK,
                        ),
                      ),
                  ]
                : null,
            loadsImagesAutomatically: context.source.loadImages,
            browserAcceleratorKeysEnabled: false,
            isInspectable: false,
          ),
          onLoadStop: (controller, url) async {
            final results = await controller.callAsyncJavaScript(
              functionBody: context.inject,
            );

            if (results == null || results.error != null) {
              completer.completeError(
                JavaScriptException(
                  message: 'JavaScript error in executeInWebView:',
                  errorMessage: '${context.source.baseUrl} - ${results?.error}',
                ),
              );
              return;
            }

            completer.complete({'result': results.value});
          },
        );

        try {
          await temp.run();
          final result = await completer.future.timeout(
            const Duration(seconds: 30),
          );
          return result;
        } finally {
          temp.dispose();
        }
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
      final sourceId = source.id;

      final initScript = switch (source.version) {
        SupportedVersion.v0_8 =>
          "var ${source.id} = window.CompatWrapper({registerHomeSectionsInInitialise: true}, new window.Sources['${source.id}'](window.cheerio));",
        SupportedVersion.v0_9 =>
          "var ${source.id} = window.source.${source.id};",
      };
      await controller.evaluateJavascript(source: initScript);

      if (_initialized) {
        return;
      }

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
        functionBody: "return await ${source.id}.getSearchFilters();",
      );

      if (result != null && result.value != null) {
        final rsec = result.value as List<dynamic>;
        _filters = rsec.map((e) => SearchFilter.fromJson(e)).toList();
      }

      // Get sort options
      // XXX: dummy query, nobody actually uses the query arg
      final params = SearchQuery(title: "").toJson();
      final sortopts = await controller.callAsyncJavaScript(
        arguments: {'query': params},
        functionBody: "return await ${source.id}.getSortingOptions?.();",
      );

      if (sortopts != null && sortopts.value != null) {
        final ssec = sortopts.value as List<dynamic>;
        _sortingOptions = ssec.map((e) => SortingOption.fromJson(e)).toList();
      }

      logger.d("Extension ${source.name} ready");
      if (!completer.isCompleted) {
        completer.complete();
      }
    } catch (e) {
      logger.e('(${source.id}) Error during WebView load stop', error: e);
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
      throw UnsupportedError("Source does not support settings");
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
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
    }

    final formid = result.value as FormID;

    if (!_forms.containsKey(formid)) {
      throw JavaScriptException(
        message: 'Failed to create form',
        errorMessage: formid,
      );
    }

    return _forms[formid]!;
  }

  Future<SettingsForm> getForm(FormID id) async {
    final source = await future;

    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw UnsupportedError("Source does not support settings");
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
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
    }

    final formid = result.value as FormID?;

    if (formid == null) {
      throw JavaScriptException(message: 'Invalid FormID', errorMessage: id);
    }

    if (!_forms.containsKey(formid)) {
      throw JavaScriptException(
        message: 'Failed to create form',
        errorMessage: formid,
      );
    }

    return _forms[formid]!;
  }

  Future<void> uninitializeForms() async {
    final source = await future;

    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw UnsupportedError("Source does not support settings");
    }

    await _controller?.evaluateJavascript(
      source: "window.Application.uninitializeForms();",
    );
  }

  Future<List<DiscoverSection>> getDiscoverSections() async {
    final source = await future;

    if (!source.hasCapability(SourceIntents.discoverSections)) {
      throw UnsupportedError("Source does not support discover sections");
    }

    final result = await _controller?.callAsyncJavaScript(
      functionBody: "return await $sourceId.getDiscoverSections();",
    );

    if (result == null || result.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
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
      throw UnsupportedError("Source does not support discover sections");
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
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
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

    // TODO: support actual sorting options if they exist
    final sortOp = (_sortingOptions != null && _sortingOptions!.isNotEmpty)
        ? _sortingOptions!.first.toJson()
        : null;

    final result = await _controller?.callAsyncJavaScript(
      arguments: {'query': params, 'metadata': metadata, 'sortOp': sortOp},
      functionBody:
          """
return await $sourceId.getSearchResults(query, metadata, sortOp)
""",
    );

    if (result == null || result.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
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
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: mdeets?.error,
      );
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
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: chaps?.error,
      );
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
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: cdeets?.error,
      );
    }

    final chapterd = ChapterDetails.fromJson(cdeets.value);

    return chapterd.pages;
  }

  Future<String?> getMangaURL(String mangaId) async {
    await future;

    if (mangaId.isEmpty) {
      return null;
    }

    dynamic result;

    try {
      result = await _controller?.evaluateJavascript(
        source: "$sourceId?.getMangaShareUrl('$mangaId')",
      );
    } catch (e) {
      return null;
    }

    return result;
  }

  Future<List<SearchFilter>?> getFilters() async {
    await future;

    final filters = _filters?.map((e) => e.copyWith()).toList();
    return filters;
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

  throw UnknownSourceException(
    message: 'Invalid missing/source',
    sourceId: sourceId,
  );
}

class SettingsForm with ChangeNotifier {
  SettingsForm({required this.id, required InAppWebViewController controller})
    : _controller = controller {
    _sections = _getSections();
  }

  final FormID id;
  final InAppWebViewController _controller;

  late Future<List<FormSectionElement>> _sections;
  Future<List<FormSectionElement>> get sections => _sections;

  Future<List<FormSectionElement>> _getSections() async {
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
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
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
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
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

  Future<void> reloadForm() async {
    await _controller.callAsyncJavaScript(
      arguments: {'formid': id},
      functionBody: """
var form = window.Application.getForm(formid);
if (typeof form === "undefined") {
  return;
}

form.formWillAppear?.();
""",
    );

    _sections = _getSections();

    notifyListeners();
  }

  void uninitialize() {
    _controller.evaluateJavascript(
      source: "window.Application.uninitializeForms();",
    );
  }
}
