import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/web/api.dart';
import 'package:gagaku/src/web/types.dart';
import 'package:gagaku/src/reader.dart';
import 'package:gagaku/src/ui.dart';

Route createWebGalleryReaderRoute(String src, String? title, WebManga? manga,
    Widget? link, VoidCallback? onLinkPressed) {
  return Styles.buildSlideTransitionRoute(
      (context, animation, secondaryAnimation) => WebGalleryReaderWidget(
            source: src,
            title: title,
            manga: manga,
            link: link,
            onLinkPressed: onLinkPressed,
          ));
}

class WebGalleryReaderWidget extends StatefulWidget {
  const WebGalleryReaderWidget({
    Key? key,
    required this.source,
    this.title,
    this.manga,
    this.link,
    this.onLinkPressed,
  }) : super(key: key);

  final String source;
  final String? title;
  final WebManga? manga;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  _WebGalleryReaderState createState() => _WebGalleryReaderState();
}

class _WebGalleryReaderState extends State<WebGalleryReaderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<ReaderPage>> _getPages(String src) async {
    final pages = await WebGalleryAPI.getImgurPages(src);

    return pages
        .map((e) =>
            ReaderPage(provider: CachedNetworkImageProvider(e, cacheKey: e)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.source;

    if (widget.title != null) {
      title = widget.title!;
    }

    return FutureBuilder<List<ReaderPage>>(
      future: _getPages(widget.source),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ReaderWidget(
            pages: snapshot.data!,
            pageCount: snapshot.data!.length,
            title: title,
            link: widget.link,
            onLinkPressed: widget.onLinkPressed,
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
