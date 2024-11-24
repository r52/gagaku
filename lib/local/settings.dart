import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/local/model/config.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalLibrarySettingsRouteBuilder<T> extends SlideTransitionRouteBuilder<T> {
  LocalLibrarySettingsRouteBuilder()
      : super(pageBuilder: (context, animation, secondaryAnimation) => const LocalLibrarySettingsWidget());
}

class LocalLibrarySettingsWidget extends HookConsumerWidget {
  const LocalLibrarySettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final cfg = ref.watch(localConfigProvider);
    final config = useState(cfg);

    final saveSettings = 'saveSettings'.tr(context: context);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('arg_settings'.tr(context: context, args: ['library'.tr(context: context)])),
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
                    ref.read(localConfigProvider.notifier).save(config.value);
                    nav.pop();
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
                'localLibrary.settings.libraryPath'.tr(context: context),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('localLibrary.settings.libraryPathDesc'.tr(context: context)),
              builder: (context) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10.0,
                    children: [
                      Text(config.value.libraryDirectory),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final perms = await Permission.manageExternalStorage.request();

                          if (perms.isGranted) {
                            String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

                            if (selectedDirectory != null) {
                              config.value = config.value.copyWith(libraryDirectory: selectedDirectory);
                            }
                          }
                        },
                        icon: const Icon(Icons.folder_open),
                        label: Text('ui.browse'.tr(context: context)),
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
