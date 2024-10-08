import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/config.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'group_view.g.dart';

enum _ViewType { info, feed, titles }

Page<dynamic> buildGroupViewPage(BuildContext context, GoRouterState state) {
  final group = state.extra.asOrNull<Group>();

  Widget child;

  if (group != null) {
    child = MangaDexGroupViewWidget(
      group: group,
    );
  } else {
    child = QueriedMangaDexGroupViewWidget(groupId: state.pathParameters['groupId']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@riverpod
Future<Group> _fetchGroupFromId(_FetchGroupFromIdRef ref, String groupId) async {
  final api = ref.watch(mangadexProvider);
  final group = await api.fetchGroups([groupId]);
  return group.first;
}

@riverpod
Future<List<ChapterFeedItemData>> _fetchGroupFeed(_FetchGroupFeedRef ref, Group group) async {
  final loggedin = await ref.watch(authControlProvider.future);

  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(groupFeedProvider(group).future);

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
    if (mid.isNotEmpty && mangaMap.containsKey(mid)) {
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

@riverpod
Future<List<Manga>> _fetchGroupTitles(_FetchGroupTitlesRef ref, Group group) async {
  final mangas = await ref.watch(groupTitlesProvider(group).future);
  await ref.read(statisticsProvider.notifier).get(mangas);

  ref.disposeAfter(const Duration(minutes: 5));

  return mangas;
}

class QueriedMangaDexGroupViewWidget extends ConsumerWidget {
  const QueriedMangaDexGroupViewWidget({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupProvider = ref.watch(_fetchGroupFromIdProvider(groupId));

    return Scaffold(
      body: switch (groupProvider) {
        AsyncValue(:final error?, :final stackTrace?) => ErrorColumn(
            error: error,
            stackTrace: stackTrace,
            message: "_fetchGroupFromIdProvider($groupId) failed",
          ),
        AsyncValue(value: final group?) => MangaDexGroupViewWidget(
            group: group,
          ),
        AsyncValue(:final progress) => ListSpinner(
            progress: progress?.toDouble(),
          ),
      },
    );
  }
}

class MangaDexGroupViewWidget extends HookConsumerWidget {
  const MangaDexGroupViewWidget({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final view = useState(_ViewType.info);

    final settings = ref.watch(mdConfigProvider);
    final isBlacklisted = settings.groupBlacklist.contains(group.id);
    final cfg = useRef(settings);

    const bottomNavigationBarItems = <Widget>[
      NavigationDestination(
        icon: Icon(Icons.info),
        label: 'Info',
      ),
      NavigationDestination(
        icon: Icon(Icons.feed),
        label: 'Group Feed',
      ),
      NavigationDestination(
        icon: Icon(Icons.menu_book),
        label: 'Group Titles',
      ),
    ];

    final controllers = [
      useScrollController(),
      useScrollController(),
      useScrollController(),
    ];

    final tab = switch (view.value) {
      _ViewType.info => CustomScrollView(
          controller: controllers[0],
          scrollBehavior: const MouseTouchScrollBehavior(),
          slivers: <Widget>[
            SliverList.list(children: [
              if (group.attributes.description != null)
                ExpansionTile(
                  initiallyExpanded: true,
                  title: const Text('Group Description'),
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Text(group.attributes.description!),
                    ),
                  ],
                ),
              if (group.attributes.website != null || group.attributes.discord != null)
                ExpansionTile(
                  initiallyExpanded: true,
                  expandedAlignment: Alignment.centerLeft,
                  title: const Text('Links'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: [
                          if (group.attributes.website != null)
                            ButtonChip(
                              onPressed: () async {
                                if (!await launchUrl(Uri.parse(group.attributes.website!))) {
                                  throw 'Could not launch ${group.attributes.website!}';
                                }
                              },
                              text: 'Website',
                            ),
                          if (group.attributes.discord != null)
                            ButtonChip(
                              onPressed: () async {
                                final url = 'https://discord.gg/${group.attributes.discord!}';
                                if (!await launchUrl(Uri.parse(url))) {
                                  throw 'Could not launch $url';
                                }
                              },
                              text: 'Discord',
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              if (group.attributes.description == null &&
                  group.attributes.website == null &&
                  group.attributes.discord == null)
                const Center(
                  child: Text('Nothing here!'),
                ),
            ]),
          ],
        ),
      _ViewType.feed => Consumer(
          key: const Key('/group?tab=feed'),
          builder: (context, ref, child) {
            return ChapterFeedWidget(
              provider: _fetchGroupFeedProvider(group),
              title: 'Group Feed',
              emptyText: 'No chapters!',
              onAtEdge: () => ref.read(groupFeedProvider(group).notifier).getMore(),
              onRefresh: () async {
                ref.read(groupFeedProvider(group).notifier).clear();
                return ref.refresh(_fetchGroupFeedProvider(group).future);
              },
              controller: controllers[1],
              restorationId: 'group_feed_offset',
            );
          },
        ),
      _ViewType.titles => Consumer(
          key: const Key('/group?tab=titles'),
          builder: (context, ref, child) {
            final titleProvider = ref.watch(_fetchGroupTitlesProvider(group));
            final isLoading = titleProvider.isLoading && !titleProvider.isRefreshing;

            return Stack(
              children: [
                switch (titleProvider) {
                  AsyncValue(:final error?, :final stackTrace?) => RefreshIndicator(
                      onRefresh: () async {
                        ref.read(groupTitlesProvider(group).notifier).clear();
                        return ref.refresh(_fetchGroupTitlesProvider(group).future);
                      },
                      child: ErrorList(
                        error: error,
                        stackTrace: stackTrace,
                        message: "_fetchGroupTitlesProvider(${group.id}) failed",
                      ),
                    ),
                  AsyncValue(value: final mangas?) => RefreshIndicator(
                      onRefresh: () async {
                        ref.read(groupTitlesProvider(group).notifier).clear();
                        return ref.refresh(_fetchGroupTitlesProvider(group).future);
                      },
                      child: mangas.isEmpty
                          ? const Text('No manga!')
                          : MangaListWidget(
                              title: const Text(
                                'Group Titles',
                                style: TextStyle(fontSize: 24),
                              ),
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: controllers[2],
                              onAtEdge: () => ref.read(groupTitlesProvider(group).notifier).getMore(),
                              children: [
                                MangaListViewSliver(items: mangas),
                              ],
                            ),
                    ),
                  AsyncValue(:final progress) => LoadingOverlayStack(
                      progress: progress?.toDouble(),
                    ),
                },
                if (isLoading) ...Styles.loadingOverlay,
              ],
            );
          },
        ),
    };

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
          child: TitleFlexBar(title: group.attributes.name),
        ),
        actions: [
          ElevatedButton.icon(
            style: Styles.buttonStyle(
              backgroundColor: isBlacklisted ? Colors.green.shade900 : Colors.red.shade900,
            ),
            onPressed: () {
              if (isBlacklisted) {
                cfg.value = settings.copyWith(
                    groupBlacklist: settings.groupBlacklist.where((element) => element != group.id).toSet());
              } else {
                cfg.value = settings.copyWith(groupBlacklist: {...settings.groupBlacklist, group.id});
              }

              ref.read(mdConfigProvider.notifier).save(cfg.value);
            },
            icon: const Icon(Icons.block),
            label: Text(isBlacklisted ? 'Unblock' : 'Block'),
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
          child: tab,
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
  }
}
