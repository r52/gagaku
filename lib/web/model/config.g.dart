// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtensionConfig _$ExtensionConfigFromJson(Map<String, dynamic> json) =>
    _ExtensionConfig(
      categoriesToUpdate:
          (json['categoriesToUpdate'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      preserveHistory: json['preserveHistory'] as bool? ?? true,
    );

Map<String, dynamic> _$ExtensionConfigToJson(_ExtensionConfig instance) =>
    <String, dynamic>{
      'categoriesToUpdate': instance.categoriesToUpdate,
      'preserveHistory': instance.preserveHistory,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WebConfig)
final webConfigProvider = WebConfigProvider._();

final class WebConfigProvider
    extends $NotifierProvider<WebConfig, ExtensionConfig> {
  WebConfigProvider._()
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
  Override overrideWithValue(ExtensionConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExtensionConfig>(value),
    );
  }
}

String _$webConfigHash() => r'82047ba484958c37d164589d9a338be3a6fa04da';

abstract class _$WebConfig extends $Notifier<ExtensionConfig> {
  ExtensionConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ExtensionConfig, ExtensionConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExtensionConfig, ExtensionConfig>,
              ExtensionConfig,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ExtensionState)
final extensionStateProvider = ExtensionStateProvider._();

final class ExtensionStateProvider
    extends $NotifierProvider<ExtensionState, ExtensionStateDB> {
  ExtensionStateProvider._()
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
  Override overrideWithValue(ExtensionStateDB value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExtensionStateDB>(value),
    );
  }
}

String _$extensionStateHash() => r'4fe53039cb63ec78590436b9277cc84ce0b5ccd6';

abstract class _$ExtensionState extends $Notifier<ExtensionStateDB> {
  ExtensionStateDB build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ExtensionStateDB, ExtensionStateDB>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExtensionStateDB, ExtensionStateDB>,
              ExtensionStateDB,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ExtensionSecureState)
final extensionSecureStateProvider = ExtensionSecureStateProvider._();

final class ExtensionSecureStateProvider
    extends $NotifierProvider<ExtensionSecureState, ExtensionStateDB> {
  ExtensionSecureStateProvider._()
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
  Override overrideWithValue(ExtensionStateDB value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExtensionStateDB>(value),
    );
  }
}

String _$extensionSecureStateHash() =>
    r'f7b9b878296c98a8425487214a2baee737cd85a7';

abstract class _$ExtensionSecureState extends $Notifier<ExtensionStateDB> {
  ExtensionStateDB build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ExtensionStateDB, ExtensionStateDB>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExtensionStateDB, ExtensionStateDB>,
              ExtensionStateDB,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
