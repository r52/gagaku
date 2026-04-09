import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexHistoryFeedPage extends StatefulHookConsumerWidget {
  const MangaDexHistoryFeedPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  ConsumerState<MangaDexHistoryFeedPage> createState() =>
      _MangaDexHistoryFeedState();
}

class _MangaDexHistoryFeedState extends ConsumerState<MangaDexHistoryFeedPage> {
  final Map<String, Manga> _mangaCache = {};

  late final _pagingController = PagingController<int, Chapter>(
    getNextPageKey: (state) => state.keys?.last != null ? null : 0,
    fetchPage: (pageKey) async {
      final me = await ref.watch(loggedUserProvider.future);
      final api = ref.watch(mangadexProvider);

      final chapters = await ref.watch(mangaDexHistoryProvider.future);

      final mangaIds = chapters.map((e) => e.manga.id).toSet();
      final mangas = await api.fetchMangaById(
        ids: mangaIds,
        limit: MangaDexEndpoints.breakLimit,
      );

      for (final m in mangas) {
        _mangaCache[m.id] = m;
      }

      try {
        await (
          ref.run((tsx) async {
            return await tsx.get(statisticsProvider.notifier).get(mangas);
          }),
          ref.run((tsx) async {
            return await tsx
                .get(readChaptersProvider(me?.id).notifier)
                .get(mangas);
          }),
          ref.run((tsx) async {
            return await tsx.get(chapterStatsProvider.notifier).get(chapters);
          }),
        ).wait;
      } catch (e) {
        logger.e(e, error: e);
      }

      return chapters.toList();
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
    final scrollController =
        DefaultScrollController.maybeOf(context) ??
        widget.controller ??
        useScrollController();

    return ChapterFeedWidget(
      controller: _pagingController,
      mangaCache: _mangaCache,
      onRefresh: () async {
        _mangaCache.clear();
        ref.invalidate(mangaDexHistoryProvider);
        _pagingController.refresh();
      },
      title: t.mangadex.localHistory,
      scrollController: scrollController,
      restorationId: 'history_list_offset',
      leading: [
        MangaDexSliverAppBar(
          title: t.history.text,
          controller: scrollController,
        ),
      ],
    );
  }
}
