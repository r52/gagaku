import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/util/http.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/extension_bridge.dart';
import 'package:gagaku/web/model/extension_repository.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:native_dio_adapter/native_dio_adapter.dart' hide URLRequest;
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

@riverpod
Map<String, String> sourceHeaders(Ref ref, String sourceId) {
  final referrers = ref.watch(extensionReferrerProvider);
  final baseReferrer = referrers[sourceId] ?? '';

  final headers = <String, String>{'user-agent': getUserAgent()};

  if (sourceId != 'gist') {
    headers['x-source-id'] = sourceId;
  }

  if (baseReferrer.isNotEmpty) {
    headers['referer'] = baseReferrer;
  }

  return headers;
}

@Riverpod(keepAlive: true)
WebSourceBroker webSourceBroker(Ref ref) {
  return WebSourceBroker(ref);
}

class WebSourceBroker {
  WebSourceBroker(this.ref) : _cache = ref.read(cacheProvider);

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

  void syncAndLogHistory(HistoryLink link) {
    if (ref.read(webConfigProvider).preserveHistory) {
      WebHistoryManager().add(link);
    } else {
      link.resolveDb();
      if (link.dbid > 0) {
        GagakuData().store.box<HistoryLink>().put(link);
      }
    }
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

    syncAndLogHistory(updatedLink);

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

    syncAndLogHistory(
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
      src = await ref.readAsync(extensionSourceProvider(srcId).future);
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

  Future<WebManga?> _fetchWithCache(
    String key,
    Future<WebManga?> Function() fetcher,
  ) async {
    if (await _cache.exists(key)) {
      logger.d('CacheManager: retrieving entry $key');
      try {
        return _cache.get<WebManga>(key, WebManga.fromJson);
      } catch (e) {
        logger.w('Failed to decode cached WebManga for $key: $e');
        // Fall through to re-fetch
      }
    }

    final manga = await fetcher();

    if (manga != null) {
      const expiry = Duration(days: 1);
      logger.d('CacheManager: caching entry $key for ${expiry.toString()}');
      _cache.put(key, json.encode(manga.toJson()), manga, true, expiry: expiry);
    }

    return manga;
  }

  Future<WebManga?> getMangaFromSource(SourceHandler handle) async {
    switch (handle.type) {
      case SourceType.source:
        return _fetchWithCache(handle.getKey(), () async {
          await ref.readAsync(extensionSourceProvider(handle.sourceId).future);
          return await ref
              .read(extensionSourceProvider(handle.sourceId).notifier)
              .getManga(handle.location);
        });

      case SourceType.proxy:
        return await _getMangaFromProxy(handle);
    }
  }

  Future<WebManga?> _getMangaFromProxy(SourceHandler handle) async {
    final url = "$_cubariApiBase/${handle.sourceId}/series/${handle.location}/";

    return _fetchWithCache(handle.getKey(), () async {
      final response = await _dio.getUri(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = response.data;
        data['source_type'] = 'cubari';
        return WebManga.fromJson(data);
      }

      logger.d(
        "Failed to download manga data.\nServer returned response code ${response.statusCode}: ${response.statusMessage}",
      );

      return null;
    });
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

  Future<ReadMarkersDB> migrate(String oldId, String newId) async {
    ReadMarkersDB db = await future;
    final keys = db.markers.keys.toList();
    bool updated = false;

    for (final key in keys) {
      if (key.startsWith('$oldId/')) {
        final newKey = key.replaceFirst('$oldId/', '$newId/');
        db.markers[newKey] = db.markers.remove(key)!;
        updated = true;
      }
    }

    if (updated) {
      final box = GagakuData().store.box<ReadMarkersDB>();
      db = db.copyWith();
      box.put(db);
      state = AsyncData(db);
    }
    return db;
  }

  Future<List<String>> getStaleKeys(Set<String> validKeys) async {
    final db = await future;
    return db.markers.keys.where((k) => !validKeys.contains(k)).toList();
  }

  Future<ReadMarkersDB> pruneKeys(List<String> staleKeys) async {
    ReadMarkersDB db = await future;
    bool updated = false;

    for (final key in staleKeys) {
      if (db.markers.containsKey(key)) {
        db.markers.remove(key);
        updated = true;
      }
    }

    if (updated) {
      final box = GagakuData().store.box<ReadMarkersDB>();
      db = db.copyWith();
      box.put(db);
      state = AsyncData(db);
    }
    return db;
  }
}

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
  ExtensionWebViewBridge? _bridge;

  @override
  Future<WebSourceInfo> build(String sourceId) async {
    final repo = ExtensionRepository();
    final (source, body) = await repo.fetchSourceAndBody(sourceId);

    _bridge = ExtensionWebViewBridge(
      sourceId: sourceId,
      onResetAllState: (id) =>
          ref.read(extensionStateProvider.notifier).resetAllState(id),
      onSetExtensionState: (id, state) => ref
          .read(extensionStateProvider.notifier)
          .setExtensionState(id, state),
      onSetExtensionSecureState: (id, state) => ref
          .read(extensionSecureStateProvider.notifier)
          .setExtensionState(id, state),
      getExtensionState: (id) =>
          ref.read(extensionStateProvider.notifier).getExtensionState(id),
      getExtensionSecureState: (id) =>
          ref.read(extensionSecureStateProvider.notifier).getExtensionState(id),
    );

    ref.onDispose(() {
      _bridge?.dispose();
      _bridge = null;
    });

    await _bridge!.init(source, body);

    return source;
  }

  Future<dynamic> callBinding(
    String bindingId, [
    List<dynamic> args = const [],
  ]) async {
    await future;
    return await _bridge!.callBinding(bindingId, args);
  }

  Future<SettingsForm> getSettingsForm() async {
    final source = await future;
    return await _bridge!.getSettingsForm(source);
  }

  Future<SettingsForm> getForm(FormID id) async {
    final source = await future;
    return await _bridge!.getForm(source, id);
  }

  Future<void> uninitializeForms() async {
    final source = await future;
    await _bridge!.uninitializeForms(source);
  }

  Future<List<DiscoverSection>> getDiscoverSections() async {
    final source = await future;
    return await _bridge!.getDiscoverSections(source);
  }

  Future<PagedResults<DiscoverSectionItem>> getDiscoverSectionItems(
    DiscoverSection section,
    dynamic metadata,
  ) async {
    final source = await future;
    return await _bridge!.getDiscoverSectionItems(source, section, metadata);
  }

  Future<PagedResults<SearchResultItem>> searchManga(
    SearchQuery query,
    dynamic metadata, {
    SortingOption? sortOp,
  }) async {
    await future;
    return await _bridge!.searchManga(query, metadata, sortOp: sortOp);
  }

  Future<WebManga?> getManga(String mangaId) async {
    await future;
    return await _bridge!.getManga(mangaId);
  }

  Future<List<String>> getChapterPages(Chapter chapter) async {
    await future;
    return await _bridge!.getChapterPages(chapter);
  }

  Future<String?> getMangaURL(String mangaId) async {
    await future;
    return await _bridge!.getMangaURL(mangaId);
  }

  Future<List<SortingOption>?> getSortingOptions(SearchQuery query) async {
    await future;
    return _bridge!.getSortingOptions(query);
  }

  Future<List<SearchFilter>?> getFilters() async {
    await future;
    return _bridge!.getFilters();
  }

  Future<List<Cookie>?> getCookies() async {
    await future;
    return _bridge!.getCookies();
  }

  Future<bool> hasSortOps() async {
    await future;
    return _bridge!.hasSortOps;
  }
}

@Riverpod(retry: noRetry)
Future<WebSourceInfo> getExtensionFromId(Ref ref, String sourceId) async {
  try {
    return await ref.watch(extensionSourceProvider(sourceId).future);
  } catch (e) {
    throw UnknownSourceException(
      message: 'Invalid missing/source',
      sourceId: sourceId,
    );
  }
}
