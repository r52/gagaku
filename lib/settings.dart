import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/model/types.dart';
import 'package:gagaku/settings/convert.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hive_ce/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

const _backupExcludeKeys = [
  'mangadex_credentials',
  'mangadex_tokens',
  'locallib',
  'data_location',
];

@RoutePage()
class AppSettingsPage extends HookConsumerWidget {
  const AppSettingsPage({super.key});

  Future<String?> _backupData(BuildContext context) async {
    Map<String, dynamic> output = {};
    final gbox = Hive.box(gagakuLocalBox);

    for (final key in gbox.keys) {
      if (_backupExcludeKeys.contains(key)) {
        continue;
      }

      final data = gbox.get(key);
      final djson = json.decode(data);
      output[key as String] = djson;
    }

    final outputdata = await const GagakuBackupDataV2().write(output);

    if (!context.mounted) return null;
    final result = await FilePicker.platform.saveFile(
      dialogTitle: context.t.backup.data,
      fileName:
          'gagaku_backup-${DateFormat('yyyy-MM-dd-kk_mm').format(DateTime.now())}.json',
      allowedExtensions: ['json'],
      bytes: utf8.encode(outputdata),
    );

    return result;
  }

  Future<bool?> _restoreBackup(BuildContext context) async {
    final t = context.t;
    final warnResult = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        final nav = Navigator.of(context);
        return AlertDialog(
          title: Text(t.backup.restore),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.backup.restoreWarning),
              Text(t.ui.irreversibleWarning),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(t.ui.no),
              onPressed: () {
                nav.pop(false);
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

    if (warnResult != true) {
      // aborted
      return null;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );

    if (result == null) {
      // aborted
      return null;
    }

    final pfile = result.files.single;
    final data = pfile.bytes;

    if (data == null) {
      // invalid data
      logger.w("Invalid backup data in file ${pfile.path!}");
      return false;
    }

    final udata = utf8.decode(data);
    final jdata = json.decode(udata) as Map<String, dynamic>;

    switch (jdata["version"]) {
      case 2:
        await const GagakuBackupDataV2().read(jdata);
        break;
      case 1:
      default:
        await const GagakuBackupDataV1().read(jdata);
        break;
    }

    // cleanup old data
    final gbox = Hive.box(gagakuLocalBox);

    for (final key in gbox.keys) {
      if (_backupExcludeKeys.contains(key)) {
        continue;
      }

      await gbox.delete(key);
    }

    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final cache = ref.watch(cacheProvider);
    final cfg = ref.watch(gagakuSettingsProvider);
    final theme = Theme.of(context);

    final gbox = Hive.box(gagakuLocalBox);
    final dataLocation = useState(gbox.get('data_location') as String?);

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
                        gagakuConfigSaveMutation.run(ref, (ref) async {
                          return ref
                              .get(gagakuSettingsProvider.notifier)
                              .save(c);
                        });
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
                        gagakuConfigSaveMutation.run(ref, (ref) async {
                          return ref
                              .get(gagakuSettingsProvider.notifier)
                              .save(c);
                        });
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
            SettingCardWidget(
              title: Text(
                t.backup.data,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(t.backup.dataSub),
              builder: (context) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10.0,
                    children: [
                      HookBuilder(
                        builder: (context) {
                          final isLoading = useState(false);

                          return ElevatedButton.icon(
                            onPressed: isLoading.value
                                ? null
                                : () async {
                                    isLoading.value = true;
                                    final result = await _backupData(context);
                                    isLoading.value = false;

                                    if (result != null) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(
                                          SnackBar(
                                            content: Text(t.backup.success),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                    } else {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(
                                          SnackBar(
                                            content: Text(t.backup.cancelled),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                    }
                                  },
                            icon: isLoading.value
                                ? CircularProgressIndicator(
                                    constraints: BoxConstraints.expand(
                                      width: 20,
                                      height: 20,
                                    ),
                                  )
                                : const Icon(Icons.save),
                            label: Text(t.backup.toFile),
                          );
                        },
                      ),
                      HookBuilder(
                        builder: (context) {
                          final isLoading = useState(false);
                          return ElevatedButton.icon(
                            onPressed: isLoading.value
                                ? null
                                : () async {
                                    isLoading.value = true;
                                    final result = await _restoreBackup(
                                      context,
                                    );
                                    isLoading.value = false;

                                    String msg = t.backup.restoreSuccess;
                                    Color bg = Colors.green;

                                    if (!context.mounted) return;
                                    switch (result) {
                                      case true:
                                        msg = t.backup.restoreSuccess;
                                        bg = Colors.green;
                                        break;
                                      case false:
                                        msg = t.backup.restoreFail;
                                        bg = Colors.red;
                                        break;
                                      case null:
                                        msg = t.backup.restoreCancelled;
                                        bg = Colors.red;
                                        break;
                                    }

                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          content: Text(msg),
                                          backgroundColor: bg,
                                        ),
                                      );
                                  },
                            icon: isLoading.value
                                ? CircularProgressIndicator(
                                    constraints: BoxConstraints.expand(
                                      width: 20,
                                      height: 20,
                                    ),
                                  )
                                : const Icon(Icons.settings_backup_restore),
                            label: Text(t.backup.fromFile),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                t.backup.dataLocation,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(t.backup.dataLocSub),
              builder: (context) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10.0,
                    children: [
                      (dataLocation.value != null
                          ? Text(dataLocation.value!)
                          : Text(t.backup.dataLocDefault)),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final perms = await Permission.manageExternalStorage
                              .request();

                          if (perms.isGranted) {
                            String? selectedDirectory = await FilePicker
                                .platform
                                .getDirectoryPath();

                            if (selectedDirectory != null) {
                              await gbox.put(
                                'data_location',
                                selectedDirectory,
                              );
                              dataLocation.value = selectedDirectory;
                            }
                          }
                        },
                        icon: const Icon(Icons.folder_open),
                        label: Text(t.ui.browse),
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
