import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/util/ui.dart';

FutureOr<DeepLink> handleDeepLink(PlatformDeepLink deepLink) {
  if (deepLink.uri.isScheme('paperback')) {
    return DeepLink.single(WebSourceFrontRoute(process: deepLink.uri));
  }

  return deepLink;
}

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    // MD
    CustomRoute(
      path: GagakuRoute.latestfeed,
      page: MangaDexGlobalFeedRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.recentfeed,
      page: MangaDexRecentFeedRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.chapter,
      page: MangaDexReaderRoute.page,
      transitionsBuilder: Styles.slideTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.manga,
      page: MangaDexMangaViewRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.mangaAlt,
      page: MangaDexMangaViewWithNameRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.list,
      page: MangaDexListViewRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.listAlt,
      page: MangaDexListViewWithNameRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.creator,
      page: MangaDexCreatorViewRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.creatorAlt,
      page: MangaDexCreatorViewWithNameRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.group,
      page: MangaDexGroupViewRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.groupAlt,
      page: MangaDexGroupViewWithNameRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.search,
      page: MangaDexSearchRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.listEdit,
      page: MangaDexEditListRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.listCreate,
      page: MangaDexCreateListRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.tag,
      page: MangaDexTagViewRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.tagAlt,
      page: MangaDexTagViewWithNameRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.login,
      page: MangaDexLoginRoute.page,
      transitionsBuilder: Styles.slideTransitionBuilder,
    ),
    AutoRoute(
      path: '/',
      page: MangaDexHomeRoute.page,
      initial: true,
      children: [
        CustomRoute(
          path: '',
          page: MangaDexFrontRoute.page,
          initial: true,
          transitionsBuilder: Styles.fadeThroughTransitionBuilder,
        ),
        CustomRoute(
          path: GagakuRoute.chapterfeed,
          page: MangaDexChapterFeedRoute.page,
          transitionsBuilder: Styles.fadeThroughTransitionBuilder,
        ),
        CustomRoute(
          path: GagakuRoute.library,
          page: MangaDexLibraryRoute.page,
          transitionsBuilder: Styles.fadeThroughTransitionBuilder,
        ),
        CustomRoute(
          path: GagakuRoute.lists,
          page: MangaDexListsRoute.page,
          transitionsBuilder: Styles.fadeThroughTransitionBuilder,
        ),
        CustomRoute(
          path: GagakuRoute.history,
          page: MangaDexHistoryFeedRoute.page,
          transitionsBuilder: Styles.fadeThroughTransitionBuilder,
        ),
      ],
    ),

    // Local
    CustomRoute(path: GagakuRoute.local, page: LocalLibraryHomeRoute.page),

    // Extensions
    CustomRoute(
      path: GagakuRoute.proxyChapter,
      page: ProxyWebSourceReaderRoute.page,
      transitionsBuilder: Styles.slideTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.extensionChapter,
      page: ExtensionReaderRoute.page,
      transitionsBuilder: Styles.slideTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.extensionHomePage,
      page: ExtensionHomeRoute.page,
      transitionsBuilder: Styles.slideTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.extensionSearch,
      page: ExtensionSearchRoute.page,
      transitionsBuilder: Styles.slideTransitionBuilder,
    ),
    CustomRoute(
      path: GagakuRoute.webManga,
      page: WebMangaViewRoute.page,
      transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
    ),
    AutoRoute(
      path: GagakuRoute.extension,
      page: WebSourceHomeRoute.page,
      children: [
        CustomRoute(
          path: '',
          page: WebSourceFrontRoute.page,
          initial: true,
          transitionsBuilder: Styles.fadeThroughTransitionBuilder,
        ),
        CustomRoute(
          path: GagakuRoute.extensionUpdates,
          page: WebSourceUpdatesRoute.page,
          transitionsBuilder: Styles.fadeThroughTransitionBuilder,
        ),
        CustomRoute(
          path: GagakuRoute.extensionSaved,
          page: WebSourceFavoritesRoute.page,
          transitionsBuilder: Styles.fadeThroughTransitionBuilder,
        ),
        CustomRoute(
          path: GagakuRoute.extensionHistory,
          page: WebSourceHistoryRoute.page,
          transitionsBuilder: Styles.fadeThroughTransitionBuilder,
        ),
      ],
    ),

    // Global Settings
    AutoRoute(path: GagakuRoute.config, page: AppSettingsRoute.page),

    // Catch all
    AutoRoute(path: '/404', page: NotFoundRoute.page),
    AutoRoute(
      path: '*',
      page: const PageInfo.emptyShell('404Route'),
      guards: [
        AutoRouteGuard.redirect((resolver) {
          final route = resolver.route;
          return NotFoundRoute(uri: route.fullPath);
        }),
      ],
    ),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    // optionally add root guards here
  ];
}
