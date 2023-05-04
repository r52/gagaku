import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'archive_reader.g.dart';

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
    ),
  );
}

@riverpod
Future<List<ReaderPage>> _getArchivePages(
    _GetArchivePagesRef ref, String path) async {
  final bytes = await File(path).readAsBytes();

  return compute(_extractArchive, bytes);
}

List<ReaderPage> _extractArchive(Uint8List bytes) {
  final archive = ZipDecoder().decodeBytes(bytes);

  final pages = <ReaderPage>[];

  for (final file in archive) {
    if (file.isFile &&
        (file.name.endsWith(".jpg") ||
            file.name.endsWith(".png") ||
            file.name.endsWith(".jpeg"))) {
      final data = file.content as Uint8List;
      pages.add(ReaderPage(provider: MemoryImage(data)));
    }
  }

  return pages;
}

class ArchiveReaderWidget extends HookConsumerWidget {
  const ArchiveReaderWidget({
    super.key,
    required this.path,
    this.title,
    this.link,
    this.onLinkPressed,
  });

  final String path;
  final String? title;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pages = ref.watch(_getArchivePagesProvider(path));

    String strtitle = path;

    if (title != null) {
      strtitle = title!;
    }

    return pages.when(
      skipLoadingOnReload: true,
      data: (result) {
        return ReaderWidget(
          pages: result,
          pageCount: result.length,
          title: strtitle,
          isLongStrip: false, // TODO longstrip
          link: link,
          onLinkPressed: onLinkPressed,
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stackTrace) {
        final messenger = ScaffoldMessenger.of(context);
        Future.delayed(
          Duration.zero,
          () => messenger
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('$err'),
                backgroundColor: Colors.red,
              ),
            ),
        );

        return Text('Error: $err');
      },
    );
  }
}
