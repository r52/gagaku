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
String _$getMangaListByPageHash() =>
    r'a0e31bd5226e46f7d9c3b9083875cf0aeecd6bcb';

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

/// See also [getMangaListByPage].
@ProviderFor(getMangaListByPage)
const getMangaListByPageProvider = GetMangaListByPageFamily();

/// See also [getMangaListByPage].
class GetMangaListByPageFamily extends Family {
  /// See also [getMangaListByPage].
  const GetMangaListByPageFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getMangaListByPageProvider';

  /// See also [getMangaListByPage].
  GetMangaListByPageProvider call(
    Iterable<String> list,
    int page,
  ) {
    return GetMangaListByPageProvider(
      list,
      page,
    );
  }

  @visibleForOverriding
  @override
  GetMangaListByPageProvider getProviderOverride(
    covariant GetMangaListByPageProvider provider,
  ) {
    return call(
      provider.list,
      provider.page,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<Iterable<Manga>> Function(GetMangaListByPageRef ref) create) {
    return _$GetMangaListByPageFamilyOverride(this, create);
  }
}

class _$GetMangaListByPageFamilyOverride implements FamilyOverride {
  _$GetMangaListByPageFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Iterable<Manga>> Function(GetMangaListByPageRef ref) create;

  @override
  final GetMangaListByPageFamily overriddenFamily;

  @override
  GetMangaListByPageProvider getProviderOverride(
    covariant GetMangaListByPageProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [getMangaListByPage].
class GetMangaListByPageProvider
    extends AutoDisposeFutureProvider<Iterable<Manga>> {
  /// See also [getMangaListByPage].
  GetMangaListByPageProvider(
    Iterable<String> list,
    int page,
  ) : this._internal(
          (ref) => getMangaListByPage(
            ref as GetMangaListByPageRef,
            list,
            page,
          ),
          from: getMangaListByPageProvider,
          name: r'getMangaListByPageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMangaListByPageHash,
          dependencies: GetMangaListByPageFamily._dependencies,
          allTransitiveDependencies:
              GetMangaListByPageFamily._allTransitiveDependencies,
          list: list,
          page: page,
        );

  GetMangaListByPageProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.list,
    required this.page,
  }) : super.internal();

  final Iterable<String> list;
  final int page;

