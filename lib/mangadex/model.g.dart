// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mangadexHash() => r'a292b576f657f3f4f75a624bdf14e965c33f39fe';

/// See also [mangadex].
@ProviderFor(mangadex)
final mangadexProvider = Provider<MangaDexModel>.internal(
  mangadex,
  name: r'mangadexProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mangadexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MangadexRef = ProviderRef<MangaDexModel>;
String _$latestChaptersFeedHash() =>
    r'60d043a5de065e52957daa4d989266e69faef500';

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
String _$latestGlobalFeedHash() => r'9bfa9061fd0965dac54ac74eb8327367238d5f2a';

/// See also [LatestGlobalFeed].
@ProviderFor(LatestGlobalFeed)
final latestGlobalFeedProvider =
    AsyncNotifierProvider<LatestGlobalFeed, List<Chapter>>.internal(
  LatestGlobalFeed.new,
  name: r'latestGlobalFeedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestGlobalFeedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LatestGlobalFeed = AsyncNotifier<List<Chapter>>;
String _$groupFeedHash() => r'd75febca41e84cb2349b467a01e6e75226838f06';

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

abstract class _$GroupFeed extends BuildlessAsyncNotifier<List<Chapter>> {
  late final Group group;

  FutureOr<List<Chapter>> build(
    Group group,
  );
}

/// See also [GroupFeed].
@ProviderFor(GroupFeed)
const groupFeedProvider = GroupFeedFamily();

/// See also [GroupFeed].
class GroupFeedFamily extends Family<AsyncValue<List<Chapter>>> {
  /// See also [GroupFeed].
  const GroupFeedFamily();

  /// See also [GroupFeed].
  GroupFeedProvider call(
    Group group,
  ) {
    return GroupFeedProvider(
      group,
    );
  }

  @override
  GroupFeedProvider getProviderOverride(
    covariant GroupFeedProvider provider,
  ) {
    return call(
      provider.group,
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
  String? get name => r'groupFeedProvider';
}

/// See also [GroupFeed].
class GroupFeedProvider
    extends AsyncNotifierProviderImpl<GroupFeed, List<Chapter>> {
  /// See also [GroupFeed].
  GroupFeedProvider(
    this.group,
  ) : super.internal(
          () => GroupFeed()..group = group,
          from: groupFeedProvider,
          name: r'groupFeedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$groupFeedHash,
          dependencies: GroupFeedFamily._dependencies,
          allTransitiveDependencies: GroupFeedFamily._allTransitiveDependencies,
        );

  final Group group;

  @override
  bool operator ==(Object other) {
    return other is GroupFeedProvider && other.group == group;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, group.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<Chapter>> runNotifierBuild(
    covariant GroupFeed notifier,
  ) {
    return notifier.build(
      group,
    );
  }
}

String _$groupTitlesHash() => r'bb3138a274c1973f59fa2aa7c0a8b3c80b99a3ad';

abstract class _$GroupTitles extends BuildlessAsyncNotifier<List<Manga>> {
  late final Group group;

  FutureOr<List<Manga>> build(
    Group group,
  );
}

/// See also [GroupTitles].
@ProviderFor(GroupTitles)
const groupTitlesProvider = GroupTitlesFamily();

/// See also [GroupTitles].
class GroupTitlesFamily extends Family<AsyncValue<List<Manga>>> {
  /// See also [GroupTitles].
  const GroupTitlesFamily();

  /// See also [GroupTitles].
  GroupTitlesProvider call(
    Group group,
  ) {
    return GroupTitlesProvider(
      group,
    );
  }

  @override
  GroupTitlesProvider getProviderOverride(
    covariant GroupTitlesProvider provider,
  ) {
    return call(
      provider.group,
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
  String? get name => r'groupTitlesProvider';
}

/// See also [GroupTitles].
class GroupTitlesProvider
    extends AsyncNotifierProviderImpl<GroupTitles, List<Manga>> {
  /// See also [GroupTitles].
  GroupTitlesProvider(
    this.group,
  ) : super.internal(
          () => GroupTitles()..group = group,
          from: groupTitlesProvider,
          name: r'groupTitlesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$groupTitlesHash,
          dependencies: GroupTitlesFamily._dependencies,
          allTransitiveDependencies:
              GroupTitlesFamily._allTransitiveDependencies,
        );

  final Group group;

  @override
  bool operator ==(Object other) {
    return other is GroupTitlesProvider && other.group == group;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, group.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<Manga>> runNotifierBuild(
    covariant GroupTitles notifier,
  ) {
    return notifier.build(
      group,
    );
  }
}

String _$creatorTitlesHash() => r'873b599622ede2fbd363a8fe527bc111397538ae';

abstract class _$CreatorTitles extends BuildlessAsyncNotifier<List<Manga>> {
  late final CreatorType creator;

  FutureOr<List<Manga>> build(
    CreatorType creator,
  );
}

/// See also [CreatorTitles].
@ProviderFor(CreatorTitles)
const creatorTitlesProvider = CreatorTitlesFamily();

/// See also [CreatorTitles].
class CreatorTitlesFamily extends Family<AsyncValue<List<Manga>>> {
  /// See also [CreatorTitles].
  const CreatorTitlesFamily();

  /// See also [CreatorTitles].
  CreatorTitlesProvider call(
    CreatorType creator,
  ) {
    return CreatorTitlesProvider(
      creator,
    );
  }

  @override
  CreatorTitlesProvider getProviderOverride(
    covariant CreatorTitlesProvider provider,
  ) {
    return call(
      provider.creator,
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
  String? get name => r'creatorTitlesProvider';
}

/// See also [CreatorTitles].
class CreatorTitlesProvider
    extends AsyncNotifierProviderImpl<CreatorTitles, List<Manga>> {
  /// See also [CreatorTitles].
  CreatorTitlesProvider(
    this.creator,
  ) : super.internal(
          () => CreatorTitles()..creator = creator,
          from: creatorTitlesProvider,
          name: r'creatorTitlesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$creatorTitlesHash,
          dependencies: CreatorTitlesFamily._dependencies,
          allTransitiveDependencies:
              CreatorTitlesFamily._allTransitiveDependencies,
        );

  final CreatorType creator;

  @override
  bool operator ==(Object other) {
    return other is CreatorTitlesProvider && other.creator == creator;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, creator.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<Manga>> runNotifierBuild(
    covariant CreatorTitles notifier,
  ) {
    return notifier.build(
      creator,
    );
  }
}

String _$mangaChaptersHash() => r'6f031d7b72ab53a434981bc6e0131e341c3e20eb';

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

String _$mangaCoversHash() => r'5a688c411dc7100278f6719eb42382e91457d78c';

abstract class _$MangaCovers extends BuildlessAsyncNotifier<List<Cover>> {
  late final Manga manga;

  FutureOr<List<Cover>> build(
    Manga manga,
  );
}

/// See also [MangaCovers].
@ProviderFor(MangaCovers)
const mangaCoversProvider = MangaCoversFamily();

/// See also [MangaCovers].
class MangaCoversFamily extends Family<AsyncValue<List<Cover>>> {
  /// See also [MangaCovers].
  const MangaCoversFamily();

  /// See also [MangaCovers].
  MangaCoversProvider call(
    Manga manga,
  ) {
    return MangaCoversProvider(
      manga,
    );
  }

  @override
  MangaCoversProvider getProviderOverride(
    covariant MangaCoversProvider provider,
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
  String? get name => r'mangaCoversProvider';
}

/// See also [MangaCovers].
class MangaCoversProvider
    extends AsyncNotifierProviderImpl<MangaCovers, List<Cover>> {
  /// See also [MangaCovers].
  MangaCoversProvider(
    this.manga,
  ) : super.internal(
          () => MangaCovers()..manga = manga,
          from: mangaCoversProvider,
          name: r'mangaCoversProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mangaCoversHash,
          dependencies: MangaCoversFamily._dependencies,
          allTransitiveDependencies:
              MangaCoversFamily._allTransitiveDependencies,
        );

  final Manga manga;

  @override
  bool operator ==(Object other) {
    return other is MangaCoversProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<Cover>> runNotifierBuild(
    covariant MangaCovers notifier,
  ) {
    return notifier.build(
      manga,
    );
  }
}

String _$readChaptersHash() => r'429f19ab4f255aee8b5e414fd754ac8621091dc2';

/// See also [ReadChapters].
@ProviderFor(ReadChapters)
final readChaptersProvider =
    AsyncNotifierProvider<ReadChapters, Map<String, ReadChapterSet>>.internal(
  ReadChapters.new,
  name: r'readChaptersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$readChaptersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReadChapters = AsyncNotifier<Map<String, ReadChapterSet>>;
String _$userLibraryHash() => r'db728effebe55f58d3dd147c3727b6fdf3db8f09';

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
String _$mangaSearchHash() => r'e5e3db3c56b9a668163093c117e6d49a1fb81269';

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

String _$statisticsHash() => r'847be5129b04dafb2f25ea8cb8fc3a846342e358';

/// See also [Statistics].
@ProviderFor(Statistics)
final statisticsProvider =
    AsyncNotifierProvider<Statistics, Map<String, MangaStatistics>>.internal(
  Statistics.new,
  name: r'statisticsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$statisticsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Statistics = AsyncNotifier<Map<String, MangaStatistics>>;
String _$ratingsHash() => r'd5689480a48de244cd7961f14e225e23811e08b9';

/// See also [Ratings].
@ProviderFor(Ratings)
final ratingsProvider =
    AsyncNotifierProvider<Ratings, Map<String, SelfRating>>.internal(
  Ratings.new,
  name: r'ratingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ratingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Ratings = AsyncNotifier<Map<String, SelfRating>>;
String _$readingStatusHash() => r'910a1148a373a364b8246af6f85d7a2f525d0bd9';

abstract class _$ReadingStatus
    extends BuildlessAsyncNotifier<MangaReadingStatus?> {
  late final Manga manga;

  FutureOr<MangaReadingStatus?> build(
    Manga manga,
  );
}

/// See also [ReadingStatus].
@ProviderFor(ReadingStatus)
const readingStatusProvider = ReadingStatusFamily();

/// See also [ReadingStatus].
class ReadingStatusFamily extends Family<AsyncValue<MangaReadingStatus?>> {
  /// See also [ReadingStatus].
  const ReadingStatusFamily();

  /// See also [ReadingStatus].
  ReadingStatusProvider call(
    Manga manga,
  ) {
    return ReadingStatusProvider(
      manga,
    );
  }

  @override
  ReadingStatusProvider getProviderOverride(
    covariant ReadingStatusProvider provider,
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
  String? get name => r'readingStatusProvider';
}

/// See also [ReadingStatus].
class ReadingStatusProvider
    extends AsyncNotifierProviderImpl<ReadingStatus, MangaReadingStatus?> {
  /// See also [ReadingStatus].
  ReadingStatusProvider(
    this.manga,
  ) : super.internal(
          () => ReadingStatus()..manga = manga,
          from: readingStatusProvider,
          name: r'readingStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$readingStatusHash,
          dependencies: ReadingStatusFamily._dependencies,
          allTransitiveDependencies:
              ReadingStatusFamily._allTransitiveDependencies,
        );

  final Manga manga;

  @override
  bool operator ==(Object other) {
    return other is ReadingStatusProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<MangaReadingStatus?> runNotifierBuild(
    covariant ReadingStatus notifier,
  ) {
    return notifier.build(
      manga,
    );
  }
}

String _$followingStatusHash() => r'fb96192a8468fb7dacb102b3b253c4235cd4c1cc';

abstract class _$FollowingStatus extends BuildlessAsyncNotifier<bool> {
  late final Manga manga;

  FutureOr<bool> build(
    Manga manga,
  );
}

/// See also [FollowingStatus].
@ProviderFor(FollowingStatus)
const followingStatusProvider = FollowingStatusFamily();

/// See also [FollowingStatus].
class FollowingStatusFamily extends Family<AsyncValue<bool>> {
  /// See also [FollowingStatus].
  const FollowingStatusFamily();

  /// See also [FollowingStatus].
  FollowingStatusProvider call(
    Manga manga,
  ) {
    return FollowingStatusProvider(
      manga,
    );
  }

  @override
  FollowingStatusProvider getProviderOverride(
    covariant FollowingStatusProvider provider,
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
  String? get name => r'followingStatusProvider';
}

/// See also [FollowingStatus].
class FollowingStatusProvider
    extends AsyncNotifierProviderImpl<FollowingStatus, bool> {
  /// See also [FollowingStatus].
  FollowingStatusProvider(
    this.manga,
  ) : super.internal(
          () => FollowingStatus()..manga = manga,
          from: followingStatusProvider,
          name: r'followingStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$followingStatusHash,
          dependencies: FollowingStatusFamily._dependencies,
          allTransitiveDependencies:
              FollowingStatusFamily._allTransitiveDependencies,
        );

  final Manga manga;

  @override
  bool operator ==(Object other) {
    return other is FollowingStatusProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<bool> runNotifierBuild(
    covariant FollowingStatus notifier,
  ) {
    return notifier.build(
      manga,
    );
  }
}

String _$mangaDexHistoryHash() => r'364392a2ac6c30f242510afe9ea65e021c131e43';

/// See also [MangaDexHistory].
@ProviderFor(MangaDexHistory)
final mangaDexHistoryProvider =
    AsyncNotifierProvider<MangaDexHistory, Queue<Chapter>>.internal(
  MangaDexHistory.new,
  name: r'mangaDexHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mangaDexHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MangaDexHistory = AsyncNotifier<Queue<Chapter>>;
String _$authControlHash() => r'f25650165fcc9db88651cdc07f10b82d4d315cce';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
