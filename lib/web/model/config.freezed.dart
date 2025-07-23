// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtensionConfig {

@JsonKey(includeFromJson: false, includeToJson: false)@Id() int get dbid;@JsonKey(includeFromJson: false, includeToJson: false)@Id() set dbid(int value); String get defaultCategory; set defaultCategory(String value); List<String> get categoriesToUpdate; set categoriesToUpdate(List<String> value);
/// Create a copy of ExtensionConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtensionConfigCopyWith<ExtensionConfig> get copyWith => _$ExtensionConfigCopyWithImpl<ExtensionConfig>(this as ExtensionConfig, _$identity);

  /// Serializes this ExtensionConfig to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'ExtensionConfig(dbid: $dbid, defaultCategory: $defaultCategory, categoriesToUpdate: $categoriesToUpdate)';
}


}

/// @nodoc
abstract mixin class $ExtensionConfigCopyWith<$Res>  {
  factory $ExtensionConfigCopyWith(ExtensionConfig value, $Res Function(ExtensionConfig) _then) = _$ExtensionConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false)@Id() int dbid, String defaultCategory, List<String> categoriesToUpdate
});




}
/// @nodoc
class _$ExtensionConfigCopyWithImpl<$Res>
    implements $ExtensionConfigCopyWith<$Res> {
  _$ExtensionConfigCopyWithImpl(this._self, this._then);

  final ExtensionConfig _self;
  final $Res Function(ExtensionConfig) _then;

/// Create a copy of ExtensionConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dbid = null,Object? defaultCategory = null,Object? categoriesToUpdate = null,}) {
  return _then(_self.copyWith(
dbid: null == dbid ? _self.dbid : dbid // ignore: cast_nullable_to_non_nullable
as int,defaultCategory: null == defaultCategory ? _self.defaultCategory : defaultCategory // ignore: cast_nullable_to_non_nullable
as String,categoriesToUpdate: null == categoriesToUpdate ? _self.categoriesToUpdate : categoriesToUpdate // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}



/// @nodoc
@JsonSerializable()
@Entity(realClass: ExtensionConfig)
class _ExtensionConfig implements ExtensionConfig {
   _ExtensionConfig({@JsonKey(includeFromJson: false, includeToJson: false)@Id() this.dbid = 0, this.defaultCategory = '', this.categoriesToUpdate = const []});
  factory _ExtensionConfig.fromJson(Map<String, dynamic> json) => _$ExtensionConfigFromJson(json);

@override@JsonKey(includeFromJson: false, includeToJson: false)@Id()  int dbid;
@override@JsonKey()  String defaultCategory;
@override@JsonKey()  List<String> categoriesToUpdate;

/// Create a copy of ExtensionConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtensionConfigCopyWith<_ExtensionConfig> get copyWith => __$ExtensionConfigCopyWithImpl<_ExtensionConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExtensionConfigToJson(this, );
}



@override
String toString() {
  return 'ExtensionConfig(dbid: $dbid, defaultCategory: $defaultCategory, categoriesToUpdate: $categoriesToUpdate)';
}


}

/// @nodoc
abstract mixin class _$ExtensionConfigCopyWith<$Res> implements $ExtensionConfigCopyWith<$Res> {
  factory _$ExtensionConfigCopyWith(_ExtensionConfig value, $Res Function(_ExtensionConfig) _then) = __$ExtensionConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false)@Id() int dbid, String defaultCategory, List<String> categoriesToUpdate
});




}
/// @nodoc
class __$ExtensionConfigCopyWithImpl<$Res>
    implements _$ExtensionConfigCopyWith<$Res> {
  __$ExtensionConfigCopyWithImpl(this._self, this._then);

  final _ExtensionConfig _self;
  final $Res Function(_ExtensionConfig) _then;

/// Create a copy of ExtensionConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dbid = null,Object? defaultCategory = null,Object? categoriesToUpdate = null,}) {
  return _then(_ExtensionConfig(
dbid: null == dbid ? _self.dbid : dbid // ignore: cast_nullable_to_non_nullable
as int,defaultCategory: null == defaultCategory ? _self.defaultCategory : defaultCategory // ignore: cast_nullable_to_non_nullable
as String,categoriesToUpdate: null == categoriesToUpdate ? _self.categoriesToUpdate : categoriesToUpdate // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
