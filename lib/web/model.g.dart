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
String _$webSourceHistoryHash() => r'6ee2202cbc821ae1463075d7e85ffb8f03e3091a';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
