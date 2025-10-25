import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/common.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/settings.dart';
import 'package:gagaku/web/source_manager.dart';
import 'package:gagaku/web/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([chipTextStyle])
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
    final controllers = List.generate(4, (idx) => useScrollController());
    final controllerSet = useMemoized(
      () => {
        'WebSourceFrontPage': controllers[0],
        'WebSourceUpdatesPage': controllers[1],
        'WebSourceFavoritesPage': controllers[2],
        'WebSourceHistoryPage': controllers[3],
      },
      [controllers],
    );

    final theme = Theme.of(context);
    final nav = Navigator.of(context);
    final api = ref.watch(proxyProvider);

    return Scaffold(
      restorationId: 'extension_home_restore',
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            controllers[selectedIndex].animateTo(
              0.0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCirc,
            );
          },
          child: TitleFlexBar(title: tr.webSources.text),
        ),
        actions: [
          OverflowBar(
            spacing: 0.0,
            children: [
              IconButton(
                color: theme.colorScheme.onPrimaryContainer,
                onPressed: () => openLinkDialog(context, api),
                icon: const Icon(Icons.open_in_browser),
                tooltip: tr.webSources.openLink,
              ),
              MenuAnchor(
                builder: (context, controller, child) => IconButton(
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
                            title: Text(tr.webSources.resetAllRead),
                            content: Text(tr.webSources.resetAllReadWarning),
                            actions: <Widget>[
                              TextButton(
                                child: Text(tr.ui.no),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              ElevatedButton(
                                child: Text(tr.ui.yes),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          );
                        },
                      );

                      if (result == true) {
                        webReadMarkerMutation.run(ref, (ref) async {
                          return await ref
                              .get(webReadMarkersProvider.notifier)
                              .clear();
                        });
                      }
                    },
                    leadingIcon: const Icon(Icons.restore),
                    child: Text(tr.webSources.resetAllRead),
                  ),
                  MenuItemButton(
                    onPressed: () => nav.push(
                      SlideTransitionRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SourceManager(),
                      ),
                    ),
                    leadingIcon: const Icon(Icons.collections_bookmark),
                    child: Text(tr.webSources.source.manager),
                  ),
                  MenuItemButton(
                    onPressed: () => nav.push(WebSourceSettingsRouteBuilder()),
                    leadingIcon: const Icon(Icons.settings),
                    child: Text(tr.arg_settings(arg: tr.webSources.text)),
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
            label: tr.webSources.home,
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: t.chapterFeed.latestUpdates,
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
            controllers[selectedIndex].animateTo(
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
