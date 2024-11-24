// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(mangadex)
const mangadexProvider = MangadexProvider._();

final class MangadexProvider
    extends $FunctionalProvider<MangaDexModel, MangaDexModel>
    with $Provider<MangaDexModel> {
  const MangadexProvider._(
      {MangaDexModel Function(
        Ref ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'mangadexProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final MangaDexModel Function(
    Ref ref,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$mangadexHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MangaDexModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<MangaDexModel>(value),
    );
  }

  @$internal
  @override
  $ProviderElement<MangaDexModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(this, pointer);

  @override
  MangadexProvider $copyWithCreate(
    MangaDexModel Function(
      Ref ref,
    ) create,
  ) {
    return MangadexProvider._(create: create);
  }

  @override
  MangaDexModel create(Ref ref) {
    final _$cb = _createCb ?? mangadex;
    return _$cb(ref);
  }
}

String _$mangadexHash() => r'4f95e2d6037a2e23987c4eafa80322c88c003f20';

@ProviderFor(RecentlyAdded)
const recentlyAddedProvider = RecentlyAddedProvider._();

final class RecentlyAddedProvider
    extends $AsyncNotifierProvider<RecentlyAdded, List<Manga>> {
  const RecentlyAddedProvider._(
      {super.runNotifierBuildOverride, RecentlyAdded Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'recentlyAddedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final RecentlyAdded Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$recentlyAddedHash();

  @$internal
  @override
  RecentlyAdded create() => _createCb?.call() ?? RecentlyAdded();

  @$internal
  @override
  RecentlyAddedProvider $copyWithCreate(
    RecentlyAdded Function() create,
  ) {
    return RecentlyAddedProvider._(create: create);
  }

  @$internal
  @override
  RecentlyAddedProvider $copyWithBuild(
    FutureOr<List<Manga>> Function(
      Ref,
      RecentlyAdded,
    ) build,
  ) {
    return RecentlyAddedProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<RecentlyAdded, List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);
}

String _$recentlyAddedHash() => r'22496d90f057786107d262caac09e636442e6af0';

abstract class _$RecentlyAdded extends $AsyncNotifier<List<Manga>> {
  FutureOr<List<Manga>> build();
  @$internal
  @override
  FutureOr<List<Manga>> runBuild() => build();
}

@ProviderFor(LatestChaptersFeed)
const latestChaptersFeedProvider = LatestChaptersFeedProvider._();

final class LatestChaptersFeedProvider
    extends $AsyncNotifierProvider<LatestChaptersFeed, List<Chapter>> {
  const LatestChaptersFeedProvider._(
      {super.runNotifierBuildOverride, LatestChaptersFeed Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'latestChaptersFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final LatestChaptersFeed Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$latestChaptersFeedHash();

  @$internal
  @override
  LatestChaptersFeed create() => _createCb?.call() ?? LatestChaptersFeed();

  @$internal
  @override
  LatestChaptersFeedProvider $copyWithCreate(
    LatestChaptersFeed Function() create,
  ) {
    return LatestChaptersFeedProvider._(create: create);
  }

  @$internal
  @override
  LatestChaptersFeedProvider $copyWithBuild(
    FutureOr<List<Chapter>> Function(
      Ref,
      LatestChaptersFeed,
    ) build,
  ) {
    return LatestChaptersFeedProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<LatestChaptersFeed, List<Chapter>>
      $createElement($ProviderPointer pointer) =>
          $AsyncNotifierProviderElement(this, pointer);
}

String _$latestChaptersFeedHash() =>
    r'53278c87aa1e8a62a77dad3274997a236599c0a8';

abstract class _$LatestChaptersFeed extends $AsyncNotifier<List<Chapter>> {
  FutureOr<List<Chapter>> build();
  @$internal
  @override
  FutureOr<List<Chapter>> runBuild() => build();
}

@ProviderFor(LatestGlobalFeed)
const latestGlobalFeedProvider = LatestGlobalFeedProvider._();

final class LatestGlobalFeedProvider
    extends $AsyncNotifierProvider<LatestGlobalFeed, List<Chapter>> {
  const LatestGlobalFeedProvider._(
      {super.runNotifierBuildOverride, LatestGlobalFeed Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'latestGlobalFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final LatestGlobalFeed Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$latestGlobalFeedHash();

  @$internal
  @override
  LatestGlobalFeed create() => _createCb?.call() ?? LatestGlobalFeed();

  @$internal
  @override
  LatestGlobalFeedProvider $copyWithCreate(
    LatestGlobalFeed Function() create,
  ) {
    return LatestGlobalFeedProvider._(create: create);
  }

  @$internal
  @override
  LatestGlobalFeedProvider $copyWithBuild(
    FutureOr<List<Chapter>> Function(
      Ref,
      LatestGlobalFeed,
    ) build,
  ) {
    return LatestGlobalFeedProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<LatestGlobalFeed, List<Chapter>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);
}

String _$latestGlobalFeedHash() => r'a2980ea27c687eb7d0bbc45526f2626d4d6ae2c0';

abstract class _$LatestGlobalFeed extends $AsyncNotifier<List<Chapter>> {
  FutureOr<List<Chapter>> build();
  @$internal
  @override
  FutureOr<List<Chapter>> runBuild() => build();
}

@ProviderFor(GroupFeed)
const groupFeedProvider = GroupFeedFamily._();

final class GroupFeedProvider
    extends $AsyncNotifierProvider<GroupFeed, List<Chapter>> {
  const GroupFeedProvider._(
      {required GroupFeedFamily super.from,
      required Group super.argument,
      super.runNotifierBuildOverride,
      GroupFeed Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'groupFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final GroupFeed Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$groupFeedHash();

  @override
  String toString() {
    return r'groupFeedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GroupFeed create() => _createCb?.call() ?? GroupFeed();

  @$internal
  @override
  GroupFeedProvider $copyWithCreate(
    GroupFeed Function() create,
  ) {
    return GroupFeedProvider._(
        argument: argument as Group,
        from: from! as GroupFeedFamily,
        create: create);
  }

  @$internal
  @override
  GroupFeedProvider $copyWithBuild(
    FutureOr<List<Chapter>> Function(
      Ref,
      GroupFeed,
    ) build,
  ) {
    return GroupFeedProvider._(
        argument: argument as Group,
        from: from! as GroupFeedFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<GroupFeed, List<Chapter>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);

  @override
  bool operator ==(Object other) {
    return other is GroupFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$groupFeedHash() => r'bff829162cb0bf702a6e2450c78ebee5e2fb0626';

final class GroupFeedFamily extends Family {
  const GroupFeedFamily._()
      : super(
          retry: null,
          name: r'groupFeedProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  GroupFeedProvider call(
    Group group,
  ) =>
      GroupFeedProvider._(argument: group, from: this);

  @override
  String debugGetCreateSourceHash() => _$groupFeedHash();

  @override
  String toString() => r'groupFeedProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    GroupFeed Function(
      Group args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as GroupFeedProvider;

        final argument = provider.argument as Group;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<List<Chapter>> Function(
            Ref ref, GroupFeed notifier, Group argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as GroupFeedProvider;

        final argument = provider.argument as Group;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$GroupFeed extends $AsyncNotifier<List<Chapter>> {
  late final _$args = ref.$arg as Group;
  Group get group => _$args;

  FutureOr<List<Chapter>> build(
    Group group,
  );
  @$internal
  @override
  FutureOr<List<Chapter>> runBuild() => build(
        _$args,
      );
}

@ProviderFor(GroupTitles)
const groupTitlesProvider = GroupTitlesFamily._();

final class GroupTitlesProvider
    extends $AsyncNotifierProvider<GroupTitles, List<Manga>> {
  const GroupTitlesProvider._(
      {required GroupTitlesFamily super.from,
      required Group super.argument,
      super.runNotifierBuildOverride,
      GroupTitles Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'groupTitlesProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final GroupTitles Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$groupTitlesHash();

  @override
  String toString() {
    return r'groupTitlesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GroupTitles create() => _createCb?.call() ?? GroupTitles();

  @$internal
  @override
  GroupTitlesProvider $copyWithCreate(
    GroupTitles Function() create,
  ) {
    return GroupTitlesProvider._(
        argument: argument as Group,
        from: from! as GroupTitlesFamily,
        create: create);
  }

  @$internal
  @override
  GroupTitlesProvider $copyWithBuild(
    FutureOr<List<Manga>> Function(
      Ref,
      GroupTitles,
    ) build,
  ) {
    return GroupTitlesProvider._(
        argument: argument as Group,
        from: from! as GroupTitlesFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<GroupTitles, List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);

  @override
  bool operator ==(Object other) {
    return other is GroupTitlesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$groupTitlesHash() => r'82b39c5d8b6e102f2a20956fbc8e950fbddebc99';

final class GroupTitlesFamily extends Family {
  const GroupTitlesFamily._()
      : super(
          retry: null,
          name: r'groupTitlesProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  GroupTitlesProvider call(
    Group group,
  ) =>
      GroupTitlesProvider._(argument: group, from: this);

  @override
  String debugGetCreateSourceHash() => _$groupTitlesHash();

  @override
  String toString() => r'groupTitlesProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    GroupTitles Function(
      Group args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as GroupTitlesProvider;

        final argument = provider.argument as Group;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<List<Manga>> Function(
            Ref ref, GroupTitles notifier, Group argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as GroupTitlesProvider;

        final argument = provider.argument as Group;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$GroupTitles extends $AsyncNotifier<List<Manga>> {
  late final _$args = ref.$arg as Group;
  Group get group => _$args;

  FutureOr<List<Manga>> build(
    Group group,
  );
  @$internal
  @override
  FutureOr<List<Manga>> runBuild() => build(
        _$args,
      );
}

@ProviderFor(CreatorTitles)
const creatorTitlesProvider = CreatorTitlesFamily._();

final class CreatorTitlesProvider
    extends $AsyncNotifierProvider<CreatorTitles, List<Manga>> {
  const CreatorTitlesProvider._(
      {required CreatorTitlesFamily super.from,
      required CreatorType super.argument,
      super.runNotifierBuildOverride,
      CreatorTitles Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'creatorTitlesProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final CreatorTitles Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$creatorTitlesHash();

  @override
  String toString() {
    return r'creatorTitlesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CreatorTitles create() => _createCb?.call() ?? CreatorTitles();

  @$internal
  @override
  CreatorTitlesProvider $copyWithCreate(
    CreatorTitles Function() create,
  ) {
    return CreatorTitlesProvider._(
        argument: argument as CreatorType,
        from: from! as CreatorTitlesFamily,
        create: create);
  }

  @$internal
  @override
  CreatorTitlesProvider $copyWithBuild(
    FutureOr<List<Manga>> Function(
      Ref,
      CreatorTitles,
    ) build,
  ) {
    return CreatorTitlesProvider._(
        argument: argument as CreatorType,
        from: from! as CreatorTitlesFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<CreatorTitles, List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);

  @override
  bool operator ==(Object other) {
    return other is CreatorTitlesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$creatorTitlesHash() => r'1f1e50d06abe63f8af040675627d6f02d71c588c';

final class CreatorTitlesFamily extends Family {
  const CreatorTitlesFamily._()
      : super(
          retry: null,
          name: r'creatorTitlesProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  CreatorTitlesProvider call(
    CreatorType creator,
  ) =>
      CreatorTitlesProvider._(argument: creator, from: this);

  @override
  String debugGetCreateSourceHash() => _$creatorTitlesHash();

  @override
  String toString() => r'creatorTitlesProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    CreatorTitles Function(
      CreatorType args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as CreatorTitlesProvider;

        final argument = provider.argument as CreatorType;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<List<Manga>> Function(
            Ref ref, CreatorTitles notifier, CreatorType argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as CreatorTitlesProvider;

        final argument = provider.argument as CreatorType;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$CreatorTitles extends $AsyncNotifier<List<Manga>> {
  late final _$args = ref.$arg as CreatorType;
  CreatorType get creator => _$args;

  FutureOr<List<Manga>> build(
    CreatorType creator,
  );
  @$internal
  @override
  FutureOr<List<Manga>> runBuild() => build(
        _$args,
      );
}

@ProviderFor(MangaChaptersListSort)
const mangaChaptersListSortProvider = MangaChaptersListSortProvider._();

final class MangaChaptersListSortProvider
    extends $NotifierProvider<MangaChaptersListSort, ListSort> {
  const MangaChaptersListSortProvider._(
      {super.runNotifierBuildOverride,
      MangaChaptersListSort Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'mangaChaptersListSortProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final MangaChaptersListSort Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$mangaChaptersListSortHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListSort value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ListSort>(value),
    );
  }

  @$internal
  @override
  MangaChaptersListSort create() =>
      _createCb?.call() ?? MangaChaptersListSort();

  @$internal
  @override
  MangaChaptersListSortProvider $copyWithCreate(
    MangaChaptersListSort Function() create,
  ) {
    return MangaChaptersListSortProvider._(create: create);
  }

  @$internal
  @override
  MangaChaptersListSortProvider $copyWithBuild(
    ListSort Function(
      Ref,
      MangaChaptersListSort,
    ) build,
  ) {
    return MangaChaptersListSortProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<MangaChaptersListSort, ListSort> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(this, pointer);
}

String _$mangaChaptersListSortHash() =>
    r'71b85b6dcf773f1b96a7175794184871a99dc3dc';

abstract class _$MangaChaptersListSort extends $Notifier<ListSort> {
  ListSort build();
  @$internal
  @override
  ListSort runBuild() => build();
}

@ProviderFor(MangaChapters)
const mangaChaptersProvider = MangaChaptersFamily._();

final class MangaChaptersProvider
    extends $AsyncNotifierProvider<MangaChapters, List<Chapter>> {
  const MangaChaptersProvider._(
      {required MangaChaptersFamily super.from,
      required Manga super.argument,
      super.runNotifierBuildOverride,
      MangaChapters Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'mangaChaptersProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final MangaChapters Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$mangaChaptersHash();

  @override
  String toString() {
    return r'mangaChaptersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MangaChapters create() => _createCb?.call() ?? MangaChapters();

  @$internal
  @override
  MangaChaptersProvider $copyWithCreate(
    MangaChapters Function() create,
  ) {
    return MangaChaptersProvider._(
        argument: argument as Manga,
        from: from! as MangaChaptersFamily,
        create: create);
  }

  @$internal
  @override
  MangaChaptersProvider $copyWithBuild(
    FutureOr<List<Chapter>> Function(
      Ref,
      MangaChapters,
    ) build,
  ) {
    return MangaChaptersProvider._(
        argument: argument as Manga,
        from: from! as MangaChaptersFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<MangaChapters, List<Chapter>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);

  @override
  bool operator ==(Object other) {
    return other is MangaChaptersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mangaChaptersHash() => r'bc3689a302f9e21dfed0b987c259cd9aedcb5db4';

final class MangaChaptersFamily extends Family {
  const MangaChaptersFamily._()
      : super(
          retry: null,
          name: r'mangaChaptersProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  MangaChaptersProvider call(
    Manga manga,
  ) =>
      MangaChaptersProvider._(argument: manga, from: this);

  @override
  String debugGetCreateSourceHash() => _$mangaChaptersHash();

  @override
  String toString() => r'mangaChaptersProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    MangaChapters Function(
      Manga args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as MangaChaptersProvider;

        final argument = provider.argument as Manga;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<List<Chapter>> Function(
            Ref ref, MangaChapters notifier, Manga argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as MangaChaptersProvider;

        final argument = provider.argument as Manga;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$MangaChapters extends $AsyncNotifier<List<Chapter>> {
  late final _$args = ref.$arg as Manga;
  Manga get manga => _$args;

  FutureOr<List<Chapter>> build(
    Manga manga,
  );
  @$internal
  @override
  FutureOr<List<Chapter>> runBuild() => build(
        _$args,
      );
}

@ProviderFor(MangaCovers)
const mangaCoversProvider = MangaCoversFamily._();

final class MangaCoversProvider
    extends $AsyncNotifierProvider<MangaCovers, List<CoverArt>> {
  const MangaCoversProvider._(
      {required MangaCoversFamily super.from,
      required Manga super.argument,
      super.runNotifierBuildOverride,
      MangaCovers Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'mangaCoversProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final MangaCovers Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$mangaCoversHash();

  @override
  String toString() {
    return r'mangaCoversProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MangaCovers create() => _createCb?.call() ?? MangaCovers();

  @$internal
  @override
  MangaCoversProvider $copyWithCreate(
    MangaCovers Function() create,
  ) {
    return MangaCoversProvider._(
        argument: argument as Manga,
        from: from! as MangaCoversFamily,
        create: create);
  }

  @$internal
  @override
  MangaCoversProvider $copyWithBuild(
    FutureOr<List<CoverArt>> Function(
      Ref,
      MangaCovers,
    ) build,
  ) {
    return MangaCoversProvider._(
        argument: argument as Manga,
        from: from! as MangaCoversFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<MangaCovers, List<CoverArt>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);

  @override
  bool operator ==(Object other) {
    return other is MangaCoversProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mangaCoversHash() => r'cf841ca39bf9272b4ce4c45d68fdb83cfcf8c56c';

final class MangaCoversFamily extends Family {
  const MangaCoversFamily._()
      : super(
          retry: null,
          name: r'mangaCoversProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  MangaCoversProvider call(
    Manga manga,
  ) =>
      MangaCoversProvider._(argument: manga, from: this);

  @override
  String debugGetCreateSourceHash() => _$mangaCoversHash();

  @override
  String toString() => r'mangaCoversProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    MangaCovers Function(
      Manga args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as MangaCoversProvider;

        final argument = provider.argument as Manga;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<List<CoverArt>> Function(
            Ref ref, MangaCovers notifier, Manga argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as MangaCoversProvider;

        final argument = provider.argument as Manga;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$MangaCovers extends $AsyncNotifier<List<CoverArt>> {
  late final _$args = ref.$arg as Manga;
  Manga get manga => _$args;

  FutureOr<List<CoverArt>> build(
    Manga manga,
  );
  @$internal
  @override
  FutureOr<List<CoverArt>> runBuild() => build(
        _$args,
      );
}

@ProviderFor(ReadChapters)
const readChaptersProvider = ReadChaptersProvider._();

final class ReadChaptersProvider
    extends $AsyncNotifierProvider<ReadChapters, ReadChaptersMap> {
  const ReadChaptersProvider._(
      {super.runNotifierBuildOverride, ReadChapters Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'readChaptersProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final ReadChapters Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$readChaptersHash();

  @$internal
  @override
  ReadChapters create() => _createCb?.call() ?? ReadChapters();

  @$internal
  @override
  ReadChaptersProvider $copyWithCreate(
    ReadChapters Function() create,
  ) {
    return ReadChaptersProvider._(create: create);
  }

  @$internal
  @override
  ReadChaptersProvider $copyWithBuild(
    FutureOr<ReadChaptersMap> Function(
      Ref,
      ReadChapters,
    ) build,
  ) {
    return ReadChaptersProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<ReadChapters, ReadChaptersMap> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);
}

String _$readChaptersHash() => r'e237346f223ca3a348f11649b3403965d3c1f135';

abstract class _$ReadChapters extends $AsyncNotifier<ReadChaptersMap> {
  FutureOr<ReadChaptersMap> build();
  @$internal
  @override
  FutureOr<ReadChaptersMap> runBuild() => build();
}

@ProviderFor(UserLibrary)
const userLibraryProvider = UserLibraryProvider._();

final class UserLibraryProvider extends $AsyncNotifierProvider<UserLibrary,
    Map<String, MangaReadingStatus>> {
  const UserLibraryProvider._(
      {super.runNotifierBuildOverride, UserLibrary Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'userLibraryProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final UserLibrary Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$userLibraryHash();

  @$internal
  @override
  UserLibrary create() => _createCb?.call() ?? UserLibrary();

  @$internal
  @override
  UserLibraryProvider $copyWithCreate(
    UserLibrary Function() create,
  ) {
    return UserLibraryProvider._(create: create);
  }

  @$internal
  @override
  UserLibraryProvider $copyWithBuild(
    FutureOr<Map<String, MangaReadingStatus>> Function(
      Ref,
      UserLibrary,
    ) build,
  ) {
    return UserLibraryProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<UserLibrary, Map<String, MangaReadingStatus>>
      $createElement($ProviderPointer pointer) =>
          $AsyncNotifierProviderElement(this, pointer);
}

String _$userLibraryHash() => r'58d3a7add927e3c970b317ca85b19a8090556ef2';

abstract class _$UserLibrary
    extends $AsyncNotifier<Map<String, MangaReadingStatus>> {
  FutureOr<Map<String, MangaReadingStatus>> build();
  @$internal
  @override
  FutureOr<Map<String, MangaReadingStatus>> runBuild() => build();
}

@ProviderFor(UserLists)
const userListsProvider = UserListsProvider._();

final class UserListsProvider
    extends $AsyncNotifierProvider<UserLists, List<CustomList>> {
  const UserListsProvider._(
      {super.runNotifierBuildOverride, UserLists Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'userListsProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final UserLists Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$userListsHash();

  @$internal
  @override
  UserLists create() => _createCb?.call() ?? UserLists();

  @$internal
  @override
  UserListsProvider $copyWithCreate(
    UserLists Function() create,
  ) {
    return UserListsProvider._(create: create);
  }

  @$internal
  @override
  UserListsProvider $copyWithBuild(
    FutureOr<List<CustomList>> Function(
      Ref,
      UserLists,
    ) build,
  ) {
    return UserListsProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<UserLists, List<CustomList>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);
}

String _$userListsHash() => r'905a900594b91b998953be64e3978287932d413b';

abstract class _$UserLists extends $AsyncNotifier<List<CustomList>> {
  FutureOr<List<CustomList>> build();
  @$internal
  @override
  FutureOr<List<CustomList>> runBuild() => build();
}

@ProviderFor(FollowedLists)
const followedListsProvider = FollowedListsProvider._();

final class FollowedListsProvider
    extends $AsyncNotifierProvider<FollowedLists, List<CustomList>> {
  const FollowedListsProvider._(
      {super.runNotifierBuildOverride, FollowedLists Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'followedListsProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FollowedLists Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$followedListsHash();

  @$internal
  @override
  FollowedLists create() => _createCb?.call() ?? FollowedLists();

  @$internal
  @override
  FollowedListsProvider $copyWithCreate(
    FollowedLists Function() create,
  ) {
    return FollowedListsProvider._(create: create);
  }

  @$internal
  @override
  FollowedListsProvider $copyWithBuild(
    FutureOr<List<CustomList>> Function(
      Ref,
      FollowedLists,
    ) build,
  ) {
    return FollowedListsProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<FollowedLists, List<CustomList>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);
}

String _$followedListsHash() => r'1065619118b8e74f6214367c8db1a64e747c3207';

abstract class _$FollowedLists extends $AsyncNotifier<List<CustomList>> {
  FutureOr<List<CustomList>> build();
  @$internal
  @override
  FutureOr<List<CustomList>> runBuild() => build();
}

@ProviderFor(CustomListFeed)
const customListFeedProvider = CustomListFeedFamily._();

final class CustomListFeedProvider
    extends $AsyncNotifierProvider<CustomListFeed, List<Chapter>> {
  const CustomListFeedProvider._(
      {required CustomListFeedFamily super.from,
      required CustomList super.argument,
      super.runNotifierBuildOverride,
      CustomListFeed Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'customListFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final CustomListFeed Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$customListFeedHash();

  @override
  String toString() {
    return r'customListFeedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CustomListFeed create() => _createCb?.call() ?? CustomListFeed();

  @$internal
  @override
  CustomListFeedProvider $copyWithCreate(
    CustomListFeed Function() create,
  ) {
    return CustomListFeedProvider._(
        argument: argument as CustomList,
        from: from! as CustomListFeedFamily,
        create: create);
  }

  @$internal
  @override
  CustomListFeedProvider $copyWithBuild(
    FutureOr<List<Chapter>> Function(
      Ref,
      CustomListFeed,
    ) build,
  ) {
    return CustomListFeedProvider._(
        argument: argument as CustomList,
        from: from! as CustomListFeedFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<CustomListFeed, List<Chapter>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);

  @override
  bool operator ==(Object other) {
    return other is CustomListFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customListFeedHash() => r'1a9d4a376d8682dd783b29c779cdc8155d900e6a';

final class CustomListFeedFamily extends Family {
  const CustomListFeedFamily._()
      : super(
          retry: null,
          name: r'customListFeedProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  CustomListFeedProvider call(
    CustomList list,
  ) =>
      CustomListFeedProvider._(argument: list, from: this);

  @override
  String debugGetCreateSourceHash() => _$customListFeedHash();

  @override
  String toString() => r'customListFeedProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    CustomListFeed Function(
      CustomList args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as CustomListFeedProvider;

        final argument = provider.argument as CustomList;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<List<Chapter>> Function(
            Ref ref, CustomListFeed notifier, CustomList argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as CustomListFeedProvider;

        final argument = provider.argument as CustomList;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$CustomListFeed extends $AsyncNotifier<List<Chapter>> {
  late final _$args = ref.$arg as CustomList;
  CustomList get list => _$args;

  FutureOr<List<Chapter>> build(
    CustomList list,
  );
  @$internal
  @override
  FutureOr<List<Chapter>> runBuild() => build(
        _$args,
      );
}

@ProviderFor(getMangaListByPage)
const getMangaListByPageProvider = GetMangaListByPageFamily._();

final class GetMangaListByPageProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const GetMangaListByPageProvider._(
      {required GetMangaListByPageFamily super.from,
      required (
        Iterable<String>,
        int,
      )
          super.argument,
      FutureOr<List<Manga>> Function(
        Ref ref,
        Iterable<String> list,
        int page,
      )? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'getMangaListByPageProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<Manga>> Function(
    Ref ref,
    Iterable<String> list,
    int page,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$getMangaListByPageHash();

  @override
  String toString() {
    return r'getMangaListByPageProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  GetMangaListByPageProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(
      Ref ref,
    ) create,
  ) {
    return GetMangaListByPageProvider._(
        argument: argument as (
          Iterable<String>,
          int,
        ),
        from: from! as GetMangaListByPageFamily,
        create: (
          ref,
          Iterable<String> list,
          int page,
        ) =>
            create(ref));
  }

  @override
  FutureOr<List<Manga>> create(Ref ref) {
    final _$cb = _createCb ?? getMangaListByPage;
    final argument = this.argument as (
      Iterable<String>,
      int,
    );
    return _$cb(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GetMangaListByPageProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getMangaListByPageHash() =>
    r'd38f35b6ded0dd3fdf558b3a8e2c3756ac3c03d0';

final class GetMangaListByPageFamily extends Family {
  const GetMangaListByPageFamily._()
      : super(
          retry: null,
          name: r'getMangaListByPageProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  GetMangaListByPageProvider call(
    Iterable<String> list,
    int page,
  ) =>
      GetMangaListByPageProvider._(argument: (
        list,
        page,
      ), from: this);

  @override
  String debugGetCreateSourceHash() => _$getMangaListByPageHash();

  @override
  String toString() => r'getMangaListByPageProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<Manga>> Function(
      Ref ref,
      (
        Iterable<String>,
        int,
      ) args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as GetMangaListByPageProvider;

        final argument = provider.argument as (
          Iterable<String>,
          int,
        );

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

@ProviderFor(PersistentMangaListPaginator)
const persistentMangaListPaginatorProvider =
    PersistentMangaListPaginatorFamily._();

final class PersistentMangaListPaginatorProvider
    extends $AsyncNotifierProvider<PersistentMangaListPaginator, List<Manga>> {
  const PersistentMangaListPaginatorProvider._(
      {required PersistentMangaListPaginatorFamily super.from,
      required String super.argument,
      super.runNotifierBuildOverride,
      PersistentMangaListPaginator Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'persistentMangaListPaginatorProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final PersistentMangaListPaginator Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$persistentMangaListPaginatorHash();

  @override
  String toString() {
    return r'persistentMangaListPaginatorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PersistentMangaListPaginator create() =>
      _createCb?.call() ?? PersistentMangaListPaginator();

  @$internal
  @override
  PersistentMangaListPaginatorProvider $copyWithCreate(
    PersistentMangaListPaginator Function() create,
  ) {
    return PersistentMangaListPaginatorProvider._(
        argument: argument as String,
        from: from! as PersistentMangaListPaginatorFamily,
        create: create);
  }

  @$internal
  @override
  PersistentMangaListPaginatorProvider $copyWithBuild(
    FutureOr<List<Manga>> Function(
      Ref,
      PersistentMangaListPaginator,
    ) build,
  ) {
    return PersistentMangaListPaginatorProvider._(
        argument: argument as String,
        from: from! as PersistentMangaListPaginatorFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<PersistentMangaListPaginator, List<Manga>>
      $createElement($ProviderPointer pointer) =>
          $AsyncNotifierProviderElement(this, pointer);

  @override
  bool operator ==(Object other) {
    return other is PersistentMangaListPaginatorProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$persistentMangaListPaginatorHash() =>
    r'dc45b9b98ca370b67860d1b2cde7f4ddc8a92c56';

final class PersistentMangaListPaginatorFamily extends Family {
  const PersistentMangaListPaginatorFamily._()
      : super(
          retry: null,
          name: r'persistentMangaListPaginatorProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PersistentMangaListPaginatorProvider call(
    String id,
  ) =>
      PersistentMangaListPaginatorProvider._(argument: id, from: this);

  @override
  String debugGetCreateSourceHash() => _$persistentMangaListPaginatorHash();

  @override
  String toString() => r'persistentMangaListPaginatorProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    PersistentMangaListPaginator Function(
      String args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as PersistentMangaListPaginatorProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<List<Manga>> Function(
            Ref ref, PersistentMangaListPaginator notifier, String argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as PersistentMangaListPaginatorProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$PersistentMangaListPaginator
    extends $AsyncNotifier<List<Manga>> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<List<Manga>> build(
    String id,
  );
  @$internal
  @override
  FutureOr<List<Manga>> runBuild() => build(
        _$args,
      );
}

@ProviderFor(ListSource)
const listSourceProvider = ListSourceFamily._();

final class ListSourceProvider
    extends $AsyncNotifierProvider<ListSource, CustomList?> {
  const ListSourceProvider._(
      {required ListSourceFamily super.from,
      required String super.argument,
      super.runNotifierBuildOverride,
      ListSource Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'listSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final ListSource Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$listSourceHash();

  @override
  String toString() {
    return r'listSourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ListSource create() => _createCb?.call() ?? ListSource();

  @$internal
  @override
  ListSourceProvider $copyWithCreate(
    ListSource Function() create,
  ) {
    return ListSourceProvider._(
        argument: argument as String,
        from: from! as ListSourceFamily,
        create: create);
  }

  @$internal
  @override
  ListSourceProvider $copyWithBuild(
    FutureOr<CustomList?> Function(
      Ref,
      ListSource,
    ) build,
  ) {
    return ListSourceProvider._(
        argument: argument as String,
        from: from! as ListSourceFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<ListSource, CustomList?> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);

  @override
  bool operator ==(Object other) {
    return other is ListSourceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listSourceHash() => r'9f85bdb85e5530013d8842bb4095cf7fd5538c2c';

final class ListSourceFamily extends Family {
  const ListSourceFamily._()
      : super(
          retry: null,
          name: r'listSourceProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ListSourceProvider call(
    String listId,
  ) =>
      ListSourceProvider._(argument: listId, from: this);

  @override
  String debugGetCreateSourceHash() => _$listSourceHash();

  @override
  String toString() => r'listSourceProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    ListSource Function(
      String args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as ListSourceProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<CustomList?> Function(
            Ref ref, ListSource notifier, String argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as ListSourceProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$ListSource extends $AsyncNotifier<CustomList?> {
  late final _$args = ref.$arg as String;
  String get listId => _$args;

  FutureOr<CustomList?> build(
    String listId,
  );
  @$internal
  @override
  FutureOr<CustomList?> runBuild() => build(
        _$args,
      );
}

@ProviderFor(TagList)
const tagListProvider = TagListProvider._();

final class TagListProvider
    extends $AsyncNotifierProvider<TagList, Iterable<Tag>> {
  const TagListProvider._(
      {super.runNotifierBuildOverride, TagList Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'tagListProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final TagList Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$tagListHash();

  @$internal
  @override
  TagList create() => _createCb?.call() ?? TagList();

  @$internal
  @override
  TagListProvider $copyWithCreate(
    TagList Function() create,
  ) {
    return TagListProvider._(create: create);
  }

  @$internal
  @override
  TagListProvider $copyWithBuild(
    FutureOr<Iterable<Tag>> Function(
      Ref,
      TagList,
    ) build,
  ) {
    return TagListProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<TagList, Iterable<Tag>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);
}

String _$tagListHash() => r'5d3bda30cfa4e84118d92e60be6dfa7b23364c85';

abstract class _$TagList extends $AsyncNotifier<Iterable<Tag>> {
  FutureOr<Iterable<Tag>> build();
  @$internal
  @override
  FutureOr<Iterable<Tag>> runBuild() => build();
}

@ProviderFor(MangaSearch)
const mangaSearchProvider = MangaSearchFamily._();

final class MangaSearchProvider
    extends $AsyncNotifierProvider<MangaSearch, List<Manga>> {
  const MangaSearchProvider._(
      {required MangaSearchFamily super.from,
      required MangaSearchParameters super.argument,
      super.runNotifierBuildOverride,
      MangaSearch Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'mangaSearchProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final MangaSearch Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$mangaSearchHash();

  @override
  String toString() {
    return r'mangaSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MangaSearch create() => _createCb?.call() ?? MangaSearch();

  @$internal
  @override
  MangaSearchProvider $copyWithCreate(
    MangaSearch Function() create,
  ) {
    return MangaSearchProvider._(
        argument: argument as MangaSearchParameters,
        from: from! as MangaSearchFamily,
        create: create);
  }

  @$internal
  @override
  MangaSearchProvider $copyWithBuild(
    FutureOr<List<Manga>> Function(
      Ref,
      MangaSearch,
    ) build,
  ) {
    return MangaSearchProvider._(
        argument: argument as MangaSearchParameters,
        from: from! as MangaSearchFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<MangaSearch, List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);

  @override
  bool operator ==(Object other) {
    return other is MangaSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mangaSearchHash() => r'86e80750442f46f879da481d5bb11328f0a3e64a';

final class MangaSearchFamily extends Family {
  const MangaSearchFamily._()
      : super(
          retry: null,
          name: r'mangaSearchProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  MangaSearchProvider call(
    MangaSearchParameters params,
  ) =>
      MangaSearchProvider._(argument: params, from: this);

  @override
  String debugGetCreateSourceHash() => _$mangaSearchHash();

  @override
  String toString() => r'mangaSearchProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    MangaSearch Function(
      MangaSearchParameters args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as MangaSearchProvider;

        final argument = provider.argument as MangaSearchParameters;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<List<Manga>> Function(
            Ref ref, MangaSearch notifier, MangaSearchParameters argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as MangaSearchProvider;

        final argument = provider.argument as MangaSearchParameters;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$MangaSearch extends $AsyncNotifier<List<Manga>> {
  late final _$args = ref.$arg as MangaSearchParameters;
  MangaSearchParameters get params => _$args;

  FutureOr<List<Manga>> build(
    MangaSearchParameters params,
  );
  @$internal
  @override
  FutureOr<List<Manga>> runBuild() => build(
        _$args,
      );
}

@ProviderFor(Statistics)
const statisticsProvider = StatisticsProvider._();

final class StatisticsProvider
    extends $AsyncNotifierProvider<Statistics, Map<String, MangaStatistics>> {
  const StatisticsProvider._(
      {super.runNotifierBuildOverride, Statistics Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'statisticsProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final Statistics Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$statisticsHash();

  @$internal
  @override
  Statistics create() => _createCb?.call() ?? Statistics();

  @$internal
  @override
  StatisticsProvider $copyWithCreate(
    Statistics Function() create,
  ) {
    return StatisticsProvider._(create: create);
  }

  @$internal
  @override
  StatisticsProvider $copyWithBuild(
    FutureOr<Map<String, MangaStatistics>> Function(
      Ref,
      Statistics,
    ) build,
  ) {
    return StatisticsProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<Statistics, Map<String, MangaStatistics>>
      $createElement($ProviderPointer pointer) =>
          $AsyncNotifierProviderElement(this, pointer);
}

String _$statisticsHash() => r'88e01c08880b752299a19619540057b3dffabc17';

abstract class _$Statistics
    extends $AsyncNotifier<Map<String, MangaStatistics>> {
  FutureOr<Map<String, MangaStatistics>> build();
  @$internal
  @override
  FutureOr<Map<String, MangaStatistics>> runBuild() => build();
}

@ProviderFor(ChapterStats)
const chapterStatsProvider = ChapterStatsProvider._();

final class ChapterStatsProvider extends $AsyncNotifierProvider<ChapterStats,
    Map<String, ChapterStatistics>> {
  const ChapterStatsProvider._(
      {super.runNotifierBuildOverride, ChapterStats Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'chapterStatsProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final ChapterStats Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$chapterStatsHash();

  @$internal
  @override
  ChapterStats create() => _createCb?.call() ?? ChapterStats();

  @$internal
  @override
  ChapterStatsProvider $copyWithCreate(
    ChapterStats Function() create,
  ) {
    return ChapterStatsProvider._(create: create);
  }

  @$internal
  @override
  ChapterStatsProvider $copyWithBuild(
    FutureOr<Map<String, ChapterStatistics>> Function(
      Ref,
      ChapterStats,
    ) build,
  ) {
    return ChapterStatsProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<ChapterStats, Map<String, ChapterStatistics>>
      $createElement($ProviderPointer pointer) =>
          $AsyncNotifierProviderElement(this, pointer);
}

String _$chapterStatsHash() => r'5feda95580c7bcd820271f414a9d27adeeff85fc';

abstract class _$ChapterStats
    extends $AsyncNotifier<Map<String, ChapterStatistics>> {
  FutureOr<Map<String, ChapterStatistics>> build();
  @$internal
  @override
  FutureOr<Map<String, ChapterStatistics>> runBuild() => build();
}

@ProviderFor(Ratings)
const ratingsProvider = RatingsProvider._();

final class RatingsProvider
    extends $AsyncNotifierProvider<Ratings, Map<String, SelfRating>> {
  const RatingsProvider._(
      {super.runNotifierBuildOverride, Ratings Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'ratingsProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final Ratings Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$ratingsHash();

  @$internal
  @override
  Ratings create() => _createCb?.call() ?? Ratings();

  @$internal
  @override
  RatingsProvider $copyWithCreate(
    Ratings Function() create,
  ) {
    return RatingsProvider._(create: create);
  }

  @$internal
  @override
  RatingsProvider $copyWithBuild(
    FutureOr<Map<String, SelfRating>> Function(
      Ref,
      Ratings,
    ) build,
  ) {
    return RatingsProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<Ratings, Map<String, SelfRating>>
      $createElement($ProviderPointer pointer) =>
          $AsyncNotifierProviderElement(this, pointer);
}

String _$ratingsHash() => r'6b900db074480ba33b6ec63df02c3e04710c1db0';

abstract class _$Ratings extends $AsyncNotifier<Map<String, SelfRating>> {
  FutureOr<Map<String, SelfRating>> build();
  @$internal
  @override
  FutureOr<Map<String, SelfRating>> runBuild() => build();
}

@ProviderFor(ReadingStatus)
const readingStatusProvider = ReadingStatusFamily._();

final class ReadingStatusProvider
    extends $AsyncNotifierProvider<ReadingStatus, MangaReadingStatus?> {
  const ReadingStatusProvider._(
      {required ReadingStatusFamily super.from,
      required Manga super.argument,
      super.runNotifierBuildOverride,
      ReadingStatus Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'readingStatusProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final ReadingStatus Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$readingStatusHash();

  @override
  String toString() {
    return r'readingStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ReadingStatus create() => _createCb?.call() ?? ReadingStatus();

  @$internal
  @override
  ReadingStatusProvider $copyWithCreate(
    ReadingStatus Function() create,
  ) {
    return ReadingStatusProvider._(
        argument: argument as Manga,
        from: from! as ReadingStatusFamily,
        create: create);
  }

  @$internal
  @override
  ReadingStatusProvider $copyWithBuild(
    FutureOr<MangaReadingStatus?> Function(
      Ref,
      ReadingStatus,
    ) build,
  ) {
    return ReadingStatusProvider._(
        argument: argument as Manga,
        from: from! as ReadingStatusFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<ReadingStatus, MangaReadingStatus?>
      $createElement($ProviderPointer pointer) =>
          $AsyncNotifierProviderElement(this, pointer);

  @override
  bool operator ==(Object other) {
    return other is ReadingStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$readingStatusHash() => r'f4a64272b7b4df32e3b54f55c4f2454a49dc77af';

final class ReadingStatusFamily extends Family {
  const ReadingStatusFamily._()
      : super(
          retry: null,
          name: r'readingStatusProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ReadingStatusProvider call(
    Manga manga,
  ) =>
      ReadingStatusProvider._(argument: manga, from: this);

  @override
  String debugGetCreateSourceHash() => _$readingStatusHash();

  @override
  String toString() => r'readingStatusProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    ReadingStatus Function(
      Manga args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as ReadingStatusProvider;

        final argument = provider.argument as Manga;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<MangaReadingStatus?> Function(
            Ref ref, ReadingStatus notifier, Manga argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as ReadingStatusProvider;

        final argument = provider.argument as Manga;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$ReadingStatus extends $AsyncNotifier<MangaReadingStatus?> {
  late final _$args = ref.$arg as Manga;
  Manga get manga => _$args;

  FutureOr<MangaReadingStatus?> build(
    Manga manga,
  );
  @$internal
  @override
  FutureOr<MangaReadingStatus?> runBuild() => build(
        _$args,
      );
}

@ProviderFor(FollowingStatus)
const followingStatusProvider = FollowingStatusFamily._();

final class FollowingStatusProvider
    extends $AsyncNotifierProvider<FollowingStatus, bool> {
  const FollowingStatusProvider._(
      {required FollowingStatusFamily super.from,
      required Manga super.argument,
      super.runNotifierBuildOverride,
      FollowingStatus Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'followingStatusProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FollowingStatus Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$followingStatusHash();

  @override
  String toString() {
    return r'followingStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FollowingStatus create() => _createCb?.call() ?? FollowingStatus();

  @$internal
  @override
  FollowingStatusProvider $copyWithCreate(
    FollowingStatus Function() create,
  ) {
    return FollowingStatusProvider._(
        argument: argument as Manga,
        from: from! as FollowingStatusFamily,
        create: create);
  }

  @$internal
  @override
  FollowingStatusProvider $copyWithBuild(
    FutureOr<bool> Function(
      Ref,
      FollowingStatus,
    ) build,
  ) {
    return FollowingStatusProvider._(
        argument: argument as Manga,
        from: from! as FollowingStatusFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<FollowingStatus, bool> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);

  @override
  bool operator ==(Object other) {
    return other is FollowingStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$followingStatusHash() => r'bfee3713458067c2bfd1e60d7675286073c861fa';

final class FollowingStatusFamily extends Family {
  const FollowingStatusFamily._()
      : super(
          retry: null,
          name: r'followingStatusProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FollowingStatusProvider call(
    Manga manga,
  ) =>
      FollowingStatusProvider._(argument: manga, from: this);

  @override
  String debugGetCreateSourceHash() => _$followingStatusHash();

  @override
  String toString() => r'followingStatusProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FollowingStatus Function(
      Manga args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as FollowingStatusProvider;

        final argument = provider.argument as Manga;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<bool> Function(Ref ref, FollowingStatus notifier, Manga argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as FollowingStatusProvider;

        final argument = provider.argument as Manga;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$FollowingStatus extends $AsyncNotifier<bool> {
  late final _$args = ref.$arg as Manga;
  Manga get manga => _$args;

  FutureOr<bool> build(
    Manga manga,
  );
  @$internal
  @override
  FutureOr<bool> runBuild() => build(
        _$args,
      );
}

@ProviderFor(MangaDexHistory)
const mangaDexHistoryProvider = MangaDexHistoryProvider._();

final class MangaDexHistoryProvider
    extends $AsyncNotifierProvider<MangaDexHistory, Queue<Chapter>> {
  const MangaDexHistoryProvider._(
      {super.runNotifierBuildOverride, MangaDexHistory Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'mangaDexHistoryProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final MangaDexHistory Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$mangaDexHistoryHash();

  @$internal
  @override
  MangaDexHistory create() => _createCb?.call() ?? MangaDexHistory();

  @$internal
  @override
  MangaDexHistoryProvider $copyWithCreate(
    MangaDexHistory Function() create,
  ) {
    return MangaDexHistoryProvider._(create: create);
  }

  @$internal
  @override
  MangaDexHistoryProvider $copyWithBuild(
    FutureOr<Queue<Chapter>> Function(
      Ref,
      MangaDexHistory,
    ) build,
  ) {
    return MangaDexHistoryProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<MangaDexHistory, Queue<Chapter>> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);
}

String _$mangaDexHistoryHash() => r'9247a4447ae06ae9da1a0b34220597f9a6c2119a';

abstract class _$MangaDexHistory extends $AsyncNotifier<Queue<Chapter>> {
  FutureOr<Queue<Chapter>> build();
  @$internal
  @override
  FutureOr<Queue<Chapter>> runBuild() => build();
}

@ProviderFor(LoggedUser)
const loggedUserProvider = LoggedUserProvider._();

final class LoggedUserProvider
    extends $AsyncNotifierProvider<LoggedUser, User?> {
  const LoggedUserProvider._(
      {super.runNotifierBuildOverride, LoggedUser Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'loggedUserProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final LoggedUser Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$loggedUserHash();

  @$internal
  @override
  LoggedUser create() => _createCb?.call() ?? LoggedUser();

  @$internal
  @override
  LoggedUserProvider $copyWithCreate(
    LoggedUser Function() create,
  ) {
    return LoggedUserProvider._(create: create);
  }

  @$internal
  @override
  LoggedUserProvider $copyWithBuild(
    FutureOr<User?> Function(
      Ref,
      LoggedUser,
    ) build,
  ) {
    return LoggedUserProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<LoggedUser, User?> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);
}

String _$loggedUserHash() => r'7dddf3c59cd6a5ec70c235eafb8e4873d51c1dfb';

abstract class _$LoggedUser extends $AsyncNotifier<User?> {
  FutureOr<User?> build();
  @$internal
  @override
  FutureOr<User?> runBuild() => build();
}

@ProviderFor(AuthControl)
const authControlProvider = AuthControlProvider._();

final class AuthControlProvider
    extends $AsyncNotifierProvider<AuthControl, bool> {
  const AuthControlProvider._(
      {super.runNotifierBuildOverride, AuthControl Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'authControlProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final AuthControl Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$authControlHash();

  @$internal
  @override
  AuthControl create() => _createCb?.call() ?? AuthControl();

  @$internal
  @override
  AuthControlProvider $copyWithCreate(
    AuthControl Function() create,
  ) {
    return AuthControlProvider._(create: create);
  }

  @$internal
  @override
  AuthControlProvider $copyWithBuild(
    FutureOr<bool> Function(
      Ref,
      AuthControl,
    ) build,
  ) {
    return AuthControlProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<AuthControl, bool> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);
}

String _$authControlHash() => r'86cd3b7ddaff466942c653fbcbb2485ef7bda871';

abstract class _$AuthControl extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$internal
  @override
  FutureOr<bool> runBuild() => build();
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
