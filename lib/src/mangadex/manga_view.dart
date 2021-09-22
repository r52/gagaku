import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/widgets.dart';
import 'package:provider/provider.dart';

Route createMangaViewRoute(Manga manga) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        MangaDexMangaViewWidget(
      manga: manga,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class MangaDexMangaViewWidget extends StatefulWidget {
  const MangaDexMangaViewWidget({Key? key, required this.manga})
      : super(key: key);

  final Manga manga;

  @override
  _MangaDexMangaViewWidgetState createState() =>
      _MangaDexMangaViewWidgetState();
}

class _MangaDexMangaViewWidgetState extends State<MangaDexMangaViewWidget> {
  var _scrollController = ScrollController();
  var _chapterOffset = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          setState(() {
            _chapterOffset += MangaDexEndpoints.apiQueryLimit;
          });
        }
      }
    });
  }

  Future<Iterable<Chapter>> _fetchChapters(
      MangaDexModel model, int offset) async {
    if (!widget.manga.readChaptersRetrieved) {
      await model.fetchReadChapters([widget.manga]);
    }

    return model.fetchMangaChapters(widget.manga, offset, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MangaDexModel>(
        builder: (context, mdx, child) {
          return FutureBuilder<Iterable<Chapter>>(
            future: _fetchChapters(mdx, _chapterOffset),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ScrollConfiguration(
                  behavior:
                      ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                        pinned: true,
                        snap: false,
                        floating: false,
                        expandedHeight: 160.0,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            '${widget.manga.title['en']!}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 1.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                          ),
                          background: CachedNetworkImage(
                            colorBlendMode: BlendMode.modulate,
                            color: Colors.grey,
                            fit: BoxFit.cover,
                            imageUrl: widget.manga.getCovertArtUrl(),
                            placeholder: (context, url) => Container(
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      // TODO manga view data/commands
                      // const SliverToBoxAdapter(
                      //   child: SizedBox(
                      //     height: 50,
                      //     child: Center(
                      //       child: Text('TODO'),
                      //     ),
                      //   ),
                      // ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            var e = snapshot.data!.elementAt(index);

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: ChapterButtonWidget(
                                chapter: e,
                                manga: widget.manga,
                                link: Text(
                                  widget.manga.title['en']!,
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            );
                          },
                          childCount: snapshot.data!.length,
                        ),
                      ),
                    ],
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
    );
  }
}
