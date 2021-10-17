import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gagaku/src/local/types.dart';
import 'package:gagaku/src/ui.dart';
import 'package:mime/mime.dart';

class MangaListWidget extends StatefulWidget {
  const MangaListWidget({
    Key? key,
    required this.title,
    required this.items,
    this.leading = const <Widget>[],
    this.restorationId,
    this.physics,
  }) : super(key: key);

  final Widget title;
  final Iterable<LocalManga> items;
  final List<Widget> leading;
  final String? restorationId;
  final ScrollPhysics? physics;

  @override
  _MangaListWidgetState createState() => _MangaListWidgetState();
}

class _MangaListWidgetState extends State<MangaListWidget> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                // TODO sorting
              ],
            ),
          ),
        ),
        SliverGrid.extent(
          maxCrossAxisExtent: 256,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.7,
          children: widget.items
              .map((manga) => _GridMangaItem(manga: manga))
              .toList(),
        ),
      ],
    );
  }
}

class _GridMangaItem extends StatelessWidget {
  const _GridMangaItem({Key? key, required this.manga}) : super(key: key);

  final LocalManga manga;

  bool isImage(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType != null ? mimeType.startsWith('image/') : false;
  }

  Future<String> _getCoverArt() async {
    Directory mangaDir = Directory(manga.path);

    if (!mangaDir.existsSync()) {
      return '';
    }

    final children = mangaDir.list();
    final chapterDir = await children
        .firstWhere((element) => element is Directory) as Directory;
    final pages = chapterDir.list();
    final cover = await pages
        .firstWhere((element) => element is File && isImage(element.path));

    return cover.path;
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: FutureBuilder<String>(
          future: _getCoverArt(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Styles.buildCenterSpinner();
            }

            if (snapshot.hasData) {
              return Image.file(
                File(snapshot.data!),
                width: 256.0,
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
          }),
    );

    return InkWell(
      onTap: () {
        // TODO manga view
        // Navigator.push(context, createMangaViewRoute(manga));
      },
      child: GridTile(
        footer: Material(
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius:
                const BorderRadius.vertical(bottom: const Radius.circular(4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridTileBar(
            backgroundColor: Colors.black45,
            title: FittedBox(
              fit: BoxFit.none,
              alignment: AlignmentDirectional.centerStart,
              child: Text(manga.name),
            ),
          ),
        ),
        child: image,
      ),
    );
  }
}
