import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/mangadex/chapter_feed.dart';
import 'package:gagaku/mangadex/history_feed.dart';
import 'package:gagaku/mangadex/latest_feed.dart';
import 'package:gagaku/mangadex/library.dart';
import 'package:gagaku/mangadex/login_old.dart';
import 'package:gagaku/mangadex/manga_feed.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/search.dart';
import 'package:gagaku/mangadex/settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum MangaDexTab {
  latestFeed,
  mangaFeed,
  chapterFeed,
  libraryView,
  history,
}

final _mangadexTabProvider = StateProvider((ref) => MangaDexTab.latestFeed);

class MangaDexHome extends HookConsumerWidget {
  const MangaDexHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final tab = ref.watch(_mangadexTabProvider);

    const bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Latest Feed',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.menu_book),
        label: 'Manga Feed',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.feed),
        label: 'Chapter Feed',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.collections),
        label: 'Library',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: 'Reading History',
      )
    ];

    final controllers = [
      useScrollController(),
      useScrollController(),
      useScrollController(),
      useScrollController(),
      useScrollController(),
    ];

    final tabs = <Widget>[
      MangaDexGlobalFeed(
        controller: controllers[0],
      ),
      MangaDexLoginWidget(
        builder: (context, ref) {
          return MangaDexMangaFeed(
            controller: controllers[1],
          );
        },
      ),
      MangaDexLoginWidget(
        builder: (context, ref) {
          return MangaDexChapterFeed(
            controller: controllers[2],
          );
        },
      ),
      MangaDexLoginWidget(
        builder: (context, ref) {
          return MangaDexLibraryView(
            controller: controllers[3],
          );
        },
      ),
      MangaDexHistoryFeed(
        controller: controllers[4],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            // Tap app bar to scroll to top
            controllers[tab.index].animateTo(0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          },
          child: const Text("Mangadex"),
        ),
        // Need to double up here to detect the entire width of
        // the bar
        flexibleSpace: GestureDetector(
          onTap: () {
            controllers[tab.index].animateTo(0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          },
        ),
        actions: [
          ButtonBar(
            children: [
              OpenContainer(
                closedColor: theme.cardColor,
                closedShape: const CircleBorder(),
                closedBuilder: (context, openContainer) {
                  return Tooltip(
                    message: 'Search Manga',
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        openContainer();
                      },
                    ),
                  );
                },
                openBuilder: (context, closedContainer) {
                  return const MangaDexSearchWidget();
                },
              ),
              OpenContainer<bool>(
                closedColor: theme.cardColor,
                closedShape: const CircleBorder(),
                closedBuilder: (context, openContainer) {
                  return Tooltip(
                    message: 'MangaDex Settings',
                    child: IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        openContainer();
                      },
                    ),
                  );
                },
                openBuilder: (context, closedContainer) {
                  return const MangaDexSettingsWidget();
                },
              ),
              Consumer(
                builder: (context, ref, child) {
                  final auth = ref.watch(authControlProvider);

                  return auth.when(
                    data: (loggedIn) {
                      if (loggedIn) {
                        return Tooltip(
                          message: 'Logout',
                          child: IconButton(
                            color: theme.colorScheme.primary,
                            icon: const Icon(Icons.logout),
                            onPressed: () =>
                                ref.read(authControlProvider.notifier).logout(),
                          ),
                        );
                      }

                      // XXX: This changes when OAuth is released
                      return Tooltip(
                        message: 'Login',
                        child: IconButton(
                          color: theme.colorScheme.primary,
                          icon: const Icon(Icons.login),
                          onPressed: () {
                            final nav = Navigator.of(context);
                            nav.push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MangaDexLoginScreen(),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (err, stack) => const Icon(Icons.error),
                  );
                },
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
  }
}
