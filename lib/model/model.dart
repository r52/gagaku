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
  static const extensionSaved = 'saved';
  static const extensionHistory = 'history';
  static const extensionHomePage = '/extensions/:sourceId/home';
  static const extensionSearch = '/extensions/:sourceId/search';
  static const web = '/read';
  static const webManga = '/read/:sourceId/:mangaId';
  static const proxyChapter = '/read/:proxy/:code/:chapter/:page';
  static const extensionChapter = '/read-chapter/:sourceId/:mangaId/:chapterId';

  static const config = '/config';
}

const gagakuBox = 'gagaku_box';
const gagakuCache = 'gagaku_cache';

class GagakuData {
  GagakuData._internal();

  static final GagakuData _instance = GagakuData._internal();

  // Default user agent
  String gagakuUserAgent = 'gagaku/1.x';

  factory GagakuData() {
    return _instance;
  }
}
