import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/login_password.dart';
import 'package:gagaku/mangadex/manga_feed.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chapter_feed.g.dart';

enum _FeedViewType { chapters, manga }

@Riverpod(retry: noRetry)
Future<List<ChapterFeedItemData>> _fetchChapters(Ref ref) async {
  final me = await ref.watch(loggedUserProvider.future);
  final api = ref.watch(mangadexProvider);

  final chapters = await ref.watch(latestChaptersFeedProvider(me?.id).future);

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
class MangaDexChapterFeedPage extends StatelessWidget {
  const MangaDexChapterFeedPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return MangaDexLoginWidget(
      builder: (context) => MangaDexChapterFeedWidget(),
    );
  }
}

class MangaDexChapterFeedWidget extends HookWidget {
  const MangaDexChapterFeedWidget({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final scrollController =
        DefaultScrollController.maybeOf(context) ??
        controller ??
        useScrollController();
    final view = useState(_FeedViewType.chapters);

    final leading = <Widget>[
      MangaDexSliverAppBar(
        title: 'mangadex.myFeed'.tr(context: context),
        controller: scrollController,
      ),
      SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        title: Text(
          'mangadex.updates'.tr(context: context),
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          SegmentedButton<_FeedViewType>(
            style: SegmentedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
            showSelectedIcon: false,
            segments: <ButtonSegment<_FeedViewType>>[
              ButtonSegment<_FeedViewType>(
                value: _FeedViewType.chapters,
                label: Text('mangadex.byChapter'.tr(context: context)),
              ),
              ButtonSegment<_FeedViewType>(
                value: _FeedViewType.manga,
                label: Text('mangadex.byManga'.tr(context: context)),
              ),
            ],
            selected: <_FeedViewType>{view.value},
            onSelectionChanged: (Set<_FeedViewType> newSelection) {
              view.value = newSelection.first;
            },
          ),
        ],
      ),
    ];

    return switch (view.value) {
      _FeedViewType.chapters => Consumer(
        builder: (context, ref, child) {
          final me = ref.watch(loggedUserProvider).value;
          final getNextPage = ref.watch(
            latestChaptersFeedProvider(me?.id).getNextPage,
          );

          return ChapterFeedWidget(
            key: ValueKey('ChapterFeedWidget(${me?.id})'),
            provider: _fetchChaptersProvider,
            emptyText: 'mangadex.noFollowsMsg'.tr(context: context),
            onAtEdge: () {
              if (getNextPage.state is! PendingMutationState) {
                getNextPage();
              }
            },
            onRefresh: () async {
              ref.invalidate(latestChaptersFeedProvider(me?.id));
              return ref.refresh(_fetchChaptersProvider.future);
            },
            controller: scrollController,
            restorationId: 'chapter_list_offset',
            leading: leading,
            isLoading: getNextPage.state is PendingMutationState,
          );
        },
      ),
      _FeedViewType.manga => MangaDexMangaFeed(
        controller: scrollController,
        leading: leading,
      ),
    };
  }
}
