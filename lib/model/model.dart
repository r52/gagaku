import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/version.dart';
import 'package:hive_ce/hive.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

abstract class GagakuRoute {
  static const chapterfeed = 'titles/feed';
  static const library = 'titles/follows';
  static const history = 'my/history';
  static const lists = 'my/lists';

  static const latestfeed = '/titles/latest';
  static const recentfeed = '/titles/recent';
  static const login = '/login';
  static const manga = '/title/:mangaId';
  static const mangaAlt = '/title/:mangaId/:name';
  static const creator = '/author/:creatorId';
  static const creatorAlt = '/author/:creatorId/:name';
  static const chapter = '/chapter/:chapterId';
  static const group = '/group/:groupId';
  static const groupAlt = '/group/:groupId/:name';
  static const list = '/list/:listId';
  static const listAlt = '/list/:listId/:name';
  static const listEdit = '/list/edit/:listId';
  static const listCreate = '/create/list';
  static const search = '/titles';
  static const tag = '/tag/:tagId';
  static const tagAlt = '/tag/:tagId/:name';

  static const local = '/local';

  static const extension = '/extensions';
  static const extensionUpdates = 'updates';
  static const extensionSaved = 'saved';
  static const extensionHistory = 'history';
  static const extensionHomePage = '/extensions/:sourceId/home';
  static const extensionSearch = '/extensions/search';
  static const web = '/read';
  static const webManga = '/read/:sourceId/:mangaId';
  static const proxyChapter = '/read/:proxy/:code/:chapter/:page';
  static const extensionChapter = '/read-chapter/:sourceId/:mangaId/:chapterId';

  static const config = '/config';
}

const gagakuLocalBox =
    'gagaku_box'; // local, device specific, or secure sensitive data
const gagakuCache = 'gagaku_cache'; // disk cache

class GagakuData {
  GagakuData._internal();

  static final GagakuData _instance = GagakuData._internal();

  late final Store store;

  late final String extensionHost;

  // Default user agent
  final String gagakuUserAgent = '$kPackageName/$kPackageVersion';

  factory GagakuData() {
    return _instance;
  }

  Future<void> initData() async {
    extensionHost = await rootBundle.loadString(
      'assets/extensionhost/bundle.js',
    );
  }

  Future<void> initGagakuBoxes() async {
    final appDir = await getApplicationDocumentsDirectory();
    await Hive.openBox(gagakuLocalBox);

    final storage = Hive.box(gagakuLocalBox);
    final dataLocation =
        ((!Platform.isWindows || !kDebugMode)
            ? storage.get('data_location')
            : null) ??
        appDir.path;

    // non-device specific, non-local, insecure data
    store = await openStore(directory: p.join(dataLocation, "gagaku"));
  }
}
