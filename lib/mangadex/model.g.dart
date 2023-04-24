// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchReadingStatusHash() =>
    r'06fbd3ffc745c0218ede8362707ac1e90e73d557';

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
String _$mangaChaptersHash() => r'19c78bf5c50b109bab7440e341da26bee3753ea5';

abstract class _$MangaChapters extends BuildlessAsyncNotifier<List<Chapter>> {
  late final Manga manga;

  FutureOr<List<Chapter>> build(
    Manga manga,
  );
}

/// See also [MangaChapters].
@ProviderFor(MangaChapters)
const mangaChaptersProvider = MangaChaptersFamily();

/// See also [MangaChapters].
class MangaChaptersFamily extends Family<AsyncValue<List<Chapter>>> {
  /// See also [MangaChapters].
  const MangaChaptersFamily();

  /// See also [MangaChapters].
  MangaChaptersProvider call(
    Manga manga,
  ) {
    return MangaChaptersProvider(
      manga,
    );
  }

  @override
  MangaChaptersProvider getProviderOverride(
    covariant MangaChaptersProvider provider,
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
  String? get name => r'mangaChaptersProvider';
}

/// See also [MangaChapters].
class MangaChaptersProvider
    extends AsyncNotifierProviderImpl<MangaChapters, List<Chapter>> {
  /// See also [MangaChapters].
  MangaChaptersProvider(
    this.manga,
  ) : super.internal(
          () => MangaChapters()..manga = manga,
          from: mangaChaptersProvider,
          name: r'mangaChaptersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mangaChaptersHash,
          dependencies: MangaChaptersFamily._dependencies,
          allTransitiveDependencies:
              MangaChaptersFamily._allTransitiveDependencies,
        );

  final Manga manga;

  @override
  bool operator ==(Object other) {
    return other is MangaChaptersProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<Chapter>> runNotifierBuild(
    covariant MangaChapters notifier,
  ) {
    return notifier.build(
      manga,
    );
  }
}

String _$readChaptersHash() => r'dfdccbd73c8ddadbec64f7afbe2aa3900a56061a';

/// See also [ReadChapters].
@ProviderFor(ReadChapters)
final readChaptersProvider =
    AsyncNotifierProvider<ReadChapters, Set<String>>.internal(
  ReadChapters.new,
  name: r'readChaptersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$readChaptersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReadChapters = AsyncNotifier<Set<String>>;
String _$userLibraryHash() => r'42214a56de6a0a58c90bdca6d34a3423e6e3922e';

abstract class _$UserLibrary extends BuildlessAsyncNotifier<Iterable<Manga>> {
  late final MangaReadingStatus status;

  FutureOr<Iterable<Manga>> build(
    MangaReadingStatus status,
  );
}

/// See also [UserLibrary].
@ProviderFor(UserLibrary)
const userLibraryProvider = UserLibraryFamily();

/// See also [UserLibrary].
class UserLibraryFamily extends Family<AsyncValue<Iterable<Manga>>> {
  /// See also [UserLibrary].
  const UserLibraryFamily();

  /// See also [UserLibrary].
  UserLibraryProvider call(
    MangaReadingStatus status,
  ) {
    return UserLibraryProvider(
      status,
    );
  }

  @override
  UserLibraryProvider getProviderOverride(
    covariant UserLibraryProvider provider,
  ) {
    return call(
      provider.status,
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
  String? get name => r'userLibraryProvider';
}

/// See also [UserLibrary].
class UserLibraryProvider
    extends AsyncNotifierProviderImpl<UserLibrary, Iterable<Manga>> {
  /// See also [UserLibrary].
  UserLibraryProvider(
    this.status,
  ) : super.internal(
          () => UserLibrary()..status = status,
          from: userLibraryProvider,
          name: r'userLibraryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userLibraryHash,
          dependencies: UserLibraryFamily._dependencies,
          allTransitiveDependencies:
              UserLibraryFamily._allTransitiveDependencies,
        );

  final MangaReadingStatus status;

  @override
  bool operator ==(Object other) {
    return other is UserLibraryProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<Iterable<Manga>> runNotifierBuild(
    covariant UserLibrary notifier,
  ) {
    return notifier.build(
      status,
    );
  }
}

String _$tagListHash() => r'0a1fc9b1354d4786d8aac74ab1a13e872b6e9e1b';

/// See also [TagList].
@ProviderFor(TagList)
final tagListProvider = AsyncNotifierProvider<TagList, Iterable<Tag>>.internal(
  TagList.new,
  name: r'tagListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tagListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TagList = AsyncNotifier<Iterable<Tag>>;
String _$mangaSearchHash() => r'a3163dd6ef59fd08598e6aa978eb87d2bae7b22f';

abstract class _$MangaSearch
    extends BuildlessAutoDisposeAsyncNotifier<List<Manga>> {
  late final MangaSearchParameters params;

  FutureOr<List<Manga>> build(
    MangaSearchParameters params,
  );
}

/// See also [MangaSearch].
@ProviderFor(MangaSearch)
const mangaSearchProvider = MangaSearchFamily();

/// See also [MangaSearch].
class MangaSearchFamily extends Family<AsyncValue<List<Manga>>> {
  /// See also [MangaSearch].
  const MangaSearchFamily();

  /// See also [MangaSearch].
  MangaSearchProvider call(
    MangaSearchParameters params,
  ) {
    return MangaSearchProvider(
      params,
    );
  }

  @override
  MangaSearchProvider getProviderOverride(
    covariant MangaSearchProvider provider,
  ) {
    return call(
      provider.params,
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
  String? get name => r'mangaSearchProvider';
}

/// See also [MangaSearch].
class MangaSearchProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MangaSearch, List<Manga>> {
  /// See also [MangaSearch].
  MangaSearchProvider(
    this.params,
  ) : super.internal(
          () => MangaSearch()..params = params,
          from: mangaSearchProvider,
          name: r'mangaSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mangaSearchHash,
          dependencies: MangaSearchFamily._dependencies,
          allTransitiveDependencies:
              MangaSearchFamily._allTransitiveDependencies,
        );

  final MangaSearchParameters params;

  @override
  bool operator ==(Object other) {
    return other is MangaSearchProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<Manga>> runNotifierBuild(
    covariant MangaSearch notifier,
  ) {
    return notifier.build(
      params,
    );
  }
}

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
