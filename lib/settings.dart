import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/config.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/types.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsHome extends HookConsumerWidget {
  const SettingsHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(gagakuSettingsProvider);
    final config = useState(cfg);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: TitleFlexBar(title: 'arg_settings'.tr(context: context, args: ['Gagaku'])),
      ),
      drawer: const MainDrawer(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            SettingCardWidget(
              title: Text(
                'theme.mode'.tr(context: context),
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
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: ThemeMode.light, label: 'theme.light'.tr(context: context)),
                      DropdownMenuEntry(value: ThemeMode.dark, label: 'theme.dark'.tr(context: context)),
                      DropdownMenuEntry(value: ThemeMode.system, label: 'theme.system'.tr(context: context)),
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
              title: Text(
                'theme.color'.tr(context: context),
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
                      for (final c in GagakuTheme.values)
                        DropdownMenuEntry(
                          leadingIcon: Container(
                            width: 15,
                            height: 15,
                            decoration:
                                BoxDecoration(color: c.color, border: Border.all(color: theme.colorScheme.onSurface)),
                          ),
                          value: c,
                          label: context.tr(c.label),
                        ),
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
