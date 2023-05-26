import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'directory_reader.g.dart';

Route createDirectoryReaderRoute(
  String path, {
  String? title,
  Widget? link,
  VoidCallback? onLinkPressed,
}) {
  return Styles.buildSlideTransitionRoute(
    (context, animation, secondaryAnimation) => DirectoryReaderWidget(
      path: path,
      title: title,
      link: link,
      onLinkPressed: onLinkPressed,
    ),
  );
}

@riverpod
Future<List<ReaderPage>> _getDirectoryPages(
    _GetDirectoryPagesRef ref, String path) async {
  final dir = Directory(path);
  final entities = await dir.list().toList();
  final files = entities.whereType<File>();

  final pageFiles = files.where((element) =>
      element.path.endsWith('.png') ||
      element.path.endsWith('.jpg') ||
      element.path.endsWith('.jpeg'));

  if (pageFiles.isNotEmpty) {
    final pages = <ReaderPage>[];
    for (final f in pageFiles) {
      pages.add(ReaderPage(provider: FileImage(f)));
    }

    return pages;
  }

  return [];
}

class DirectoryReaderWidget extends HookConsumerWidget {
  const DirectoryReaderWidget({
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
    final pages = ref.watch(_getDirectoryPagesProvider(path));
    final theme = Theme.of(context);

    String strtitle = path;

    if (title != null) {
      strtitle = title!;
    }

    return pages.when(
      skipLoadingOnReload: true,
      data: (result) {
        if (result.isEmpty) {
          return const Center(
            child: Text("This archive contains no images!"),
          );
        }

        return ReaderWidget(
          pages: result,
          pageCount: result.length,
          title: strtitle,
          isLongStrip: false, // TODO longstrip
          link: link,
          onLinkPressed: onLinkPressed,
        );
      },
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Loading directory...",
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.normal,
                fontSize: 18,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator()
          ],
        ),
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
