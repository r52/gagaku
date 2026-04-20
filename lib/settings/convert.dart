import 'dart:collection';
import 'dart:convert';

import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/reader/model/config.dart';
import 'package:gagaku/settings/types.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart' show historyListUUID;
import 'package:gagaku/web/model/types.dart';

const _versionKey = "version";

abstract interface class GagakuBackupDataConverter {
  Future<void> read(Map<String, dynamic> data);
  Future<String> write(Map<String, dynamic> data);

  void importExtensionState(Store store, Map<String, dynamic> json);
  void writeExtensionState(Store store, Map<String, dynamic> json);
  void importExtensionSecureState(Store store, Map<String, dynamic> json);
  void writeExtensionSecureState(Store store, Map<String, dynamic> json);

  void importGagakuConfig(Store store, Map<String, dynamic> json);
  void writeGagakuConfig(Store store, Map<String, dynamic> json);

  void importReaderConfig(Store store, Map<String, dynamic> json);
  void writeReaderConfig(Store store, Map<String, dynamic> json);

  void importMangadexConfig(Store store, Map<String, dynamic> json);
  void writeMangadexConfig(Store store, Map<String, dynamic> json);

  void importMangadexHistory(Store store, Map<String, dynamic> json);
  void writeMangadexHistory(Store store, Map<String, dynamic> json);

  void importWebReadHistory(Store store, Map<String, dynamic> json);
  void writeWebReadHistory(Store store, Map<String, dynamic> json);

  void importWebConfigFavoritesHistory(Store store, Map<String, dynamic> json);
  void writeWebConfigFavoritesHistory(Store store, Map<String, dynamic> json);
}

abstract base class GagakuBackupBase implements GagakuBackupDataConverter {
  const GagakuBackupBase();

  static const extenstionStateKey = "extension-state";
  static const extenstionSecureStateKey = "extension-secure-state";
  static const readerConfigKey = "reader";
  static const mangadexConfigKey = "mangadex";
  static const gagakuConfigKey = "gagaku";
  static const mangadexHistoryKey = "mangadex_history";

  T? _getUnique<T>(Store store) {
    final box = store.box<T>();
    final query = box.query().build();
    final result = query.findUnique();
    query.close();
    return result;
  }

  void _importConfig<T>(
    Store store,
    Map<String, dynamic> data,
    String key,
    T Function(Map<String, dynamic>) fromJson,
    void Function(T oldConfig, T newConfig) applyId,
  ) {
    if (!data.containsKey(key)) return;

    final oldConfig = _getUnique<T>(store);
    final newConfig = fromJson(data[key] as Map<String, dynamic>);

    if (oldConfig != null) {
      applyId(oldConfig, newConfig);
    }

    store.box<T>().put(newConfig);
  }

  @override
  void importExtensionSecureState(Store store, Map<String, dynamic> data) {
    final box = store.box<ExtensionStateDB>();
    final query = box.query(ExtensionStateDB_.secure.equals(true)).build();

    ExtensionStateDB? db = query.findUnique() ?? ExtensionStateDB(secure: true);
    query.close();

    if (data.containsKey(extenstionSecureStateKey)) {
      final state = data[extenstionSecureStateKey] as Map<String, dynamic>;
      db.state = state.cast<String, Map<String, dynamic>>();
      box.put(db);
    }
  }

  @override
  void importExtensionState(Store store, Map<String, dynamic> data) {
    final box = store.box<ExtensionStateDB>();
    final query = box.query(ExtensionStateDB_.secure.equals(false)).build();

    ExtensionStateDB? db =
        query.findUnique() ?? ExtensionStateDB(secure: false);
    query.close();

    if (data.containsKey(extenstionStateKey)) {
      final state = data[extenstionStateKey] as Map<String, dynamic>;
      db.state = state.cast<String, Map<String, dynamic>>();
      box.put(db);
    }
  }

  @override
  void importGagakuConfig(Store store, Map<String, dynamic> data) {
    _importConfig<GagakuConfig>(
      store,
      data,
      gagakuConfigKey,
      GagakuConfig.fromJson,
      (oldCfg, newCfg) => newCfg.dbid = oldCfg.dbid,
    );
  }

  @override
  void importMangadexConfig(Store store, Map<String, dynamic> data) {
    _importConfig<MangaDexConfig>(
      store,
      data,
      mangadexConfigKey,
      MangaDexConfig.fromJson,
      (oldCfg, newCfg) => newCfg.dbid = oldCfg.dbid,
    );
  }

  @override
  void importMangadexHistory(Store store, Map<String, dynamic> data) {
    final db = _getUnique<MangaDexHistoryDB>(store) ?? MangaDexHistoryDB();

    if (data.containsKey(mangadexHistoryKey)) {
      final state = data[mangadexHistoryKey];
      if (state is! List) {
        logger.w('Data in $mangadexHistoryKey not a List');
        return;
      }
      db.queue = List<String>.from(state);
      store.box<MangaDexHistoryDB>().put(db);
    }
  }

  @override
  void importReaderConfig(Store store, Map<String, dynamic> data) {
    _importConfig<ReaderConfig>(
      store,
      data,
      readerConfigKey,
      ReaderConfig.fromJson,
      (oldCfg, newCfg) => newCfg.dbid = oldCfg.dbid,
    );
  }

  @override
  void writeExtensionSecureState(Store store, Map<String, dynamic> data) {
    final query = store
        .box<ExtensionStateDB>()
        .query(ExtensionStateDB_.secure.equals(true))
        .build();
    final db = query.findUnique();
    query.close();
    if (db != null) data[extenstionSecureStateKey] = db.state;
  }

  @override
  void writeExtensionState(Store store, Map<String, dynamic> data) {
    final query = store
        .box<ExtensionStateDB>()
        .query(ExtensionStateDB_.secure.equals(false))
        .build();
    final db = query.findUnique();
    query.close();
    if (db != null) data[extenstionStateKey] = db.state;
  }

  @override
  void writeGagakuConfig(Store store, Map<String, dynamic> data) {
    final cfg = _getUnique<GagakuConfig>(store);
    if (cfg != null) data[gagakuConfigKey] = cfg.toJson();
  }

  @override
  void writeMangadexConfig(Store store, Map<String, dynamic> data) {
    final cfg = _getUnique<MangaDexConfig>(store);
    if (cfg != null) data[mangadexConfigKey] = cfg.toJson();
  }

  @override
  void writeMangadexHistory(Store store, Map<String, dynamic> data) {
    final db = _getUnique<MangaDexHistoryDB>(store);
    if (db != null) data[mangadexHistoryKey] = db.queue;
  }

  @override
  void writeReaderConfig(Store store, Map<String, dynamic> data) {
    final cfg = _getUnique<ReaderConfig>(store);
    if (cfg != null) data[readerConfigKey] = cfg.toJson();
  }
}

