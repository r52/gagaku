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

@ProviderFor(WebSourceFavorites)
const webSourceFavoritesProvider = WebSourceFavoritesProvider._();

final class WebSourceFavoritesProvider
    extends
        $AsyncNotifierProvider<
          WebSourceFavorites,
          Map<String, List<HistoryLink>>
        > {
  const WebSourceFavoritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSourceFavoritesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSourceFavoritesHash();

  @$internal
  @override
  WebSourceFavorites create() => WebSourceFavorites();
}

String _$webSourceFavoritesHash() =>
    r'b98e46b5fb695e524ddf5313aad2e616eff36ee9';

abstract class _$WebSourceFavorites
    extends $AsyncNotifier<Map<String, List<HistoryLink>>> {
  FutureOr<Map<String, List<HistoryLink>>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, List<HistoryLink>>>,
              Map<String, List<HistoryLink>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, List<HistoryLink>>>,
                Map<String, List<HistoryLink>>
              >,
              AsyncValue<Map<String, List<HistoryLink>>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(WebSourceHistory)
const webSourceHistoryProvider = WebSourceHistoryProvider._();

final class WebSourceHistoryProvider
    extends $AsyncNotifierProvider<WebSourceHistory, Queue<HistoryLink>> {
  const WebSourceHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSourceHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSourceHistoryHash();

  @$internal
  @override
  WebSourceHistory create() => WebSourceHistory();
}

String _$webSourceHistoryHash() => r'c628fef95497386236877f4b452293d66d7ad95f';

abstract class _$WebSourceHistory extends $AsyncNotifier<Queue<HistoryLink>> {
  FutureOr<Queue<HistoryLink>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<Queue<HistoryLink>>, Queue<HistoryLink>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Queue<HistoryLink>>, Queue<HistoryLink>>,
              AsyncValue<Queue<HistoryLink>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(WebReadMarkers)
const webReadMarkersProvider = WebReadMarkersProvider._();

final class WebReadMarkersProvider
    extends $AsyncNotifierProvider<WebReadMarkers, Map<String, Set<String>>> {
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

String _$webReadMarkersHash() => r'85072d9873e221da4ec97977e70d020e81752f36';

abstract class _$WebReadMarkers
    extends $AsyncNotifier<Map<String, Set<String>>> {
  FutureOr<Map<String, Set<String>>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, Set<String>>>,
              Map<String, Set<String>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, Set<String>>>,
                Map<String, Set<String>>
              >,
              AsyncValue<Map<String, Set<String>>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

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

String _$extensionSourceHash() => r'9ec622666011419942ac62f42fe3c6a62eec335a';

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
    extends $AsyncNotifierProvider<ExtensionInfoList, List<WebSourceInfo>> {
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

String _$extensionInfoListHash() => r'0665e8257c6673036644f3e598bf43e023b1bd12';

abstract class _$ExtensionInfoList extends $AsyncNotifier<List<WebSourceInfo>> {
  FutureOr<List<WebSourceInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<WebSourceInfo>>, List<WebSourceInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<WebSourceInfo>>, List<WebSourceInfo>>,
              AsyncValue<List<WebSourceInfo>>,
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
    r'b5bf3c8a25a75348d4400be94e8864bff3bafdea';

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
