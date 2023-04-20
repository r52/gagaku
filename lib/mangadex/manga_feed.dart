import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_feed.g.dart';

class FeedResults {
  const FeedResults(this.list, this.length);

  final Iterable<Manga> list;
  final int length;
}

@riverpod
Future<FeedResults> fetchMangaFeed(FetchMangaFeedRef ref, int offset) async {
  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(fetchChapterFeedProvider(offset).future);

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

  return FeedResults(mangas, chapters.length);
}

class MangaDexMangaFeed extends HookConsumerWidget {
  const MangaDexMangaFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offset = useState(0);

    final results = ref.watch(fetchMangaFeedProvider(offset.value));

    return Scaffold(
      body: Center(
        child: results.when(
            data: (result) {
              if (result.list.isEmpty) {
                return const Text('Find some manga to follow!');
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await ref
                      .read(mangadexProvider)
                      .invalidateCacheItem(CacheLists.latestChapters);
                  offset.value = 0;
                },
                child: MangaListWidget(
                  items: result.list,
                  title: const Text(
                    'Latest Updates',
                    style: TextStyle(fontSize: 24),
                  ),
                  physics: const AlwaysScrollableScrollPhysics(),
                  onAtEdge: () {
                    if (result.length ==
                        offset.value + MangaDexEndpoints.apiQueryLimit) {
                      offset.value += MangaDexEndpoints.apiQueryLimit;
                    }
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
