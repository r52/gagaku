import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexMangaFeed extends ConsumerStatefulWidget {
  const MangaDexMangaFeed({
    super.key,
    this.controller,
    this.leading = const [],
  });

  final ScrollController? controller;
  final List<Widget> leading;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MangaDexMangaFeedState();
}

class _MangaDexMangaFeedState extends ConsumerState<MangaDexMangaFeed> {
  static const info = MangaDexFeeds.latestChapters;

  late final _pagingManager = OffsetPagingManager<Manga>(limit: info.limit);

  late final _pagingController = PagingController<int, Manga>(
    getNextPageKey: _pagingManager.getNextPageKey,
    fetchPage: (pageKey) async {
      final api = ref.watch(mangadexProvider);

      final chapterlist = await api.fetchFeed(
        path: info.path!,
        feedKey: info.key,
        limit: info.limit,
        offset: pageKey,
      );

      _pagingManager.totalItems = chapterlist.total;

      final chapters = chapterlist.data.cast<Chapter>();

      final mangaIds = chapters.map((e) => e.manga.id).toSet();
      final mangas = await api.fetchMangaById(
        ids: mangaIds,
        limit: MangaDexEndpoints.breakLimit,
      );

      try {
        ref.run((tsx) async {
          return await tsx.get(statisticsProvider.notifier).get(mangas);
        });
      } catch (e) {
        logger.e(e, error: e);
      }

      return mangas;
    },
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          _pagingManager.reset();
          final api = ref.watch(mangadexProvider);
          await api.invalidateAll(info.key);
          return _pagingController.refresh();
        },
        child: MangaListWidget(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: widget.controller,
          leading: widget.leading,
          children: [MangaListViewSliver(controller: _pagingController)],
        ),
      ),
    );
  }
}
