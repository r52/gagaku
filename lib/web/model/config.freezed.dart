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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WebSourceConfig _$WebSourceConfigFromJson(Map<String, dynamic> json) {
  return _WebSourceConfig.fromJson(json);
}

/// @nodoc
mixin _$WebSourceConfig {
  List<WebSourceInfo> get installedSources =>
      throw _privateConstructorUsedError;
  set installedSources(List<WebSourceInfo> value) =>
      throw _privateConstructorUsedError;
  @RepoConverter()
  List<RepoInfo> get repoList => throw _privateConstructorUsedError;
  @RepoConverter()
  set repoList(List<RepoInfo> value) => throw _privateConstructorUsedError;
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
    WebSourceConfig value,
    $Res Function(WebSourceConfig) then,
  ) = _$WebSourceConfigCopyWithImpl<$Res, WebSourceConfig>;
  @useResult
  $Res call({
    List<WebSourceInfo> installedSources,
    @RepoConverter() List<RepoInfo> repoList,
    List<WebSourceCategory> categories,
    String defaultCategory,
  });
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
    Object? installedSources = null,
    Object? repoList = null,
    Object? categories = null,
    Object? defaultCategory = null,
  }) {
    return _then(
      _value.copyWith(
            installedSources:
                null == installedSources
                    ? _value.installedSources
                    : installedSources // ignore: cast_nullable_to_non_nullable
                        as List<WebSourceInfo>,
            repoList:
                null == repoList
                    ? _value.repoList
                    : repoList // ignore: cast_nullable_to_non_nullable
                        as List<RepoInfo>,
            categories:
                null == categories
                    ? _value.categories
                    : categories // ignore: cast_nullable_to_non_nullable
                        as List<WebSourceCategory>,
            defaultCategory:
                null == defaultCategory
                    ? _value.defaultCategory
                    : defaultCategory // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WebSourceConfigImplCopyWith<$Res>
    implements $WebSourceConfigCopyWith<$Res> {
  factory _$$WebSourceConfigImplCopyWith(
    _$WebSourceConfigImpl value,
    $Res Function(_$WebSourceConfigImpl) then,
  ) = __$$WebSourceConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<WebSourceInfo> installedSources,
    @RepoConverter() List<RepoInfo> repoList,
    List<WebSourceCategory> categories,
    String defaultCategory,
  });
}

/// @nodoc
class __$$WebSourceConfigImplCopyWithImpl<$Res>
    extends _$WebSourceConfigCopyWithImpl<$Res, _$WebSourceConfigImpl>
    implements _$$WebSourceConfigImplCopyWith<$Res> {
  __$$WebSourceConfigImplCopyWithImpl(
    _$WebSourceConfigImpl _value,
    $Res Function(_$WebSourceConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WebSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? installedSources = null,
    Object? repoList = null,
    Object? categories = null,
    Object? defaultCategory = null,
  }) {
    return _then(
      _$WebSourceConfigImpl(
        installedSources:
            null == installedSources
                ? _value.installedSources
                : installedSources // ignore: cast_nullable_to_non_nullable
                    as List<WebSourceInfo>,
        repoList:
            null == repoList
                ? _value.repoList
                : repoList // ignore: cast_nullable_to_non_nullable
                    as List<RepoInfo>,
        categories:
            null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                    as List<WebSourceCategory>,
        defaultCategory:
            null == defaultCategory
                ? _value.defaultCategory
                : defaultCategory // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSourceConfigImpl implements _WebSourceConfig {
  _$WebSourceConfigImpl({
    this.installedSources = const [],
    @RepoConverter() this.repoList = const [],
    this.categories = const [_defaultCategory],
    this.defaultCategory = _defaultUUID,
  });

  factory _$WebSourceConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSourceConfigImplFromJson(json);

  @override
  @JsonKey()
  List<WebSourceInfo> installedSources;
  @override
  @JsonKey()
  @RepoConverter()
  List<RepoInfo> repoList;
  @override
  @JsonKey()
  List<WebSourceCategory> categories;
  @override
  @JsonKey()
  String defaultCategory;

  @override
  String toString() {
    return 'WebSourceConfig(installedSources: $installedSources, repoList: $repoList, categories: $categories, defaultCategory: $defaultCategory)';
  }

  /// Create a copy of WebSourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSourceConfigImplCopyWith<_$WebSourceConfigImpl> get copyWith =>
      __$$WebSourceConfigImplCopyWithImpl<_$WebSourceConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSourceConfigImplToJson(this);
  }
}

abstract class _WebSourceConfig implements WebSourceConfig {
  factory _WebSourceConfig({
    List<WebSourceInfo> installedSources,
    @RepoConverter() List<RepoInfo> repoList,
    List<WebSourceCategory> categories,
    String defaultCategory,
  }) = _$WebSourceConfigImpl;

  factory _WebSourceConfig.fromJson(Map<String, dynamic> json) =
      _$WebSourceConfigImpl.fromJson;

  @override
  List<WebSourceInfo> get installedSources;
  set installedSources(List<WebSourceInfo> value);
  @override
  @RepoConverter()
  List<RepoInfo> get repoList;
  @RepoConverter()
  set repoList(List<RepoInfo> value);
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
