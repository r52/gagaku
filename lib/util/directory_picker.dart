import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/android/jni_bindings.dart' as android;
import 'package:jni/jni.dart';
import 'package:jni_flutter/jni_flutter.dart';
import 'package:path/path.dart' as p;

/// Lets the user pick a directory and returns its filesystem path, or `null`
/// if the picker was cancelled.
///
/// [FilePicker.pickDirectory] returns a `content://` document-tree URI on
/// Android. Callers of this function read the directory through `dart:io`
/// under `MANAGE_EXTERNAL_STORAGE`, so the tree is resolved to the directory
/// of the storage volume that holds it. Trees from other document providers
/// (Downloads, cloud storage) have no such path and throw
/// [DirectoryPathUnavailable].
Future<String?> pickDirectoryPath({String? dialogTitle}) async {
  final uri = await FilePicker.pickDirectory(dialogTitle: dialogTitle);
  if (uri == null) return null;
  if (!Platform.isAndroid) return uri.toFilePath();

  return resolveExternalStorageTreePath(uri) ??
      (throw DirectoryPathUnavailable(uri));
}

/// Resolves an Android external storage tree URI to the filesystem path of
/// the directory it names, or returns `null` if [uri] is not such a tree or
/// its volume is not mounted. Android only.
String? resolveExternalStorageTreePath(Uri uri) {
  final tree = ExternalStorageTree.parse(uri);
  if (tree == null) return null;
  final volumeDirectory = _androidVolumeDirectory(tree);
  return volumeDirectory == null ? null : tree.resolve(volumeDirectory);
}

/// Thrown by [pickDirectoryPath] when the picked directory has no filesystem
/// path the app can open.
final class DirectoryPathUnavailable implements Exception {
  const DirectoryPathUnavailable(this.uri);

  final Uri uri;

  @override
  String toString() => t.errors.directoryPathUnavailable;
}

/// A document tree from Android's external storage provider, such as
/// `content://com.android.externalstorage.documents/tree/primary%3AManga`.
///
/// The tree document ID is `<volume>:<path>`, where `<volume>` is `primary`
/// for the primary shared storage or the volume UUID (for example
/// `1234-ABCD`) for removable storage.
final class ExternalStorageTree {
  const ExternalStorageTree({
    required this.volumeId,
    required this.relativePath,
  });

  static const authority = 'com.android.externalstorage.documents';

  /// `primary`, or the UUID of a removable volume.
  final String volumeId;

  /// The path inside the volume, without leading or trailing separators.
  /// Empty for the volume root.
  final String relativePath;

  bool get isPrimary => volumeId.toLowerCase() == 'primary';

  /// Parses an external storage tree URI, or returns `null` for any other
  /// URI.
  static ExternalStorageTree? parse(Uri uri) {
    if (uri.scheme != 'content' || uri.authority != authority) return null;

    final segments = uri.pathSegments;
    if (segments.length != 2 || segments[0] != 'tree') return null;

    final documentId = segments[1];
    final separator = documentId.indexOf(':');
    if (separator <= 0) return null;

    final pathSegments = documentId
        .substring(separator + 1)
        .split('/')
        .where((segment) => segment.isNotEmpty)
        .toList();
    if (pathSegments.any((segment) => segment == '.' || segment == '..')) {
      return null;
    }

    return ExternalStorageTree(
      volumeId: documentId.substring(0, separator),
      relativePath: pathSegments.join('/'),
    );
  }

  /// Whether this tree lives on a volume with the given properties.
  bool matchesVolume({required bool isPrimary, required String? uuid}) =>
      this.isPrimary
      ? isPrimary
      : uuid != null && uuid.toLowerCase() == volumeId.toLowerCase();

  /// The filesystem path of this tree, given its volume's [volumeDirectory].
  String resolve(String volumeDirectory) => relativePath.isEmpty
      ? volumeDirectory
      : p.posix.join(volumeDirectory, relativePath);
}

/// Returns the mounted directory of the storage volume holding [tree], or
/// `null` if no mounted volume matches.
String? _androidVolumeDirectory(ExternalStorageTree tree) => using((arena) {
  final context = (androidApplicationContext as android.Context)
    ..releasedBy(arena);
  final serviceName = android.Context.STORAGE_SERVICE?..releasedBy(arena);
  final manager = context.getSystemService$1(serviceName)?..releasedBy(arena);
  if (manager == null) return null;

  final volumes = (manager as android.StorageManager).storageVolumes
    ?..releasedBy(arena);
  if (volumes == null) return null;

  for (final volume in volumes.asDart()) {
    if (volume == null) continue;
    volume.releasedBy(arena);
    final uuid = volume.uuid?.toDartString(releaseOriginal: true);
    if (!tree.matchesVolume(isPrimary: volume.isPrimary, uuid: uuid)) {
      continue;
    }
    // `getDirectory()` is null while the volume is not mounted.
    final directory = volume.directory?..releasedBy(arena);
    return directory?.absolutePath?.toDartString(releaseOriginal: true);
  }
  return null;
});
