import 'package:file_picker/file_picker.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/local/model/config.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalLibrarySettingsRouteBuilder<T>
    extends SlideTransitionRouteBuilder<T> {
  LocalLibrarySettingsRouteBuilder()
    : super(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LocalLibrarySettingsWidget(),
      );
}

class LocalLibrarySettingsWidget extends HookConsumerWidget {
  const LocalLibrarySettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final nav = Navigator.of(context);
    final cfg = ref.watch(localConfigProvider);
    final config = useState(cfg);

    final saveSettings = tr.saveSettings;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(tr.arg_settings(arg: tr.library)),
        actions: [
          OverflowBar(
            spacing: 8.0,
            children: [
              Tooltip(
                message: saveSettings,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: Text(saveSettings),
                  onPressed: () {
                    ref.run((tsx) async {
                      return tsx
                          .get(localConfigProvider.notifier)
                          .save(config.value);
                    });

                    nav.pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            SettingTile(
              title: Text(
                tr.localLibrary.settings.libraryPath,
                style: CommonTextStyles.twentyBold,
              ),
              subtitle: Text(config.value.libraryDirectory),
              trailing: const Icon(Icons.folder_open),
              onTap: () async {
                final perms = await Permission.manageExternalStorage.request();

                if (perms.isGranted) {
                  String? selectedDirectory =
                      await FilePicker.getDirectoryPath();

                  if (selectedDirectory != null) {
                    config.value = config.value.copyWith(
                      libraryDirectory: selectedDirectory,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
