import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/chapter_feed.dart';
import 'package:gagaku/src/mangadex/login.dart';
import 'package:gagaku/src/mangadex/manga_feed.dart';
import 'package:gagaku/src/mangadex/search.dart';
import 'package:gagaku/src/mangadex/settings.dart';
import 'package:provider/provider.dart';

class MangaDexHomePage extends StatefulWidget {
  MangaDexHomePage({Key? key, required this.topScaffold}) : super(key: key);

  final GlobalKey<ScaffoldState> topScaffold;

  @override
  _MangaDexHomePageState createState() => _MangaDexHomePageState();
}

class _MangaDexHomePageState extends State<MangaDexHomePage>
    with RestorationMixin {
  final RestorableInt _currentIndex = RestorableInt(0);

  @override
  String get restorationId => 'md_homepage';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_currentIndex, 'md_bottom_navigation_tab_index');
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Provider.of<MangaDexModel>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return MangaDexLoginWidget(
        topScaffold: widget.topScaffold,
        builder: (context) {
          var bottomNavigationBarItems = <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Manga Feed',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.feed),
              label: 'Chapter Feed',
            )
          ];

          final selectedItem = <Widget>[
            MangaDexMangaFeed(),
            MangaDexChapterFeed()
          ];

          // TODO library view

          return Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      widget.topScaffold.currentState!.openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              title: Text('MangaDex'),
              actions: [
                ButtonBar(
                  children: [
                    Tooltip(
                      message: 'Search Manga',
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Navigator.push(context, createMangaDexSearchRoute());
                        },
                      ),
                    ),
                    Tooltip(
                      message: 'MangaDex Settings',
                      child: IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          Navigator.push(
                              context,
                              createMangaDexSettingsRoute(
                                  Provider.of<MangaDexModel>(context,
                                          listen: false)
                                      .settings));
                        },
                      ),
                    ),
                    Tooltip(
                      message: 'Logout',
                      child: IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        icon: Icon(Icons.logout),
                        onPressed: () async {
                          final result = await Provider.of<MangaDexModel>(
                                  context,
                                  listen: false)
                              .logout();

                          if (!result) {
                            // Shouldn't ever fail to logout
                            throw Exception('Failed to logout');
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            body: Center(
              child: PageTransitionSwitcher(
                transitionBuilder: (child, animation, secondaryAnimation) {
                  return FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  );
                },
                child: selectedItem[_currentIndex.value],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: false,
              items: bottomNavigationBarItems,
              currentIndex: _currentIndex.value,
              type: BottomNavigationBarType.fixed,
              fixedColor: Theme.of(context).colorScheme.primary,
              onTap: (index) {
                setState(() {
                  _currentIndex.value = index;
                });
              },
            ),
          );
        });
  }
}
