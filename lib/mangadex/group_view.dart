import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/detail_scaffold.dart';
import 'package:gagaku/util/material_hooks.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_view.g.dart';

enum _ViewType { feed, titles }

@Riverpod(retry: noRetry)
Future<Group> _fetchGroupFromId(Ref ref, String groupId) async {
  final api = ref.watch(mangadexProvider);
  final group = await api.fetchGroups([groupId]);
  return group.first;
}

class MangaDexGroupViewPage extends StatelessWidget {
  const MangaDexGroupViewPage({super.key, required this.groupId, this.group});

  final String groupId;
  final Group? group;

  @override
  Widget build(BuildContext context) {
    if (group != null) {
      return MangaDexGroupViewWidget(group: group!);
    }

    return DataProviderWhenWidget(
      provider: _fetchGroupFromIdProvider(groupId),
      loadingBuilder: (context, progress) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: Center(
          child: CircularProgressIndicator(value: progress?.toDouble()),
        ),
      ),
      errorBuilder: (context, child, _, _) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: child,
      ),
      builder: (context, data) {
        return MangaDexGroupViewWidget(group: data);
      },
    );
  }
}

class MangaDexGroupViewWidget extends StatefulHookConsumerWidget {
  const MangaDexGroupViewWidget({super.key, required this.group});

  final Group group;

  @override
  ConsumerState<MangaDexGroupViewWidget> createState() =>
      _MangaDexGroupViewWidgetState();
}

class _MangaDexGroupViewWidgetState
    extends ConsumerState<MangaDexGroupViewWidget> {
  late final _feed = ChapterFeedPager(
    ref: ref,
    feedKey: MangaDexFeeds.groupFeed.key,
    limit: MangaDexFeeds.groupFeed.limit,
    path: MangaDexFeeds.groupFeed.path!,
    entity: widget.group,
  );

  late final _titles = EntityTitlesPager(
    ref: ref,
    info: MangaDexFeeds.groupTitles,
    entity: widget.group,
  );

  @override
  void dispose() {
    _feed.dispose();
    _titles.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final tabController = useMaterialTabController(
      initialLength: _ViewType.values.length,
    );
    final scrollController = useScrollController();

    return DetailScaffold(
      title: widget.group.attributes.name,
      actions: _GroupBlockButton(group: widget.group),
      metadata: _GroupInfo(group: widget.group),
      tabController: tabController,
      tabs: [
        DetailTab(
          label: t.feed,
          scrollToTop: true,
          body: ChapterFeedWidget(
            controller: _feed.controller,
            mangaCache: _feed.mangaCache,
            restorationId: 'group_feed_offset',
          ),
        ),
        DetailTab(
          label: t.titles,
          scrollToTop: true,
          body: MangaListWidget(
            physics: const AlwaysScrollableScrollPhysics(),
            noController: true,
            children: [MangaListViewSliver(controller: _titles.controller)],
          ),
        ),
      ],
      onRefresh: () => switch (_ViewType.values[tabController.index]) {
        _ViewType.feed => _feed.refresh(),
        _ViewType.titles => _titles.refresh(),
      },
      scrollController: scrollController,
    );
  }
}

class _GroupBlockButton extends ConsumerWidget {
  const _GroupBlockButton({required this.group});

  final Group group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final settings = ref.watch(mdConfigProvider);
    final isBlacklisted = settings.groupBlacklist.contains(group.id);

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8.0),
      child: ElevatedButton.icon(
        style: Styles.buttonStyle(
          backgroundColor: isBlacklisted
              ? Colors.green.shade900
              : Colors.red.shade900,
        ),
        onPressed: () {
          final cfg = settings.copyWith(
            groupBlacklist: isBlacklisted
                ? settings.groupBlacklist
                      .where((element) => element != group.id)
                      .toSet()
                : {...settings.groupBlacklist, group.id},
          );

          ref.run((tsx) async {
            return tsx.get(mdConfigProvider.notifier).save(cfg);
          });
        },
        icon: const Icon(Icons.block),
        label: Text(isBlacklisted ? t.ui.unblock : t.ui.block),
      ),
    );
  }
}

class _GroupInfo extends StatelessWidget {
  const _GroupInfo({required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final theme = Theme.of(context);
    final ScanlationGroupAttributes(:description, :website, :discord) =
        group.attributes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (description != null)
          ExpansionTile(
            initiallyExpanded: true,
            title: Text(t.mangadex.groupDesc),
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: theme.colorScheme.surfaceContainerHighest,
                child: Text(description),
              ),
            ],
          ),
        if (website != null || discord != null)
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
                    if (website != null)
                      ButtonChip(
                        onPressed: () async {
                          await Styles.tryLaunchUrl(context, website);
                        },
                        text: t.tracking.website,
                      ),
                    if (discord != null)
                      ButtonChip(
                        onPressed: () async {
                          await Styles.tryLaunchUrl(
                            context,
                            'https://discord.gg/$discord',
                          );
                        },
                        text: t.tracking.discord,
                      ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
