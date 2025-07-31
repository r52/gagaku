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
    );

Map<String, dynamic> _$ExtensionConfigToJson(_ExtensionConfig instance) =>
    <String, dynamic>{'categoriesToUpdate': instance.categoriesToUpdate};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(WebConfig)
const webConfigProvider = WebConfigProvider._();

final class WebConfigProvider
    extends $NotifierProvider<WebConfig, ExtensionConfig> {
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
  Override overrideWithValue(ExtensionConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExtensionConfig>(value),
    );
  }
}

String _$webConfigHash() => r'3946a046f37b982630c47c257cf1cb6ad37d53f4';

abstract class _$WebConfig extends $Notifier<ExtensionConfig> {
  ExtensionConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ExtensionConfig, ExtensionConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExtensionConfig, ExtensionConfig>,
              ExtensionConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ExtensionState)
const extensionStateProvider = ExtensionStateProvider._();

final class ExtensionStateProvider
    extends $NotifierProvider<ExtensionState, ExtensionStateDB> {
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
  Override overrideWithValue(ExtensionStateDB value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExtensionStateDB>(value),
    );
  }
}

String _$extensionStateHash() => r'793a03042a21a1c60a0703659f419051266ffd10';

abstract class _$ExtensionState extends $Notifier<ExtensionStateDB> {
  ExtensionStateDB build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ExtensionStateDB, ExtensionStateDB>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExtensionStateDB, ExtensionStateDB>,
              ExtensionStateDB,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ExtensionSecureState)
const extensionSecureStateProvider = ExtensionSecureStateProvider._();

final class ExtensionSecureStateProvider
    extends $NotifierProvider<ExtensionSecureState, ExtensionStateDB> {
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
  Override overrideWithValue(ExtensionStateDB value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExtensionStateDB>(value),
    );
  }
}

String _$extensionSecureStateHash() =>
    r'fbce2ebe73d57cbaa9e7d959d0d66a78c36be5c0';

abstract class _$ExtensionSecureState extends $Notifier<ExtensionStateDB> {
  ExtensionStateDB build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ExtensionStateDB, ExtensionStateDB>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExtensionStateDB, ExtensionStateDB>,
              ExtensionStateDB,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
