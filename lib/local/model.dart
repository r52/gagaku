// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:gagaku/local/config.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.g.dart';

enum LibraryItemType { directory, archive }

typedef LibraryItemCompare = int Function(LocalLibraryItem, LocalLibraryItem);

enum LibrarySort {
  name_desc('Name descending'),
  name_asc('Name ascending'),
  modified_desc('Modified descending'),
  modified_asc('Modified ascending');

  const LibrarySort(this.label);
  final String label;
}

final librarySortTypeProvider = StateProvider((ref) => LibrarySort.name_desc);

Map<LibrarySort, LibraryItemCompare> _libraryCompare = {
  LibrarySort.name_desc: (LocalLibraryItem a, LocalLibraryItem b) {
    if (!a.isReadable && b.isReadable) {
      return -1;
    }

    if (a.isReadable && !b.isReadable) {
      return 1;
    }

    return compareNatural(a.name?.toLowerCase() ?? a.path.toLowerCase(),
        b.name?.toLowerCase() ?? b.path.toLowerCase());
  },
  LibrarySort.name_asc: (LocalLibraryItem a, LocalLibraryItem b) {
    if (!a.isReadable && b.isReadable) {
      return -1;
    }

    if (a.isReadable && !b.isReadable) {
      return 1;
    }

    return compareNatural(b.name?.toLowerCase() ?? b.path.toLowerCase(),
        a.name?.toLowerCase() ?? a.path.toLowerCase());
  },
  LibrarySort.modified_desc: (LocalLibraryItem a, LocalLibraryItem b) {
    if (!a.isReadable && b.isReadable) {
      return -1;
    }

    if (a.isReadable && !b.isReadable) {
      return 1;
    }

    return a.modified.compareTo(b.modified);
  },
  LibrarySort.modified_asc: (LocalLibraryItem a, LocalLibraryItem b) {
    if (!a.isReadable && b.isReadable) {
      return -1;
    }

    if (a.isReadable && !b.isReadable) {
      return 1;
    }

    return b.modified.compareTo(a.modified);
  },
};

LocalLibraryItem? libraryItemBinarySearch(List<LocalLibraryItem> list, int low,
    int high, LocalLibraryItem item, LibrarySort sort) {
  if (low > high) {
    return null;
  }

  int middle = (low + high) >> 1;

  final mid = list.elementAt(middle);
  if (mid.type == item.type && mid.path == item.path) {
    return mid;
  }

  if (_libraryCompare[sort]!(item, mid) > 0) {
    return libraryItemBinarySearch(list, middle + 1, high, item, sort);
  }

  return libraryItemBinarySearch(list, low, middle - 1, item, sort);
}

LocalLibraryItem? findLibraryItem(
    LocalLibraryItem old, LocalLibraryItem curr, LibrarySort sort) {
  if (curr.type == old.type && curr.path == old.path) {
    return curr;
  }

  final children = curr.children
      .where((element) =>
          old.type == element.type && old.isReadable == element.isReadable)
      .toList();

  if (children.isNotEmpty) {
    final result =
        libraryItemBinarySearch(children, 0, children.length - 1, old, sort);

    if (result != null) {
      return result;
    }

    for (final e in children) {
      final cres = findLibraryItem(old, e, sort);
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
    required this.modified,
    this.name,
    this.thumbnail,
    this.isReadable = false,
    this.parent,
  });

  final String path;
  final LibraryItemType type;
  final DateTime modified;
  final String? name;
  String? thumbnail;
  bool isReadable;
  LocalLibraryItem? parent;
  List<LocalLibraryItem> children = [];
  int get id => Object.hash(path, type);
}

@Riverpod(keepAlive: true)
class LocalLibrary extends _$LocalLibrary {
  Future<LocalLibraryItem?> _processDirectory(
      Directory dir, LocalLibraryItem? parent) async {
    final formats = await ref.watch(supportedFormatsProvider.future);
    final sort = ref.watch(librarySortTypeProvider);

    final entities = await dir.list().toList();
    final files = entities.whereType<File>();
    final name = (dir.uri.pathSegments.length - 2 >= 0)
        ? dir.uri.pathSegments.elementAt(dir.uri.pathSegments.length - 2)
        : dir.path;

    final stats = dir.statSync();

    final res = LocalLibraryItem(
      path: dir.path,
      name: name,
      modified: stats.modified,
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

    res.children.sort(_libraryCompare[sort]);

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
          modified: await file.lastModified(),
          name: file.uri.pathSegments.last,
          isReadable: true,
          parent: parent);
    }

    return null;
  }

  Future<LocalLibraryItem> _scanLibrary() async {
    final cfg = ref.watch(localConfigProvider);
    final sort = ref.watch(librarySortTypeProvider);
    if (cfg.libraryDirectory.isNotEmpty) {
      final top = LocalLibraryItem(
        path: cfg.libraryDirectory,
        type: LibraryItemType.directory,
        modified: DateTime.now(),
      );

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

      top.children.sort(_libraryCompare[sort]);

      return top;
    }

    return LocalLibraryItem(
      path: '',
      type: LibraryItemType.directory,
      modified: DateTime.now(),
    );
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
