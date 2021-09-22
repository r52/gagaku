import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/reader.dart';
import 'package:provider/provider.dart';

Route createMangaDexReaderRoute(Chapter chapter, Manga manga) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        MangaDexReaderWidget(
      chapter: chapter,
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

class MangaDexReaderWidget extends StatefulWidget {
  const MangaDexReaderWidget(
      {Key? key, required this.chapter, required this.manga})
      : super(key: key);

  final Chapter chapter;
  final Manga manga;

  @override
  _MangaDexReaderState createState() => _MangaDexReaderState();
}

class _MangaDexReaderState extends State<MangaDexReaderWidget> {
  late Future<List<ReaderPage>> _pages;

  @override
  void initState() {
    super.initState();

    var dataSaver =
        Provider.of<MangaDexModel>(context, listen: false).settings.dataSaver;

    _pages = Provider.of<MangaDexModel>(context, listen: false)
        .getChapterServer(widget.chapter)
        .then((server) {
      var chData = dataSaver ? widget.chapter.dataSaver : widget.chapter.data;

      List<ReaderPage> pages = chData.map((e) {
        var url = server + e;
        return ReaderPage(url: url, key: e);
      }).toList();
      return pages;
    });

    // Mark as read if not read
    if (!widget.chapter.read) {
      Provider.of<MangaDexModel>(context, listen: false)
          .setChapterRead(widget.chapter, true)
          .then((result) {
        if (result) {
          widget.manga.readChapters.add(widget.chapter.id);
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _pages.then((pages) {
      pages.forEach((element) {
        precacheImage(
            CachedNetworkImageProvider(element.url, cacheKey: element.key),
            context);
      });
    });
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
              title: '${widget.manga.title['en']!} - $title');
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
  }
}
