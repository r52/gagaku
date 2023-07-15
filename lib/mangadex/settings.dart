import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/config.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexSettingsWidget extends HookConsumerWidget {
  const MangaDexSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final cfg = ref.watch(mdConfigProvider);
    final config = useState(cfg);

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
                    children: [
                      for (final lang in Languages.languages.values)
                        Padding(
                          padding: screenSizeSmall
                              ? const EdgeInsets.symmetric(horizontal: 2)
                              : const EdgeInsets.all(4),
                          child: FilterChip(
                              // labelPadding: const EdgeInsets.all(0),
                              label: Text(lang.name),
                              selected: config.value.translatedLanguages
                                  .contains(lang),
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
                              }),
                        )
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
                    children: [
                      for (final lang in Languages.languages.values)
                        Padding(
                          padding: screenSizeSmall
                              ? const EdgeInsets.symmetric(horizontal: 2)
                              : const EdgeInsets.all(4),
                          child: FilterChip(
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
                              }),
                        )
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
                    children: [
                      for (final content in ContentRating.values)
                        Padding(
                          padding: screenSizeSmall
                              ? const EdgeInsets.symmetric(horizontal: 2)
                              : const EdgeInsets.all(4),
                          child: FilterChip(
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
                                          .where(
                                              (element) => element != content)
                                          .toSet());
                                }
                              }),
                        )
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
          ],
        ),
      ),
    );
  }
}
