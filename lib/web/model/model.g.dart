// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(extensionReferrer)
final extensionReferrerProvider = ExtensionReferrerProvider._();

final class ExtensionReferrerProvider
    extends
        $FunctionalProvider<
          Map<String, String>,
          Map<String, String>,
          Map<String, String>
        >
    with $Provider<Map<String, String>> {
  ExtensionReferrerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'extensionReferrerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$extensionReferrerHash();

  @$internal
  @override
  $ProviderElement<Map<String, String>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, String> create(Ref ref) {
    return extensionReferrer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, String>>(value),
    );
  }
}

String _$extensionReferrerHash() => r'13ddbba7059d5caf3026b45cc998d2b1595b8f20';

@ProviderFor(sourceHeaders)
final sourceHeadersProvider = SourceHeadersFamily._();

final class SourceHeadersProvider
    extends
        $FunctionalProvider<
          Map<String, String>,
          Map<String, String>,
          Map<String, String>
        >
    with $Provider<Map<String, String>> {
  SourceHeadersProvider._({
    required SourceHeadersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'sourceHeadersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sourceHeadersHash();

  @override
  String toString() {
    return r'sourceHeadersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Map<String, String>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, String> create(Ref ref) {
    final argument = this.argument as String;
    return sourceHeaders(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, String>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SourceHeadersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sourceHeadersHash() => r'4036165872f3dd1d3eb4a2986e82eba3a4c9f6a6';

final class SourceHeadersFamily extends $Family
    with $FunctionalFamilyOverride<Map<String, String>, String> {
  SourceHeadersFamily._()
    : super(
        retry: null,
        name: r'sourceHeadersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SourceHeadersProvider call(String sourceId) =>
      SourceHeadersProvider._(argument: sourceId, from: this);

  @override
  String toString() => r'sourceHeadersProvider';
}

@ProviderFor(webSourceBroker)
final webSourceBrokerProvider = WebSourceBrokerProvider._();

final class WebSourceBrokerProvider
    extends
        $FunctionalProvider<WebSourceBroker, WebSourceBroker, WebSourceBroker>
    with $Provider<WebSourceBroker> {
  WebSourceBrokerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSourceBrokerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSourceBrokerHash();

  @$internal
  @override
  $ProviderElement<WebSourceBroker> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WebSourceBroker create(Ref ref) {
    return webSourceBroker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSourceBroker value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSourceBroker>(value),
    );
  }
}

String _$webSourceBrokerHash() => r'56c8a586cc5056c95d1633b275a9a96ac2641b3e';

@ProviderFor(webSourceDio)
final webSourceDioProvider = WebSourceDioProvider._();

final class WebSourceDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  WebSourceDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSourceDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSourceDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return webSourceDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$webSourceDioHash() => r'bd2b8559eee79fcb3d19de25997ef97e6d5c23f2';

@ProviderFor(webLinkResolver)
final webLinkResolverProvider = WebLinkResolverProvider._();

final class WebLinkResolverProvider
    extends
        $FunctionalProvider<WebLinkResolver, WebLinkResolver, WebLinkResolver>
    with $Provider<WebLinkResolver> {
  WebLinkResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webLinkResolverProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webLinkResolverHash();

  @$internal
  @override
  $ProviderElement<WebLinkResolver> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WebLinkResolver create(Ref ref) {
    return webLinkResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebLinkResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebLinkResolver>(value),
    );
  }
}

String _$webLinkResolverHash() => r'0439168440a9e61a371e5f191757c9f6921b90b1';

@ProviderFor(WebReadMarkers)
final webReadMarkersProvider = WebReadMarkersProvider._();

final class WebReadMarkersProvider
    extends $AsyncNotifierProvider<WebReadMarkers, ReadMarkersDB> {
  WebReadMarkersProvider._()
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

String _$webReadMarkersHash() => r'2a2a11ce395499e75ba71b9381d78d32c91c2c86';

abstract class _$WebReadMarkers extends $AsyncNotifier<ReadMarkersDB> {
  FutureOr<ReadMarkersDB> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ReadMarkersDB>, ReadMarkersDB>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ReadMarkersDB>, ReadMarkersDB>,
              AsyncValue<ReadMarkersDB>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(installedSources)
final installedSourcesProvider = InstalledSourcesProvider._();

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
  InstalledSourcesProvider._()
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
final extensionSourceProvider = ExtensionSourceFamily._();

final class ExtensionSourceProvider
    extends $AsyncNotifierProvider<ExtensionSource, WebSourceInfo> {
  ExtensionSourceProvider._({
    required ExtensionSourceFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
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

String _$extensionSourceHash() => r'07c161fafe0749cf74bad053174879cf0f7325a6';

final class ExtensionSourceFamily extends $Family
    with
        $ClassFamilyOverride<
          ExtensionSource,
          AsyncValue<WebSourceInfo>,
          WebSourceInfo,
          FutureOr<WebSourceInfo>,
          String
        > {
  ExtensionSourceFamily._()
    : super(
        retry: noRetry,
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
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<WebSourceInfo>, WebSourceInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WebSourceInfo>, WebSourceInfo>,
              AsyncValue<WebSourceInfo>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(getExtensionFromId)
final getExtensionFromIdProvider = GetExtensionFromIdFamily._();

final class GetExtensionFromIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<WebSourceInfo>,
          WebSourceInfo,
          FutureOr<WebSourceInfo>
        >
    with $FutureModifier<WebSourceInfo>, $FutureProvider<WebSourceInfo> {
  GetExtensionFromIdProvider._({
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
    r'830e21e505424a30da753500077aada70301ee94';

final class GetExtensionFromIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<WebSourceInfo>, String> {
  GetExtensionFromIdFamily._()
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
