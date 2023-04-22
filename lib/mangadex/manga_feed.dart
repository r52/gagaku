import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_feed.g.dart';

class FetchMangaFeedResults {
  const FetchMangaFeedResults(this.list, this.length);

  final Iterable<Manga> list;
  final int length;
}

@riverpod
Future<FetchMangaFeedResults> fetchMangaFeed(FetchMangaFeedRef ref) async {
  final api = ref.watch(mangadexProvider);

  final chapters = await ref.watch(latestChaptersFeedProvider.future);

  var mangaids = chapters.map((e) {
    for (var r in e.relationships) {
      var res = r.maybeWhen(manga: (id) => id, orElse: () => null);
      if (res != null) {
        return res;
      }
    }

    return '';
  }).toSet();

  mangaids.removeWhere((element) => element.isEmpty);

  var mangas = await api.fetchManga(mangaids);

  ref.keepAlive();

  return FetchMangaFeedResults(mangas, chapters.length);
}

class MangaDexMangaFeed extends HookConsumerWidget {
  const MangaDexMangaFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(fetchMangaFeedProvider);

    return Scaffold(
      body: Center(
        child: results.when(
            skipLoadingOnReload: true,
            data: (result) {
              if (result.list.isEmpty) {
                return const Text('Find some manga to follow!');
              }

              return RefreshIndicator(
                onRefresh: () async {
                  ref.read(latestChaptersFeedProvider.notifier).clear();
                },
                child: MangaListWidget(
                  items: result.list,
                  title: const Text(
                    'Latest Updates',
                    style: TextStyle(fontSize: 24),
                  ),
                  physics: const AlwaysScrollableScrollPhysics(),
                  onAtEdge: () {
                    ref.read(latestChaptersFeedProvider.notifier).getMore();
                  },
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
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
