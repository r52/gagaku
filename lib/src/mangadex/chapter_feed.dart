import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    List<_ChapterFeedItem> list = [];

    chapters.forEach((chapter) {
      _ChapterFeedItem? item;
      if (list.isNotEmpty && list.last.mangaId == chapter.mangaId) {
        item = list.last;
      } else {
        item = new _ChapterFeedItem(manga: mangaMap[chapter.mangaId]!);
        list.add(item);
      }

      item.chapters.add(chapter);
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MangaDexModel>(builder: (context, mdx, child) {
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
                          // TODO refresh
                          //await _refreshMangaFeed();
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
                // TODO toast
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
    });
  }
}

class _ChapterFeedItem extends StatelessWidget {
  _ChapterFeedItem({Key? key, required this.manga})
      : mangaId = manga.id,
        coverArt = manga.getCovertArtUrl(quality: CoverArtQuality.small),
        super(key: key);

  final Manga manga;
  final String mangaId;
  final String coverArt;

  List<Chapter> chapters = [];

  @override
  Widget build(BuildContext context) {
    var chapterBtns = chapters.map((e) {
      String title = '';

      if (e.chapter != null) {
        title += 'Chapter ' + e.chapter!;
      }

      if (e.title != null) {
        title += ' - ' + e.title!;
      }

      if (manga.readChaptersRetrieved) {
        e.read = manga.readChapters.contains(e.id);
      }

      return OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.grey[900],
              primary: (e.read
                  ? Theme.of(context).backgroundColor
                  : Theme.of(context).colorScheme.primary)),
          onPressed: () async {
            // TODO READER!!!!
            print('tapped chapter ' + title + '; id=' + e.id);
          },
          child: Row(
            children: [
              Icon(
                e.read ? Icons.check : Icons.circle,
                color: e.read ? Colors.green : Colors.blue,
                size: e.read ? 15 : 10,
              ),
              SizedBox(width: 5),
              Text(title),
              Spacer(),
              Icon(Icons.schedule, size: 20),
              SizedBox(width: 5),
              Text(timeago.format(e.publishAt))
            ],
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
                      // TODO: manga view
                      print('tapped manga ' +
                          manga.title['en']! +
                          '; id=' +
                          manga.id);
                    },
                    child: CachedNetworkImage(
                        imageUrl: coverArt,
                        placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: 128.0)),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          // TODO: manga view
                          print('tapped manga ' +
                              manga.title['en']! +
                              '; id=' +
                              manga.id);
                        },
                        child: Text(manga.title['en']!)),
                    Divider(),
                    ...chapterBtns
                  ],
                ))
              ],
            )));
  }
}
