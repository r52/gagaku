import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/search.dart';
import 'package:gagaku/mangadex/settings.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexHome extends HookConsumerWidget {
  const MangaDexHome({this.controllers, required this.child, super.key});

  final List<ScrollController>? controllers;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
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
        label: 'History',
      )
    ];

    final index = _calculateSelectedIndex(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            controllers?[index].animateTo(0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          },
          child: Styles.titleFlexBar(context: context, title: 'MangaDex'),
        ),
        actions: [
          ButtonBar(
            children: [
              Tooltip(
                message: 'Search Manga',
                child: OpenContainer(
                  closedColor: theme.cardColor,
                  closedShape: const CircleBorder(),
                  closedBuilder: (context, openContainer) {
                    return IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        openContainer();
                      },
                    );
                  },
                  openBuilder: (context, closedContainer) {
                    return const MangaDexSearchWidget();
                  },
                ),
              ),
              Tooltip(
                message: 'MangaDex Settings',
                child: OpenContainer<bool>(
                  closedColor: theme.cardColor,
                  closedShape: const CircleBorder(),
                  closedBuilder: (context, openContainer) {
                    return IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        openContainer();
                      },
                    );
                  },
                  openBuilder: (context, closedContainer) {
                    return const MangaDexSettingsWidget();
                  },
                ),
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
                            context.push(GagakuRoute.login);
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
        child: child,
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: bottomNavigationBarItems,
        selectedIndex: index,
        onDestinationSelected: (index) {
          final currTab = _calculateSelectedIndex(context);

          if (currTab == index) {
            // Scroll to top if on the same tab
            controllers?[index].animateTo(0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          } else {
            // Switch tab
            _onItemTapped(index, context);
          }
        },
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/');
        break;
      case 1:
        GoRouter.of(context).go(GagakuRoute.mangafeed);
        break;
      case 2:
        GoRouter.of(context).go(GagakuRoute.chapterfeed);
        break;
      case 3:
        GoRouter.of(context).go(GagakuRoute.library);
        break;
      case 4:
        GoRouter.of(context).go(GagakuRoute.history);
        break;
    }
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    switch (location) {
      case GagakuRoute.mangafeed:
        return 1;
      case GagakuRoute.chapterfeed:
        return 2;
      case GagakuRoute.library:
        return 3;
      case GagakuRoute.history:
        return 4;
      default:
        return 0;
    }
  }
}
