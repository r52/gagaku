import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexHomePage extends HookConsumerWidget {
  const MangaDexHomePage({super.key, required this.child});

  final Widget child;

  static int _calculateSelectedIndex(BuildContext context) {
    final route = GoRouterState.of(context).uri;
    final path = route.path;

    switch (path) {
      case GagakuRoute.chapterfeed:
        return 1;
      case GagakuRoute.library:
        return 2;
      case GagakuRoute.lists:
        return 3;
      case GagakuRoute.history:
        return 4;
      case '/':
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = _calculateSelectedIndex(context);
    final t = context.t;
    final controllers = List.generate(5, (_) => useScrollController());
    final controllerSet = useMemoized(
      () => {
        'MangaDexFrontPage': controllers[0],
        'MangaDexChapterFeedPage': controllers[1],
        'MangaDexLibraryPage': controllers[2],
        'MangaDexListsPage': controllers[3],
        'MangaDexHistoryFeedPage': controllers[4],
      },
      [controllers],
    );

    return Scaffold(
      restorationId: 'md_home_restore',
      drawer: const MainDrawer(),
      body: DefaultScrollController(controllers: controllerSet, child: child),
      bottomNavigationBar: NavigationBar(
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: t.mangadex.home),
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: t.mangadex.myFeed,
          ),
          NavigationDestination(
            icon: Icon(Icons.collections),
            label: t.library,
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: t.mangadex.myLists,
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: t.history.text,
          ),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (idx) {
          if (idx == selectedIndex) {
            controllers[selectedIndex].animateTo(
              0.0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCirc,
            );
          } else {
            switch (idx) {
              case 0:
                const MangaDexFrontRoute().go(context);
                break;
              case 1:
                const MangaDexChapterFeedRoute().go(context);
                break;
              case 2:
                const MangaDexLibraryRoute().go(context);
                break;
              case 3:
                const MangaDexListsRoute().go(context);
                break;
              case 4:
                const MangaDexHistoryFeedRoute().go(context);
                break;
              default:
                const MangaDexFrontRoute().go(context);
                break;
            }
          }
        },
      ),
    );
  }
}
