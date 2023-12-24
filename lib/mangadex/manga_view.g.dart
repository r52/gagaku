// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchMangaFromIdHash() => r'aa14b104bfae399f4c9480fded6d7263eec0320d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [_fetchMangaFromId].
@ProviderFor(_fetchMangaFromId)
const _fetchMangaFromIdProvider = _FetchMangaFromIdFamily();

/// See also [_fetchMangaFromId].
class _FetchMangaFromIdFamily extends Family {
  /// See also [_fetchMangaFromId].
  const _FetchMangaFromIdFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchMangaFromIdProvider';

  /// See also [_fetchMangaFromId].
  _FetchMangaFromIdProvider call(
    String mangaId,
  ) {
    return _FetchMangaFromIdProvider(
      mangaId,
    );
  }

  @visibleForOverriding
  @override
  _FetchMangaFromIdProvider getProviderOverride(
    covariant _FetchMangaFromIdProvider provider,
  ) {
    return call(
      provider.mangaId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<Manga> Function(_FetchMangaFromIdRef ref) create) {
    return _$FetchMangaFromIdFamilyOverride(this, create);
  }
}

class _$FetchMangaFromIdFamilyOverride implements FamilyOverride {
  _$FetchMangaFromIdFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Manga> Function(_FetchMangaFromIdRef ref) create;

  @override
  final _FetchMangaFromIdFamily overriddenFamily;

  @override
  _FetchMangaFromIdProvider getProviderOverride(
    covariant _FetchMangaFromIdProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchMangaFromId].
class _FetchMangaFromIdProvider extends AutoDisposeFutureProvider<Manga> {
  /// See also [_fetchMangaFromId].
  _FetchMangaFromIdProvider(
    String mangaId,
  ) : this._internal(
          (ref) => _fetchMangaFromId(
            ref as _FetchMangaFromIdRef,
            mangaId,
          ),
          from: _fetchMangaFromIdProvider,
          name: r'_fetchMangaFromIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchMangaFromIdHash,
          dependencies: _FetchMangaFromIdFamily._dependencies,
          allTransitiveDependencies:
              _FetchMangaFromIdFamily._allTransitiveDependencies,
          mangaId: mangaId,
        );

  _FetchMangaFromIdProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mangaId,
  }) : super.internal();

  final String mangaId;

