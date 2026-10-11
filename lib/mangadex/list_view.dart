import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/util/detail_scaffold.dart';
import 'package:gagaku/util/material_hooks.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';

enum _ViewType { titles, feed }

class MangaDexListViewPage extends ConsumerWidget {
  const MangaDexListViewPage({super.key, required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final listProvider = ref.watch(listSourceProvider(listId));

    return switch (listProvider) {
      AsyncValue(:final error?, :final stackTrace?) => Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            await ref.read(mangadexProvider).invalidateCacheItem(listId);
            return ref.refresh(listSourceProvider(listId).future);
          },
          child: ErrorList(
            error: error,
            stackTrace: stackTrace,
            message: "_fetchListFromIdProvider($listId) failed",
          ),
        ),
      ),
      AsyncValue(hasValue: true, value: final list) when list != null =>
        _MangaDexListView(list: list),
      AsyncValue(hasValue: true) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(t.mangadex.listNotExistError(id: listId))),
      ),
      AsyncValue(:final progress) => Scaffold(
        body: ListSpinner(progress: progress?.toDouble()),
      ),
    };
  }
}

class _MangaDexListView extends StatefulHookConsumerWidget {
  const _MangaDexListView({required this.list});

  final CustomList list;

  @override
  ConsumerState<_MangaDexListView> createState() => _MangaDexListViewState();
}

class _MangaDexListViewState extends ConsumerState<_MangaDexListView> {
  static const _feedInfo = MangaDexFeeds.customListFeed;

  late final _feed = ChapterFeedPager(
    ref: ref,
    feedKey: _feedInfo.key,
    limit: _feedInfo.limit,
    path: _feedInfo.path!.replaceFirst('{id}', widget.list.id),
    entity: widget.list,
  );

  @override
  void dispose() {
    _feed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final list = widget.list;
    final tabController = useMaterialTabController(
      initialLength: _ViewType.values.length,
    );
    final scrollController = useScrollController();
    final titlesRefresh = useState(Object());

    return DetailScaffold(
      title: list.attributes.name,
      actions: _ListActions(list: list),
      metadata: _ListInfo(list: list),
      tabController: tabController,
      tabs: [
        DetailTab(
          label: t.titles,
          scrollToTop: true,
          body: _ListTitlesTab(list: list, refreshKey: titlesRefresh.value),
        ),
        DetailTab(
          label: t.feed,
          scrollToTop: true,
          body: ChapterFeedWidget(
            controller: _feed.controller,
            mangaCache: _feed.mangaCache,
            restorationId: 'list_feed_offset',
          ),
        ),
      ],
      onRefresh: () async {
        switch (_ViewType.values[tabController.index]) {
          case _ViewType.titles:
            await ref.read(mangadexProvider).invalidateCacheItem(list.id);
            titlesRefresh.value = Object();
            return ref.refresh(listSourceProvider(list.id).future);
          case _ViewType.feed:
            return _feed.refresh();
        }
      },
      scrollController: scrollController,
    );
  }
}

class _ListTitlesTab extends HookConsumerWidget {
  const _ListTitlesTab({required this.list, required this.refreshKey});

  final CustomList list;

  /// Changing this refetches the current page.
  final Object refreshKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final page = useState(0);
    final future = useMangaListFetcher(ref, list.set, page.value, [refreshKey]);

    return Column(
      children: [
        Expanded(
          child: MangaListWidget(
            title: Text(
              '${t.titles} (${list.set.length})',
              style: CommonTextStyles.twentyfour,
            ),
            physics: const AlwaysScrollableScrollPhysics(),
            noController: true,
            future: future,
            children: [
              if (future.hasData) MangaListViewSliver(items: future.data),
            ],
          ),
        ),
        NumberPaginator(
          numberPages: max(
            (list.set.length / MangaDexEndpoints.searchLimit).ceil(),
            1,
          ),
          onPageChange: (int index) {
            final controller = PrimaryScrollController.maybeOf(context);
            if (controller != null && controller.hasClients) {
              controller.jumpTo(0.0);
            }
            page.value = index;
          },
        ),
      ],
    );
  }
}

class _ListInfo extends StatelessWidget {
  const _ListInfo({required this.list});

  final CustomList list;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final visibility = list.attributes.visibility;
    final username = list.user?.attributes?.username;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          if (username != null)
            Chip(avatar: const Icon(Icons.person), label: Text(username)),
          Chip(
            avatar: Icon(
              Icons.circle,
              size: 16.0,
              color: visibility == CustomListVisibility.private
                  ? Colors.red
                  : Colors.green,
            ),
            label: Text(t[visibility.label]),
          ),
        ],
      ),
    );
  }
}

class _ListActions extends ConsumerWidget {
  const _ListActions({required this.list});

  final CustomList list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final theme = Theme.of(context);
    final me = ref.watch(loggedUserProvider).value;
    final followedLists = ref.watch(followedListsProvider(me?.id)).value;
    final idx = followedLists?.indexWhere((e) => e.id == list.id);

    return OverflowBar(
      spacing: 8.0,
      children: [
        if (idx != null)
          IconButton(
            style: Styles.squareIconButtonStyle(
              backgroundColor: theme.colorScheme.surfaceContainer,
            ),
            onPressed: () => ref.run((tsx) async {
              return await tsx
                  .get(customListCommandsProvider(me?.id))
                  .setFollow(tsx, list, idx == -1);
            }),
            icon: Icon(
              idx == -1 ? Icons.bookmark_border : Icons.bookmark,
              color: idx == -1 ? null : theme.colorScheme.primary,
            ),
            tooltip: idx == -1 ? t.ui.follow : t.ui.unfollow,
          ),
        if (list.user != null && me != null && list.user!.id == me.id)
          IconButton(
            style: Styles.squareIconButtonStyle(
              backgroundColor: theme.colorScheme.surfaceContainer,
            ),
            onPressed: () {
              MangaDexEditListRoute(listId: list.id, list: list).push(context);
            },
            icon: const Icon(Icons.edit),
            tooltip: t.ui.edit,
          ),
        const SizedBox.shrink(),
      ],
    );
  }
}
