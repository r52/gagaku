import 'dart:convert';
import 'package:gagaku/util/riverpod.dart';

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
    final result = await FilePicker.saveFile(
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

    FilePickerResult? result = await FilePicker.pickFiles(
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
    const titleStyle = CommonTextStyles.twentyBold;

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
            BottomSheetSettingTile(
              title: Text(t.theme.mode, style: titleStyle),
              trailing: Text(
                cfg.themeMode == ThemeMode.light
                    ? t.theme.light
                    : cfg.themeMode == ThemeMode.dark
                    ? t.theme.dark
                    : t.theme.system,
              ),
              builder: (context) {
                return RadioGroup<ThemeMode>(
                  groupValue: cfg.themeMode,
                  onChanged: (ThemeMode? value) {
                    if (value != null) {
                      final c = cfg.copyWith(themeMode: value);
                      ref.run(
                        (tsx) async =>
                            tsx.get(gagakuSettingsProvider.notifier).save(c),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioListTile<ThemeMode>(
                        title: Text(t.theme.light),
                        value: ThemeMode.light,
                      ),
                      RadioListTile<ThemeMode>(
                        title: Text(t.theme.dark),
                        value: ThemeMode.dark,
                      ),
                      RadioListTile<ThemeMode>(
                        title: Text(t.theme.system),
                        value: ThemeMode.system,
                      ),
                    ],
                  ),
                );
              },
            ),
            BottomSheetSettingTile(
              title: Text(t.theme.color, style: titleStyle),
              trailing: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: cfg.theme.color,
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.colorScheme.onSurface),
                ),
              ),
              builder: (context) {
                return Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  children: [
                    for (final c in GagakuTheme.values)
                      InkWell(
                        onTap: () {
                          final newCfg = cfg.copyWith(theme: c);
                          ref.run(
                            (tsx) async => tsx
                                .get(gagakuSettingsProvider.notifier)
                                .save(newCfg),
                          );
                          Navigator.of(context).pop();
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: c.color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: cfg.theme == c
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurface,
                                  width: cfg.theme == c ? 3 : 1,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(t[c.label]),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),

            // --- Update settings ---
            SwitchListTile(
              title: Text(t.updates.checkForUpdates, style: titleStyle),
              subtitle: Text(t.updates.checkForUpdatesSub),
              value: cfg.checkForUpdates,
              onChanged: (bool value) {
                final c = cfg.copyWith(checkForUpdates: value);
                ref.run(
                  (tsx) async =>
                      tsx.get(gagakuSettingsProvider.notifier).save(c),
                );
              },
            ),
            BottomSheetSettingTile(
              title: Text(t.updates.updateChannel, style: titleStyle),
              subtitle: Text(t.updates.updateChannelSub),
              trailing: Text(cfg.updateChannel),
              builder: (context) {
                return RadioGroup<String>(
                  groupValue: cfg.updateChannel,
                  onChanged: (String? value) {
                    if (value != null) {
                      final c = cfg.copyWith(updateChannel: value);
                      ref.run(
                        (tsx) async =>
                            tsx.get(gagakuSettingsProvider.notifier).save(c),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioListTile<String>(
                        title: Text(t.updates.channelStable),
                        value: 'stable',
                      ),
                      RadioListTile<String>(
                        title: Text(t.updates.channelBeta),
                        value: 'beta',
                      ),
                    ],
                  ),
                );
              },
            ),
            BottomSheetSettingTile(
              title: Text(t.updates.checkFrequency, style: titleStyle),
              subtitle: Text(t.updates.checkFrequencySub),
              trailing: Text('${cfg.updateCheckCooldownHours}h'),
              builder: (context) {
                return RadioGroup<int>(
                  groupValue: cfg.updateCheckCooldownHours,
                  onChanged: (int? value) {
                    if (value != null) {
                      final c = cfg.copyWith(updateCheckCooldownHours: value);
                      ref.run(
                        (tsx) async =>
                            tsx.get(gagakuSettingsProvider.notifier).save(c),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioListTile<int>(
                        title: Text(t.updates.freqHourly),
                        value: 1,
                      ),
                      RadioListTile<int>(
                        title: Text(t.updates.freqDaily),
                        value: 24,
                      ),
                      RadioListTile<int>(
                        title: Text(t.updates.freqWeekly),
                        value: 168,
                      ),
                      RadioListTile<int>(
                        title: Text(t.updates.freqMonthly),
                        value: 720,
                      ),
                    ],
                  ),
                );
              },
            ),
            SettingTile(
              title: Text(t.cache.clear, style: titleStyle),
              subtitle: Text(t.cache.clearSub),
              trailing: const Icon(Icons.delete_sweep),
              onTap: () async {
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
            ),
            HookBuilder(
              builder: (context) {
                final isLoading = useState(false);

                return SettingTile(
                  title: Text(t.backup.data, style: titleStyle),
                  subtitle: Text(t.backup.dataSub),
                  trailing: isLoading.value
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.save),
                  onTap: isLoading.value
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
                );
              },
            ),
            HookBuilder(
              builder: (context) {
                final isLoading = useState(false);
                return SettingTile(
                  title: Text(t.backup.restore, style: titleStyle),
                  subtitle: Text(t.backup.fromFile),
                  trailing: isLoading.value
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.settings_backup_restore),
                  onTap: isLoading.value
                      ? null
                      : () async {
                          isLoading.value = true;
                          final result = await _restoreBackup(context);
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
                              SnackBar(content: Text(msg), backgroundColor: bg),
                            );
                        },
                );
              },
            ),
            SettingTile(
              title: Text(t.backup.dataLocation, style: titleStyle),
              subtitle: Text(
                dataLocation.value != null
                    ? dataLocation.value!
                    : t.backup.dataLocDefault,
              ),
              trailing: const Icon(Icons.folder_open),
              onTap: () async {
                final perms = await Permission.manageExternalStorage.request();

                if (perms.isGranted) {
                  String? selectedDirectory =
                      await FilePicker.getDirectoryPath();

                  if (selectedDirectory != null) {
                    await gbox.put('data_location', selectedDirectory);
                    dataLocation.value = selectedDirectory;
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
