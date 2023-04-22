import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/mangadex/chapter_feed.dart';
import 'package:gagaku/mangadex/login_old.dart';
import 'package:gagaku/mangadex/manga_feed.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexHome extends ConsumerWidget {
  const MangaDexHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final tab = ref.watch(mangadexTabProvider);

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

    const tabs = <Widget>[
      MangaDexMangaFeed(),
      MangaDexChapterFeed(),
      Center(
        child: Text("Library Feed"),
      )
    ];

    return MangaDexLoginWidget(
      builder: (context, ref) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Mangadex"),
            actions: [
              ButtonBar(
                children: [
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
                return FadeThroughTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
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
              ref.read(mangadexTabProvider.notifier).state =
                  MangaDexTab.values[index];
            },
          ),
        );
      },
    );
  }
}
