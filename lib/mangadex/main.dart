import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/mangadex/chapter_feed.dart';
import 'package:gagaku/mangadex/library.dart';
import 'package:gagaku/mangadex/login_old.dart';
import 'package:gagaku/mangadex/manga_feed.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/search.dart';
import 'package:gagaku/mangadex/settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum MangaDexTab {
  mangaFeed,
  chapterFeed,
  libraryView,
}

final _mangadexTabProvider = StateProvider((ref) => MangaDexTab.mangaFeed);

class MangaDexHome extends HookConsumerWidget {
  const MangaDexHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final tab = ref.watch(_mangadexTabProvider);

    const bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Manga Feed',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.feed),
        label: 'Chapter Feed',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.collections),
        label: 'Library',
      )
    ];

    final controllers = [
      useScrollController(),
      useScrollController(),
      useScrollController(),
    ];

    final tabs = <Widget>[
      MangaDexMangaFeed(
        controller: controllers[0],
      ),
      MangaDexChapterFeed(
        controller: controllers[1],
      ),
      MangaDexLibraryView(
        controller: controllers[2],
      ),
    ];

    return MangaDexLoginWidget(
      builder: (context, ref) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Mangadex"),
            flexibleSpace: GestureDetector(
              onTap: () {
                // Tap app bar to scroll to top
                controllers[tab.index].animateTo(0.0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut);
              },
            ),
            actions: [
              ButtonBar(
                children: [
                  Tooltip(
                    message: 'Search Manga',
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        Navigator.push(context, createMangaDexSearchRoute());
                      },
                    ),
                  ),
                  Tooltip(
                    message: 'MangaDex Settings',
                    child: IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Navigator.push(context, createMangaDexSettingsRoute());
                      },
                    ),
                  ),
                  Tooltip(
                    message: 'Logout',
                    child: IconButton(
                      color: theme.colorScheme.primary,
                      icon: const Icon(Icons.logout),
                      onPressed: () =>
                          ref.read(authControlProvider.notifier).logout(),
                    ),
                  ),
                ],
              )
            ],
          ),
          drawer: const MainDrawer(),
          body: Center(
            child: PageTransitionSwitcher(
              transitionBuilder: (child, animation, secondaryAnimation) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: tabs[tab.index],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: false,
            items: bottomNavigationBarItems,
            currentIndex: tab.index,
            type: BottomNavigationBarType.fixed,
            fixedColor: Theme.of(context).colorScheme.primary,
            onTap: (index) {
              final currTab = ref.read(_mangadexTabProvider);

              if (currTab == MangaDexTab.values[index]) {
                // Scroll to top if on the same tab
                controllers[index].animateTo(0.0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut);
              } else {
                // Switch tab
                ref.read(_mangadexTabProvider.notifier).state =
                    MangaDexTab.values[index];
              }
            },
          ),
        );
      },
    );
  }
}
