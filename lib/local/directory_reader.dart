import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/local/model.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
Future<List<ReaderPage>> _getDirectoryPages(_GetDirectoryPagesRef ref, String path) async {
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

class DirectoryReaderWidget extends ConsumerWidget {
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
    final pageProvider = ref.watch(_getDirectoryPagesProvider(path));
    final theme = Theme.of(context);

    String strtitle = path;

    if (title != null) {
      strtitle = title!;
    }

    switch (pageProvider) {
      case AsyncValue(:final error?, :final stackTrace?):
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
          ),
          body: ErrorColumn(
            error: error,
            stackTrace: stackTrace,
            message: "_getDirectoryPagesProvider($path) failed",
          ),
        );
      case AsyncValue(value: final pages?):
        if (pages.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
            ),
            body: const Center(
              child: Text("This directory contains no readable images!"),
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
      case _:
        return Center(
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
        );
    }
  }
}
