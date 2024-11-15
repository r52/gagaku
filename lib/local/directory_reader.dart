import 'dart:io';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/local/model.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/util/ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'directory_reader.g.dart';

class DirectoryReaderRouteBuilder<T> extends SlideTransitionRouteBuilder<T> {
  final String path;
  final String? title;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  DirectoryReaderRouteBuilder({
    required this.path,
    this.title,
    this.link,
    this.onLinkPressed,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => DirectoryReaderWidget(
            path: path,
            title: title,
            link: link,
            onLinkPressed: onLinkPressed,
          ),
        );
}

@riverpod
Future<List<ReaderPage>> _getDirectoryPages(Ref ref, String path) async {
  final formats = await ref.watch(supportedFormatsProvider.future);
  final dir = Directory(path);
  final entities = await dir.list().toList();
  final files = entities.whereType<File>();

  final pageFiles = files
      .where((element) =>
          element.path.endsWith('.png') ||
          element.path.endsWith('.jpg') ||
          element.path.endsWith('.jpeg') ||
          (formats.avif && element.path.endsWith(".avif")))
      .toList();

  pageFiles.sort((a, b) => compareNatural(a.uri.pathSegments.last, b.uri.pathSegments.last));

  if (pageFiles.isEmpty) {
    return [];
  }

  final pages = <ReaderPage>[];
  for (final f in pageFiles) {
    pages.add(ReaderPage(provider: FileImage(f), sortKey: f.uri.pathSegments.last));
  }

  ref.onDispose(() {
    pages.clear();
  });

  return pages;
}

class DirectoryReaderWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String strtitle = path;

    if (title != null) {
      strtitle = title!;
    }

    return DataProviderWhenWidget(
      provider: _getDirectoryPagesProvider(path),
      errorBuilder: (context, child) => Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
        ),
        body: child,
      ),
      builder: (context, pages) {
        if (pages.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
            ),
            body: Center(
              child: Text('localLibrary.dirUnreadableWarning'.tr(context: context)),
            ),
          );
        }

        return ReaderWidget(
          pages: pages,
          title: strtitle,
          longstrip: false,
          link: link,
          onLinkPressed: onLinkPressed,
        );
      },
      loadingWidget: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20.0,
          children: [
            Text(
              'localLibrary.loadingDir'.tr(context: context),
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.normal,
                fontSize: 18,
                decoration: TextDecoration.none,
              ),
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
