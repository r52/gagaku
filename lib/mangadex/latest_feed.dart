import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'latest_feed.g.dart';

@Riverpod(retry: noRetry)
Future<List<ChapterFeedItemData>> _fetchGlobalChapters(Ref ref) async {
  final me = await ref.watch(loggedUserProvider.future);
  final api = ref.watch(mangadexProvider);

  final chapters = await ref.watch(latestGlobalFeedProvider.future);

  final mangaIds = chapters.map((e) => e.manga.id).toSet();
  final mangas = await api.fetchManga(
    ids: mangaIds,
    limit: MangaDexEndpoints.breakLimit,
  );

  await ref.read(statisticsProvider.get)(mangas);
  await ref.read(readChaptersProvider(me?.id).get)(mangas);

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

@RoutePage()
class MangaDexGlobalFeedPage extends HookConsumerWidget {
  const MangaDexGlobalFeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();
    final getNextPage = ref.watch(latestGlobalFeedProvider.getNextPage);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            controller.animateTo(
              0.0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCirc,
            );
          },
          child: TitleFlexBar(
            title: 'mangadex.latestUpdates'.tr(context: context),
          ),
        ),
        leading: AutoLeadingButton(),
      ),
      body: ChapterFeedWidget(
        provider: _fetchGlobalChaptersProvider,
        onAtEdge: () {
          if (getNextPage.state is! PendingMutationState) {
            getNextPage();
          }
        },
        onRefresh: () async {
          ref.invalidate(latestGlobalFeedProvider);
          return ref.refresh(_fetchGlobalChaptersProvider.future);
        },
        controller: controller,
        restorationId: 'global_list_offset',
        isLoading: getNextPage.state is PendingMutationState,
      ),
    );
  }
}
