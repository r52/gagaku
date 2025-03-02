import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'group_view.g.dart';

enum _ViewType { info, feed, titles }

@riverpod
Future<Group> _fetchGroupFromId(Ref ref, String groupId) async {
  final api = ref.watch(mangadexProvider);
  final group = await api.fetchGroups([groupId]);
  return group.first;
}

@Riverpod(retry: noRetry)
Future<List<ChapterFeedItemData>> _fetchGroupFeed(Ref ref, Group group) async {
  final me = await ref.watch(loggedUserProvider.future);
  final api = ref.watch(mangadexProvider);

  final chapters = await ref.watch(groupFeedProvider(group).future);

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

@Riverpod(retry: noRetry)
Future<List<Manga>> _fetchGroupTitles(Ref ref, Group group) async {
  final mangas = await ref.watch(groupTitlesProvider(group).future);
  await ref.read(statisticsProvider.get)(mangas);

  ref.disposeAfter(const Duration(minutes: 5));

  return mangas;
}

@RoutePage()
class MangaDexGroupViewWithNamePage extends MangaDexGroupViewPage {
  const MangaDexGroupViewWithNamePage({
    super.key,
    @PathParam() required super.groupId,
    @PathParam() this.name,
  });

  final String? name;
}

@RoutePage()
class MangaDexGroupViewPage extends StatelessWidget {
  const MangaDexGroupViewPage({
    super.key,
    @PathParam() required this.groupId,
    this.group,
  });

  final String groupId;

  final Group? group;

  @override
  Widget build(BuildContext context) {
    if (group != null) {
      return MangaDexGroupViewWidget(group: group!);
    }

    return DataProviderWhenWidget(
      provider: _fetchGroupFromIdProvider(groupId),
      errorBuilder: (context, child) => Scaffold(body: child),
      builder: (context, data) {
        return MangaDexGroupViewWidget(group: data);
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
      NavigationDestination(icon: Icon(Icons.info), label: 'Info'),
      NavigationDestination(icon: Icon(Icons.feed), label: 'Group Feed'),
      NavigationDestination(icon: Icon(Icons.menu_book), label: 'Group Titles'),
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
          SliverList.list(
            children: [
              if (group.attributes.description != null)
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text('mangadex.groupDesc'.tr(context: context)),
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Text(group.attributes.description!),
                    ),
                  ],
                ),
              if (group.attributes.website != null ||
                  group.attributes.discord != null)
                ExpansionTile(
                  initiallyExpanded: true,
                  expandedAlignment: Alignment.centerLeft,
                  title: Text('tracking.links'.tr(context: context)),
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
                                if (!await launchUrl(
                                  Uri.parse(group.attributes.website!),
                                )) {
                                  throw 'Could not launch ${group.attributes.website!}';
                                }
                              },
                              text: 'tracking.website'.tr(context: context),
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
                              text: 'tracking.discord'.tr(context: context),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              if (group.attributes.description == null &&
                  group.attributes.website == null &&
                  group.attributes.discord == null)
                Center(child: Text('tracking.nothing'.tr(context: context))),
            ],
          ),
        ],
      ),
      _ViewType.feed => Consumer(
        key: const Key('/group?tab=feed'),
        builder: (context, ref, child) {
          final getNextPage = ref.watch(groupFeedProvider(group).getNextPage);

          return ChapterFeedWidget(
            provider: _fetchGroupFeedProvider(group),
            title: 'mangadex.groupFeed'.tr(context: context),
            emptyText: 'mangaView.noChaptersMsg'.tr(context: context),
            onAtEdge: () {
              if (getNextPage.state is! PendingMutationState) {
                getNextPage();
              }
            },
            onRefresh: () async {
              ref.invalidate(groupFeedProvider(group));
              return ref.refresh(_fetchGroupFeedProvider(group).future);
            },
            controller: controllers[1],
            restorationId: 'group_feed_offset',
            isLoading: getNextPage.state is PendingMutationState,
          );
        },
      ),
      _ViewType.titles => Consumer(
        key: const Key('/group?tab=titles'),
        builder: (context, ref, child) {
          final titleProvider = ref.watch(_fetchGroupTitlesProvider(group));
          final getNextPage = ref.watch(groupTitlesProvider(group).getNextPage);
          final isLoading =
              getNextPage.state is PendingMutationState ||
              (titleProvider.isLoading && !titleProvider.isRefreshing);

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(groupTitlesProvider(group));
              return ref.refresh(_fetchGroupTitlesProvider(group).future);
            },
            child: DataProviderWhenWidget(
              provider: _fetchGroupTitlesProvider(group),
              initialData: titleProvider,
              builder:
                  (context, mangas) => MangaListWidget(
                    title: Text(
                      'mangadex.groupTitles'.tr(context: context),
                      style: TextStyle(fontSize: 24),
                    ),
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: controllers[2],
                    onAtEdge: () {
                      if (getNextPage.state is! PendingMutationState) {
                        getNextPage();
                      }
                    },
                    isLoading: isLoading,
                    children: [
                      if (mangas.isEmpty)
                        SliverToBoxAdapter(
                          child: Center(
                            child: Text('errors.notitles'.tr(context: context)),
                          ),
                        ),
                      MangaListViewSliver(items: mangas),
                    ],
                  ),
              loadingBuilder:
                  (_, progress) =>
                      LoadingOverlayStack(progress: progress?.toDouble()),
            ),
          );
        },
      ),
    };

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
          child: TitleFlexBar(title: group.attributes.name),
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
                  groupBlacklist:
                      settings.groupBlacklist
                          .where((element) => element != group.id)
                          .toSet(),
                );
              } else {
                cfg.value = settings.copyWith(
                  groupBlacklist: {...settings.groupBlacklist, group.id},
                );
              }

              ref.read(mdConfigProvider.save)(cfg.value);
            },
            icon: const Icon(Icons.block),
            label: Text(
              isBlacklisted
                  ? 'ui.unblock'.tr(context: context)
                  : 'ui.block'.tr(context: context),
            ),
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
  }
}
