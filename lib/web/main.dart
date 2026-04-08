import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebSourceHomePage extends HookConsumerWidget {
  const WebSourceHomePage({super.key, required this.child});

  final Widget child;

  static int _calculateSelectedIndex(BuildContext context) {
    final route = GoRouterState.of(context).uri;
    final path = route.path;

    switch (path) {
      case GagakuRoute.extension:
        return 0;
      case GagakuRoute.extensionUpdates:
        return 1;
      case GagakuRoute.extensionSaved:
        return 2;
      case GagakuRoute.extensionHistory:
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectedIndex = _calculateSelectedIndex(context);
    final tr = context.t;
    final controllers = useRef<Map<int, ScrollController>>({});
    final activeController = controllers.value.putIfAbsent(
      selectedIndex,
      () => ScrollController(),
    );

    useEffect(() {
      return () {
        for (final c in controllers.value.values) {
          c.dispose();
        }
      };
    }, []);

    return Scaffold(
      restorationId: 'extension_home_restore',
      drawer: const MainDrawer(),
      body: Center(
        child: DefaultScrollController(
          controller: activeController,
          child: child,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: tr.webSources.home,
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: tr.chapterFeed.latestUpdates,
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: tr.webSources.favorites,
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: tr.history.text,
          ),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (idx) {
          if (idx == selectedIndex) {
            activeController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCirc,
            );
          } else {
            switch (idx) {
              case 0:
                const WebSourceFrontRoute().go(context);
                break;
              case 1:
                const WebSourceUpdatesRoute().go(context);
                break;
              case 2:
                const WebSourceFavoritesRoute().go(context);
                break;
              case 3:
                const WebSourceHistoryRoute().go(context);
                break;
              default:
                const WebSourceFrontRoute().go(context);
            }
          }
        },
      ),
    );
  }
}
