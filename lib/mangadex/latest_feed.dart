import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'latest_feed.g.dart';

Page<dynamic> buildLatestFeedPage(BuildContext context, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: const MangaDexGlobalFeed(),
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@Riverpod(retry: noRetry)
Future<List<ChapterFeedItemData>> _fetchGlobalChapters(_FetchGlobalChaptersRef ref) async {
  final api = ref.watch(mangadexProvider);

  final chapters = await ref.watch(latestGlobalFeedProvider.future);

  final mangaIds = chapters.map((e) => e.manga.id).toSet();
  final mangas = await api.fetchManga(ids: mangaIds, limit: MangaDexEndpoints.breakLimit);

  await ref.read(statisticsProvider.notifier).get(mangas);

  final loggedin = await ref.watch(authControlProvider.future);

  if (loggedin) {
    await ref.read(readChaptersProvider.notifier).get(mangas);
  }

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

class MangaDexGlobalFeed extends HookConsumerWidget {
  const MangaDexGlobalFeed({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrler = controller ?? useScrollController();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            ctrler.animateTo(0.0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
          },
          child: const TitleFlexBar(title: 'Latest Uploads'),
        ),
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: ChapterFeedWidget(
        provider: _fetchGlobalChaptersProvider,
        //title: 'Latest Uploads',
        onAtEdge: () => ref.read(latestGlobalFeedProvider.notifier).getMore(),
        onRefresh: () async {
          ref.read(latestGlobalFeedProvider.notifier).clear();
          return ref.refresh(_fetchGlobalChaptersProvider.future);
        },
        controller: ctrler,
        restorationId: 'global_list_offset',
      ),
    );
  }
}
