import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/types.dart';
import 'package:gagaku/src/mangadex/widgets.dart';
import 'package:gagaku/src/ui.dart';
import 'package:provider/provider.dart';

class MangaDexMangaFeed extends StatefulWidget {
  const MangaDexMangaFeed({Key? key}) : super(key: key);

  @override
  _MangaDexMangaFeedState createState() => _MangaDexMangaFeedState();
}

class _MangaDexMangaFeedState extends State<MangaDexMangaFeed> {
  var _chapterOffset = 0;
  var _resultLength = 0;

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
                if (_resultLength == 0 &&
                    snapshot.connectionState != ConnectionState.done) {
                  return Styles.buildCenterSpinner();
                }

                if (snapshot.hasData) {
                  if (snapshot.data!.length == 0) {
                    return const Center(
                        child: Text('Find some manga to follow!'));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await _refreshFeed(mdx);
                    },
                    child: MangaListWidget(
                      items: snapshot.data!,
                      title: Text(
                        'Latest Updates',
                        style: TextStyle(fontSize: 24),
                      ),
                      restorationId: 'manga_list_grid_offset',
                      physics: const AlwaysScrollableScrollPhysics(),
                      defaultView: MangaListView.grid,
                      onAtEdge: () {
                        if (_resultLength ==
                            _chapterOffset + MangaDexEndpoints.apiQueryLimit) {
                          setState(() {
                            _chapterOffset += MangaDexEndpoints.apiQueryLimit;
                          });
                        }
                      },
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

                return Styles.buildCenterSpinner();
              },
            );
          },
        ),
      ),
    );
  }
}
