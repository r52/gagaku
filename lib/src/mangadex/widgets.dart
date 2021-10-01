import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/manga_view.dart';
import 'package:gagaku/src/mangadex/reader.dart';
import 'package:gagaku/src/mangadex/types.dart';
import 'package:gagaku/src/reader.dart';
import 'package:gagaku/src/ui.dart';
import 'package:gagaku/src/util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

enum MangaListView { grid, list, detailed }

class ChapterButtonWidget extends StatefulWidget {
  const ChapterButtonWidget({
    Key? key,
    required this.chapter,
    required this.manga,
    this.link,
    this.onLinkPressed,
  }) : super(key: key);

  final Chapter chapter;
  final Manga manga;
  final Widget? link;
  final LinkPressedCallback? onLinkPressed;

  @override
  _ChapterButtonWidgetState createState() => _ChapterButtonWidgetState();
}

class _ChapterButtonWidgetState extends State<ChapterButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);

    String title = '';

    if (widget.chapter.chapter != null) {
      title += 'Chapter ${widget.chapter.chapter!}';
    }

    if (widget.chapter.title != null) {
      title += ' - ${widget.chapter.title!}';
    }

    if (widget.manga.readChapters != null) {
      widget.chapter.read =
          widget.manga.readChapters!.contains(widget.chapter.id);
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
              color: widget.chapter.read ? theme.backgroundColor : Colors.blue,
              width: 4.0),
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
                  context,
                  createMangaDexReaderRoute(widget.chapter, widget.manga,
                      widget.link, widget.onLinkPressed))
              .then((value) {
            // Refresh this when reader view is closed to update read status
            setState(() {});
          });
        },
        tileColor: theme.backgroundColor,
        dense: true,
        minVerticalPadding: 0.0,
        contentPadding:
            EdgeInsets.symmetric(horizontal: (screenSizeSmall ? 4.0 : 10.0)),
        minLeadingWidth: 0.0,
        leading: IconButton(
          onPressed: () async {
            bool set = !widget.chapter.read;
            bool result =
                await Provider.of<MangaDexModel>(context, listen: false)
                    .setChapterRead(widget.chapter, set);

            // Sanity check
            if (widget.manga.readChapters == null) {
              widget.manga.readChapters = Set<String>();
            }

            if (result) {
              // Refresh
              setState(() {
                if (set) {
                  widget.manga.readChapters!.add(widget.chapter.id);
                } else {
                  widget.manga.readChapters!.remove(widget.chapter.id);
                }
              });
            }
          },
          padding: const EdgeInsets.all(0.0),
          splashRadius: 15,
          iconSize: 20,
          tooltip: widget.chapter.read ? 'Unmark as read' : 'Mark as read',
          icon: Icon(
              widget.chapter.read ? Icons.visibility_off : Icons.visibility,
              color: (widget.chapter.read
                  ? theme.highlightColor
                  : theme.primaryIconTheme.color)),
          constraints: BoxConstraints(minWidth: 20.0, minHeight: 20.0),
        ),
        title: Text(
          title,
          style: TextStyle(
              color: (widget.chapter.read
                  ? theme.highlightColor
                  : theme.colorScheme.primary)),
        ),
        trailing: !screenSizeSmall
            ? FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconTextChip(
                      icon: Icon(Icons.language, size: 18),
                      text: Text(
                        Languages.get(widget.chapter.translatedLanguage)
                            .toString()
                            .toUpperCase(),
                      ),
                    ),
                    SizedBox(width: 2),
                    IconTextChip(
                      icon: Icon(Icons.group, size: 20),
                      text: Text(widget.chapter.groupName),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.schedule, size: 20),
                    SizedBox(width: 5),
                    Text(timeago.format(widget.chapter.publishAt))
                  ],
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule, size: 15),
                  SizedBox(width: 5),
                  Text(timeago.format(widget.chapter.publishAt))
                ],
              ),
      ),
    );
  }
}

class MangaListWidget extends StatefulWidget {
  const MangaListWidget({
    Key? key,
    required this.title,
    required this.items,
    this.leading = const <Widget>[],
    this.defaultView = MangaListView.grid,
    this.restorationId,
    this.physics,
    this.onAtEdge,
  }) : super(key: key);

