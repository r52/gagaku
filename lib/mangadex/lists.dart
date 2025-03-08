import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/mangadex/login_password.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

enum _ListViewType { self, followed }

@RoutePage()
class MangaDexListsPage extends StatelessWidget {
  const MangaDexListsPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return MangaDexLoginWidget(
      builder: (context) => MangaDexListsWidget(controller: controller),
    );
  }
}

class MangaDexListsWidget extends HookConsumerWidget {
  const MangaDexListsWidget({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AutoRouter.of(context);
    final theme = Theme.of(context);
    final scrollController =
        DefaultScrollController.maybeOf(context, 'MangaDexListsPage') ??
        controller ??
        useScrollController();
    final view = useState(_ListViewType.self);
    final me = ref.watch(loggedUserProvider).value;
    final deleteList = ref.watch(userListsProvider(me?.id).deleteList);
    final followList = ref.watch(followedListsProvider(me?.id).setFollow);
    final userGetNextPage = ref.watch(userListsProvider(me?.id).getNextPage);
    final followGetNextPage = ref.watch(
      followedListsProvider(me?.id).getNextPage,
    );

    ref.listen(userListsProvider(me?.id).deleteList, (_, state) {
      if (state.state is ErrorMutationState) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                'mangadex.deleteListError'.tr(
                  context: context,
                  args: [(state.state as ErrorMutationState).error.toString()],
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );
      } else if (state.state is SuccessMutationState) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('mangadex.deleteListOk'.tr(context: context)),
              backgroundColor: Colors.green,
            ),
          );
      }

