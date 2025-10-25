// ignore_for_file: provider_dependencies
part of 'package:gagaku/routes.dart';

final GlobalKey<NavigatorState> mdshellNavigatorKey =
    GlobalKey<NavigatorState>();

@TypedShellRoute<MangaDexHomeRouteData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<MangaDexFrontRoute>(path: '/'),
    TypedGoRoute<MangaDexChapterFeedRoute>(path: GagakuRoute.chapterfeed),
    TypedGoRoute<MangaDexLibraryRoute>(path: GagakuRoute.library),
    TypedGoRoute<MangaDexListsRoute>(path: GagakuRoute.lists),
    TypedGoRoute<MangaDexHistoryFeedRoute>(path: GagakuRoute.history),
  ],
)
class MangaDexHomeRouteData extends ShellRouteData {
  const MangaDexHomeRouteData();

  static final GlobalKey<NavigatorState> navigatorKey = mdshellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MangaDexHomePage(child: navigator);
  }
}

class MangaDexFrontRoute extends GoRouteData with $MangaDexFrontRoute {
  const MangaDexFrontRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexFrontPage(),
      transitionsBuilder: Styles.fadeThroughTransitionBuilder,
    );
  }
}

class MangaDexChapterFeedRoute extends GoRouteData
    with $MangaDexChapterFeedRoute {
  const MangaDexChapterFeedRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexChapterFeedPage(),
      transitionsBuilder: Styles.fadeThroughTransitionBuilder,
    );
  }
}

class MangaDexLibraryRoute extends GoRouteData with $MangaDexLibraryRoute {
  const MangaDexLibraryRoute();
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexLibraryPage(),
      transitionsBuilder: Styles.fadeThroughTransitionBuilder,
    );
  }
}

class MangaDexListsRoute extends GoRouteData with $MangaDexListsRoute {
  const MangaDexListsRoute();
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexListsPage(),
      transitionsBuilder: Styles.fadeThroughTransitionBuilder,
    );
  }
}

