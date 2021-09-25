import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/manga_view.dart';
import 'package:gagaku/src/util.dart';
import 'package:provider/provider.dart';

Route createMangaDexSearchRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        MangaDexSearchWidget(),
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

class MangaDexSearchWidget extends StatefulWidget {
  const MangaDexSearchWidget({Key? key}) : super(key: key);

  @override
  _MangaDexSearchWidgetState createState() => _MangaDexSearchWidgetState();
}

class _MangaDexSearchWidgetState extends State<MangaDexSearchWidget> {
  Timer? _debounce;

  var _scrollController = ScrollController();
  var _searchOffset = 0;
  String _searchTerm = '';
  Set<Manga> _results = Set<Manga>();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          setState(() {
            _searchOffset += MangaDexEndpoints.apiSearchLimit;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<Iterable<Manga>> _searchManga(
      MangaDexModel model, String searchTerm, int offset) async {
    if (searchTerm.isEmpty) {
      return [];
    }

    var manga = await model.searchManga(searchTerm, offset, _results);
    _results.addAll(manga);

    return _results;
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 750), () {
      setState(() {
        _searchTerm = query;
        _results.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //final bool screenSizeSmall = MediaQuery.of(context).size.width <= 480;
    final theme = Theme.of(context);

    return Scaffold(
      body: Consumer<MangaDexModel>(
        builder: (context, mdx, child) {
          return FutureBuilder<Iterable<Manga>>(
            future: _searchManga(mdx, _searchTerm, _searchOffset),
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
                        expandedHeight: 80.0,
                        flexibleSpace: FlexibleSpaceBar(
                          title: TextField(
                            autofocus: true,
                            onChanged: _onSearchChanged,
                            decoration: InputDecoration(
                              icon: Icon(Icons.search),
                              hintText: 'Search Manga...',
                            ),
                          ),
                        ),
                      ),
                      // TODO search filters?
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
                            var manga = snapshot.data!.elementAt(index);

                            var iconColor = Colors.green;

                            switch (manga.status) {
                              case MangaStatus.none:
                              case MangaStatus.ongoing:
                                break;
                              case MangaStatus.completed:
                                iconColor = Colors.blue;
                                break;
                              case MangaStatus.hiatus:
                                iconColor = Colors.orange;
                                break;
                              case MangaStatus.cancelled:
                                iconColor = Colors.red;
                                break;
                            }

                            return Card(
                              margin: const EdgeInsets.all(6),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.push(context,
                                            createMangaViewRoute(manga));
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: manga.getCovertArtUrl(
                                            quality: CoverArtQuality.small),
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        width: 80.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              primary:
                                                  theme.colorScheme.onSurface,
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onPressed: () async {
                                              Navigator.push(context,
                                                  createMangaViewRoute(manga));
                                            },
                                            child: Text(manga.title['en']!),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: theme.canvasColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 2.0,
                                                  horizontal: 6.0,
                                                ),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.circle,
                                                      color: iconColor,
                                                      size: 10,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      describeEnum(manga.status)
                                                          .capitalize(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
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
