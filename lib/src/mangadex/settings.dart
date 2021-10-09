import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/types.dart';
import 'package:gagaku/src/ui.dart';
import 'package:gagaku/src/util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MangaDexSettings {
  Set<Language> translatedLanguages;
  static const _translatedLanguagesKey = 'mangadex.translatedLanguages';

  Set<Language> originalLanguage;
  static const _originalLanguageKey = 'mangadex.originalLanguage';

  Set<ContentRating> contentRating;
  static const _contentRatingKey = 'mangadex.contentRating';

  bool dataSaver = false;
  static const _dataSaverKey = 'mangadex.dataSaver';

  MangaDexSettings({
    Set<Language>? translatedLanguages,
    Set<Language>? originalLanguage,
    Set<ContentRating>? contentRating,
    bool? dataSaver,
  })  : translatedLanguages = translatedLanguages ?? {},
        originalLanguage = originalLanguage ?? {},
        contentRating = contentRating ??
            {
              ContentRating.safe,
              ContentRating.suggestive,
              ContentRating.erotica
            },
        dataSaver = dataSaver ?? false;

  MangaDexSettings copyWith({
    Set<Language>? translatedLanguages,
    Set<Language>? originalLanguage,
    Set<ContentRating>? contentRating,
    bool? dataSaver,
  }) {
    return MangaDexSettings(
      translatedLanguages: translatedLanguages ?? this.translatedLanguages,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      contentRating: contentRating ?? this.contentRating,
      dataSaver: dataSaver ?? this.dataSaver,
    );
  }

  static Future<MangaDexSettings> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var translatedLanguagesList =
        prefs.getStringList(_translatedLanguagesKey) ?? [];

    var translatedLanguages =
        translatedLanguagesList.map((e) => Languages.get(e)).toSet();

    var originalLanguageList = prefs.getStringList(_originalLanguageKey) ?? [];
    var originalLanguage =
        originalLanguageList.map((e) => Languages.get(e)).toSet();

    var contentRatingList = prefs.getStringList(_contentRatingKey) ??
        ['safe', 'suggestive', 'erotica'];
    var contentRating =
        contentRatingList.map((e) => ContentRatingExt.parse(e)).toSet();

    bool dataSaver = prefs.getBool(_dataSaverKey) ?? false;

    return MangaDexSettings(
      translatedLanguages: translatedLanguages,
      originalLanguage: originalLanguage,
      contentRating: contentRating,
      dataSaver: dataSaver,
    );
  }

  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var translatedLanguagesList =
        translatedLanguages.map((e) => e.toString()).toList();
    var originalLanguageList =
        originalLanguage.map((e) => e.toString()).toList();
    var contentRatingList = contentRating.map((e) => e.name).toList();

    await prefs.setStringList(_translatedLanguagesKey, translatedLanguagesList);
    await prefs.setStringList(_originalLanguageKey, originalLanguageList);
    await prefs.setStringList(_contentRatingKey, contentRatingList);
    await prefs.setBool(_dataSaverKey, dataSaver);
  }
}

Route createMangaDexSettingsRoute(MangaDexSettings settings) {
  return Styles.buildSlideTransitionRoute(
      (context, animation, secondaryAnimation) => MangaDexSettingsWidget(
            settings: settings,
          ));
}

class MangaDexSettingsWidget extends StatefulWidget {
  MangaDexSettingsWidget({Key? key, required this.settings}) : super(key: key);

  final MangaDexSettings settings;

  @override
  _MangaDexSettingsWidgetState createState() => _MangaDexSettingsWidgetState();
}

class _MangaDexSettingsWidgetState extends State<MangaDexSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: Text('MangaDex Settings'),
        actions: [
          ButtonBar(
            children: [
              Tooltip(
                message: 'Save Settings',
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  label: Text('Save Settings'),
                  onPressed: () {
                    Provider.of<MangaDexModel>(context, listen: false)
                        .setSettings(widget.settings);

                    Navigator.pop(context, true);
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
              title: Text(
                'Chapter Language Filter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Show only chapters from these languages.'),
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
                              selected: widget.settings.translatedLanguages
                                  .contains(lang),
                              onSelected: (value) {
                                setState(() {
                                  if (value) {
                                    widget.settings.translatedLanguages
                                        .add(lang);
                                  } else {
                                    widget.settings.translatedLanguages
                                        .remove(lang);
                                  }
                                });
                              }),
                        )
                    ],
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                'Original Language Filter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
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
                              selected: widget.settings.originalLanguage
                                  .contains(lang),
                              onSelected: (value) {
                                setState(() {
                                  if (value) {
                                    widget.settings.originalLanguage.add(lang);
                                  } else {
                                    widget.settings.originalLanguage
                                        .remove(lang);
                                  }
                                });
                              }),
                        )
                    ],
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
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
                              selected: widget.settings.contentRating
                                  .contains(content),
                              onSelected: (value) {
                                setState(() {
                                  if (value) {
                                    widget.settings.contentRating.add(content);
                                  } else {
                                    widget.settings.contentRating
                                        .remove(content);
                                  }
                                });
                              }),
                        )
                    ],
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
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
                      Text('Off'),
                      Switch(
                        value: widget.settings.dataSaver,
                        onChanged: (value) {
                          setState(() {
                            widget.settings.dataSaver = value;
                          });
                        },
                      ),
                      Text('On'),
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

class SettingCardWidget extends StatelessWidget {
  const SettingCardWidget(
      {required this.title, this.subtitle, required this.builder});

  final Widget title;
  final Widget? subtitle;
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);

    if (screenSizeSmall) {
      return ExpansionTile(
        title: title,
        subtitle: subtitle,
        children: [
          Container(
            color: Theme.of(context).cardColor,
            child: Center(
              child: builder(context),
            ),
          )
        ],
      );
    }

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  title,
                  SizedBox(
                    height: (subtitle != null ? 10 : 0),
                  ),
                  subtitle ?? SizedBox(),
                ],
              ),
            ),
            Expanded(child: builder(context))
          ],
        ),
      ),
    );
  }
}
