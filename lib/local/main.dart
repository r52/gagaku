import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/local/archive_reader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum LocalLibraryAction { open, settings }

class LocalLibraryHome extends ConsumerWidget {
  const LocalLibraryHome({super.key});

  Future<PlatformFile?> _pickMangaArchive() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['cbz', 'zip'],
    );

    if (result != null) {
      return result.files.single;
    }

    return null;
  }

  Future<void> _readArchive(NavigatorState navigator) async {
    PlatformFile? result = await _pickMangaArchive();

    if (result != null) {
      navigator.push(createArchiveReaderRoute(result.path!));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Library"),
        actions: [
          ButtonBar(
            children: [
              PopupMenuButton<LocalLibraryAction>(
                icon: const Icon(Icons.more_vert),
                onSelected: (LocalLibraryAction result) async {
                  switch (result) {
                    case LocalLibraryAction.open:
                      final nav = Navigator.of(context);
                      await _readArchive(nav);
                      break;
                    case LocalLibraryAction.settings:
                      // TODO local library settings
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Library is empty!'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                // TODO local library
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
                final nav = Navigator.of(context);
                await _readArchive(nav);
              },
              icon: const Icon(Icons.folder_open),
              label: const Text('Read Archive'),
            ),
          ],
        ),
      ),
    );
  }
}
