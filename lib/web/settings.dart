import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/config.dart';
import 'package:gagaku/web/repo_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class WebSourceSettingsRouteBuilder<T> extends SlideTransitionRouteBuilder<T> {
  WebSourceSettingsRouteBuilder()
      : super(pageBuilder: (context, animation, secondaryAnimation) => const WebSourceSettingsWidget());
}

class WebSourceSettingsWidget extends HookConsumerWidget {
  const WebSourceSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final cfg = ref.watch(webConfigProvider);
    final config = useState(cfg);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Web Source Settings'),
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
                    ref.read(webConfigProvider.notifier).saveWith(sourceDirectory: config.value.sourceDirectory);
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
                'Sources Path',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Choose where to store your downloaded sources'),
              builder: (context) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(config.value.sourceDirectory),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final perms = await Permission.manageExternalStorage.request();

                          if (perms.isGranted) {
                            String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

                            if (selectedDirectory != null) {
                              config.value = config.value.copyWith(sourceDirectory: selectedDirectory);
                            }
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
            SettingCardWidget(
              title: const Text(
                'Repos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Configure source repos'),
              builder: (context) {
                return Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      nav.push(SlideTransitionRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const RepoListManager(),
                      ));
                    },
                    icon: const Icon(Icons.library_add),
                    label: const Text('Manage'),
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
