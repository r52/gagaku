import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/local/main.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/chapter_feed.dart';
import 'package:gagaku/mangadex/creator_view.dart';
import 'package:gagaku/mangadex/group_view.dart';
import 'package:gagaku/mangadex/history_feed.dart';
import 'package:gagaku/mangadex/latest_feed.dart';
import 'package:gagaku/mangadex/library.dart';
import 'package:gagaku/mangadex/login_old.dart';
import 'package:gagaku/mangadex/main.dart';
import 'package:gagaku/mangadex/manga_feed.dart';
import 'package:gagaku/mangadex/manga_view.dart';
import 'package:gagaku/mangadex/reader.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:gagaku/web/main.dart';
import 'package:gagaku/web/manga_view.dart';
import 'package:gagaku/web/reader.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class _HttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 5;
  }
}

void main() async {
  HttpOverrides.global = _HttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(gagakuBox);

  final appdir = await getApplicationSupportDirectory();

  if (kReleaseMode) {
    Logger.level = Level.warning;
  }

  logger = Logger(
    filter: kReleaseMode ? ProductionFilter() : null,
    printer: PrettyPrinter(
      colors: false,
      printTime: true,
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

  runApp(const ProviderScope(child: App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<ScrollController> _controllers = [];

  late final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: !kReleaseMode,
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
        path: GagakuRoute.login,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return const MangaDexLoginScreen();
        },
      ),
      // Main mangadex page
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return MangaDexHome(
            controllers: _controllers,
            child: child,
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: MangaDexGlobalFeed(
                controller: _controllers[0],
              ),
              transitionsBuilder: Styles.horizontalSharedAxisTransitionBuilder,
            ),
          ),
          GoRoute(
            path: GagakuRoute.mangafeed,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: MangaDexLoginWidget(
                key: const Key(GagakuRoute.mangafeed),
                builder: (context, ref) {
                  return MangaDexMangaFeed(
                    controller: _controllers[1],
                  );
                },
              ),
              transitionsBuilder: Styles.horizontalSharedAxisTransitionBuilder,
            ),
          ),
          GoRoute(
            path: GagakuRoute.chapterfeed,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: MangaDexLoginWidget(
                key: const Key(GagakuRoute.chapterfeed),
                builder: (context, ref) {
                  return MangaDexChapterFeed(
                    controller: _controllers[2],
                  );
                },
              ),
              transitionsBuilder: Styles.horizontalSharedAxisTransitionBuilder,
            ),
          ),
          GoRoute(
            path: GagakuRoute.library,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: MangaDexLoginWidget(
                key: const Key(GagakuRoute.library),
                builder: (context, ref) {
                  return MangaDexLibraryView(
                    controller: _controllers[3],
                  );
                },
              ),
              transitionsBuilder: Styles.horizontalSharedAxisTransitionBuilder,
            ),
          ),
          GoRoute(
            path: GagakuRoute.history,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: MangaDexHistoryFeed(
                controller: _controllers[4],
              ),
              transitionsBuilder: Styles.horizontalSharedAxisTransitionBuilder,
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
      GoRoute(
        path: GagakuRoute.web,
        builder: (BuildContext context, GoRouterState state) {
          return const WebSourcesHome();
        },
        routes: <RouteBase>[
          GoRoute(
            path: GagakuRoute.webManga,
            parentNavigatorKey: _rootNavigatorKey,
            pageBuilder: buildWebMangaViewPage,
          ),
          GoRoute(
            path: GagakuRoute.webMangaFull,
            parentNavigatorKey: _rootNavigatorKey,
            pageBuilder: buildWebReaderPage,
          ),
        ],
      ),
    ],
  );

  @override
  void initState() {
    super.initState();

    _controllers.addAll([
      ScrollController(),
      ScrollController(),
      ScrollController(),
      ScrollController(),
      ScrollController(),
    ]);
  }

  @override
  void dispose() {
    super.dispose();

    for (var element in _controllers) {
      element.dispose();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gagaku',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber, brightness: Brightness.light),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber, brightness: Brightness.dark),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
