import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_view.g.dart';

enum _ViewType { titles, feed }

Page<dynamic> buildListViewPage(BuildContext context, GoRouterState state) {
  final list = state.extra.asOrNull<CustomList>();

  Widget child;

  if (list != null) {
    child = MangaDexListViewWidget(
      list: list,
    );
  } else {
    child =
        QueriedMangaDexListViewWidget(listId: state.pathParameters['listId']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@riverpod
Future<CustomList?> _fetchListFromId(
    _FetchListFromIdRef ref, String listId) async {
  final api = ref.watch(mangadexProvider);
  final list = await api.getListById(listId);
  return list;
}

@riverpod
Future<List<ChapterFeedItemData>> _fetchListFeed(
    _FetchListFeedRef ref, CustomList list) async {
  final loggedin = await ref.watch(authControlProvider.future);

  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(customListFeedProvider(list).future);

  final mangaIds = chapters.map((e) => e.getMangaID()).toSet();
  mangaIds.removeWhere((element) => element.isEmpty);

  final mangas =
      await api.fetchManga(ids: mangaIds, limit: MangaDexEndpoints.breakLimit);

  await ref.watch(statisticsProvider.notifier).get(mangas);

  if (loggedin) {
    await ref.watch(readChaptersProvider.notifier).get(mangas);
  }

  final mangaMap = Map<String, Manga>.fromIterable(mangas, key: (e) => e.id);

  // Craft feed items
  List<ChapterFeedItemData> dlist = [];

  for (final chapter in chapters) {
    final cid = chapter.getMangaID();
    if (cid.isNotEmpty && mangaMap.containsKey(cid)) {
      ChapterFeedItemData? item;
      if (dlist.isNotEmpty && dlist.last.mangaId == cid) {
        item = dlist.last;
      } else {
        item = ChapterFeedItemData(manga: mangaMap[cid]!);
        dlist.add(item);
      }

      item.chapters.add(chapter);
    }
  }

  ref.keepAlive();

  return dlist;
}

@riverpod
Future<Iterable<Manga>> _fetchListTitles(
    _FetchListTitlesRef ref, CustomList list) async {
  final mangas = await ref.watch(customListTitlesProvider(list).future);
  await ref.watch(statisticsProvider.notifier).get(mangas);

  ref.keepAlive();

  return mangas;
}

class QueriedMangaDexListViewWidget extends ConsumerWidget {
  const QueriedMangaDexListViewWidget({super.key, required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(_fetchListFromIdProvider(listId));

    Widget child;

    switch (list) {
      case AsyncData(:final value):
        if (value == null) {
          return Center(
            child: Text('List with ID $listId does not exist!'),
          );
        }

        return MangaDexListViewWidget(
          list: value,
        );
      case AsyncError(:final error, :final stackTrace):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_fetchListFromIdProvider($listId) failed",
            error: error, stackTrace: stackTrace);

        child = Styles.errorColumn(error, stackTrace);
        break;
      case _:
        child = Styles.listSpinner;
        break;
    }

    return Scaffold(
      body: child,
    );
  }
}

class MangaDexListViewWidget extends HookConsumerWidget {
  const MangaDexListViewWidget({super.key, required this.list});

  final CustomList list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messenger = ScaffoldMessenger.of(context);
    final view = useState(_ViewType.titles);
    final me = ref.watch(loggedUserProvider).valueOrNull;

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

    final tabs = <Widget>[
      Consumer(
        key: const Key('/list?tab=titles'),
        builder: (context, ref, child) {
          final mangas = ref.watch(_fetchListTitlesProvider(list));
          final isLoading = ref.watch(customListTitlesProvider(list)).isLoading;

          return Stack(
            children: [
              switch (mangas) {
                AsyncValue(:final error?, :final stackTrace?) => () {
                    final messenger = ScaffoldMessenger.of(context);
                    Styles.showErrorSnackBar(messenger, '$error');
                    logger.e("_fetchGroupTitlesProvider(group) failed",
                        error: error, stackTrace: stackTrace);

                    return RefreshIndicator(
                      onRefresh: () {
                        ref.invalidate(customListTitlesProvider(list));
                        return ref
                            .refresh(_fetchListTitlesProvider(list).future);
                      },
                      child: Styles.errorList(error, stackTrace),
                    );
                  }(),
                AsyncValue(:final value?) => () {
                    if (value.isEmpty) {
                      return const Text('No manga!');
                    }

                    return RefreshIndicator(
                      onRefresh: () {
                        ref
                            .read(customListTitlesProvider(list).notifier)
                            .clear();
                        return ref
                            .refresh(_fetchListTitlesProvider(list).future);
                      },
                      child: MangaListWidget(
                        title: const Text(
                          'List Titles',
                          style: TextStyle(fontSize: 24),
                        ),
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: controllers[0],
                        onAtEdge: () => ref
                            .read(customListTitlesProvider(list).notifier)
                            .getMore(),
                        children: [
                          MangaListViewSliver(items: value),
                        ],
                      ),
                    );
                  }(),
                _ => const Stack(
                    children: Styles.loadingOverlay,
                  ),
              },
              if (isLoading) ...Styles.loadingOverlay,
            ],
          );
        },
      ),
      Consumer(
        key: const Key('/list?tab=feed'),
        builder: (context, ref, child) {
          return ChapterFeedWidget(
            provider: _fetchListFeedProvider(list),
            title: 'List Feed',
            emptyText: 'No chapters!',
            onAtEdge: () =>
                ref.read(customListFeedProvider(list).notifier).getMore(),
            onRefresh: () {
              ref.read(customListFeedProvider(list).notifier).clear();
              return ref.refresh(_fetchListFeedProvider(list).future);
            },
            controller: controllers[1],
            restorationId: 'list_feed_offset',
          );
        },
      ),
    ];

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
            controllers[view.value.index].animateTo(0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          },
          child: Styles.titleFlexBar(
              context: context, title: list.attributes.name),
        ),
        actions: (list.user != null && me != null && list.user!.id == me.id)
            ? [
                ElevatedButton(
                  style: Styles.buttonStyle(),
                  onPressed: () {
                    // TODO
                  },
                  child: const Text('Edit'),
                ),
                const SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  style: Styles.buttonStyle(backgroundColor: Colors.red),
                  onPressed: () async {
                    final result = await showDeleteListDialog(
                        context, list.attributes.name);
                    if (result == true) {
                      ref
                          .read(userListsProvider.notifier)
                          .deleteList(list)
                          .then((success) {
                        if (success == true) {
                          context.pop();
                        } else {
                          messenger
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text('Failed to delete list.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                        }
                      });
                    }
                  },
                  child: const Text('Delete'),
                ),
                const SizedBox(
                  width: 4,
                ),
              ]
            : [],
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
          child: tabs[view.value.index],
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
            controllers[index].animateTo(0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          } else {
            // Switch tab
            view.value = _ViewType.values[index];
          }
        },
      ),
    );
  }
}
