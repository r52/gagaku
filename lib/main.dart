import 'package:flutter/material.dart';
import 'package:gagaku/src/local/api.dart';
import 'package:gagaku/src/local/index.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/index.dart';
import 'package:gagaku/src/util.dart';
import 'package:gagaku/src/web/index.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  if (DeviceContext.isDesktop()) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MangaDexModel()),
      ChangeNotifierProvider(create: (context) => LocalDatabaseModel()),
    ],
    child: MaterialApp(
      title: 'Gagaku',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent)),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent)),
      themeMode: ThemeMode
          .dark, // ThemeMode.system doesn't work on Windows https://github.com/flutter/flutter/issues/54612
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'gagaku_root',
      home: GagakuApp(),
    ),
  ));
}

class GagakuApp extends StatefulWidget {
  const GagakuApp({Key? key}) : super(key: key);

  @override
  _GagakuAppState createState() => _GagakuAppState();
}

class _GagakuAppState extends State<GagakuApp> with RestorationMixin {
  final RestorableInt _selectedIndex = RestorableInt(0);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  String get restorationId => 'gagaku_app';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedIndex, 'tab_index');
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = <Widget>[
      MangaDexHomePage(
        topScaffold: _scaffoldKey,
      ),
      LocalLibraryHomePage(
        topScaffold: _scaffoldKey,
      ),
      WebGalleryHomePage(
        topScaffold: _scaffoldKey,
      ),
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: NavigationRail(
          leading: Column(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/icon.png'),
              ),
              Text('Gagaku')
            ],
          ),
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex.value = index;
            });
          },
          selectedIndex: _selectedIndex.value,
          labelType: NavigationRailLabelType.all,
          destinations: [
            NavigationRailDestination(
              icon: const Icon(Icons.menu_book_outlined),
              selectedIcon: const Icon(Icons.menu_book),
              label: Text('MangaDex'),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.photo_album_outlined),
              selectedIcon: const Icon(Icons.photo_album),
              label: Text('Local Library'),
            ),
            NavigationRailDestination(
              icon: const Icon(
                Icons.language_outlined,
              ),
              selectedIcon: const Icon(Icons.language),
              label: Text('Web Gallery'),
            ),
          ],
        ),
      ),
      body: selectedItem[_selectedIndex.value],
    );
  }
}
