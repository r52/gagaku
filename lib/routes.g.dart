// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $appSettingsRoute,
  $localLibraryHomeRoute,
  $mangaDexHomeRouteData,
  $mangaDexReaderRoute,
  $mangaDexRecentFeedRoute,
  $mangaDexSearchRoute,
  $mangaDexTagViewRoute,
  $mangaDexTagViewAltRoute,
  $mangaDexMangaViewRoute,
  $mangaDexMangaViewAltRoute,
  $mangaDexCreateListRoute,
  $mangaDexEditListRoute,
  $mangaDexListViewRoute,
  $mangaDexListViewAltRoute,
  $mangaDexCreatorViewRoute,
  $mangaDexCreatorViewAltRoute,
  $mangaDexGroupViewRoute,
  $mangaDexGroupViewAltRoute,
  $mangaDexGlobalFeedRoute,
  $mangaDexLoginRoute,
  $webSourceHomeRouteData,
  $extensionHomeRoute,
  $webMangaViewRoute,
  $proxyWebSourceReaderRoute,
  $extensionReaderRoute,
  $extensionSearchRoute,
  $addRepoRoute,
];

RouteBase get $appSettingsRoute =>
    GoRouteData.$route(path: '/config', factory: $AppSettingsRoute._fromState);

mixin $AppSettingsRoute on GoRouteData {
  static AppSettingsRoute _fromState(GoRouterState state) =>
      const AppSettingsRoute();

  @override
  String get location => GoRouteData.$location('/config');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $localLibraryHomeRoute => GoRouteData.$route(
  path: '/local',
  factory: $LocalLibraryHomeRoute._fromState,
);

mixin $LocalLibraryHomeRoute on GoRouteData {
  static LocalLibraryHomeRoute _fromState(GoRouterState state) =>
      const LocalLibraryHomeRoute();

  @override
  String get location => GoRouteData.$location('/local');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mangaDexHomeRouteData => ShellRouteData.$route(
  factory: $MangaDexHomeRouteDataExtension._fromState,
  routes: [
    GoRouteData.$route(path: '/', factory: $MangaDexFrontRoute._fromState),
    GoRouteData.$route(
      path: '/titles/feed',
      factory: $MangaDexChapterFeedRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/titles/follows',
      factory: $MangaDexLibraryRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/my/lists',
      factory: $MangaDexListsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/my/history',
      factory: $MangaDexHistoryFeedRoute._fromState,
    ),
  ],
);

extension $MangaDexHomeRouteDataExtension on MangaDexHomeRouteData {
  static MangaDexHomeRouteData _fromState(GoRouterState state) =>
      const MangaDexHomeRouteData();
}

mixin $MangaDexFrontRoute on GoRouteData {
  static MangaDexFrontRoute _fromState(GoRouterState state) =>
      const MangaDexFrontRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MangaDexChapterFeedRoute on GoRouteData {
  static MangaDexChapterFeedRoute _fromState(GoRouterState state) =>
      const MangaDexChapterFeedRoute();

  @override
  String get location => GoRouteData.$location('/titles/feed');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MangaDexLibraryRoute on GoRouteData {
  static MangaDexLibraryRoute _fromState(GoRouterState state) =>
      const MangaDexLibraryRoute();

  @override
  String get location => GoRouteData.$location('/titles/follows');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MangaDexListsRoute on GoRouteData {
  static MangaDexListsRoute _fromState(GoRouterState state) =>
      const MangaDexListsRoute();

  @override
  String get location => GoRouteData.$location('/my/lists');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MangaDexHistoryFeedRoute on GoRouteData {
  static MangaDexHistoryFeedRoute _fromState(GoRouterState state) =>
      const MangaDexHistoryFeedRoute();

  @override
  String get location => GoRouteData.$location('/my/history');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mangaDexReaderRoute => GoRouteData.$route(
  path: '/chapter/:chapterId',
  factory: $MangaDexReaderRoute._fromState,
);

mixin $MangaDexReaderRoute on GoRouteData {
  static MangaDexReaderRoute _fromState(GoRouterState state) =>
      MangaDexReaderRoute(
        chapterId: state.pathParameters['chapterId']!,
        $extra: state.extra as ReaderData?,
      );

  MangaDexReaderRoute get _self => this as MangaDexReaderRoute;

  @override
  String get location =>
      GoRouteData.$location('/chapter/${Uri.encodeComponent(_self.chapterId)}');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $mangaDexRecentFeedRoute => GoRouteData.$route(
  path: '/titles/recent',
  factory: $MangaDexRecentFeedRoute._fromState,
);

mixin $MangaDexRecentFeedRoute on GoRouteData {
  static MangaDexRecentFeedRoute _fromState(GoRouterState state) =>
      const MangaDexRecentFeedRoute();

  @override
  String get location => GoRouteData.$location('/titles/recent');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mangaDexSearchRoute => GoRouteData.$route(
  path: '/titles',
  factory: $MangaDexSearchRoute._fromState,
);

mixin $MangaDexSearchRoute on GoRouteData {
  static MangaDexSearchRoute _fromState(GoRouterState state) =>
      MangaDexSearchRoute(
        selectMode:
            _$convertMapValue(
              'select-mode',
              state.uri.queryParameters,
              _$boolConverter,
            ) ??
            false,
        selectedTitles: state.uri.queryParametersAll['selected-titles']
            ?.map((e) => e)
            .toSet(),
        $extra: state.extra as MangaSearchParameters?,
      );

  MangaDexSearchRoute get _self => this as MangaDexSearchRoute;

  @override
  String get location => GoRouteData.$location(
    '/titles',
    queryParams: {
      if (_self.selectMode != false) 'select-mode': _self.selectMode.toString(),
      if (_self.selectedTitles != null)
        'selected-titles': _self.selectedTitles?.map((e) => e).toList(),
    },
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
}

RouteBase get $mangaDexTagViewRoute => GoRouteData.$route(
  path: '/tag/:tagId',
  factory: $MangaDexTagViewRoute._fromState,
);

mixin $MangaDexTagViewRoute on GoRouteData {
  static MangaDexTagViewRoute _fromState(GoRouterState state) =>
      MangaDexTagViewRoute(
        tagId: state.pathParameters['tagId']!,
        tag: _$convertMapValue('tag', state.uri.queryParameters, (
          String json0,
        ) {
          return Tag.fromJson(jsonDecode(json0) as Map<String, dynamic>);
        }),
      );

  MangaDexTagViewRoute get _self => this as MangaDexTagViewRoute;

  @override
  String get location => GoRouteData.$location(
    '/tag/${Uri.encodeComponent(_self.tagId)}',
    queryParams: {
      if (_self.tag != null) 'tag': jsonEncode(_self.tag!.toJson()),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mangaDexTagViewAltRoute => GoRouteData.$route(
  path: '/tag/:tagId/:name',
  factory: $MangaDexTagViewAltRoute._fromState,
);

mixin $MangaDexTagViewAltRoute on GoRouteData {
  static MangaDexTagViewAltRoute _fromState(GoRouterState state) =>
      MangaDexTagViewAltRoute(
        tagId: state.pathParameters['tagId']!,
        name: state.pathParameters['name'],
        tag: _$convertMapValue('tag', state.uri.queryParameters, (
          String json0,
        ) {
          return Tag.fromJson(jsonDecode(json0) as Map<String, dynamic>);
        }),
      );

  MangaDexTagViewAltRoute get _self => this as MangaDexTagViewAltRoute;

  @override
  String get location => GoRouteData.$location(
    '/tag/${Uri.encodeComponent(_self.tagId)}/${Uri.encodeComponent(_self.name ?? '')}',
    queryParams: {
      if (_self.tag != null) 'tag': jsonEncode(_self.tag!.toJson()),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mangaDexMangaViewRoute => GoRouteData.$route(
  path: '/title/:mangaId',
  factory: $MangaDexMangaViewRoute._fromState,
);

mixin $MangaDexMangaViewRoute on GoRouteData {
  static MangaDexMangaViewRoute _fromState(GoRouterState state) =>
      MangaDexMangaViewRoute(
        mangaId: state.pathParameters['mangaId']!,
        manga: _$convertMapValue('manga', state.uri.queryParameters, (
          String json0,
        ) {
          return Manga.fromJson(jsonDecode(json0) as Map<String, dynamic>);
        }),
      );

  MangaDexMangaViewRoute get _self => this as MangaDexMangaViewRoute;

  @override
  String get location => GoRouteData.$location(
    '/title/${Uri.encodeComponent(_self.mangaId)}',
    queryParams: {
      if (_self.manga != null) 'manga': jsonEncode(_self.manga!.toJson()),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mangaDexMangaViewAltRoute => GoRouteData.$route(
  path: '/title/:mangaId/:name',
  factory: $MangaDexMangaViewAltRoute._fromState,
);

mixin $MangaDexMangaViewAltRoute on GoRouteData {
  static MangaDexMangaViewAltRoute _fromState(GoRouterState state) =>
      MangaDexMangaViewAltRoute(
        mangaId: state.pathParameters['mangaId']!,
        name: state.pathParameters['name'],
        manga: _$convertMapValue('manga', state.uri.queryParameters, (
          String json0,
        ) {
          return Manga.fromJson(jsonDecode(json0) as Map<String, dynamic>);
        }),
      );

  MangaDexMangaViewAltRoute get _self => this as MangaDexMangaViewAltRoute;

  @override
  String get location => GoRouteData.$location(
    '/title/${Uri.encodeComponent(_self.mangaId)}/${Uri.encodeComponent(_self.name ?? '')}',
    queryParams: {
      if (_self.manga != null) 'manga': jsonEncode(_self.manga!.toJson()),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mangaDexCreateListRoute => GoRouteData.$route(
  path: '/create/list',
  factory: $MangaDexCreateListRoute._fromState,
);

mixin $MangaDexCreateListRoute on GoRouteData {
  static MangaDexCreateListRoute _fromState(GoRouterState state) =>
      const MangaDexCreateListRoute();

  @override
  String get location => GoRouteData.$location('/create/list');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mangaDexEditListRoute => GoRouteData.$route(
  path: '/list/edit/:listId',
  factory: $MangaDexEditListRoute._fromState,
);

mixin $MangaDexEditListRoute on GoRouteData {
  static MangaDexEditListRoute _fromState(GoRouterState state) =>
      MangaDexEditListRoute(
        listId: state.pathParameters['listId'],
        list: _$convertMapValue('list', state.uri.queryParameters, (
          String json0,
        ) {
          return CustomList.fromJson(jsonDecode(json0) as Map<String, dynamic>);
        }),
      );

  MangaDexEditListRoute get _self => this as MangaDexEditListRoute;

  @override
  String get location => GoRouteData.$location(
    '/list/edit/${Uri.encodeComponent(_self.listId ?? '')}',
    queryParams: {
      if (_self.list != null) 'list': jsonEncode(_self.list!.toJson()),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mangaDexListViewRoute => GoRouteData.$route(
  path: '/list/:listId',
  factory: $MangaDexListViewRoute._fromState,
);

mixin $MangaDexListViewRoute on GoRouteData {
  static MangaDexListViewRoute _fromState(GoRouterState state) =>
      MangaDexListViewRoute(listId: state.pathParameters['listId']!);

  MangaDexListViewRoute get _self => this as MangaDexListViewRoute;

  @override
  String get location =>
      GoRouteData.$location('/list/${Uri.encodeComponent(_self.listId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mangaDexListViewAltRoute => GoRouteData.$route(
  path: '/list/:listId/:name',
  factory: $MangaDexListViewAltRoute._fromState,
);

mixin $MangaDexListViewAltRoute on GoRouteData {
  static MangaDexListViewAltRoute _fromState(GoRouterState state) =>
      MangaDexListViewAltRoute(
        listId: state.pathParameters['listId']!,
        name: state.pathParameters['name'],
      );

  MangaDexListViewAltRoute get _self => this as MangaDexListViewAltRoute;

  @override
  String get location => GoRouteData.$location(
    '/list/${Uri.encodeComponent(_self.listId)}/${Uri.encodeComponent(_self.name ?? '')}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mangaDexCreatorViewRoute => GoRouteData.$route(
  path: '/author/:creatorId',
  factory: $MangaDexCreatorViewRoute._fromState,
);

mixin $MangaDexCreatorViewRoute on GoRouteData {
  static MangaDexCreatorViewRoute _fromState(GoRouterState state) =>
      MangaDexCreatorViewRoute(
        creatorId: state.pathParameters['creatorId']!,
        $extra: state.extra as CreatorType?,
      );

  MangaDexCreatorViewRoute get _self => this as MangaDexCreatorViewRoute;

  @override
  String get location =>
      GoRouteData.$location('/author/${Uri.encodeComponent(_self.creatorId)}');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $mangaDexCreatorViewAltRoute => GoRouteData.$route(
  path: '/author/:creatorId/:name',
  factory: $MangaDexCreatorViewAltRoute._fromState,
);

mixin $MangaDexCreatorViewAltRoute on GoRouteData {
  static MangaDexCreatorViewAltRoute _fromState(GoRouterState state) =>
      MangaDexCreatorViewAltRoute(
        creatorId: state.pathParameters['creatorId']!,
        name: state.pathParameters['name'],
        $extra: state.extra as CreatorType?,
      );

  MangaDexCreatorViewAltRoute get _self => this as MangaDexCreatorViewAltRoute;

  @override
  String get location => GoRouteData.$location(
    '/author/${Uri.encodeComponent(_self.creatorId)}/${Uri.encodeComponent(_self.name ?? '')}',
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $mangaDexGroupViewRoute => GoRouteData.$route(
  path: '/group/:groupId',
  factory: $MangaDexGroupViewRoute._fromState,
);

mixin $MangaDexGroupViewRoute on GoRouteData {
  static MangaDexGroupViewRoute _fromState(GoRouterState state) =>
      MangaDexGroupViewRoute(
        groupId: state.pathParameters['groupId']!,
        $extra: state.extra as Group?,
      );

  MangaDexGroupViewRoute get _self => this as MangaDexGroupViewRoute;

  @override
  String get location =>
      GoRouteData.$location('/group/${Uri.encodeComponent(_self.groupId)}');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $mangaDexGroupViewAltRoute => GoRouteData.$route(
  path: '/group/:groupId/:name',
  factory: $MangaDexGroupViewAltRoute._fromState,
);

mixin $MangaDexGroupViewAltRoute on GoRouteData {
  static MangaDexGroupViewAltRoute _fromState(GoRouterState state) =>
      MangaDexGroupViewAltRoute(
        groupId: state.pathParameters['groupId']!,
        name: state.pathParameters['name'],
        $extra: state.extra as Group?,
      );

  MangaDexGroupViewAltRoute get _self => this as MangaDexGroupViewAltRoute;

  @override
  String get location => GoRouteData.$location(
    '/group/${Uri.encodeComponent(_self.groupId)}/${Uri.encodeComponent(_self.name ?? '')}',
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $mangaDexGlobalFeedRoute => GoRouteData.$route(
  path: '/titles/latest',
  factory: $MangaDexGlobalFeedRoute._fromState,
);

mixin $MangaDexGlobalFeedRoute on GoRouteData {
  static MangaDexGlobalFeedRoute _fromState(GoRouterState state) =>
      const MangaDexGlobalFeedRoute();

  @override
  String get location => GoRouteData.$location('/titles/latest');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mangaDexLoginRoute =>
    GoRouteData.$route(path: '/login', factory: $MangaDexLoginRoute._fromState);

mixin $MangaDexLoginRoute on GoRouteData {
  static MangaDexLoginRoute _fromState(GoRouterState state) =>
      const MangaDexLoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $webSourceHomeRouteData => ShellRouteData.$route(
  factory: $WebSourceHomeRouteDataExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/extensions',
      factory: $WebSourceFrontRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/extensions/updates',
      factory: $WebSourceUpdatesRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/extensions/saved',
      factory: $WebSourceFavoritesRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/extensions/history',
      factory: $WebSourceHistoryRoute._fromState,
    ),
  ],
);

extension $WebSourceHomeRouteDataExtension on WebSourceHomeRouteData {
  static WebSourceHomeRouteData _fromState(GoRouterState state) =>
      const WebSourceHomeRouteData();
}

mixin $WebSourceFrontRoute on GoRouteData {
  static WebSourceFrontRoute _fromState(GoRouterState state) =>
      const WebSourceFrontRoute();

  @override
  String get location => GoRouteData.$location('/extensions');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $WebSourceUpdatesRoute on GoRouteData {
  static WebSourceUpdatesRoute _fromState(GoRouterState state) =>
      const WebSourceUpdatesRoute();

  @override
  String get location => GoRouteData.$location('/extensions/updates');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $WebSourceFavoritesRoute on GoRouteData {
  static WebSourceFavoritesRoute _fromState(GoRouterState state) =>
      const WebSourceFavoritesRoute();

  @override
  String get location => GoRouteData.$location('/extensions/saved');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $WebSourceHistoryRoute on GoRouteData {
  static WebSourceHistoryRoute _fromState(GoRouterState state) =>
      const WebSourceHistoryRoute();

  @override
  String get location => GoRouteData.$location('/extensions/history');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $extensionHomeRoute => GoRouteData.$route(
  path: '/extensions/:sourceId/home',
  factory: $ExtensionHomeRoute._fromState,
);

mixin $ExtensionHomeRoute on GoRouteData {
  static ExtensionHomeRoute _fromState(GoRouterState state) =>
      ExtensionHomeRoute(
        sourceId: state.pathParameters['sourceId']!,
        source: _$convertMapValue('source', state.uri.queryParameters, (
          String json0,
        ) {
          return WebSourceInfo.fromJson(
            jsonDecode(json0) as Map<String, dynamic>,
          );
        }),
      );

  ExtensionHomeRoute get _self => this as ExtensionHomeRoute;

  @override
  String get location => GoRouteData.$location(
    '/extensions/${Uri.encodeComponent(_self.sourceId)}/home',
    queryParams: {
      if (_self.source != null) 'source': jsonEncode(_self.source!.toJson()),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $webMangaViewRoute => GoRouteData.$route(
  path: '/read/:sourceId/:mangaId',
  factory: $WebMangaViewRoute._fromState,
);

mixin $WebMangaViewRoute on GoRouteData {
  static WebMangaViewRoute _fromState(GoRouterState state) => WebMangaViewRoute(
    sourceId: state.pathParameters['sourceId']!,
    mangaId: state.pathParameters['mangaId']!,
    handle: _$convertMapValue('handle', state.uri.queryParameters, (
      String json0,
    ) {
      return SourceHandler.fromJson(jsonDecode(json0) as Map<String, dynamic>);
    }),
  );

  WebMangaViewRoute get _self => this as WebMangaViewRoute;

  @override
  String get location => GoRouteData.$location(
    '/read/${Uri.encodeComponent(_self.sourceId)}/${Uri.encodeComponent(_self.mangaId)}',
    queryParams: {
      if (_self.handle != null) 'handle': jsonEncode(_self.handle!.toJson()),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $proxyWebSourceReaderRoute => GoRouteData.$route(
  path: '/read/:proxy/:code/:chapter/:page',
  factory: $ProxyWebSourceReaderRoute._fromState,
);

mixin $ProxyWebSourceReaderRoute on GoRouteData {
  static ProxyWebSourceReaderRoute _fromState(GoRouterState state) =>
      ProxyWebSourceReaderRoute(
        proxy: state.pathParameters['proxy']!,
        code: state.pathParameters['code']!,
        chapter: state.pathParameters['chapter']!,
        page: state.pathParameters['page'],
        $extra: state.extra as WebReaderData?,
      );

  ProxyWebSourceReaderRoute get _self => this as ProxyWebSourceReaderRoute;

  @override
  String get location => GoRouteData.$location(
    '/read/${Uri.encodeComponent(_self.proxy)}/${Uri.encodeComponent(_self.code)}/${Uri.encodeComponent(_self.chapter)}/${Uri.encodeComponent(_self.page ?? '')}',
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $extensionReaderRoute => GoRouteData.$route(
  path: '/read-chapter/:sourceId/:mangaId/:chapterId',
  factory: $ExtensionReaderRoute._fromState,
);

mixin $ExtensionReaderRoute on GoRouteData {
  static ExtensionReaderRoute _fromState(GoRouterState state) =>
      ExtensionReaderRoute(
        sourceId: state.pathParameters['sourceId']!,
        mangaId: state.pathParameters['mangaId']!,
        chapterId: state.pathParameters['chapterId']!,
        $extra: state.extra as WebReaderData?,
      );

  ExtensionReaderRoute get _self => this as ExtensionReaderRoute;

  @override
  String get location => GoRouteData.$location(
    '/read-chapter/${Uri.encodeComponent(_self.sourceId)}/${Uri.encodeComponent(_self.mangaId)}/${Uri.encodeComponent(_self.chapterId)}',
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $extensionSearchRoute => GoRouteData.$route(
  path: '/extensions/search',
  factory: $ExtensionSearchRoute._fromState,
);

mixin $ExtensionSearchRoute on GoRouteData {
  static ExtensionSearchRoute _fromState(GoRouterState state) =>
      ExtensionSearchRoute(
        initialSource: _$convertMapValue(
          'initial-source',
          state.uri.queryParameters,
          (String json0) {
            return WebSourceInfo.fromJson(
              jsonDecode(json0) as Map<String, dynamic>,
            );
          },
        ),
        query: _$convertMapValue('query', state.uri.queryParameters, (
          String json0,
        ) {
          return SearchQuery.fromJson(
            jsonDecode(json0) as Map<String, dynamic>,
          );
        }),
      );

  ExtensionSearchRoute get _self => this as ExtensionSearchRoute;

  @override
  String get location => GoRouteData.$location(
    '/extensions/search',
    queryParams: {
      if (_self.initialSource != null)
        'initial-source': jsonEncode(_self.initialSource!.toJson()),
      if (_self.query != null) 'query': jsonEncode(_self.query!.toJson()),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $addRepoRoute => GoRouteData.$route(
  path: '/extensions/addrepo',
  factory: $AddRepoRoute._fromState,
);

mixin $AddRepoRoute on GoRouteData {
  static AddRepoRoute _fromState(GoRouterState state) => AddRepoRoute(
    name: state.uri.queryParameters['name']!,
    url: state.uri.queryParameters['url']!,
  );

  AddRepoRoute get _self => this as AddRepoRoute;

  @override
  String get location => GoRouteData.$location(
    '/extensions/addrepo',
    queryParams: {'name': _self.name, 'url': _self.url},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
