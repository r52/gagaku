import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/local/model.dart';
import 'package:gagaku/local/types.dart';
import 'package:gagaku/log.dart';
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

class _ExtractInfo {
  const _ExtractInfo({
    required this.type,
    required this.formats,
    required this.bytes,
  });

  final ArchiveType type;
  final FormatInfo formats;
  final Uint8List bytes;
}

@riverpod
Future<List<ReaderPage>> _getArchivePages(
    _GetArchivePagesRef ref, String path) async {
  final formats = await ref.watch(supportedFormatsProvider.future);
  final bytes = await File(path).readAsBytes();

  if (path.endsWith('.cbt') || path.endsWith('.tar')) {
    return compute(_extractArchive,
        _ExtractInfo(type: ArchiveType.tar, formats: formats, bytes: bytes));
  }

  return compute(_extractArchive,
      _ExtractInfo(type: ArchiveType.zip, formats: formats, bytes: bytes));
}

List<ReaderPage> _extractArchive(_ExtractInfo info) {
  Archive archive;

  switch (info.type) {
    case ArchiveType.tar:
      archive = TarDecoder().decodeBytes(info.bytes);
      break;
    case ArchiveType.zip:
    default:
      archive = ZipDecoder().decodeBytes(info.bytes);
      break;
  }

  final pages = <ReaderPage>[];

  for (final file in archive) {
    if (file.isFile &&
        (file.name.endsWith(".jpg") ||
            file.name.endsWith(".png") ||
            file.name.endsWith(".jpeg") ||
            (info.formats.avif && file.name.endsWith(".avif")))) {
      final data = file.content as Uint8List;
      pages.add(ReaderPage(provider: MemoryImage(data), sortKey: file.name));
    }
  }

  return pages;
}

class ArchiveReaderWidget extends ConsumerWidget {
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
    final theme = Theme.of(context);

    String strtitle = path;

    if (title != null) {
      strtitle = title!;
    }

    switch (pages) {
      case AsyncValue(:final error?, :final stackTrace?):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_getArchivePagesProvider($path) failed",
            error: error, stackTrace: stackTrace);

        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
          ),
          body: Styles.errorColumn(error, stackTrace),
        );
      case AsyncValue(:final value?):
        if (value.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
            ),
            body: const Center(
              child: Text("This archive contains no readable images!"),
            ),
          );
        }

        return ReaderWidget(
          pages: value,
          pageCount: value.length,
          title: strtitle,
          isLongStrip: false, // TODO longstrip
          link: link,
          onLinkPressed: onLinkPressed,
        );
      case _:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Extracting archive...",
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
