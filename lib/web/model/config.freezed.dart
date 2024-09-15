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

WebSourceConfig _$WebSourceConfigFromJson(Map<String, dynamic> json) {
  return _WebSourceConfig.fromJson(json);
}

/// @nodoc
mixin _$WebSourceConfig {
  String get sourceDirectory => throw _privateConstructorUsedError;
  set sourceDirectory(String value) => throw _privateConstructorUsedError;
  List<String> get repoList => throw _privateConstructorUsedError;
  set repoList(List<String> value) => throw _privateConstructorUsedError;
  List<WebSourceCategory> get categories => throw _privateConstructorUsedError;
  set categories(List<WebSourceCategory> value) =>
      throw _privateConstructorUsedError;
  String get defaultCategory => throw _privateConstructorUsedError;
  set defaultCategory(String value) => throw _privateConstructorUsedError;

  /// Serializes this WebSourceConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebSourceConfigCopyWith<WebSourceConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSourceConfigCopyWith<$Res> {
  factory $WebSourceConfigCopyWith(
          WebSourceConfig value, $Res Function(WebSourceConfig) then) =
      _$WebSourceConfigCopyWithImpl<$Res, WebSourceConfig>;
  @useResult
  $Res call(
      {String sourceDirectory,
      List<String> repoList,
      List<WebSourceCategory> categories,
      String defaultCategory});
}

/// @nodoc
class _$WebSourceConfigCopyWithImpl<$Res, $Val extends WebSourceConfig>
    implements $WebSourceConfigCopyWith<$Res> {
  _$WebSourceConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceDirectory = null,
    Object? repoList = null,
    Object? categories = null,
    Object? defaultCategory = null,
  }) {
    return _then(_value.copyWith(
      sourceDirectory: null == sourceDirectory
          ? _value.sourceDirectory
          : sourceDirectory // ignore: cast_nullable_to_non_nullable
              as String,
      repoList: null == repoList
          ? _value.repoList
          : repoList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<WebSourceCategory>,
      defaultCategory: null == defaultCategory
          ? _value.defaultCategory
          : defaultCategory // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebSourceConfigImplCopyWith<$Res>
    implements $WebSourceConfigCopyWith<$Res> {
  factory _$$WebSourceConfigImplCopyWith(_$WebSourceConfigImpl value,
          $Res Function(_$WebSourceConfigImpl) then) =
      __$$WebSourceConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sourceDirectory,
      List<String> repoList,
      List<WebSourceCategory> categories,
      String defaultCategory});
}

/// @nodoc
class __$$WebSourceConfigImplCopyWithImpl<$Res>
    extends _$WebSourceConfigCopyWithImpl<$Res, _$WebSourceConfigImpl>
    implements _$$WebSourceConfigImplCopyWith<$Res> {
  __$$WebSourceConfigImplCopyWithImpl(
      _$WebSourceConfigImpl _value, $Res Function(_$WebSourceConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceDirectory = null,
    Object? repoList = null,
    Object? categories = null,
    Object? defaultCategory = null,
  }) {
    return _then(_$WebSourceConfigImpl(
      sourceDirectory: null == sourceDirectory
          ? _value.sourceDirectory
          : sourceDirectory // ignore: cast_nullable_to_non_nullable
              as String,
      repoList: null == repoList
          ? _value.repoList
          : repoList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<WebSourceCategory>,
      defaultCategory: null == defaultCategory
          ? _value.defaultCategory
          : defaultCategory // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSourceConfigImpl implements _WebSourceConfig {
  _$WebSourceConfigImpl(
      {this.sourceDirectory = '',
      this.repoList = const [],
      this.categories = const [_defaultCategory],
      this.defaultCategory = _defaultUUID});

  factory _$WebSourceConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSourceConfigImplFromJson(json);

  @override
  @JsonKey()
  String sourceDirectory;
  @override
  @JsonKey()
  List<String> repoList;
  @override
  @JsonKey()
  List<WebSourceCategory> categories;
  @override
  @JsonKey()
  String defaultCategory;

  @override
  String toString() {
    return 'WebSourceConfig(sourceDirectory: $sourceDirectory, repoList: $repoList, categories: $categories, defaultCategory: $defaultCategory)';
  }

  /// Create a copy of WebSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSourceConfigImplCopyWith<_$WebSourceConfigImpl> get copyWith =>
      __$$WebSourceConfigImplCopyWithImpl<_$WebSourceConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSourceConfigImplToJson(
      this,
    );
  }
}

abstract class _WebSourceConfig implements WebSourceConfig {
  factory _WebSourceConfig(
      {String sourceDirectory,
      List<String> repoList,
      List<WebSourceCategory> categories,
      String defaultCategory}) = _$WebSourceConfigImpl;

  factory _WebSourceConfig.fromJson(Map<String, dynamic> json) =
      _$WebSourceConfigImpl.fromJson;

  @override
  String get sourceDirectory;
  set sourceDirectory(String value);
  @override
  List<String> get repoList;
  set repoList(List<String> value);
  @override
  List<WebSourceCategory> get categories;
  set categories(List<WebSourceCategory> value);
  @override
  String get defaultCategory;
  set defaultCategory(String value);

  /// Create a copy of WebSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSourceConfigImplCopyWith<_$WebSourceConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
