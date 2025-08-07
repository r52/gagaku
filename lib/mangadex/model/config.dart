import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model/model.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gagaku/mangadex/model/types.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@unfreezed
@Entity()
@JsonSerializable()
class MangaDexConfig with _$MangaDexConfig {
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @Id()
  int dbid;

  @override
  @Transient()
  @LanguageConverter()
  Set<Language> translatedLanguages;

  @override
  @Transient()
  @LanguageConverter()
  Set<Language> originalLanguage;

  @override
  @Transient()
  Set<ContentRating> contentRating;

  @override
  bool dataSaver;

  @override
  @Transient()
  Set<String> groupBlacklist;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String> get dbTranslatedLanguages => translatedLanguages
      .map((lang) => const LanguageConverter().toJson(lang) as String)
      .toList();

  set dbTranslatedLanguages(List<String> value) {
    translatedLanguages = value.map(const LanguageConverter().fromJson).toSet();
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String> get dbOriginalLanguage => originalLanguage
      .map((lang) => const LanguageConverter().toJson(lang) as String)
      .toList();

  set dbOriginalLanguage(List<String> value) {
    originalLanguage = value.map(const LanguageConverter().fromJson).toSet();
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String> get dbContentRating => contentRating.map((c) => c.name).toList();

  set dbContentRating(List<String> value) {
    contentRating = value.map((c) => ContentRating.values.byName(c)).toSet();
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String> get dbGroupBlacklist => groupBlacklist.toList();

  set dbGroupBlacklist(List<String> value) {
    groupBlacklist = value.toSet();
  }

  MangaDexConfig({
    this.dbid = 0,
    this.translatedLanguages = const {},
    this.originalLanguage = const {},
    this.contentRating = const {
      ContentRating.safe,
      ContentRating.suggestive,
      ContentRating.erotica,
    },
    this.dataSaver = false,
    this.groupBlacklist = const {},
  });

  factory MangaDexConfig.fromJson(Map<String, dynamic> json) =>
      _$MangaDexConfigFromJson(json);

  Map<String, Object?> toJson() => _$MangaDexConfigToJson(this);
}

@riverpod
class MdConfig extends _$MdConfig {
  MangaDexConfig _fetch() {
    final box = GagakuData().store.box<MangaDexConfig>();
    final query = box.query().build();

    MangaDexConfig? cfg;
    cfg = query.findUnique();
    query.close();

    if (cfg == null) {
      cfg = MangaDexConfig();
      box.put(cfg);
    }

    return cfg;
  }

  @override
  MangaDexConfig build() {
    return _fetch();
  }

  MangaDexConfig save(MangaDexConfig update) {
    final box = GagakuData().store.box<MangaDexConfig>();

    if (update.dbid == 0) {
      final query = box.query().build();
      final cfg = query.findUnique();
      query.close();

      if (cfg != null) {
        update.dbid = cfg.dbid;
      }
    }

    state = update;

    box.put(update);

    return update;
  }
}

final mdConfigSaveMutation = Mutation<MangaDexConfig>();
