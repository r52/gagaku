import 'dart:io';

import 'package:gagaku/local/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.g.dart';

class LocalLibraryItem {
  LocalLibraryItem({
    required this.path,
    this.name,
    this.isDirectory = false,
    this.isReadable = false,
    this.parent,
  });

  String path;
  String? name;
  bool isDirectory;
  bool isReadable;
  LocalLibraryItem? parent;
  List<LocalLibraryItem> children = [];
}

@Riverpod(keepAlive: true)
class LocalLibrary extends _$LocalLibrary {
  Future<LocalLibraryItem?> _processDirectory(
      Directory dir, LocalLibraryItem? parent) async {
    final entities = await dir.list().toList();
    final files = entities.whereType<File>();
    final name = (dir.uri.pathSegments.length - 2 >= 0)
        ? dir.uri.pathSegments.elementAt(dir.uri.pathSegments.length - 2)
        : dir.path;

    final res = LocalLibraryItem(
        path: dir.path, name: name, isDirectory: true, parent: parent);

    final isReadable = files.isNotEmpty &&
        files.every((element) =>
            element.path.endsWith(".jpg") ||
            element.path.endsWith(".png") ||
            element.path.endsWith(".jpeg"));

    res.isReadable = isReadable;

    if (res.isReadable) {
      return res;
    }

    for (final e in files) {
      final p = await _processFile(e, res);
      if (p != null) {
        res.children.add(p);
      }
    }

    final dirs = entities.whereType<Directory>();
    for (final e in dirs) {
      final p = await _processDirectory(e, res);
      if (p != null) {
        res.children.add(p);
      }
    }

    if (res.children.isNotEmpty) {
      return res;
    }

    return null;
  }

  Future<LocalLibraryItem?> _processFile(
      File file, LocalLibraryItem? parent) async {
    if (file.path.endsWith('.cbz') ||
        file.path.endsWith('.zip') ||
        file.path.endsWith('.cbt') ||
        file.path.endsWith('.tar')) {
      return LocalLibraryItem(
          path: file.path,
          name: file.uri.pathSegments.last,
          isReadable: true,
          parent: parent);
    }

    return null;
  }

  Future<LocalLibraryItem> _scanLibrary() async {
    final cfg = ref.watch(localConfigProvider);
    if (cfg.libraryDirectory.isNotEmpty) {
      final top =
          LocalLibraryItem(path: cfg.libraryDirectory, isDirectory: true);

      final dir = Directory(cfg.libraryDirectory);
      final entities = await dir.list().toList();

      for (final e in entities) {
        if (e is File) {
          final p = await _processFile(e, top);
          if (p != null) {
            top.children.add(p);
          }
        } else if (e is Directory) {
          final p = await _processDirectory(e, top);
          if (p != null) {
            top.children.add(p);
          }
        }

        // otherwise skip
      }

      return top;
    }

    return LocalLibraryItem(path: '');
  }

  @override
  FutureOr<LocalLibraryItem> build() async {
    return _scanLibrary();
  }

  Future<void> rescan() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _scanLibrary();
    });
  }
}
