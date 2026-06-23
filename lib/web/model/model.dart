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
import 'package:gagaku/web/model/extension_runtime.dart';
import 'package:gagaku/web/model/fjs_extension_runtime.dart';
import 'package:gagaku/web/model/extension_repository.dart';
import 'package:gagaku/web/model/link_resolver.dart';
import 'package:gagaku/web/model/source_adapter.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:native_dio_adapter/native_dio_adapter.dart' hide URLRequest;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.g.dart';

const historyListUUID = 'd6f79229-6f8e-4872-9610-5200a54aef8f';
void openWebSource(BuildContext context, ResolvedWebLink link) {
  final initialChapter = link.initialChapter;
  if (initialChapter != null) {
    switch (initialChapter.series) {
      case ProxySeriesRef(:final proxyId, :final seriesId):
        ProxyWebSourceReaderRoute(
          proxy: proxyId,
          code: seriesId,
          chapter: initialChapter.chapterId,
          page: '1',
        ).push(context);
      case ExtensionSeriesRef(:final sourceId, :final mangaId):
        ExtensionReaderRoute(
          sourceId: sourceId,
          mangaId: mangaId,
          chapterId: initialChapter.chapterId,
        ).push(context);
    }
    return;
  }

  WebMangaViewRoute(
    sourceId: link.series.sourceId,
    mangaId: link.series.location,
    handle: link.series.toLegacySourceHandler(),
  ).push(context);
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
  final transport = ref.watch(webSourceTransportProvider);
  return WebSourceBroker(
    cache: ref.watch(cacheProvider),
    proxyAdapter: ProxyWebSourceAdapter(transport: transport),
    extensionAdapter: ExtensionWebSourceAdapter(
      fetchManga: (sourceId, mangaId) async {
        await ref.readAsync(extensionSourceProvider(sourceId).future);
        return ref
            .read(extensionSourceProvider(sourceId).notifier)
            .getManga(mangaId);
      },
      fetchChapterPages: (sourceId, chapter) async {
        final provider = extensionSourceProvider(sourceId);
        await ref.readAsync(provider.future);
        final notifier = ref.read(provider.notifier);
        return ExtensionChapterPages(
          runtime: await notifier.getRuntime(),
          links: await notifier.getChapterPages(chapter),
        );
      },
    ),
  );
}

@Riverpod(keepAlive: true)
WebSourceTransport webSourceTransport(Ref ref) {
  return _DioWebSourceTransport(_createWebSourceDio());
}

@Riverpod(keepAlive: true)
WebLinkResolver webLinkResolver(Ref ref) {
  return WebLinkResolver(
    extensionExists: (sourceId) async {
      final box = GagakuData().store.box<WebSourceInfo>();
      final query = box.query(WebSourceInfo_.id.equals(sourceId)).build();
      final source = query.findUnique();
      query.close();
      return source != null;
    },
    redirectTransport: _WebSourceRedirectTransport(
      ref.watch(webSourceTransportProvider),
    ),
  );
}

class _DioWebSourceTransport implements WebSourceTransport {
  _DioWebSourceTransport(this.dio);

  final Dio dio;

  @override
  Future<Response<dynamic>> getUri(Uri uri, {bool followRedirects = true}) {
    return dio.getUri(uri, options: Options(followRedirects: followRedirects));
  }
}

class _WebSourceRedirectTransport implements WebLinkRedirectTransport {
  _WebSourceRedirectTransport(this.transport);

  final WebSourceTransport transport;

  @override
  Future<Uri?> resolveRedirect(Uri uri) async {
    logger.d('WebLinkResolver: retrieving redirect for ${uri.toString()}');

    final response = await transport.getUri(uri, followRedirects: false);
    if (response.statusCode != 302) {
      return null;
    }

    final location = response.headers.value('location');
    if (location == null || location.isEmpty) {
      return null;
    }

    logger.d('WebLinkResolver: redirect location $location');
    return Uri.tryParse(location);
  }
}

