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
    final cfg = ref.watch(mdConfigProvider);
    final config = useState(cfg);
    final groups =
        ref.watch(_fetchGroupDataProvider(config.value.groupBlacklist));

    const spacing = 4.0;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
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
                  child: Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (final lang in Languages.languages.values)
                        FilterChip(
                          label: Text(lang.name),
                          selected:
                              config.value.translatedLanguages.contains(lang),
                          onSelected: (value) {
                            if (value) {
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
                        ),
                    ],
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
                  child: Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (final lang in Languages.languages.values)
                        FilterChip(
                          label: Text(lang.name),
                          selected:
                              config.value.originalLanguage.contains(lang),
                          onSelected: (value) {
                            if (value) {
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
                        ),
                    ],
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
                  child: Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (final content in ContentRating.values)
                        FilterChip(
                          label: Text(content.formatted),
                          selected:
                              config.value.contentRating.contains(content),
                          onSelected: (value) {
                            if (value) {
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
                        ),
                    ],
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

                switch (groups) {
                  case AsyncData(:final value):
                    for (final group in config.value.groupBlacklist) {
                      final groupInfo =
                          value.firstWhere((element) => element.id == group);
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
                  case AsyncError(:final error, :final stackTrace):
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
