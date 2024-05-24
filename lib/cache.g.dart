// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef CacheRef = Ref<CacheManager>;

@ProviderFor(cache)
const cacheProvider = CacheProvider._();

final class CacheProvider
    extends $FunctionalProvider<CacheManager, CacheManager>
    with $Provider<CacheManager, CacheRef> {
  const CacheProvider._(
      {CacheManager Function(
        CacheRef ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          name: r'cacheProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final CacheManager Function(
    CacheRef ref,
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
      CacheRef ref,
    ) create,
  ) {
    return CacheProvider._(create: create);
  }

  @override
  CacheManager create(CacheRef ref) {
    final _$cb = _createCb ?? cache;
    return _$cb(ref);
  }
}

String _$cacheHash() => r'8034060009e61bf983bad09b38587b167ef38b16';

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
