import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_feed.g.dart';

@riverpod
Future<List<Manga>> _fetchMangaFeed(_FetchMangaFeedRef ref) async {
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
      child: switch (feedProvider) {
        AsyncValue(:final error?, :final stackTrace?) => RefreshIndicator(
            onRefresh: () async {
              ref.read(latestChaptersFeedProvider.notifier).clear();
              return ref.refresh(_fetchMangaFeedProvider.future);
            },
            child: ErrorList(
              error: error,
              stackTrace: stackTrace,
              message: "_fetchMangaFeedProvider failed",
            ),
          ),
        AsyncValue(value: final mangas?) => RefreshIndicator(
            onRefresh: () async {
              ref.read(latestChaptersFeedProvider.notifier).clear();
              return ref.refresh(_fetchMangaFeedProvider.future);
            },
            child: MangaListWidget(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: controller,
              onAtEdge: () => ref.read(latestChaptersFeedProvider.notifier).getMore(),
              leading: leading,
              isLoading: isLoading,
              children: [
                if (mangas.isEmpty)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Text('Find some manga to follow!'),
                    ),
                  ),
                MangaListViewSliver(items: mangas),
              ],
            ),
          ),
        _ => const LoadingOverlayStack(),
      },
    );
  }
}
