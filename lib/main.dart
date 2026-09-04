import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/model/maintenance.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/model/startup_section.dart';
import 'package:gagaku/model/types.dart';
import 'package:gagaku/model/update_metadata.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/sync/service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/update_checker.dart';
import 'package:gagaku/update_installer.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/deeplink.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:timeago/timeago.dart' as timeago;

class _HttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..maxConnectionsPerHost = 5
      ..connectionTimeout = const Duration(seconds: 10);
  }
}

void main() async {
  HttpOverrides.global = _HttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  PlatformInAppWebViewController.debugLoggingSettings.excludeFilter.add(
    RegExp(r"onConsoleMessage"),
  );

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }

  await InAppWebViewController.setJavaScriptBridgeName('gagaku');

  timeagoLocalesMap.forEach((locale, lookupMessages) {
    timeago.setLocaleMessages(locale, lookupMessages);
  });

  await Hive.initFlutter();
  Hive.registerAdapter(CacheEntryAdapter());
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
      excludeBox: {Level.trace: true, Level.debug: true, Level.info: true},
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

  await cleanupCachedUpdateFiles();

  final gdat = GagakuData();
  await gdat.initData();
  await gdat.initGagakuBoxes();
  AppMaintenanceService().start();

  final providerContainer = ProviderContainer();
  await GagakuSyncService().start(providerContainer);
  // ignore: riverpod_lint/missing_provider_scope
  runApp(
    _GagakuRoot(
      providerContainer: providerContainer,
      initialLocation: StartupSection.load().location,
    ),
  );
}

final class _GagakuRoot extends StatefulWidget {
  const _GagakuRoot({
    required this.providerContainer,
    required this.initialLocation,
  });

  final ProviderContainer providerContainer;
  final String initialLocation;

  @override
  State<_GagakuRoot> createState() => _GagakuRootState();
}

final class _GagakuRootState extends State<_GagakuRoot> {
  @override
  Widget build(BuildContext context) => UncontrolledProviderScope(
    container: widget.providerContainer,
    child: TranslationProvider(
      child: App(initialLocation: widget.initialLocation),
    ),
  );

  @override
  void dispose() {
    unawaited(GagakuSyncService().stop());
    widget.providerContainer.dispose();
    super.dispose();
  }
}

class App extends HookConsumerWidget {
  App({required this.initialLocation, super.key});

  final String initialLocation;

  static const _routingErrorLocation = '/routing-error';

  final _exceptionRecovery = _RoutingExceptionRecovery();

  late final _router = GoRouter(
    routes: [
      GoRoute(
        path: GagakuRoute.shareWebManga,
        redirect: (BuildContext context, GoRouterState state) {
          final share = GagakuRoute.parseWebMangaShareUri(state.uri);
          if (share == null) return '/';

          return WebMangaViewRoute(
            sourceId: share.sourceId,
            mangaId: share.mangaId,
          ).location;
        },
      ),
      ...$appRoutes,
      GoRoute(
        path: _routingErrorLocation,
        builder: (BuildContext context, GoRouterState state) {
          return ErrorRoute(
            error: state.extra! as Exception,
          ).build(context, state);
        },
      ),
    ],
    initialLocation: initialLocation,
    navigatorKey: rootNavigatorKey,
    onException: (BuildContext context, GoRouterState state, GoRouter router) {
      if (PBLinkDelegate().recoverInitialNavigation(state, router)) return;

      _exceptionRecovery.recover(state, router);
    },
    onEnter:
        (
          BuildContext context,
          GoRouterState current,
          GoRouterState next,
          GoRouter router,
        ) async {
          final scheme = next.uri.scheme;

          switch (scheme) {
            case PBLinkDelegate.scheme:
              return await PBLinkDelegate().process(context, next, router);
            default:
              return _exceptionRecovery.resumePendingAfter(
                    next,
                    router,
                    _routingErrorLocation,
                  ) ??
                  PBLinkDelegate().resumePendingAfter(context, next);
          }
        },
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(gagakuSettingsProvider);
    final updateResult = ref.watch(updateCheckerProvider);

    Future<void> recordUpdateCheck() async {
      await ref
          .read(updateMetadataStoreProvider)
          .recordUpdateCheck(ref.read(updateCheckerNowProvider)());
    }

    // Surface updates without blocking startup.
    useEffect(() {
      switch (updateResult) {
        case AsyncData(value: UpdateResultAvailable(:final info)):
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final navContext = rootNavigatorKey.currentContext;
            if (navContext != null && navContext.mounted) {
              showUpdateSnackBar(
                navContext,
                info,
                onDismissed: recordUpdateCheck,
                onNotNow: recordUpdateCheck,
                onDownload: recordUpdateCheck,
              );
            }
          });
        case AsyncData(value: final result)
            when shouldRecordUpdateCheck(result):
          Future.delayed(Duration.zero, recordUpdateCheck);
        default:
          break;
      }
      return null;
    }, [updateResult]);

    return MaterialApp.router(
      title: 'Gagaku',
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: AppLocaleUtils.supportedLocales,
      locale: TranslationProvider.of(context).flutterLocale,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: config.theme.color,
          brightness: Brightness.light,
        ),
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
          dynamicSchemeVariant: DynamicSchemeVariant.content,
        ),
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

final class _RoutingExceptionRecovery {
  Exception? _pendingError;

  void recover(GoRouterState state, GoRouter router) {
    _pendingError = state.error!;
    router.go('/');
  }

  OnEnterResult? resumePendingAfter(
    GoRouterState state,
    GoRouter router,
    String errorLocation,
  ) {
    if (state.uri.path != '/' || _pendingError == null) return null;

    return Allow(
      then: () {
        final error = _pendingError;
        _pendingError = null;

        if (error != null) {
          router.go(errorLocation, extra: error);
        }
      },
    );
  }
}

class ErrorRoute extends GoRouteData {
  ErrorRoute({required this.error});
  final Exception error;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NotFoundScreen(error: error);
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, required this.error});

  final Exception error;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.errors.pageNotFound),
        leading: const BackButton(),
      ),
      body: Center(
        child: Text(t.errors.pageNotFoundArg(url: error.toString())),
      ),
    );
  }
}
