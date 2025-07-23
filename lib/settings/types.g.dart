// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSourceCategory _$WebSourceCategoryFromJson(Map<String, dynamic> json) =>
    WebSourceCategory(json['id'] as String, json['name'] as String);

Map<String, dynamic> _$WebSourceCategoryToJson(WebSourceCategory instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_WebSourceConfig _$WebSourceConfigFromJson(Map<String, dynamic> json) =>
    _WebSourceConfig(
      installedSources:
          (json['installedSources'] as List<dynamic>?)
              ?.map((e) => WebSourceInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      repoList:
          (json['repoList'] as List<dynamic>?)
              ?.map(const RepoConverter().fromJson)
              .toList() ??
          const [],
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map(
                (e) => WebSourceCategory.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [_defaultCategory],
      defaultCategory: json['defaultCategory'] as String? ?? _defaultUUID,
      categoriesToUpdate:
          (json['categoriesToUpdate'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$WebSourceConfigToJson(
  _WebSourceConfig instance,
) => <String, dynamic>{
  'installedSources': instance.installedSources.map((e) => e.toJson()).toList(),
  'repoList': instance.repoList.map(const RepoConverter().toJson).toList(),
  'categories': instance.categories.map((e) => e.toJson()).toList(),
  'defaultCategory': instance.defaultCategory,
  'categoriesToUpdate': instance.categoriesToUpdate,
};
