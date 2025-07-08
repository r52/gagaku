// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

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

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(WebConfig)
const webConfigProvider = WebConfigProvider._();

final class WebConfigProvider
    extends $NotifierProvider<WebConfig, WebSourceConfig> {
  const WebConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webConfigHash();

  @$internal
  @override
  WebConfig create() => WebConfig();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSourceConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSourceConfig>(value),
    );
  }
}

String _$webConfigHash() => r'4bccb93a95d460642c1c8e845848bf3091caac30';

abstract class _$WebConfig extends $Notifier<WebSourceConfig> {
  WebSourceConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WebSourceConfig, WebSourceConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WebSourceConfig, WebSourceConfig>,
              WebSourceConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ExtensionState)
const extensionStateProvider = ExtensionStateProvider._();

final class ExtensionStateProvider
    extends $NotifierProvider<ExtensionState, ExtensionStateMap> {
  const ExtensionStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'extensionStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$extensionStateHash();

  @$internal
  @override
  ExtensionState create() => ExtensionState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExtensionStateMap value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExtensionStateMap>(value),
    );
  }
}

String _$extensionStateHash() => r'8041816f19647b41f164799cc6063757a6997893';

abstract class _$ExtensionState extends $Notifier<ExtensionStateMap> {
  ExtensionStateMap build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ExtensionStateMap, ExtensionStateMap>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExtensionStateMap, ExtensionStateMap>,
              ExtensionStateMap,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ExtensionSecureState)
const extensionSecureStateProvider = ExtensionSecureStateProvider._();

final class ExtensionSecureStateProvider
    extends $NotifierProvider<ExtensionSecureState, ExtensionStateMap> {
  const ExtensionSecureStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'extensionSecureStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$extensionSecureStateHash();

  @$internal
  @override
  ExtensionSecureState create() => ExtensionSecureState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExtensionStateMap value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExtensionStateMap>(value),
    );
  }
}

String _$extensionSecureStateHash() =>
    r'25399becce16ba4d5389b121f40921d5f46772ec';

abstract class _$ExtensionSecureState extends $Notifier<ExtensionStateMap> {
  ExtensionStateMap build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ExtensionStateMap, ExtensionStateMap>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExtensionStateMap, ExtensionStateMap>,
              ExtensionStateMap,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