Dio _createWebSourceDio() {
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

class WebSourceBroker {
  WebSourceBroker({
    required CacheManager cache,
    required ProxyWebSourceAdapter proxyAdapter,
    required ExtensionWebSourceAdapter extensionAdapter,
  }) : _cache = cache,
       _proxyAdapter = proxyAdapter,
       _extensionAdapter = extensionAdapter;

  final CacheManager _cache;
  final ProxyWebSourceAdapter _proxyAdapter;
  final ExtensionWebSourceAdapter _extensionAdapter;

  Future<void> invalidateCacheItem(String item) async {
    if (await _cache.exists(item)) {
      await _cache.remove(item);
    }
  }

  Future<void> invalidateAll(String startsWith) async {
    await _cache.invalidateAll(startsWith);
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
      _cache.put(key, json.encode(manga.toJson()), manga, expiry: expiry);
    }

    return manga;
  }

  Future<WebManga?> getManga(WebSeriesRef series) {
    return _fetchWithCache(
      series.key,
      () => switch (series) {
        ProxySeriesRef() => _proxyAdapter.fetchManga(series),
        ExtensionSeriesRef() => _extensionAdapter.fetchManga(series),
      },
    );
  }

  Future<ExtensionChapterPages> getExtensionChapterPages(
    ExtensionSeriesRef series,
    Chapter chapter,
  ) {
    return _extensionAdapter.fetchChapterPages(series, chapter);
  }

  Future<dynamic> getProxyAPI(String path) => _proxyAdapter.fetchApiPath(path);
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
    link.requireSeries;
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

  Future<void> record(HistoryLink link, {required bool preserveHistory}) async {
    if (link.series == null) {
      throw ArgumentError.value(
        link,
        'link',
        'History records require a series reference',
      );
    }

    if (preserveHistory) {
      await add(link);
      return;
    }

    await GagakuData().store.runInTransactionAsync(TxMode.write, (store, _) {
      link.resolveDb(store: store);
      if (link.dbid > 0) {
        store.box<HistoryLink>().put(link);
      }
    }, null);
  }

  Future<void> add(HistoryLink link) async {
    link.requireSeries;
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
  ExtensionRuntime? _runtime;

  @override
  Future<WebSourceInfo> build(String sourceId) async {
    final repo = ExtensionRepository();
    final (source, body) = await repo.fetchSourceAndBody(sourceId);

    void onResetAllState(String id) {
      ref.read(extensionStateProvider.notifier).resetAllState(id);
    }

    void onSetExtensionState(String id, dynamic state) {
      ref.read(extensionStateProvider.notifier).setExtensionState(id, state);
    }

    void onSetExtensionSecureState(String id, dynamic state) {
      ref
          .read(extensionSecureStateProvider.notifier)
          .setExtensionState(id, state);
    }

    dynamic getExtensionState(String id) {
      return ref.read(extensionStateProvider.notifier).getExtensionState(id);
    }

    dynamic getExtensionSecureState(String id) {
      return ref
          .read(extensionSecureStateProvider.notifier)
          .getExtensionState(id);
    }

    _runtime = FjsExtensionRuntime(
      sourceId: sourceId,
      extensionHost: GagakuData().extensionHost,
      onResetAllState: onResetAllState,
      onSetExtensionState: onSetExtensionState,
      onSetExtensionSecureState: onSetExtensionSecureState,
      getExtensionState: getExtensionState,
      getExtensionSecureState: getExtensionSecureState,
    );

    ref.onDispose(() {
      _runtime?.dispose();
      _runtime = null;
    });

    await _runtime!.init(source, body);

    return source;
  }

  Future<dynamic> callBinding(
    String bindingId, [
    List<dynamic> args = const [],
  ]) async {
    await future;
    return await _runtime!.callBinding(bindingId, args);
  }

  Future<ExtensionForm> getSettingsForm() async {
    final source = await future;
    return await _runtime!.getSettingsForm(source);
  }

  Future<ExtensionForm> getForm(FormID id) async {
    final source = await future;
    return await _runtime!.getForm(source, id);
  }

  Future<void> uninitializeForms() async {
    final source = await future;
    await _runtime!.uninitializeForms(source);
  }

  Future<List<DiscoverSection>> getDiscoverSections() async {
    final source = await future;
    return await _runtime!.getDiscoverSections(source);
  }

  Future<PagedResults<DiscoverSectionItem>> getDiscoverSectionItems(
    DiscoverSection section,
    dynamic metadata,
  ) async {
    final source = await future;
    return await _runtime!.getDiscoverSectionItems(source, section, metadata);
  }

  Future<PagedResults<SearchResultItem>> searchManga(
    SearchQuery query,
    dynamic metadata, {
    SortingOption? sortOp,
  }) async {
    await future;
    return await _runtime!.searchManga(query, metadata, sortOp: sortOp);
  }

  Future<WebManga?> getManga(String mangaId) async {
    await future;
    return await _runtime!.getManga(mangaId);
  }

  Future<List<String>> getChapterPages(Chapter chapter) async {
    await future;
    return await _runtime!.getChapterPages(chapter);
  }

  Future<String?> getMangaURL(String mangaId) async {
    await future;
    return await _runtime!.getMangaURL(mangaId);
  }

  Future<List<SortingOption>?> getSortingOptions(SearchQuery query) async {
    await future;
    return _runtime!.getSortingOptions(query);
  }

  Future<ExtensionForm?> getAdvancedSearchForm(SearchQuery query) async {
    await future;
    return await _runtime!.getAdvancedSearchForm(query);
  }

  Future<bool> hasAdvancedSearchForm() async {
    await future;
    return _runtime!.hasAdvancedSearchForm;
  }

  Future<List<Cookie>?> getCookies() async {
    await future;
    return _runtime!.getCookies();
  }

  Future<bool> hasSortOps() async {
    await future;
    return _runtime!.hasSortOps;
  }

  /// Returns the underlying [ExtensionRuntime] for this source.
  ///
  /// Ensures the provider is initialized before returning the runtime.
  Future<ExtensionRuntime> getRuntime() async {
    await future;
    return _runtime!;
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
