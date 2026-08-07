import 'dart:io';

import 'package:path/path.dart' as p;

import 'package:gagaku/sync/store.dart';

/// A [SyncStore] rooted at an ordinary path available through `dart:io`.
///
/// Object keys always use `/` separators, independent of the host platform.
/// The configured root is the trust boundary; links below it are never
/// followed so a remote directory cannot redirect operations outside it.
final class FilesystemSyncStore implements SyncStore {
  FilesystemSyncStore(String rootPath) : _root = Directory(_rootPath(rootPath));

  final Directory _root;

  String get rootPath => _root.path;

  @override
  Future<void> create(String key, List<int> bytes) async {
    final segments = _keySegments(key);
    final content = List<int>.of(bytes);
    await _ensureParentDirectories(segments);
    final file = File(_pathForSegments(segments));
    var created = false;

    try {
      await file.create(exclusive: true);
      created = true;
    } on PathExistsException {
      throw SyncObjectAlreadyExistsException(key);
    }

    try {
      final handle = await file.open(mode: FileMode.writeOnly);
      try {
        await handle.writeFrom(content);
        await handle.flush();
      } finally {
        await handle.close();
      }
    } catch (_) {
      if (created) {
        try {
          await file.delete();
        } catch (_) {
          // A failed cleanup leaves an invalid object for repository validation.
        }
      }
      rethrow;
    }
  }

  @override
  Future<void> delete(String key) async {
    final segments = _keySegments(key);
    if (!await _safeParentsExist(segments)) return;
    final file = File(_pathForSegments(segments));
    final type = await FileSystemEntity.type(file.path, followLinks: false);
    switch (type) {
      case FileSystemEntityType.notFound:
        return;
      case FileSystemEntityType.file:
        await file.delete();
      case FileSystemEntityType.link:
        throw FileSystemException(
          'Refusing to delete a linked sync object',
          file.path,
        );
      default:
        throw FileSystemException('Sync object is not a file', file.path);
    }
  }

  @override
  Future<List<SyncObject>> list(String prefix) async {
    _validatePrefix(prefix);
    if (!await _root.exists()) return const [];

    final objects = <SyncObject>[];
    await _listDirectory(_root, const [], prefix, objects);
    objects.sort((left, right) => left.key.compareTo(right.key));
    return List.unmodifiable(objects);
  }

  @override
  Future<List<int>> read(String key) async {
    final segments = _keySegments(key);
    if (!await _safeParentsExist(segments)) {
      throw SyncObjectNotFoundException(key);
    }
    final file = File(_pathForSegments(segments));
    final type = await FileSystemEntity.type(file.path, followLinks: false);
    if (type == FileSystemEntityType.notFound) {
      throw SyncObjectNotFoundException(key);
    }
    if (type != FileSystemEntityType.file) {
      throw FileSystemException('Sync object is not a regular file', file.path);
    }
    return file.readAsBytes();
  }

  Future<void> _listDirectory(
    Directory directory,
    List<String> parentSegments,
    String prefix,
    List<SyncObject> output,
  ) async {
    await for (final entity in directory.list(followLinks: false)) {
      final name = p.basename(entity.path);
      if (!_isSafeSegment(name)) continue;
      final segments = [...parentSegments, name];
      final key = segments.join('/');
      final type = await FileSystemEntity.type(entity.path, followLinks: false);
      if (type == FileSystemEntityType.directory) {
        await _listDirectory(Directory(entity.path), segments, prefix, output);
      } else if (type == FileSystemEntityType.file && key.startsWith(prefix)) {
        try {
          output.add(
            SyncObject(key: key, length: await File(entity.path).length()),
          );
        } on FileSystemException {
          // An eventually consistent provider may remove an entry mid-list.
        }
      }
    }
  }

  Future<void> _ensureParentDirectories(List<String> segments) async {
    await _root.create(recursive: true);
    var current = _root.path;
    for (final segment in segments.take(segments.length - 1)) {
      current = p.join(current, segment);
      final type = await FileSystemEntity.type(current, followLinks: false);
      switch (type) {
        case FileSystemEntityType.notFound:
          await Directory(current).create();
        case FileSystemEntityType.directory:
          break;
        case FileSystemEntityType.link:
          throw FileSystemException(
            'Refusing to follow a linked sync directory',
            current,
          );
        default:
          throw FileSystemException(
            'Sync path component is not a directory',
            current,
          );
      }
    }
    await _safeParentsExist(segments);
  }

  Future<bool> _safeParentsExist(List<String> segments) async {
    var current = _root.path;
    for (final segment in segments.take(segments.length - 1)) {
      current = p.join(current, segment);
      final type = await FileSystemEntity.type(current, followLinks: false);
      if (type == FileSystemEntityType.link) {
        throw FileSystemException(
          'Refusing to follow a linked sync directory',
          current,
        );
      }
      if (type == FileSystemEntityType.notFound) return false;
      if (type != FileSystemEntityType.directory) {
        throw FileSystemException(
          'Sync path component is not a directory',
          current,
        );
      }
    }
    return true;
  }

  String _pathForSegments(List<String> segments) {
    final path = p.normalize(p.joinAll([_root.path, ...segments]));
    if (!p.isWithin(_root.path, path)) {
      throw ArgumentError.value(segments.join('/'), 'key', 'escapes root');
    }
    return path;
  }

  static String _rootPath(String value) {
    if (value.trim().isEmpty) {
      throw ArgumentError.value(value, 'rootPath', 'must not be empty');
    }
    if (RegExp(r'^[A-Za-z][A-Za-z0-9+.-]*://').hasMatch(value)) {
      throw ArgumentError.value(
        value,
        'rootPath',
        'must be a filesystem path, not a URI',
      );
    }
    return p.normalize(p.absolute(value));
  }

  static List<String> _keySegments(String key) {
    if (key.isEmpty || key.endsWith('/')) {
      throw ArgumentError.value(key, 'key', 'must identify an object');
    }
    _validatePrefix(key);
    return key.split('/');
  }

  static void _validatePrefix(String prefix) {
    if (prefix.startsWith('/') ||
        prefix.contains(r'\') ||
        prefix.contains('\u0000') ||
        prefix.contains(':')) {
      throw ArgumentError.value(prefix, 'prefix', 'is not a safe object key');
    }
    final value = prefix.endsWith('/')
        ? prefix.substring(0, prefix.length - 1)
        : prefix;
    if (value.isEmpty) return;
    if (value.split('/').any((segment) => !_isSafeSegment(segment))) {
      throw ArgumentError.value(prefix, 'prefix', 'is not a safe object key');
    }
  }

  static bool _isSafeSegment(String segment) =>
      segment.isNotEmpty && segment != '.' && segment != '..';
}
