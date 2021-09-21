import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/manga_view.dart';
import 'package:provider/provider.dart';

class MangaDexMangaFeed extends StatefulWidget {
  MangaDexMangaFeed({Key? key}) : super(key: key);

  @override
  _MangaDexMangaFeedState createState() => _MangaDexMangaFeedState();
}

class _MangaDexMangaFeedState extends State<MangaDexMangaFeed> {
  late Future<Iterable<Manga>> _mangaList;

  var _scrollController = ScrollController();
  var _chapterOffset = 0;

  @override
  void initState() {
    super.initState();

    _mangaList = _fetchMangaFeed(0);

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          setState(() {
            _chapterOffset += MangaDexEndpoints.apiQueryLimit;
            _mangaList = _fetchMangaFeed(_chapterOffset);
          });
        }
      }
    });
  }

  Future<Iterable<Manga>> _fetchMangaFeed(int offset) async {
    var chapters = await Provider.of<MangaDexModel>(context, listen: false)
        .fetchChapterFeed(offset, true);

    var mangaIds = chapters.map((e) => e.mangaId).toSet();

    return Provider.of<MangaDexModel>(context, listen: false)
        .fetchManga(mangaIds);
  }

  Future<void> _refreshFeed() async {
    await Provider.of<MangaDexModel>(context, listen: false)
        .invalidateCacheItem(CacheLists.latestChapters);

    // Refresh
    setState(() {
      _chapterOffset = 0;
      _mangaList = _fetchMangaFeed(_chapterOffset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Iterable<Manga>>(
          future: _mangaList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length == 0) {
                return const Center(child: Text('Find some manga to follow!'));
              }

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
                      child: GridView.extent(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        restorationId: 'manga_list_grid_offset',
                        maxCrossAxisExtent: 300,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        padding: const EdgeInsets.all(8),
                        childAspectRatio: 0.7,
                        children: snapshot.data!
                            .map((manga) => _GridMangaItem(manga: manga))
                            .toList(),
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

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.none,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text),
    );
  }
}

class _GridMangaItem extends StatelessWidget {
  const _GridMangaItem({Key? key, required this.manga}) : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: manga.getCovertArtUrl(),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );

    return InkWell(
      onTap: () {
        Navigator.push(context, createMangaViewRoute(manga));
      },
      child: GridTile(
        footer: Material(
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridTileBar(
              backgroundColor: Colors.black45,
              title: _GridTitleText(manga.title['en']!)),
        ),
        child: image,
      ),
    );
  }
}
