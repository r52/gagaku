import 'package:flutter/material.dart';
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
    final tr = context.t;
    final nav = Navigator.of(context);
    final theme = Theme.of(context);
    final cfg = ref.watch(mdConfigProvider);
    final config = useState(cfg);
    final groupDataProvider = ref.watch(
      _fetchGroupDataProvider(config.value.groupBlacklist),
    );

    const spacing = 4.0;

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
                    mdConfigSaveMutation.run(ref, (ref) async {
                      return ref
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
            SettingCardWidget(
              title: Text(
                tr.mangadex.settings.translatedLanguages,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(tr.mangadex.settings.translatedLanguagesDesc),
              builder: (context) {
                return Center(
                  child: MenuAnchor(
                    builder:
                        (context, controller, child) => SizedBox(
                          width: double.infinity,
                          child: Material(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (controller.isOpen) {
                                  controller.close();
                                } else {
                                  controller.open();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: child,
                              ),
                            ),
                          ),
                        ),
                    menuChildren: List.generate(
                      Languages.languages.length,
                      (index) => Builder(
                        builder: (_) {
                          final lang = Languages.languages.elementAt(index);
                          return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(tr[lang.label]),
                            secondary: CountryFlag(flag: lang.flag, size: 15),
                            value: config.value.translatedLanguages.contains(
                              lang,
                            ),
                            onChanged: (bool? value) async {
                              if (value == true) {
                                config.value = config.value.copyWith(
                                  translatedLanguages: {
                                    ...config.value.translatedLanguages,
                                    lang,
                                  },
                                );
                              } else {
                                config.value = config.value.copyWith(
                                  translatedLanguages:
                                      config.value.translatedLanguages
                                          .where((element) => element != lang)
                                          .toSet(),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    child: Column(
                      children: [
                        Wrap(
                          spacing: 2.0,
                          runSpacing: 2.0,
                          children: [
                            if (config.value.translatedLanguages.isEmpty)
                              Text(tr.mangadex.settings.selectLanguages),
                            for (final lang in config.value.translatedLanguages)
                              ElevatedButton.icon(
                                onPressed: () {
                                  config.value = config.value.copyWith(
                                    translatedLanguages:
                                        config.value.translatedLanguages
                                            .where((element) => element != lang)
                                            .toSet(),
                                  );
                                },
                                icon: const Icon(Icons.close),
                                label: Text(tr[lang.label]),
                              ),
                          ],
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                tr.mangadex.settings.originalLanguage,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(tr.mangadex.settings.originalLanguageDesc),
              builder: (context) {
                return Center(
                  child: MenuAnchor(
                    builder:
                        (context, controller, child) => SizedBox(
                          width: double.infinity,
                          child: Material(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (controller.isOpen) {
                                  controller.close();
                                } else {
                                  controller.open();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: child,
                              ),
                            ),
                          ),
                        ),
                    menuChildren: List.generate(
                      Languages.languages.length,
                      (index) => Builder(
                        builder: (_) {
                          final lang = Languages.languages.elementAt(index);
                          return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(tr[lang.label]),
                            secondary: CountryFlag(flag: lang.flag, size: 15),
                            value: config.value.originalLanguage.contains(lang),
                            onChanged: (bool? value) async {
                              if (value == true) {
                                config.value = config.value.copyWith(
                                  originalLanguage: {
                                    ...config.value.originalLanguage,
                                    lang,
                                  },
                                );
                              } else {
                                config.value = config.value.copyWith(
                                  originalLanguage:
                                      config.value.originalLanguage
                                          .where((element) => element != lang)
                                          .toSet(),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    child: Column(
                      children: [
                        Wrap(
                          spacing: 2.0,
                          runSpacing: 2.0,
                          children: [
                            if (config.value.originalLanguage.isEmpty)
                              Text(tr.mangadex.settings.selectLanguages),
                            for (final lang in config.value.originalLanguage)
                              ElevatedButton.icon(
                                onPressed: () {
                                  config.value = config.value.copyWith(
                                    originalLanguage:
                                        config.value.originalLanguage
                                            .where((element) => element != lang)
                                            .toSet(),
                                  );
                                },
                                icon: const Icon(Icons.close),
                                label: Text(tr[lang.label]),
                              ),
                          ],
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                tr.mangadex.settings.contentRating,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              builder: (context) {
                return Center(
                  child: MenuAnchor(
                    builder:
                        (context, controller, child) => SizedBox(
                          width: double.infinity,
                          child: Material(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (controller.isOpen) {
                                  controller.close();
                                } else {
                                  controller.open();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: child,
                              ),
                            ),
                          ),
                        ),
                    menuChildren: List.generate(
                      ContentRating.values.length,
                      (index) => Builder(
                        builder: (_) {
                          final content = ContentRating.values.elementAt(index);
                          return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(tr[content.label]),
                            value: config.value.contentRating.contains(content),
                            onChanged: (bool? value) async {
                              if (value == true) {
                                config.value = config.value.copyWith(
                                  contentRating: {
                                    ...config.value.contentRating,
                                    content,
                                  },
                                );
                              } else {
                                config.value = config.value.copyWith(
                                  contentRating:
                                      config.value.contentRating
                                          .where(
                                            (element) => element != content,
                                          )
                                          .toSet(),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    child: Column(
                      children: [
                        Wrap(
                          spacing: 2.0,
                          runSpacing: 2.0,
                          children: [
                            if (config.value.contentRating.isEmpty)
                              Text(tr.mangadex.settings.selectContentFilters),
                            for (final content in config.value.contentRating)
                              ElevatedButton.icon(
                                onPressed: () {
                                  config.value = config.value.copyWith(
                                    contentRating:
                                        config.value.contentRating
                                            .where(
                                              (element) => element != content,
                                            )
                                            .toSet(),
                                  );
                                },
                                icon: const Icon(Icons.close),
                                label: Text(tr[content.label]),
                              ),
                          ],
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                tr.mangadex.settings.dataSaver,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              builder: (context) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(tr.ui.off),
                      Switch(
                        value: config.value.dataSaver,
                        onChanged: (value) {
                          config.value = config.value.copyWith(
                            dataSaver: value,
                          );
                        },
                      ),
                      Text(tr.ui.on),
                    ],
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                tr.mangadex.settings.groupBlacklist,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              builder: (context) {
                if (config.value.groupBlacklist.isEmpty) {
                  return Center(
                    child: Wrap(children: [InputChip(label: Text(tr.ui.none))]),
                  );
                }

                final children = <Widget>[];

                switch (groupDataProvider) {
                  case AsyncValue(value: final groups?):
                    for (final group in config.value.groupBlacklist) {
                      final groupInfo = groups.firstWhere(
                        (element) => element.id == group,
                      );
                      children.add(
                        InputChip(
                          label: Text(groupInfo.attributes.name),
                          onDeleted: () {
                            config.value = config.value.copyWith(
                              groupBlacklist:
                                  config.value.groupBlacklist
                                      .where((element) => element != group)
                                      .toSet(),
                            );
                          },
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

                    for (final group in config.value.groupBlacklist) {
                      children.add(
                        InputChip(
                          label: Text(group),
                          onDeleted: () {
                            config.value = config.value.copyWith(
                              groupBlacklist:
                                  config.value.groupBlacklist
                                      .where((element) => element != group)
                                      .toSet(),
                            );
                          },
                        ),
                      );
                    }
                    break;
                  case AsyncValue(:final progress):
                    return ListSpinner(progress: progress?.toDouble());
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
