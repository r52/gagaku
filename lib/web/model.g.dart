// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$proxyHash() => r'9c1283bf072913b04bc06342dad4b6ff01fd1e7e';

/// See also [proxy].
@ProviderFor(proxy)
final proxyProvider = Provider<ProxyHandler>.internal(
  proxy,
  name: r'proxyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$proxyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProxyRef = ProviderRef<ProxyHandler>;
String _$webSourceHistoryHash() => r'2a6d79dd62487489190d268d93bbe5d2550908a1';

/// See also [WebSourceHistory].
@ProviderFor(WebSourceHistory)
final webSourceHistoryProvider =
    AsyncNotifierProvider<WebSourceHistory, Queue<HistoryLink>>.internal(
  WebSourceHistory.new,
  name: r'webSourceHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$webSourceHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WebSourceHistory = AsyncNotifier<Queue<HistoryLink>>;
String _$webReadMarkersHash() => r'a759ec66baab960073b26e268cfcc4f510644156';

/// See also [WebReadMarkers].
@ProviderFor(WebReadMarkers)
final webReadMarkersProvider =
    AsyncNotifierProvider<WebReadMarkers, Map<String, Set<String>>>.internal(
  WebReadMarkers.new,
  name: r'webReadMarkersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$webReadMarkersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WebReadMarkers = AsyncNotifier<Map<String, Set<String>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
