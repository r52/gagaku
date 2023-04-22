// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchMangaViewChaptersHash() =>
    r'cb827b418135592e1554e594c38f1a497fafed90';

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

typedef FetchMangaViewChaptersRef
    = AutoDisposeFutureProviderRef<FetchMangaChaptersResult>;

/// See also [fetchMangaViewChapters].
@ProviderFor(fetchMangaViewChapters)
const fetchMangaViewChaptersProvider = FetchMangaViewChaptersFamily();

/// See also [fetchMangaViewChapters].
class FetchMangaViewChaptersFamily
    extends Family<AsyncValue<FetchMangaChaptersResult>> {
  /// See also [fetchMangaViewChapters].
  const FetchMangaViewChaptersFamily();

  /// See also [fetchMangaViewChapters].
  FetchMangaViewChaptersProvider call(
    Manga manga,
  ) {
    return FetchMangaViewChaptersProvider(
      manga,
    );
  }

  @override
  FetchMangaViewChaptersProvider getProviderOverride(
    covariant FetchMangaViewChaptersProvider provider,
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
  String? get name => r'fetchMangaViewChaptersProvider';
}

/// See also [fetchMangaViewChapters].
class FetchMangaViewChaptersProvider
    extends AutoDisposeFutureProvider<FetchMangaChaptersResult> {
  /// See also [fetchMangaViewChapters].
  FetchMangaViewChaptersProvider(
    this.manga,
  ) : super.internal(
          (ref) => fetchMangaViewChapters(
            ref,
            manga,
          ),
          from: fetchMangaViewChaptersProvider,
          name: r'fetchMangaViewChaptersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchMangaViewChaptersHash,
          dependencies: FetchMangaViewChaptersFamily._dependencies,
          allTransitiveDependencies:
              FetchMangaViewChaptersFamily._allTransitiveDependencies,
        );

  final Manga manga;

  @override
  bool operator ==(Object other) {
    return other is FetchMangaViewChaptersProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
