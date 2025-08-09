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

class GagakuBackupDataV1 implements GagakuBackupDataConverter {
  const GagakuBackupDataV1();

  static const _extenstionStateKey = "extension-state";
  static const _extenstionSecureStateKey = "extension-secure-state";
  static const _readerConfigKey = "reader";
  static const _mangadexConfigKey = "mangadex";
  static const _gagakuConfigKey = "gagaku";
  static const _mangadexHistoryKey = "mangadex_history";
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

    final output = json.encode(data);
    return output;
  }

  @override
  void importExtensionSecureState(Store store, Map<String, dynamic> data) {
    final box = store.box<ExtensionStateDB>();
    final query = box.query(ExtensionStateDB_.secure.equals(true)).build();

    ExtensionStateDB? db;
    db = query.findUnique();
    db ??= ExtensionStateDB(secure: true);
    query.close();

    final key = _extenstionSecureStateKey;
    if (data.containsKey(key)) {
      final state = data[key] as Map<String, dynamic>;
      final content = state.cast<String, Map<String, dynamic>>();
      db.state = content;

      box.put(db);
    }
  }

  @override
  void importExtensionState(Store store, Map<String, dynamic> data) {
    final box = store.box<ExtensionStateDB>();
    final query = box.query(ExtensionStateDB_.secure.equals(false)).build();

    ExtensionStateDB? db;
    db = query.findUnique();
    db ??= ExtensionStateDB(secure: false);
    query.close();

    final key = _extenstionStateKey;
    if (data.containsKey(key)) {
      final state = data[key] as Map<String, dynamic>;
      final content = state.cast<String, Map<String, dynamic>>();
      db.state = content;

      box.put(db);
    }
  }

  @override
  void importGagakuConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<GagakuConfig>();
    final query = box.query().build();

    GagakuConfig? cfg;
    cfg = query.findUnique();
    query.close();

    final key = _gagakuConfigKey;
    if (data.containsKey(key)) {
      final state = data[key];

      final c = GagakuConfig.fromJson(state);
      if (cfg != null) {
        c.dbid = cfg.dbid;
      }

      box.put(c);
    }
  }

  @override
  void importMangadexConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<MangaDexConfig>();
    final query = box.query().build();

    MangaDexConfig? cfg;
    cfg = query.findUnique();
    query.close();

    final key = _mangadexConfigKey;
    if (data.containsKey(key)) {
      final state = data[key];

      final c = MangaDexConfig.fromJson(state);
      if (cfg != null) {
        c.dbid = cfg.dbid;
      }

      box.put(c);
    }
  }

  @override
  void importMangadexHistory(Store store, Map<String, dynamic> data) {
    final box = store.box<MangaDexHistoryDB>();
    final query = box.query().build();

    MangaDexHistoryDB? db;
    db = query.findUnique();
    db ??= MangaDexHistoryDB();
    query.close();

    final key = _mangadexHistoryKey;
    if (data.containsKey(key)) {
      final state = data[key];

      if (state is! List) {
        // invalid type
        logger.w('Data in $key not a List');
        return;
      }

      final content = List<String>.from(state);
      db.queue = content;

      box.put(db);
    }
  }

  @override
  void importReaderConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<ReaderConfig>();
    final query = box.query().build();

    ReaderConfig? cfg;
    cfg = query.findUnique();
    query.close();

    final key = _readerConfigKey;
    if (data.containsKey(key)) {
      final state = data[key];

      final c = ReaderConfig.fromJson(state);
      if (cfg != null) {
        c.dbid = cfg.dbid;
      }

      box.put(c);
    }
  }

  @override
  void importWebReadHistory(Store store, Map<String, dynamic> data) {
    final box = store.box<ReadMarkersDB>();
    final query = box.query().build();

    ReadMarkersDB? db;
    db = query.findUnique();
    db ??= ReadMarkersDB();
    query.close();

    final key = _webReadMarkersKey;
    if (data.containsKey(key)) {
      final content = data[key] as Map<String, dynamic>;

      final markers = content.map((m, s) => MapEntry(m, Set<String>.from(s)));
      db.markers = markers;

      box.put(db);
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
  void writeExtensionSecureState(Store store, Map<String, dynamic> data) {
    final box = store.box<ExtensionStateDB>();
    final query = box.query(ExtensionStateDB_.secure.equals(true)).build();

    ExtensionStateDB? db;
    db = query.findUnique();
    query.close();

    if (db != null) {
      data[_extenstionSecureStateKey] = db.state;
    }
  }

  @override
  void writeExtensionState(Store store, Map<String, dynamic> data) {
    final box = store.box<ExtensionStateDB>();
    final query = box.query(ExtensionStateDB_.secure.equals(false)).build();

    ExtensionStateDB? db;
    db = query.findUnique();
    query.close();

    if (db != null) {
      data[_extenstionStateKey] = db.state;
    }
  }

  @override
  void writeGagakuConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<GagakuConfig>();
    final query = box.query().build();

    GagakuConfig? cfg;
    cfg = query.findUnique();
    query.close();

    if (cfg != null) {
      data[_gagakuConfigKey] = cfg.toJson();
    }
  }

  @override
  void writeMangadexConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<MangaDexConfig>();
    final query = box.query().build();

    MangaDexConfig? cfg;
    cfg = query.findUnique();
    query.close();

    if (cfg != null) {
      data[_mangadexConfigKey] = cfg.toJson();
    }
  }

  @override
  void writeMangadexHistory(Store store, Map<String, dynamic> data) {
    final box = store.box<MangaDexHistoryDB>();
    final query = box.query().build();

    MangaDexHistoryDB? db;
    db = query.findUnique();
    query.close();

    if (db != null) {
      data[_mangadexHistoryKey] = db.queue;
    }
  }

  @override
  void writeReaderConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<ReaderConfig>();
    final query = box.query().build();

    ReaderConfig? cfg;
    cfg = query.findUnique();
    query.close();

    if (cfg != null) {
      data[_readerConfigKey] = cfg.toJson();
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

  @override
  void writeWebReadHistory(Store store, Map<String, dynamic> data) {
    final box = store.box<ReadMarkersDB>();
    final query = box.query().build();

    ReadMarkersDB? db;
    db = query.findUnique();
    query.close();

    if (db != null) {
      data[_webReadMarkersKey] = db.markers.map(
        (key, value) => MapEntry(key, value.toList()),
      );
    }
  }
}

