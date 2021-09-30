import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/manga_view.dart';
import 'package:gagaku/src/mangadex/widgets.dart';
import 'package:gagaku/src/util.dart';
import 'package:provider/provider.dart';

class MangaDexChapterFeed extends StatefulWidget {
  const MangaDexChapterFeed({Key? key}) : super(key: key);

  @override
  _MangaDexChapterFeedState createState() => _MangaDexChapterFeedState();
}

class _MangaDexChapterFeedState extends State<MangaDexChapterFeed> {
  var _scrollController = ScrollController();
  var _chapterOffset = 0;
  var _resultLength = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          if (_resultLength ==
              _chapterOffset + MangaDexEndpoints.apiQueryLimit) {
            setState(() {
              _chapterOffset += MangaDexEndpoints.apiQueryLimit;
            });
          }
        }
      }
    });
  }

  Future<Iterable<_ChapterFeedItem>> _fetchChapters(
      MangaDexModel model, int offset) async {
    var chapters = await model.fetchChapterFeed(offset, true);
    _resultLength = chapters.length;

    var mangaIds = chapters.map((e) => e.mangaId).toSet();

    var mangas = await model.fetchManga(mangaIds);

    await model.fetchReadChapters(mangas);

    var mangaMap = Map<String, Manga>.fromIterable(mangas, key: (e) => e.id);

    // Craft feed items
    List<_ChapterFeedItemData> dlist = [];

    chapters.forEach((chapter) {
      _ChapterFeedItemData? item;
      if (dlist.isNotEmpty && dlist.last.mangaId == chapter.mangaId) {
        item = dlist.last;
      } else {
        item = new _ChapterFeedItemData(manga: mangaMap[chapter.mangaId]!);
        dlist.add(item);
      }

      item.chapters.add(chapter);
    });

    // Craft widgets
    var wlist = dlist
        .map((e) => _ChapterFeedItem(
              state: e,
            ))
        .toList();

    return wlist;
  }

  Future<void> _refreshFeed(MangaDexModel model) async {
    await model.invalidateCacheItem(CacheLists.latestChapters);

    // Refresh
    setState(() {
      _resultLength = 0;
      _chapterOffset = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<MangaDexModel>(
          builder: (context, mdx, child) {
            return FutureBuilder<Iterable<_ChapterFeedItem>>(
              future: _fetchChapters(mdx, _chapterOffset),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length == 0) {
                    return const Center(
                        child: Text('Find some manga to follow!'));
                  }

                  return ScrollConfiguration(
                    behavior:
                        ScrollConfiguration.of(context).copyWith(dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    }),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await _refreshFeed(mdx);
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Latest Chapters',
                                  style: TextStyle(fontSize: 24),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              restorationId: 'chapter_list_offset',
                              padding: const EdgeInsets.all(6),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return snapshot.data!.elementAt(index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text('${snapshot.error}'),
                      backgroundColor: Colors.red,
                    ));

                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ChapterFeedItem extends StatefulWidget {
  _ChapterFeedItem({Key? key, required this.state}) : super(key: key);

  final _ChapterFeedItemData state;

  @override
  _ChapterFeedItemState createState() => _ChapterFeedItemState();
}

class _ChapterFeedItemState extends State<_ChapterFeedItem> {
  @override
  Widget build(BuildContext context) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);

    var chapterBtns = widget.state.chapters.map((e) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ChapterButtonWidget(
          chapter: e,
          manga: widget.state.manga,
          link: Text(
            widget.state.manga.title['en']!,
            style: TextStyle(fontSize: 24),
          ),
          onLinkPressed: () {
            Navigator.push(context, createMangaViewRoute(widget.state.manga));
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
                Navigator.push(
                    context, createMangaViewRoute(widget.state.manga));
              },
              child: CachedNetworkImage(
                  imageUrl: widget.state.coverArt,
                  placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: screenSizeSmall ? 80.0 : 128.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: theme.colorScheme.onSurface,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        Navigator.push(
                            context, createMangaViewRoute(widget.state.manga));
                      },
                      child: Text(widget.state.manga.title['en']!)),
                  Divider(),
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
