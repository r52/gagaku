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
abstract class _$$LocalLibConfigImplCopyWith<$Res>
    implements $LocalLibConfigCopyWith<$Res> {
  factory _$$LocalLibConfigImplCopyWith(_$LocalLibConfigImpl value,
          $Res Function(_$LocalLibConfigImpl) then) =
      __$$LocalLibConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String libraryDirectory});
}

/// @nodoc
class __$$LocalLibConfigImplCopyWithImpl<$Res>
    extends _$LocalLibConfigCopyWithImpl<$Res, _$LocalLibConfigImpl>
    implements _$$LocalLibConfigImplCopyWith<$Res> {
  __$$LocalLibConfigImplCopyWithImpl(
      _$LocalLibConfigImpl _value, $Res Function(_$LocalLibConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? libraryDirectory = null,
  }) {
    return _then(_$LocalLibConfigImpl(
      libraryDirectory: null == libraryDirectory
          ? _value.libraryDirectory
          : libraryDirectory // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalLibConfigImpl implements _LocalLibConfig {
  _$LocalLibConfigImpl({this.libraryDirectory = ''});

  factory _$LocalLibConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalLibConfigImplFromJson(json);

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
  _$$LocalLibConfigImplCopyWith<_$LocalLibConfigImpl> get copyWith =>
      __$$LocalLibConfigImplCopyWithImpl<_$LocalLibConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalLibConfigImplToJson(
      this,
    );
  }
}

abstract class _LocalLibConfig implements LocalLibConfig {
  factory _LocalLibConfig({String libraryDirectory}) = _$LocalLibConfigImpl;

  factory _LocalLibConfig.fromJson(Map<String, dynamic> json) =
      _$LocalLibConfigImpl.fromJson;

  @override
  String get libraryDirectory;
  set libraryDirectory(String value);
  @override
  @JsonKey(ignore: true)
  _$$LocalLibConfigImplCopyWith<_$LocalLibConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
