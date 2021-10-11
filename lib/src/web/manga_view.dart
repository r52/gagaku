import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/ui.dart';
import 'package:gagaku/src/util.dart';
import 'package:gagaku/src/web/reader.dart';
import 'package:gagaku/src/web/types.dart';
import 'package:timeago/timeago.dart' as timeago;

Route createMangaViewRoute(WebManga manga) {
  return Styles.buildSlideTransitionRoute(
      (context, animation, secondaryAnimation) => WebMangaViewWidget(
            manga: manga,
          ));
}

class WebMangaViewWidget extends StatefulWidget {
  const WebMangaViewWidget({Key? key, required this.manga}) : super(key: key);

  final WebManga manga;

  @override
  _WebMangaViewWidgetState createState() => _WebMangaViewWidgetState();
}

class _WebMangaViewWidgetState extends State<WebMangaViewWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        scrollBehavior: MouseTouchScrollBehavior(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.manga.title,
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
                imageUrl: widget.manga.coverArt,
                placeholder: (context, url) => Container(
                  child: Styles.buildCenterSpinner(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          if (widget.manga.description.length > 0)
            SliverToBoxAdapter(
              child: ExpansionTile(
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                title: Text('Synopsis'),
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    color: theme.backgroundColor,
                    child: Text(widget.manga.description),
                  ),
                ],
              ),
            ),
          SliverToBoxAdapter(
            child: ExpansionTile(
              title: Text('Info'),
              children: [
                ExpansionTile(
                  title: Text('Author'),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: theme.backgroundColor,
                      child: Row(
                        children: [
                          IconTextChip(
                            text: Text(widget.manga.author),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('Artist'),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: theme.backgroundColor,
                      child: Row(
                        children: [
                          IconTextChip(
                            text: Text(widget.manga.artist),
                          )
                        ],
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
                var e = widget.manga.chapters.elementAt(index);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: ChapterButtonWidget(
                    chapter: e,
                    manga: widget.manga,
                    link: Text(
                      widget.manga.title,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
              childCount: widget.manga.chapters.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ChapterButtonWidget extends StatefulWidget {
  const ChapterButtonWidget({
    Key? key,
    required this.chapter,
    required this.manga,
    this.link,
    this.onLinkPressed,
  }) : super(key: key);

  final WebChapter chapter;
  final WebManga manga;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  _ChapterButtonWidgetState createState() => _ChapterButtonWidgetState();
}

class _ChapterButtonWidgetState extends State<ChapterButtonWidget> {
  String getImgurSource(String proxy) {
    var split = proxy.split('/');
    split.removeWhere((element) => element.isEmpty);

    return split.last;
  }

  @override
  Widget build(BuildContext context) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);

    String title = 'Chapter ${widget.chapter.chapter}';

    if (widget.chapter.title.isNotEmpty) {
      title += ' - ${widget.chapter.title}';
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: theme.backgroundColor, width: 4.0),
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              createWebGalleryReaderRoute(
                  getImgurSource(widget.chapter.groups.entries.first.value),
                  title: title,
                  manga: widget.manga,
                  link: widget.link,
                  onLinkPressed: widget.onLinkPressed));
        },
        tileColor: theme.backgroundColor,
        dense: true,
        minVerticalPadding: 0.0,
        contentPadding:
            EdgeInsets.symmetric(horizontal: (screenSizeSmall ? 4.0 : 10.0)),
        minLeadingWidth: 0.0,
        title: Text(
          title,
          style: TextStyle(color: theme.colorScheme.primary),
        ),
        trailing: !screenSizeSmall
            ? FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconTextChip(
                      icon: Icon(Icons.group, size: 20),
                      text: Text(widget.chapter.groups.entries.first.key),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.schedule, size: 20),
                    SizedBox(width: 5),
                    Text(timeago.format(widget.chapter.lastUpdated))
                  ],
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule, size: 15),
                  SizedBox(width: 5),
                  Text(timeago.format(widget.chapter.lastUpdated))
                ],
              ),
      ),
    );
  }
}
