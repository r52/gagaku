import 'package:flutter/material.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings.g.dart';

@riverpod
Future<Set<Group>> _fetchGroupData(Ref ref, Iterable<String> uuids) async {
  final api = ref.watch(mangadexProvider);
  final groups = await api.fetchGroups(uuids);
  return groups.toSet();
}

class MangaDexSettingsWidget extends HookConsumerWidget {
  const MangaDexSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const titleStyle = CommonTextStyles.twentyBold;
    final tr = context.t;
    final nav = Navigator.of(context);
    final cfg = ref.watch(mdConfigProvider);
    final config = useState(cfg.copyWith());
    final groupDataProvider = ref.watch(
      _fetchGroupDataProvider(config.value.groupBlacklist),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.arg_settings(arg: 'MangaDex')),
        actions: [
          OverflowBar(
            spacing: 8.0,
            children: [
              Tooltip(
                message: tr.saveSettings,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: Text(tr.saveSettings),
                  onPressed: () {
                    ref.run((tsx) async {
                      return tsx
                          .get(mdConfigProvider.notifier)
                          .save(config.value);
                    });
                    nav.pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            MultiSelectChipSettingTile(
              title: Text(
                tr.mangadex.settings.translatedLanguages,
                style: titleStyle,
              ),
              subtitle: Text(tr.mangadex.settings.translatedLanguagesDesc),
              chips: config.value.translatedLanguages.map((lang) {
                return InputChip(
                  label: Text(tr[lang.label]),
                  avatar: CountryFlag(flag: lang.flag, size: 15),
                  onDeleted: () {
                    config.value = config.value.copyWith(
                      translatedLanguages: {...config.value.translatedLanguages}
                        ..remove(lang),
                    );
                  },
                );
              }).toList(),
              builder: (context) {
                final langsList = Languages.languages.toList();
                return ValueListenableBuilder(
                  valueListenable: config,
                  builder: (context, currentConfig, _) {
                    return Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: langsList.length,
                        itemBuilder: (context, index) {
                          final lang = langsList[index];
                          return CheckboxListTile(
                            title: Text(tr[lang.label]),
                            secondary: CountryFlag(flag: lang.flag, size: 15),
                            value: currentConfig.translatedLanguages.contains(
                              lang,
                            ),
                            onChanged: (bool? value) {
                              if (value == true) {
                                config.value = currentConfig.copyWith(
                                  translatedLanguages: {
                                    ...currentConfig.translatedLanguages,
                                  }..add(lang),
                                );
                              } else {
                                config.value = currentConfig.copyWith(
                                  translatedLanguages: {
                                    ...currentConfig.translatedLanguages,
                                  }..remove(lang),
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
            MultiSelectChipSettingTile(
              title: Text(
                tr.mangadex.settings.originalLanguage,
                style: titleStyle,
              ),
              subtitle: Text(tr.mangadex.settings.originalLanguageDesc),
              chips: config.value.originalLanguage.map((lang) {
                return InputChip(
                  label: Text(tr[lang.label]),
                  avatar: CountryFlag(flag: lang.flag, size: 15),
                  onDeleted: () {
                    config.value = config.value.copyWith(
                      originalLanguage: {...config.value.originalLanguage}
                        ..remove(lang),
                    );
                  },
                );
              }).toList(),
              builder: (context) {
                final langsList = Languages.languages.toList();
                return ValueListenableBuilder(
                  valueListenable: config,
                  builder: (context, currentConfig, _) {
                    return Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: langsList.length,
                        itemBuilder: (context, index) {
                          final lang = langsList[index];
                          return CheckboxListTile(
                            title: Text(tr[lang.label]),
                            secondary: CountryFlag(flag: lang.flag, size: 15),
                            value: currentConfig.originalLanguage.contains(
                              lang,
                            ),
                            onChanged: (bool? value) {
                              if (value == true) {
                                config.value = currentConfig.copyWith(
                                  originalLanguage: {
                                    ...currentConfig.originalLanguage,
                                  }..add(lang),
                                );
                              } else {
                                config.value = currentConfig.copyWith(
                                  originalLanguage: {
                                    ...currentConfig.originalLanguage,
                                  }..remove(lang),
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
            BottomSheetSettingTile(
              title: Text(
                tr.mangadex.settings.contentRating,
                style: titleStyle,
              ),
              builder: (context) {
                return ValueListenableBuilder(
                  valueListenable: config,
                  builder: (context, currentConfig, _) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final content in ContentRating.values)
                          CheckboxListTile(
                            title: Text(tr[content.label]),
                            value: currentConfig.contentRating.contains(
                              content,
                            ),
                            onChanged: (bool? value) {
                              if (value == true) {
                                config.value = currentConfig.copyWith(
                                  contentRating: {
                                    ...currentConfig.contentRating,
                                  }..add(content),
                                );
                              } else {
                                config.value = currentConfig.copyWith(
                                  contentRating: {
                                    ...currentConfig.contentRating,
                                  }..remove(content),
                                );
                              }
                            },
                          ),
                      ],
                    );
                  },
                );
              },
            ),
            SwitchListTile(
              title: Text(tr.mangadex.settings.dataSaver, style: titleStyle),
              value: config.value.dataSaver,
              onChanged: (value) {
                config.value = config.value.copyWith(dataSaver: value);
              },
            ),
            BottomSheetSettingTile(
              title: Text(
                tr.mangadex.settings.groupBlacklist,
                style: titleStyle,
              ),
              builder: (context) {
                return ValueListenableBuilder(
                  valueListenable: config,
                  builder: (context, currentConfig, _) {
                    if (currentConfig.groupBlacklist.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(tr.ui.none),
                        ),
                      );
                    }

                    final children = <Widget>[];

                    switch (groupDataProvider) {
                      case AsyncValue(value: final groups?):
                        for (final group in currentConfig.groupBlacklist) {
                          final groupInfo = groups.firstWhere(
                            (element) => element.id == group,
                          );
                          children.add(
                            ListTile(
                              title: Text(groupInfo.attributes.name),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  config.value = currentConfig.copyWith(
                                    groupBlacklist: currentConfig.groupBlacklist
                                        .where((element) => element != group)
                                        .toSet(),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        break;
                      case AsyncValue(:final error?, :final stackTrace?):
                        final messenger = ScaffoldMessenger.of(context);
                        Styles.showSnackBar(messenger, content: '$error');
                        logger.e(
                          "_fetchGroupDataProvider failed",
                          error: error,
                          stackTrace: stackTrace,
                        );

                        for (final group in currentConfig.groupBlacklist) {
                          children.add(
                            ListTile(
                              title: Text(group),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  config.value = currentConfig.copyWith(
                                    groupBlacklist: currentConfig.groupBlacklist
                                        .where((element) => element != group)
                                        .toSet(),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        break;
                      case AsyncValue(:final progress):
                        return ListSpinner(progress: progress?.toDouble());
                    }

                    return Flexible(
                      child: ListView(shrinkWrap: true, children: children),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
