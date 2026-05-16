import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/model/types.dart';
import 'package:gagaku/routes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/update_checker.dart';
import 'package:gagaku/util/riverpod.dart';
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

  final gdat = GagakuData();
  await gdat.initData();
  await gdat.initGagakuBoxes();

  runApp(ProviderScope(child: TranslationProvider(child: App())));
}

class App extends HookConsumerWidget {
  App({super.key});

  final _router = GoRouter(
    routes: $appRoutes,
    initialLocation: '/',
    navigatorKey: rootNavigatorKey,
    errorBuilder: (BuildContext context, GoRouterState state) {
      return ErrorRoute(error: state.error!).build(context, state);
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
              return const Allow();
          }
        },
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(gagakuSettingsProvider);
    final updateResult = ref.watch(updateCheckerProvider);

    // Trigger dialog when an update is available.
    useEffect(() {
      switch (updateResult) {
        case AsyncData(value: UpdateResultAvailable(:final info)):
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final navContext = rootNavigatorKey.currentContext;
            if (navContext != null && navContext.mounted) {
              showUpdateDialog(navContext, info);
            }
          });
        case AsyncData(value: UpdateResultUpToDate()) ||
            AsyncData(value: UpdateResultIgnored()):
          Future.delayed(Duration.zero, () async {
            final updatedConfig = config.copyWith(
              lastUpdateCheck: DateTime.now(),
            );
            ref.run((tsx) async {
              return tsx
                  .get(gagakuSettingsProvider.notifier)
                  .save(updatedConfig);
            });
          });
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
