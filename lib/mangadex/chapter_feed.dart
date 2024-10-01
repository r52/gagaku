import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/manga_feed.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chapter_feed.g.dart';

enum _FeedViewType { chapters, manga }

@Riverpod(retry: noRetry)
Future<List<ChapterFeedItemData>> _fetchChapters(_FetchChaptersRef ref) async {
  final api = ref.watch(mangadexProvider);

  final chapters = await ref.watch(latestChaptersFeedProvider.future);

  final mangaIds = chapters.map((e) => e.manga.id).toSet();
  final mangas = await api.fetchManga(ids: mangaIds, limit: MangaDexEndpoints.breakLimit);

  await ref.read(statisticsProvider.notifier).get(mangas);
  await ref.read(readChaptersProvider.notifier).get(mangas);

  final mangaMap = Map<String, Manga>.fromIterable(mangas, key: (e) => e.id);

  // Craft feed items
  final dlist = chapters.fold(<ChapterFeedItemData>[], (list, chapter) {
    final mid = chapter.manga.id;
    if (mangaMap.containsKey(mid)) {
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

class MangaDexChapterFeed extends HookConsumerWidget {
  const MangaDexChapterFeed({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = DefaultScrollController.maybeOf(context) ?? controller;
    final view = useState(_FeedViewType.chapters);

    final leading = <Widget>[
      MangaDexSliverAppBar(
        controller: scrollController,
      ),
      SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        title: const Text(
          'Latest Updates',
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          SegmentedButton<_FeedViewType>(
            style: SegmentedButton.styleFrom(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))),
            showSelectedIcon: false,
            segments: const <ButtonSegment<_FeedViewType>>[
              ButtonSegment<_FeedViewType>(
                value: _FeedViewType.chapters,
                label: Text('By Chapter'),
              ),
              ButtonSegment<_FeedViewType>(
                value: _FeedViewType.manga,
                label: Text('By Manga'),
              ),
            ],
            selected: <_FeedViewType>{view.value},
            onSelectionChanged: (Set<_FeedViewType> newSelection) {
              view.value = newSelection.first;
            },
          ),
        ],
      )
    ];

    return switch (view.value) {
      _FeedViewType.chapters => ChapterFeedWidget(
          provider: _fetchChaptersProvider,
          emptyText: 'Find some manga to follow!',
          onAtEdge: () => ref.read(latestChaptersFeedProvider.notifier).getMore(),
          onRefresh: () async {
            ref.read(latestChaptersFeedProvider.notifier).clear();
            return ref.refresh(_fetchChaptersProvider.future);
          },
          controller: scrollController,
          restorationId: 'chapter_list_offset',
          leading: leading,
        ),
      _FeedViewType.manga => MangaDexMangaFeed(
          controller: scrollController,
          leading: leading,
        ),
    };
  }
}
