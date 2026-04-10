import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:collection/collection.dart';
import 'package:gagaku/local/model/model.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pool/pool.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'archive_thumbnail_provider.g.dart';

final _thumbnailPool = Pool(1);

int extractArchiveHash(String archivePath, int modifiedMs) {
  int hash = 5381;
  String input = '${archivePath}_$modifiedMs';
  for (int i = 0; i < input.length; i++) {
    hash = ((hash << 5) + hash) + input.codeUnitAt(i);
  }
  return hash;
}

Future<String?> _extractThumbnail(String archivePath, String destPath) async {
  final file = InputFileStream(archivePath);
  Archive archive;
  final lpath = archivePath.toLowerCase();

  if (lpath.endsWith('.tar') || lpath.endsWith('.cbt')) {
    archive = TarDecoder().decodeStream(file);
  } else {
    archive = ZipDecoder().decodeStream(file);
  }

  final imageFiles = archive.where((f) {
    if (!f.isFile) return false;
    final name = f.name.toLowerCase();
    return name.endsWith('.jpg') ||
        name.endsWith('.jpeg') ||
        name.endsWith('.png') ||
        name.endsWith('.webp') ||
        name.endsWith('.avif');
  }).toList();

  if (imageFiles.isEmpty) {
    throw Exception('No images found in archive');
  }

  imageFiles.sort((a, b) => compareNatural(a.name, b.name));

  final firstImage = imageFiles.first;

  final rawBytes = firstImage.content as List<int>;

  final image = img.decodeImage(Uint8List.fromList(rawBytes));
  if (image != null) {
    final resized = img.copyResize(image, width: 256);
    final jpgBytes = img.encodeJpg(resized, quality: 85);

    final destFile = File(destPath);
    await destFile.parent.create(recursive: true);
    await destFile.writeAsBytes(jpgBytes);
    return destPath;
  }

  return null;
}

Future<String> sweepArchiveThumbnailsIsolate(Map<String, dynamic> args) async {
  final thumbDirPath = args['thumbDirPath'] as String;
  final validHashes = args['validHashes'] as Set<String>;

  final thumbDir = Directory(thumbDirPath);
  if (!await thumbDir.exists()) return 'Done';

  final cacheFiles = await thumbDir.list().toList();
  for (final file in cacheFiles) {
    if (file is File) {
      final baseName = p.basenameWithoutExtension(file.path);
      if (!validHashes.contains(baseName)) {
        try {
          await file.delete();
        } catch (_) {}
      }
    }
  }

  return 'Done';
}

void triggerThumbnailGarbageCollection(LocalLibraryItem rootItem) async {
  final validHashes = <String>{};

  void traverse(LocalLibraryItem item) {
    if (item.type == LibraryItemType.archive) {
      validHashes.add(
        extractArchiveHash(
          item.path,
          item.modified.millisecondsSinceEpoch,
        ).toString(),
      );
    }
    for (final child in item.children) {
      traverse(child);
    }
  }

  traverse(rootItem);

  final cacheDir = await getApplicationCacheDirectory();
  final thumbDirPath = p.join(cacheDir.path, 'gagaku_archive_thumbs');

  Isolate.run(
    () => sweepArchiveThumbnailsIsolate({
      'thumbDirPath': thumbDirPath,
      'validHashes': validHashes,
    }),
  );
}

@riverpod
Future<String?> archiveThumbnail(Ref ref, LocalLibraryItem item) async {
  if (item.type != LibraryItemType.archive || item.thumbnail == null) {
    return item.thumbnail;
  }

  final cacheDir = await getApplicationCacheDirectory();
  final thumbDir = Directory(p.join(cacheDir.path, 'gagaku_archive_thumbs'));

  final hashToken = extractArchiveHash(
    item.path,
    item.modified.millisecondsSinceEpoch,
  );
  final destPath = p.join(thumbDir.path, '$hashToken.jpg');

  if (await File(destPath).exists()) {
    return destPath;
  }

  // To prevent main thread lag, run this inside an isolate
  return await _thumbnailPool.withResource(
    () => Isolate.run(() => _extractThumbnail(item.path, destPath)),
  );
}
