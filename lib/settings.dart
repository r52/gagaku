import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/config.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/types.dart';
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
        flexibleSpace: const TitleFlexBar(title: 'Gagaku Settings'),
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
                  child: DropdownMenu<ThemeMode>(
                    initialSelection: config.value.themeMode,
                    requestFocusOnTap: false,
                    enableSearch: false,
                    enableFilter: false,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: ThemeMode.light, label: 'Light'),
                      DropdownMenuEntry(value: ThemeMode.dark, label: 'Dark'),
                      DropdownMenuEntry(value: ThemeMode.system, label: 'System defined'),
                    ],
                    onSelected: (ThemeMode? value) {
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
                  child: DropdownMenu<GagakuTheme>(
                    initialSelection: config.value.theme,
                    enableSearch: false,
                    enableFilter: false,
                    requestFocusOnTap: false,
                    dropdownMenuEntries: [
                      for (final c in GagakuTheme.values) DropdownMenuEntry(value: c, label: c.label),
                    ],
                    onSelected: (GagakuTheme? value) {
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
