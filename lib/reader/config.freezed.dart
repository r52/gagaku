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

ReaderConfig _$ReaderConfigFromJson(Map<String, dynamic> json) {
  return _ReaderConfig.fromJson(json);
}

/// @nodoc
mixin _$ReaderConfig {
  /// If true, the reader fits the page to widget width, otherwise
  /// it is contrained to widget height (default)
  bool get fitWidth => throw _privateConstructorUsedError;

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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      {bool fitWidth,
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fitWidth = null,
    Object? direction = null,
    Object? showProgressBar = null,
    Object? clickToTurn = null,
    Object? swipeGestures = null,
    Object? precacheCount = null,
  }) {
    return _then(_value.copyWith(
      fitWidth: null == fitWidth
          ? _value.fitWidth
          : fitWidth // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$_ReaderConfigCopyWith<$Res>
    implements $ReaderConfigCopyWith<$Res> {
  factory _$$_ReaderConfigCopyWith(
          _$_ReaderConfig value, $Res Function(_$_ReaderConfig) then) =
      __$$_ReaderConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool fitWidth,
      ReaderDirection direction,
      bool showProgressBar,
      bool clickToTurn,
      bool swipeGestures,
      int precacheCount});
}

/// @nodoc
class __$$_ReaderConfigCopyWithImpl<$Res>
    extends _$ReaderConfigCopyWithImpl<$Res, _$_ReaderConfig>
    implements _$$_ReaderConfigCopyWith<$Res> {
  __$$_ReaderConfigCopyWithImpl(
      _$_ReaderConfig _value, $Res Function(_$_ReaderConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fitWidth = null,
    Object? direction = null,
    Object? showProgressBar = null,
    Object? clickToTurn = null,
    Object? swipeGestures = null,
    Object? precacheCount = null,
  }) {
    return _then(_$_ReaderConfig(
      fitWidth: null == fitWidth
          ? _value.fitWidth
          : fitWidth // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$_ReaderConfig implements _ReaderConfig {
  const _$_ReaderConfig(
      {this.fitWidth = false,
      this.direction = ReaderDirection.leftToRight,
      this.showProgressBar = false,
      this.clickToTurn = true,
      this.swipeGestures = true,
      this.precacheCount = 3});

  factory _$_ReaderConfig.fromJson(Map<String, dynamic> json) =>
      _$$_ReaderConfigFromJson(json);

  /// If true, the reader fits the page to widget width, otherwise
  /// it is contrained to widget height (default)
  @override
  @JsonKey()
  final bool fitWidth;

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
    return 'ReaderConfig(fitWidth: $fitWidth, direction: $direction, showProgressBar: $showProgressBar, clickToTurn: $clickToTurn, swipeGestures: $swipeGestures, precacheCount: $precacheCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReaderConfig &&
            (identical(other.fitWidth, fitWidth) ||
                other.fitWidth == fitWidth) &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fitWidth, direction,
      showProgressBar, clickToTurn, swipeGestures, precacheCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReaderConfigCopyWith<_$_ReaderConfig> get copyWith =>
      __$$_ReaderConfigCopyWithImpl<_$_ReaderConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReaderConfigToJson(
      this,
    );
  }
}

abstract class _ReaderConfig implements ReaderConfig {
  const factory _ReaderConfig(
      {final bool fitWidth,
      final ReaderDirection direction,
      final bool showProgressBar,
      final bool clickToTurn,
      final bool swipeGestures,
      final int precacheCount}) = _$_ReaderConfig;

  factory _ReaderConfig.fromJson(Map<String, dynamic> json) =
      _$_ReaderConfig.fromJson;

  @override

  /// If true, the reader fits the page to widget width, otherwise
  /// it is contrained to widget height (default)
  bool get fitWidth;
  @override

  /// Reader direction
  ReaderDirection get direction;
  @override

  /// Displays progress bar if true (default false)
  bool get showProgressBar;
  @override

  /// Enable click/tap to turn page gesture
  bool get clickToTurn;
  @override

  /// Enable swipe gestures
  bool get swipeGestures;
  @override

  /// The number of images/pages to preload
  int get precacheCount;
  @override
  @JsonKey(ignore: true)
  _$$_ReaderConfigCopyWith<_$_ReaderConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
