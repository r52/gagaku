// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebSourceConfigImpl _$$WebSourceConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSourceConfigImpl(
      sourceDirectory: json['sourceDirectory'] as String? ?? '',
      repoList: (json['repoList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WebSourceConfigImplToJson(
        _$WebSourceConfigImpl instance) =>
    <String, dynamic>{
      'sourceDirectory': instance.sourceDirectory,
      'repoList': instance.repoList,
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

String _$webConfigHash() => r'd2fe9e2dcf17052f5a15a350429e7671220ce0fe';

abstract class _$WebConfig extends $Notifier<WebSourceConfig> {
  WebSourceConfig build();
  @$internal
  @override
  WebSourceConfig runBuild() => build();
}

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
