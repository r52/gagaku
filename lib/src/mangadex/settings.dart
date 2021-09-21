import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ContentRating { safe, suggestive, erotica, pornographic }

class Language {
  final String name;
  final String code;

  const Language({required this.name, required this.code});

  @override
  String toString() {
    return code;
  }
}

class Languages {
  static const Map<String, Language> _languages = {
    'en': const Language(name: 'English', code: 'en'),
    'pt-br': const Language(name: 'Portuguese (BR)', code: 'pt-br'),
    'pt': const Language(name: 'Portuguese', code: 'pt'),
    'ru': const Language(name: 'Russian', code: 'ru'),
    'fr': const Language(name: 'French', code: 'fr'),
    'es-la': const Language(name: 'Spanish (LATAM)', code: 'es-la'),
    'es': const Language(name: 'Spanish', code: 'es'),
    'pl': const Language(name: 'Polish', code: 'pl'),
    'tr': const Language(name: 'Turkish', code: 'tr'),
    'it': const Language(name: 'Italian', code: 'it'),
    'id': const Language(name: 'Indoneasian', code: 'id'),
    'vi': const Language(name: 'Vietnam', code: 'vi'),
    'hu': const Language(name: 'Hungarian', code: 'hu'),
    'zh': const Language(name: 'Chinese (Simp.)', code: 'zh'),
    'zh-hk': const Language(name: 'Chinese (Trad.)', code: 'zh-hk'),
    'ar': const Language(name: 'Arabic', code: 'ar'),
    'de': const Language(name: 'German', code: 'de'),
    'th': const Language(name: 'Thai', code: 'th'),
    'ca': const Language(name: 'Catalan', code: 'ca'),
    'bg': const Language(name: 'Bulgarian', code: 'bg'),
    'fa': const Language(name: 'Persian', code: 'fa'),
    'uk': const Language(name: 'Ukrainian', code: 'uk'),
    'ro': const Language(name: 'Romanian', code: 'ro'),
    'he': const Language(name: 'Hebrew', code: 'he'),
    'mn': const Language(name: 'Mongolian', code: 'mn'),
    'ms': const Language(name: 'Malay', code: 'ms'),
    'tl': const Language(name: 'Tagalog', code: 'tl'),
    'ja': const Language(name: 'Japanese', code: 'ja'),
    'ko': const Language(name: 'Korean', code: 'ko'),
    'hi': const Language(name: 'Hindi', code: 'hi'),
    'my': const Language(name: 'Burmese', code: 'my'),
    'cs': const Language(name: 'Czech', code: 'cs'),
    'nl': const Language(name: 'Dutch', code: 'nl'),
    'sv': const Language(name: 'Swedish', code: 'sv'),
    'bn': const Language(name: 'Bengali', code: 'bn'),
    'no': const Language(name: 'Norwegian', code: 'no'),
    'lt': const Language(name: 'Lithuanian', code: 'lt'),
    'el': const Language(name: 'Greek', code: 'el'),
    'sr': const Language(name: 'Serbo-Croatian', code: 'sr'),
    'da': const Language(name: 'Danish', code: 'da'),
    'NULL': const Language(name: 'Other', code: 'NULL'),
  };

  static Map<String, Language> get languages => _languages;

  static Language get(String code) {
    return _languages[code]!;
  }

  static final english = _languages['en']!;
}

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
    this.translatedLanguages = const {},
    this.originalLanguage = const {},
    this.contentRating = const {
      ContentRating.safe,
      ContentRating.suggestive,
      ContentRating.erotica
    },
    this.dataSaver = false,
  });

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

    var contentRatingList = prefs.getStringList(_contentRatingKey) ?? [];
    var contentRating = contentRatingList
        .map((e) => ContentRating.values
            .firstWhere((element) => describeEnum(element) == e))
        .toSet();

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
    var contentRatingList = contentRating.map((e) => describeEnum(e)).toList();

    await prefs.setStringList(_translatedLanguagesKey, translatedLanguagesList);
    await prefs.setStringList(_originalLanguageKey, originalLanguageList);
    await prefs.setStringList(_contentRatingKey, contentRatingList);
    await prefs.setBool(_dataSaverKey, dataSaver);
  }
}
