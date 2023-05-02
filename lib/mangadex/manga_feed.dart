import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_feed.g.dart';

@riverpod
Future<Iterable<Manga>> _fetchMangaFeed(_FetchMangaFeedRef ref) async {
  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(latestChaptersFeedProvider.future);

  final mangaids = chapters.map((e) => e.getMangaID()).toSet();
  mangaids.removeWhere((element) => element.isEmpty);

  final mangas = await api.fetchManga(mangaids);

  ref.keepAlive();

  return mangas;
}

class MangaDexMangaFeed extends HookConsumerWidget {
  const MangaDexMangaFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(_fetchMangaFeedProvider);

    return Center(
      child: results.when(
        skipLoadingOnReload: true,
        data: (result) {
          if (result.isEmpty) {
            return const Text('Find some manga to follow!');
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.read(latestChaptersFeedProvider.notifier).clear();
            },
            child: MangaListWidget(
              items: result,
              title: const Text(
                'Latest Updates',
                style: TextStyle(fontSize: 24),
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              onAtEdge: () =>
                  ref.read(latestChaptersFeedProvider.notifier).getMore(),
            ),
          );
        },
        error: (err, stack) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text('$err'),
              backgroundColor: Colors.red,
            ));
          return Text('Error: $err');
        },
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
