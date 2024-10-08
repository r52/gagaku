import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/local/model.dart';
import 'package:gagaku/local/types.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'archive_reader.g.dart';

class ArchiveReaderRouteBuilder<T> extends SlideTransitionRouteBuilder<T> {
  final String path;
  final String? title;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  ArchiveReaderRouteBuilder({
    required this.path,
    this.title,
    this.link,
    this.onLinkPressed,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ArchiveReaderWidget(
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
    required this.path,
  });

  final ArchiveType type;
  final FormatInfo formats;
  final String path;
}

@riverpod
Future<List<ReaderPage>> _getArchivePages(
    _GetArchivePagesRef ref, String path) async {
  final formats = await ref.watch(supportedFormatsProvider.future);
  var type = ArchiveType.zip;

  if (path.endsWith('.cbt') || path.endsWith('.tar')) {
    type = ArchiveType.tar;
  }

  final pages = await compute(
      _extractArchive, _ExtractInfo(type: type, formats: formats, path: path));

  /// pages MUST be cleared on dispose otherwise MemoryImage and its
  /// accompanying Uint8List buffer won't get GC'd for whatever reason
  ref.onDispose(() {
    pages.clear();
  });

  return pages;
}

Future<List<ReaderPage>> _extractArchive(_ExtractInfo info) async {
  Archive archive;
  final file = InputFileStream(info.path);

  switch (info.type) {
    case ArchiveType.tar:
      archive = TarDecoder().decodeBuffer(file);
      break;
    case ArchiveType.zip:
    default:
      archive = ZipDecoder().decodeBuffer(file);
      break;
  }

  final pages = <ReaderPage>[];

  for (final file in archive) {
    if (file.isFile &&
        (file.name.endsWith(".jpg") ||
            file.name.endsWith(".png") ||
            file.name.endsWith(".jpeg") ||
            (info.formats.avif && file.name.endsWith(".avif")))) {
      pages.add(ReaderPage(
        provider: MemoryImage(file.content as Uint8List),
        sortKey: file.name,
      ));
    }
  }

  await archive.clear();

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
    final pageProvider = ref.watch(_getArchivePagesProvider(path));

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
            message: "_getArchivePagesProvider($path) failed",
          ),
        );
      case AsyncValue(value: final pages?):
        if (pages.isEmpty) {
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
                "Extracting archive...",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
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
