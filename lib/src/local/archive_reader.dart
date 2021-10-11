import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/reader.dart';
import 'package:gagaku/src/ui.dart';

Route createArchiveReaderRoute(
  String path, {
  String? title,
  Widget? link,
  VoidCallback? onLinkPressed,
}) {
  return Styles.buildSlideTransitionRoute(
      (context, animation, secondaryAnimation) => ArchiveReaderWidget(
            path: path,
            title: title,
            link: link,
            onLinkPressed: onLinkPressed,
          ));
}

List<ReaderPage> _extractArchive(Uint8List bytes) {
  final archive = ZipDecoder().decodeBytes(bytes);

  var pages = <ReaderPage>[];

  for (final file in archive) {
    if (file.isFile) {
      final data = file.content as Uint8List;
      pages.add(ReaderPage(provider: MemoryImage(data)));
    }
  }

  return pages;
}

class ArchiveReaderWidget extends StatefulWidget {
  const ArchiveReaderWidget({
    Key? key,
    required this.path,
    this.title,
    this.link,
    this.onLinkPressed,
  }) : super(key: key);

  final String path;
  final String? title;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  _ArchiveReaderWidgetState createState() => _ArchiveReaderWidgetState();
}

class _ArchiveReaderWidgetState extends State<ArchiveReaderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<ReaderPage>> _getPages(String path) async {
    final bytes = await File(path).readAsBytes();

    return compute(_extractArchive, bytes);
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.path;

    if (widget.title != null) {
      title = widget.title!;
    }

    return FutureBuilder<List<ReaderPage>>(
      future: _getPages(widget.path),
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
