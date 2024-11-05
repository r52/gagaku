import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/config.dart';
import 'package:gagaku/local/main.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/cache.dart';
import 'package:gagaku/mangadex/chapter_feed.dart';
import 'package:gagaku/mangadex/creator_view.dart';
import 'package:gagaku/mangadex/edit_list.dart';
import 'package:gagaku/mangadex/frontpage.dart';
import 'package:gagaku/mangadex/group_view.dart';
import 'package:gagaku/mangadex/history_feed.dart';
import 'package:gagaku/mangadex/latest_feed.dart';
import 'package:gagaku/mangadex/library.dart';
import 'package:gagaku/mangadex/list_view.dart';
import 'package:gagaku/mangadex/lists.dart';
import 'package:gagaku/mangadex/login_password.dart';
import 'package:gagaku/mangadex/main.dart';
import 'package:gagaku/mangadex/manga_view.dart';
import 'package:gagaku/mangadex/reader.dart';
import 'package:gagaku/mangadex/recent_feed.dart';
import 'package:gagaku/mangadex/search.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/settings.dart';
import 'package:gagaku/types.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/favorites.dart';
import 'package:gagaku/web/history.dart';
import 'package:gagaku/web/main.dart';
import 'package:gagaku/web/manga_view.dart';
import 'package:gagaku/web/reader.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _mdShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'mdshell');
final GlobalKey<NavigatorState> _proxyShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'proxyshell');

class _HttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 5;
  }
}