base class GagakuBackupDataV1 extends GagakuBackupBase {
  const GagakuBackupDataV1();

  static const _webfavoritesKey = "web_favorites";
  static const _webhistoryKey = "web_history";
  static const _webReadMarkersKey = "web_read_history";
  static const _webConfigKey = "websource";

  @override
  Future<void> read(Map<String, dynamic> data) async {
    await GagakuData().store.runInTransactionAsync(TxMode.write, (store, data) {
      importExtensionState(store, data);
      importExtensionSecureState(store, data);
      importGagakuConfig(store, data);
      importReaderConfig(store, data);
      importMangadexConfig(store, data);
      importMangadexHistory(store, data);
      importWebReadHistory(store, data);
      importWebConfigFavoritesHistory(store, data);
    }, data);
  }

  @override
  Future<String> write(Map<String, dynamic> data) async {
    data[_versionKey] = 1;

    data = await GagakuData().store.runInTransactionAsync(TxMode.write, (
      store,
      data,
    ) {
      writeExtensionState(store, data);
      writeExtensionSecureState(store, data);
      writeGagakuConfig(store, data);
      writeReaderConfig(store, data);
      writeMangadexConfig(store, data);
      writeMangadexHistory(store, data);
      writeWebReadHistory(store, data);
      writeWebConfigFavoritesHistory(store, data);
      return data;
    }, data);

    return json.encode(data);
  }

  @override
  void importWebReadHistory(Store store, Map<String, dynamic> data) {
    final db = _getUnique<ReadMarkersDB>(store) ?? ReadMarkersDB();

    if (data.containsKey(_webReadMarkersKey)) {
      final content = data[_webReadMarkersKey] as Map<String, dynamic>;
      db.markers = content.map((m, s) => MapEntry(m, Set<String>.from(s)));
      store.box<ReadMarkersDB>().put(db);
    }
  }

  @override
  void writeWebReadHistory(Store store, Map<String, dynamic> data) {
    final db = _getUnique<ReadMarkersDB>(store);

    if (db != null) {
      data[_webReadMarkersKey] = db.markers.map(
        (key, value) => MapEntry(key, value.toList()),
      );
    }
  }

  @override
  void importWebConfigFavoritesHistory(Store store, Map<String, dynamic> data) {
    final linksToAdd = <HistoryLink>{};
    List<HistoryLink> historylist = [];
    final favLists = <String, List<HistoryLink>>{};

    // history
    if (data.containsKey(_webhistoryKey)) {
      final state = data[_webhistoryKey];

      if (state is List) {
        historylist = state.map((e) => HistoryLink.fromJson(e)).toList();
        linksToAdd.addAll(historylist);
      }
    }

    // cfg
    WebSourceConfig? cfg;

    if (data.containsKey(_webConfigKey)) {
      final state = data[_webConfigKey];
      cfg = WebSourceConfig.fromJson(state as Map<String, dynamic>);
    }

    if (cfg != null) {
      // can't process favorites if no config in data

      // favs
      if (data.containsKey(_webfavoritesKey)) {
        final content = data[_webfavoritesKey];

        if (content is List) {
          final links = content.map((e) => HistoryLink.fromJson(e)).toList();
          favLists[cfg.defaultCategory] = links;
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
              map[cfg.defaultCategory] = [
                ...?map[cfg.defaultCategory],
                ...?list,
              ];
            }
          }

          favLists.addAll(map);
        }

        for (final favlist in favLists.values) {
          linksToAdd.addAll(favlist);
        }
      }
    }

    // import data

    // cfg
    if (cfg != null) {
      final ecfgbox = store.box<ExtensionConfig>();
      final ecfgquery = ecfgbox.query().build();

      ExtensionConfig? ecfg;
      ecfg = ecfgquery.findUnique();
      ecfg ??= ExtensionConfig();
      ecfgquery.close();

      ecfg.categoriesToUpdate = cfg.categoriesToUpdate;

      ecfgbox.put(ecfg);
    }

    // sources
    if (cfg != null) {
      final sbox = store.box<WebSourceInfo>();
      sbox.removeAll();

      final sources = [...cfg.installedSources];
      sbox.putMany(sources);
    }

    // repo
    if (cfg != null) {
      final box = store.box<RepoInfo>();
      box.removeAll();

      final repos = [...cfg.repoList];
      box.putMany(repos);
    }

    // add links
    final linkbox = store.box<HistoryLink>();
    linkbox.removeAll();
    linkbox.putMany(linksToAdd.toList());

    // set history
    {
      final hbox = store.box<WebFavoritesList>();
      final hq = hbox
          .query(WebFavoritesList_.id.equals(historyListUUID))
          .build();

      WebFavoritesList? hlist;
      hlist = hq.findUnique();
      hq.close();

      if (hlist == null) {
        hlist = WebFavoritesList(
          id: historyListUUID,
          name: 'extension_history',
        );
        hbox.put(hlist);
      }

      final addedhlinks = linksToAdd.intersection(historylist.toSet());

      hlist.list.addAll(addedhlinks);
      hbox.put(hlist);
    }

    // set fav lists
    if (cfg != null) {
      final fbox = store.box<WebFavoritesList>();
      final fq = fbox
          .query(WebFavoritesList_.id.notEquals(historyListUUID))
          .build();

      // remove existing lists
      fq.remove();
      fq.close();

      int sortorder = 0;

      final newfavlist = <WebFavoritesList>[];

      for (final cat in cfg.categories) {
        final newlist = WebFavoritesList(
          id: cat.id,
          name: cat.name,
          sortOrder: sortorder,
        );
        sortorder++;

        final addedlinks = linksToAdd.intersection(favLists[cat.id]!.toSet());
        newlist.list.addAll(addedlinks);
        newfavlist.add(newlist);
      }

      fbox.putMany(newfavlist);
    }
  }

  @override
  void writeWebConfigFavoritesHistory(Store store, Map<String, dynamic> data) {
    final ecfgbox = store.box<ExtensionConfig>();
    final ecfgquery = ecfgbox.query().build();

    ExtensionConfig? ecfg;
    ecfg = ecfgquery.findUnique();
    ecfg ??= ExtensionConfig();
    ecfgquery.close();

    // sources
    final sbox = store.box<WebSourceInfo>();
    final sources = sbox.getAll();

    // repo
    final rbox = store.box<RepoInfo>();
    final repos = rbox.getAll();

    // lists
    final listbox = store.box<WebFavoritesList>();
    final lists = listbox.getAll();

    final favlists = lists.where((e) => e.id != historyListUUID).toList();
    final historylist = lists.firstWhere((e) => e.id == historyListUUID);

    // cfg
    final cfg = WebSourceConfig(
      categories: favlists.map((e) => WebSourceCategory(e.id, e.name)).toList(),
      categoriesToUpdate: ecfg.categoriesToUpdate,
      repoList: repos,
      installedSources: sources,
    );

    data[_webConfigKey] = cfg.toJson();

    // history
    data[_webhistoryKey] = historylist.list.map((i) => i.toJson()).toList();

    // fav lists
    data[_webfavoritesKey] = {
      for (var item in favlists)
        item.id: item.list.map((i) => i.toJson()).toList(),
    };
  }
}

