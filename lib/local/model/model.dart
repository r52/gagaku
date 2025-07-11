// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/local/model/config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.g.dart';

enum LibraryItemType { directory, archive }

typedef LibraryItemCompare = int Function(LocalLibraryItem, LocalLibraryItem);

enum LibrarySort {
  name_desc,
  name_asc,
  modified_desc,
  modified_asc;

  static const _key = 'localLibrary.sort.';
  String get label => '$_key$name';
}

@Riverpod(keepAlive: true)
class LibrarySortType extends _$LibrarySortType {
  @override
  LibrarySort build() => LibrarySort.name_desc;

  @override
  set state(LibrarySort newState) => super.state = newState;
  LibrarySort update(LibrarySort Function(LibrarySort state) cb) =>
      state = cb(state);
}

int? _standardLocalLibraryItemComp(LocalLibraryItem a, LocalLibraryItem b) {
  if (a.type == b.type && a.path == b.path) {
    return 0;
  }

  if (!a.isReadable && b.isReadable) {
    return -1;
  }

  if (a.isReadable && !b.isReadable) {
    return 1;
  }

  return null;
}

Map<LibrarySort, LibraryItemCompare> _libraryCompare = {
  LibrarySort.name_desc: (LocalLibraryItem a, LocalLibraryItem b) {
    return _standardLocalLibraryItemComp(a, b) ??
        compareNatural(
          a.name?.toLowerCase() ?? a.path.toLowerCase(),
          b.name?.toLowerCase() ?? b.path.toLowerCase(),
        );
  },
  LibrarySort.name_asc: (LocalLibraryItem a, LocalLibraryItem b) {
    return _standardLocalLibraryItemComp(a, b) ??
        compareNatural(
          b.name?.toLowerCase() ?? b.path.toLowerCase(),
          a.name?.toLowerCase() ?? a.path.toLowerCase(),
        );
  },
  LibrarySort.modified_desc: (LocalLibraryItem a, LocalLibraryItem b) {
    return _standardLocalLibraryItemComp(a, b) ??
        a.modified.compareTo(b.modified);
  },
  LibrarySort.modified_asc: (LocalLibraryItem a, LocalLibraryItem b) {
    return _standardLocalLibraryItemComp(a, b) ??
        b.modified.compareTo(a.modified);
  },
};

LocalLibraryItem? findLibraryItem(
  LocalLibraryItem old,
  LocalLibraryItem curr,
  LibrarySort sort,
) {
  if (curr.type == old.type && curr.path == old.path) {
    return curr;
  }

  final children =
      curr.children
          .where(
            (element) =>
                old.type == element.type &&
                old.isReadable == element.isReadable,
          )
          .toList();

  if (children.isNotEmpty) {
    final result = children.binarySearch(old, _libraryCompare[sort]!);

    if (result > -1) {
      return children[result];
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
    this.error,
    this.sort,
  });

  final String path;
  final LibraryItemType type;
  final DateTime modified;
  final String? name;
  String? thumbnail;
  String? error;
  bool isReadable;
  LocalLibraryItem? parent;
  LibrarySort? sort;
  List<LocalLibraryItem> children = [];
  int get id => Object.hash(path, type);

  void setSortType(LibrarySort type) {
    sort = type;
    children.sort(_libraryCompare[sort]);
  }
}

@Riverpod(keepAlive: true)
class LocalLibrary extends _$LocalLibrary {
  Future<LocalLibraryItem?> _processDirectory(
    Directory dir,
    LocalLibraryItem? parent,
  ) async {
    final formats = await ref.watch(supportedFormatsProvider.future);
    final currentSort = ref.read(librarySortTypeProvider);

    final entities = await dir.list().toList();
    final files = entities.whereType<File>();
    final name =
        (dir.uri.pathSegments.length - 2 >= 0)
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

    final isReadable =
        files.isNotEmpty &&
        files.every(
          (element) =>
              element.path.endsWith(".jpg") ||
              element.path.endsWith(".png") ||
              element.path.endsWith(".jpeg") ||
              (formats.avif && element.path.endsWith(".avif")),
        );

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

    res.setSortType(currentSort);

    if (res.children.isNotEmpty) {
      return res;
    }

    return null;
  }

  Future<LocalLibraryItem?> _processFile(
    File file,
    LocalLibraryItem? parent,
  ) async {
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
        parent: parent,
      );
    }

    return null;
  }

  Future<LocalLibraryItem> _scanLibrary() async {
    final libDir = ref.watch(
      localConfigProvider.select((c) => c.libraryDirectory),
    );
    final currentSort = ref.read(librarySortTypeProvider);

    final perms = await Permission.manageExternalStorage.request();

    if (perms.isDenied) {
      return LocalLibraryItem(
        path: '',
        type: LibraryItemType.directory,
        modified: DateTime.now(),
        error: t.localLibrary.errors.permissionDenied,
      );
    }

    if (libDir.isNotEmpty) {
      state = const AsyncValue.loading(progress: 0);
      final top = LocalLibraryItem(
        path: libDir,
        type: LibraryItemType.directory,
        modified: DateTime.now(),
      );

      final dir = Directory(libDir);
      final entities = await dir.list().toList();

      for (final (idx, e) in entities.indexed) {
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
        state = AsyncValue.loading(progress: (idx + 1) / entities.length);
      }

      top.setSortType(currentSort);

      state = const AsyncValue.loading(progress: 1);

      if (top.children.isEmpty) {
        top.error = t.localLibrary.errors.emptyLibrary;
      }

      return top;
    }

    return LocalLibraryItem(
      path: '',
      type: LibraryItemType.directory,
      modified: DateTime.now(),
      error: t.localLibrary.errors.pathNotSet,
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
  const FormatInfo({required this.avif});

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
