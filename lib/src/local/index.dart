import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/local/archive_reader.dart';

enum LocalLibraryAction {
  import,
  open,
}

class LocalLibraryHomePage extends StatefulWidget {
  LocalLibraryHomePage({Key? key, required this.topScaffold}) : super(key: key);

  final GlobalKey<ScaffoldState> topScaffold;

  @override
  _LocalLibraryHomePageState createState() => _LocalLibraryHomePageState();
}

class _LocalLibraryHomePageState extends State<LocalLibraryHomePage> {
  Future<void> _readArchive() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['cbz', 'zip'],
    );

    if (result != null) {
      final path = result.files.single.path!;
      print(path);

      Navigator.push(context, createArchiveReaderRoute(path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                widget.topScaffold.currentState!.openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text('Local Library'),
        actions: [
          ButtonBar(
            children: [
              PopupMenuButton<LocalLibraryAction>(
                icon: const Icon(Icons.add),
                onSelected: (LocalLibraryAction result) async {
                  switch (result) {
                    case LocalLibraryAction.open:
                      await _readArchive();
                      break;
                    case LocalLibraryAction.import:
                    default:
                      break;
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<LocalLibraryAction>>[
                  const PopupMenuItem<LocalLibraryAction>(
                    value: LocalLibraryAction.import,
                    child: ListTile(
                      leading: const Icon(Icons.library_add),
                      title: Text('Import to Library'),
                    ),
                  ),
                  const PopupMenuItem<LocalLibraryAction>(
                    value: LocalLibraryAction.open,
                    child: ListTile(
                      leading: const Icon(Icons.folder_open),
                      title: Text('Read from Archive'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                await _readArchive();
              },
              icon: const Icon(Icons.folder_open),
              label: const Text('Read from Archive'),
            ),
          ],
        ),
      ),
    );
  }
}
