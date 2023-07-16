import 'package:flutter/material.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_feed.g.dart';

@riverpod
Future<Iterable<Manga>> _fetchMangaFeed(_FetchMangaFeedRef ref) async {
  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(latestChaptersFeedProvider.future);

  final mangaids = chapters.map((e) => e.getMangaID()).toSet();
  mangaids.removeWhere((element) => element.isEmpty);

  final mangas = await api.fetchManga(ids: mangaids);

  await ref.watch(statisticsProvider.notifier).get(mangas);

  ref.keepAlive();

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
    final results = ref.watch(_fetchMangaFeedProvider);
    final isLoading = results.isLoading;

    return Center(
      child: Stack(
        children: [
          switch (results) {
            AsyncValue(:final error?, :final stackTrace?) => () {
                final messenger = ScaffoldMessenger.of(context);
                Styles.showErrorSnackBar(messenger, '$error');
                logger.e("_fetchMangaFeedProvider failed", error, stackTrace);

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(latestChaptersFeedProvider);
                    return await ref.refresh(_fetchMangaFeedProvider.future);
                  },
                  child: Styles.errorList(error, stackTrace),
                );
              }(),
            AsyncValue(:final value?) => () {
                if (value.isEmpty) {
                  return const Text('Find some manga to follow!');
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.read(latestChaptersFeedProvider.notifier).clear();
                    return await ref.refresh(_fetchMangaFeedProvider.future);
                  },
                  child: MangaListWidget(
                    title: const Text(
                      'Latest Updates',
                      style: TextStyle(fontSize: 24),
                    ),
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: controller,
                    onAtEdge: () =>
                        ref.read(latestChaptersFeedProvider.notifier).getMore(),
                    children: [
                      MangaListViewSliver(items: value),
                    ],
                  ),
                );
              }(),
            _ => const SizedBox.shrink(),
          },
          if (isLoading) ...Styles.loadingOverlay,
        ],
      ),
    );
  }
}