class GagakuBackupDataV2 implements GagakuBackupDataConverter {
  const GagakuBackupDataV2();

  static const _extenstionStateKey = "extension-state";
  static const _extenstionSecureStateKey = "extension-secure-state";
  static const _readerConfigKey = "reader";
  static const _mangadexConfigKey = "mangadex";
  static const _gagakuConfigKey = "gagaku";
  static const _mangadexHistoryKey = "mangadex_history";
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

    final output = json.encode(data);
    return output;
  }

  @override
  void importExtensionSecureState(Store store, Map<String, dynamic> data) {
    final box = store.box<ExtensionStateDB>();
    final query = box.query(ExtensionStateDB_.secure.equals(true)).build();

    ExtensionStateDB? db;
    db = query.findUnique();
    db ??= ExtensionStateDB(secure: true);
    query.close();

    final key = _extenstionSecureStateKey;
    if (data.containsKey(key)) {
      final state = data[key] as Map<String, dynamic>;
      final content = state.cast<String, Map<String, dynamic>>();
      db.state = content;

      box.put(db);
    }
  }

  @override
  void importExtensionState(Store store, Map<String, dynamic> data) {
    final box = store.box<ExtensionStateDB>();
    final query = box.query(ExtensionStateDB_.secure.equals(false)).build();

    ExtensionStateDB? db;
    db = query.findUnique();
    db ??= ExtensionStateDB(secure: false);
    query.close();

    final key = _extenstionStateKey;
    if (data.containsKey(key)) {
      final state = data[key] as Map<String, dynamic>;
      final content = state.cast<String, Map<String, dynamic>>();
      db.state = content;

      box.put(db);
    }
  }

  @override
  void importGagakuConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<GagakuConfig>();
    final query = box.query().build();

    GagakuConfig? cfg;
    cfg = query.findUnique();
    query.close();

    final key = _gagakuConfigKey;
    if (data.containsKey(key)) {
      final state = data[key];

      final c = GagakuConfig.fromJson(state);
      if (cfg != null) {
        c.dbid = cfg.dbid;
      }

      box.put(c);
    }
  }

  @override
  void importMangadexConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<MangaDexConfig>();
    final query = box.query().build();

    MangaDexConfig? cfg;
    cfg = query.findUnique();
    query.close();

    final key = _mangadexConfigKey;
    if (data.containsKey(key)) {
      final state = data[key];

      final c = MangaDexConfig.fromJson(state);
      if (cfg != null) {
        c.dbid = cfg.dbid;
      }

      box.put(c);
    }
  }

  @override
  void importMangadexHistory(Store store, Map<String, dynamic> data) {
    final box = store.box<MangaDexHistoryDB>();
    final query = box.query().build();

    MangaDexHistoryDB? db;
    db = query.findUnique();
    db ??= MangaDexHistoryDB();
    query.close();

    final key = _mangadexHistoryKey;
    if (data.containsKey(key)) {
      final state = data[key];

      if (state is! List) {
        // invalid type
        logger.w('Data in $key not a List');
        return;
      }

      final content = List<String>.from(state);
      db.queue = content;

      box.put(db);
    }
  }

  @override
  void importReaderConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<ReaderConfig>();
    final query = box.query().build();

    ReaderConfig? cfg;
    cfg = query.findUnique();
    query.close();

    final key = _readerConfigKey;
    if (data.containsKey(key)) {
      final state = data[key];

      final c = ReaderConfig.fromJson(state);
      if (cfg != null) {
        c.dbid = cfg.dbid;
      }

      box.put(c);
    }
  }

  @override
  void importWebReadHistory(Store store, Map<String, dynamic> data) {
    final box = store.box<ReadMarkersDB>();
    final query = box.query().build();

    ReadMarkersDB? db;
    db = query.findUnique();
    db ??= ReadMarkersDB();
    query.close();

    final key = _webReadMarkersKey;
    if (data.containsKey(key)) {
      final content = data[key] as Map<String, dynamic>;

      final markers = content.map((m, s) => MapEntry(m, Set<String>.from(s)));
      db.markers = markers;

      box.put(db);
    }
  }

  void importExtensionConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<ExtensionConfig>();
    final query = box.query().build();

    ExtensionConfig? cfg;
    cfg = query.findUnique();
    query.close();

    final key = _webConfigKey;
    if (data.containsKey(key)) {
      final state = data[key];

      final c = ExtensionConfig.fromJson(state);
      if (cfg != null) {
        c.dbid = cfg.dbid;
      }

      box.put(c);
    }
  }

  void importInstalledSources(Store store, Map<String, dynamic> data) {
    final sbox = store.box<WebSourceInfo>();
    sbox.removeAll();

    final key = _extInstalledSourcesKey;
    if (data.containsKey(key) && data[key] is List) {
      final list = data[key] as List<dynamic>;
      final sources = list.map((e) => WebSourceInfo.fromJson(e)).toList();
      sbox.putMany(sources);
    }
  }

  void importRepoList(Store store, Map<String, dynamic> data) {
    final box = store.box<RepoInfo>();
    box.removeAll();

    final key = _extRepoListKey;
    if (data.containsKey(key) && data[key] is List) {
      final list = data[key] as List<dynamic>;
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

  @override
  void writeExtensionSecureState(Store store, Map<String, dynamic> data) {
    final box = store.box<ExtensionStateDB>();
    final query = box.query(ExtensionStateDB_.secure.equals(true)).build();

    ExtensionStateDB? db;
    db = query.findUnique();
    query.close();

    if (db != null) {
      data[_extenstionSecureStateKey] = db.state;
    }
  }

  @override
  void writeExtensionState(Store store, Map<String, dynamic> data) {
    final box = store.box<ExtensionStateDB>();
    final query = box.query(ExtensionStateDB_.secure.equals(false)).build();

    ExtensionStateDB? db;
    db = query.findUnique();
    query.close();

    if (db != null) {
      data[_extenstionStateKey] = db.state;
    }
  }

  @override
  void writeGagakuConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<GagakuConfig>();
    final query = box.query().build();

    GagakuConfig? cfg;
    cfg = query.findUnique();
    query.close();

    if (cfg != null) {
      data[_gagakuConfigKey] = cfg.toJson();
    }
  }

  @override
  void writeMangadexConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<MangaDexConfig>();
    final query = box.query().build();

    MangaDexConfig? cfg;
    cfg = query.findUnique();
    query.close();

    if (cfg != null) {
      data[_mangadexConfigKey] = cfg.toJson();
    }
  }

  @override
  void writeMangadexHistory(Store store, Map<String, dynamic> data) {
    final box = store.box<MangaDexHistoryDB>();
    final query = box.query().build();

    MangaDexHistoryDB? db;
    db = query.findUnique();
    query.close();

    if (db != null) {
      data[_mangadexHistoryKey] = db.queue;
    }
  }

  @override
  void writeReaderConfig(Store store, Map<String, dynamic> data) {
    final box = store.box<ReaderConfig>();
    final query = box.query().build();

    ReaderConfig? cfg;
    cfg = query.findUnique();
    query.close();

    if (cfg != null) {
      data[_readerConfigKey] = cfg.toJson();
    }
  }

  void writeExtensionConfig(Store store, Map<String, dynamic> data) {
    final ecfgbox = store.box<ExtensionConfig>();
    final ecfgquery = ecfgbox.query().build();

    ExtensionConfig? ecfg;
    ecfg = ecfgquery.findUnique();
    ecfgquery.close();

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

  @override
  void writeWebReadHistory(Store store, Map<String, dynamic> data) {
    final box = store.box<ReadMarkersDB>();
    final query = box.query().build();

    ReadMarkersDB? db;
    db = query.findUnique();
    query.close();

    if (db != null) {
      data[_webReadMarkersKey] = db.markers.map(
        (key, value) => MapEntry(key, value.toList()),
      );
    }
  }
}
