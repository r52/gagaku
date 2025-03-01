// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MangaDexConfig {

@LanguageConverter() Set<Language> get translatedLanguages;@LanguageConverter() Set<Language> get originalLanguage; Set<ContentRating> get contentRating; bool get dataSaver; Set<String> get groupBlacklist;
/// Create a copy of MangaDexConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaDexConfigCopyWith<MangaDexConfig> get copyWith => _$MangaDexConfigCopyWithImpl<MangaDexConfig>(this as MangaDexConfig, _$identity);

  /// Serializes this MangaDexConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MangaDexConfig&&const DeepCollectionEquality().equals(other.translatedLanguages, translatedLanguages)&&const DeepCollectionEquality().equals(other.originalLanguage, originalLanguage)&&const DeepCollectionEquality().equals(other.contentRating, contentRating)&&(identical(other.dataSaver, dataSaver) || other.dataSaver == dataSaver)&&const DeepCollectionEquality().equals(other.groupBlacklist, groupBlacklist));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(translatedLanguages),const DeepCollectionEquality().hash(originalLanguage),const DeepCollectionEquality().hash(contentRating),dataSaver,const DeepCollectionEquality().hash(groupBlacklist));

@override
String toString() {
  return 'MangaDexConfig(translatedLanguages: $translatedLanguages, originalLanguage: $originalLanguage, contentRating: $contentRating, dataSaver: $dataSaver, groupBlacklist: $groupBlacklist)';
}


}

/// @nodoc
abstract mixin class $MangaDexConfigCopyWith<$Res>  {
  factory $MangaDexConfigCopyWith(MangaDexConfig value, $Res Function(MangaDexConfig) _then) = _$MangaDexConfigCopyWithImpl;
@useResult
$Res call({
@LanguageConverter() Set<Language> translatedLanguages,@LanguageConverter() Set<Language> originalLanguage, Set<ContentRating> contentRating, bool dataSaver, Set<String> groupBlacklist
});




}
/// @nodoc
class _$MangaDexConfigCopyWithImpl<$Res>
    implements $MangaDexConfigCopyWith<$Res> {
  _$MangaDexConfigCopyWithImpl(this._self, this._then);

  final MangaDexConfig _self;
  final $Res Function(MangaDexConfig) _then;

/// Create a copy of MangaDexConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? translatedLanguages = null,Object? originalLanguage = null,Object? contentRating = null,Object? dataSaver = null,Object? groupBlacklist = null,}) {
  return _then(_self.copyWith(
translatedLanguages: null == translatedLanguages ? _self.translatedLanguages : translatedLanguages // ignore: cast_nullable_to_non_nullable
as Set<Language>,originalLanguage: null == originalLanguage ? _self.originalLanguage : originalLanguage // ignore: cast_nullable_to_non_nullable
as Set<Language>,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as Set<ContentRating>,dataSaver: null == dataSaver ? _self.dataSaver : dataSaver // ignore: cast_nullable_to_non_nullable
as bool,groupBlacklist: null == groupBlacklist ? _self.groupBlacklist : groupBlacklist // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MangaDexConfig implements MangaDexConfig {
   _MangaDexConfig({@LanguageConverter() final  Set<Language> translatedLanguages = const {}, @LanguageConverter() final  Set<Language> originalLanguage = const {}, final  Set<ContentRating> contentRating = const {ContentRating.safe, ContentRating.suggestive, ContentRating.erotica}, this.dataSaver = false, final  Set<String> groupBlacklist = const {}}): _translatedLanguages = translatedLanguages,_originalLanguage = originalLanguage,_contentRating = contentRating,_groupBlacklist = groupBlacklist;
  factory _MangaDexConfig.fromJson(Map<String, dynamic> json) => _$MangaDexConfigFromJson(json);

 final  Set<Language> _translatedLanguages;
@override@JsonKey()@LanguageConverter() Set<Language> get translatedLanguages {
  if (_translatedLanguages is EqualUnmodifiableSetView) return _translatedLanguages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_translatedLanguages);
}

 final  Set<Language> _originalLanguage;
@override@JsonKey()@LanguageConverter() Set<Language> get originalLanguage {
  if (_originalLanguage is EqualUnmodifiableSetView) return _originalLanguage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_originalLanguage);
}

 final  Set<ContentRating> _contentRating;
@override@JsonKey() Set<ContentRating> get contentRating {
  if (_contentRating is EqualUnmodifiableSetView) return _contentRating;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_contentRating);
}

@override@JsonKey() final  bool dataSaver;
 final  Set<String> _groupBlacklist;
@override@JsonKey() Set<String> get groupBlacklist {
  if (_groupBlacklist is EqualUnmodifiableSetView) return _groupBlacklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_groupBlacklist);
}


/// Create a copy of MangaDexConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MangaDexConfigCopyWith<_MangaDexConfig> get copyWith => __$MangaDexConfigCopyWithImpl<_MangaDexConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MangaDexConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MangaDexConfig&&const DeepCollectionEquality().equals(other._translatedLanguages, _translatedLanguages)&&const DeepCollectionEquality().equals(other._originalLanguage, _originalLanguage)&&const DeepCollectionEquality().equals(other._contentRating, _contentRating)&&(identical(other.dataSaver, dataSaver) || other.dataSaver == dataSaver)&&const DeepCollectionEquality().equals(other._groupBlacklist, _groupBlacklist));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_translatedLanguages),const DeepCollectionEquality().hash(_originalLanguage),const DeepCollectionEquality().hash(_contentRating),dataSaver,const DeepCollectionEquality().hash(_groupBlacklist));

@override
String toString() {
  return 'MangaDexConfig(translatedLanguages: $translatedLanguages, originalLanguage: $originalLanguage, contentRating: $contentRating, dataSaver: $dataSaver, groupBlacklist: $groupBlacklist)';
}


}

/// @nodoc
abstract mixin class _$MangaDexConfigCopyWith<$Res> implements $MangaDexConfigCopyWith<$Res> {
  factory _$MangaDexConfigCopyWith(_MangaDexConfig value, $Res Function(_MangaDexConfig) _then) = __$MangaDexConfigCopyWithImpl;
@override @useResult
$Res call({
@LanguageConverter() Set<Language> translatedLanguages,@LanguageConverter() Set<Language> originalLanguage, Set<ContentRating> contentRating, bool dataSaver, Set<String> groupBlacklist
});




}
/// @nodoc
class __$MangaDexConfigCopyWithImpl<$Res>
    implements _$MangaDexConfigCopyWith<$Res> {
  __$MangaDexConfigCopyWithImpl(this._self, this._then);

  final _MangaDexConfig _self;
  final $Res Function(_MangaDexConfig) _then;

/// Create a copy of MangaDexConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? translatedLanguages = null,Object? originalLanguage = null,Object? contentRating = null,Object? dataSaver = null,Object? groupBlacklist = null,}) {
  return _then(_MangaDexConfig(
translatedLanguages: null == translatedLanguages ? _self._translatedLanguages : translatedLanguages // ignore: cast_nullable_to_non_nullable
as Set<Language>,originalLanguage: null == originalLanguage ? _self._originalLanguage : originalLanguage // ignore: cast_nullable_to_non_nullable
as Set<Language>,contentRating: null == contentRating ? _self._contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as Set<ContentRating>,dataSaver: null == dataSaver ? _self.dataSaver : dataSaver // ignore: cast_nullable_to_non_nullable
as bool,groupBlacklist: null == groupBlacklist ? _self._groupBlacklist : groupBlacklist // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
