import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gagaku/mangadex/types.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@unfreezed
class MangaDexConfig with _$MangaDexConfig {
  factory MangaDexConfig({
    @Default({}) @LanguageConverter() Set<Language> translatedLanguages,
    @Default({}) @LanguageConverter() Set<Language> originalLanguage,
    @Default({
      ContentRating.safe,
      ContentRating.suggestive,
      ContentRating.erotica
    })
        Set<ContentRating> contentRating,
    @Default(false) bool dataSaver,
  }) = _MangaDexConfig;

  factory MangaDexConfig.fromJson(Map<String, dynamic> json) =>
      _$MangaDexConfigFromJson(json);
}

@riverpod
class MdConfig extends _$MdConfig {
  MangaDexConfig _fetch() {
    final box = Hive.box(gagakuBox);
    final str = box.get('mangadex');

    if (str == null) {
      return MangaDexConfig();
    }

    final content = json.decode(str) as Map<String, dynamic>;

    return MangaDexConfig.fromJson(content);
  }

  @override
  MangaDexConfig build() {
    return _fetch();
  }

  void save() {
    final box = Hive.box(gagakuBox);
    box.put('mangadex', json.encode(state.toJson()));
  }
}
