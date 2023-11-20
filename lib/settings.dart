import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/config.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsHome extends HookConsumerWidget {
  const SettingsHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(gagakuSettingsProvider);
    final config = useState(cfg);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace:
            Styles.titleFlexBar(context: context, title: 'Gagaku Settings'),
      ),
      drawer: const MainDrawer(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            SettingCardWidget(
              title: const Text(
                'Default Theme',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              builder: (context) {
                return Center(
                  child: DropdownButton<ThemeMode>(
                    value: config.value.themeMode,
                    items: const [
                      DropdownMenuItem(
                          value: ThemeMode.light, child: Text('Light')),
                      DropdownMenuItem(
                          value: ThemeMode.dark, child: Text('Dark')),
                      DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text('System defined')),
                    ],
                    onChanged: (ThemeMode? value) {
                      if (value != null) {
                        final cfg = config.value.copyWith(themeMode: value);
                        ref.read(gagakuSettingsProvider.notifier).save(cfg);
                        config.value = cfg;
                      }
                    },
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: const Text(
                'Theme Color',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              builder: (context) {
                return Center(
                  child: DropdownButton<Color>(
                    value: config.value.theme,
                    items: [
                      DropdownMenuItem(
                          value: Colors.amber.shade500,
                          child: const Text('Amber (MD)')),
                      DropdownMenuItem(
                          value: Colors.blue.shade500,
                          child: const Text('Blue (Gagaku)')),
                      DropdownMenuItem(
                          value: Colors.teal.shade500,
                          child: const Text('Teal')),
                      DropdownMenuItem(
                          value: Colors.green.shade500,
                          child: const Text('Green')),
                      DropdownMenuItem(
                          value: Colors.lightGreen.shade500,
                          child: const Text('Light Green')),
                      DropdownMenuItem(
                          value: Colors.red.shade500, child: const Text('Red')),
                      DropdownMenuItem(
                          value: Colors.orange.shade500,
                          child: const Text('Orange')),
                      DropdownMenuItem(
                          value: Colors.yellow.shade500,
                          child: const Text('Yellow')),
                      DropdownMenuItem(
                          value: Colors.purple.shade500,
                          child: const Text('Purple')),
                    ],
                    onChanged: (Color? value) {
                      if (value != null) {
                        final cfg = config.value.copyWith(theme: value);
                        ref.read(gagakuSettingsProvider.notifier).save(cfg);
                        config.value = cfg;
                      }
                    },
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
