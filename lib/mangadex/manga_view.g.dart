// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchMangaFromIdHash() => r'a0ad364f40eb3ded19c3a8012e0238c43a8f1d73';

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
class _FetchMangaFromIdFamily extends Family<AsyncValue<Manga>> {
  /// See also [_fetchMangaFromId].
  const _FetchMangaFromIdFamily();

  /// See also [_fetchMangaFromId].
  _FetchMangaFromIdProvider call(
    String mangaId,
  ) {
    return _FetchMangaFromIdProvider(
      mangaId,
    );
  }

  @override
  _FetchMangaFromIdProvider getProviderOverride(
    covariant _FetchMangaFromIdProvider provider,
  ) {
    return call(
      provider.mangaId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchMangaFromIdProvider';
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
    super._createNotifier, {
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
    FutureOr<Manga> Function(_FetchMangaFromIdRef provider) create,
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
  AutoDisposeFutureProviderElement<Manga> createElement() {
    return _FetchMangaFromIdProviderElement(this);
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
class _FetchReadChaptersRedunFamily extends Family<AsyncValue<void>> {
  /// See also [_fetchReadChaptersRedun].
  const _FetchReadChaptersRedunFamily();

  /// See also [_fetchReadChaptersRedun].
  _FetchReadChaptersRedunProvider call(
    Manga manga,
  ) {
    return _FetchReadChaptersRedunProvider(
      manga,
    );
  }

  @override
  _FetchReadChaptersRedunProvider getProviderOverride(
    covariant _FetchReadChaptersRedunProvider provider,
  ) {
    return call(
      provider.manga,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchReadChaptersRedunProvider';
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
    super._createNotifier, {
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
    FutureOr<void> Function(_FetchReadChaptersRedunRef provider) create,
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
  AutoDisposeFutureProviderElement<void> createElement() {
    return _FetchReadChaptersRedunProviderElement(this);
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
