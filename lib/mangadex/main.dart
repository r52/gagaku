import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MangaDexHomePage extends HookConsumerWidget {
  const MangaDexHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    useOnAppLifecycleStateChange((_, current) {
      if (current == AppLifecycleState.resumed &&
          ref.exists(authControlProvider)) {
        ref.read(authControlProvider.notifier).invalidate();
      }
    });

    return AutoTabsRouter(
      routes: [
        MangaDexFrontRoute(),
        MangaDexChapterFeedRoute(),
        MangaDexLibraryRoute(),
        MangaDexListsRoute(),
        MangaDexHistoryFeedRoute(),
      ],
      transitionBuilder:
          (context, child, animation) =>
              FadeTransition(opacity: animation, child: child),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          restorationId: 'md_home_restore',
          drawer: const MainDrawer(),
          body: DefaultScrollController(
            controllers: controllerSet,
            child: child,
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
              ),
            ],
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: (idx) {
              if (idx == tabsRouter.activeIndex) {
                controllers[tabsRouter.activeIndex].animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOutCirc,
                );
              } else {
                tabsRouter.setActiveIndex(idx);
              }
            },
          ),
        );
      },
    );
  }
}
