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

ReaderConfig _$ReaderConfigFromJson(Map<String, dynamic> json) {
  return _ReaderConfig.fromJson(json);
}

/// @nodoc
mixin _$ReaderConfig {
  /// Reader format
  ReaderFormat get format => throw _privateConstructorUsedError;

  /// Reader direction
  ReaderDirection get direction => throw _privateConstructorUsedError;

  /// Displays progress bar if true (default false)
  bool get showProgressBar => throw _privateConstructorUsedError;

  /// Enable click/tap to turn page gesture
  bool get clickToTurn => throw _privateConstructorUsedError;

  /// Enable swipe gestures
  bool get swipeGestures => throw _privateConstructorUsedError;

  /// The number of images/pages to preload
  int get precacheCount => throw _privateConstructorUsedError;

  /// Serializes this ReaderConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReaderConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReaderConfigCopyWith<ReaderConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReaderConfigCopyWith<$Res> {
  factory $ReaderConfigCopyWith(
          ReaderConfig value, $Res Function(ReaderConfig) then) =
      _$ReaderConfigCopyWithImpl<$Res, ReaderConfig>;
  @useResult
  $Res call(
      {ReaderFormat format,
      ReaderDirection direction,
      bool showProgressBar,
      bool clickToTurn,
      bool swipeGestures,
      int precacheCount});
}

/// @nodoc
class _$ReaderConfigCopyWithImpl<$Res, $Val extends ReaderConfig>
    implements $ReaderConfigCopyWith<$Res> {
  _$ReaderConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReaderConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? format = null,
    Object? direction = null,
    Object? showProgressBar = null,
    Object? clickToTurn = null,
    Object? swipeGestures = null,
    Object? precacheCount = null,
  }) {
    return _then(_value.copyWith(
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as ReaderFormat,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as ReaderDirection,
      showProgressBar: null == showProgressBar
          ? _value.showProgressBar
          : showProgressBar // ignore: cast_nullable_to_non_nullable
              as bool,
      clickToTurn: null == clickToTurn
          ? _value.clickToTurn
          : clickToTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      swipeGestures: null == swipeGestures
          ? _value.swipeGestures
          : swipeGestures // ignore: cast_nullable_to_non_nullable
              as bool,
      precacheCount: null == precacheCount
          ? _value.precacheCount
          : precacheCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReaderConfigImplCopyWith<$Res>
    implements $ReaderConfigCopyWith<$Res> {
  factory _$$ReaderConfigImplCopyWith(
          _$ReaderConfigImpl value, $Res Function(_$ReaderConfigImpl) then) =
      __$$ReaderConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ReaderFormat format,
      ReaderDirection direction,
      bool showProgressBar,
      bool clickToTurn,
      bool swipeGestures,
      int precacheCount});
}

/// @nodoc
class __$$ReaderConfigImplCopyWithImpl<$Res>
    extends _$ReaderConfigCopyWithImpl<$Res, _$ReaderConfigImpl>
    implements _$$ReaderConfigImplCopyWith<$Res> {
  __$$ReaderConfigImplCopyWithImpl(
      _$ReaderConfigImpl _value, $Res Function(_$ReaderConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReaderConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? format = null,
    Object? direction = null,
    Object? showProgressBar = null,
    Object? clickToTurn = null,
    Object? swipeGestures = null,
    Object? precacheCount = null,
  }) {
    return _then(_$ReaderConfigImpl(
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as ReaderFormat,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as ReaderDirection,
      showProgressBar: null == showProgressBar
          ? _value.showProgressBar
          : showProgressBar // ignore: cast_nullable_to_non_nullable
              as bool,
      clickToTurn: null == clickToTurn
          ? _value.clickToTurn
          : clickToTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      swipeGestures: null == swipeGestures
          ? _value.swipeGestures
          : swipeGestures // ignore: cast_nullable_to_non_nullable
              as bool,
      precacheCount: null == precacheCount
          ? _value.precacheCount
          : precacheCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReaderConfigImpl implements _ReaderConfig {
  const _$ReaderConfigImpl(
      {this.format = ReaderFormat.single,
      this.direction = ReaderDirection.leftToRight,
      this.showProgressBar = false,
      this.clickToTurn = true,
      this.swipeGestures = true,
      this.precacheCount = 3});

  factory _$ReaderConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReaderConfigImplFromJson(json);

  /// Reader format
  @override
  @JsonKey()
  final ReaderFormat format;

  /// Reader direction
  @override
  @JsonKey()
  final ReaderDirection direction;

  /// Displays progress bar if true (default false)
  @override
  @JsonKey()
  final bool showProgressBar;

  /// Enable click/tap to turn page gesture
  @override
  @JsonKey()
  final bool clickToTurn;

  /// Enable swipe gestures
  @override
  @JsonKey()
  final bool swipeGestures;

  /// The number of images/pages to preload
  @override
  @JsonKey()
  final int precacheCount;

  @override
  String toString() {
    return 'ReaderConfig(format: $format, direction: $direction, showProgressBar: $showProgressBar, clickToTurn: $clickToTurn, swipeGestures: $swipeGestures, precacheCount: $precacheCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReaderConfigImpl &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.showProgressBar, showProgressBar) ||
                other.showProgressBar == showProgressBar) &&
            (identical(other.clickToTurn, clickToTurn) ||
                other.clickToTurn == clickToTurn) &&
            (identical(other.swipeGestures, swipeGestures) ||
                other.swipeGestures == swipeGestures) &&
            (identical(other.precacheCount, precacheCount) ||
                other.precacheCount == precacheCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, format, direction,
      showProgressBar, clickToTurn, swipeGestures, precacheCount);

  /// Create a copy of ReaderConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReaderConfigImplCopyWith<_$ReaderConfigImpl> get copyWith =>
      __$$ReaderConfigImplCopyWithImpl<_$ReaderConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReaderConfigImplToJson(
      this,
    );
  }
}

abstract class _ReaderConfig implements ReaderConfig {
  const factory _ReaderConfig(
      {final ReaderFormat format,
      final ReaderDirection direction,
      final bool showProgressBar,
      final bool clickToTurn,
      final bool swipeGestures,
      final int precacheCount}) = _$ReaderConfigImpl;

  factory _ReaderConfig.fromJson(Map<String, dynamic> json) =
      _$ReaderConfigImpl.fromJson;

  /// Reader format
  @override
  ReaderFormat get format;

  /// Reader direction
  @override
  ReaderDirection get direction;

  /// Displays progress bar if true (default false)
  @override
  bool get showProgressBar;

  /// Enable click/tap to turn page gesture
  @override
  bool get clickToTurn;

  /// Enable swipe gestures
  @override
  bool get swipeGestures;

  /// The number of images/pages to preload
  @override
  int get precacheCount;

  /// Create a copy of ReaderConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReaderConfigImplCopyWith<_$ReaderConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
