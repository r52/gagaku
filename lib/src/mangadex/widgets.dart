import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/reader.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChapterButtonWidget extends StatefulWidget {
  const ChapterButtonWidget(
      {Key? key, required this.chapter, required this.manga})
      : super(key: key);

  final Chapter chapter;
  final Manga manga;

  @override
  _ChapterButtonWidgetState createState() => _ChapterButtonWidgetState();
}

class _ChapterButtonWidgetState extends State<ChapterButtonWidget> {
  @override
  Widget build(BuildContext context) {
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
                  context, createReaderRoute(widget.chapter, widget.manga))
              .then((value) {
            // Refresh this when reader view is closed to update read status
            setState(() {});
          });
        },
        tileColor: theme.backgroundColor,
        dense: true,
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
        ),
        title: Text(
          title,
          style: TextStyle(
              color: (widget.chapter.read
                  ? theme.highlightColor
                  : theme.colorScheme.primary)),
        ),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.canvasColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
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
        ));
  }
}
