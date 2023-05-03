// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchMangaViewChaptersHash() =>
    r'59b62ff4b88c114039ad626173041591badfa631';

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

typedef _FetchMangaViewChaptersRef
    = AutoDisposeFutureProviderRef<_FetchMangaChaptersResult>;

/// See also [_fetchMangaViewChapters].
@ProviderFor(_fetchMangaViewChapters)
const _fetchMangaViewChaptersProvider = _FetchMangaViewChaptersFamily();

/// See also [_fetchMangaViewChapters].
class _FetchMangaViewChaptersFamily
    extends Family<AsyncValue<_FetchMangaChaptersResult>> {
  /// See also [_fetchMangaViewChapters].
  const _FetchMangaViewChaptersFamily();

  /// See also [_fetchMangaViewChapters].
  _FetchMangaViewChaptersProvider call(
    Manga manga,
  ) {
    return _FetchMangaViewChaptersProvider(
      manga,
    );
  }

  @override
  _FetchMangaViewChaptersProvider getProviderOverride(
    covariant _FetchMangaViewChaptersProvider provider,
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
  String? get name => r'_fetchMangaViewChaptersProvider';
}

/// See also [_fetchMangaViewChapters].
class _FetchMangaViewChaptersProvider
    extends AutoDisposeFutureProvider<_FetchMangaChaptersResult> {
  /// See also [_fetchMangaViewChapters].
  _FetchMangaViewChaptersProvider(
    this.manga,
  ) : super.internal(
          (ref) => _fetchMangaViewChapters(
            ref,
            manga,
          ),
          from: _fetchMangaViewChaptersProvider,
          name: r'_fetchMangaViewChaptersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchMangaViewChaptersHash,
          dependencies: _FetchMangaViewChaptersFamily._dependencies,
          allTransitiveDependencies:
              _FetchMangaViewChaptersFamily._allTransitiveDependencies,
        );

  final Manga manga;

  @override
  bool operator ==(Object other) {
    return other is _FetchMangaViewChaptersProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
