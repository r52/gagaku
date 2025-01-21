import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_feed.g.dart';

@Riverpod(retry: noRetry)
Future<List<ChapterFeedItemData>> _fetchHistoryFeed(Ref ref) async {
  final me = await ref.watch(loggedUserProvider.future);
  final api = ref.watch(mangadexProvider);

  final chapters = await ref.watch(mangaDexHistoryProvider.future);

  final mangaIds = chapters.map((e) => e.manga.id).toSet();
  final mangas = await api.fetchManga(ids: mangaIds, limit: MangaDexEndpoints.breakLimit);

  await ref.read(statisticsProvider.get)(mangas);
  await ref.read(readChaptersProvider(me?.id).get)(mangas);

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
    final scrollController = DefaultScrollController.maybeOf(context) ?? controller;
    return ChapterFeedWidget(
      provider: _fetchHistoryFeedProvider,
      title: 'mangadex.localHistory'.tr(context: context),
      emptyText: 'mangadex.noHistoryMsg'.tr(context: context),
      onRefresh: () async => ref.refresh(mangaDexHistoryProvider.future),
      controller: scrollController,
      restorationId: 'history_list_offset',
      leading: [
        MangaDexSliverAppBar(
          title: 'history.text'.tr(context: context),
          controller: scrollController,
        ),
      ],
    );
  }
}
