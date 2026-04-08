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
            SettingCardWidget(
              title: Text(
                tr.mangadex.settings.translatedLanguages,
                style: titleStyle,
              ),
              subtitle: Text(tr.mangadex.settings.translatedLanguagesDesc),
              builder: (context) {
                return MultiSelectMenuAnchor<Language>(
                  items: Languages.languages,
                  selected: config.value.translatedLanguages,
                  labelFor: (lang) => tr[lang.label],
                  trailingIconFor: (lang) =>
                      CountryFlag(flag: lang.flag, size: 15),
                  placeholder: tr.mangadex.settings.selectLanguages,
                  onChanged: (updated) => config.value = config.value.copyWith(
                    translatedLanguages: updated,
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                tr.mangadex.settings.originalLanguage,
                style: titleStyle,
              ),
              subtitle: Text(tr.mangadex.settings.originalLanguageDesc),
              builder: (context) {
                return MultiSelectMenuAnchor<Language>(
                  items: Languages.languages,
                  selected: config.value.originalLanguage,
                  labelFor: (lang) => tr[lang.label],
                  trailingIconFor: (lang) =>
                      CountryFlag(flag: lang.flag, size: 15),
                  placeholder: tr.mangadex.settings.selectLanguages,
                  onChanged: (updated) => config.value = config.value.copyWith(
                    originalLanguage: updated,
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                tr.mangadex.settings.contentRating,
                style: titleStyle,
              ),
              builder: (context) {
                return MultiSelectMenuAnchor<ContentRating>(
                  items: ContentRating.values,
                  selected: config.value.contentRating,
                  labelFor: (content) => tr[content.label],
                  placeholder: tr.mangadex.settings.selectContentFilters,
                  onChanged: (updated) => config.value = config.value.copyWith(
                    contentRating: updated,
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(tr.mangadex.settings.dataSaver, style: titleStyle),
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
                style: titleStyle,
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
                              groupBlacklist: config.value.groupBlacklist
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
                              groupBlacklist: config.value.groupBlacklist
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
