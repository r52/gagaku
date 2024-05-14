import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/local/config.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Route createLocalLibrarySettingsRoute() {
  return Styles.buildSlideTransitionRoute(
      (context, animation, secondaryAnimation) =>
          const LocalLibrarySettingsWidget());
}

class LocalLibrarySettingsWidget extends HookConsumerWidget {
  const LocalLibrarySettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final cfg = ref.watch(localConfigProvider);
    final config = useState(cfg);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Library Settings'),
        actions: [
          OverflowBar(
            spacing: 8.0,
            children: [
              Tooltip(
                message: 'Save Settings',
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save Settings'),
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
              title: const Text(
                'Manga Library Path',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle:
                  const Text('Choose where to search for your manga library'),
              builder: (context) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(config.value.libraryDirectory),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          String? selectedDirectory =
                              await FilePicker.platform.getDirectoryPath();

                          if (selectedDirectory != null) {
                            config.value = config.value
                                .copyWith(libraryDirectory: selectedDirectory);
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
