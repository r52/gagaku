import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_feed.g.dart';

@riverpod
Future<List<ChapterFeedItemData>> _fetchHistoryFeed(
    _FetchHistoryFeedRef ref) async {
  final api = ref.watch(mangadexProvider);
  final loggedin = await ref.watch(authControlProvider.future);

  final chapters = await ref.watch(mangaDexHistoryProvider.future);

  final mangaIds = chapters.map((e) => e.getMangaID()).toSet();
  mangaIds.removeWhere((element) => element.isEmpty);
  await Future.delayed(const Duration(milliseconds: 100));

  final mangas = await api.fetchManga(mangaIds);
  await Future.delayed(const Duration(milliseconds: 100));

  await ref.watch(statisticsProvider.notifier).get(mangas);
  await Future.delayed(const Duration(milliseconds: 100));

  if (loggedin) {
    await ref.watch(readChaptersProvider.notifier).get(mangas);
  }

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

  ref.keepAlive();

  return dlist;
}

class MangaDexHistoryFeed extends ConsumerWidget {
  const MangaDexHistoryFeed({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ChapterFeedWidget(
      provider: _fetchHistoryFeedProvider,
      title: 'Reading History (local)',
      emptyText: 'No reading history!',
      onRefresh: () async {
        return await ref.refresh(mangaDexHistoryProvider.future);
      },
      controller: controller,
      restorationId: 'history_list_offset',
    );
  }
}
