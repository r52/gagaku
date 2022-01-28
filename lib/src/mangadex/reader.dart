import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/types.dart';
import 'package:gagaku/src/reader.dart';
import 'package:gagaku/src/ui.dart';
import 'package:provider/provider.dart';

Route createMangaDexReaderRoute(
    Chapter chapter, Manga manga, Widget? link, VoidCallback? onLinkPressed) {
  return Styles.buildSlideTransitionRoute(
      (context, animation, secondaryAnimation) => MangaDexReaderWidget(
            chapter: chapter,
            manga: manga,
            link: link,
            onLinkPressed: onLinkPressed,
          ));
}

class MangaDexReaderWidget extends StatefulWidget {
  const MangaDexReaderWidget({
    Key? key,
    required this.chapter,
    required this.manga,
    this.link,
    this.onLinkPressed,
  }) : super(key: key);

  final Chapter chapter;
  final Manga manga;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  _MangaDexReaderState createState() => _MangaDexReaderState();
}

class _MangaDexReaderState extends State<MangaDexReaderWidget> {
  late Future<List<ReaderPage>> _pages;

  @override
  void initState() {
    super.initState();

    _pages = Provider.of<MangaDexModel>(context, listen: false)
        .getChapterServer(widget.chapter)
        .then((data) {
      List<ReaderPage> pages = data.pages.map((page) {
        var url = data.baseUrl + page;
        return ReaderPage(
            provider: CachedNetworkImageProvider(url, cacheKey: page));
      }).toList();
      return pages;
    });

    // Mark as read if not read
    if (!widget.chapter.read) {
      Provider.of<MangaDexModel>(context, listen: false)
          .setChapterRead(widget.chapter, true)
          .then((result) {
        if (result && widget.manga.readChapters != null) {
          widget.manga.readChapters!.add(widget.chapter.id);
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = '';

    if (widget.chapter.chapter != null) {
      title += 'Chapter ${widget.chapter.chapter!}';
    }

    if (widget.chapter.title != null) {
      title += ' - ${widget.chapter.title!}';
    }

    return FutureBuilder<List<ReaderPage>>(
      future: _pages,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ReaderWidget(
            pages: snapshot.data!,
            pageCount: snapshot.data!.length,
            title: '${widget.manga.title.entries.first.value} - $title',
            link: widget.link,
            onLinkPressed: widget.onLinkPressed,
            externalUrl: widget.chapter.externalUrl,
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
  }
}
