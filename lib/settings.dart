import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/model/types.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class AppSettingsPage extends ConsumerWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cache = ref.watch(cacheProvider);
    final cfg = ref.watch(gagakuSettingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: TitleFlexBar(
          title: 'arg_settings'.tr(context: context, args: ['Gagaku']),
        ),
      ),
      drawer: const MainDrawer(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            SettingCardWidget(
              title: Text(
                'theme.mode'.tr(context: context),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              builder: (context) {
                return Center(
                  child: DropdownMenu<ThemeMode>(
                    initialSelection: cfg.themeMode,
                    requestFocusOnTap: false,
                    enableSearch: false,
                    enableFilter: false,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: ThemeMode.light,
                        label: 'theme.light'.tr(context: context),
                      ),
                      DropdownMenuEntry(
                        value: ThemeMode.dark,
                        label: 'theme.dark'.tr(context: context),
                      ),
                      DropdownMenuEntry(
                        value: ThemeMode.system,
                        label: 'theme.system'.tr(context: context),
                      ),
                    ],
                    onSelected: (ThemeMode? value) {
                      if (value != null) {
                        final c = cfg.copyWith(themeMode: value);
                        ref.read(gagakuSettingsProvider.save)(c);
                      }
                    },
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                'theme.color'.tr(context: context),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              builder: (context) {
                return Center(
                  child: DropdownMenu<GagakuTheme>(
                    initialSelection: cfg.theme,
                    enableSearch: false,
                    enableFilter: false,
                    requestFocusOnTap: false,
                    dropdownMenuEntries: [
                      for (final c in GagakuTheme.values)
                        DropdownMenuEntry(
                          leadingIcon: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: c.color,
                              border: Border.all(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          value: c,
                          label: context.tr(c.label),
                        ),
                    ],
                    onSelected: (GagakuTheme? value) {
                      if (value != null) {
                        final c = cfg.copyWith(theme: value);
                        ref.read(gagakuSettingsProvider.save)(c);
                      }
                    },
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                'cache.clear'.tr(context: context),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('cache.clearSub'.tr(context: context)),
              builder: (context) {
                return Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          final nav = Navigator.of(context);
                          return AlertDialog(
                            title: Text('cache.clear'.tr(context: context)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('cache.clearWarning'.tr(context: context)),
                                Text(
                                  'ui.irreversibleWarning'.tr(context: context),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text('ui.no'.tr(context: context)),
                                onPressed: () {
                                  nav.pop(null);
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  nav.pop(true);
                                },
                                child: Text('ui.yes'.tr(context: context)),
                              ),
                            ],
                          );
                        },
                      );

                      if (result == true) {
                        await cache.clearAll();
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(
                                'cache.clearSuccess'.tr(context: context),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                      }
                    },
                    icon: const Icon(Icons.delete_sweep),
                    label: Text('cache.clear'.tr(context: context)),
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
