abstract class GagakuRoute {
  static const mangafeed = '/titles/mangafeed';
  static const chapterfeed = '/titles/feed';
  static const library = '/titles/follows';
  static const history = '/my/history';

  static const login = '/login';
  static const manga = '/title/:mangaId';
  static const mangaAlt = '/title/:mangaId/:name';
  static const creator = '/author/:creatorId';
  static const creatorAlt = '/author/:creatorId/:name';
  static const chapter = '/chapter/:chapterId';
  static const group = '/group/:groupId';
  static const groupAlt = '/group/:groupId/:name';

  static const local = '/local';

  static const web = '/read';
  static const webManga = ':proxy/:code';
  static const webMangaFull = ':proxy/:code/:chapter/:page';
}

const gagakuBox = 'gagaku_box';
