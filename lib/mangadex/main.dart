import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MangaDexHomePage extends HookConsumerWidget {
  const MangaDexHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useOnAppLifecycleStateChange((_, current) {
      if (current == AppLifecycleState.resumed &&
          ref.exists(authControlProvider)) {
        ref.read(authControlProvider.notifier).invalidate();
      }
    });

    return AutoTabsScaffold(
      routes: [
        MangaDexFrontRoute(),
        MangaDexChapterFeedRoute(),
        MangaDexLibraryRoute(),
        MangaDexListsRoute(),
        MangaDexHistoryFeedRoute(),
      ],
      restorationId: 'md_home_restore',
      drawer: const MainDrawer(),
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBar(
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
          onDestinationSelected: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
