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
mixin _$ReaderConfig {

/// Reader format
 ReaderFormat get format;/// Reader direction
 ReaderDirection get direction;/// Displays progress bar if true (default false)
 bool get showProgressBar;/// Enable click/tap to turn page gesture
 bool get clickToTurn;/// Enable swipe gestures
 bool get swipeGestures;/// The number of images/pages to preload
 int get precacheCount;
/// Create a copy of ReaderConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReaderConfigCopyWith<ReaderConfig> get copyWith => _$ReaderConfigCopyWithImpl<ReaderConfig>(this as ReaderConfig, _$identity);

  /// Serializes this ReaderConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderConfig&&(identical(other.format, format) || other.format == format)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.showProgressBar, showProgressBar) || other.showProgressBar == showProgressBar)&&(identical(other.clickToTurn, clickToTurn) || other.clickToTurn == clickToTurn)&&(identical(other.swipeGestures, swipeGestures) || other.swipeGestures == swipeGestures)&&(identical(other.precacheCount, precacheCount) || other.precacheCount == precacheCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,format,direction,showProgressBar,clickToTurn,swipeGestures,precacheCount);

@override
String toString() {
  return 'ReaderConfig(format: $format, direction: $direction, showProgressBar: $showProgressBar, clickToTurn: $clickToTurn, swipeGestures: $swipeGestures, precacheCount: $precacheCount)';
}


}

/// @nodoc
abstract mixin class $ReaderConfigCopyWith<$Res>  {
  factory $ReaderConfigCopyWith(ReaderConfig value, $Res Function(ReaderConfig) _then) = _$ReaderConfigCopyWithImpl;
@useResult
$Res call({
 ReaderFormat format, ReaderDirection direction, bool showProgressBar, bool clickToTurn, bool swipeGestures, int precacheCount
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
@pragma('vm:prefer-inline') @override $Res call({Object? format = null,Object? direction = null,Object? showProgressBar = null,Object? clickToTurn = null,Object? swipeGestures = null,Object? precacheCount = null,}) {
  return _then(_self.copyWith(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as ReaderFormat,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as ReaderDirection,showProgressBar: null == showProgressBar ? _self.showProgressBar : showProgressBar // ignore: cast_nullable_to_non_nullable
as bool,clickToTurn: null == clickToTurn ? _self.clickToTurn : clickToTurn // ignore: cast_nullable_to_non_nullable
as bool,swipeGestures: null == swipeGestures ? _self.swipeGestures : swipeGestures // ignore: cast_nullable_to_non_nullable
as bool,precacheCount: null == precacheCount ? _self.precacheCount : precacheCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _ReaderConfig implements ReaderConfig {
  const _ReaderConfig({this.format = ReaderFormat.single, this.direction = ReaderDirection.leftToRight, this.showProgressBar = false, this.clickToTurn = true, this.swipeGestures = true, this.precacheCount = 3});
  factory _ReaderConfig.fromJson(Map<String, dynamic> json) => _$ReaderConfigFromJson(json);

/// Reader format
@override@JsonKey() final  ReaderFormat format;
/// Reader direction
@override@JsonKey() final  ReaderDirection direction;
/// Displays progress bar if true (default false)
@override@JsonKey() final  bool showProgressBar;
/// Enable click/tap to turn page gesture
@override@JsonKey() final  bool clickToTurn;
/// Enable swipe gestures
@override@JsonKey() final  bool swipeGestures;
/// The number of images/pages to preload
@override@JsonKey() final  int precacheCount;

/// Create a copy of ReaderConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReaderConfigCopyWith<_ReaderConfig> get copyWith => __$ReaderConfigCopyWithImpl<_ReaderConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReaderConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReaderConfig&&(identical(other.format, format) || other.format == format)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.showProgressBar, showProgressBar) || other.showProgressBar == showProgressBar)&&(identical(other.clickToTurn, clickToTurn) || other.clickToTurn == clickToTurn)&&(identical(other.swipeGestures, swipeGestures) || other.swipeGestures == swipeGestures)&&(identical(other.precacheCount, precacheCount) || other.precacheCount == precacheCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,format,direction,showProgressBar,clickToTurn,swipeGestures,precacheCount);

@override
String toString() {
  return 'ReaderConfig(format: $format, direction: $direction, showProgressBar: $showProgressBar, clickToTurn: $clickToTurn, swipeGestures: $swipeGestures, precacheCount: $precacheCount)';
}


}

/// @nodoc
abstract mixin class _$ReaderConfigCopyWith<$Res> implements $ReaderConfigCopyWith<$Res> {
  factory _$ReaderConfigCopyWith(_ReaderConfig value, $Res Function(_ReaderConfig) _then) = __$ReaderConfigCopyWithImpl;
@override @useResult
$Res call({
 ReaderFormat format, ReaderDirection direction, bool showProgressBar, bool clickToTurn, bool swipeGestures, int precacheCount
});




}
/// @nodoc
class __$ReaderConfigCopyWithImpl<$Res>
    implements _$ReaderConfigCopyWith<$Res> {
  __$ReaderConfigCopyWithImpl(this._self, this._then);

  final _ReaderConfig _self;
  final $Res Function(_ReaderConfig) _then;

/// Create a copy of ReaderConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? format = null,Object? direction = null,Object? showProgressBar = null,Object? clickToTurn = null,Object? swipeGestures = null,Object? precacheCount = null,}) {
  return _then(_ReaderConfig(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
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
