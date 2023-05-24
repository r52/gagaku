import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'latest_feed.g.dart';

@riverpod
Future<List<ChapterFeedItem>> _fetchGlobalChapters(
    _FetchGlobalChaptersRef ref) async {
  final api = ref.watch(mangadexProvider);
  final loggedin = await ref.watch(authControlProvider.future);

  final chapters = await ref.watch(latestGlobalFeedProvider.future);

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

  // Craft widgets
  final wlist = dlist
      .map((e) => ChapterFeedItem(
            state: e,
          ))
      .toList();

  ref.keepAlive();

  return wlist;
}

class MangaDexGlobalFeed extends StatelessWidget {
  const MangaDexGlobalFeed({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return ChapterFeedWidget(
      provider: _fetchGlobalChaptersProvider,
      title: 'Latest Uploads',
      controller: controller,
      restorationId: 'global_list_offset',
    );
  }
}
