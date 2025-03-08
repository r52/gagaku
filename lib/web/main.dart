import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/settings.dart';
import 'package:gagaku/web/source_manager.dart';
import 'package:gagaku/web/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class WebSourceHomePage extends HookConsumerWidget {
  const WebSourceHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllers = List.generate(3, (idx) => useScrollController());
    final controllerSet = useMemoized(
      () => {
        'WebSourceFrontPage': controllers[0],
        'WebSourceFavoritesPage': controllers[1],
        'WebSourceHistoryPage': controllers[2],
      },
      [controllers],
    );

    final theme = Theme.of(context);
    final nav = Navigator.of(context);
    final api = ref.watch(proxyProvider);

    return AutoTabsRouter(
      routes: [
        WebSourceFrontRoute(),
        WebSourceFavoritesRoute(),
        WebSourceHistoryRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          restorationId: 'extension_home_restore',
          appBar: AppBar(
            flexibleSpace: GestureDetector(
              onTap: () {
                controllers[tabsRouter.activeIndex].animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOutCirc,
                );
              },
              child: TitleFlexBar(
                title: 'webSources.text'.tr(context: context),
              ),
            ),
            actions: [
              OverflowBar(
                spacing: 0.0,
                children: [
                  IconButton(
                    color: theme.colorScheme.onPrimaryContainer,
                    onPressed: () => openLinkDialog(context, api),
                    icon: const Icon(Icons.open_in_browser),
                    tooltip: 'mangaActions.openLink'.tr(context: context),
                  ),
                  MenuAnchor(
                    builder:
                        (context, controller, child) => IconButton(
                          color: theme.colorScheme.onPrimaryContainer,
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          icon: const Icon(Icons.more_vert),
                        ),
                    menuChildren: [
                      MenuItemButton(
                        onPressed: () async {
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'webSources.resetAllRead'.tr(
                                    context: context,
                                  ),
                                ),
                                content: const Text(
                                  'Are you sure you want to reset all read markers?',
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('ui.no'.tr(context: context)),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text('ui.yes'.tr(context: context)),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                          if (result == true) {
                            ref.read(webReadMarkersProvider.clear)();
                          }
                        },
                        leadingIcon: const Icon(Icons.restore),
                        child: Text(
                          'webSources.resetAllRead'.tr(context: context),
                        ),
                      ),
                      MenuItemButton(
                        onPressed:
                            () => nav.push(
                              SlideTransitionRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const SourceManager(),
                              ),
                            ),
                        leadingIcon: const Icon(Icons.collections_bookmark),
                        child: Text(
                          'webSources.source.manager'.tr(context: context),
                        ),
                      ),
                      MenuItemButton(
                        onPressed:
                            () => nav.push(WebSourceSettingsRouteBuilder()),
                        leadingIcon: const Icon(Icons.settings),
                        child: Text(
                          'arg_settings'.tr(
                            context: context,
                            args: ['webSources.text'.tr(context: context)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          drawer: const MainDrawer(),
          body: Center(
            child: DefaultScrollController(
              controllers: controllerSet,
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
                label: 'webSources.home'.tr(context: context),
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: 'webSources.favorites'.tr(context: context),
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
