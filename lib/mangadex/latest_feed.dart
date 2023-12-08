import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'latest_feed.g.dart';

@riverpod
Future<List<ChapterFeedItemData>> _fetchGlobalChapters(
    _FetchGlobalChaptersRef ref) async {
  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(latestGlobalFeedProvider.future);

  final mangaIds = chapters.map((e) => e.getMangaID()).toSet();
  mangaIds.removeWhere((element) => element.isEmpty);

  final mangas =
      await api.fetchManga(ids: mangaIds, limit: MangaDexEndpoints.breakLimit);

  await ref.watch(statisticsProvider.notifier).get(mangas);

  final loggedin = await ref.watch(authControlProvider.future);

  if (loggedin) {
    await ref.watch(readChaptersProvider.notifier).get(mangas);
  }

  final mangaMap = Map<String, Manga>.fromIterable(mangas, key: (e) => e.id);

  // Craft feed items
  final dlist = chapters.fold(<ChapterFeedItemData>[], (list, chapter) {
    final cid = chapter.getMangaID();
    if (cid.isNotEmpty && mangaMap.containsKey(cid)) {
      ChapterFeedItemData? item;
      if (list.isNotEmpty && list.last.mangaId == cid) {
        item = list.last;
      } else {
        item = ChapterFeedItemData(manga: mangaMap[cid]!);
        list.add(item);
      }

      item.chapters.add(chapter);
    }

    return list;
  });

  ref.disposeAfter(const Duration(minutes: 5));

  return dlist;
}

class MangaDexGlobalFeed extends ConsumerWidget {
  const MangaDexGlobalFeed({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ChapterFeedWidget(
      provider: _fetchGlobalChaptersProvider,
      title: 'Latest Uploads',
      onAtEdge: () => ref.read(latestGlobalFeedProvider.notifier).getMore(),
      onRefresh: () {
        ref.read(latestGlobalFeedProvider.notifier).clear();
        return ref.refresh(_fetchGlobalChaptersProvider.future);
      },
      controller: controller,
      restorationId: 'global_list_offset',
    );
  }
}
