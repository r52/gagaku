import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/widgets.dart';
import 'package:provider/provider.dart';

class MangaDexMangaFeed extends StatefulWidget {
  const MangaDexMangaFeed({Key? key}) : super(key: key);

  @override
  _MangaDexMangaFeedState createState() => _MangaDexMangaFeedState();
}

class _MangaDexMangaFeedState extends State<MangaDexMangaFeed> {
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

  Future<Iterable<Manga>> _fetchMangaFeed(
      MangaDexModel model, int offset) async {
    var chapters = await model.fetchChapterFeed(offset, true);
    _resultLength = chapters.length;

    var mangaIds = chapters.map((e) => e.mangaId).toSet();

    return model.fetchManga(mangaIds);
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
            return FutureBuilder<Iterable<Manga>>(
              future: _fetchMangaFeed(mdx, _chapterOffset),
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
                                  'Latest Updates',
                                  style: TextStyle(fontSize: 24),
                                )
                              ],
                            ),
                          ),
                          Expanded(
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
                                  .map((manga) => GridMangaItem(manga: manga))
                                  .toList(),
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
