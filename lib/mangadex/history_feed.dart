import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_feed.g.dart';

@riverpod
Future<List<ChapterFeedItemData>> _fetchHistoryFeed(_FetchHistoryFeedRef ref) async {
  final api = ref.watch(mangadexProvider);
  final loggedin = await ref.watch(authControlProvider.future);

  final chapters = await ref.watch(mangaDexHistoryProvider.future);

  final mangaIds = chapters.map((e) => e.manga.id).toSet();

  final mangas = await api.fetchManga(ids: mangaIds, limit: MangaDexEndpoints.breakLimit);

  await ref.read(statisticsProvider.notifier).get(mangas);

  if (loggedin) {
    await ref.read(readChaptersProvider.notifier).get(mangas);
  }

  final mangaMap = Map<String, Manga>.fromIterable(mangas, key: (e) => e.id);

  // Craft feed items
  final dlist = chapters.fold(<ChapterFeedItemData>[], (list, chapter) {
    final mid = chapter.manga.id;
    if (mid.isNotEmpty && mangaMap.containsKey(mid)) {
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
      onRefresh: () async => ref.refresh(mangaDexHistoryProvider.future),
      controller: controller,
      restorationId: 'history_list_offset',
      leading: [
        MangaDexSliverAppBar(
          controller: controller,
        ),
      ],
    );
  }
}
