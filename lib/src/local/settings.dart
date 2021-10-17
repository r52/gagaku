import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/local/api.dart';
import 'package:gagaku/src/ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class LocalDatabaseSettings {
  Directory libraryPath;
  static const _libraryPathKey = 'local.libraryPath';

  LocalDatabaseSettings({
    Directory? libraryPath,
  }) : libraryPath = libraryPath ?? Directory.systemTemp;

  LocalDatabaseSettings copyWith({
    Directory? libraryPath,
  }) {
    return LocalDatabaseSettings(
      libraryPath: libraryPath ?? this.libraryPath,
    );
  }

  static Future<LocalDatabaseSettings> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lib path
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String defPath = p.join(appDocDir.path, 'gagaku');
    String libdir = prefs.getString(_libraryPathKey) ?? defPath;

    var libPath = Directory(libdir);
    final libexists = await libPath.exists();

    if (!libexists) {
      libPath = await libPath.create();
    }

    return LocalDatabaseSettings(
      libraryPath: libPath,
    );
  }

  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(_libraryPathKey, libraryPath.path);
  }
}

Route createLocalLibrarySettingsRoute(LocalDatabaseSettings settings) {
  return Styles.buildSlideTransitionRoute(
      (context, animation, secondaryAnimation) =>
          LocalLibrarySettingsWidget(settings: settings));
}

class LocalLibrarySettingsWidget extends StatefulWidget {
  LocalLibrarySettingsWidget({Key? key, required this.settings})
      : super(key: key);

  final LocalDatabaseSettings settings;

  @override
  _LocalLibrarySettingsWidgetState createState() =>
      _LocalLibrarySettingsWidgetState();
}

class _LocalLibrarySettingsWidgetState
    extends State<LocalLibrarySettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: Text('Library Settings'),
        actions: [
          ButtonBar(
            children: [
              Tooltip(
                message: 'Save Settings',
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  label: Text('Save Settings'),
                  onPressed: () {
                    Provider.of<LocalDatabaseModel>(context, listen: false)
                        .setSettings(widget.settings);

                    Navigator.pop(context, true);
                  },
                ),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            SettingCardWidget(
              title: Text(
                'Manga Library Path',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle:
                  Text('Choose where to search for/store your manga library'),
              builder: (context) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.settings.libraryPath.path),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          String? selectedDirectory =
                              await FilePicker.platform.getDirectoryPath();

                          if (selectedDirectory != null) {
                            setState(() {
                              widget.settings.libraryPath =
                                  Directory(selectedDirectory);
                            });
                          }
                        },
                        icon: const Icon(Icons.folder_open),
                        label: const Text('Browse'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
