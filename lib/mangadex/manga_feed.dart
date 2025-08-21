import 'package:flutter/material.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/model/common.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([chipTextStyle])
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

  late final _pagingController = GagakuPagingController<int, Manga>(
    getNextPageKey: (state) =>
        state.keys?.last != null ? state.keys!.last + info.limit : 0,
    fetchPage: (pageKey) async {
      final api = ref.watch(mangadexProvider);

      final chapterlist = await api.fetchFeed(
        path: info.path!,
        feedKey: info.key,
        limit: info.limit,
        offset: pageKey,
      );

      final chapters = chapterlist.data.cast<Chapter>();

      final mangaIds = chapters.map((e) => e.manga.id).toSet();
      final mangas = await api.fetchMangaById(
        ids: mangaIds,
        limit: MangaDexEndpoints.breakLimit,
      );

      try {
        statisticsMutation.run(ref, (ref) async {
          return await ref.get(statisticsProvider.notifier).get(mangas);
        });
      } catch (e) {
        logger.e(e, error: e);
      }

      return PageResultsMetaData(mangas, chapterlist.total);
    },
    refresh: () async {
      final api = ref.watch(mangadexProvider);
      await api.invalidateAll(info.key);
    },
    getIsLastPage: (state, data) =>
        (state.keys?.last ?? 0) + info.limit >= data.total!,
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
        onRefresh: () async => _pagingController.refresh(),
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
