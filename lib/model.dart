abstract class GagakuRoute {
  static const chapterfeed = '/titles/feed';
  static const library = '/titles/follows';
  static const history = '/my/history';
  static const lists = '/my/lists';

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
  static const search = '/search';

  static const local = '/local';

  static const proxyHome = '/proxy';
  static const proxySaved = '/proxy/saved';
  static const web = '/read';
  static const webManga = '/read/:proxy/:code';
  static const webMangaFull = '/read/:proxy/:code/:chapter/:page';

  static const config = '/config';
}

const gagakuBox = 'gagaku_box';
const gagakuCache = 'gagaku_cache';
