import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'group_view.g.dart';

enum _ViewType { info, feed, titles }

@Riverpod(retry: noRetry)
Future<Group> _fetchGroupFromId(Ref ref, String groupId) async {
  final api = ref.watch(mangadexProvider);
  final group = await api.fetchGroups([groupId]);
  return group.first;
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
      errorBuilder: (context, child, _, _) => Scaffold(body: child),
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
    final t = context.t;
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

    final groupFeedInfo = MangaDexFeeds.groupFeed;

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
                  title: Text(t.mangadex.groupDesc),
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
                  title: Text(t.tracking.links),
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
                              text: t.tracking.website,
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
                              text: t.tracking.discord,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              if (group.attributes.description == null &&
                  group.attributes.website == null &&
                  group.attributes.discord == null)
                Center(child: Text(t.tracking.nothing)),
            ],
          ),
        ],
      ),
      _ViewType.feed => InfiniteScrollChapterFeedWidget(
        key: const Key('/group?tab=feed'),
        feedKey: groupFeedInfo.key,
        limit: groupFeedInfo.limit,
        path: groupFeedInfo.path!,
        entity: group,
        scrollController: controllers[1],
        restorationId: 'group_feed_offset',
      ),
      _ViewType.titles => _GroupTitlesTab(
        key: const Key('/group?tab=titles'),
        group: group,
        controller: controllers[2],
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
            label: Text(isBlacklisted ? t.ui.unblock : t.ui.block),
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

class _GroupTitlesTab extends ConsumerStatefulWidget {
  const _GroupTitlesTab({
    super.key,
    required this.group,
    required this.controller,
  });

  final Group group;
  final ScrollController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __GroupTitlesTabState();
}

class __GroupTitlesTabState extends ConsumerState<_GroupTitlesTab> {
  static const info = MangaDexFeeds.groupTitles;

  late final _pagingController = GagakuPagingController<int, Manga>(
    getNextPageKey:
        (state) => state.keys?.last != null ? state.keys!.last + info.limit : 0,
    fetchPage: (pageKey) async {
      final api = ref.watch(mangadexProvider);
      final list = await api.fetchMangaList(
        limit: info.limit,
        feedKey: info.key,
        offset: pageKey,
        entity: widget.group,
      );

      final newItems = list.data.cast<Manga>();

      await ref.read(statisticsProvider.get)(newItems);

      return PageResultsMetaData(newItems, list.total);
    },
    refresh: () async {
      final api = ref.watch(mangadexProvider);
      await api.invalidateAll('${info.key}(${widget.group.id}');
    },
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return RefreshIndicator(
      onRefresh: () async => _pagingController.refresh(),
      child: MangaListWidget(
        title: Text(t.mangadex.groupTitles, style: TextStyle(fontSize: 24)),
        physics: const AlwaysScrollableScrollPhysics(),
        controller: widget.controller,
        children: [MangaListViewSliver(controller: _pagingController)],
      ),
    );
  }
}
