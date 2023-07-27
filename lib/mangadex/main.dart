import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/chapter_feed.dart';
import 'package:gagaku/mangadex/history_feed.dart';
import 'package:gagaku/mangadex/latest_feed.dart';
import 'package:gagaku/mangadex/library.dart';
import 'package:gagaku/mangadex/login_old.dart';
import 'package:gagaku/mangadex/manga_feed.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/search.dart';
import 'package:gagaku/mangadex/settings.dart';
import 'package:gagaku/ui.dart';
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
    final nav = Navigator.of(context);
    final theme = Theme.of(context);
    final tab = ref.watch(_mangadexTabProvider);
    final lifecycle = useAppLifecycleState();

    useEffect(() {
      if (lifecycle == AppLifecycleState.resumed) {
        ref.read(authControlProvider.notifier).invalidate();
      }
      return null;
    }, [lifecycle]);

    const bottomNavigationBarItems = <Widget>[
      NavigationDestination(
        icon: Icon(Icons.home),
        label: 'Latest Feed',
      ),
      NavigationDestination(
        icon: Icon(Icons.menu_book),
        label: 'Manga Feed',
      ),
      NavigationDestination(
        icon: Icon(Icons.feed),
        label: 'Chapter Feed',
      ),
      NavigationDestination(
        icon: Icon(Icons.collections),
        label: 'Library',
      ),
      NavigationDestination(
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
        key: const Key('mangafeed'),
        builder: (context, ref) {
          return MangaDexMangaFeed(
            controller: controllers[1],
          );
        },
      ),
      MangaDexLoginWidget(
        key: const Key('chapterfeed'),
        builder: (context, ref) {
          return MangaDexChapterFeed(
            controller: controllers[2],
          );
        },
      ),
      MangaDexLoginWidget(
        key: const Key('userlibrary'),
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
        flexibleSpace: GestureDetector(
          onTap: () {
            controllers[tab.index].animateTo(0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          },
          child: Styles.titleFlexBar(context: context, title: 'MangaDex'),
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

                  switch (auth) {
                    case AsyncData(value: final loggedin):
                      // XXX: This changes when OAuth is released
                      Widget logbtn = Tooltip(
                        message: 'Login',
                        child: IconButton(
                          color: theme.colorScheme.primary,
                          icon: const Icon(Icons.login),
                          onPressed: () {
                            nav.push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MangaDexLoginScreen(),
                              ),
                            );
                          },
                        ),
                      );

                      if (loggedin) {
                        logbtn = Tooltip(
                          message: 'Logout',
                          child: IconButton(
                            color: theme.colorScheme.primary,
                            icon: const Icon(Icons.logout),
                            onPressed: () =>
                                ref.read(authControlProvider.notifier).logout(),
                          ),
                        );
                      }

                      return Ink(
                        decoration: ShapeDecoration(
                          color: theme.cardColor,
                          shape: const CircleBorder(),
                        ),
                        child: logbtn,
                      );
                    case AsyncError(:final error, :final stackTrace):
                      final messenger = ScaffoldMessenger.of(context);
                      Styles.showErrorSnackBar(messenger, '$error');
                      logger.e("authControlProvider failed",
                          error: error, stackTrace: stackTrace);
                      return const Icon(Icons.error);
                    case _:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
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
      bottomNavigationBar: NavigationBar(
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: bottomNavigationBarItems,
        selectedIndex: tab.index,
        onDestinationSelected: (index) {
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
