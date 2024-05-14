import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/config.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings.g.dart';

@riverpod
Future<Set<Group>> _fetchGroupData(
    _FetchGroupDataRef ref, Iterable<String> uuids) async {
  final api = ref.watch(mangadexProvider);
  final groups = await api.fetchGroups(uuids);
  return groups.toSet();
}

class MangaDexSettingsWidget extends HookConsumerWidget {
  const MangaDexSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final theme = Theme.of(context);
    final cfg = ref.watch(mdConfigProvider);
    final config = useState(cfg);
    final groupDataProvider =
        ref.watch(_fetchGroupDataProvider(config.value.groupBlacklist));

    const spacing = 4.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MangaDex Settings'),
        actions: [
          ButtonBar(
            children: [
              Tooltip(
                message: 'Save Settings',
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save Settings'),
                  onPressed: () {
                    ref.read(mdConfigProvider.notifier).save(config.value);
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
                'Chapter Language Filter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Show only chapters from these languages.'),
              builder: (context) {
                return Center(
                  child: MenuAnchor(
                    builder: (context, controller, child) => InkWell(
                      onTap: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      child: child,
                    ),
                    menuChildren: List.generate(
                      Languages.languages.length,
                      (index) => Builder(
                        builder: (_) {
                          final lang = Languages.languages.elementAt(index);
                          return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(lang.label),
                            secondary: Text(
                              lang.flag,
                              style: const TextStyle(
                                fontFamily: 'Twemoji',
                                fontSize: 15,
                              ),
                            ),
                            value:
                                config.value.translatedLanguages.contains(lang),
                            onChanged: (bool? value) async {
                              if (value == true) {
                                config.value = config.value.copyWith(
                                    translatedLanguages: {
                                      ...config.value.translatedLanguages,
                                      lang
                                    });
                              } else {
                                config.value = config.value.copyWith(
                                    translatedLanguages: config
                                        .value.translatedLanguages
                                        .where((element) => element != lang)
                                        .toSet());
                              }
                            },
                          );
                        },
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0)),
                      ),
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 2.0,
                            runSpacing: 2.0,
                            children: [
                              if (config.value.translatedLanguages.isEmpty)
                                const Text('Select Languages'),
                              for (final lang
                                  in config.value.translatedLanguages)
                                ElevatedButton.icon(
                                  onPressed: () {
                                    config.value = config.value.copyWith(
                                        translatedLanguages: config
                                            .value.translatedLanguages
                                            .where((element) => element != lang)
                                            .toSet());
                                  },
                                  icon: const Icon(Icons.close),
                                  label: Text(lang.label),
                                ),
                            ],
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: const Text(
                'Original Language Filter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                  'Only show titles originally published in these languages. If no languages are selected, no filter will be applied.'),
              builder: (context) {
                return Center(
                  child: MenuAnchor(
                    builder: (context, controller, child) => InkWell(
                      onTap: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      child: child,
                    ),
                    menuChildren: List.generate(
                      Languages.languages.length,
                      (index) => Builder(
                        builder: (_) {
                          final lang = Languages.languages.elementAt(index);
                          return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(lang.label),
                            secondary: Text(
                              lang.flag,
                              style: const TextStyle(
                                fontFamily: 'Twemoji',
                                fontSize: 15,
                              ),
                            ),
                            value: config.value.originalLanguage.contains(lang),
                            onChanged: (bool? value) async {
                              if (value == true) {
                                config.value = config.value.copyWith(
                                    originalLanguage: {
                                      ...config.value.originalLanguage,
                                      lang
                                    });
                              } else {
                                config.value = config.value.copyWith(
                                    originalLanguage: config
                                        .value.originalLanguage
                                        .where((element) => element != lang)
                                        .toSet());
                              }
                            },
                          );
                        },
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0)),
                      ),
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 2.0,
                            runSpacing: 2.0,
                            children: [
                              if (config.value.originalLanguage.isEmpty)
                                const Text('Select Languages'),
                              for (final lang in config.value.originalLanguage)
                                ElevatedButton.icon(
                                  onPressed: () {
                                    config.value = config.value.copyWith(
                                        originalLanguage: config
                                            .value.originalLanguage
                                            .where((element) => element != lang)
                                            .toSet());
                                  },
                                  icon: const Icon(Icons.close),
                                  label: Text(lang.label),
                                ),
                            ],
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: const Text(
                'Content Filter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              builder: (context) {
                return Center(
                  child: MenuAnchor(
                    builder: (context, controller, child) => InkWell(
                      onTap: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      child: child,
                    ),
                    menuChildren: List.generate(
                      ContentRating.values.length,
                      (index) => Builder(
                        builder: (_) {
                          final content = ContentRating.values.elementAt(index);
                          return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(content.label),
                            value: config.value.contentRating.contains(content),
                            onChanged: (bool? value) async {
                              if (value == true) {
                                config.value = config.value.copyWith(
                                    contentRating: {
                                      ...config.value.contentRating,
                                      content
                                    });
                              } else {
                                config.value = config.value.copyWith(
                                    contentRating: config.value.contentRating
                                        .where((element) => element != content)
                                        .toSet());
                              }
                            },
                          );
                        },
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0)),
                      ),
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 2.0,
                            runSpacing: 2.0,
                            children: [
                              if (config.value.contentRating.isEmpty)
                                const Text('Select Content Filters'),
                              for (final content in config.value.contentRating)
                                ElevatedButton.icon(
                                  onPressed: () {
                                    config.value = config.value.copyWith(
                                        contentRating: config
                                            .value.contentRating
                                            .where(
                                                (element) => element != content)
                                            .toSet());
                                  },
                                  icon: const Icon(Icons.close),
                                  label: Text(content.label),
                                ),
                            ],
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: const Text(
                'Data Saver',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              builder: (context) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Off'),
                      Switch(
                        value: config.value.dataSaver,
                        onChanged: (value) {
                          config.value =
                              config.value.copyWith(dataSaver: value);
                        },
                      ),
                      const Text('On'),
                    ],
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: const Text(
                'Blocked Groups',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              builder: (context) {
                if (config.value.groupBlacklist.isEmpty) {
                  return const Center(
                    child: Wrap(
                      children: [
                        InputChip(
                          label: Text('None'),
                        ),
                      ],
                    ),
                  );
                }

                final children = <Widget>[];

                switch (groupDataProvider) {
                  case AsyncValue(valueOrNull: final groups?):
                    for (final group in config.value.groupBlacklist) {
                      final groupInfo =
                          groups.firstWhere((element) => element.id == group);
                      children.add(InputChip(
                        label: Text(groupInfo.attributes.name),
                        onDeleted: () {
                          config.value = config.value.copyWith(
                            groupBlacklist: config.value.groupBlacklist
                                .where((element) => element != group)
                                .toSet(),
                          );
                        },
                      ));
                    }
                    break;
                  case AsyncValue(:final error?, :final stackTrace?):
                    final messenger = ScaffoldMessenger.of(context);
                    Styles.showErrorSnackBar(messenger, '$error');
                    logger.e("_fetchGroupDataProvider failed",
                        error: error, stackTrace: stackTrace);

                    final children = <Widget>[];

                    for (final group in config.value.groupBlacklist) {
                      children.add(InputChip(
                        label: Text(group),
                        onDeleted: () {
                          config.value = config.value.copyWith(
                            groupBlacklist: config.value.groupBlacklist
                                .where((element) => element != group)
                                .toSet(),
                          );
                        },
                      ));
                    }
                    break;
                  case _:
                    return Styles.listSpinner;
                }

                return Center(
                  child: Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: children,
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
