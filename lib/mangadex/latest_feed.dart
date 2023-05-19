import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'latest_feed.g.dart';

@riverpod
Future<List<ChapterFeedItem>> _fetchGlobalChapters(
    _FetchGlobalChaptersRef ref) async {
  final api = ref.watch(mangadexProvider);
  final loggedin = await ref.watch(authControlProvider.future);

  final chapters = await ref.watch(latestGlobalFeedProvider.future);

  final mangaIds = chapters.map((e) => e.getMangaID()).toSet();
  mangaIds.removeWhere((element) => element.isEmpty);
  await Future.delayed(const Duration(milliseconds: 100));

  final mangas = await api.fetchManga(mangaIds);
  await Future.delayed(const Duration(milliseconds: 100));

  await ref.watch(statisticsProvider.notifier).get(mangas);
  await Future.delayed(const Duration(milliseconds: 100));

  if (loggedin) {
    await ref.watch(readChaptersProvider.notifier).get(mangas);
  }

  final mangaMap = Map<String, Manga>.fromIterable(mangas, key: (e) => e.id);

  // Craft feed items
  List<ChapterFeedItemData> dlist = [];

  for (final chapter in chapters) {
    final cid = chapter.getMangaID();
    ChapterFeedItemData? item;
    if (dlist.isNotEmpty && dlist.last.mangaId == cid) {
      item = dlist.last;
    } else {
      item = ChapterFeedItemData(manga: mangaMap[cid]!);
      dlist.add(item);
    }

    item.chapters.add(chapter);
  }

  // Craft widgets
  final wlist = dlist
      .map((e) => ChapterFeedItem(
            state: e,
          ))
      .toList();

  ref.keepAlive();

  return wlist;
}

class MangaDexGlobalFeed extends HookConsumerWidget {
  const MangaDexGlobalFeed({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = controller ?? useScrollController();
    final results = ref.watch(_fetchGlobalChaptersProvider);

    useEffect(() {
      void controllerAtEdge() {
        if (scrollController.position.atEdge) {
          if (scrollController.position.pixels != 0) {
            ref.read(latestGlobalFeedProvider.notifier).getMore();
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
            return const Text('No results!');
          }

          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            }),
            child: RefreshIndicator(
              onRefresh: () async {
                ref.read(latestGlobalFeedProvider.notifier).clear();
                return await ref.refresh(_fetchGlobalChaptersProvider.future);
              },
              child: Column(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Text(
                          'Latest Uploads',
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      restorationId: 'global_list_offset',
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
      ),
    );
  }
}
