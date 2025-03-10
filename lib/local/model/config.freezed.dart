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
mixin _$LocalLibConfig {

 String get libraryDirectory;
/// Create a copy of LocalLibConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalLibConfigCopyWith<LocalLibConfig> get copyWith => _$LocalLibConfigCopyWithImpl<LocalLibConfig>(this as LocalLibConfig, _$identity);

  /// Serializes this LocalLibConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalLibConfig&&(identical(other.libraryDirectory, libraryDirectory) || other.libraryDirectory == libraryDirectory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,libraryDirectory);

@override
String toString() {
  return 'LocalLibConfig(libraryDirectory: $libraryDirectory)';
}


}

/// @nodoc
abstract mixin class $LocalLibConfigCopyWith<$Res>  {
  factory $LocalLibConfigCopyWith(LocalLibConfig value, $Res Function(LocalLibConfig) _then) = _$LocalLibConfigCopyWithImpl;
@useResult
$Res call({
 String libraryDirectory
});




}
/// @nodoc
class _$LocalLibConfigCopyWithImpl<$Res>
    implements $LocalLibConfigCopyWith<$Res> {
  _$LocalLibConfigCopyWithImpl(this._self, this._then);

  final LocalLibConfig _self;
  final $Res Function(LocalLibConfig) _then;

/// Create a copy of LocalLibConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? libraryDirectory = null,}) {
  return _then(_self.copyWith(
libraryDirectory: null == libraryDirectory ? _self.libraryDirectory : libraryDirectory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LocalLibConfig implements LocalLibConfig {
   _LocalLibConfig({this.libraryDirectory = ''});
  factory _LocalLibConfig.fromJson(Map<String, dynamic> json) => _$LocalLibConfigFromJson(json);

@override@JsonKey() final  String libraryDirectory;

/// Create a copy of LocalLibConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalLibConfigCopyWith<_LocalLibConfig> get copyWith => __$LocalLibConfigCopyWithImpl<_LocalLibConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocalLibConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalLibConfig&&(identical(other.libraryDirectory, libraryDirectory) || other.libraryDirectory == libraryDirectory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,libraryDirectory);

@override
String toString() {
  return 'LocalLibConfig(libraryDirectory: $libraryDirectory)';
}


}

/// @nodoc
abstract mixin class _$LocalLibConfigCopyWith<$Res> implements $LocalLibConfigCopyWith<$Res> {
  factory _$LocalLibConfigCopyWith(_LocalLibConfig value, $Res Function(_LocalLibConfig) _then) = __$LocalLibConfigCopyWithImpl;
@override @useResult
$Res call({
 String libraryDirectory
});




}
/// @nodoc
class __$LocalLibConfigCopyWithImpl<$Res>
    implements _$LocalLibConfigCopyWith<$Res> {
  __$LocalLibConfigCopyWithImpl(this._self, this._then);

  final _LocalLibConfig _self;
  final $Res Function(_LocalLibConfig) _then;

/// Create a copy of LocalLibConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? libraryDirectory = null,}) {
  return _then(_LocalLibConfig(
libraryDirectory: null == libraryDirectory ? _self.libraryDirectory : libraryDirectory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
