import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gagaku/local/main.dart';
import 'package:gagaku/mangadex/main.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/web/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _HttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 5;
  }
}

void main() async {
  HttpOverrides.global = _HttpOverrides();

  await Hive.initFlutter();
  await Hive.openBox(gagakuBox);
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
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
      const WebGalleryHome(),
    ];

    return pages[page.index];
  }
}
