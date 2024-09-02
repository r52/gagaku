// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef ProxyRef = Ref<ProxyHandler>;

@ProviderFor(proxy)
const proxyProvider = ProxyProvider._();

final class ProxyProvider
    extends $FunctionalProvider<ProxyHandler, ProxyHandler>
    with $Provider<ProxyHandler, ProxyRef> {
  const ProxyProvider._(
      {ProxyHandler Function(
        ProxyRef ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'proxyProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final ProxyHandler Function(
    ProxyRef ref,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$proxyHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProxyHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ProxyHandler>(value),
    );
  }

  @$internal
  @override
  $ProviderElement<ProxyHandler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(this, pointer);

  @override
  ProxyProvider $copyWithCreate(
    ProxyHandler Function(
      ProxyRef ref,
    ) create,
  ) {
    return ProxyProvider._(create: create);
  }

  @override
  ProxyHandler create(ProxyRef ref) {
    final _$cb = _createCb ?? proxy;
    return _$cb(ref);
  }
}

String _$proxyHash() => r'9c1283bf072913b04bc06342dad4b6ff01fd1e7e';

@ProviderFor(WebSourceFavorites)
const webSourceFavoritesProvider = WebSourceFavoritesProvider._();

final class WebSourceFavoritesProvider
    extends $AsyncNotifierProvider<WebSourceFavorites, List<HistoryLink>> {
  const WebSourceFavoritesProvider._(
      {super.runNotifierBuildOverride, WebSourceFavorites Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'webSourceFavoritesProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final WebSourceFavorites Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$webSourceFavoritesHash();

  @$internal
  @override
  WebSourceFavorites create() => _createCb?.call() ?? WebSourceFavorites();

  @$internal
  @override
  WebSourceFavoritesProvider $copyWithCreate(
    WebSourceFavorites Function() create,
  ) {
    return WebSourceFavoritesProvider._(create: create);
  }

  @$internal
  @override
  WebSourceFavoritesProvider $copyWithBuild(
    FutureOr<List<HistoryLink>> Function(
      Ref<AsyncValue<List<HistoryLink>>>,
      WebSourceFavorites,
    ) build,
  ) {
    return WebSourceFavoritesProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<WebSourceFavorites, List<HistoryLink>>
      $createElement($ProviderPointer pointer) =>
          $AsyncNotifierProviderElement(this, pointer);
}

String _$webSourceFavoritesHash() =>
    r'59188a5d4f269b6f6d3ce28bdd0a08c0a84b6b71';

abstract class _$WebSourceFavorites extends $AsyncNotifier<List<HistoryLink>> {
  FutureOr<List<HistoryLink>> build();
  @$internal
  @override
  FutureOr<List<HistoryLink>> runBuild() => build();
}

@ProviderFor(WebSourceHistory)
const webSourceHistoryProvider = WebSourceHistoryProvider._();

final class WebSourceHistoryProvider
    extends $AsyncNotifierProvider<WebSourceHistory, Queue<HistoryLink>> {
  const WebSourceHistoryProvider._(
      {super.runNotifierBuildOverride, WebSourceHistory Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'webSourceHistoryProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final WebSourceHistory Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$webSourceHistoryHash();

  @$internal
  @override
  WebSourceHistory create() => _createCb?.call() ?? WebSourceHistory();

  @$internal
  @override
  WebSourceHistoryProvider $copyWithCreate(
    WebSourceHistory Function() create,
  ) {
    return WebSourceHistoryProvider._(create: create);
  }

  @$internal
  @override
  WebSourceHistoryProvider $copyWithBuild(
    FutureOr<Queue<HistoryLink>> Function(
      Ref<AsyncValue<Queue<HistoryLink>>>,
      WebSourceHistory,
    ) build,
  ) {
    return WebSourceHistoryProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<WebSourceHistory, Queue<HistoryLink>>
      $createElement($ProviderPointer pointer) =>
          $AsyncNotifierProviderElement(this, pointer);
}

String _$webSourceHistoryHash() => r'5ca47131ac0b6052d4b8d1042d78010e227dcdf4';

abstract class _$WebSourceHistory extends $AsyncNotifier<Queue<HistoryLink>> {
  FutureOr<Queue<HistoryLink>> build();
  @$internal
  @override
  FutureOr<Queue<HistoryLink>> runBuild() => build();
}

@ProviderFor(WebReadMarkers)
const webReadMarkersProvider = WebReadMarkersProvider._();

final class WebReadMarkersProvider
    extends $AsyncNotifierProvider<WebReadMarkers, Map<String, Set<String>>> {
  const WebReadMarkersProvider._(
      {super.runNotifierBuildOverride, WebReadMarkers Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'webReadMarkersProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final WebReadMarkers Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$webReadMarkersHash();

  @$internal
  @override
  WebReadMarkers create() => _createCb?.call() ?? WebReadMarkers();

  @$internal
  @override
  WebReadMarkersProvider $copyWithCreate(
    WebReadMarkers Function() create,
  ) {
    return WebReadMarkersProvider._(create: create);
  }

  @$internal
  @override
  WebReadMarkersProvider $copyWithBuild(
    FutureOr<Map<String, Set<String>>> Function(
      Ref<AsyncValue<Map<String, Set<String>>>>,
      WebReadMarkers,
    ) build,
  ) {
    return WebReadMarkersProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<WebReadMarkers, Map<String, Set<String>>>
      $createElement($ProviderPointer pointer) =>
          $AsyncNotifierProviderElement(this, pointer);
}

String _$webReadMarkersHash() => r'c594534a9297ff5b9cea3d7193fc5ce4ca7a7fbf';

abstract class _$WebReadMarkers
    extends $AsyncNotifier<Map<String, Set<String>>> {
  FutureOr<Map<String, Set<String>>> build();
  @$internal
  @override
  FutureOr<Map<String, Set<String>>> runBuild() => build();
}

@ProviderFor(WebSourceManager)
const webSourceManagerProvider = WebSourceManagerProvider._();

final class WebSourceManagerProvider
    extends $AsyncNotifierProvider<WebSourceManager, Map<String, WebSource>> {
  const WebSourceManagerProvider._(
      {super.runNotifierBuildOverride, WebSourceManager Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'webSourceManagerProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final WebSourceManager Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$webSourceManagerHash();

  @$internal
  @override
  WebSourceManager create() => _createCb?.call() ?? WebSourceManager();

  @$internal
  @override
  WebSourceManagerProvider $copyWithCreate(
    WebSourceManager Function() create,
  ) {
    return WebSourceManagerProvider._(create: create);
  }

  @$internal
  @override
  WebSourceManagerProvider $copyWithBuild(
    FutureOr<Map<String, WebSource>> Function(
      Ref<AsyncValue<Map<String, WebSource>>>,
      WebSourceManager,
    ) build,
  ) {
    return WebSourceManagerProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<WebSourceManager, Map<String, WebSource>>
      $createElement($ProviderPointer pointer) =>
          $AsyncNotifierProviderElement(this, pointer);
}

String _$webSourceManagerHash() => r'faba7592e01d658de95ce5e672d58bf4f03a41eb';

abstract class _$WebSourceManager
    extends $AsyncNotifier<Map<String, WebSource>> {
  FutureOr<Map<String, WebSource>> build();
  @$internal
  @override
  FutureOr<Map<String, WebSource>> runBuild() => build();
}

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
