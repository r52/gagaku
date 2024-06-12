import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/local/archive_reader.dart';
import 'package:gagaku/local/config.dart';
import 'package:gagaku/local/directory_reader.dart';
import 'package:gagaku/local/model.dart';
import 'package:gagaku/local/settings.dart';
import 'package:gagaku/local/widgets.dart';
import 'package:gagaku/ui.dart';
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
      navigator.push(
          ArchiveReaderRouteBuilder(path: result.path!, title: result.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const TitleFlexBar(title: 'Local Library'),
        actions: [
          OverflowBar(
            spacing: 8.0,
            children: [
              MenuAnchor(
                builder: (context, controller, child) => IconButton(
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
                    child: const Text('Read Archive'),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      nav.push(LocalLibrarySettingsRouteBuilder());
                    },
                    leadingIcon: const Icon(Icons.settings),
                    child: const Text('Settings'),
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
          final settings = ref.watch(localConfigProvider);
          final libraryProvider = ref.watch(localLibraryProvider);
          final sort = ref.watch(librarySortTypeProvider);
          final currentItem =
              useState<LocalLibraryItem?>(libraryProvider.value);

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

          if (settings.libraryDirectory.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No library directory set!'),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      nav.push(LocalLibrarySettingsRouteBuilder());
                    },
                    icon: const Icon(Icons.library_add),
                    label: const Text('Set Library Directory'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await _readArchive(nav);
                    },
                    icon: const Icon(Icons.folder_open),
                    label: const Text('Read Archive'),
                  ),
                ],
              ),
            );
          }

          switch (libraryProvider) {
            case AsyncValue(value: final top?):
              Widget child;

              if (top.children.isEmpty) {
                child = Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Library is empty!'),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await _readArchive(nav);
                        },
                        icon: const Icon(Icons.folder_open),
                        label: const Text('Read Archive'),
                      ),
                    ],
                  ),
                );
              } else if (currentItem.value != null) {
                child = LibraryListWidget(
                  title: Text(
                    currentItem.value!.path,
                    style: const TextStyle(fontSize: 24),
                  ),
                  item: currentItem.value!,
                  onTap: (item) {
                    if (item.isReadable) {
                      switch (item.type) {
                        case LibraryItemType.directory:
                          nav.push(DirectoryReaderRouteBuilder(
                              path: item.path, title: item.name ?? item.path));
                          break;
                        case LibraryItemType.archive:
                          nav.push(ArchiveReaderRouteBuilder(
                              path: item.path, title: item.name ?? item.path));
                          break;
                        default:
                          break;
                      }
                    } else {
                      currentItem.value = item;
                    }
                  },
                );
              } else {
                return Styles.listSpinner;
              }

              return RefreshIndicator(
                onRefresh: () => ref.refresh(localLibraryProvider.future),
                child: child,
              );
            case AsyncValue(:final error?, :final stackTrace?):
              return RefreshIndicator(
                onRefresh: () => ref.refresh(localLibraryProvider.future),
                child: ErrorList(
                  error: error,
                  stackTrace: stackTrace,
                  message: "localLibraryProvider failed",
                ),
              );
            case _:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Scanning library...",
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
                    const CircularProgressIndicator()
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
