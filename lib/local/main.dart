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
import 'package:gagaku/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum LocalLibraryAction { open, settings }

class LocalLibraryHome extends HookConsumerWidget {
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
      navigator
          .push(createArchiveReaderRoute(result.path!, title: result.name));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final settings = ref.watch(localConfigProvider);
    final result = ref.watch(localLibraryProvider);
    final theme = Theme.of(context);
    final currentItem = useState<LocalLibraryItem?>(null);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace:
            Styles.titleFlexBar(context: context, title: 'Local Library'),
        actions: [
          ButtonBar(
            children: [
              PopupMenuButton<LocalLibraryAction>(
                icon: const Icon(Icons.more_vert),
                onSelected: (LocalLibraryAction result) async {
                  switch (result) {
                    case LocalLibraryAction.open:
                      await _readArchive(nav);
                      break;
                    case LocalLibraryAction.settings:
                      nav.push(createLocalLibrarySettingsRoute());
                      break;
                    default:
                      break;
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<LocalLibraryAction>>[
                  const PopupMenuItem<LocalLibraryAction>(
                    value: LocalLibraryAction.open,
                    child: ListTile(
                      leading: Icon(Icons.folder_open),
                      title: Text('Read Archive'),
                    ),
                  ),
                  const PopupMenuItem<LocalLibraryAction>(
                    value: LocalLibraryAction.settings,
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: () {
        if (DeviceContext.isMobile() || settings.libraryDirectory.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (DeviceContext.isDesktop()) ...[
                  const Text('No library directory set!'),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      nav.push(createLocalLibrarySettingsRoute());
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
                ],
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

        return result.when(
          skipLoadingOnReload: false,
          data: (top) {
            currentItem.value ??= top;
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
            } else {
              child = LibraryListWidget(
                title: Text(
                  currentItem.value!.path,
                  style: const TextStyle(fontSize: 24),
                ),
                item: currentItem.value!,
                onTap: (item) {
                  if (item.isReadable) {
                    if (item.isDirectory) {
                      nav.push(createDirectoryReaderRoute(item.path,
                          title: item.name ?? item.path));
                    } else {
                      nav.push(createArchiveReaderRoute(item.path,
                          title: item.name ?? item.path));
                    }
                  } else {
                    currentItem.value = item;
                  }
                },
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                return await ref.refresh(localLibraryProvider.future);
              },
              child: child,
            );
          },
          loading: () => Center(
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
          ),
          error: (err, stackTrace) {
            final messenger = ScaffoldMessenger.of(context);
            Styles.showErrorSnackBar(messenger, '$err');

            return Text('Error: $err');
          },
        );
      }(),
    );
  }
}
