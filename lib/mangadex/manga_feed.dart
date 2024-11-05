import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_feed.g.dart';

@Riverpod(retry: noRetry)
Future<List<Manga>> _fetchMangaFeed(Ref ref) async {
  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(latestChaptersFeedProvider.future);

  final mangaids = chapters.map((e) => e.manga.id).toSet();

  final mangas = await api.fetchManga(ids: mangaids, limit: MangaDexEndpoints.breakLimit);

  await ref.read(statisticsProvider.notifier).get(mangas);

  ref.disposeAfter(const Duration(minutes: 5));

  return mangas;
}

class MangaDexMangaFeed extends ConsumerWidget {
  const MangaDexMangaFeed({
    super.key,
    this.controller,
    this.leading = const [],
  });

  final ScrollController? controller;
  final List<Widget> leading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedProvider = ref.watch(_fetchMangaFeedProvider);
    final isLoading = feedProvider.isLoading && !feedProvider.isRefreshing;

    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          ref.read(latestChaptersFeedProvider.notifier).clear();
          return ref.refresh(_fetchMangaFeedProvider.future);
        },
        child: switch (feedProvider) {
          AsyncValue(:final error?, :final stackTrace?) => ErrorList(
              error: error,
              stackTrace: stackTrace,
              message: "_fetchMangaFeedProvider failed",
            ),
          AsyncValue(value: final mangas?) => MangaListWidget(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: controller,
              onAtEdge: () => ref.read(latestChaptersFeedProvider.notifier).getMore(),
              leading: leading,
              isLoading: isLoading,
              children: [
                if (mangas.isEmpty)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Text('mangadex.noFollowsMsg'.tr(context: context)),
                    ),
                  ),
                MangaListViewSliver(items: mangas),
              ],
            ),
          _ => const LoadingOverlayStack(),
        },
      ),
    );
  }
}
