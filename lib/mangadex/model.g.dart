// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchMangaChaptersHash() =>
    r'1231df78ba99b7652e908926790ff8c5da302ce9';

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

typedef FetchMangaChaptersRef = AutoDisposeFutureProviderRef<Iterable<Chapter>>;

/// See also [fetchMangaChapters].
@ProviderFor(fetchMangaChapters)
const fetchMangaChaptersProvider = FetchMangaChaptersFamily();

/// See also [fetchMangaChapters].
class FetchMangaChaptersFamily extends Family<AsyncValue<Iterable<Chapter>>> {
  /// See also [fetchMangaChapters].
  const FetchMangaChaptersFamily();

  /// See also [fetchMangaChapters].
  FetchMangaChaptersProvider call(
    Manga manga,
    int offset,
  ) {
    return FetchMangaChaptersProvider(
      manga,
      offset,
    );
  }

  @override
  FetchMangaChaptersProvider getProviderOverride(
    covariant FetchMangaChaptersProvider provider,
  ) {
    return call(
      provider.manga,
      provider.offset,
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
  String? get name => r'fetchMangaChaptersProvider';
}

/// See also [fetchMangaChapters].
class FetchMangaChaptersProvider
    extends AutoDisposeFutureProvider<Iterable<Chapter>> {
  /// See also [fetchMangaChapters].
  FetchMangaChaptersProvider(
    this.manga,
    this.offset,
  ) : super.internal(
          (ref) => fetchMangaChapters(
            ref,
            manga,
            offset,
          ),
          from: fetchMangaChaptersProvider,
          name: r'fetchMangaChaptersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchMangaChaptersHash,
          dependencies: FetchMangaChaptersFamily._dependencies,
          allTransitiveDependencies:
              FetchMangaChaptersFamily._allTransitiveDependencies,
        );

  final Manga manga;
  final int offset;

  @override
  bool operator ==(Object other) {
    return other is FetchMangaChaptersProvider &&
        other.manga == manga &&
        other.offset == offset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$fetchReadingStatusHash() =>
    r'06fbd3ffc745c0218ede8362707ac1e90e73d557';
typedef FetchReadingStatusRef
    = AutoDisposeFutureProviderRef<MangaReadingStatus?>;

/// See also [fetchReadingStatus].
@ProviderFor(fetchReadingStatus)
const fetchReadingStatusProvider = FetchReadingStatusFamily();

/// See also [fetchReadingStatus].
class FetchReadingStatusFamily extends Family<AsyncValue<MangaReadingStatus?>> {
  /// See also [fetchReadingStatus].
  const FetchReadingStatusFamily();

  /// See also [fetchReadingStatus].
  FetchReadingStatusProvider call(
    Manga manga,
  ) {
    return FetchReadingStatusProvider(
      manga,
    );
  }

  @override
  FetchReadingStatusProvider getProviderOverride(
    covariant FetchReadingStatusProvider provider,
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
  String? get name => r'fetchReadingStatusProvider';
}

/// See also [fetchReadingStatus].
class FetchReadingStatusProvider
    extends AutoDisposeFutureProvider<MangaReadingStatus?> {
  /// See also [fetchReadingStatus].
  FetchReadingStatusProvider(
    this.manga,
  ) : super.internal(
          (ref) => fetchReadingStatus(
            ref,
            manga,
          ),
          from: fetchReadingStatusProvider,
          name: r'fetchReadingStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchReadingStatusHash,
          dependencies: FetchReadingStatusFamily._dependencies,
          allTransitiveDependencies:
              FetchReadingStatusFamily._allTransitiveDependencies,
        );

  final Manga manga;

  @override
  bool operator ==(Object other) {
    return other is FetchReadingStatusProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$fetchFollowingMangaHash() =>
    r'6177e9e4654b826d1c0e440403da773ee57e0f3c';
typedef FetchFollowingMangaRef = AutoDisposeFutureProviderRef<bool>;

/// See also [fetchFollowingManga].
@ProviderFor(fetchFollowingManga)
const fetchFollowingMangaProvider = FetchFollowingMangaFamily();

/// See also [fetchFollowingManga].
class FetchFollowingMangaFamily extends Family<AsyncValue<bool>> {
  /// See also [fetchFollowingManga].
  const FetchFollowingMangaFamily();

  /// See also [fetchFollowingManga].
  FetchFollowingMangaProvider call(
    Manga manga,
  ) {
    return FetchFollowingMangaProvider(
      manga,
    );
  }

  @override
  FetchFollowingMangaProvider getProviderOverride(
    covariant FetchFollowingMangaProvider provider,
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
  String? get name => r'fetchFollowingMangaProvider';
}

/// See also [fetchFollowingManga].
class FetchFollowingMangaProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [fetchFollowingManga].
  FetchFollowingMangaProvider(
    this.manga,
  ) : super.internal(
          (ref) => fetchFollowingManga(
            ref,
            manga,
          ),
          from: fetchFollowingMangaProvider,
          name: r'fetchFollowingMangaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchFollowingMangaHash,
          dependencies: FetchFollowingMangaFamily._dependencies,
          allTransitiveDependencies:
              FetchFollowingMangaFamily._allTransitiveDependencies,
        );

  final Manga manga;

  @override
  bool operator ==(Object other) {
    return other is FetchFollowingMangaProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$fetchReadChaptersHash() => r'dfdbef9bff8401e931a30a707199574c4d35c1e0';
typedef FetchReadChaptersRef = AutoDisposeFutureProviderRef<Set<String>>;

/// See also [fetchReadChapters].
@ProviderFor(fetchReadChapters)
const fetchReadChaptersProvider = FetchReadChaptersFamily();

/// See also [fetchReadChapters].
class FetchReadChaptersFamily extends Family<AsyncValue<Set<String>>> {
  /// See also [fetchReadChapters].
  const FetchReadChaptersFamily();

  /// See also [fetchReadChapters].
  FetchReadChaptersProvider call(
    Iterable<Manga> mangas,
  ) {
    return FetchReadChaptersProvider(
      mangas,
    );
  }

  @override
  FetchReadChaptersProvider getProviderOverride(
    covariant FetchReadChaptersProvider provider,
  ) {
    return call(
      provider.mangas,
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
  String? get name => r'fetchReadChaptersProvider';
}

/// See also [fetchReadChapters].
class FetchReadChaptersProvider extends AutoDisposeFutureProvider<Set<String>> {
  /// See also [fetchReadChapters].
  FetchReadChaptersProvider(
    this.mangas,
  ) : super.internal(
          (ref) => fetchReadChapters(
            ref,
            mangas,
          ),
          from: fetchReadChaptersProvider,
          name: r'fetchReadChaptersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchReadChaptersHash,
          dependencies: FetchReadChaptersFamily._dependencies,
          allTransitiveDependencies:
              FetchReadChaptersFamily._allTransitiveDependencies,
        );

  final Iterable<Manga> mangas;

  @override
  bool operator ==(Object other) {
    return other is FetchReadChaptersProvider && other.mangas == mangas;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mangas.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$latestChaptersFeedHash() =>
    r'0390a3bbc44ca109dbcf72bd524a7c98e77de281';

/// See also [LatestChaptersFeed].
@ProviderFor(LatestChaptersFeed)
final latestChaptersFeedProvider =
    AsyncNotifierProvider<LatestChaptersFeed, List<Chapter>>.internal(
  LatestChaptersFeed.new,
  name: r'latestChaptersFeedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestChaptersFeedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LatestChaptersFeed = AsyncNotifier<List<Chapter>>;
String _$authControlHash() => r'f8be09eda62cb7aef4301595371cdb20bc07059e';

/// See also [AuthControl].
@ProviderFor(AuthControl)
final authControlProvider =
    AutoDisposeAsyncNotifierProvider<AuthControl, bool>.internal(
  AuthControl.new,
  name: r'authControlProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authControlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthControl = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
