import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chapter_feed.g.dart';

@riverpod
Future<List<ChapterFeedItem>> _fetchChapters(_FetchChaptersRef ref) async {
  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(latestChaptersFeedProvider.future);

  final mangaIds = chapters.map((e) => e.getMangaID()).toSet();
  mangaIds.removeWhere((element) => element.isEmpty);
  await Future.delayed(const Duration(milliseconds: 100));

  final mangas = await api.fetchManga(mangaIds);
  await Future.delayed(const Duration(milliseconds: 100));

  await ref.watch(statisticsProvider.notifier).get(mangas);
  await Future.delayed(const Duration(milliseconds: 100));

  await ref.watch(readChaptersProvider.notifier).get(mangas);

  final mangaMap = Map<String, Manga>.fromIterable(mangas, key: (e) => e.id);

  // Craft feed items
  List<ChapterFeedItemData> dlist = [];

  for (final chapter in chapters) {
    final cid = chapter.getMangaID();
    ChapterFeedItemData? item;
    if (dlist.isNotEmpty && dlist.last.mangaId == cid) {
      item = dlist.last;
    } else {
      item = ChapterFeedItemData(manga: mangaMap[cid]!);
      dlist.add(item);
    }

    item.chapters.add(chapter);
  }

  // Craft widgets
  final wlist = dlist
      .map((e) => ChapterFeedItem(
            state: e,
          ))
      .toList();

  ref.keepAlive();

  return wlist;
}

class MangaDexChapterFeed extends ConsumerWidget {
  const MangaDexChapterFeed({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ChapterFeedWidget(
      provider: _fetchChaptersProvider,
      title: 'Latest Chapters',
      emptyText: 'Find some manga to follow!',
      onAtEdge: () {
        ref.read(latestChaptersFeedProvider.notifier).getMore();
      },
      onRefresh: () async {
        ref.read(latestChaptersFeedProvider.notifier).clear();
        return await ref.refresh(_fetchChaptersProvider.future);
      },
      controller: controller,
      restorationId: 'chapter_list_offset',
    );
  }
}
