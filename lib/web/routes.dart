// ignore_for_file: riverpod_lint/provider_dependencies
part of 'package:gagaku/routes.dart';

final GlobalKey<NavigatorState> webshellNavigatorKey =
    GlobalKey<NavigatorState>();

@TypedShellRoute<WebSourceHomeRouteData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<WebSourceFrontRoute>(path: GagakuRoute.extension),
    TypedGoRoute<WebSourceUpdatesRoute>(path: GagakuRoute.extensionUpdates),
    TypedGoRoute<WebSourceFavoritesRoute>(path: GagakuRoute.extensionSaved),
    TypedGoRoute<WebSourceHistoryRoute>(path: GagakuRoute.extensionHistory),
  ],
)
class WebSourceHomeRouteData extends ShellRouteData {
  const WebSourceHomeRouteData();

  static final GlobalKey<NavigatorState> navigatorKey = webshellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return WebSourceHomePage(child: navigator);
  }
}

class WebSourceFrontRoute extends GoRouteData with $WebSourceFrontRoute {
  const WebSourceFrontRoute();
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: WebSourceFrontPage(),
      transitionsBuilder: Styles.fadeThroughTransitionBuilder,
    );
  }
}

@TypedGoRoute<ExtensionHomeRoute>(path: GagakuRoute.extensionHomePage)
class ExtensionHomeRoute extends GoRouteData with $ExtensionHomeRoute {
  const ExtensionHomeRoute({required this.sourceId, this.source});

  final String sourceId;
  final WebSourceInfo? source;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: ExtensionHomePage(sourceId: sourceId, source: source),
      transitionsBuilder: Styles.slideTransitionBuilder,
    );
  }
}

class WebSourceUpdatesRoute extends GoRouteData with $WebSourceUpdatesRoute {
  const WebSourceUpdatesRoute();
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: WebSourceUpdatesPage(),
      transitionsBuilder: Styles.fadeThroughTransitionBuilder,
    );
  }
}

class WebSourceFavoritesRoute extends GoRouteData
    with $WebSourceFavoritesRoute {
  const WebSourceFavoritesRoute();
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: WebSourceFavoritesPage(),
      transitionsBuilder: Styles.fadeThroughTransitionBuilder,
    );
  }
}

class WebSourceHistoryRoute extends GoRouteData with $WebSourceHistoryRoute {
  const WebSourceHistoryRoute();
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: WebSourceHistoryPage(),
      transitionsBuilder: Styles.fadeThroughTransitionBuilder,
    );
  }
}

@TypedGoRoute<WebMangaViewRoute>(path: GagakuRoute.webManga)
class WebMangaViewRoute extends GoRouteData with $WebMangaViewRoute {
  const WebMangaViewRoute({
    required this.sourceId,
    required this.mangaId,
    this.handle,
  });

  final String sourceId;
  final String mangaId;
  final SourceHandler? handle;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: WebMangaViewPage(
        sourceId: sourceId,
        mangaId: mangaId,
        handle: handle,
      ),
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    );
  }
}

@TypedGoRoute<ProxyWebSourceReaderRoute>(path: GagakuRoute.proxyChapter)
class ProxyWebSourceReaderRoute extends GoRouteData
    with $ProxyWebSourceReaderRoute {
  const ProxyWebSourceReaderRoute({
    required this.proxy,
    required this.code,
    required this.chapter,
    this.page,
    this.$extra,
  });

  final String proxy;
  final String code;
  final String chapter;
  final String? page;

  final WebReaderData? $extra;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: ProxyWebSourceReaderPage(
        proxy: proxy,
        code: code,
        chapter: chapter,
        page: page,
        readerData: $extra,
      ),
      transitionsBuilder: Styles.slideTransitionBuilder,
    );
  }
}

@TypedGoRoute<ExtensionReaderRoute>(path: GagakuRoute.extensionChapter)
class ExtensionReaderRoute extends GoRouteData with $ExtensionReaderRoute {
  const ExtensionReaderRoute({
    required this.sourceId,
    required this.mangaId,
    required this.chapterId,
    this.$extra,
  });

  final String sourceId;
  final String mangaId;
  final String chapterId;
  final WebReaderData? $extra;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: ExtensionReaderPage(
        sourceId: sourceId,
        mangaId: mangaId,
        chapterId: chapterId,
        readerData: $extra,
      ),
      transitionsBuilder: Styles.slideTransitionBuilder,
    );
  }
}

@TypedGoRoute<ExtensionSearchRoute>(path: GagakuRoute.extensionSearch)
class ExtensionSearchRoute extends GoRouteData with $ExtensionSearchRoute {
  const ExtensionSearchRoute({this.initialSource, this.query});

  final WebSourceInfo? initialSource;
  final SearchQuery? query;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: ExtensionSearchPage(initialSource: initialSource, query: query),
      transitionsBuilder: Styles.slideTransitionBuilder,
    );
  }
}

@TypedGoRoute<AddRepoRoute>(path: GagakuRoute.extensionAddRepo)
class AddRepoRoute extends GoRouteData with $AddRepoRoute {
  const AddRepoRoute({required this.name, required this.url});

  final String name;
  final String url;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage(
      key: state.pageKey,
      child: AddRepoDialog(name: name, url: url),
    );
  }
}
