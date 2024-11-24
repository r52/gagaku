// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(cache)
const cacheProvider = CacheProvider._();

final class CacheProvider
    extends $FunctionalProvider<CacheManager, CacheManager>
    with $Provider<CacheManager> {
  const CacheProvider._(
      {CacheManager Function(
        Ref ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'cacheProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final CacheManager Function(
    Ref ref,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$cacheHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CacheManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<CacheManager>(value),
    );
  }

  @$internal
  @override
  $ProviderElement<CacheManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(this, pointer);

  @override
  CacheProvider $copyWithCreate(
    CacheManager Function(
      Ref ref,
    ) create,
  ) {
    return CacheProvider._(create: create);
  }

  @override
  CacheManager create(Ref ref) {
    final _$cb = _createCb ?? cache;
    return _$cb(ref);
  }
}

String _$cacheHash() => r'48a6174c970e2db177c74ed79966f8d5a4210d3e';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
