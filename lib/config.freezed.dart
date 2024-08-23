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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GagakuConfig _$GagakuConfigFromJson(Map<String, dynamic> json) {
  return _GagakuConfig.fromJson(json);
}

/// @nodoc
mixin _$GagakuConfig {
  /// Theme mode
  ThemeMode get themeMode => throw _privateConstructorUsedError;

  /// Theme color
  @ColorConverter()
  Color get theme => throw _privateConstructorUsedError; // Grid view size
  GridAlbumExtent get gridAlbumExtent => throw _privateConstructorUsedError;

  /// Serializes this GagakuConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GagakuConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GagakuConfigCopyWith<GagakuConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GagakuConfigCopyWith<$Res> {
  factory $GagakuConfigCopyWith(
          GagakuConfig value, $Res Function(GagakuConfig) then) =
      _$GagakuConfigCopyWithImpl<$Res, GagakuConfig>;
  @useResult
  $Res call(
      {ThemeMode themeMode,
      @ColorConverter() Color theme,
      GridAlbumExtent gridAlbumExtent});
}

/// @nodoc
class _$GagakuConfigCopyWithImpl<$Res, $Val extends GagakuConfig>
    implements $GagakuConfigCopyWith<$Res> {
  _$GagakuConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GagakuConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? theme = null,
    Object? gridAlbumExtent = null,
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
      gridAlbumExtent: null == gridAlbumExtent
          ? _value.gridAlbumExtent
          : gridAlbumExtent // ignore: cast_nullable_to_non_nullable
              as GridAlbumExtent,
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
  $Res call(
      {ThemeMode themeMode,
      @ColorConverter() Color theme,
      GridAlbumExtent gridAlbumExtent});
}

/// @nodoc
class __$$GagakuConfigImplCopyWithImpl<$Res>
    extends _$GagakuConfigCopyWithImpl<$Res, _$GagakuConfigImpl>
    implements _$$GagakuConfigImplCopyWith<$Res> {
  __$$GagakuConfigImplCopyWithImpl(
      _$GagakuConfigImpl _value, $Res Function(_$GagakuConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of GagakuConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? theme = null,
    Object? gridAlbumExtent = null,
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
      gridAlbumExtent: null == gridAlbumExtent
          ? _value.gridAlbumExtent
          : gridAlbumExtent // ignore: cast_nullable_to_non_nullable
              as GridAlbumExtent,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GagakuConfigImpl implements _GagakuConfig {
  const _$GagakuConfigImpl(
      {this.themeMode = ThemeMode.system,
      @ColorConverter() this.theme = const Color(0xFFFFC107),
      this.gridAlbumExtent = GridAlbumExtent.medium});

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
// Grid view size
  @override
  @JsonKey()
  final GridAlbumExtent gridAlbumExtent;

  @override
  String toString() {
    return 'GagakuConfig(themeMode: $themeMode, theme: $theme, gridAlbumExtent: $gridAlbumExtent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GagakuConfigImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.gridAlbumExtent, gridAlbumExtent) ||
                other.gridAlbumExtent == gridAlbumExtent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, themeMode, theme, gridAlbumExtent);

  /// Create a copy of GagakuConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      @ColorConverter() final Color theme,
      final GridAlbumExtent gridAlbumExtent}) = _$GagakuConfigImpl;

  factory _GagakuConfig.fromJson(Map<String, dynamic> json) =
      _$GagakuConfigImpl.fromJson;

  /// Theme mode
  @override
  ThemeMode get themeMode;

  /// Theme color
  @override
  @ColorConverter()
  Color get theme; // Grid view size
  @override
  GridAlbumExtent get gridAlbumExtent;

  /// Create a copy of GagakuConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GagakuConfigImplCopyWith<_$GagakuConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
