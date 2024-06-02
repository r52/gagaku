import 'package:flutter/material.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_feed.g.dart';

@riverpod
Future<List<Manga>> _fetchMangaFeed(_FetchMangaFeedRef ref) async {
  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(latestChaptersFeedProvider.future);

  final mangaids = chapters.map((e) => e.manga.id).toSet();

  final mangas =
      await api.fetchManga(ids: mangaids, limit: MangaDexEndpoints.breakLimit);

  await ref.read(statisticsProvider.notifier).get(mangas);

  ref.disposeAfter(const Duration(minutes: 5));

  return mangas;
}

class MangaDexMangaFeed extends ConsumerWidget {
  const MangaDexMangaFeed({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedProvider = ref.watch(_fetchMangaFeedProvider);
    final isLoading = feedProvider.isLoading && !feedProvider.isRefreshing;

    return Center(
      child: Stack(
        children: [
          switch (feedProvider) {
            AsyncValue(:final error?, :final stackTrace?) => () {
                final messenger = ScaffoldMessenger.of(context);
                Styles.showErrorSnackBar(messenger, '$error');
                logger.e("_fetchMangaFeedProvider failed",
                    error: error, stackTrace: stackTrace);

                return RefreshIndicator(
                  onRefresh: () {
                    ref.read(latestChaptersFeedProvider.notifier).clear();
                    return ref.refresh(_fetchMangaFeedProvider.future);
                  },
                  child: ErrorList(error: error, stackTrace: stackTrace),
                );
              }(),
            AsyncValue(value: final mangas?) => RefreshIndicator(
                onRefresh: () {
                  ref.read(latestChaptersFeedProvider.notifier).clear();
                  return ref.refresh(_fetchMangaFeedProvider.future);
                },
                child: mangas.isEmpty
                    ? const Text('Find some manga to follow!')
                    : MangaListWidget(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: controller,
                        onAtEdge: () => ref
                            .read(latestChaptersFeedProvider.notifier)
                            .getMore(),
                        children: [
                          MangaListViewSliver(items: mangas),
                        ],
                      ),
              ),
            _ => const SizedBox.shrink(),
          },
          if (isLoading) ...Styles.loadingOverlay,
        ],
      ),
    );
  }
}