base class GagakuBackupDataV2 extends GagakuBackupBase {
  const GagakuBackupDataV2();

  static const _webfavoritesKey = "web_favorites";
  static const _webhistoryKey = "web_history";
  static const _webReadMarkersKey = "web_read_markers";
  static const _webConfigKey = "web_config";
  static const _extRepoListKey = "ext-repo-list";
  static const _extInstalledSourcesKey = "ext-installed-sources";
  static const _linkCacheKey = "link-cache";

  @override
  Future<void> read(Map<String, dynamic> data) async {
    await GagakuData().store.runInTransactionAsync(TxMode.write, (store, data) {
      importExtensionState(store, data);
      importExtensionSecureState(store, data);
      importGagakuConfig(store, data);
      importReaderConfig(store, data);
      importMangadexConfig(store, data);
      importMangadexHistory(store, data);
      importWebReadHistory(store, data);
      importWebConfigFavoritesHistory(store, data);
    }, data);
  }

  @override
  Future<String> write(Map<String, dynamic> data) async {
    data[_versionKey] = 2;

    data = await GagakuData().store.runInTransactionAsync(TxMode.write, (
      store,
      data,
    ) {
      writeExtensionState(store, data);
      writeExtensionSecureState(store, data);
      writeGagakuConfig(store, data);
      writeReaderConfig(store, data);
      writeMangadexConfig(store, data);
      writeMangadexHistory(store, data);
      writeWebReadHistory(store, data);
      writeWebConfigFavoritesHistory(store, data);
      return data;
    }, data);

    return json.encode(data);
  }

  @override
  void importWebReadHistory(Store store, Map<String, dynamic> data) {
    final db = _getUnique<ReadMarkersDB>(store) ?? ReadMarkersDB();

    if (data.containsKey(_webReadMarkersKey)) {
      final content = data[_webReadMarkersKey] as Map<String, dynamic>;
      db.markers = content.map((m, s) => MapEntry(m, Set<String>.from(s)));
      store.box<ReadMarkersDB>().put(db);
    }
  }

  @override
  void writeWebReadHistory(Store store, Map<String, dynamic> data) {
    final db = _getUnique<ReadMarkersDB>(store);

    if (db != null) {
      data[_webReadMarkersKey] = db.markers.map(
        (key, value) => MapEntry(key, value.toList()),
      );
    }
  }

  void importExtensionConfig(Store store, Map<String, dynamic> data) {
    _importConfig<ExtensionConfig>(
      store,
      data,
      _webConfigKey,
      ExtensionConfig.fromJson,
      (oldCfg, newCfg) => newCfg.dbid = oldCfg.dbid,
    );
  }

  void importInstalledSources(Store store, Map<String, dynamic> data) {
    final sbox = store.box<WebSourceInfo>();
    sbox.removeAll();

    if (data.containsKey(_extInstalledSourcesKey) &&
        data[_extInstalledSourcesKey] is List) {
      final list = data[_extInstalledSourcesKey] as List<dynamic>;
      final sources = list.map((e) => WebSourceInfo.fromJson(e)).toList();
      sbox.putMany(sources);
    }
  }

  void importRepoList(Store store, Map<String, dynamic> data) {
    final box = store.box<RepoInfo>();
    box.removeAll();

    if (data.containsKey(_extRepoListKey) && data[_extRepoListKey] is List) {
      final list = data[_extRepoListKey] as List<dynamic>;
      final repos = list.map((e) => RepoInfo.fromJson(e)).toList();
      box.putMany(repos);
    }
  }

  @override
  void importWebConfigFavoritesHistory(Store store, Map<String, dynamic> data) {
    importExtensionConfig(store, data);
    importInstalledSources(store, data);
    importRepoList(store, data);

    // link cache
    final linkbox = store.box<HistoryLink>();
    linkbox.removeAll();
    HashMap<String, HistoryLink> linkcache = HashMap();

    if (data.containsKey(_linkCacheKey) && data[_linkCacheKey] is List) {
      final list = data[_linkCacheKey] as List<dynamic>;
      final links = list.map((e) => HistoryLink.fromJson(e)).toList();
      linkbox.putMany(links);
      linkcache.addEntries(links.map((l) => MapEntry(l.url, l)));
    }

    // history
    {
      final hbox = store.box<WebFavoritesList>();
      final hq = hbox
          .query(WebFavoritesList_.id.equals(historyListUUID))
          .build();

      WebFavoritesList? hlist;
      hlist = hq.findUnique();
      hq.close();

      if (hlist == null) {
        hlist = WebFavoritesList(
          id: historyListUUID,
          name: 'extension_history',
        );
        hbox.put(hlist);
      }

      if (data.containsKey(_webhistoryKey) && data[_webhistoryKey] is List) {
        final content = List<String>.from(
          data[_webhistoryKey] as List<dynamic>,
        );

        hlist.list.clear();
        final linksToAdd = [
          for (final url in content)
            if (linkcache.containsKey(url)) linkcache[url]!,
        ];

        hlist.list.addAll(linksToAdd);
        hbox.put(hlist);
      }
    }

    // fav lists
    {
      final fbox = store.box<WebFavoritesList>();
      final fq = fbox
          .query(WebFavoritesList_.id.notEquals(historyListUUID))
          .build();

      // remove existing lists
      fq.remove();
      fq.close();

      if (data.containsKey(_webfavoritesKey) &&
          data[_webfavoritesKey] is List) {
        final newfavlist = <WebFavoritesList>[];

        final list = data[_webfavoritesKey] as List<dynamic>;
        final imported = list
            .map((e) => FavoriteListExport.fromJson(e))
            .toList();

        for (final cat in imported) {
          final newlist = WebFavoritesList(
            id: cat.id,
            name: cat.name,
            sortOrder: cat.sortOrder,
          );

          final linksToAdd = [
            for (final url in cat.list)
              if (linkcache.containsKey(url)) linkcache[url]!,
          ];

          newlist.list.addAll(linksToAdd);
          newfavlist.add(newlist);
        }

        fbox.putMany(newfavlist);
      }
    }
  }

  void writeExtensionConfig(Store store, Map<String, dynamic> data) {
    final ecfg = _getUnique<ExtensionConfig>(store);
    if (ecfg != null) {
      data[_webConfigKey] = ecfg.toJson();
    }
  }

  void writeInstalledSources(Store store, Map<String, dynamic> data) {
    final sbox = store.box<WebSourceInfo>();
    final sources = sbox.getAll();
    data[_extInstalledSourcesKey] = sources.map((e) => e.toJson()).toList();
  }

  void writeRepoList(Store store, Map<String, dynamic> data) {
    final rbox = store.box<RepoInfo>();
    final repos = rbox.getAll();
    data[_extRepoListKey] = repos.map((e) => e.toJson()).toList();
  }

  @override
  void writeWebConfigFavoritesHistory(Store store, Map<String, dynamic> data) {
    writeExtensionConfig(store, data);
    writeInstalledSources(store, data);
    writeRepoList(store, data);

    // link cache
    final linkbox = store.box<HistoryLink>();
    final links = linkbox.getAll();
    data[_linkCacheKey] = links.map((e) => e.toJson()).toList();

    // lists
    final listbox = store.box<WebFavoritesList>();
    final lists = listbox.getAll();

    final favlists = lists.where((e) => e.id != historyListUUID).toList();
    final historylist = lists.firstWhere((e) => e.id == historyListUUID);

    // history
    data[_webhistoryKey] = historylist.list.map((i) => i.url).toList();

    // fav lists
    data[_webfavoritesKey] = favlists
        .map((e) => FavoriteListExport.fromList(e))
        .toList();
  }
}