      return;
    });

    useEffect(() {
      void controllerAtEdge() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
          switch (view.value) {
            case _ListViewType.self:
              if (userGetNextPage.state is! PendingMutationState) {
                userGetNextPage();
              }
              break;
            case _ListViewType.followed:
              if (followGetNextPage.state is! PendingMutationState) {
                followGetNextPage();
              }
              break;
          }
        }
      }

      scrollController.addListener(controllerAtEdge);
      return () => scrollController.removeListener(controllerAtEdge);
    }, [scrollController, me]);

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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
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
          router.push<bool>(MangaDexEditListRoute()).then((success) {
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
        },
      ),
      body: switch (view.value) {
        _ListViewType.self => Consumer(
          builder: (context, ref, child) {
            return RefreshIndicator(
              key: ValueKey('_ListViewType.self(${me?.id})'),
              onRefresh: () => ref.refresh(userListsProvider(me?.id).future),
              child: DataProviderWhenWidget(
                provider: userListsProvider(me?.id),
                builder:
                    (context, lists) => Stack(
                      children: [
                        CustomScrollView(
                          scrollBehavior: const MouseTouchScrollBehavior(),
                          controller: scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            appbar,
                            leading,
                            if (lists.isEmpty)
                              SliverToBoxAdapter(
                                child: Text(
                                  'errors.nolists'.tr(context: context),
                                ),
                              ),
                            SliverList.builder(
                              itemCount: lists.length,
                              findChildIndexCallback: (key) {
                                final valueKey = key as ValueKey<String>;
                                final val = lists.indexWhere(
                                  (i) => i.id == valueKey.value,
                                );
                                return val >= 0 ? val : null;
                              },
                              itemBuilder: (BuildContext context, int index) {
                                final item = lists.elementAt(index);

                                return Card(
                                  key: ValueKey(item.id),
                                  color:
                                      index.isOdd
                                          ? theme.colorScheme.surfaceContainer
                                          : theme
                                              .colorScheme
                                              .surfaceContainerHighest,
                                  child: ListTile(
                                    leading: Tooltip(
                                      message:
                                          item.attributes.visibility.name
                                              .capitalize(),
                                      child: Icon(
                                        Icons.circle,
                                        size: 16.0,
                                        color:
                                            item.attributes.visibility ==
                                                    CustomListVisibility.private
                                                ? Colors.red
                                                : Colors.green,
                                      ),
                                    ),
                                    title: Text(item.attributes.name),
                                    subtitle: Text(
                                      'num_items'.plural(item.set.length),
                                    ),
                                    trailing: MenuAnchor(
                                      builder:
                                          (context, controller, child) =>
                                              IconButton(
                                                onPressed: () {
                                                  if (controller.isOpen) {
                                                    controller.close();
                                                  } else {
                                                    controller.open();
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.more_vert,
                                                ),
                                              ),
                                      menuChildren: [
                                        Consumer(
                                          builder: (context, refx, child) {
                                            final followedLists =
                                                refx
                                                    .watch(
                                                      followedListsProvider(
                                                        me?.id,
                                                      ),
                                                    )
                                                    .value;
                                            final idx = followedLists
                                                ?.indexWhere(
                                                  (e) => e.id == item.id,
                                                );

                                            if (idx == null) {
                                              return const SizedBox.shrink();
                                            }

                                            return MenuItemButton(
                                              onPressed:
                                                  () => followList(
                                                    item,
                                                    idx == -1,
                                                  ),
                                              child: Text(
                                                idx == -1
                                                    ? 'ui.follow'.tr(
                                                      context: context,
                                                    )
                                                    : 'ui.unfollow'.tr(
                                                      context: context,
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                        MenuItemButton(
                                          onPressed: () async {
                                            final result =
                                                await showDeleteListDialog(
                                                  context,
                                                  item.attributes.name,
                                                );
                                            if (result == true) {
                                              deleteList(item);
                                            }
                                          },
                                          child: Text(
                                            'ui.delete'.tr(context: context),
                                          ),
                                        ),
                                        MenuItemButton(
                                          onPressed: () {
                                            router.push(
                                              MangaDexEditListRoute(list: item),
                                            );
                                          },
                                          child: Text(
                                            'ui.edit'.tr(context: context),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      router.pushPath('/list/${item.id}');
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        if (userGetNextPage.state is PendingMutationState)
                          ...Styles.loadingOverlay,
                      ],
                    ),
                loadingBuilder:
                    (_, progress) =>
                        LoadingOverlayStack(progress: progress?.toDouble()),
              ),
            );
          },
        ),
        _ListViewType.followed => Consumer(
          builder: (context, ref, child) {
            return RefreshIndicator(
              key: ValueKey('_ListViewType.followed(${me?.id})'),
              onRefresh:
                  () => ref.refresh(followedListsProvider(me?.id).future),
              child: DataProviderWhenWidget(
                provider: followedListsProvider(me?.id),
                builder:
                    (context, lists) => Stack(
                      children: [
                        CustomScrollView(
                          scrollBehavior: const MouseTouchScrollBehavior(),
                          controller: scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            appbar,
                            leading,
                            if (lists.isEmpty)
                              SliverToBoxAdapter(
                                child: Text(
                                  'errors.nolists'.tr(context: context),
                                ),
                              ),
                            SliverList.builder(
                              itemCount: lists.length,
                              findChildIndexCallback: (key) {
                                final valueKey = key as ValueKey<String>;
                                final val = lists.indexWhere(
                                  (i) => i.id == valueKey.value,
                                );
                                return val >= 0 ? val : null;
                              },
                              itemBuilder: (BuildContext context, int index) {
                                final item = lists.elementAt(index);

                                return Card(
                                  key: ValueKey(item.id),
                                  color:
                                      index.isOdd
                                          ? theme.colorScheme.surfaceContainer
                                          : theme
                                              .colorScheme
                                              .surfaceContainerHighest,
                                  child: ListTile(
                                    leading: Tooltip(
                                      message:
                                          item.attributes.visibility.name
                                              .capitalize(),
                                      child: Icon(
                                        Icons.circle,
                                        size: 16.0,
                                        color:
                                            item.attributes.visibility ==
                                                    CustomListVisibility.private
                                                ? Colors.red
                                                : Colors.green,
                                      ),
                                    ),
                                    title: Text(item.attributes.name),
                                    subtitle: Text(
                                      'num_items'.plural(item.set.length),
                                    ),
                                    trailing: MenuAnchor(
                                      builder:
                                          (context, controller, child) =>
                                              IconButton(
                                                onPressed: () {
                                                  if (controller.isOpen) {
                                                    controller.close();
                                                  } else {
                                                    controller.open();
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.more_vert,
                                                ),
                                              ),
                                      menuChildren: [
                                        MenuItemButton(
                                          onPressed: () async {
                                            followList(item, false);
                                          },
                                          child: Text(
                                            'ui.unfollow'.tr(context: context),
                                          ),
                                        ),
                                        if (item.user != null &&
                                            me != null &&
                                            item.user!.id == me.id)
                                          MenuItemButton(
                                            onPressed: () async {
                                              final result =
                                                  await showDeleteListDialog(
                                                    context,
                                                    item.attributes.name,
                                                  );
                                              if (result == true) {
                                                deleteList(item);
                                              }
                                            },
                                            child: Text(
                                              'ui.delete'.tr(context: context),
                                            ),
                                          ),
                                        if (item.user != null &&
                                            me != null &&
                                            item.user!.id == me.id)
                                          MenuItemButton(
                                            onPressed: () {
                                              router.push(
                                                MangaDexEditListRoute(
                                                  list: item,
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'ui.edit'.tr(context: context),
                                            ),
                                          ),
                                      ],
                                    ),
                                    onTap: () {
                                      router.pushPath('/list/${item.id}');
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        if (followGetNextPage.state is PendingMutationState)
                          ...Styles.loadingOverlay,
                      ],
                    ),
                loadingBuilder:
                    (_, progress) =>
                        LoadingOverlayStack(progress: progress?.toDouble()),
              ),
            );
          },
        ),
      },
    );
  }
}
