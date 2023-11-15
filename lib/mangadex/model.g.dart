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
    r'fbfd961dd7237464598fd4a95fd05fd569c63242';

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
String _$latestGlobalFeedHash() => r'63414a07c1bbce58335603e751281e96a72f2a3a';

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
String _$groupFeedHash() => r'7e7393d4ccda9d1634bb1cd42bdac3191069680d';

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
    extends AsyncNotifierProviderImpl<GroupFeed, List<Chapter>> {
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
  AsyncNotifierProviderElement<GroupFeed, List<Chapter>> createElement() {
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

mixin GroupFeedRef on AsyncNotifierProviderRef<List<Chapter>> {
  /// The parameter `group` of this provider.
  Group get group;
}

class _GroupFeedProviderElement
    extends AsyncNotifierProviderElement<GroupFeed, List<Chapter>>
    with GroupFeedRef {
  _GroupFeedProviderElement(super.provider);

  @override
  Group get group => (origin as GroupFeedProvider).group;
}

String _$groupTitlesHash() => r'9f5a21c735f5e3bd4e1475e3432a8f37475211fe';

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
    extends AsyncNotifierProviderImpl<GroupTitles, List<Manga>> {
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
  AsyncNotifierProviderElement<GroupTitles, List<Manga>> createElement() {
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

mixin GroupTitlesRef on AsyncNotifierProviderRef<List<Manga>> {
  /// The parameter `group` of this provider.
  Group get group;
}

class _GroupTitlesProviderElement
    extends AsyncNotifierProviderElement<GroupTitles, List<Manga>>
    with GroupTitlesRef {
  _GroupTitlesProviderElement(super.provider);

  @override
  Group get group => (origin as GroupTitlesProvider).group;
}

String _$creatorTitlesHash() => r'cb26ec1c3b2ca6b7c5f3386187e77922deea9a3d';

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
    extends AsyncNotifierProviderImpl<CreatorTitles, List<Manga>> {
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
  AsyncNotifierProviderElement<CreatorTitles, List<Manga>> createElement() {
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

mixin CreatorTitlesRef on AsyncNotifierProviderRef<List<Manga>> {
  /// The parameter `creator` of this provider.
  CreatorType get creator;
}

class _CreatorTitlesProviderElement
    extends AsyncNotifierProviderElement<CreatorTitles, List<Manga>>
    with CreatorTitlesRef {
  _CreatorTitlesProviderElement(super.provider);

  @override
  CreatorType get creator => (origin as CreatorTitlesProvider).creator;
}

String _$mangaChaptersHash() => r'6f4cb03ad007b42cd5ea349b030b8f496ac282a7';

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
    extends AsyncNotifierProviderImpl<MangaChapters, List<Chapter>> {
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
  AsyncNotifierProviderElement<MangaChapters, List<Chapter>> createElement() {
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

mixin MangaChaptersRef on AsyncNotifierProviderRef<List<Chapter>> {
  /// The parameter `manga` of this provider.
  Manga get manga;
}

class _MangaChaptersProviderElement
    extends AsyncNotifierProviderElement<MangaChapters, List<Chapter>>
    with MangaChaptersRef {
  _MangaChaptersProviderElement(super.provider);

  @override
  Manga get manga => (origin as MangaChaptersProvider).manga;
}

String _$mangaCoversHash() => r'c694ebf3674071687746d8a039e9fb8a5683dc93';

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
    extends AsyncNotifierProviderImpl<MangaCovers, List<Cover>> {
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
  FutureOr<List<Cover>> runNotifierBuild(
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
  AsyncNotifierProviderElement<MangaCovers, List<Cover>> createElement() {
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

mixin MangaCoversRef on AsyncNotifierProviderRef<List<Cover>> {
  /// The parameter `manga` of this provider.
  Manga get manga;
}

class _MangaCoversProviderElement
    extends AsyncNotifierProviderElement<MangaCovers, List<Cover>>
    with MangaCoversRef {
  _MangaCoversProviderElement(super.provider);

  @override
  Manga get manga => (origin as MangaCoversProvider).manga;
}

String _$readChaptersHash() => r'05281e77132c04171cd00ac3df17ef9ade0b5be7';

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
String _$userLibraryHash() => r'16c08eb4daec2ee4a82638bf7b98fdcea575611d';

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
class UserLibraryFamily extends Family {
  /// See also [UserLibrary].
  const UserLibraryFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userLibraryProvider';

  /// See also [UserLibrary].
  UserLibraryProvider call(
    MangaReadingStatus status,
  ) {
    return UserLibraryProvider(
      status,
    );
  }

  @visibleForOverriding
  @override
  UserLibraryProvider getProviderOverride(
    covariant UserLibraryProvider provider,
  ) {
    return call(
      provider.status,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(UserLibrary Function() create) {
    return _$UserLibraryFamilyOverride(this, create);
  }
}

class _$UserLibraryFamilyOverride implements FamilyOverride {
  _$UserLibraryFamilyOverride(this.overriddenFamily, this.create);

  final UserLibrary Function() create;

  @override
  final UserLibraryFamily overriddenFamily;

  @override
  UserLibraryProvider getProviderOverride(
    covariant UserLibraryProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [UserLibrary].
class UserLibraryProvider
    extends AsyncNotifierProviderImpl<UserLibrary, Iterable<Manga>> {
  /// See also [UserLibrary].
  UserLibraryProvider(
    MangaReadingStatus status,
  ) : this._internal(
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
          status: status,
        );

  UserLibraryProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final MangaReadingStatus status;

  @override
  FutureOr<Iterable<Manga>> runNotifierBuild(
    covariant UserLibrary notifier,
  ) {
    return notifier.build(
      status,
    );
  }

  @override
  Override overrideWith(UserLibrary Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserLibraryProvider._internal(
        () => create()..status = status,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  (MangaReadingStatus,) get argument {
    return (status,);
  }

  @override
  AsyncNotifierProviderElement<UserLibrary, Iterable<Manga>> createElement() {
    return _UserLibraryProviderElement(this);
  }

  UserLibraryProvider _copyWith(
    UserLibrary Function() create,
  ) {
    return UserLibraryProvider._internal(
      () => create()..status = status,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      status: status,
    );
  }

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
}

mixin UserLibraryRef on AsyncNotifierProviderRef<Iterable<Manga>> {
  /// The parameter `status` of this provider.
  MangaReadingStatus get status;
}

class _UserLibraryProviderElement
    extends AsyncNotifierProviderElement<UserLibrary, Iterable<Manga>>
    with UserLibraryRef {
  _UserLibraryProviderElement(super.provider);

  @override
  MangaReadingStatus get status => (origin as UserLibraryProvider).status;
}

String _$userListsHash() => r'a918698a6f97e6de2eca4b55b10cc46c6b113f23';

/// See also [UserLists].
@ProviderFor(UserLists)
final userListsProvider =
    AsyncNotifierProvider<UserLists, List<CustomList>>.internal(
  UserLists.new,
  name: r'userListsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userListsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserLists = AsyncNotifier<List<CustomList>>;
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
String _$mangaSearchHash() => r'24102ea4bfc9e92f70d2f72aa7d1d90b9259eb5a';

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

String _$statisticsHash() => r'59223b4d71c465cc5914ff1379278ea1b704898b';

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
String _$ratingsHash() => r'77d638e475ac3896aa51a8a0d64cda1940ec717f';

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
String _$readingStatusHash() => r'4b85d356c66917d74f0fc4bc20554489ec17571c';

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
class ReadingStatusProvider
    extends AsyncNotifierProviderImpl<ReadingStatus, MangaReadingStatus?> {
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
  AsyncNotifierProviderElement<ReadingStatus, MangaReadingStatus?>
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

mixin ReadingStatusRef on AsyncNotifierProviderRef<MangaReadingStatus?> {
  /// The parameter `manga` of this provider.
  Manga get manga;
}

class _ReadingStatusProviderElement
    extends AsyncNotifierProviderElement<ReadingStatus, MangaReadingStatus?>
    with ReadingStatusRef {
  _ReadingStatusProviderElement(super.provider);

  @override
  Manga get manga => (origin as ReadingStatusProvider).manga;
}

String _$followingStatusHash() => r'b7d5dc300375051d78fa6770d731cd1746ffbac0';

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
    extends AsyncNotifierProviderImpl<FollowingStatus, bool> {
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
  AsyncNotifierProviderElement<FollowingStatus, bool> createElement() {
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

mixin FollowingStatusRef on AsyncNotifierProviderRef<bool> {
  /// The parameter `manga` of this provider.
  Manga get manga;
}

class _FollowingStatusProviderElement
    extends AsyncNotifierProviderElement<FollowingStatus, bool>
    with FollowingStatusRef {
  _FollowingStatusProviderElement(super.provider);

  @override
  Manga get manga => (origin as FollowingStatusProvider).manga;
}

String _$mangaDexHistoryHash() => r'2bf96d936dd78622577da02c9400ad3dd5f9804f';

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
String _$authControlHash() => r'7c76d1e532990ca742f04a2683bc8c4345b5cb9e';

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
