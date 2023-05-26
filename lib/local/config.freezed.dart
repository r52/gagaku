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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LocalLibConfig _$LocalLibConfigFromJson(Map<String, dynamic> json) {
  return _LocalLibConfig.fromJson(json);
}

/// @nodoc
mixin _$LocalLibConfig {
  String get libraryDirectory => throw _privateConstructorUsedError;
  set libraryDirectory(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocalLibConfigCopyWith<LocalLibConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalLibConfigCopyWith<$Res> {
  factory $LocalLibConfigCopyWith(
          LocalLibConfig value, $Res Function(LocalLibConfig) then) =
      _$LocalLibConfigCopyWithImpl<$Res, LocalLibConfig>;
  @useResult
  $Res call({String libraryDirectory});
}

/// @nodoc
class _$LocalLibConfigCopyWithImpl<$Res, $Val extends LocalLibConfig>
    implements $LocalLibConfigCopyWith<$Res> {
  _$LocalLibConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? libraryDirectory = null,
  }) {
    return _then(_value.copyWith(
      libraryDirectory: null == libraryDirectory
          ? _value.libraryDirectory
          : libraryDirectory // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocalLibConfigCopyWith<$Res>
    implements $LocalLibConfigCopyWith<$Res> {
  factory _$$_LocalLibConfigCopyWith(
          _$_LocalLibConfig value, $Res Function(_$_LocalLibConfig) then) =
      __$$_LocalLibConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String libraryDirectory});
}

/// @nodoc
class __$$_LocalLibConfigCopyWithImpl<$Res>
    extends _$LocalLibConfigCopyWithImpl<$Res, _$_LocalLibConfig>
    implements _$$_LocalLibConfigCopyWith<$Res> {
  __$$_LocalLibConfigCopyWithImpl(
      _$_LocalLibConfig _value, $Res Function(_$_LocalLibConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? libraryDirectory = null,
  }) {
    return _then(_$_LocalLibConfig(
      libraryDirectory: null == libraryDirectory
          ? _value.libraryDirectory
          : libraryDirectory // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocalLibConfig implements _LocalLibConfig {
  _$_LocalLibConfig({this.libraryDirectory = ''});

  factory _$_LocalLibConfig.fromJson(Map<String, dynamic> json) =>
      _$$_LocalLibConfigFromJson(json);

  @override
  @JsonKey()
  String libraryDirectory;

  @override
  String toString() {
    return 'LocalLibConfig(libraryDirectory: $libraryDirectory)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocalLibConfigCopyWith<_$_LocalLibConfig> get copyWith =>
      __$$_LocalLibConfigCopyWithImpl<_$_LocalLibConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocalLibConfigToJson(
      this,
    );
  }
}

abstract class _LocalLibConfig implements LocalLibConfig {
  factory _LocalLibConfig({String libraryDirectory}) = _$_LocalLibConfig;

  factory _LocalLibConfig.fromJson(Map<String, dynamic> json) =
      _$_LocalLibConfig.fromJson;

  @override
  String get libraryDirectory;
  set libraryDirectory(String value);
  @override
  @JsonKey(ignore: true)
  _$$_LocalLibConfigCopyWith<_$_LocalLibConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
