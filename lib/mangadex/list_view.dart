import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_view.g.dart';

enum _ViewType { titles, feed }

Page<dynamic> buildListViewPage(BuildContext context, GoRouterState state) {
  final list = state.extra.asOrNull<CustomList>();

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: MangaDexListViewWidget(
      listId: list != null ? list.id : state.pathParameters['listId']!,
    ),
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@riverpod
Future<List<ChapterFeedItemData>> _fetchListFeed(_FetchListFeedRef ref, CustomList list) async {
  final loggedin = await ref.watch(authControlProvider.future);

  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(customListFeedProvider(list).future);

  final mangaIds = chapters.map((e) => e.manga.id).toSet();

  final mangas = await api.fetchManga(ids: mangaIds, limit: MangaDexEndpoints.breakLimit);

  await ref.read(statisticsProvider.notifier).get(mangas);

  if (loggedin) {
    await ref.read(readChaptersProvider.notifier).get(mangas);
  }

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

class MangaDexListViewWidget extends HookConsumerWidget {
  const MangaDexListViewWidget({super.key, required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final view = useState(_ViewType.titles);
    final me = ref.watch(loggedUserProvider).value;
    final listProvider = ref.watch(listSourceProvider(listId));

    const bottomNavigationBarItems = <Widget>[
      NavigationDestination(
        icon: Icon(Icons.menu_book),
        label: 'Titles',
      ),
      NavigationDestination(
        icon: Icon(Icons.feed),
        label: 'Feed',
      ),
    ];

    final controllers = [
      useScrollController(),
      useScrollController(),
    ];

    switch (listProvider) {
      case AsyncValue(:final error?, :final stackTrace?):
        return Scaffold(
          appBar: AppBar(),
          body: RefreshIndicator(
            onRefresh: () async => ref.refresh(listSourceProvider(listId).future),
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
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/');
                }
              },
            ),
            flexibleSpace: GestureDetector(
              onTap: () {
                controllers[view.value.index]
                    .animateTo(0.0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
              },
              child: TitleFlexBar(title: list.attributes.name),
            ),
            actions: [
              OverflowBar(
                spacing: 8.0,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final followedLists = ref.watch(followedListsProvider).value;
                      final idx = followedLists?.indexWhere((e) => e.id == list.id);

                      if (idx == null) {
                        return const SizedBox.shrink();
                      }

                      return IconButton(
                        style: Styles.squareIconButtonStyle(backgroundColor: theme.colorScheme.surfaceContainer),
                        onPressed: () => ref.read(followedListsProvider.notifier).setFollow(list, idx == -1),
                        icon: Icon(
                          idx == -1 ? Icons.bookmark_border : Icons.bookmark,
                          color: idx == -1 ? null : theme.colorScheme.primary,
                        ),
                        tooltip: idx == -1 ? 'Follow' : 'Unfollow',
                      );
                    },
                  ),
                  if (list.user != null && me != null && list.user!.id == me.id)
                    IconButton(
                      style: Styles.squareIconButtonStyle(backgroundColor: theme.colorScheme.surfaceContainer),
                      onPressed: () {
                        context.push('/list/edit/${list.id}', extra: list);
                      },
                      icon: const Icon(Icons.edit),
                      tooltip: 'Edit',
                    ),
                  const SizedBox.shrink(),
                  // if (list.user != null && me != null && list.user!.id == me.id)
                  //   ElevatedButton(
                  //     style: Styles.buttonStyle(backgroundColor: Colors.red),
                  //     onPressed: () async {
                  //       final result = await showDeleteListDialog(
                  //           context, list.attributes.name);
                  //       if (result == true) {
                  //         ref
                  //             .read(userListsProvider.notifier)
                  //             .deleteList(list)
                  //             .then((success) {
                  //           if (success == true) {
                  //             if (!context.mounted) return;
                  //             context.pop();
                  //           } else {
                  //             messenger
                  //               ..removeCurrentSnackBar()
                  //               ..showSnackBar(
                  //                 const SnackBar(
                  //                   content: Text('Failed to delete list.'),
                  //                   backgroundColor: Colors.red,
                  //                 ),
                  //               );
                  //           }
                  //         });
                  //       }
                  //     },
                  //     child: const Text('Delete'),
                  //   ),
                  // const SizedBox(
                  //   width: 4,
                  // ),
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
                      final titlesProvider = ref.watch(getMangaListByPageProvider(list.set, currentPage.value));

                      return Stack(
                        children: [
                          Column(
                            children: switch (titlesProvider) {
                              AsyncValue(:final error?, :final stackTrace?) => [
                                  RefreshIndicator(
                                    onRefresh: () async =>
                                        ref.refresh(getMangaListByPageProvider(list.set, currentPage.value).future),
                                    child: ErrorList(error: error, stackTrace: stackTrace),
                                  )
                                ],
                              AsyncValue(value: final mangas) => [
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async =>
                                          ref.refresh(getMangaListByPageProvider(list.set, currentPage.value).future),
                                      child: MangaListWidget(
                                        title: Text(
                                          'Titles (${list.set.length})',
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        controller: controllers[0],
                                        children: [
                                          if (mangas != null) MangaListViewSliver(items: mangas),
                                        ],
                                      ),
                                    ),
                                  ),
                                  NumberPaginator(
                                    numberPages: max((list.set.length / MangaDexEndpoints.searchLimit).ceil(), 1),
                                    onPageChange: (int index) {
                                      currentPage.value = index;
                                    },
                                  ),
                                ],
                            },
                          ),
                          if (titlesProvider.isLoading) ...Styles.loadingOverlay
                        ],
                      );
                    },
                  ),
                _ViewType.feed => Consumer(
                    key: const Key('/list?tab=feed'),
                    builder: (context, ref, child) {
                      return ChapterFeedWidget(
                        provider: _fetchListFeedProvider(list),
                        title: 'List Feed',
                        emptyText: 'No chapters!',
                        onAtEdge: () => ref.read(customListFeedProvider(list).notifier).getMore(),
                        onRefresh: () async {
                          ref.read(customListFeedProvider(list).notifier).clear();
                          return ref.refresh(_fetchListFeedProvider(list).future);
                        },
                        controller: controllers[1],
                        restorationId: 'list_feed_offset',
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
                controllers[index].animateTo(0.0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
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
            child: Text('List with ID $listId does not exist!'),
          ),
        );
      case AsyncValue(:final progress):
        return Scaffold(
          body: ListSpinner(
            progress: progress?.toDouble(),
          ),
        );
    }
  }
}
