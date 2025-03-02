import 'dart:math';

import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_view.g.dart';

enum _ViewType { titles, feed }

@Riverpod(retry: noRetry)
Future<List<ChapterFeedItemData>> _fetchListFeed(
  Ref ref,
  CustomList list,
) async {
  final me = await ref.watch(loggedUserProvider.future);
  final api = ref.watch(mangadexProvider);

  final chapters = await ref.watch(customListFeedProvider(list).future);

  final mangaIds = chapters.map((e) => e.manga.id).toSet();
  final mangas = await api.fetchManga(
    ids: mangaIds,
    limit: MangaDexEndpoints.breakLimit,
  );

  await ref.read(statisticsProvider.get)(mangas);
  await ref.read(readChaptersProvider(me?.id).get)(mangas);

  final mangaMap = Map<String, Manga>.fromIterable(mangas, key: (e) => e.id);

  // Craft feed items
  final dlist = chapters.fold(<ChapterFeedItemData>[], (list, chapter) {
    final mid = chapter.manga.id;
    if (mangaMap.containsKey(mid)) {
      ChapterFeedItemData? item;
      if (list.isNotEmpty && list.last.mangaId == mid) {
        item = list.last;
      } else {
        item = ChapterFeedItemData(manga: mangaMap[mid]!);
        list.add(item);
      }

      item.chapters.add(chapter);
    }

    return list;
  });

  ref.disposeAfter(const Duration(minutes: 5));

  return dlist;
}

@Riverpod(retry: noRetry)
Future<CustomList?> _getList(Ref ref, String listId) async {
  final me = await ref.watch(loggedUserProvider.future);

  if (me != null) {
    final userlists = await ref.watch(userListsProvider(me.id).future);
    final found = userlists.indexWhere((e) => e.id == listId);
    if (found >= 0) {
      return userlists.elementAt(found);
    }
  }

  final list = await ref.watch(listSourceProvider(listId).future);
  return list;
}

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
    final router = AutoRouter.of(context);
    final theme = Theme.of(context);
    final view = useState(_ViewType.titles);
    final me = ref.watch(loggedUserProvider).value;
    final listProvider = ref.watch(_getListProvider(listId));

    final bottomNavigationBarItems = <Widget>[
      NavigationDestination(
        icon: Icon(Icons.menu_book),
        label: 'titles'.tr(context: context),
      ),
      NavigationDestination(
        icon: Icon(Icons.feed),
        label: 'feed'.tr(context: context),
      ),
    ];

    final controllers = [useScrollController(), useScrollController()];

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
                        tooltip:
                            idx == -1
                                ? 'ui.follow'.tr(context: context)
                                : 'ui.unfollow'.tr(context: context),
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
                      tooltip: 'ui.edit'.tr(context: context),
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
                    final currentPage = useState(0);
                    final titlesProvider = ref.watch(
                      getMangaListByPageProvider(list.set, currentPage.value),
                    );

                    return RefreshIndicator(
                      onRefresh:
                          () async => ref.refresh(
                            getMangaListByPageProvider(
                              list.set,
                              currentPage.value,
                            ).future,
                          ),
                      child: switch (titlesProvider) {
                        AsyncValue(:final error?, :final stackTrace?) =>
                          ErrorList(error: error, stackTrace: stackTrace),
                        AsyncValue(value: final mangas) => Column(
                          children: [
                            Expanded(
                              child: MangaListWidget(
                                title: Text(
                                  '${'titles'.tr(context: context)} (${list.set.length})',
                                  style: const TextStyle(fontSize: 24),
                                ),
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: controllers[0],
                                isLoading: titlesProvider.isLoading,
                                children: [
                                  if (mangas != null)
                                    MangaListViewSliver(items: mangas),
                                ],
                              ),
                            ),
                            NumberPaginator(
                              numberPages: max(
                                (list.set.length /
                                        MangaDexEndpoints.searchLimit)
                                    .ceil(),
                                1,
                              ),
                              onPageChange: (int index) {
                                currentPage.value = index;
                              },
                            ),
                          ],
                        ),
                      },
                    );
                  },
                ),
                _ViewType.feed => Consumer(
                  key: const Key('/list?tab=feed'),
                  builder: (context, ref, child) {
                    final getNextPage = ref.watch(
                      customListFeedProvider(list).getNextPage,
                    );

                    return ChapterFeedWidget(
                      provider: _fetchListFeedProvider(list),
                      title: 'mangadex.listFeed'.tr(context: context),
                      emptyText: 'mangaView.noChaptersMsg'.tr(context: context),
                      onAtEdge: () {
                        if (getNextPage.state is! PendingMutationState) {
                          getNextPage();
                        }
                      },
                      onRefresh: () async {
                        ref.invalidate(customListFeedProvider(list));
                        return ref.refresh(_fetchListFeedProvider(list).future);
                      },
                      controller: controllers[1],
                      restorationId: 'list_feed_offset',
                      isLoading: getNextPage.state is PendingMutationState,
                    );
                  },
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
          body: Center(
            child: Text(
              'mangadex.listNotExistError'.tr(context: context, args: [listId]),
            ),
          ),
        );
      case AsyncValue(:final progress):
        return Scaffold(body: ListSpinner(progress: progress?.toDouble()));
    }
  }
}
