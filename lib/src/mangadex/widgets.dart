import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/reader.dart';
import 'package:gagaku/src/mangadex/settings.dart';
import 'package:gagaku/src/reader.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    final bool screenSizeSmall = MediaQuery.of(context).size.width <= 480;
    final theme = Theme.of(context);

    String title = '';

    if (widget.chapter.chapter != null) {
      title += 'Chapter ${widget.chapter.chapter!}';
    }

    if (widget.chapter.title != null) {
      title += ' - ${widget.chapter.title!}';
    }

    if (widget.manga.readChaptersRetrieved) {
      widget.chapter.read =
          widget.manga.readChapters.contains(widget.chapter.id);
    }

    return ListTile(
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
        contentPadding:
            EdgeInsets.symmetric(horizontal: (screenSizeSmall ? 4.0 : 16.0)),
        minLeadingWidth: 0.0,
        leading: IconButton(
          onPressed: () async {
            bool set = !widget.chapter.read;
            bool result =
                await Provider.of<MangaDexModel>(context, listen: false)
                    .setChapterRead(widget.chapter, set);

            if (result) {
              // Refresh
              setState(() {
                if (set) {
                  widget.manga.readChapters.add(widget.chapter.id);
                } else {
                  widget.manga.readChapters.remove(widget.chapter.id);
                }
              });
            }
          },
          padding: const EdgeInsets.all(0.0),
          splashRadius: 15,
          iconSize: widget.chapter.read ? 15 : 10,
          tooltip: widget.chapter.read ? 'Unmark as read' : 'Mark as read',
          icon: Icon(
            widget.chapter.read ? Icons.check : Icons.circle,
            color: widget.chapter.read ? Colors.green : Colors.blue,
          ),
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
                    Container(
                      decoration: BoxDecoration(
                        color: theme.canvasColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 6.0),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Icon(Icons.language, size: 20),
                          SizedBox(width: 5),
                          Text(Languages.get(widget.chapter.translatedLanguage)
                              .name)
                        ],
                      ),
                    ),
                    SizedBox(width: 2),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.canvasColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 6.0),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Icon(Icons.group, size: 20),
                          SizedBox(width: 5),
                          Text(widget.chapter.groupName)
                        ],
                      ),
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
              ));
  }
}
