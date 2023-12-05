import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
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
    child = QueriedMangaDexGroupViewWidget(
        groupId: state.pathParameters['groupId']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@riverpod
Future<Group> _fetchGroupFromId(
    _FetchGroupFromIdRef ref, String groupId) async {
  final api = ref.watch(mangadexProvider);
  final group = await api.fetchGroups([groupId]);
  return group.first;
}

@riverpod
Future<List<ChapterFeedItemData>> _fetchGroupFeed(
    _FetchGroupFeedRef ref, Group group) async {
  final loggedin = await ref.watch(authControlProvider.future);

  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(groupFeedProvider(group).future);

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
Future<Iterable<Manga>> _fetchGroupTitles(
    _FetchGroupTitlesRef ref, Group group) async {
  final mangas = await ref.watch(groupTitlesProvider(group).future);
  await ref.watch(statisticsProvider.notifier).get(mangas);

  ref.keepAlive();

  return mangas;
}

class QueriedMangaDexGroupViewWidget extends ConsumerWidget {
  const QueriedMangaDexGroupViewWidget({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(_fetchGroupFromIdProvider(groupId));

    Widget child;

    switch (group) {
      case AsyncData(:final value):
        return MangaDexGroupViewWidget(
          group: value,
        );
      case AsyncError(:final error, :final stackTrace):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_fetchGroupFromIdProvider($groupId) failed",
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
          scrollBehavior: MouseTouchScrollBehavior(),
          slivers: <Widget>[
            if (group.attributes.description != null)
              SliverToBoxAdapter(
                child: ExpansionTile(
                  initiallyExpanded: true,
                  title: const Text('Group Description'),
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      color: theme.colorScheme.background,
                      child: Text(group.attributes.description!),
                    ),
                  ],
                ),
              ),
            if (group.attributes.website != null ||
                group.attributes.discord != null)
              SliverToBoxAdapter(
                child: ExpansionTile(
                  initiallyExpanded: true,
                  expandedAlignment: Alignment.centerLeft,
                  title: const Text('Links'),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: theme.colorScheme.background,
                      child: Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: [
                          if (group.attributes.website != null)
                            ButtonChip(
                              onPressed: () async {
                                if (!await launchUrl(
                                    Uri.parse(group.attributes.website!))) {
                                  throw 'Could not launch ${group.attributes.website!}';
                                }
                              },
                              text: const Text('Website'),
                            ),
                          if (group.attributes.discord != null)
                            ButtonChip(
                              onPressed: () async {
                                final url =
                                    'https://discord.gg/${group.attributes.discord!}';
                                if (!await launchUrl(Uri.parse(url))) {
                                  throw 'Could not launch $url';
                                }
                              },
                              text: const Text('Discord'),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      _ViewType.feed => Consumer(
          key: const Key('/group?tab=feed'),
          builder: (context, ref, child) {
            return ChapterFeedWidget(
              provider: _fetchGroupFeedProvider(group),
              title: 'Group Feed',
              emptyText: 'No chapters!',
              onAtEdge: () =>
                  ref.read(groupFeedProvider(group).notifier).getMore(),
              onRefresh: () {
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
            final mangas = ref.watch(_fetchGroupTitlesProvider(group));
            final isLoading = mangas.isLoading && !mangas.isRefreshing;

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
                          ref.read(groupTitlesProvider(group).notifier).clear();
                          return ref
                              .refresh(_fetchGroupTitlesProvider(group).future);
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
                          ref.read(groupTitlesProvider(group).notifier).clear();
                          return ref
                              .refresh(_fetchGroupTitlesProvider(group).future);
                        },
                        child: MangaListWidget(
                          title: const Text(
                            'Group Titles',
                            style: TextStyle(fontSize: 24),
                          ),
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: controllers[2],
                          onAtEdge: () => ref
                              .read(groupTitlesProvider(group).notifier)
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
            controllers[view.value.index].animateTo(0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          },
          child: Styles.titleFlexBar(
              context: context, title: group.attributes.name),
        ),
        actions: [
          ElevatedButton.icon(
            style: Styles.buttonStyle(
              backgroundColor:
                  isBlacklisted ? Colors.green.shade900 : Colors.red.shade900,
            ),
            onPressed: () {
              if (isBlacklisted) {
                cfg.value = settings.copyWith(
                    groupBlacklist: settings.groupBlacklist
                        .where((element) => element != group.id)
                        .toSet());
              } else {
                cfg.value = settings.copyWith(
                    groupBlacklist: {...settings.groupBlacklist, group.id});
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
