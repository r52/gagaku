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

GagakuConfig _$GagakuConfigFromJson(Map<String, dynamic> json) {
  return _GagakuConfig.fromJson(json);
}

/// @nodoc
mixin _$GagakuConfig {
  /// Theme mode
  ThemeMode get themeMode => throw _privateConstructorUsedError;

  /// Theme color
  @ColorConverter()
  Color get theme => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GagakuConfigCopyWith<GagakuConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GagakuConfigCopyWith<$Res> {
  factory $GagakuConfigCopyWith(
          GagakuConfig value, $Res Function(GagakuConfig) then) =
      _$GagakuConfigCopyWithImpl<$Res, GagakuConfig>;
  @useResult
  $Res call({ThemeMode themeMode, @ColorConverter() Color theme});
}

/// @nodoc
class _$GagakuConfigCopyWithImpl<$Res, $Val extends GagakuConfig>
    implements $GagakuConfigCopyWith<$Res> {
  _$GagakuConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? theme = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GagakuConfigImplCopyWith<$Res>
    implements $GagakuConfigCopyWith<$Res> {
  factory _$$GagakuConfigImplCopyWith(
          _$GagakuConfigImpl value, $Res Function(_$GagakuConfigImpl) then) =
      __$$GagakuConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ThemeMode themeMode, @ColorConverter() Color theme});
}

/// @nodoc
class __$$GagakuConfigImplCopyWithImpl<$Res>
    extends _$GagakuConfigCopyWithImpl<$Res, _$GagakuConfigImpl>
    implements _$$GagakuConfigImplCopyWith<$Res> {
  __$$GagakuConfigImplCopyWithImpl(
      _$GagakuConfigImpl _value, $Res Function(_$GagakuConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? theme = null,
  }) {
    return _then(_$GagakuConfigImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GagakuConfigImpl implements _GagakuConfig {
  const _$GagakuConfigImpl(
      {this.themeMode = ThemeMode.system,
      @ColorConverter() this.theme = const Color(0xFFFFC107)});

  factory _$GagakuConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$GagakuConfigImplFromJson(json);

  /// Theme mode
  @override
  @JsonKey()
  final ThemeMode themeMode;

  /// Theme color
  @override
  @JsonKey()
  @ColorConverter()
  final Color theme;

  @override
  String toString() {
    return 'GagakuConfig(themeMode: $themeMode, theme: $theme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GagakuConfigImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.theme, theme) || other.theme == theme));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, themeMode, theme);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GagakuConfigImplCopyWith<_$GagakuConfigImpl> get copyWith =>
      __$$GagakuConfigImplCopyWithImpl<_$GagakuConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GagakuConfigImplToJson(
      this,
    );
  }
}

abstract class _GagakuConfig implements GagakuConfig {
  const factory _GagakuConfig(
      {final ThemeMode themeMode,
      @ColorConverter() final Color theme}) = _$GagakuConfigImpl;

  factory _GagakuConfig.fromJson(Map<String, dynamic> json) =
      _$GagakuConfigImpl.fromJson;

  @override

  /// Theme mode
  ThemeMode get themeMode;
  @override

  /// Theme color
  @ColorConverter()
  Color get theme;
  @override
  @JsonKey(ignore: true)
  _$$GagakuConfigImplCopyWith<_$GagakuConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
