// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/local/model/archive_thumbnail_provider.dart';
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

  final children = curr.children
      .where(
        (element) =>
            old.type == element.type && old.isReadable == element.isReadable,
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

class _ScanArgs {
  const _ScanArgs({
    required this.libDir,
    required this.formats,
    required this.currentSort,
    required this.sendPort,
  });
  final String libDir;
  final FormatInfo formats;
  final LibrarySort currentSort;
  final SendPort sendPort;
}

Future<LocalLibraryItem?> _processFileIsolate(
  File file,
  LocalLibraryItem? parent,
) async {
  final lpath = file.path.toLowerCase();
  if (lpath.endsWith('.cbz') ||
      lpath.endsWith('.zip') ||
      lpath.endsWith('.cbt') ||
      lpath.endsWith('.tar')) {
    return LocalLibraryItem(
      path: file.path,
      type: LibraryItemType.archive,
      modified: await file.lastModified(),
      name: file.uri.pathSegments.last,
      isReadable: true,
      thumbnail: file.path,
      parent: parent,
    );
  }
  return null;
}

Future<LocalLibraryItem?> _processDirectoryIsolate(
  Directory dir,
  LocalLibraryItem? parent,
  FormatInfo formats,
  LibrarySort currentSort,
) async {
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

  final imageFiles = files.where((element) {
    final lowerPath = element.path.toLowerCase();
    return lowerPath.endsWith(".jpg") ||
        lowerPath.endsWith(".png") ||
        lowerPath.endsWith(".jpeg") ||
        lowerPath.endsWith(".webp") ||
        (formats.avif && lowerPath.endsWith(".avif"));
  }).toList();

  res.isReadable = imageFiles.isNotEmpty;

  if (res.isReadable) {
    res.thumbnail = imageFiles.first.path;
    return res;
  }

  for (final e in files) {
    final p = await _processFileIsolate(e, res);
    if (p != null) {
      res.children.add(p);
    }
  }

  final dirs = entities.whereType<Directory>();
  for (final e in dirs) {
    final p = await _processDirectoryIsolate(e, res, formats, currentSort);
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

Future<void> _isolateWorker(_ScanArgs args) async {
  final top = LocalLibraryItem(
    path: args.libDir,
    type: LibraryItemType.directory,
    modified: DateTime.now(),
  );

  final dir = Directory(args.libDir);
  if (!dir.existsSync()) {
    args.sendPort.send(top);
    args.sendPort.send(true);
    return;
  }

  final entities = await dir.list().toList();

  for (final e in entities) {
    if (e is File) {
      final p = await _processFileIsolate(e, top);
      if (p != null) {
        top.children.add(p);
      }
    } else if (e is Directory) {
      final p = await _processDirectoryIsolate(
        e,
        top,
        args.formats,
        args.currentSort,
      );
      if (p != null) {
        top.children.add(p);
      }
    }

    top.setSortType(args.currentSort);
    args.sendPort.send(top);
  }

  args.sendPort.send(true);
}

@Riverpod(keepAlive: true)
class LocalLibrary extends _$LocalLibrary {
  Stream<LocalLibraryItem> _scanLibrary() async* {
    final libDir = ref.watch(
      localConfigProvider.select((c) => c.libraryDirectory),
    );
    final currentSort = ref.read(librarySortTypeProvider);
    final formats = await ref.watch(supportedFormatsProvider.future);

    final perms = await Permission.manageExternalStorage.request();

    if (perms.isDenied) {
      yield LocalLibraryItem(
        path: '',
        type: LibraryItemType.directory,
        modified: DateTime.now(),
        error: t.localLibrary.errors.permissionDenied,
      );
      return;
    }

    if (libDir.isNotEmpty) {
      final top = LocalLibraryItem(
        path: libDir,
        type: LibraryItemType.directory,
        modified: DateTime.now(),
      );

      final dir = Directory(libDir);
      if (!dir.existsSync()) {
        top.error = t.localLibrary.errors.emptyLibrary;
        yield top;
        return;
      }

      yield top;

      final receivePort = ReceivePort();
      await Isolate.spawn(
        _isolateWorker,
        _ScanArgs(
          libDir: libDir,
          formats: formats,
          currentSort: currentSort,
          sendPort: receivePort.sendPort,
        ),
      );

      LocalLibraryItem? lastItem;

      await for (final message in receivePort) {
        if (message is LocalLibraryItem) {
          lastItem = message;
          yield lastItem;
        } else if (message == true) {
          receivePort.close();
          break;
        }
      }

      lastItem ??= top;

      if (lastItem.children.isEmpty) {
        lastItem.error = t.localLibrary.errors.emptyLibrary;
        yield lastItem;
      } else {
        triggerThumbnailGarbageCollection(lastItem);
      }
      return;
    }

    yield LocalLibraryItem(
      path: '',
      type: LibraryItemType.directory,
      modified: DateTime.now(),
      error: t.localLibrary.errors.pathNotSet,
    );
  }

  @override
  Stream<LocalLibraryItem> build() async* {
    yield* _scanLibrary();
  }

  Future<void> rescan() async {
    ref.invalidateSelf();
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
