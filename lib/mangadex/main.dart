import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexHome extends HookConsumerWidget {
  const MangaDexHome({this.controllers, required this.child, super.key});

  final List<ScrollController>? controllers;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lifecycle = useAppLifecycleState();

    useEffect(() {
      if (lifecycle == AppLifecycleState.resumed && ref.exists(authControlProvider)) {
        ref.read(authControlProvider.notifier).invalidate();
      }
      return null;
    }, [lifecycle]);

    final index = _calculateSelectedIndex(context);

    return Scaffold(
      restorationId: 'md_home_restore',
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
            label: 'Home',
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
            controllers?[index].animateTo(0.0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
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
    final location = cleanBaseDomains(GoRouterState.of(context).uri.toString());

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
