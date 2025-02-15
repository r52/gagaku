// ignore_for_file: unused_local_variable

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/local/archive_reader.dart';
import 'package:gagaku/local/model/config.dart';
import 'package:gagaku/local/directory_reader.dart';
import 'package:gagaku/local/model/model.dart';
import 'package:gagaku/local/settings.dart';
import 'package:gagaku/local/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocalLibraryHome extends StatelessWidget {
  const LocalLibraryHome({super.key});

  Future<PlatformFile?> _pickMangaArchive() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['cbz', 'zip', 'cbt', 'tar'],
    );

    if (result != null) {
      return result.files.single;
    }

    return null;
  }

  Future<void> _readArchive(NavigatorState navigator) async {
    PlatformFile? result = await _pickMangaArchive();

    if (result != null) {
      navigator.push(ArchiveReaderRouteBuilder(path: result.path!, title: result.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: TitleFlexBar(title: 'localLibrary.text'.tr(context: context)),
        actions: [
          OverflowBar(
            spacing: 8.0,
            children: [
              MenuAnchor(
                builder: (context, controller, child) => IconButton(
                  color: theme.colorScheme.onPrimaryContainer,
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: const Icon(Icons.more_vert),
                ),
                menuChildren: [
                  MenuItemButton(
                    onPressed: () async {
                      await _readArchive(nav);
                    },
                    leadingIcon: const Icon(Icons.folder_open),
                    child: Text('localLibrary.readArchive'.tr(context: context)),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      nav.push(LocalLibrarySettingsRouteBuilder());
                    },
                    leadingIcon: const Icon(Icons.settings),
                    child: Text('settings'.tr(context: context)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: HookConsumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final libDir = ref.watch(localConfigProvider.select((c) => c.libraryDirectory));
          final libraryProvider = ref.watch(localLibraryProvider);
          final sort = ref.watch(librarySortTypeProvider);
          final currentItem = useState<LocalLibraryItem?>(libraryProvider.value);

          useEffect(() {
            final newVal = libraryProvider.value;
            if (currentItem.value != null && newVal != null) {
              final result = findLibraryItem(currentItem.value!, newVal, sort);

              if (result != null) {
                currentItem.value = result;
              } else {
                currentItem.value = newVal;
              }
            }

            currentItem.value ??= newVal;
            return null;
          }, [libraryProvider]);

          useEffect(() {
            if (currentItem.value != null && currentItem.value?.sort != null && currentItem.value?.sort != sort) {
              currentItem.value?.setSortType(sort);
            }
            return null;
          }, [currentItem.value, sort]);

          if (libDir.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10.0,
                children: [
                  Text('localLibrary.noPathWarning'.tr(context: context)),
                  ElevatedButton.icon(
                    onPressed: () {
                      nav.push(LocalLibrarySettingsRouteBuilder());
                    },
                    icon: const Icon(Icons.library_add),
                    label: Text('localLibrary.setPath'.tr(context: context)),
                  ),
                  const Divider(),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await _readArchive(nav);
                    },
                    icon: const Icon(Icons.folder_open),
                    label: Text('localLibrary.readArchive'.tr(context: context)),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => ref.refresh(localLibraryProvider.future),
            child: switch (libraryProvider) {
              AsyncValue(:final error?, :final stackTrace?) => ErrorList(
                  error: error,
                  stackTrace: stackTrace,
                  message: "localLibraryProvider failed",
                ),
              AsyncValue(value: final top?) when top.error != null => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10.0,
                    children: [
                      Text(top.error!),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await _readArchive(nav);
                        },
                        icon: const Icon(Icons.folder_open),
                        label: Text('localLibrary.readArchive'.tr(context: context)),
                      ),
                    ],
                  ),
                ),
              AsyncValue(value: final top?) when currentItem.value != null => LibraryListWidget(
                  title: Text(
                    currentItem.value!.path,
                    style: const TextStyle(fontSize: 24),
                  ),
                  item: currentItem.value!,
                  onTap: (item) {
                    if (item.isReadable) {
                      switch (item.type) {
                        case LibraryItemType.directory:
                          nav.push(DirectoryReaderRouteBuilder(path: item.path, title: item.name ?? item.path));
                          break;
                        case LibraryItemType.archive:
                          nav.push(ArchiveReaderRouteBuilder(path: item.path, title: item.name ?? item.path));
                          break;
                      }
                    } else {
                      currentItem.value = item;
                    }
                  },
                ),
              AsyncValue(value: final top?) => const ListSpinner(),
              AsyncValue(:final progress) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'localLibrary.scanning'.tr(context: context),
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
                      CircularProgressIndicator(value: progress?.toDouble()),
                      if (progress != null)
                        Text(
                          '${(progress * 100).floor()}%',
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                          ),
                        )
                    ],
                  ),
                ),
            },
          );
        },
      ),
    );
  }
}