void main() async {
  HttpOverrides.global = _HttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  timeagoLocalesMap.forEach((locale, lookupMessages) {
    timeago.setLocaleMessages(locale, lookupMessages);
  });

  await Hive.initFlutter();
  Hive.registerAdapter(CacheEntryAdapter());
  await Hive.openBox(gagakuBox);
  await Hive.openLazyBox<CacheEntry>(gagakuCache);

  final appdir = await getApplicationSupportDirectory();

  if (kReleaseMode) {
    Logger.level = Level.warning;
  }

  logger = Logger(
    filter: kReleaseMode ? ProductionFilter() : null,
    printer: PrettyPrinter(
      colors: false,
      dateTimeFormat: DateTimeFormat.onlyTime,
      excludeBox: {
        Level.trace: true,
        Level.debug: true,
        Level.info: true,
      },
    ),
    output: DeviceContext.isDesktop()
        ? (kReleaseMode
            ? FileOutput(file: File(p.join(appdir.path, 'gagaku.log')))
            : MultiOutput([
                FileOutput(file: File(p.join(appdir.path, 'gagaku.log'))),
                ConsoleOutput(),
              ]))
        : null,
  );

  final pkg = await PackageInfo.fromPlatform();
  final gdat = GagakuData();
  gdat.gagakuUserAgent = '${pkg.appName}/${pkg.version}';

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: App(),
      ),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    restorationScopeId: 'root_route_restore',
    initialLocation: '/',
    debugLogDiagnostics: !kReleaseMode,
    onException: (_, GoRouterState state, GoRouter router) {
      router.go('/404', extra: state.uri.toString());
    },
    routes: <RouteBase>[
      // MD endpoints
      GoRoute(
        path: GagakuRoute.manga,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildMangaViewPage,
      ),
      GoRoute(
        path: GagakuRoute.mangaAlt,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildMangaViewPage,
      ),
      GoRoute(
        path: GagakuRoute.chapter,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildMDReaderPage,
      ),
      GoRoute(
        path: GagakuRoute.group,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildGroupViewPage,
      ),
      GoRoute(
        path: GagakuRoute.groupAlt,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildGroupViewPage,
      ),
      GoRoute(
        path: GagakuRoute.creator,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildCreatorViewPage,
      ),
      GoRoute(
        path: GagakuRoute.creatorAlt,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildCreatorViewPage,
      ),
      GoRoute(
        path: GagakuRoute.listEdit,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildListEditPage,
      ),
      GoRoute(
        path: GagakuRoute.list,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildListViewPage,
      ),
      GoRoute(
        path: GagakuRoute.listAlt,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildListViewPage,
      ),
      GoRoute(
        path: GagakuRoute.search,
        parentNavigatorKey: _rootNavigatorKey,
        builder: buildMDSearchPage,
      ),
      GoRoute(
        path: GagakuRoute.listCreate,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return const MangaDexEditListScreen();
        },
      ),
      GoRoute(
        path: GagakuRoute.login,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return const MangaDexLoginScreen();
        },
      ),
      GoRoute(
        path: GagakuRoute.latestfeed,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildLatestFeedPage,
      ),
      GoRoute(
        path: GagakuRoute.recentfeed,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildRecentFeedPage,
      ),
      // Main mangadex page
      ShellRoute(
        navigatorKey: _mdShellNavigatorKey,
        restorationScopeId: 'md_route_restore',
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return MangaDexHome(
            child: child,
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: MangaDexFrontPage(),
              transitionsBuilder: Styles.fadeThroughTransitionBuilder,
              restorationId: 'md_main_restore',
            ),
          ),
          GoRoute(
            path: GagakuRoute.chapterfeed,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: MangaDexLoginWidget(
                key: const Key(GagakuRoute.chapterfeed),
                builder: (context, ref) {
                  return MangaDexChapterFeed();
                },
              ),
              transitionsBuilder: Styles.fadeThroughTransitionBuilder,
              restorationId: 'md_chapterfeed_restore',
            ),
          ),
          GoRoute(
            path: GagakuRoute.library,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: MangaDexLoginWidget(
                key: const Key(GagakuRoute.library),
                builder: (context, ref) {
                  return MangaDexLibraryView();
                },
              ),
              transitionsBuilder: Styles.fadeThroughTransitionBuilder,
              restorationId: 'md_library_restore',
            ),
          ),
          GoRoute(
            path: GagakuRoute.lists,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: MangaDexLoginWidget(
                key: const Key(GagakuRoute.lists),
                builder: (context, ref) {
                  return MangaDexListsView();
                },
              ),
              transitionsBuilder: Styles.fadeThroughTransitionBuilder,
              restorationId: 'md_lists_restore',
            ),
          ),
          GoRoute(
            path: GagakuRoute.history,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: MangaDexHistoryFeed(),
              transitionsBuilder: Styles.fadeThroughTransitionBuilder,
              restorationId: 'md_history_restore',
            ),
          ),
        ],
      ),
      // Local
      GoRoute(
        path: GagakuRoute.local,
        builder: (BuildContext context, GoRouterState state) {
          return const LocalLibraryHome();
        },
      ),
      // Web
      ShellRoute(
        navigatorKey: _proxyShellNavigatorKey,
        restorationScopeId: 'proxy_route_restore',
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return WebSourceHome(
            child: child,
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: GagakuRoute.proxyHome,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: WebSourceHistoryWidget(),
              transitionsBuilder: Styles.fadeThroughTransitionBuilder,
              restorationId: 'proxy_home_restore',
            ),
          ),
          GoRoute(
            path: GagakuRoute.proxySaved,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: WebSourceFavoritesWidget(),
              transitionsBuilder: Styles.fadeThroughTransitionBuilder,
              restorationId: 'proxy_saved_restore',
            ),
          ),
        ],
      ),
      GoRoute(
        path: GagakuRoute.webManga,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildWebMangaViewPage,
      ),
      GoRoute(
        path: GagakuRoute.webMangaChapter,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildWebReaderPage,
      ),
      GoRoute(
        path: GagakuRoute.webMangaSource,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildWebMangaViewPage,
      ),
      GoRoute(
        path: GagakuRoute.webMangaSourceChapter,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildWebReaderPage,
      ),
      GoRoute(
        path: '/ml/:url(.*)',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildRedirectedWebMangaViewPage,
      ),
      GoRoute(
        path: '/mk/:url(.*)',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: buildRedirectedWebMangaViewPage,
      ),
      // Settings route
      GoRoute(
        path: GagakuRoute.config,
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsHome();
        },
      ),
      // Error route
      GoRoute(
        path: '/404',
        builder: (BuildContext context, GoRouterState state) {
          return NotFoundScreen(uri: state.extra as String? ?? '');
        },
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final config = ref.watch(gagakuSettingsProvider);

    return MaterialApp.router(
      title: 'Gagaku',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: config.theme.color, brightness: Brightness.light),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
            seedColor: config.theme.color,
            brightness: Brightness.dark,
            dynamicSchemeVariant: DynamicSchemeVariant.content),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      themeMode: config.themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      restorationScopeId: 'app_root_restore',
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, required this.uri});

  final String uri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pageNotFound.header'.tr(context: context)),
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: Center(
        child: Text('pageNotFound.error'.tr(context: context, args: [uri])),
      ),
    );
  }
}