class MangaDexHistoryFeedRoute extends GoRouteData
    with $MangaDexHistoryFeedRoute {
  const MangaDexHistoryFeedRoute();
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexHistoryFeedPage(),
      transitionsBuilder: Styles.fadeThroughTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexReaderRoute>(path: GagakuRoute.chapter)
class MangaDexReaderRoute extends GoRouteData with $MangaDexReaderRoute {
  const MangaDexReaderRoute({required this.chapterId, this.$extra});

  final String chapterId;
  final ReaderData? $extra;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexReaderPage(chapterId: chapterId, readerData: $extra),
      transitionsBuilder: Styles.slideTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexRecentFeedRoute>(path: GagakuRoute.recentfeed)
class MangaDexRecentFeedRoute extends GoRouteData
    with $MangaDexRecentFeedRoute {
  const MangaDexRecentFeedRoute();
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexRecentFeedPage(),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexSearchRoute>(path: GagakuRoute.search)
class MangaDexSearchRoute extends GoRouteData with $MangaDexSearchRoute {
  const MangaDexSearchRoute({
    this.selectMode = false,
    this.selectedTitles,
    this.$extra,
  });

  final bool selectMode;
  final Set<String>? selectedTitles;
  final MangaSearchParameters? $extra;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexSearchPage(
        selectMode: selectMode,
        selectedTitles: selectedTitles,
        parameters: $extra,
      ),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexTagViewRoute>(path: GagakuRoute.tag)
class MangaDexTagViewRoute extends GoRouteData with $MangaDexTagViewRoute {
  const MangaDexTagViewRoute({required this.tagId, this.tag});

  final String tagId;
  final Tag? tag;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexTagViewPage(tagId: tagId, tag: tag),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexTagViewAltRoute>(path: GagakuRoute.tagAlt)
class MangaDexTagViewAltRoute extends GoRouteData
    with $MangaDexTagViewAltRoute {
  const MangaDexTagViewAltRoute({required this.tagId, this.name, this.tag});

  final String tagId;
  final String? name;
  final Tag? tag;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexTagViewPage(tagId: tagId, tag: tag),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexMangaViewRoute>(path: GagakuRoute.manga)
class MangaDexMangaViewRoute extends GoRouteData with $MangaDexMangaViewRoute {
  const MangaDexMangaViewRoute({required this.mangaId, this.manga});

  final String mangaId;
  final Manga? manga;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexMangaViewPage(mangaId: mangaId, manga: manga),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexMangaViewAltRoute>(path: GagakuRoute.mangaAlt)
class MangaDexMangaViewAltRoute extends GoRouteData
    with $MangaDexMangaViewAltRoute {
  const MangaDexMangaViewAltRoute({
    required this.mangaId,
    this.name,
    this.manga,
  });

  final String mangaId;
  final String? name;
  final Manga? manga;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexMangaViewPage(mangaId: mangaId, manga: manga),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexCreateListRoute>(path: GagakuRoute.listCreate)
class MangaDexCreateListRoute extends GoRouteData
    with $MangaDexCreateListRoute {
  const MangaDexCreateListRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexCreateListScreen(),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexEditListRoute>(path: GagakuRoute.listEdit)
class MangaDexEditListRoute extends GoRouteData with $MangaDexEditListRoute {
  const MangaDexEditListRoute({this.listId, this.list});

  final String? listId;
  final CustomList? list;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexEditListScreen(listId: listId, list: list),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexListViewRoute>(path: GagakuRoute.list)
class MangaDexListViewRoute extends GoRouteData with $MangaDexListViewRoute {
  const MangaDexListViewRoute({required this.listId});

  final String listId;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexListViewPage(listId: listId),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexListViewAltRoute>(path: GagakuRoute.listAlt)
class MangaDexListViewAltRoute extends GoRouteData
    with $MangaDexListViewAltRoute {
  const MangaDexListViewAltRoute({required this.listId, this.name});

  final String listId;
  final String? name;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexListViewPage(listId: listId),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexCreatorViewRoute>(path: GagakuRoute.creator)
class MangaDexCreatorViewRoute extends GoRouteData
    with $MangaDexCreatorViewRoute {
  const MangaDexCreatorViewRoute({required this.creatorId, this.$extra});

  final String creatorId;
  final CreatorType? $extra;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexCreatorViewPage(creatorId: creatorId, creator: $extra),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexCreatorViewAltRoute>(path: GagakuRoute.creatorAlt)
class MangaDexCreatorViewAltRoute extends GoRouteData
    with $MangaDexCreatorViewAltRoute {
  const MangaDexCreatorViewAltRoute({
    required this.creatorId,
    this.name,
    this.$extra,
  });

  final String creatorId;
  final String? name;
  final CreatorType? $extra;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexCreatorViewPage(creatorId: creatorId, creator: $extra),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexGroupViewRoute>(path: GagakuRoute.group)
class MangaDexGroupViewRoute extends GoRouteData with $MangaDexGroupViewRoute {
  const MangaDexGroupViewRoute({required this.groupId, this.$extra});

  final String groupId;
  final Group? $extra;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexGroupViewPage(groupId: groupId, group: $extra),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexGroupViewAltRoute>(path: GagakuRoute.groupAlt)
class MangaDexGroupViewAltRoute extends GoRouteData
    with $MangaDexGroupViewAltRoute {
  const MangaDexGroupViewAltRoute({
    required this.groupId,
    this.name,
    this.$extra,
  });

  final String groupId;
  final String? name;
  final Group? $extra;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexGroupViewPage(groupId: groupId, group: $extra),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexGlobalFeedRoute>(path: GagakuRoute.latestfeed)
class MangaDexGlobalFeedRoute extends GoRouteData
    with $MangaDexGlobalFeedRoute {
  const MangaDexGlobalFeedRoute();
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MangaDexGlobalFeedPage(),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<MangaDexLoginRoute>(path: GagakuRoute.login)
class MangaDexLoginRoute extends GoRouteData with $MangaDexLoginRoute {
  const MangaDexLoginRoute();
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: const MangaDexLoginScreen(),
      transitionsBuilder: Styles.slideTransitionBuilder,
    );
  }
}
