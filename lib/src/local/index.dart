import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/local/api.dart';
import 'package:gagaku/src/local/archive_reader.dart';
import 'package:gagaku/src/local/settings.dart';
import 'package:gagaku/src/local/types.dart';
import 'package:gagaku/src/local/widgets.dart';
import 'package:gagaku/src/ui.dart';
import 'package:provider/provider.dart';

enum LocalLibraryAction { import, open, rescan }

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

  Future<Iterable<LocalManga>> _fetchManga(LocalDatabaseModel model) async {
    return model.getAllMangas();
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
                      // TODO import
                      break;
                    case LocalLibraryAction.rescan:
                      // TODO rescan
                      break;
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
                      title: Text('Import Manga to Library'),
                    ),
                  ),
                  const PopupMenuItem<LocalLibraryAction>(
                    value: LocalLibraryAction.open,
                    child: ListTile(
                      leading: const Icon(Icons.folder_open),
                      title: Text('Read Archive without Importing'),
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem<LocalLibraryAction>(
                    value: LocalLibraryAction.rescan,
                    child: ListTile(
                      leading: const Icon(Icons.refresh),
                      title: Text('Re-scan Library Directory'),
                    ),
                  ),
                ],
              ),
              Tooltip(
                message: 'Settings',
                child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                        context,
                        createLocalLibrarySettingsRoute(
                            Provider.of<LocalDatabaseModel>(context,
                                    listen: false)
                                .settings));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<LocalDatabaseModel>(
        builder: (context, mdx, child) {
          return FutureBuilder<Iterable<LocalManga>>(
            future: _fetchManga(mdx),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Styles.buildCenterSpinner();
              }

              if (snapshot.hasData) {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Library is empty!'),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {},
                          icon: const Icon(Icons.library_add),
                          label: const Text('Import Manga to Library'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('or'),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await _readArchive();
                          },
                          icon: const Icon(Icons.folder_open),
                          label: const Text('Read Archive without Importing'),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: MangaListWidget(
                    items: snapshot.data!,
                    title: Text(
                      'Local Library',
                      style: TextStyle(fontSize: 24),
                    ),
                    restorationId: 'local_manga_list_grid_offset',
                    physics: const AlwaysScrollableScrollPhysics(),
                  ),
                );
              } else if (snapshot.hasError) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text('${snapshot.error}'),
                    backgroundColor: Colors.red,
                  ));

                return Text('${snapshot.error}');
              }

              return Styles.buildCenterSpinner();
            },
          );
        },
      ),
    );
  }
}
