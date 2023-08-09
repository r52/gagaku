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

typedef _FetchMangaFromIdRef = AutoDisposeFutureProviderRef<Manga>;

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
    this.mangaId,
  ) : super.internal(
          (ref) => _fetchMangaFromId(
            ref,
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
        );

  final String mangaId;

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

String _$fetchReadChaptersRedunHash() =>
    r'ee6e26ca0ad2a94741b4f9afe8e5e7ec62fe52ef';
typedef _FetchReadChaptersRedunRef = AutoDisposeFutureProviderRef<void>;

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
    this.manga,
  ) : super.internal(
          (ref) => _fetchReadChaptersRedun(
            ref,
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
        );

  final Manga manga;

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
