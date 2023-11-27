import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/manga_feed.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chapter_feed.g.dart';

enum _FeedViewType { chapters, manga }

@riverpod
Future<List<ChapterFeedItemData>> _fetchChapters(_FetchChaptersRef ref) async {
  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(latestChaptersFeedProvider.future);

  final mangaIds = chapters.map((e) => e.getMangaID()).toSet();
  mangaIds.removeWhere((element) => element.isEmpty);

  final mangas =
      await api.fetchManga(ids: mangaIds, limit: MangaDexEndpoints.breakLimit);

  await ref.watch(statisticsProvider.notifier).get(mangas);
  await ref.watch(readChaptersProvider.notifier).get(mangas);

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

class MangaDexChapterFeed extends HookConsumerWidget {
  const MangaDexChapterFeed({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = useState(_FeedViewType.chapters);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Row(
            children: [
              const Text(
                'Latest Updates',
                style: TextStyle(fontSize: 24),
              ),
              const Spacer(),
              ToggleButtons(
                isSelected: List<bool>.generate(
                    2, (index) => view.value.index == index),
                onPressed: (index) {
                  view.value = _FeedViewType.values.elementAt(index);
                },
                borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text('By Chapter'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text('By Manga'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: switch (view.value) {
            _FeedViewType.chapters => ChapterFeedWidget(
                provider: _fetchChaptersProvider,
                emptyText: 'Find some manga to follow!',
                onAtEdge: () =>
                    ref.read(latestChaptersFeedProvider.notifier).getMore(),
                onRefresh: () {
                  ref.read(latestChaptersFeedProvider.notifier).clear();
                  return ref.refresh(_fetchChaptersProvider.future);
                },
                controller: controller,
                restorationId: 'chapter_list_offset',
              ),
            _FeedViewType.manga => MangaDexMangaFeed(
                controller: controller,
              ),
          },
        )
      ],
    );
  }
}
