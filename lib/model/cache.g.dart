// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cache)
final cacheProvider = CacheProvider._();

final class CacheProvider
    extends $FunctionalProvider<CacheManager, CacheManager, CacheManager>
    with $Provider<CacheManager> {
  CacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cacheHash();

  @$internal
  @override
  $ProviderElement<CacheManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CacheManager create(Ref ref) {
    return cache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CacheManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CacheManager>(value),
    );
  }
}

String _$cacheHash() => r'06b976943b9bae624407c64f83b982ddf25ad689';
