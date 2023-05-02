import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/manga_view.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chapter_feed.g.dart';

@riverpod
Future<List<_ChapterFeedItem>> _fetchChapters(_FetchChaptersRef ref) async {
  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(latestChaptersFeedProvider.future);

  final mangaIds = chapters.map((e) => e.getMangaID()).toSet();
  mangaIds.removeWhere((element) => element.isEmpty);
  await Future.delayed(const Duration(milliseconds: 100));

  final mangas = await api.fetchManga(mangaIds);
  await Future.delayed(const Duration(milliseconds: 100));

  ref.watch(statisticsProvider.notifier).get(mangas);
  await Future.delayed(const Duration(milliseconds: 100));

  ref.watch(readChaptersProvider.notifier).get(mangas);

  final mangaMap = Map<String, Manga>.fromIterable(mangas, key: (e) => e.id);

  // Craft feed items
  List<_ChapterFeedItemData> dlist = [];

  for (final chapter in chapters) {
    final cid = chapter.getMangaID();
    _ChapterFeedItemData? item;
    if (dlist.isNotEmpty && dlist.last.mangaId == cid) {
      item = dlist.last;
    } else {
      item = _ChapterFeedItemData(manga: mangaMap[cid]!);
      dlist.add(item);
    }

    item.chapters.add(chapter);
  }

  // Craft widgets
  final wlist = dlist
      .map((e) => _ChapterFeedItem(
            state: e,
          ))
      .toList();

  ref.keepAlive();

  return wlist;
}

class MangaDexChapterFeed extends HookConsumerWidget {
  const MangaDexChapterFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final results = ref.watch(_fetchChaptersProvider);

    useEffect(() {
      void controllerAtEdge() {
        if (scrollController.position.atEdge) {
          if (scrollController.position.pixels != 0) {
            ref.read(latestChaptersFeedProvider.notifier).getMore();
          }
        }
      }

      scrollController.addListener(controllerAtEdge);
      return () => scrollController.removeListener(controllerAtEdge);
    }, [scrollController]);

    return Center(
      child: results.when(
        skipLoadingOnReload: true,
        data: (result) {
          if (result.isEmpty) {
            return const Text('Find some manga to follow!');
          }

          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
            child: RefreshIndicator(
              onRefresh: () async {
                ref.read(latestChaptersFeedProvider.notifier).clear();
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10.0),
                    child: Row(
                      children: const [
                        Text(
                          'Latest Chapters',
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      restorationId: 'chapter_list_offset',
                      padding: const EdgeInsets.all(6),
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return result.elementAt(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stackTrace) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text('$err'),
              backgroundColor: Colors.red,
            ));

          return Text('Error: $err');
        },
      ),
    );
  }
}

class _ChapterFeedItem extends HookWidget {
  const _ChapterFeedItem({required this.state});

  final _ChapterFeedItemData state;

  @override
  Widget build(BuildContext context) {
    final refresh = useState(0);
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);

    var chapterBtns = state.chapters.map((e) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ChapterButtonWidget(
          chapter: e,
          manga: state.manga,
          link: Text(
            state.manga.attributes.title.get('en'),
            style: const TextStyle(fontSize: 24),
          ),
          onLinkPressed: () {
            Navigator.push(context, createMangaViewRoute(state.manga))
                .then((value) {
              // Refresh when the view is closed
              refresh.value++;
            });
          },
        ),
      );
    }).toList();

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                Navigator.push(context, createMangaViewRoute(state.manga))
                    .then((value) {
                  // Refresh when the view is closed
                  refresh.value++;
                });
              },
              child: ExtendedImage.network(state.coverArt,
                  loadStateChanged: extendedImageLoadStateHandler,
                  width: screenSizeSmall ? 80.0 : 128.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.onSurface,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        Navigator.push(
                                context, createMangaViewRoute(state.manga))
                            .then((value) {
                          // Refresh when the view is closed
                          refresh.value++;
                        });
                      },
                      child: Text(state.manga.attributes.title.get('en'))),
                  const Divider(),
                  ...chapterBtns
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ChapterFeedItemData {
  _ChapterFeedItemData({required this.manga})
      : mangaId = manga.id,
        coverArt = manga.getCovertArtUrl(quality: CoverArtQuality.medium);

  final Manga manga;
  final String mangaId;
  final String coverArt;

  List<Chapter> chapters = [];
}