  @override
  Override overrideWith(
    FutureOr<Iterable<Manga>> Function(GetMangaListByPageRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMangaListByPageProvider._internal(
        (ref) => create(ref as GetMangaListByPageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        list: list,
        page: page,
      ),
    );
  }

  @override
  (
    Iterable<String>,
    int,
  ) get argument {
    return (
      list,
      page,
    );
  }

  @override
  AutoDisposeFutureProviderElement<Iterable<Manga>> createElement() {
    return _GetMangaListByPageProviderElement(this);
  }

  GetMangaListByPageProvider _copyWith(
    FutureOr<Iterable<Manga>> Function(GetMangaListByPageRef ref) create,
  ) {
    return GetMangaListByPageProvider._internal(
      (ref) => create(ref as GetMangaListByPageRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      list: list,
      page: page,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GetMangaListByPageProvider &&
        other.list == list &&
        other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, list.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMangaListByPageRef on AutoDisposeFutureProviderRef<Iterable<Manga>> {
  /// The parameter `list` of this provider.
  Iterable<String> get list;

  /// The parameter `page` of this provider.
  int get page;
}

class _GetMangaListByPageProviderElement
    extends AutoDisposeFutureProviderElement<Iterable<Manga>>
    with GetMangaListByPageRef {
  _GetMangaListByPageProviderElement(super.provider);

  @override
  Iterable<String> get list => (origin as GetMangaListByPageProvider).list;
  @override
  int get page => (origin as GetMangaListByPageProvider).page;
}

String _$latestChaptersFeedHash() =>
    r'0074fd45b0038212acec33db7984c23151bffd23';

/// See also [LatestChaptersFeed].
@ProviderFor(LatestChaptersFeed)
final latestChaptersFeedProvider = AutoDisposeAsyncNotifierProvider<
    LatestChaptersFeed, List<Chapter>>.internal(
  LatestChaptersFeed.new,
  name: r'latestChaptersFeedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestChaptersFeedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LatestChaptersFeed = AutoDisposeAsyncNotifier<List<Chapter>>;
String _$latestGlobalFeedHash() => r'022ff8d3ddd62b4d18c76da6224bead1f257912d';

/// See also [LatestGlobalFeed].
@ProviderFor(LatestGlobalFeed)
final latestGlobalFeedProvider =
    AutoDisposeAsyncNotifierProvider<LatestGlobalFeed, List<Chapter>>.internal(
  LatestGlobalFeed.new,
  name: r'latestGlobalFeedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestGlobalFeedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LatestGlobalFeed = AutoDisposeAsyncNotifier<List<Chapter>>;
String _$groupFeedHash() => r'b1b14a927127c4e165f55f26ed83046eb9cf8dd1';

abstract class _$GroupFeed
    extends BuildlessAutoDisposeAsyncNotifier<List<Chapter>> {
  late final Group group;

  FutureOr<List<Chapter>> build(
    Group group,
  );
}

/// See also [GroupFeed].
@ProviderFor(GroupFeed)
const groupFeedProvider = GroupFeedFamily();

/// See also [GroupFeed].
class GroupFeedFamily extends Family {
  /// See also [GroupFeed].
  const GroupFeedFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groupFeedProvider';

  /// See also [GroupFeed].
  GroupFeedProvider call(
    Group group,
  ) {
    return GroupFeedProvider(
      group,
    );
  }

  @visibleForOverriding
  @override
  GroupFeedProvider getProviderOverride(
    covariant GroupFeedProvider provider,
  ) {
    return call(
      provider.group,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(GroupFeed Function() create) {
    return _$GroupFeedFamilyOverride(this, create);
  }
}

class _$GroupFeedFamilyOverride implements FamilyOverride {
  _$GroupFeedFamilyOverride(this.overriddenFamily, this.create);

  final GroupFeed Function() create;

  @override
  final GroupFeedFamily overriddenFamily;

  @override
  GroupFeedProvider getProviderOverride(
    covariant GroupFeedProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [GroupFeed].
class GroupFeedProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GroupFeed, List<Chapter>> {
  /// See also [GroupFeed].
  GroupFeedProvider(
    Group group,
  ) : this._internal(
          () => GroupFeed()..group = group,
          from: groupFeedProvider,
          name: r'groupFeedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$groupFeedHash,
          dependencies: GroupFeedFamily._dependencies,
          allTransitiveDependencies: GroupFeedFamily._allTransitiveDependencies,
          group: group,
        );

  GroupFeedProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.group,
  }) : super.internal();

  final Group group;

  @override
  FutureOr<List<Chapter>> runNotifierBuild(
    covariant GroupFeed notifier,
  ) {
    return notifier.build(
      group,
    );
  }

  @override
  Override overrideWith(GroupFeed Function() create) {
    return ProviderOverride(
      origin: this,
      override: GroupFeedProvider._internal(
        () => create()..group = group,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        group: group,
      ),
    );
  }

  @override
  (Group,) get argument {
    return (group,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GroupFeed, List<Chapter>>
      createElement() {
    return _GroupFeedProviderElement(this);
  }

  GroupFeedProvider _copyWith(
    GroupFeed Function() create,
  ) {
    return GroupFeedProvider._internal(
      () => create()..group = group,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      group: group,
    );
  }

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
}

mixin GroupFeedRef on AutoDisposeAsyncNotifierProviderRef<List<Chapter>> {
  /// The parameter `group` of this provider.
  Group get group;
}

class _GroupFeedProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GroupFeed, List<Chapter>>
    with GroupFeedRef {
  _GroupFeedProviderElement(super.provider);

  @override
  Group get group => (origin as GroupFeedProvider).group;
}

String _$groupTitlesHash() => r'01622d91abc2d261539280a9b01e4ef097b63df4';

abstract class _$GroupTitles
    extends BuildlessAutoDisposeAsyncNotifier<List<Manga>> {
  late final Group group;

  FutureOr<List<Manga>> build(
    Group group,
  );
}

/// See also [GroupTitles].
@ProviderFor(GroupTitles)
const groupTitlesProvider = GroupTitlesFamily();

/// See also [GroupTitles].
class GroupTitlesFamily extends Family {
  /// See also [GroupTitles].
  const GroupTitlesFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groupTitlesProvider';

  /// See also [GroupTitles].
  GroupTitlesProvider call(
    Group group,
  ) {
    return GroupTitlesProvider(
      group,
    );
  }

  @visibleForOverriding
  @override
  GroupTitlesProvider getProviderOverride(
    covariant GroupTitlesProvider provider,
  ) {
    return call(
      provider.group,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(GroupTitles Function() create) {
    return _$GroupTitlesFamilyOverride(this, create);
  }
}

class _$GroupTitlesFamilyOverride implements FamilyOverride {
  _$GroupTitlesFamilyOverride(this.overriddenFamily, this.create);

  final GroupTitles Function() create;

  @override
  final GroupTitlesFamily overriddenFamily;

  @override
  GroupTitlesProvider getProviderOverride(
    covariant GroupTitlesProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [GroupTitles].
class GroupTitlesProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GroupTitles, List<Manga>> {
  /// See also [GroupTitles].
  GroupTitlesProvider(
    Group group,
  ) : this._internal(
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
          group: group,
        );

  GroupTitlesProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.group,
  }) : super.internal();

  final Group group;

  @override
  FutureOr<List<Manga>> runNotifierBuild(
    covariant GroupTitles notifier,
  ) {
    return notifier.build(
      group,
    );
  }

  @override
  Override overrideWith(GroupTitles Function() create) {
    return ProviderOverride(
      origin: this,
      override: GroupTitlesProvider._internal(
        () => create()..group = group,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        group: group,
      ),
    );
  }

  @override
  (Group,) get argument {
    return (group,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GroupTitles, List<Manga>>
      createElement() {
    return _GroupTitlesProviderElement(this);
  }

  GroupTitlesProvider _copyWith(
    GroupTitles Function() create,
  ) {
    return GroupTitlesProvider._internal(
      () => create()..group = group,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      group: group,
    );
  }

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
}

mixin GroupTitlesRef on AutoDisposeAsyncNotifierProviderRef<List<Manga>> {
  /// The parameter `group` of this provider.
  Group get group;
}

class _GroupTitlesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GroupTitles, List<Manga>>
    with GroupTitlesRef {
  _GroupTitlesProviderElement(super.provider);

  @override
  Group get group => (origin as GroupTitlesProvider).group;
}

String _$creatorTitlesHash() => r'fe1dd23482de894d2a74e6172ddd1973a95e36c7';

abstract class _$CreatorTitles
    extends BuildlessAutoDisposeAsyncNotifier<List<Manga>> {
  late final CreatorType creator;

  FutureOr<List<Manga>> build(
    CreatorType creator,
  );
}

/// See also [CreatorTitles].
@ProviderFor(CreatorTitles)
const creatorTitlesProvider = CreatorTitlesFamily();

/// See also [CreatorTitles].
class CreatorTitlesFamily extends Family {
  /// See also [CreatorTitles].
  const CreatorTitlesFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'creatorTitlesProvider';

  /// See also [CreatorTitles].
  CreatorTitlesProvider call(
    CreatorType creator,
  ) {
    return CreatorTitlesProvider(
      creator,
    );
  }

  @visibleForOverriding
  @override
  CreatorTitlesProvider getProviderOverride(
    covariant CreatorTitlesProvider provider,
  ) {
    return call(
      provider.creator,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(CreatorTitles Function() create) {
    return _$CreatorTitlesFamilyOverride(this, create);
  }
}

class _$CreatorTitlesFamilyOverride implements FamilyOverride {
  _$CreatorTitlesFamilyOverride(this.overriddenFamily, this.create);

  final CreatorTitles Function() create;

  @override
  final CreatorTitlesFamily overriddenFamily;

  @override
  CreatorTitlesProvider getProviderOverride(
    covariant CreatorTitlesProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [CreatorTitles].
class CreatorTitlesProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CreatorTitles, List<Manga>> {
  /// See also [CreatorTitles].
  CreatorTitlesProvider(
    CreatorType creator,
  ) : this._internal(
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
          creator: creator,
        );

  CreatorTitlesProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.creator,
  }) : super.internal();

  final CreatorType creator;

  @override
  FutureOr<List<Manga>> runNotifierBuild(
    covariant CreatorTitles notifier,
  ) {
    return notifier.build(
      creator,
    );
  }

  @override
  Override overrideWith(CreatorTitles Function() create) {
    return ProviderOverride(
      origin: this,
      override: CreatorTitlesProvider._internal(
        () => create()..creator = creator,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        creator: creator,
      ),
    );
  }

  @override
  (CreatorType,) get argument {
    return (creator,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CreatorTitles, List<Manga>>
      createElement() {
    return _CreatorTitlesProviderElement(this);
  }

  CreatorTitlesProvider _copyWith(
    CreatorTitles Function() create,
  ) {
    return CreatorTitlesProvider._internal(
      () => create()..creator = creator,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      creator: creator,
    );
  }

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
}

mixin CreatorTitlesRef on AutoDisposeAsyncNotifierProviderRef<List<Manga>> {
  /// The parameter `creator` of this provider.
  CreatorType get creator;
}

class _CreatorTitlesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CreatorTitles, List<Manga>>
    with CreatorTitlesRef {
  _CreatorTitlesProviderElement(super.provider);

  @override
  CreatorType get creator => (origin as CreatorTitlesProvider).creator;
}

String _$mangaChaptersHash() => r'21cba142e506e729e048cbf8428dd6329349144a';

abstract class _$MangaChapters
    extends BuildlessAutoDisposeAsyncNotifier<List<Chapter>> {
  late final Manga manga;

  FutureOr<List<Chapter>> build(
    Manga manga,
  );
}

/// See also [MangaChapters].
@ProviderFor(MangaChapters)
const mangaChaptersProvider = MangaChaptersFamily();

/// See also [MangaChapters].
class MangaChaptersFamily extends Family {
  /// See also [MangaChapters].
  const MangaChaptersFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'mangaChaptersProvider';

  /// See also [MangaChapters].
  MangaChaptersProvider call(
    Manga manga,
  ) {
    return MangaChaptersProvider(
      manga,
    );
  }

  @visibleForOverriding
  @override
  MangaChaptersProvider getProviderOverride(
    covariant MangaChaptersProvider provider,
  ) {
    return call(
      provider.manga,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(MangaChapters Function() create) {
    return _$MangaChaptersFamilyOverride(this, create);
  }
}

class _$MangaChaptersFamilyOverride implements FamilyOverride {
  _$MangaChaptersFamilyOverride(this.overriddenFamily, this.create);

  final MangaChapters Function() create;

  @override
  final MangaChaptersFamily overriddenFamily;

  @override
  MangaChaptersProvider getProviderOverride(
    covariant MangaChaptersProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [MangaChapters].
class MangaChaptersProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MangaChapters, List<Chapter>> {
  /// See also [MangaChapters].
  MangaChaptersProvider(
    Manga manga,
  ) : this._internal(
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
          manga: manga,
        );

  MangaChaptersProvider._internal(
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
  FutureOr<List<Chapter>> runNotifierBuild(
    covariant MangaChapters notifier,
  ) {
    return notifier.build(
      manga,
    );
  }

  @override
  Override overrideWith(MangaChapters Function() create) {
    return ProviderOverride(
      origin: this,
      override: MangaChaptersProvider._internal(
        () => create()..manga = manga,
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
  AutoDisposeAsyncNotifierProviderElement<MangaChapters, List<Chapter>>
      createElement() {
    return _MangaChaptersProviderElement(this);
  }

  MangaChaptersProvider _copyWith(
    MangaChapters Function() create,
  ) {
    return MangaChaptersProvider._internal(
      () => create()..manga = manga,
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
    return other is MangaChaptersProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MangaChaptersRef on AutoDisposeAsyncNotifierProviderRef<List<Chapter>> {
  /// The parameter `manga` of this provider.
  Manga get manga;
}

class _MangaChaptersProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MangaChapters,
        List<Chapter>> with MangaChaptersRef {
  _MangaChaptersProviderElement(super.provider);

  @override
  Manga get manga => (origin as MangaChaptersProvider).manga;
}

String _$mangaCoversHash() => r'da067c46fb69802cba3e3d49e23d5e00fa16a690';

abstract class _$MangaCovers
    extends BuildlessAutoDisposeAsyncNotifier<List<CoverArt>> {
  late final Manga manga;

  FutureOr<List<CoverArt>> build(
    Manga manga,
  );
}

/// See also [MangaCovers].
@ProviderFor(MangaCovers)
const mangaCoversProvider = MangaCoversFamily();

/// See also [MangaCovers].
class MangaCoversFamily extends Family {
  /// See also [MangaCovers].
  const MangaCoversFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'mangaCoversProvider';

  /// See also [MangaCovers].
  MangaCoversProvider call(
    Manga manga,
  ) {
    return MangaCoversProvider(
      manga,
    );
  }

  @visibleForOverriding
  @override
  MangaCoversProvider getProviderOverride(
    covariant MangaCoversProvider provider,
  ) {
    return call(
      provider.manga,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(MangaCovers Function() create) {
    return _$MangaCoversFamilyOverride(this, create);
  }
}

class _$MangaCoversFamilyOverride implements FamilyOverride {
  _$MangaCoversFamilyOverride(this.overriddenFamily, this.create);

  final MangaCovers Function() create;

  @override
  final MangaCoversFamily overriddenFamily;

  @override
  MangaCoversProvider getProviderOverride(
    covariant MangaCoversProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [MangaCovers].
class MangaCoversProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MangaCovers, List<CoverArt>> {
  /// See also [MangaCovers].
  MangaCoversProvider(
    Manga manga,
  ) : this._internal(
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
          manga: manga,
        );

  MangaCoversProvider._internal(
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
  FutureOr<List<CoverArt>> runNotifierBuild(
    covariant MangaCovers notifier,
  ) {
    return notifier.build(
      manga,
    );
  }

  @override
  Override overrideWith(MangaCovers Function() create) {
    return ProviderOverride(
      origin: this,
      override: MangaCoversProvider._internal(
        () => create()..manga = manga,
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
  AutoDisposeAsyncNotifierProviderElement<MangaCovers, List<CoverArt>>
      createElement() {
    return _MangaCoversProviderElement(this);
  }

  MangaCoversProvider _copyWith(
    MangaCovers Function() create,
  ) {
    return MangaCoversProvider._internal(
      () => create()..manga = manga,
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
    return other is MangaCoversProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MangaCoversRef on AutoDisposeAsyncNotifierProviderRef<List<CoverArt>> {
  /// The parameter `manga` of this provider.
  Manga get manga;
}

class _MangaCoversProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MangaCovers, List<CoverArt>>
    with MangaCoversRef {
  _MangaCoversProviderElement(super.provider);

  @override
  Manga get manga => (origin as MangaCoversProvider).manga;
}

String _$readChaptersHash() => r'2466dc973def4eb07fc519e275161f8134e1cd96';

/// See also [ReadChapters].
@ProviderFor(ReadChapters)
final readChaptersProvider =
    AsyncNotifierProvider<ReadChapters, ReadChaptersMap>.internal(
  ReadChapters.new,
  name: r'readChaptersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$readChaptersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReadChapters = AsyncNotifier<ReadChaptersMap>;
String _$userLibraryHash() => r'58d3a7add927e3c970b317ca85b19a8090556ef2';

/// See also [UserLibrary].
@ProviderFor(UserLibrary)
final userLibraryProvider = AutoDisposeAsyncNotifierProvider<UserLibrary,
    Map<String, MangaReadingStatus>>.internal(
  UserLibrary.new,
  name: r'userLibraryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userLibraryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserLibrary
    = AutoDisposeAsyncNotifier<Map<String, MangaReadingStatus>>;
String _$userListsHash() => r'2ec431339aea3d37d2eac41114c7f471554a3fd1';

/// See also [UserLists].
@ProviderFor(UserLists)
final userListsProvider =
    AutoDisposeAsyncNotifierProvider<UserLists, List<CRef>>.internal(
  UserLists.new,
  name: r'userListsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userListsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserLists = AutoDisposeAsyncNotifier<List<CRef>>;
String _$customListFeedHash() => r'b6cda3660905de48a833c01e93ff952d86c87ca8';

abstract class _$CustomListFeed
    extends BuildlessAutoDisposeAsyncNotifier<List<Chapter>> {
  late final CustomList list;

  FutureOr<List<Chapter>> build(
    CustomList list,
  );
}

/// See also [CustomListFeed].
@ProviderFor(CustomListFeed)
const customListFeedProvider = CustomListFeedFamily();

/// See also [CustomListFeed].
class CustomListFeedFamily extends Family {
  /// See also [CustomListFeed].
  const CustomListFeedFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'customListFeedProvider';

  /// See also [CustomListFeed].
  CustomListFeedProvider call(
    CustomList list,
  ) {
    return CustomListFeedProvider(
      list,
    );
  }

  @visibleForOverriding
  @override
  CustomListFeedProvider getProviderOverride(
    covariant CustomListFeedProvider provider,
  ) {
    return call(
      provider.list,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(CustomListFeed Function() create) {
    return _$CustomListFeedFamilyOverride(this, create);
  }
}

class _$CustomListFeedFamilyOverride implements FamilyOverride {
  _$CustomListFeedFamilyOverride(this.overriddenFamily, this.create);

  final CustomListFeed Function() create;

  @override
  final CustomListFeedFamily overriddenFamily;

  @override
  CustomListFeedProvider getProviderOverride(
    covariant CustomListFeedProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [CustomListFeed].
class CustomListFeedProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CustomListFeed, List<Chapter>> {
  /// See also [CustomListFeed].
  CustomListFeedProvider(
    CustomList list,
  ) : this._internal(
          () => CustomListFeed()..list = list,
          from: customListFeedProvider,
          name: r'customListFeedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customListFeedHash,
          dependencies: CustomListFeedFamily._dependencies,
          allTransitiveDependencies:
              CustomListFeedFamily._allTransitiveDependencies,
          list: list,
        );

  CustomListFeedProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.list,
  }) : super.internal();

  final CustomList list;

  @override
  FutureOr<List<Chapter>> runNotifierBuild(
    covariant CustomListFeed notifier,
  ) {
    return notifier.build(
      list,
    );
  }

  @override
  Override overrideWith(CustomListFeed Function() create) {
    return ProviderOverride(
      origin: this,
      override: CustomListFeedProvider._internal(
        () => create()..list = list,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        list: list,
      ),
    );
  }

  @override
  (CustomList,) get argument {
    return (list,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CustomListFeed, List<Chapter>>
      createElement() {
    return _CustomListFeedProviderElement(this);
  }

  CustomListFeedProvider _copyWith(
    CustomListFeed Function() create,
  ) {
    return CustomListFeedProvider._internal(
      () => create()..list = list,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      list: list,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CustomListFeedProvider && other.list == list;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, list.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CustomListFeedRef on AutoDisposeAsyncNotifierProviderRef<List<Chapter>> {
  /// The parameter `list` of this provider.
  CustomList get list;
}

class _CustomListFeedProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CustomListFeed,
        List<Chapter>> with CustomListFeedRef {
  _CustomListFeedProviderElement(super.provider);

  @override
  CustomList get list => (origin as CustomListFeedProvider).list;
}

String _$listByIdHash() => r'1d2960e4ad6e1f5d8a329d1b6aa99b00fb75a726';

abstract class _$ListById extends BuildlessAutoDisposeAsyncNotifier<CRef?> {
  late final String listId;

  FutureOr<CRef?> build(
    String listId,
  );
}

/// See also [ListById].
@ProviderFor(ListById)
const listByIdProvider = ListByIdFamily();

/// See also [ListById].
class ListByIdFamily extends Family {
  /// See also [ListById].
  const ListByIdFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'listByIdProvider';

  /// See also [ListById].
  ListByIdProvider call(
    String listId,
  ) {
    return ListByIdProvider(
      listId,
    );
  }

  @visibleForOverriding
  @override
  ListByIdProvider getProviderOverride(
    covariant ListByIdProvider provider,
  ) {
    return call(
      provider.listId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(ListById Function() create) {
    return _$ListByIdFamilyOverride(this, create);
  }
}

class _$ListByIdFamilyOverride implements FamilyOverride {
  _$ListByIdFamilyOverride(this.overriddenFamily, this.create);

  final ListById Function() create;

  @override
  final ListByIdFamily overriddenFamily;

  @override
  ListByIdProvider getProviderOverride(
    covariant ListByIdProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [ListById].
class ListByIdProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ListById, CRef?> {
  /// See also [ListById].
  ListByIdProvider(
    String listId,
  ) : this._internal(
          () => ListById()..listId = listId,
          from: listByIdProvider,
          name: r'listByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listByIdHash,
          dependencies: ListByIdFamily._dependencies,
          allTransitiveDependencies: ListByIdFamily._allTransitiveDependencies,
          listId: listId,
        );

  ListByIdProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listId,
  }) : super.internal();

  final String listId;

  @override
  FutureOr<CRef?> runNotifierBuild(
    covariant ListById notifier,
  ) {
    return notifier.build(
      listId,
    );
  }

  @override
  Override overrideWith(ListById Function() create) {
    return ProviderOverride(
      origin: this,
      override: ListByIdProvider._internal(
        () => create()..listId = listId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listId: listId,
      ),
    );
  }

  @override
  (String,) get argument {
    return (listId,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ListById, CRef?> createElement() {
    return _ListByIdProviderElement(this);
  }

  ListByIdProvider _copyWith(
    ListById Function() create,
  ) {
    return ListByIdProvider._internal(
      () => create()..listId = listId,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      listId: listId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ListByIdProvider && other.listId == listId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListByIdRef on AutoDisposeAsyncNotifierProviderRef<CRef?> {
  /// The parameter `listId` of this provider.
  String get listId;
}

class _ListByIdProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ListById, CRef?>
    with ListByIdRef {
  _ListByIdProviderElement(super.provider);

  @override
  String get listId => (origin as ListByIdProvider).listId;
}

String _$tagListHash() => r'5d3bda30cfa4e84118d92e60be6dfa7b23364c85';

/// See also [TagList].
@ProviderFor(TagList)
final tagListProvider =
    AutoDisposeAsyncNotifierProvider<TagList, Iterable<Tag>>.internal(
  TagList.new,
  name: r'tagListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tagListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TagList = AutoDisposeAsyncNotifier<Iterable<Tag>>;
String _$mangaSearchHash() => r'159ceccb8f506d719f9cac380bf9e9c6fccfc8f4';

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
class MangaSearchFamily extends Family {
  /// See also [MangaSearch].
  const MangaSearchFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'mangaSearchProvider';

  /// See also [MangaSearch].
  MangaSearchProvider call(
    MangaSearchParameters params,
  ) {
    return MangaSearchProvider(
      params,
    );
  }

  @visibleForOverriding
  @override
  MangaSearchProvider getProviderOverride(
    covariant MangaSearchProvider provider,
  ) {
    return call(
      provider.params,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(MangaSearch Function() create) {
    return _$MangaSearchFamilyOverride(this, create);
  }
}

class _$MangaSearchFamilyOverride implements FamilyOverride {
  _$MangaSearchFamilyOverride(this.overriddenFamily, this.create);

  final MangaSearch Function() create;

  @override
  final MangaSearchFamily overriddenFamily;

  @override
  MangaSearchProvider getProviderOverride(
    covariant MangaSearchProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [MangaSearch].
class MangaSearchProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MangaSearch, List<Manga>> {
  /// See also [MangaSearch].
  MangaSearchProvider(
    MangaSearchParameters params,
  ) : this._internal(
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
          params: params,
        );

  MangaSearchProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final MangaSearchParameters params;

  @override
  FutureOr<List<Manga>> runNotifierBuild(
    covariant MangaSearch notifier,
  ) {
    return notifier.build(
      params,
    );
  }

  @override
  Override overrideWith(MangaSearch Function() create) {
    return ProviderOverride(
      origin: this,
      override: MangaSearchProvider._internal(
        () => create()..params = params,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  (MangaSearchParameters,) get argument {
    return (params,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MangaSearch, List<Manga>>
      createElement() {
    return _MangaSearchProviderElement(this);
  }

  MangaSearchProvider _copyWith(
    MangaSearch Function() create,
  ) {
    return MangaSearchProvider._internal(
      () => create()..params = params,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      params: params,
    );
  }

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
}

mixin MangaSearchRef on AutoDisposeAsyncNotifierProviderRef<List<Manga>> {
  /// The parameter `params` of this provider.
  MangaSearchParameters get params;
}

class _MangaSearchProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MangaSearch, List<Manga>>
    with MangaSearchRef {
  _MangaSearchProviderElement(super.provider);

  @override
  MangaSearchParameters get params => (origin as MangaSearchProvider).params;
}

String _$statisticsHash() => r'0eadddfe8d6c466b93a6aa044cd156e02348f664';

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
String _$ratingsHash() => r'd1a9f106a0aa6f83917a96fb0bd0abf4102de40b';

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
String _$readingStatusHash() => r'd2a8a5435a9d4e8818ebf814652f65efed49bf3d';

abstract class _$ReadingStatus
    extends BuildlessAutoDisposeAsyncNotifier<MangaReadingStatus?> {
  late final Manga manga;

  FutureOr<MangaReadingStatus?> build(
    Manga manga,
  );
}

/// See also [ReadingStatus].
@ProviderFor(ReadingStatus)
const readingStatusProvider = ReadingStatusFamily();

/// See also [ReadingStatus].
class ReadingStatusFamily extends Family {
  /// See also [ReadingStatus].
  const ReadingStatusFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'readingStatusProvider';

  /// See also [ReadingStatus].
  ReadingStatusProvider call(
    Manga manga,
  ) {
    return ReadingStatusProvider(
      manga,
    );
  }

  @visibleForOverriding
  @override
  ReadingStatusProvider getProviderOverride(
    covariant ReadingStatusProvider provider,
  ) {
    return call(
      provider.manga,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(ReadingStatus Function() create) {
    return _$ReadingStatusFamilyOverride(this, create);
  }
}

class _$ReadingStatusFamilyOverride implements FamilyOverride {
  _$ReadingStatusFamilyOverride(this.overriddenFamily, this.create);

  final ReadingStatus Function() create;

  @override
  final ReadingStatusFamily overriddenFamily;

  @override
  ReadingStatusProvider getProviderOverride(
    covariant ReadingStatusProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [ReadingStatus].
class ReadingStatusProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ReadingStatus, MangaReadingStatus?> {
  /// See also [ReadingStatus].
  ReadingStatusProvider(
    Manga manga,
  ) : this._internal(
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
          manga: manga,
        );

  ReadingStatusProvider._internal(
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
  FutureOr<MangaReadingStatus?> runNotifierBuild(
    covariant ReadingStatus notifier,
  ) {
    return notifier.build(
      manga,
    );
  }

  @override
  Override overrideWith(ReadingStatus Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReadingStatusProvider._internal(
        () => create()..manga = manga,
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
  AutoDisposeAsyncNotifierProviderElement<ReadingStatus, MangaReadingStatus?>
      createElement() {
    return _ReadingStatusProviderElement(this);
  }

  ReadingStatusProvider _copyWith(
    ReadingStatus Function() create,
  ) {
    return ReadingStatusProvider._internal(
      () => create()..manga = manga,
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
    return other is ReadingStatusProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReadingStatusRef
    on AutoDisposeAsyncNotifierProviderRef<MangaReadingStatus?> {
  /// The parameter `manga` of this provider.
  Manga get manga;
}

class _ReadingStatusProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ReadingStatus,
        MangaReadingStatus?> with ReadingStatusRef {
  _ReadingStatusProviderElement(super.provider);

  @override
  Manga get manga => (origin as ReadingStatusProvider).manga;
}

String _$followingStatusHash() => r'a6108611a7a36518f2eef9b81a8861fdab800e2e';

abstract class _$FollowingStatus
    extends BuildlessAutoDisposeAsyncNotifier<bool> {
  late final Manga manga;

  FutureOr<bool> build(
    Manga manga,
  );
}

/// See also [FollowingStatus].
@ProviderFor(FollowingStatus)
const followingStatusProvider = FollowingStatusFamily();

/// See also [FollowingStatus].
class FollowingStatusFamily extends Family {
  /// See also [FollowingStatus].
  const FollowingStatusFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'followingStatusProvider';

  /// See also [FollowingStatus].
  FollowingStatusProvider call(
    Manga manga,
  ) {
    return FollowingStatusProvider(
      manga,
    );
  }

  @visibleForOverriding
  @override
  FollowingStatusProvider getProviderOverride(
    covariant FollowingStatusProvider provider,
  ) {
    return call(
      provider.manga,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(FollowingStatus Function() create) {
    return _$FollowingStatusFamilyOverride(this, create);
  }
}

class _$FollowingStatusFamilyOverride implements FamilyOverride {
  _$FollowingStatusFamilyOverride(this.overriddenFamily, this.create);

  final FollowingStatus Function() create;

  @override
  final FollowingStatusFamily overriddenFamily;

  @override
  FollowingStatusProvider getProviderOverride(
    covariant FollowingStatusProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [FollowingStatus].
class FollowingStatusProvider
    extends AutoDisposeAsyncNotifierProviderImpl<FollowingStatus, bool> {
  /// See also [FollowingStatus].
  FollowingStatusProvider(
    Manga manga,
  ) : this._internal(
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
          manga: manga,
        );

  FollowingStatusProvider._internal(
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
  FutureOr<bool> runNotifierBuild(
    covariant FollowingStatus notifier,
  ) {
    return notifier.build(
      manga,
    );
  }

  @override
  Override overrideWith(FollowingStatus Function() create) {
    return ProviderOverride(
      origin: this,
      override: FollowingStatusProvider._internal(
        () => create()..manga = manga,
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
  AutoDisposeAsyncNotifierProviderElement<FollowingStatus, bool>
      createElement() {
    return _FollowingStatusProviderElement(this);
  }

  FollowingStatusProvider _copyWith(
    FollowingStatus Function() create,
  ) {
    return FollowingStatusProvider._internal(
      () => create()..manga = manga,
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
    return other is FollowingStatusProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FollowingStatusRef on AutoDisposeAsyncNotifierProviderRef<bool> {
  /// The parameter `manga` of this provider.
  Manga get manga;
}

class _FollowingStatusProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FollowingStatus, bool>
    with FollowingStatusRef {
  _FollowingStatusProviderElement(super.provider);

  @override
  Manga get manga => (origin as FollowingStatusProvider).manga;
}

String _$mangaDexHistoryHash() => r'721bf0e32dd60362d983be14996c01756687f48c';

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
String _$loggedUserHash() => r'57b59b906ca3803768fb2dd9e231239755558a97';

/// See also [LoggedUser].
@ProviderFor(LoggedUser)
final loggedUserProvider = AsyncNotifierProvider<LoggedUser, User?>.internal(
  LoggedUser.new,
  name: r'loggedUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loggedUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoggedUser = AsyncNotifier<User?>;
String _$authControlHash() => r'43f2fe0c7d47d46934f52612bd9bef69c438fb40';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
