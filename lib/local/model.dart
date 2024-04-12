import 'dart:io';

import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:gagaku/local/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.g.dart';

enum LibraryItemType { directory, archive }

int compareLibraryItems(LocalLibraryItem a, LocalLibraryItem b) {
  if (!a.isReadable && b.isReadable) {
    return -1;
  }

  if (a.isReadable && !b.isReadable) {
    return 1;
  }

  return compareNatural(a.name ?? a.path, b.name ?? b.path);
}

LocalLibraryItem? libraryItemBinarySearch(
    List<LocalLibraryItem> list, int low, int high, LocalLibraryItem item) {
  if (low > high) {
    return null;
  }

  int middle = (low + high) >> 1;

  final mid = list.elementAt(middle);
  if (mid.type == item.type && mid.path == item.path) {
    return mid;
  }

  if (compareLibraryItems(item, mid) > 0) {
    return libraryItemBinarySearch(list, middle + 1, high, item);
  }

  return libraryItemBinarySearch(list, low, middle - 1, item);
}

LocalLibraryItem? findLibraryItem(LocalLibraryItem old, LocalLibraryItem curr) {
  if (curr.type == old.type && curr.path == old.path) {
    return curr;
  }

  final children = curr.children
      .where((element) =>
          old.type == element.type && old.isReadable == element.isReadable)
      .toList();

  if (children.isNotEmpty) {
    final result = libraryItemBinarySearch(children, 0, children.length, old);

    if (result != null) {
      return result;
    }

    for (final e in children) {
      final cres = findLibraryItem(old, e);
      if (cres != null) {
        return cres;
      }
    }
  }

  return null;
}

class LocalLibraryItem {
  LocalLibraryItem({
    required this.path,
    required this.type,
    this.name,
    this.thumbnail,
    this.isReadable = false,
    this.parent,
  });

  final String path;
  final LibraryItemType type;
  final String? name;
  String? thumbnail;
  bool isReadable;
  LocalLibraryItem? parent;
  List<LocalLibraryItem> children = [];
}

@Riverpod(keepAlive: true)
class LocalLibrary extends _$LocalLibrary {
  Future<LocalLibraryItem?> _processDirectory(
      Directory dir, LocalLibraryItem? parent) async {
    final formats = await ref.watch(supportedFormatsProvider.future);

    final entities = await dir.list().toList();
    final files = entities.whereType<File>();
    final name = (dir.uri.pathSegments.length - 2 >= 0)
        ? dir.uri.pathSegments.elementAt(dir.uri.pathSegments.length - 2)
        : dir.path;

    final res = LocalLibraryItem(
      path: dir.path,
      name: name,
      type: LibraryItemType.directory,
      parent: parent,
    );

    final isReadable = files.isNotEmpty &&
        files.every((element) =>
            element.path.endsWith(".jpg") ||
            element.path.endsWith(".png") ||
            element.path.endsWith(".jpeg") ||
            (formats.avif && element.path.endsWith(".avif")));

    res.isReadable = isReadable;

    if (res.isReadable) {
      res.thumbnail = files.first.path;
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

    res.children.sort(compareLibraryItems);

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
      // TODO thumbnail for archives?
      return LocalLibraryItem(
          path: file.path,
          type: LibraryItemType.archive,
          name: file.uri.pathSegments.last,
          isReadable: true,
          parent: parent);
    }

    return null;
  }

  Future<LocalLibraryItem> _scanLibrary() async {
    final cfg = ref.watch(localConfigProvider);
    if (cfg.libraryDirectory.isNotEmpty) {
      final top = LocalLibraryItem(
          path: cfg.libraryDirectory, type: LibraryItemType.directory);

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

      top.children.sort(compareLibraryItems);

      return top;
    }

    return LocalLibraryItem(path: '', type: LibraryItemType.directory);
  }

  @override
  Future<LocalLibraryItem> build() async {
    return _scanLibrary();
  }

  Future<void> rescan() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _scanLibrary();
    });
  }
}

class FormatInfo {
  const FormatInfo({
    required this.avif,
  });

  final bool avif;
}

@Riverpod(keepAlive: true)
class SupportedFormats extends _$SupportedFormats {
  @override
  Future<FormatInfo> build() async {
    bool avif = false;

    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      avif = int.parse(androidInfo.version.release) >= 12;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      avif = int.parse(iosInfo.systemVersion) >= 16;
    } else if (Platform.isWindows) {
      avif = true;
    }

    return FormatInfo(avif: avif);
  }
}
