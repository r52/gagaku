import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/i18n/strings.g.dart';
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
    final t = context.t;
    final cache = ref.watch(cacheProvider);
    final cfg = ref.watch(gagakuSettingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: TitleFlexBar(title: t.arg_settings(arg: 'Gagaku')),
      ),
      drawer: const MainDrawer(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            SettingCardWidget(
              title: Text(
                t.theme.mode,
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
                        label: t.theme.light,
                      ),
                      DropdownMenuEntry(
                        value: ThemeMode.dark,
                        label: t.theme.dark,
                      ),
                      DropdownMenuEntry(
                        value: ThemeMode.system,
                        label: t.theme.system,
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
                t.theme.color,
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
                          label: t[c.label],
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
                t.cache.clear,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(t.cache.clearSub),
              builder: (context) {
                return Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          final nav = Navigator.of(context);
                          return AlertDialog(
                            title: Text(t.cache.clear),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(t.cache.clearWarning),
                                Text(t.ui.irreversibleWarning),
                              ],
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text(t.ui.no),
                                onPressed: () {
                                  nav.pop(null);
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  nav.pop(true);
                                },
                                child: Text(t.ui.yes),
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
                              content: Text(t.cache.clearSuccess),
                              backgroundColor: Colors.green,
                            ),
                          );
                      }
                    },
                    icon: const Icon(Icons.delete_sweep),
                    label: Text(t.cache.clear),
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
