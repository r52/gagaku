import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/login.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;

class MangaDexHomePage extends StatefulWidget {
  MangaDexHomePage({Key? key, required this.restorationId}) : super(key: key);

  final String restorationId;

  @override
  _MangaDexHomePageState createState() => _MangaDexHomePageState();
}

class _MangaDexHomePageState extends State<MangaDexHomePage>
    with RestorationMixin {
  final RestorableInt _currentIndex = RestorableInt(0);

  @override
  String get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_currentIndex, 'md_bottom_navigation_tab_index');
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Provider.of<MangaDexModel>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return MangaDexLoginWidget(builder: (context) {
      var bottomNavigationBarItems = <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.feed),
          label: 'Feed',
        )
      ];

      final selectedItem = <Widget>[
        MangaDexMangaFeed(),
        Center(child: Text('Feed')) // TODO: Feed
      ];

      return Scaffold(
        appBar: AppBar(
          title: Text('MangaDex'),
          actions: [
            ButtonBar(
              children: [
                Tooltip(
                    message: 'Logout',
                    child: Consumer<MangaDexModel>(
                      builder: (context, mdx, child) {
                        return IconButton(
                          color: Theme.of(context).colorScheme.primary,
                          icon: Icon(Icons.logout),
                          onPressed: () async {
                            final result = await mdx.logout();

                            if (!result) {
                              // Shouldn't ever fail to logout
                              throw Exception('Failed to logout');
                            }
                          },
                        );
                      },
                    ))
              ],
            )
          ],
        ),
        body: Center(
          child: PageTransitionSwitcher(
            transitionBuilder: (child, animation, secondaryAnimation) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: selectedItem[_currentIndex.value],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          items: bottomNavigationBarItems,
          currentIndex: _currentIndex.value,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex.value = index;
            });
          },
        ),
      );
    });
  }
}

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

  Future<void> _refreshMangaFeed() async {
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
    return Consumer<MangaDexModel>(builder: (context, mdx, child) {
      return Scaffold(
        body: Center(
          child: FutureBuilder<Iterable<Manga>>(
            future: _mangaList,
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
                          await _refreshMangaFeed();
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
        // TODO: manga view
        print('tapped manga ' + manga.title['en']! + '; id=' + manga.id);
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
