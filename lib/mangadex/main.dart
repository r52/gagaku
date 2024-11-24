import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexHome extends HookConsumerWidget {
  const MangaDexHome({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllers = List.generate(5, (idx) => useScrollController());
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
        child: DefaultScrollController(
          controller: controllers[index],
          child: child,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'mangadex.home'.tr(context: context),
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: 'mangadex.myFeed'.tr(context: context),
          ),
          NavigationDestination(
            icon: Icon(Icons.collections),
            label: 'library.text'.tr(context: context),
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'mangadex.myLists'.tr(context: context),
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'history.text'.tr(context: context),
          )
        ],
        selectedIndex: index,
        onDestinationSelected: (index) {
          final currTab = _calculateSelectedIndex(context);

          if (currTab == index) {
            // Scroll to top if on the same tab
            controllers[index].animateTo(0.0, duration: const Duration(milliseconds: 1000), curve: Curves.easeOutCirc);
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
