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

 int get dbid; set dbid(int value); ThemeMode get themeMode; set themeMode(ThemeMode value); GagakuTheme get theme; set theme(GagakuTheme value); GridAlbumExtent get gridAlbumExtent; set gridAlbumExtent(GridAlbumExtent value); bool get checkForUpdates; set checkForUpdates(bool value); int get updateCheckCooldownHours; set updateCheckCooldownHours(int value); String get updateChannel; set updateChannel(String value); List<String> get ignoredUpdates; set ignoredUpdates(List<String> value); DateTime? get lastUpdateCheck; set lastUpdateCheck(DateTime? value);
/// Create a copy of GagakuConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GagakuConfigCopyWith<GagakuConfig> get copyWith => _$GagakuConfigCopyWithImpl<GagakuConfig>(this as GagakuConfig, _$identity);





@override
String toString() {
  return 'GagakuConfig(dbid: $dbid, themeMode: $themeMode, theme: $theme, gridAlbumExtent: $gridAlbumExtent, checkForUpdates: $checkForUpdates, updateCheckCooldownHours: $updateCheckCooldownHours, updateChannel: $updateChannel, ignoredUpdates: $ignoredUpdates, lastUpdateCheck: $lastUpdateCheck)';
}


}

/// @nodoc
abstract mixin class $GagakuConfigCopyWith<$Res>  {
  factory $GagakuConfigCopyWith(GagakuConfig value, $Res Function(GagakuConfig) _then) = _$GagakuConfigCopyWithImpl;
@useResult
$Res call({
 int dbid, ThemeMode themeMode, GagakuTheme theme, GridAlbumExtent gridAlbumExtent, bool checkForUpdates, int updateCheckCooldownHours, String updateChannel, List<String> ignoredUpdates, DateTime? lastUpdateCheck
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
@pragma('vm:prefer-inline') @override $Res call({Object? dbid = null,Object? themeMode = null,Object? theme = null,Object? gridAlbumExtent = null,Object? checkForUpdates = null,Object? updateCheckCooldownHours = null,Object? updateChannel = null,Object? ignoredUpdates = null,Object? lastUpdateCheck = freezed,}) {
  return _then(GagakuConfig(
dbid: null == dbid ? _self.dbid : dbid // ignore: cast_nullable_to_non_nullable
as int,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as GagakuTheme,gridAlbumExtent: null == gridAlbumExtent ? _self.gridAlbumExtent : gridAlbumExtent // ignore: cast_nullable_to_non_nullable
as GridAlbumExtent,checkForUpdates: null == checkForUpdates ? _self.checkForUpdates : checkForUpdates // ignore: cast_nullable_to_non_nullable
as bool,updateCheckCooldownHours: null == updateCheckCooldownHours ? _self.updateCheckCooldownHours : updateCheckCooldownHours // ignore: cast_nullable_to_non_nullable
as int,updateChannel: null == updateChannel ? _self.updateChannel : updateChannel // ignore: cast_nullable_to_non_nullable
as String,ignoredUpdates: null == ignoredUpdates ? _self.ignoredUpdates : ignoredUpdates // ignore: cast_nullable_to_non_nullable
as List<String>,lastUpdateCheck: freezed == lastUpdateCheck ? _self.lastUpdateCheck : lastUpdateCheck // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}



// dart format on