  @override
  Override overrideWith(
    FutureOr<Manga> Function(_FetchMangaFromIdRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchMangaFromIdProvider._internal(
        (ref) => create(ref as _FetchMangaFromIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mangaId: mangaId,
      ),
    );
  }

  @override
  (String,) get argument {
    return (mangaId,);
  }

  @override
  AutoDisposeFutureProviderElement<Manga> createElement() {
    return _FetchMangaFromIdProviderElement(this);
  }

  _FetchMangaFromIdProvider _copyWith(
    FutureOr<Manga> Function(_FetchMangaFromIdRef ref) create,
  ) {
    return _FetchMangaFromIdProvider._internal(
      (ref) => create(ref as _FetchMangaFromIdRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      mangaId: mangaId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchMangaFromIdProvider && other.mangaId == mangaId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mangaId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchMangaFromIdRef on AutoDisposeFutureProviderRef<Manga> {
  /// The parameter `mangaId` of this provider.
  String get mangaId;
}

class _FetchMangaFromIdProviderElement
    extends AutoDisposeFutureProviderElement<Manga> with _FetchMangaFromIdRef {
  _FetchMangaFromIdProviderElement(super.provider);

  @override
  String get mangaId => (origin as _FetchMangaFromIdProvider).mangaId;
}

String _$fetchReadChaptersRedunHash() =>
    r'ee6e26ca0ad2a94741b4f9afe8e5e7ec62fe52ef';

/// See also [_fetchReadChaptersRedun].
@ProviderFor(_fetchReadChaptersRedun)
const _fetchReadChaptersRedunProvider = _FetchReadChaptersRedunFamily();

/// See also [_fetchReadChaptersRedun].
class _FetchReadChaptersRedunFamily extends Family {
  /// See also [_fetchReadChaptersRedun].
  const _FetchReadChaptersRedunFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchReadChaptersRedunProvider';

  /// See also [_fetchReadChaptersRedun].
  _FetchReadChaptersRedunProvider call(
    Manga manga,
  ) {
    return _FetchReadChaptersRedunProvider(
      manga,
    );
  }

  @visibleForOverriding
  @override
  _FetchReadChaptersRedunProvider getProviderOverride(
    covariant _FetchReadChaptersRedunProvider provider,
  ) {
    return call(
      provider.manga,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<void> Function(_FetchReadChaptersRedunRef ref) create) {
    return _$FetchReadChaptersRedunFamilyOverride(this, create);
  }
}

class _$FetchReadChaptersRedunFamilyOverride implements FamilyOverride {
  _$FetchReadChaptersRedunFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<void> Function(_FetchReadChaptersRedunRef ref) create;

  @override
  final _FetchReadChaptersRedunFamily overriddenFamily;

  @override
  _FetchReadChaptersRedunProvider getProviderOverride(
    covariant _FetchReadChaptersRedunProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchReadChaptersRedun].
class _FetchReadChaptersRedunProvider extends AutoDisposeFutureProvider<void> {
  /// See also [_fetchReadChaptersRedun].
  _FetchReadChaptersRedunProvider(
    Manga manga,
  ) : this._internal(
          (ref) => _fetchReadChaptersRedun(
            ref as _FetchReadChaptersRedunRef,
            manga,
          ),
          from: _fetchReadChaptersRedunProvider,
          name: r'_fetchReadChaptersRedunProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchReadChaptersRedunHash,
          dependencies: _FetchReadChaptersRedunFamily._dependencies,
          allTransitiveDependencies:
              _FetchReadChaptersRedunFamily._allTransitiveDependencies,
          manga: manga,
        );

  _FetchReadChaptersRedunProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.manga,
  }) : super.internal();

  final Manga manga;

  @override
  Override overrideWith(
    FutureOr<void> Function(_FetchReadChaptersRedunRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchReadChaptersRedunProvider._internal(
        (ref) => create(ref as _FetchReadChaptersRedunRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        manga: manga,
      ),
    );
  }

  @override
  (Manga,) get argument {
    return (manga,);
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _FetchReadChaptersRedunProviderElement(this);
  }

  _FetchReadChaptersRedunProvider _copyWith(
    FutureOr<void> Function(_FetchReadChaptersRedunRef ref) create,
  ) {
    return _FetchReadChaptersRedunProvider._internal(
      (ref) => create(ref as _FetchReadChaptersRedunRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      manga: manga,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchReadChaptersRedunProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchReadChaptersRedunRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `manga` of this provider.
  Manga get manga;
}

class _FetchReadChaptersRedunProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with _FetchReadChaptersRedunRef {
  _FetchReadChaptersRedunProviderElement(super.provider);

  @override
  Manga get manga => (origin as _FetchReadChaptersRedunProvider).manga;
}

String _$fetchRelatedMangaHash() => r'b72cd2374bf3c284544cd9bf67a0b46bcc25f98d';

/// See also [_fetchRelatedManga].
@ProviderFor(_fetchRelatedManga)
const _fetchRelatedMangaProvider = _FetchRelatedMangaFamily();

/// See also [_fetchRelatedManga].
class _FetchRelatedMangaFamily extends Family {
  /// See also [_fetchRelatedManga].
  const _FetchRelatedMangaFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchRelatedMangaProvider';

  /// See also [_fetchRelatedManga].
  _FetchRelatedMangaProvider call(
    Manga manga,
  ) {
    return _FetchRelatedMangaProvider(
      manga,
    );
  }

  @visibleForOverriding
  @override
  _FetchRelatedMangaProvider getProviderOverride(
    covariant _FetchRelatedMangaProvider provider,
  ) {
    return call(
      provider.manga,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<Iterable<Manga>> Function(_FetchRelatedMangaRef ref) create) {
    return _$FetchRelatedMangaFamilyOverride(this, create);
  }
}

class _$FetchRelatedMangaFamilyOverride implements FamilyOverride {
  _$FetchRelatedMangaFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Iterable<Manga>> Function(_FetchRelatedMangaRef ref) create;

  @override
  final _FetchRelatedMangaFamily overriddenFamily;

  @override
  _FetchRelatedMangaProvider getProviderOverride(
    covariant _FetchRelatedMangaProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchRelatedManga].
class _FetchRelatedMangaProvider
    extends AutoDisposeFutureProvider<Iterable<Manga>> {
  /// See also [_fetchRelatedManga].
  _FetchRelatedMangaProvider(
    Manga manga,
  ) : this._internal(
          (ref) => _fetchRelatedManga(
            ref as _FetchRelatedMangaRef,
            manga,
          ),
          from: _fetchRelatedMangaProvider,
          name: r'_fetchRelatedMangaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchRelatedMangaHash,
          dependencies: _FetchRelatedMangaFamily._dependencies,
          allTransitiveDependencies:
              _FetchRelatedMangaFamily._allTransitiveDependencies,
          manga: manga,
        );

  _FetchRelatedMangaProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.manga,
  }) : super.internal();

  final Manga manga;

  @override
  Override overrideWith(
    FutureOr<Iterable<Manga>> Function(_FetchRelatedMangaRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchRelatedMangaProvider._internal(
        (ref) => create(ref as _FetchRelatedMangaRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        manga: manga,
      ),
    );
  }

  @override
  (Manga,) get argument {
    return (manga,);
  }

  @override
  AutoDisposeFutureProviderElement<Iterable<Manga>> createElement() {
    return _FetchRelatedMangaProviderElement(this);
  }

  _FetchRelatedMangaProvider _copyWith(
    FutureOr<Iterable<Manga>> Function(_FetchRelatedMangaRef ref) create,
  ) {
    return _FetchRelatedMangaProvider._internal(
      (ref) => create(ref as _FetchRelatedMangaRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      manga: manga,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchRelatedMangaProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchRelatedMangaRef on AutoDisposeFutureProviderRef<Iterable<Manga>> {
  /// The parameter `manga` of this provider.
  Manga get manga;
}

class _FetchRelatedMangaProviderElement
    extends AutoDisposeFutureProviderElement<Iterable<Manga>>
    with _FetchRelatedMangaRef {
  _FetchRelatedMangaProviderElement(super.provider);

  @override
  Manga get manga => (origin as _FetchRelatedMangaProvider).manga;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
