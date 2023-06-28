import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/local/main.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/main.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/util.dart';
import 'package:gagaku/web/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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
    Logger.level = Level.info;
  }

  logger = Logger(
    filter: kReleaseMode ? ProductionFilter() : null,
    printer: PrettyPrinter(
      colors: false,
      printTime: true,
      excludeBox: {
        Level.verbose: true,
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

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const GagakuHome(),
    );
  }
}

class GagakuHome extends ConsumerWidget {
  const GagakuHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(homepageProvider);

    final pages = <Widget>[
      const MangaDexHome(),
      const LocalLibraryHome(),
      const WebSourcesHome(),
    ];

    return pages[page.index];
  }
}
