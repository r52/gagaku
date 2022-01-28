import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/types.dart';
import 'package:gagaku/src/mangadex/widgets.dart';
import 'package:gagaku/src/ui.dart';
import 'package:provider/provider.dart';

Route createMangaViewRoute(Manga manga) {
  return Styles.buildSlideTransitionRoute(
      (context, animation, secondaryAnimation) => MangaDexMangaViewWidget(
            manga: manga,
          ));
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
    final theme = Theme.of(context);
    return Scaffold(
      body: Consumer<MangaDexModel>(
        builder: (context, mdx, child) {
          return FutureBuilder<Iterable<Chapter>>(
            future: _fetchChapters(mdx, _chapterOffset),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CustomScrollView(
                  controller: _scrollController,
                  scrollBehavior: MouseTouchScrollBehavior(),
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      snap: false,
                      floating: false,
                      expandedHeight: 180.0,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          '${widget.manga.title.entries.first.value}',
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
                          imageUrl: widget.manga
                              .getCovertArtUrl(quality: CoverArtQuality.medium),
                          placeholder: (context, url) => Container(
                            child: Styles.buildCenterSpinner(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      actions: [
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
                                          MangaReadingStatus.plan_to_read);

                                  if (success) {
                                    success = await mdx.setMangaFollowing(
                                        widget.manga, false);
                                  }

                                  if (success) {
                                    setState(() {});
                                  }
                                },
                                child: Text('Add to Library'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ];
                          } else {
                            return [
                              Tooltip(
                                message: widget.manga.userFollowing!
                                    ? 'Unfollow Manga'
                                    : 'Follow Manga',
                                child: ElevatedButton(
                                  onPressed: () async {
                                    bool set = !widget.manga.userFollowing!;
                                    bool success = await mdx.setMangaFollowing(
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
                                onChanged: (MangaReadingStatus? status) async {
                                  if (status != null) {
                                    bool success =
                                        await mdx.setMangaReadingStatus(
                                            widget.manga, status);

                                    if (success &&
                                        status == MangaReadingStatus.none) {
                                      success = await mdx.setMangaFollowing(
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
                                  (int index) =>
                                      DropdownMenuItem<MangaReadingStatus>(
                                    value: MangaReadingStatus.values
                                        .elementAt(index),
                                    child: Text(
                                      MangaReadingStatus.values
                                          .elementAt(index)
                                          .formatted,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ];
                          }
                        }())
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: theme.cardColor,
                        child: Row(
                          children: [
                            MangaStatusChip(status: widget.manga.status),
                            const SizedBox(
                              width: 10,
                            ),
                            ContentRatingChip(
                                rating: widget.manga.contentRating),
                          ],
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
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    color: theme.backgroundColor,
                                    child: Text(entry.value),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: ExpansionTile(
                        title: Text('Info'),
                        children: [
                          if (widget.manga.author != null)
                            ExpansionTile(
                              title: Text('Author'),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  color: theme.backgroundColor,
                                  child: Row(
                                    children: [
                                      IconTextChip(
                                        text: Text(widget.manga.author!),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (widget.manga.artist != null)
                            ExpansionTile(
                              title: Text('Artist'),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  color: theme.backgroundColor,
                                  child: Row(
                                    children: [
                                      IconTextChip(
                                        text: Text(widget.manga.artist!),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (widget.manga.publicationDemographic != null)
                            ExpansionTile(
                              title: Text('Demograhic'),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  color: theme.backgroundColor,
                                  child: Row(
                                    children: [
                                      IconTextChip(
                                        text: Text(widget.manga
                                            .publicationDemographic!.formatted),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (widget.manga.tags.isNotEmpty)
                            ExpansionTile(
                              title: Text('Genres'),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  color: theme.backgroundColor,
                                  child: Row(
                                    children: widget.manga.tags
                                        .where((tag) =>
                                            tag.group == TagGroup.genre)
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: IconTextChip(
                                                  text: Text(e.name['en']!)),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          if (widget.manga.tags.isNotEmpty)
                            ExpansionTile(
                              title: Text('Themes'),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  color: theme.backgroundColor,
                                  child: Row(
                                    children: widget.manga.tags
                                        .where((tag) =>
                                            tag.group == TagGroup.theme)
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: IconTextChip(
                                                  text: Text(e.name['en']!)),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: theme.cardColor,
                        child: Text(
                          'Chapters',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          var e = snapshot.data!.elementAt(index);

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: ChapterButtonWidget(
                              chapter: e,
                              manga: widget.manga,
                              link: Text(
                                widget.manga.title.entries.first.value,
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          );
                        },
                        childCount: snapshot.data!.length,
                      ),
                    ),
                  ],
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
              return Styles.buildCenterSpinner();
            },
          );
        },
      ),
    );
  }
}
