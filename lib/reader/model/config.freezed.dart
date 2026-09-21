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
mixin _$ReaderConfig {


/// Create a copy of ReaderConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReaderConfigCopyWith<ReaderConfig> get copyWith => _$ReaderConfigCopyWithImpl<ReaderConfig>(this as ReaderConfig, _$identity);





@override
String toString() {
  final _this = this as ReaderConfig;
  return 'ReaderConfig(dbid: ${_this.dbid}, format: ${_this.format}, direction: ${_this.direction}, showProgressBar: ${_this.showProgressBar}, clickToTurn: ${_this.clickToTurn}, swipeGestures: ${_this.swipeGestures}, precacheCount: ${_this.precacheCount})';
}


}

/// @nodoc
abstract mixin class $ReaderConfigCopyWith<$Res>  {
  factory $ReaderConfigCopyWith(ReaderConfig value, $Res Function(ReaderConfig) _then) = _$ReaderConfigCopyWithImpl;
@useResult
$Res call({
 int dbid, ReaderFormat format, ReaderDirection direction, bool showProgressBar, bool clickToTurn, bool swipeGestures, int precacheCount
});




}
/// @nodoc
class _$ReaderConfigCopyWithImpl<$Res>
    implements $ReaderConfigCopyWith<$Res> {
  _$ReaderConfigCopyWithImpl(this._self, this._then);

  final ReaderConfig _self;
  final $Res Function(ReaderConfig) _then;

/// Create a copy of ReaderConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dbid = null,Object? format = null,Object? direction = null,Object? showProgressBar = null,Object? clickToTurn = null,Object? swipeGestures = null,Object? precacheCount = null,}) {
  return _then(ReaderConfig(
dbid: null == dbid ? _self.dbid : dbid // ignore: cast_nullable_to_non_nullable
as int,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as ReaderFormat,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as ReaderDirection,showProgressBar: null == showProgressBar ? _self.showProgressBar : showProgressBar // ignore: cast_nullable_to_non_nullable
as bool,clickToTurn: null == clickToTurn ? _self.clickToTurn : clickToTurn // ignore: cast_nullable_to_non_nullable
as bool,swipeGestures: null == swipeGestures ? _self.swipeGestures : swipeGestures // ignore: cast_nullable_to_non_nullable
as bool,precacheCount: null == precacheCount ? _self.precacheCount : precacheCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



// dart format on
