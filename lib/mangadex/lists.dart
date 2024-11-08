import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum _ListViewType { self, followed }

class MangaDexListsView extends HookConsumerWidget {
  const MangaDexListsView({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scrollController = DefaultScrollController.maybeOf(context) ?? controller ?? useScrollController();
    final view = useState(_ListViewType.self);
    final me = ref.watch(loggedUserProvider).value;

    useEffect(() {
      void controllerAtEdge() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          switch (view.value) {
            case _ListViewType.self:
              ref.read(userListsProvider.notifier).getMore();
              break;
            case _ListViewType.followed:
              ref.read(followedListsProvider.notifier).getMore();
              break;
          }
        }
      }

      scrollController.addListener(controllerAtEdge);
      return () => scrollController.removeListener(controllerAtEdge);
    }, [scrollController]);

    final appbar = MangaDexSliverAppBar(
      title: 'mangadex.myLists'.tr(context: context),
      controller: scrollController,
    );

    final leading = SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      actions: [
        SegmentedButton<_ListViewType>(
          style: SegmentedButton.styleFrom(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))),
          showSelectedIcon: false,
          segments: <ButtonSegment<_ListViewType>>[
            ButtonSegment<_ListViewType>(
              value: _ListViewType.self,
              label: Text('mangadex.myLists'.tr(context: context)),
            ),
            ButtonSegment<_ListViewType>(
              value: _ListViewType.followed,
              label: Text('mangadex.followedLists'.tr(context: context)),
            ),
          ],
          selected: <_ListViewType>{view.value},
          onSelectionChanged: (Set<_ListViewType> newSelection) {
            view.value = newSelection.first;
          },
        ),
      ],
    );

    return Scaffold(
      drawer: const MainDrawer(),
      floatingActionButton: FloatingActionButton.extended(
          tooltip: 'mangadex.newList'.tr(context: context),
          icon: const Icon(Icons.playlist_add),
          label: Text('mangadex.newList'.tr(context: context)),
          onPressed: () {
            final messenger = ScaffoldMessenger.of(context);
            context.push<bool>(GagakuRoute.listCreate).then((success) {
              if (!context.mounted) return;
              if (success == true) {
                messenger
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('mangadex.newListOk'.tr(context: context)),
                      backgroundColor: Colors.green,
                    ),
                  );
              }
            });
          }),
      body: switch (view.value) {
        _ListViewType.self => Consumer(
            builder: (context, ref, child) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.read(userListsProvider.notifier).clear();
                  return ref.refresh(userListsProvider.future);
                },
                child: DataProviderWhenWidget(
                  provider: userListsProvider,
                  builder: (context, lists) => CustomScrollView(
                    scrollBehavior: const MouseTouchScrollBehavior(),
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      appbar,
                      leading,
                      if (lists.isEmpty)
                        SliverToBoxAdapter(
                          child: Text('errors.nolists'.tr(context: context)),
                        ),
                      SliverList.builder(
                        itemCount: lists.length,
                        findChildIndexCallback: (key) {
                          final valueKey = key as ValueKey<String>;
                          final val = lists.indexWhere((i) => i.id == valueKey.value);
                          return val >= 0 ? val : null;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final messenger = ScaffoldMessenger.of(context);
                          final item = lists.elementAt(index);

                          return Card(
                            key: ValueKey(item.id),
                            color: index.isOdd
                                ? theme.colorScheme.surfaceContainer
                                : theme.colorScheme.surfaceContainerHighest,
                            child: ListTile(
                              leading: Tooltip(
                                  message: item.attributes.visibility.name.capitalize(),
                                  child: Icon(
                                    Icons.circle,
                                    size: 16.0,
                                    color: item.attributes.visibility == CustomListVisibility.private
                                        ? Colors.red
                                        : Colors.green,
                                  )),
                              title: Text(item.attributes.name),
                              subtitle: Text('num_items'.plural(item.set.length)),
                              trailing: MenuAnchor(
                                builder: (context, controller, child) => IconButton(
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
                                  Consumer(
                                    builder: (context, refx, child) {
                                      final followedLists = refx.watch(followedListsProvider).value;
                                      final idx = followedLists?.indexWhere((e) => e.id == item.id);

                                      if (idx == null) {
                                        return const SizedBox.shrink();
                                      }

                                      return MenuItemButton(
                                        onPressed: () =>
                                            ref.read(followedListsProvider.notifier).setFollow(item, idx == -1),
                                        child: Text(idx == -1
                                            ? 'ui.follow'.tr(context: context)
                                            : 'ui.unfollow'.tr(context: context)),
                                      );
                                    },
                                  ),
                                  MenuItemButton(
                                    onPressed: () async {
                                      final result = await showDeleteListDialog(context, item.attributes.name);
                                      if (result == true) {
                                        ref.read(userListsProvider.notifier).deleteList(item).then((success) {
                                          if (!context.mounted) return;
                                          if (success == true) {
                                            messenger
                                              ..removeCurrentSnackBar()
                                              ..showSnackBar(
                                                SnackBar(
                                                  content: Text('mangadex.deleteListOk'.tr(context: context)),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                          } else {
                                            messenger
                                              ..removeCurrentSnackBar()
                                              ..showSnackBar(
                                                SnackBar(
                                                  content: Text('mangadex.deleteListError'.tr(context: context)),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                          }
                                        });
                                      }
                                    },
                                    child: Text('ui.delete'.tr(context: context)),
                                  ),
                                  MenuItemButton(
                                    onPressed: () {
                                      context.push('/list/edit/${item.id}', extra: item);
                                    },
                                    child: Text('ui.edit'.tr(context: context)),
                                  ),
                                ],
                              ),
                              onTap: () {
                                context.push('/list/${item.id}', extra: item);
                              },
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  loadingBuilder: (_, progress) => LoadingOverlayStack(
                    progress: progress?.toDouble(),
                  ),
                ),
              );
            },
          ),
        _ListViewType.followed => Consumer(
            builder: (context, ref, child) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.read(followedListsProvider.notifier).clear();
                  return ref.refresh(followedListsProvider.future);
                },
                child: DataProviderWhenWidget(
                  provider: followedListsProvider,
                  builder: (context, lists) => CustomScrollView(
                    scrollBehavior: const MouseTouchScrollBehavior(),
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      appbar,
                      leading,
                      if (lists.isEmpty)
                        SliverToBoxAdapter(
                          child: Text('errors.nolists'.tr(context: context)),
                        ),
                      SliverList.builder(
                        itemCount: lists.length,
                        findChildIndexCallback: (key) {
                          final valueKey = key as ValueKey<String>;
                          final val = lists.indexWhere((i) => i.id == valueKey.value);
                          return val >= 0 ? val : null;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final messenger = ScaffoldMessenger.of(context);
                          final item = lists.elementAt(index);

                          return Card(
                            key: ValueKey(item.id),
                            color: index.isOdd
                                ? theme.colorScheme.surfaceContainer
                                : theme.colorScheme.surfaceContainerHighest,
                            child: ListTile(
                              leading: Tooltip(
                                  message: item.attributes.visibility.name.capitalize(),
                                  child: Icon(
                                    Icons.circle,
                                    size: 16.0,
                                    color: item.attributes.visibility == CustomListVisibility.private
                                        ? Colors.red
                                        : Colors.green,
                                  )),
                              title: Text(item.attributes.name),
                              subtitle: Text('num_items'.plural(item.set.length)),
                              trailing: MenuAnchor(
                                builder: (context, controller, child) => IconButton(
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
                                      ref.read(followedListsProvider.notifier).setFollow(item, false);
                                    },
                                    child: Text('ui.unfollow'.tr(context: context)),
                                  ),
                                  if (item.user != null && me != null && item.user!.id == me.id)
                                    MenuItemButton(
                                      onPressed: () async {
                                        final result = await showDeleteListDialog(context, item.attributes.name);
                                        if (result == true) {
                                          ref.read(userListsProvider.notifier).deleteList(item).then((success) {
                                            if (!context.mounted) return;
                                            if (success == true) {
                                              messenger
                                                ..removeCurrentSnackBar()
                                                ..showSnackBar(
                                                  SnackBar(
                                                    content: Text('mangadex.deleteListOk'.tr(context: context)),
                                                    backgroundColor: Colors.green,
                                                  ),
                                                );
                                            } else {
                                              messenger
                                                ..removeCurrentSnackBar()
                                                ..showSnackBar(
                                                  SnackBar(
                                                    content: Text('mangadex.deleteListError'.tr(context: context)),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                            }
                                          });
                                        }
                                      },
                                      child: Text('ui.delete'.tr(context: context)),
                                    ),
                                  if (item.user != null && me != null && item.user!.id == me.id)
                                    MenuItemButton(
                                      onPressed: () {
                                        context.push('/list/edit/${item.id}', extra: item);
                                      },
                                      child: Text('ui.edit'.tr(context: context)),
                                    ),
                                ],
                              ),
                              onTap: () {
                                context.push('/list/${item.id}', extra: item);
                              },
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  loadingBuilder: (_, progress) => LoadingOverlayStack(
                    progress: progress?.toDouble(),
                  ),
                ),
              );
            },
          ),
      },
    );
  }
}
