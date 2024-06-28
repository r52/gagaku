import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
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
      if (lifecycle == AppLifecycleState.resumed &&
          ref.exists(authControlProvider)) {
        ref.read(authControlProvider.notifier).invalidate();
      }
      return null;
    }, [lifecycle]);

    final index = _calculateSelectedIndex(context);

    return Scaffold(
      restorationId: 'md_home_restore',
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            controllers?[index].animateTo(0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          },
          child: const TitleFlexBar(title: 'MangaDex'),
        ),
        actions: [
          OverflowBar(
            spacing: 8.0,
            children: [
              Tooltip(
                message: 'Search Manga',
                child: OpenContainer(
                  closedColor: theme.colorScheme.surface,
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
                  closedColor: theme.colorScheme.surface,
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
                    case AsyncValue(value: final loggedin?):
                      // XXX: This changes when OAuth is released
                      return Ink(
                        decoration: ShapeDecoration(
                          color: theme.colorScheme.surface,
                          shape: const CircleBorder(),
                        ),
                        child: Tooltip(
                          message: loggedin ? 'Logout' : 'Login',
                          child: IconButton(
                            color: theme.colorScheme.primary,
                            icon: loggedin
                                ? const Icon(Icons.logout)
                                : const Icon(Icons.login),
                            onPressed: loggedin
                                ? () => ref
                                    .read(authControlProvider.notifier)
                                    .logout()
                                : () => context.push(GagakuRoute.login),
                          ),
                        ),
                      );
                    // ignore: unused_local_variable
                    case AsyncValue(:final error?, :final stackTrace?):
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
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Latest',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: 'My Feed',
          ),
          NavigationDestination(
            icon: Icon(Icons.collections),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'My Lists',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'History',
          )
        ],
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
        GoRouter.of(context).go(GagakuRoute.chapterfeed);
        break;
      case 2:
        GoRouter.of(context).go(GagakuRoute.library);
        break;
      case 3:
        GoRouter.of(context).go(GagakuRoute.lists);
        break;
      case 4:
        GoRouter.of(context).go(GagakuRoute.history);
        break;
    }
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    switch (location) {
      case GagakuRoute.chapterfeed:
        return 1;
      case GagakuRoute.library:
        return 2;
      case GagakuRoute.lists:
        return 3;
      case GagakuRoute.history:
        return 4;
      default:
        return 0;
    }
  }
}
