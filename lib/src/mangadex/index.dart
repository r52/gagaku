import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/chapter_feed.dart';
import 'package:gagaku/src/mangadex/login.dart';
import 'package:gagaku/src/mangadex/manga_feed.dart';
import 'package:provider/provider.dart';

class MangaDexHomePage extends StatefulWidget {
  MangaDexHomePage({Key? key, required this.restorationId}) : super(key: key);

  final String restorationId;

  @override
  _MangaDexHomePageState createState() => _MangaDexHomePageState();
}

class _MangaDexHomePageState extends State<MangaDexHomePage>
    with RestorationMixin {
  final RestorableInt _currentIndex = RestorableInt(0);

  @override
  String get restorationId => widget.restorationId;

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
    return MangaDexLoginWidget(builder: (context) {
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

      final selectedItem = <Widget>[MangaDexMangaFeed(), MangaDexChapterFeed()];

      return Scaffold(
        appBar: AppBar(
          title: Text('MangaDex'),
          actions: [
            ButtonBar(
              children: [
                Tooltip(
                    message: 'Logout',
                    child: Consumer<MangaDexModel>(
                      builder: (context, mdx, child) {
                        return IconButton(
                          color: Theme.of(context).colorScheme.primary,
                          icon: Icon(Icons.logout),
                          onPressed: () async {
                            final result = await mdx.logout();

                            if (!result) {
                              // Shouldn't ever fail to logout
                              throw Exception('Failed to logout');
                            }
                          },
                        );
                      },
                    ))
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
