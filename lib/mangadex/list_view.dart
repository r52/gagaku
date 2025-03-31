import 'dart:math';

import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';

enum _ViewType { titles, feed }

@RoutePage()
class MangaDexListViewWithNamePage extends MangaDexListViewPage {
  const MangaDexListViewWithNamePage({
    super.key,
    @PathParam() required super.listId,
    @PathParam() this.name,
  });

  final String? name;
}

@RoutePage()
class MangaDexListViewPage extends HookConsumerWidget {
  const MangaDexListViewPage({super.key, @PathParam() required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final router = AutoRouter.of(context);
    final theme = Theme.of(context);
    final view = useState(_ViewType.titles);
    final me = ref.watch(loggedUserProvider).value;
    final listProvider = ref.watch(listSourceProvider(listId));

    final bottomNavigationBarItems = <Widget>[
      NavigationDestination(icon: Icon(Icons.menu_book), label: t.titles),
      NavigationDestination(icon: Icon(Icons.feed), label: t.feed),
    ];

    final controllers = [useScrollController(), useScrollController()];

    final customFeedInfo = MangaDexFeeds.customListFeed;

    switch (listProvider) {
      case AsyncValue(:final error?, :final stackTrace?):
        return Scaffold(
          appBar: AppBar(),
          body: RefreshIndicator(
            onRefresh:
                () async => ref.refresh(listSourceProvider(listId).future),
            child: ErrorList(
              error: error,
              stackTrace: stackTrace,
              message: "_fetchListFromIdProvider($listId) failed",
            ),
          ),
        );
      case AsyncValue(hasValue: true, value: final list) when list != null:
        return Scaffold(
          appBar: AppBar(
            leading: AutoLeadingButton(),
            flexibleSpace: GestureDetector(
              onTap: () {
                controllers[view.value.index].animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
              child: TitleFlexBar(title: list.attributes.name),
            ),
            actions: [
              OverflowBar(
                spacing: 8.0,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final followedLists =
                          ref.watch(followedListsProvider(me?.id)).value;
                      final followList = ref.watch(
                        followedListsProvider(me?.id).setFollow,
                      );
                      final idx = followedLists?.indexWhere(
                        (e) => e.id == list.id,
                      );

                      if (idx == null) {
                        return const SizedBox.shrink();
                      }

                      return IconButton(
                        style: Styles.squareIconButtonStyle(
                          backgroundColor: theme.colorScheme.surfaceContainer,
                        ),
                        onPressed: () => followList(list, idx == -1),
                        icon: Icon(
                          idx == -1 ? Icons.bookmark_border : Icons.bookmark,
                          color: idx == -1 ? null : theme.colorScheme.primary,
                        ),
                        tooltip: idx == -1 ? t.ui.follow : t.ui.unfollow,
                      );
                    },
                  ),
                  if (list.user != null && me != null && list.user!.id == me.id)
                    IconButton(
                      style: Styles.squareIconButtonStyle(
                        backgroundColor: theme.colorScheme.surfaceContainer,
                      ),
                      onPressed: () {
                        router.push(MangaDexEditListRoute(list: list));
                      },
                      icon: const Icon(Icons.edit),
                      tooltip: t.ui.edit,
                    ),
                  const SizedBox.shrink(),
                ],
              ),
            ],
          ),
          body: Center(
            child: PageTransitionSwitcher(
              transitionBuilder: (child, animation, secondaryAnimation) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: switch (view.value) {
                _ViewType.titles => HookConsumer(
                  key: const Key('/list?tab=titles'),
                  builder: (context, ref, child) {
                    final refresh = useState(UniqueKey());
                    final currentPage = useValueNotifier(0);

                    return RefreshIndicator(
                      onRefresh: () async {
                        refresh.value = UniqueKey();
                        return ref.refresh(listSourceProvider(listId).future);
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: HookConsumer(
                              builder: (context, ref, child) {
                                final page = useValueListenable(currentPage);
                                final data = useMemoized(
                                  () => getMangaListByPage(ref, list.set, page),
                                  [list.set, page, refresh.value],
                                );
                                final future = useFuture(data);

                                return MangaListWidget(
                                  title: Text(
                                    '${t.titles} (${list.set.length})',
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller: controllers[0],
                                  future: future,
                                  children: [
                                    if (future.hasData)
                                      MangaListViewSliver(items: future.data),
                                  ],
                                );
                              },
                            ),
                          ),
                          HookBuilder(
                            builder: (context) {
                              final _ = useValueListenable(currentPage);
                              return NumberPaginator(
                                numberPages: max(
                                  (list.set.length /
                                          MangaDexEndpoints.searchLimit)
                                      .ceil(),
                                  1,
                                ),
                                onPageChange: (int index) {
                                  controllers[0].jumpTo(0.0);
                                  currentPage.value = index;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                _ViewType.feed => InfiniteScrollChapterFeedWidget(
                  key: const Key('/list?tab=feed'),
                  feedKey: customFeedInfo.key,
                  limit: customFeedInfo.limit,
                  path: customFeedInfo.path!.replaceFirst('{id}', list.id),
                  entity: list,
                  title: t.mangadex.listFeed,
                  scrollController: controllers[1],
                  restorationId: 'list_feed_offset',
                ),
              },
            ),
          ),
          bottomNavigationBar: NavigationBar(
            height: 60,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            destinations: bottomNavigationBarItems,
            selectedIndex: view.value.index,
            onDestinationSelected: (index) {
              final currTab = view.value;

              if (currTab == _ViewType.values[index]) {
                // Scroll to top if on the same tab
                controllers[index].animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              } else {
                // Switch tab
                view.value = _ViewType.values[index];
              }
            },
          ),
        );
      case AsyncValue(hasValue: true, value: final list) when list == null:
        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(t.mangadex.listNotExistError(id: listId))),
        );
      case AsyncValue(:final progress):
        return Scaffold(body: ListSpinner(progress: progress?.toDouble()));
    }
  }
}
