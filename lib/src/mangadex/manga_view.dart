import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/settings.dart';
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

  Future<Iterable<Chapter>> _fetchChapters(
      MangaDexModel model, int offset) async {
    if (widget.manga.userFollowing == null) {
      await model.getMangaFollowing(widget.manga);
    }

    if (widget.manga.userReadStatus == null) {
      await model.getMangaReadingStatus(widget.manga);
    }

    if (widget.manga.readChapters == null) {
      await model.fetchReadChapters([widget.manga]);
    }

    var chapters = await model.fetchMangaChapters(widget.manga, offset, true);
    _resultLength = chapters.length;

    return chapters;
  }

  @override
  Widget build(BuildContext context) {
    // TODO more manga info
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
                      if (widget.manga.description.length > 0)
                        SliverToBoxAdapter(
                          child: ExpansionTile(
                            title: Text('Synopsis'),
                            children: [
                              for (final entry
                                  in widget.manga.description.entries)
                                ExpansionTile(
                                  title: Text(Languages.get(entry.key).name),
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(entry.value))
                                  ],
                                )
                            ],
                          ),
                        ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...(() {
                                if (!widget.manga.userFollowing! &&
                                    widget.manga.userReadStatus ==
                                        MangaReadingStatus.none) {
                                  return [
                                    ElevatedButton(
                                      onPressed: () async {
                                        bool success =
                                            await mdx.setMangaReadingStatus(
                                                widget.manga,
                                                MangaReadingStatus
                                                    .plan_to_read);

                                        if (success) {
                                          success = await mdx.setMangaFollowing(
                                              widget.manga, false);
                                        }

                                        if (success) {
                                          setState(() {});
                                        }
                                      },
                                      child: Text('Add to Library'),
                                    )
                                  ];
                                } else {
                                  return [
                                    Tooltip(
                                      message: widget.manga.userFollowing!
                                          ? 'Unfollow Manga'
                                          : 'Follow Manga',
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          bool set =
                                              !widget.manga.userFollowing!;
                                          bool success =
                                              await mdx.setMangaFollowing(
                                                  widget.manga, set);

                                          if (success) {
                                            setState(() {});
                                          }
                                        },
                                        child: Icon(widget.manga.userFollowing!
                                            ? Icons.favorite
                                            : Icons.favorite_border),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton<MangaReadingStatus>(
                                      value: widget.manga.userReadStatus,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      onChanged:
                                          (MangaReadingStatus? status) async {
                                        if (status != null) {
                                          bool success =
                                              await mdx.setMangaReadingStatus(
                                                  widget.manga, status);

                                          if (success &&
                                              status ==
                                                  MangaReadingStatus.none) {
                                            success =
                                                await mdx.setMangaFollowing(
                                                    widget.manga, false);
                                          }

                                          if (success) {
                                            setState(() {});
                                          }
                                        }
                                      },
                                      items: List<
                                          DropdownMenuItem<
                                              MangaReadingStatus>>.generate(
                                        MangaReadingStatus.values.length,
                                        (int index) => DropdownMenuItem<
                                            MangaReadingStatus>(
                                          value: MangaReadingStatus.values
                                              .elementAt(index),
                                          child: Text(
                                            MangaDexStrings.readingStatus
                                                .elementAt(index),
                                          ),
                                        ),
                                      ),
                                    )
                                  ];
                                }
                              }())
                            ],
                          ),
                        ),
                      ),
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
