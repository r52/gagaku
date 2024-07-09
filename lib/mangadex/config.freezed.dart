// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MangaDexConfig _$MangaDexConfigFromJson(Map<String, dynamic> json) {
  return _MangaDexConfig.fromJson(json);
}

/// @nodoc
mixin _$MangaDexConfig {
  @LanguageConverter()
  Set<Language> get translatedLanguages => throw _privateConstructorUsedError;
  @LanguageConverter()
  set translatedLanguages(Set<Language> value) =>
      throw _privateConstructorUsedError;
  @LanguageConverter()
  Set<Language> get originalLanguage => throw _privateConstructorUsedError;
  @LanguageConverter()
  set originalLanguage(Set<Language> value) =>
      throw _privateConstructorUsedError;
  Set<ContentRating> get contentRating => throw _privateConstructorUsedError;
  set contentRating(Set<ContentRating> value) =>
      throw _privateConstructorUsedError;
  bool get dataSaver => throw _privateConstructorUsedError;
  set dataSaver(bool value) => throw _privateConstructorUsedError;
  Set<String> get groupBlacklist => throw _privateConstructorUsedError;
  set groupBlacklist(Set<String> value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MangaDexConfigCopyWith<MangaDexConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaDexConfigCopyWith<$Res> {
  factory $MangaDexConfigCopyWith(
          MangaDexConfig value, $Res Function(MangaDexConfig) then) =
      _$MangaDexConfigCopyWithImpl<$Res, MangaDexConfig>;
  @useResult
  $Res call(
      {@LanguageConverter() Set<Language> translatedLanguages,
      @LanguageConverter() Set<Language> originalLanguage,
      Set<ContentRating> contentRating,
      bool dataSaver,
      Set<String> groupBlacklist});
}

/// @nodoc
class _$MangaDexConfigCopyWithImpl<$Res, $Val extends MangaDexConfig>
    implements $MangaDexConfigCopyWith<$Res> {
  _$MangaDexConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? translatedLanguages = null,
    Object? originalLanguage = null,
    Object? contentRating = null,
    Object? dataSaver = null,
    Object? groupBlacklist = null,
  }) {
    return _then(_value.copyWith(
      translatedLanguages: null == translatedLanguages
          ? _value.translatedLanguages
          : translatedLanguages // ignore: cast_nullable_to_non_nullable
              as Set<Language>,
      originalLanguage: null == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as Set<Language>,
      contentRating: null == contentRating
          ? _value.contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as Set<ContentRating>,
      dataSaver: null == dataSaver
          ? _value.dataSaver
          : dataSaver // ignore: cast_nullable_to_non_nullable
              as bool,
      groupBlacklist: null == groupBlacklist
          ? _value.groupBlacklist
          : groupBlacklist // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MangaDexConfigImplCopyWith<$Res>
    implements $MangaDexConfigCopyWith<$Res> {
  factory _$$MangaDexConfigImplCopyWith(_$MangaDexConfigImpl value,
          $Res Function(_$MangaDexConfigImpl) then) =
      __$$MangaDexConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@LanguageConverter() Set<Language> translatedLanguages,
      @LanguageConverter() Set<Language> originalLanguage,
      Set<ContentRating> contentRating,
      bool dataSaver,
      Set<String> groupBlacklist});
}

/// @nodoc
class __$$MangaDexConfigImplCopyWithImpl<$Res>
    extends _$MangaDexConfigCopyWithImpl<$Res, _$MangaDexConfigImpl>
    implements _$$MangaDexConfigImplCopyWith<$Res> {
  __$$MangaDexConfigImplCopyWithImpl(
      _$MangaDexConfigImpl _value, $Res Function(_$MangaDexConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? translatedLanguages = null,
    Object? originalLanguage = null,
    Object? contentRating = null,
    Object? dataSaver = null,
    Object? groupBlacklist = null,
  }) {
    return _then(_$MangaDexConfigImpl(
      translatedLanguages: null == translatedLanguages
          ? _value.translatedLanguages
          : translatedLanguages // ignore: cast_nullable_to_non_nullable
              as Set<Language>,
      originalLanguage: null == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as Set<Language>,
      contentRating: null == contentRating
          ? _value.contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as Set<ContentRating>,
      dataSaver: null == dataSaver
          ? _value.dataSaver
          : dataSaver // ignore: cast_nullable_to_non_nullable
              as bool,
      groupBlacklist: null == groupBlacklist
          ? _value.groupBlacklist
          : groupBlacklist // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaDexConfigImpl implements _MangaDexConfig {
  _$MangaDexConfigImpl(
      {@LanguageConverter() this.translatedLanguages = const {},
      @LanguageConverter() this.originalLanguage = const {},
      this.contentRating = const {
        ContentRating.safe,
        ContentRating.suggestive,
        ContentRating.erotica
      },
      this.dataSaver = false,
      this.groupBlacklist = const {}});

  factory _$MangaDexConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaDexConfigImplFromJson(json);

  @override
  @JsonKey()
  @LanguageConverter()
  Set<Language> translatedLanguages;
  @override
  @JsonKey()
  @LanguageConverter()
  Set<Language> originalLanguage;
  @override
  @JsonKey()
  Set<ContentRating> contentRating;
  @override
  @JsonKey()
  bool dataSaver;
  @override
  @JsonKey()
  Set<String> groupBlacklist;

  @override
  String toString() {
    return 'MangaDexConfig(translatedLanguages: $translatedLanguages, originalLanguage: $originalLanguage, contentRating: $contentRating, dataSaver: $dataSaver, groupBlacklist: $groupBlacklist)';
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaDexConfigImplCopyWith<_$MangaDexConfigImpl> get copyWith =>
      __$$MangaDexConfigImplCopyWithImpl<_$MangaDexConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaDexConfigImplToJson(
      this,
    );
  }
}

abstract class _MangaDexConfig implements MangaDexConfig {
  factory _MangaDexConfig(
      {@LanguageConverter() Set<Language> translatedLanguages,
      @LanguageConverter() Set<Language> originalLanguage,
      Set<ContentRating> contentRating,
      bool dataSaver,
      Set<String> groupBlacklist}) = _$MangaDexConfigImpl;

  factory _MangaDexConfig.fromJson(Map<String, dynamic> json) =
      _$MangaDexConfigImpl.fromJson;

  @override
  @LanguageConverter()
  Set<Language> get translatedLanguages;
  @LanguageConverter()
  set translatedLanguages(Set<Language> value);
  @override
  @LanguageConverter()
  Set<Language> get originalLanguage;
  @LanguageConverter()
  set originalLanguage(Set<Language> value);
  @override
  Set<ContentRating> get contentRating;
  set contentRating(Set<ContentRating> value);
  @override
  bool get dataSaver;
  set dataSaver(bool value);
  @override
  Set<String> get groupBlacklist;
  set groupBlacklist(Set<String> value);
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MangaDexConfigImplCopyWith<_$MangaDexConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