  final Widget title;
  final Iterable<Manga> items;
  final List<Widget> leading;
  final MangaListView defaultView;
  final String? restorationId;
  final ScrollPhysics? physics;
  final VoidCallback? onAtEdge;

  @override
  _MangaListWidgetState createState() => _MangaListWidgetState();
}

class _MangaListWidgetState extends State<MangaListWidget> {
  var _scrollController = ScrollController();
  var _mangaListView = MangaListView.grid;

  @override
  void initState() {
    super.initState();

    if (widget.onAtEdge != null) {
      _scrollController.addListener(() {
        if (_scrollController.position.atEdge) {
          if (_scrollController.position.pixels != 0) {
            widget.onAtEdge!();
          }
        }
      });
    }

    _mangaListView = widget.defaultView;

    // TODO save view pref
    // SharedPreferences.getInstance().then((prefs) {
    //   setState(() {
    //     _mangaListView = prefs.getInt('mangalist.view') ?? 0;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    Widget view;

    switch (_mangaListView) {
      case MangaListView.list:
        view = SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              var manga = widget.items.elementAt(index);

              return _ListMangaItem(
                manga: manga,
              );
            },
            childCount: widget.items.length,
          ),
        );
        break;
      case MangaListView.detailed:
        view = SliverGrid.extent(
          maxCrossAxisExtent: 1200,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 3,
          children: widget.items
              .map((manga) => _GridMangaDetailedItem(manga: manga))
              .toList(),
        );

        break;
      case MangaListView.grid:
      default:
        view = SliverGrid.extent(
          maxCrossAxisExtent: 300,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.7,
          children: widget.items
              .map((manga) => _GridMangaItem(manga: manga))
              .toList(),
        );
        break;
    }

    return CustomScrollView(
      controller: _scrollController,
      scrollBehavior: MouseTouchScrollBehavior(),
      physics: widget.physics,
      restorationId: widget.restorationId,
      slivers: [
        ...widget.leading,
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(
              children: [
                widget.title,
                const Spacer(),
                ToggleButtons(
                  children: const [
                    Icon(
                      Icons.grid_view,
                    ),
                    Icon(
                      Icons.table_rows,
                    ),
                    Icon(
                      Icons.view_list,
                    ),
                  ],
                  isSelected: List<bool>.generate(MangaListView.values.length,
                      (index) => _mangaListView.index == index),
                  onPressed: (index) {
                    setState(() {
                      _mangaListView = MangaListView.values.elementAt(index);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        view,
      ],
    );
  }
}

class _ListMangaItem extends StatelessWidget {
  const _ListMangaItem({Key? key, required this.manga}) : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                Navigator.push(context, createMangaViewRoute(manga));
              },
              child: CachedNetworkImage(
                imageUrl: manga.getCovertArtUrl(quality: CoverArtQuality.small),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 80.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: theme.colorScheme.onSurface,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.push(context, createMangaViewRoute(manga));
                    },
                    child: Text(manga.title['en']!),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MangaStatusChip(
                        status: manga.status,
                      ),
                      // TODO: rest of the info as they become available
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _GridMangaDetailedItem extends StatelessWidget {
  const _GridMangaDetailedItem({Key? key, required this.manga})
      : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  primary: theme.colorScheme.onSurface,
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              onPressed: () async {
                Navigator.push(context, createMangaViewRoute(manga));
              },
              child: Text(
                manga.title['en']!,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () async {
                      Navigator.push(context, createMangaViewRoute(manga));
                    },
                    child: CachedNetworkImage(
                        imageUrl: manga.getCovertArtUrl(
                            quality: CoverArtQuality.small),
                        placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: screenSizeSmall ? 80.0 : 128.0),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MangaStatusChip(status: manga.status),
                            // TODO: rest of the info as they become available
                          ],
                        ),
                        if (manga.description.isNotEmpty)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                manga.description.entries.first.value,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
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
        imageUrl: manga.getCovertArtUrl(quality: CoverArtQuality.medium),
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

class MangaStatusChip extends StatelessWidget {
  const MangaStatusChip({Key? key, required this.status}) : super(key: key);

  final MangaStatus status;

  @override
  Widget build(BuildContext context) {
    var iconColor = Colors.green;

    switch (status) {
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

    return IconTextChip(
      icon: Icon(
        Icons.circle,
        color: iconColor,
        size: 10,
      ),
      text: Text(
        status.formatted,
      ),
    );
  }
}
