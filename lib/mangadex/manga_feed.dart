import 'package:flutter/material.dart';
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
  await Future.delayed(const Duration(milliseconds: 100));

  final mangas = await api.fetchManga(mangaids);
  await Future.delayed(const Duration(milliseconds: 100));

  await ref.watch(statisticsProvider.notifier).get(mangas);

  ref.keepAlive();

  return mangas;
}

class MangaDexMangaFeed extends HookConsumerWidget {
  const MangaDexMangaFeed({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(_fetchMangaFeedProvider);
    final isLoading = results.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    return Center(
      child: Stack(
        children: [
          results.when(
            skipLoadingOnReload: true,
            data: (result) {
              if (result.isEmpty) {
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
                    MangaListViewSliver(items: result),
                  ],
                ),
              );
            },
            error: (err, stack) {
              final messenger = ScaffoldMessenger.of(context);
              Future.delayed(
                Duration.zero,
                () => messenger
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('$err'),
                      backgroundColor: Colors.red,
                    ),
                  ),
              );

              return Text('Error: $err');
            },
            loading: () => const SizedBox.shrink(),
          ),
          if (isLoading) ...Styles.loadingOverlay,
        ],
      ),
    );
  }
}
