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
mixin _$GagakuConfig {

/// Theme mode
 ThemeMode get themeMode;/// Theme color
@JsonKey(unknownEnumValue: GagakuTheme.lime) GagakuTheme get theme;// Grid view size
 GridAlbumExtent get gridAlbumExtent;
/// Create a copy of GagakuConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GagakuConfigCopyWith<GagakuConfig> get copyWith => _$GagakuConfigCopyWithImpl<GagakuConfig>(this as GagakuConfig, _$identity);

  /// Serializes this GagakuConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GagakuConfig&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.gridAlbumExtent, gridAlbumExtent) || other.gridAlbumExtent == gridAlbumExtent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeMode,theme,gridAlbumExtent);

@override
String toString() {
  return 'GagakuConfig(themeMode: $themeMode, theme: $theme, gridAlbumExtent: $gridAlbumExtent)';
}


}

/// @nodoc
abstract mixin class $GagakuConfigCopyWith<$Res>  {
  factory $GagakuConfigCopyWith(GagakuConfig value, $Res Function(GagakuConfig) _then) = _$GagakuConfigCopyWithImpl;
@useResult
$Res call({
 ThemeMode themeMode,@JsonKey(unknownEnumValue: GagakuTheme.lime) GagakuTheme theme, GridAlbumExtent gridAlbumExtent
});




}
/// @nodoc
class _$GagakuConfigCopyWithImpl<$Res>
    implements $GagakuConfigCopyWith<$Res> {
  _$GagakuConfigCopyWithImpl(this._self, this._then);

  final GagakuConfig _self;
  final $Res Function(GagakuConfig) _then;

/// Create a copy of GagakuConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? theme = null,Object? gridAlbumExtent = null,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as GagakuTheme,gridAlbumExtent: null == gridAlbumExtent ? _self.gridAlbumExtent : gridAlbumExtent // ignore: cast_nullable_to_non_nullable
as GridAlbumExtent,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _GagakuConfig implements GagakuConfig {
  const _GagakuConfig({this.themeMode = ThemeMode.system, @JsonKey(unknownEnumValue: GagakuTheme.lime) this.theme = GagakuTheme.lime, this.gridAlbumExtent = GridAlbumExtent.medium});
  factory _GagakuConfig.fromJson(Map<String, dynamic> json) => _$GagakuConfigFromJson(json);

/// Theme mode
@override@JsonKey() final  ThemeMode themeMode;
/// Theme color
@override@JsonKey(unknownEnumValue: GagakuTheme.lime) final  GagakuTheme theme;
// Grid view size
@override@JsonKey() final  GridAlbumExtent gridAlbumExtent;

/// Create a copy of GagakuConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GagakuConfigCopyWith<_GagakuConfig> get copyWith => __$GagakuConfigCopyWithImpl<_GagakuConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GagakuConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GagakuConfig&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.gridAlbumExtent, gridAlbumExtent) || other.gridAlbumExtent == gridAlbumExtent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeMode,theme,gridAlbumExtent);

@override
String toString() {
  return 'GagakuConfig(themeMode: $themeMode, theme: $theme, gridAlbumExtent: $gridAlbumExtent)';
}


}

/// @nodoc
abstract mixin class _$GagakuConfigCopyWith<$Res> implements $GagakuConfigCopyWith<$Res> {
  factory _$GagakuConfigCopyWith(_GagakuConfig value, $Res Function(_GagakuConfig) _then) = __$GagakuConfigCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode themeMode,@JsonKey(unknownEnumValue: GagakuTheme.lime) GagakuTheme theme, GridAlbumExtent gridAlbumExtent
});




}
/// @nodoc
class __$GagakuConfigCopyWithImpl<$Res>
    implements _$GagakuConfigCopyWith<$Res> {
  __$GagakuConfigCopyWithImpl(this._self, this._then);

  final _GagakuConfig _self;
  final $Res Function(_GagakuConfig) _then;

/// Create a copy of GagakuConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? theme = null,Object? gridAlbumExtent = null,}) {
  return _then(_GagakuConfig(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as GagakuTheme,gridAlbumExtent: null == gridAlbumExtent ? _self.gridAlbumExtent : gridAlbumExtent // ignore: cast_nullable_to_non_nullable
as GridAlbumExtent,
  ));
}


}

// dart format on
