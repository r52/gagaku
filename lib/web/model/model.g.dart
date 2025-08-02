// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(proxy)
const proxyProvider = ProxyProvider._();

final class ProxyProvider
    extends $FunctionalProvider<ProxyHandler, ProxyHandler, ProxyHandler>
    with $Provider<ProxyHandler> {
  const ProxyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proxyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proxyHash();

  @$internal
  @override
  $ProviderElement<ProxyHandler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProxyHandler create(Ref ref) {
    return proxy(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProxyHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProxyHandler>(value),
    );
  }
}

String _$proxyHash() => r'8a4e90bb9775641c76f0be18ce9750786e3b2a4b';

@ProviderFor(WebReadMarkers)
const webReadMarkersProvider = WebReadMarkersProvider._();

final class WebReadMarkersProvider
    extends $AsyncNotifierProvider<WebReadMarkers, ReadMarkersDB> {
  const WebReadMarkersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webReadMarkersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webReadMarkersHash();

  @$internal
  @override
  WebReadMarkers create() => WebReadMarkers();
}

String _$webReadMarkersHash() => r'94c78980a45d993d6e93e40c31184f93e5635b7d';

abstract class _$WebReadMarkers extends $AsyncNotifier<ReadMarkersDB> {
  FutureOr<ReadMarkersDB> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ReadMarkersDB>, ReadMarkersDB>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ReadMarkersDB>, ReadMarkersDB>,
              AsyncValue<ReadMarkersDB>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(installedSources)
const installedSourcesProvider = InstalledSourcesProvider._();

final class InstalledSourcesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WebSourceInfo>>,
          List<WebSourceInfo>,
          Stream<List<WebSourceInfo>>
        >
    with
        $FutureModifier<List<WebSourceInfo>>,
        $StreamProvider<List<WebSourceInfo>> {
  const InstalledSourcesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'installedSourcesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$installedSourcesHash();

  @$internal
  @override
  $StreamProviderElement<List<WebSourceInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<WebSourceInfo>> create(Ref ref) {
    return installedSources(ref);
  }
}

String _$installedSourcesHash() => r'ec6937fd410c5666607ee8943bb59a91ffb42b23';

@ProviderFor(ExtensionSource)
const extensionSourceProvider = ExtensionSourceFamily._();

final class ExtensionSourceProvider
    extends $AsyncNotifierProvider<ExtensionSource, WebSourceInfo> {
  const ExtensionSourceProvider._({
    required ExtensionSourceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'extensionSourceProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$extensionSourceHash();

  @override
  String toString() {
    return r'extensionSourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ExtensionSource create() => ExtensionSource();

  @override
  bool operator ==(Object other) {
    return other is ExtensionSourceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$extensionSourceHash() => r'0bdecf04f757b34b9e353bcd8ff74c7427ca7bb8';

final class ExtensionSourceFamily extends $Family
    with
        $ClassFamilyOverride<
          ExtensionSource,
          AsyncValue<WebSourceInfo>,
          WebSourceInfo,
          FutureOr<WebSourceInfo>,
          String
        > {
  const ExtensionSourceFamily._()
    : super(
        retry: null,
        name: r'extensionSourceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ExtensionSourceProvider call(String sourceId) =>
      ExtensionSourceProvider._(argument: sourceId, from: this);

  @override
  String toString() => r'extensionSourceProvider';
}

abstract class _$ExtensionSource extends $AsyncNotifier<WebSourceInfo> {
  late final _$args = ref.$arg as String;
  String get sourceId => _$args;

  FutureOr<WebSourceInfo> build(String sourceId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<WebSourceInfo>, WebSourceInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WebSourceInfo>, WebSourceInfo>,
              AsyncValue<WebSourceInfo>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ExtensionInfoList)
const extensionInfoListProvider = ExtensionInfoListProvider._();

final class ExtensionInfoListProvider
    extends
        $AsyncNotifierProvider<ExtensionInfoList, Map<String, WebSourceInfo>> {
  const ExtensionInfoListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'extensionInfoListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$extensionInfoListHash();

  @$internal
  @override
  ExtensionInfoList create() => ExtensionInfoList();
}

String _$extensionInfoListHash() => r'5450a457cad1e9211abd092e3a12fdea12901a9f';

abstract class _$ExtensionInfoList
    extends $AsyncNotifier<Map<String, WebSourceInfo>> {
  FutureOr<Map<String, WebSourceInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, WebSourceInfo>>,
              Map<String, WebSourceInfo>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, WebSourceInfo>>,
                Map<String, WebSourceInfo>
              >,
              AsyncValue<Map<String, WebSourceInfo>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(getExtensionFromId)
const getExtensionFromIdProvider = GetExtensionFromIdFamily._();

final class GetExtensionFromIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<WebSourceInfo>,
          WebSourceInfo,
          FutureOr<WebSourceInfo>
        >
    with $FutureModifier<WebSourceInfo>, $FutureProvider<WebSourceInfo> {
  const GetExtensionFromIdProvider._({
    required GetExtensionFromIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'getExtensionFromIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getExtensionFromIdHash();

  @override
  String toString() {
    return r'getExtensionFromIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WebSourceInfo> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WebSourceInfo> create(Ref ref) {
    final argument = this.argument as String;
    return getExtensionFromId(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetExtensionFromIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getExtensionFromIdHash() =>
    r'29cbd9751aed6812bbe6bdafc4ecb1a632f17c6b';

final class GetExtensionFromIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<WebSourceInfo>, String> {
  const GetExtensionFromIdFamily._()
    : super(
        retry: noRetry,
        name: r'getExtensionFromIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetExtensionFromIdProvider call(String sourceId) =>
      GetExtensionFromIdProvider._(argument: sourceId, from: this);

  @override
  String toString() => r'getExtensionFromIdProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
