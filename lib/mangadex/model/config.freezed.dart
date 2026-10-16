// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MangaDexConfig {


/// Create a copy of MangaDexConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaDexConfigCopyWith<MangaDexConfig> get copyWith => _$MangaDexConfigCopyWithImpl<MangaDexConfig>(this as MangaDexConfig, _$identity);





@override
String toString() {
  final _this = this as MangaDexConfig;
  return 'MangaDexConfig(dbid: ${_this.dbid}, translatedLanguages: ${_this.translatedLanguages}, originalLanguage: ${_this.originalLanguage}, contentRating: ${_this.contentRating}, dataSaver: ${_this.dataSaver}, groupBlacklist: ${_this.groupBlacklist})';
}


}

/// @nodoc
abstract mixin class $MangaDexConfigCopyWith<$Res>  {
  factory $MangaDexConfigCopyWith(MangaDexConfig value, $Res Function(MangaDexConfig) _then) = _$MangaDexConfigCopyWithImpl;
@useResult
$Res call({
 int dbid, Set<Language> translatedLanguages, Set<Language> originalLanguage, Set<ContentRating> contentRating, bool dataSaver, Set<String> groupBlacklist
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
@pragma('vm:prefer-inline') @override $Res call({Object? dbid = null,Object? translatedLanguages = null,Object? originalLanguage = null,Object? contentRating = null,Object? dataSaver = null,Object? groupBlacklist = null,}) {
  return _then(MangaDexConfig(
dbid: null == dbid ? _self.dbid : dbid // ignore: cast_nullable_to_non_nullable
as int,translatedLanguages: null == translatedLanguages ? _self.translatedLanguages : translatedLanguages // ignore: cast_nullable_to_non_nullable
as Set<Language>,originalLanguage: null == originalLanguage ? _self.originalLanguage : originalLanguage // ignore: cast_nullable_to_non_nullable
as Set<Language>,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as Set<ContentRating>,dataSaver: null == dataSaver ? _self.dataSaver : dataSaver // ignore: cast_nullable_to_non_nullable
as bool,groupBlacklist: null == groupBlacklist ? _self.groupBlacklist : groupBlacklist // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}



// dart format on
