import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/manga_view.dart';
import 'package:gagaku/src/mangadex/widgets.dart';
import 'package:provider/provider.dart';

class MangaDexChapterFeed extends StatefulWidget {
  MangaDexChapterFeed({Key? key}) : super(key: key);

  @override
  _MangaDexChapterFeedState createState() => _MangaDexChapterFeedState();
}

class _MangaDexChapterFeedState extends State<MangaDexChapterFeed> {
  late Future<Iterable<_ChapterFeedItem>> _items;

  var _scrollController = ScrollController();
  var _chapterOffset = 0;

  @override
  void initState() {
    super.initState();

    _items = _fetchChapters(0);

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          setState(() {
            _chapterOffset += MangaDexEndpoints.apiQueryLimit;
            _items = _fetchChapters(_chapterOffset);
          });
        }
      }
    });
  }

  Future<Iterable<_ChapterFeedItem>> _fetchChapters(int offset) async {
    var chapters = await Provider.of<MangaDexModel>(context, listen: false)
        .fetchChapterFeed(offset, true);

    var mangaIds = chapters.map((e) => e.mangaId).toSet();

    var mangas = await Provider.of<MangaDexModel>(context, listen: false)
        .fetchManga(mangaIds);

    await Provider.of<MangaDexModel>(context, listen: false)
        .fetchReadChapters(mangas);

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

  Future<void> _refreshFeed() async {
    await Provider.of<MangaDexModel>(context, listen: false)
        .invalidateCacheItem(CacheLists.latestChapters);

    // Refresh
    setState(() {
      _chapterOffset = 0;
      _items = _fetchChapters(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Iterable<_ChapterFeedItem>>(
          future: _items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ScrollConfiguration(
                  behavior:
                      ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: RefreshIndicator(
                      onRefresh: () async {
                        await _refreshFeed();
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        restorationId: 'chapter_list_offset',
                        padding: const EdgeInsets.all(8),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return snapshot.data!.elementAt(index);
                        },
                      )));
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
    final theme = Theme.of(context);

    var chapterBtns = widget.state.chapters.map((e) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: ChapterButtonWidget(
            chapter: e,
            manga: widget.state.manga,
          ));
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
                      width: 128.0),
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
                          Navigator.push(context,
                              createMangaViewRoute(widget.state.manga));
                        },
                        child: Text(widget.state.manga.title['en']!)),
                    Divider(),
                    ...chapterBtns
                  ],
                ))
              ],
            )));
  }
}

class _ChapterFeedItemData {
  _ChapterFeedItemData({required this.manga})
      : mangaId = manga.id,
        coverArt = manga.getCovertArtUrl(quality: CoverArtQuality.small);

  final Manga manga;
  final String mangaId;
  final String coverArt;

  List<Chapter> chapters = [];
}
