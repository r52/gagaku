// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSourceCategory _$WebSourceCategoryFromJson(Map<String, dynamic> json) =>
    WebSourceCategory(
      json['id'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$WebSourceCategoryToJson(WebSourceCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$WebSourceConfigImpl _$$WebSourceConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSourceConfigImpl(
      sourceDirectory: json['sourceDirectory'] as String? ?? '',
      repoList: (json['repoList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map(
                  (e) => WebSourceCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [_defaultCategory],
      defaultCategory: json['defaultCategory'] as String? ?? _defaultUUID,
    );

Map<String, dynamic> _$$WebSourceConfigImplToJson(
        _$WebSourceConfigImpl instance) =>
    <String, dynamic>{
      'sourceDirectory': instance.sourceDirectory,
      'repoList': instance.repoList,
      'categories': instance.categories,
      'defaultCategory': instance.defaultCategory,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(WebConfig)
const webConfigProvider = WebConfigProvider._();

final class WebConfigProvider
    extends $NotifierProvider<WebConfig, WebSourceConfig> {
  const WebConfigProvider._(
      {super.runNotifierBuildOverride, WebConfig Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'webConfigProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final WebConfig Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$webConfigHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSourceConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<WebSourceConfig>(value),
    );
  }

  @$internal
  @override
  WebConfig create() => _createCb?.call() ?? WebConfig();

  @$internal
  @override
  WebConfigProvider $copyWithCreate(
    WebConfig Function() create,
  ) {
    return WebConfigProvider._(create: create);
  }

  @$internal
  @override
  WebConfigProvider $copyWithBuild(
    WebSourceConfig Function(
      Ref<WebSourceConfig>,
      WebConfig,
    ) build,
  ) {
    return WebConfigProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<WebConfig, WebSourceConfig> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(this, pointer);
}

String _$webConfigHash() => r'581d5a27382777d75f47e53f7f5ae3542b91d0ac';

abstract class _$WebConfig extends $Notifier<WebSourceConfig> {
  WebSourceConfig build();
  @$internal
  @override
  WebSourceConfig runBuild() => build();
}

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
