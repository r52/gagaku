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
mixin _$WebSourceConfig {

 List<WebSourceInfo> get installedSources;@RepoConverter() List<RepoInfo> get repoList; List<WebSourceCategory> get categories; String get defaultCategory; List<String> get categoriesToUpdate;
/// Create a copy of WebSourceConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebSourceConfigCopyWith<WebSourceConfig> get copyWith => _$WebSourceConfigCopyWithImpl<WebSourceConfig>(this as WebSourceConfig, _$identity);

  /// Serializes this WebSourceConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebSourceConfig&&const DeepCollectionEquality().equals(other.installedSources, installedSources)&&const DeepCollectionEquality().equals(other.repoList, repoList)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.defaultCategory, defaultCategory) || other.defaultCategory == defaultCategory)&&const DeepCollectionEquality().equals(other.categoriesToUpdate, categoriesToUpdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(installedSources),const DeepCollectionEquality().hash(repoList),const DeepCollectionEquality().hash(categories),defaultCategory,const DeepCollectionEquality().hash(categoriesToUpdate));

@override
String toString() {
  return 'WebSourceConfig(installedSources: $installedSources, repoList: $repoList, categories: $categories, defaultCategory: $defaultCategory, categoriesToUpdate: $categoriesToUpdate)';
}


}

/// @nodoc
abstract mixin class $WebSourceConfigCopyWith<$Res>  {
  factory $WebSourceConfigCopyWith(WebSourceConfig value, $Res Function(WebSourceConfig) _then) = _$WebSourceConfigCopyWithImpl;
@useResult
$Res call({
 List<WebSourceInfo> installedSources,@RepoConverter() List<RepoInfo> repoList, List<WebSourceCategory> categories, String defaultCategory, List<String> categoriesToUpdate
});




}
/// @nodoc
class _$WebSourceConfigCopyWithImpl<$Res>
    implements $WebSourceConfigCopyWith<$Res> {
  _$WebSourceConfigCopyWithImpl(this._self, this._then);

  final WebSourceConfig _self;
  final $Res Function(WebSourceConfig) _then;

/// Create a copy of WebSourceConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? installedSources = null,Object? repoList = null,Object? categories = null,Object? defaultCategory = null,Object? categoriesToUpdate = null,}) {
  return _then(_self.copyWith(
installedSources: null == installedSources ? _self.installedSources : installedSources // ignore: cast_nullable_to_non_nullable
as List<WebSourceInfo>,repoList: null == repoList ? _self.repoList : repoList // ignore: cast_nullable_to_non_nullable
as List<RepoInfo>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<WebSourceCategory>,defaultCategory: null == defaultCategory ? _self.defaultCategory : defaultCategory // ignore: cast_nullable_to_non_nullable
as String,categoriesToUpdate: null == categoriesToUpdate ? _self.categoriesToUpdate : categoriesToUpdate // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _WebSourceConfig implements WebSourceConfig {
   _WebSourceConfig({final  List<WebSourceInfo> installedSources = const [], @RepoConverter() final  List<RepoInfo> repoList = const [], final  List<WebSourceCategory> categories = const [_defaultCategory], this.defaultCategory = _defaultUUID, final  List<String> categoriesToUpdate = const []}): _installedSources = installedSources,_repoList = repoList,_categories = categories,_categoriesToUpdate = categoriesToUpdate;
  factory _WebSourceConfig.fromJson(Map<String, dynamic> json) => _$WebSourceConfigFromJson(json);

 final  List<WebSourceInfo> _installedSources;
@override@JsonKey() List<WebSourceInfo> get installedSources {
  if (_installedSources is EqualUnmodifiableListView) return _installedSources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_installedSources);
}

 final  List<RepoInfo> _repoList;
@override@JsonKey()@RepoConverter() List<RepoInfo> get repoList {
  if (_repoList is EqualUnmodifiableListView) return _repoList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_repoList);
}

 final  List<WebSourceCategory> _categories;
@override@JsonKey() List<WebSourceCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  String defaultCategory;
 final  List<String> _categoriesToUpdate;
@override@JsonKey() List<String> get categoriesToUpdate {
  if (_categoriesToUpdate is EqualUnmodifiableListView) return _categoriesToUpdate;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoriesToUpdate);
}


/// Create a copy of WebSourceConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebSourceConfigCopyWith<_WebSourceConfig> get copyWith => __$WebSourceConfigCopyWithImpl<_WebSourceConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebSourceConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebSourceConfig&&const DeepCollectionEquality().equals(other._installedSources, _installedSources)&&const DeepCollectionEquality().equals(other._repoList, _repoList)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.defaultCategory, defaultCategory) || other.defaultCategory == defaultCategory)&&const DeepCollectionEquality().equals(other._categoriesToUpdate, _categoriesToUpdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_installedSources),const DeepCollectionEquality().hash(_repoList),const DeepCollectionEquality().hash(_categories),defaultCategory,const DeepCollectionEquality().hash(_categoriesToUpdate));

@override
String toString() {
  return 'WebSourceConfig(installedSources: $installedSources, repoList: $repoList, categories: $categories, defaultCategory: $defaultCategory, categoriesToUpdate: $categoriesToUpdate)';
}


}

/// @nodoc
abstract mixin class _$WebSourceConfigCopyWith<$Res> implements $WebSourceConfigCopyWith<$Res> {
  factory _$WebSourceConfigCopyWith(_WebSourceConfig value, $Res Function(_WebSourceConfig) _then) = __$WebSourceConfigCopyWithImpl;
@override @useResult
$Res call({
 List<WebSourceInfo> installedSources,@RepoConverter() List<RepoInfo> repoList, List<WebSourceCategory> categories, String defaultCategory, List<String> categoriesToUpdate
});




}
/// @nodoc
class __$WebSourceConfigCopyWithImpl<$Res>
    implements _$WebSourceConfigCopyWith<$Res> {
  __$WebSourceConfigCopyWithImpl(this._self, this._then);

  final _WebSourceConfig _self;
  final $Res Function(_WebSourceConfig) _then;

/// Create a copy of WebSourceConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? installedSources = null,Object? repoList = null,Object? categories = null,Object? defaultCategory = null,Object? categoriesToUpdate = null,}) {
  return _then(_WebSourceConfig(
installedSources: null == installedSources ? _self._installedSources : installedSources // ignore: cast_nullable_to_non_nullable
as List<WebSourceInfo>,repoList: null == repoList ? _self._repoList : repoList // ignore: cast_nullable_to_non_nullable
as List<RepoInfo>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<WebSourceCategory>,defaultCategory: null == defaultCategory ? _self.defaultCategory : defaultCategory // ignore: cast_nullable_to_non_nullable
as String,categoriesToUpdate: null == categoriesToUpdate ? _self._categoriesToUpdate : categoriesToUpdate // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
