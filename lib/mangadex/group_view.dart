import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'group_view.g.dart';

enum _ViewType { info, feed, titles }

Route createGroupViewRoute(Group group) {
  return Styles.buildSharedAxisTransitionRoute(
    (context, animation, secondaryAnimation) => MangaDexGroupViewWidget(
      group: group,
    ),
    SharedAxisTransitionType.scaled,
  );
}

@riverpod
Future<List<ChapterFeedItemData>> _fetchGroupFeed(
    _FetchGroupFeedRef ref, Group group) async {
  final loggedin = await ref.watch(authControlProvider.future);

  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(groupFeedProvider(group).future);

  final mangaIds = chapters.map((e) => e.getMangaID()).toSet();
  mangaIds.removeWhere((element) => element.isEmpty);

  final mangas = await api.fetchManga(ids: mangaIds);

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

class MangaDexGroupViewWidget extends HookWidget {
  const MangaDexGroupViewWidget({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final view = useState(_ViewType.info);

    const bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.info),
        label: 'Info',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.feed),
        label: 'Group Feed',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.menu_book),
        label: 'Group Titles',
      ),
    ];

    final controllers = [
      useScrollController(),
      useScrollController(),
      useScrollController(),
    ];

    final tabs = <Widget>[
      CustomScrollView(
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
      Consumer(
        builder: (context, ref, child) {
          return ChapterFeedWidget(
            provider: _fetchGroupFeedProvider(group),
            title: 'Group Feed',
            emptyText: 'No chapters!',
            onAtEdge: () {
              ref.read(groupFeedProvider(group).notifier).getMore();
            },
            onRefresh: () async {
              ref.read(groupFeedProvider(group).notifier).clear();
              return await ref.refresh(_fetchGroupFeedProvider(group).future);
            },
            controller: controllers[1],
            restorationId: 'group_feed_offset',
          );
        },
      ),
      Consumer(
        builder: (context, ref, child) {
          final mangas = ref.watch(_fetchGroupTitlesProvider(group));
          final isLoading = ref.watch(groupTitlesProvider(group)).isLoading;

          return Stack(
            children: [
              switch (mangas) {
                AsyncValue(:final error?, :final stackTrace?) => () {
                    final messenger = ScaffoldMessenger.of(context);
                    Styles.showErrorSnackBar(messenger, '$error');
                    logger.e("_fetchGroupTitlesProvider(group) failed",
                        error: error, stackTrace: stackTrace);

                    return RefreshIndicator(
                      onRefresh: () async {
                        ref.invalidate(groupTitlesProvider(group));
                        return await ref
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
                      onRefresh: () async {
                        ref.read(groupTitlesProvider(group).notifier).clear();
                        return await ref
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
    ];

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            controllers[view.value.index].animateTo(0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          },
          child: Styles.titleFlexBar(
              context: context, title: group.attributes.name),
        ),
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
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        items: bottomNavigationBarItems,
        currentIndex: view.value.index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: theme.colorScheme.primary,
        onTap: (index) {
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
