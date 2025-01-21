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

String _$recentlyAddedHash() => r'27e386fd5c62ca2d639a07aaa892a4ebf9343e2a';

abstract class _$RecentlyAdded extends $AsyncNotifier<List<Manga>> {
  FutureOr<List<Manga>> build();
  @$internal
  @override
  FutureOr<List<Manga>> runBuild() => build();
}

@ProviderFor(LatestChaptersFeed)
const latestChaptersFeedProvider = LatestChaptersFeedFamily._();

final class LatestChaptersFeedProvider
    extends $AsyncNotifierProvider<LatestChaptersFeed, List<Chapter>> {
  const LatestChaptersFeedProvider._(
      {required LatestChaptersFeedFamily super.from,
      required String? super.argument,
      super.runNotifierBuildOverride,
      LatestChaptersFeed Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'latestChaptersFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final LatestChaptersFeed Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$latestChaptersFeedHash();

  @override
  String toString() {
    return r'latestChaptersFeedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LatestChaptersFeed create() => _createCb?.call() ?? LatestChaptersFeed();

  @$internal
  @override
  LatestChaptersFeedProvider $copyWithCreate(
    LatestChaptersFeed Function() create,
  ) {
    return LatestChaptersFeedProvider._(
        argument: argument as String?,
        from: from! as LatestChaptersFeedFamily,
        create: create);
  }

  @$internal
  @override
  LatestChaptersFeedProvider $copyWithBuild(
    FutureOr<List<Chapter>> Function(
      Ref,
      LatestChaptersFeed,
    ) build,
  ) {
    return LatestChaptersFeedProvider._(
        argument: argument as String?,
        from: from! as LatestChaptersFeedFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<LatestChaptersFeed, List<Chapter>>
      $createElement($ProviderPointer pointer) =>
          $AsyncNotifierProviderElement(this, pointer);

  @override
  bool operator ==(Object other) {
    return other is LatestChaptersFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$latestChaptersFeedHash() =>
    r'fd662e51c46a01297dce5ac36d2737104bb45828';

final class LatestChaptersFeedFamily extends Family {
  const LatestChaptersFeedFamily._()
      : super(
          retry: null,
          name: r'latestChaptersFeedProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  LatestChaptersFeedProvider call(
    String? userId,
  ) =>
      LatestChaptersFeedProvider._(argument: userId, from: this);

  @override
  String debugGetCreateSourceHash() => _$latestChaptersFeedHash();

  @override
  String toString() => r'latestChaptersFeedProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    LatestChaptersFeed Function(
      String? args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as LatestChaptersFeedProvider;

        final argument = provider.argument as String?;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<List<Chapter>> Function(
            Ref ref, LatestChaptersFeed notifier, String? argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as LatestChaptersFeedProvider;

        final argument = provider.argument as String?;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$LatestChaptersFeed extends $AsyncNotifier<List<Chapter>> {
  late final _$args = ref.$arg as String?;
  String? get userId => _$args;

  FutureOr<List<Chapter>> build(
    String? userId,
  );
  @$internal
  @override
  FutureOr<List<Chapter>> runBuild() => build(
        _$args,
      );
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

String _$latestGlobalFeedHash() => r'5e07a6116979b2e033a0d06e08ded8d9e8e04370';

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

String _$groupFeedHash() => r'cb2bfae2514fa1384502fbeebcd2a026c38310ef';

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

String _$groupTitlesHash() => r'f0d58ebd46a2f57e40c074ad4f6362a65960ac54';

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

String _$creatorTitlesHash() => r'04f86fc79ac915e62499cafc32a17ebc70e65f9c';

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

String _$mangaChaptersHash() => r'937ff5111f655411183679c912cd114b32da1e76';

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

String _$mangaCoversHash() => r'51b81d104906d3631b8b252d19e145e0c6101e94';

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
const readChaptersProvider = ReadChaptersFamily._();

final class ReadChaptersProvider
    extends $AsyncNotifierProvider<ReadChapters, ReadChaptersMap> {
  const ReadChaptersProvider._(
      {required ReadChaptersFamily super.from,
      required String? super.argument,
      super.runNotifierBuildOverride,
      ReadChapters Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'readChaptersProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final ReadChapters Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$readChaptersHash();

  @override
  String toString() {
    return r'readChaptersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ReadChapters create() => _createCb?.call() ?? ReadChapters();

  @$internal
  @override
  ReadChaptersProvider $copyWithCreate(
    ReadChapters Function() create,
  ) {
    return ReadChaptersProvider._(
        argument: argument as String?,
        from: from! as ReadChaptersFamily,
        create: create);
  }

  @$internal
  @override
  ReadChaptersProvider $copyWithBuild(
    FutureOr<ReadChaptersMap> Function(
      Ref,
      ReadChapters,
    ) build,
  ) {
    return ReadChaptersProvider._(
        argument: argument as String?,
        from: from! as ReadChaptersFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$ReadChaptersElement $createElement($ProviderPointer pointer) =>
      _$ReadChaptersElement(this, pointer);

  ProviderListenable<ReadChapters$Get> get get =>
      $LazyProxyListenable<ReadChapters$Get, AsyncValue<ReadChaptersMap>>(
        this,
        (element) {
          element as _$ReadChaptersElement;

          return element._$get;
        },
      );

  ProviderListenable<ReadChapters$Set> get set =>
      $LazyProxyListenable<ReadChapters$Set, AsyncValue<ReadChaptersMap>>(
        this,
        (element) {
          element as _$ReadChaptersElement;

          return element._$set;
        },
      );

  @override
  bool operator ==(Object other) {
    return other is ReadChaptersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$readChaptersHash() => r'7416db2f44cce3d1dc05701ba1b1d8034cdcc3ce';

final class ReadChaptersFamily extends Family {
  const ReadChaptersFamily._()
      : super(
          retry: null,
          name: r'readChaptersProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  ReadChaptersProvider call(
    String? userId,
  ) =>
      ReadChaptersProvider._(argument: userId, from: this);

  @override
  String debugGetCreateSourceHash() => _$readChaptersHash();

  @override
  String toString() => r'readChaptersProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    ReadChapters Function(
      String? args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as ReadChaptersProvider;

        final argument = provider.argument as String?;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<ReadChaptersMap> Function(
            Ref ref, ReadChapters notifier, String? argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as ReadChaptersProvider;

        final argument = provider.argument as String?;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$ReadChapters extends $AsyncNotifier<ReadChaptersMap> {
  late final _$args = ref.$arg as String?;
  String? get userId => _$args;

  FutureOr<ReadChaptersMap> build(
    String? userId,
  );
  @$internal
  @override
  FutureOr<ReadChaptersMap> runBuild() => build(
        _$args,
      );
}

class _$ReadChaptersElement
    extends $AsyncNotifierProviderElement<ReadChapters, ReadChaptersMap> {
  _$ReadChaptersElement(super.provider, super.pointer) {
    _$get.result = $Result.data(_$ReadChapters$Get(this));
    _$set.result = $Result.data(_$ReadChapters$Set(this));
  }
  final _$get = $ElementLense<_$ReadChapters$Get>();
  final _$set = $ElementLense<_$ReadChapters$Set>();
  @override
  void mount() {
    super.mount();
    _$get.result!.stateOrNull!.reset();
    _$set.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$get);
    listenableVisitor(_$set);
  }
}

sealed class ReadChapters$Get extends MutationBase<ReadChaptersMap> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [ReadChapters.get] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<ReadChaptersMap> call(Iterable<Manga> mangas);
}

final class _$ReadChapters$Get extends $AsyncMutationBase<ReadChaptersMap,
    _$ReadChapters$Get, ReadChapters> implements ReadChapters$Get {
  _$ReadChapters$Get(this.element, {super.state, super.key});

  @override
  final _$ReadChaptersElement element;

  @override
  $ElementLense<_$ReadChapters$Get> get listenable => element._$get;

  @override
  Future<ReadChaptersMap> call(Iterable<Manga> mangas) {
    return mutateAsync(
      Invocation.method(
        #get,
        [mangas],
      ),
      ($notifier) => $notifier.get(
        mangas,
      ),
    );
  }

  @override
  _$ReadChapters$Get copyWith(MutationState<ReadChaptersMap> state,
          {Object? key}) =>
      _$ReadChapters$Get(element, state: state, key: key);
}

sealed class ReadChapters$Set extends MutationBase<ReadChaptersMap> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [ReadChapters.set] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<ReadChaptersMap> call(Manga manga,
      {Iterable<Chapter>? read, Iterable<Chapter>? unread});
}

final class _$ReadChapters$Set extends $AsyncMutationBase<ReadChaptersMap,
    _$ReadChapters$Set, ReadChapters> implements ReadChapters$Set {
  _$ReadChapters$Set(this.element, {super.state, super.key});

  @override
  final _$ReadChaptersElement element;

  @override
  $ElementLense<_$ReadChapters$Set> get listenable => element._$set;

  @override
  Future<ReadChaptersMap> call(Manga manga,
      {Iterable<Chapter>? read, Iterable<Chapter>? unread}) {
    return mutateAsync(
      Invocation.method(#set, [manga], {#read: read, #unread: unread}),
      ($notifier) => $notifier.set(
        manga,
        read: read,
        unread: unread,
      ),
    );
  }

  @override
  _$ReadChapters$Set copyWith(MutationState<ReadChaptersMap> state,
          {Object? key}) =>
      _$ReadChapters$Set(element, state: state, key: key);
}

@ProviderFor(UserLibrary)
const userLibraryProvider = UserLibraryFamily._();

final class UserLibraryProvider extends $AsyncNotifierProvider<UserLibrary,
    Map<String, MangaReadingStatus>> {
  const UserLibraryProvider._(
      {required UserLibraryFamily super.from,
      required String? super.argument,
      super.runNotifierBuildOverride,
      UserLibrary Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'userLibraryProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final UserLibrary Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$userLibraryHash();

  @override
  String toString() {
    return r'userLibraryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserLibrary create() => _createCb?.call() ?? UserLibrary();

  @$internal
  @override
  UserLibraryProvider $copyWithCreate(
    UserLibrary Function() create,
  ) {
    return UserLibraryProvider._(
        argument: argument as String?,
        from: from! as UserLibraryFamily,
        create: create);
  }

  @$internal
  @override
  UserLibraryProvider $copyWithBuild(
    FutureOr<Map<String, MangaReadingStatus>> Function(
      Ref,
      UserLibrary,
    ) build,
  ) {
    return UserLibraryProvider._(
        argument: argument as String?,
        from: from! as UserLibraryFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$UserLibraryElement $createElement($ProviderPointer pointer) =>
      _$UserLibraryElement(this, pointer);

  ProviderListenable<UserLibrary$Set> get set => $LazyProxyListenable<
          UserLibrary$Set, AsyncValue<Map<String, MangaReadingStatus>>>(
        this,
        (element) {
          element as _$UserLibraryElement;

          return element._$set;
        },
      );

  @override
  bool operator ==(Object other) {
    return other is UserLibraryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userLibraryHash() => r'73aa98bfcf1e7771677589d4ff0328d32e358694';

final class UserLibraryFamily extends Family {
  const UserLibraryFamily._()
      : super(
          retry: null,
          name: r'userLibraryProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserLibraryProvider call(
    String? userId,
  ) =>
      UserLibraryProvider._(argument: userId, from: this);

  @override
  String debugGetCreateSourceHash() => _$userLibraryHash();

  @override
  String toString() => r'userLibraryProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    UserLibrary Function(
      String? args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as UserLibraryProvider;

        final argument = provider.argument as String?;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<Map<String, MangaReadingStatus>> Function(
            Ref ref, UserLibrary notifier, String? argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as UserLibraryProvider;

        final argument = provider.argument as String?;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$UserLibrary
    extends $AsyncNotifier<Map<String, MangaReadingStatus>> {
  late final _$args = ref.$arg as String?;
  String? get userId => _$args;

  FutureOr<Map<String, MangaReadingStatus>> build(
    String? userId,
  );
  @$internal
  @override
  FutureOr<Map<String, MangaReadingStatus>> runBuild() => build(
        _$args,
      );
}

class _$UserLibraryElement extends $AsyncNotifierProviderElement<UserLibrary,
    Map<String, MangaReadingStatus>> {
  _$UserLibraryElement(super.provider, super.pointer) {
    _$set.result = $Result.data(_$UserLibrary$Set(this));
  }
  final _$set = $ElementLense<_$UserLibrary$Set>();
  @override
  void mount() {
    super.mount();
    _$set.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$set);
  }
}

sealed class UserLibrary$Set
    extends MutationBase<Map<String, MangaReadingStatus>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [UserLibrary.set] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, MangaReadingStatus>> call(
      Manga manga, MangaReadingStatus? status);
}

final class _$UserLibrary$Set extends $AsyncMutationBase<
    Map<String, MangaReadingStatus>,
    _$UserLibrary$Set,
    UserLibrary> implements UserLibrary$Set {
  _$UserLibrary$Set(this.element, {super.state, super.key});

  @override
  final _$UserLibraryElement element;

  @override
  $ElementLense<_$UserLibrary$Set> get listenable => element._$set;

  @override
  Future<Map<String, MangaReadingStatus>> call(
      Manga manga, MangaReadingStatus? status) {
    return mutateAsync(
      Invocation.method(
        #set,
        [manga, status],
      ),
      ($notifier) => $notifier.set(
        manga,
        status,
      ),
    );
  }

  @override
  _$UserLibrary$Set copyWith(
          MutationState<Map<String, MangaReadingStatus>> state,
          {Object? key}) =>
      _$UserLibrary$Set(element, state: state, key: key);
}

@ProviderFor(UserLists)
const userListsProvider = UserListsFamily._();

final class UserListsProvider
    extends $AsyncNotifierProvider<UserLists, List<CustomList>> {
  const UserListsProvider._(
      {required UserListsFamily super.from,
      required String? super.argument,
      super.runNotifierBuildOverride,
      UserLists Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'userListsProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final UserLists Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$userListsHash();

  @override
  String toString() {
    return r'userListsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserLists create() => _createCb?.call() ?? UserLists();

  @$internal
  @override
  UserListsProvider $copyWithCreate(
    UserLists Function() create,
  ) {
    return UserListsProvider._(
        argument: argument as String?,
        from: from! as UserListsFamily,
        create: create);
  }

  @$internal
  @override
  UserListsProvider $copyWithBuild(
    FutureOr<List<CustomList>> Function(
      Ref,
      UserLists,
    ) build,
  ) {
    return UserListsProvider._(
        argument: argument as String?,
        from: from! as UserListsFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$UserListsElement $createElement($ProviderPointer pointer) =>
      _$UserListsElement(this, pointer);

  ProviderListenable<UserLists$UpdateList> get updateList =>
      $LazyProxyListenable<UserLists$UpdateList, AsyncValue<List<CustomList>>>(
        this,
        (element) {
          element as _$UserListsElement;

          return element._$updateList;
        },
      );

  ProviderListenable<UserLists$EditList> get editList =>
      $LazyProxyListenable<UserLists$EditList, AsyncValue<List<CustomList>>>(
        this,
        (element) {
          element as _$UserListsElement;

          return element._$editList;
        },
      );

  ProviderListenable<UserLists$DeleteList> get deleteList =>
      $LazyProxyListenable<UserLists$DeleteList, AsyncValue<List<CustomList>>>(
        this,
        (element) {
          element as _$UserListsElement;

          return element._$deleteList;
        },
      );

  ProviderListenable<UserLists$NewList> get newList =>
      $LazyProxyListenable<UserLists$NewList, AsyncValue<List<CustomList>>>(
        this,
        (element) {
          element as _$UserListsElement;

          return element._$newList;
        },
      );

  @override
  bool operator ==(Object other) {
    return other is UserListsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userListsHash() => r'23724a91c07593227bf8113bd2afac58475d0cf2';

final class UserListsFamily extends Family {
  const UserListsFamily._()
      : super(
          retry: null,
          name: r'userListsProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserListsProvider call(
    String? userId,
  ) =>
      UserListsProvider._(argument: userId, from: this);

  @override
  String debugGetCreateSourceHash() => _$userListsHash();

  @override
  String toString() => r'userListsProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    UserLists Function(
      String? args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as UserListsProvider;

        final argument = provider.argument as String?;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<List<CustomList>> Function(
            Ref ref, UserLists notifier, String? argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as UserListsProvider;

        final argument = provider.argument as String?;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$UserLists extends $AsyncNotifier<List<CustomList>> {
  late final _$args = ref.$arg as String?;
  String? get userId => _$args;

  FutureOr<List<CustomList>> build(
    String? userId,
  );
  @$internal
  @override
  FutureOr<List<CustomList>> runBuild() => build(
        _$args,
      );
}

class _$UserListsElement
    extends $AsyncNotifierProviderElement<UserLists, List<CustomList>> {
  _$UserListsElement(super.provider, super.pointer) {
    _$updateList.result = $Result.data(_$UserLists$UpdateList(this));
    _$editList.result = $Result.data(_$UserLists$EditList(this));
    _$deleteList.result = $Result.data(_$UserLists$DeleteList(this));
    _$newList.result = $Result.data(_$UserLists$NewList(this));
  }
  final _$updateList = $ElementLense<_$UserLists$UpdateList>();
  final _$editList = $ElementLense<_$UserLists$EditList>();
  final _$deleteList = $ElementLense<_$UserLists$DeleteList>();
  final _$newList = $ElementLense<_$UserLists$NewList>();
  @override
  void mount() {
    super.mount();
    _$updateList.result!.stateOrNull!.reset();
    _$editList.result!.stateOrNull!.reset();
    _$deleteList.result!.stateOrNull!.reset();
    _$newList.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$updateList);
    listenableVisitor(_$editList);
    listenableVisitor(_$deleteList);
    listenableVisitor(_$newList);
  }
}

sealed class UserLists$UpdateList extends MutationBase<List<CustomList>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [UserLists.updateList] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<List<CustomList>> call(CustomList list, Manga manga, bool add);
}

final class _$UserLists$UpdateList extends $AsyncMutationBase<List<CustomList>,
    _$UserLists$UpdateList, UserLists> implements UserLists$UpdateList {
  _$UserLists$UpdateList(this.element, {super.state, super.key});

  @override
  final _$UserListsElement element;

  @override
  $ElementLense<_$UserLists$UpdateList> get listenable => element._$updateList;

  @override
  Future<List<CustomList>> call(CustomList list, Manga manga, bool add) {
    return mutateAsync(
      Invocation.method(
        #updateList,
        [list, manga, add],
      ),
      ($notifier) => $notifier.updateList(
        list,
        manga,
        add,
      ),
    );
  }

  @override
  _$UserLists$UpdateList copyWith(MutationState<List<CustomList>> state,
          {Object? key}) =>
      _$UserLists$UpdateList(element, state: state, key: key);
}

sealed class UserLists$EditList extends MutationBase<List<CustomList>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [UserLists.editList] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<List<CustomList>> call(CustomList list, String name,
      CustomListVisibility visibility, Iterable<String> mangaIds);
}

final class _$UserLists$EditList extends $AsyncMutationBase<List<CustomList>,
    _$UserLists$EditList, UserLists> implements UserLists$EditList {
  _$UserLists$EditList(this.element, {super.state, super.key});

  @override
  final _$UserListsElement element;

  @override
  $ElementLense<_$UserLists$EditList> get listenable => element._$editList;

  @override
  Future<List<CustomList>> call(CustomList list, String name,
      CustomListVisibility visibility, Iterable<String> mangaIds) {
    return mutateAsync(
      Invocation.method(
        #editList,
        [list, name, visibility, mangaIds],
      ),
      ($notifier) => $notifier.editList(
        list,
        name,
        visibility,
        mangaIds,
      ),
    );
  }

  @override
  _$UserLists$EditList copyWith(MutationState<List<CustomList>> state,
          {Object? key}) =>
      _$UserLists$EditList(element, state: state, key: key);
}

sealed class UserLists$DeleteList extends MutationBase<List<CustomList>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [UserLists.deleteList] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<List<CustomList>> call(CustomList list);
}

final class _$UserLists$DeleteList extends $AsyncMutationBase<List<CustomList>,
    _$UserLists$DeleteList, UserLists> implements UserLists$DeleteList {
  _$UserLists$DeleteList(this.element, {super.state, super.key});

  @override
  final _$UserListsElement element;

  @override
  $ElementLense<_$UserLists$DeleteList> get listenable => element._$deleteList;

  @override
  Future<List<CustomList>> call(CustomList list) {
    return mutateAsync(
      Invocation.method(
        #deleteList,
        [list],
      ),
      ($notifier) => $notifier.deleteList(
        list,
      ),
    );
  }

  @override
  _$UserLists$DeleteList copyWith(MutationState<List<CustomList>> state,
          {Object? key}) =>
      _$UserLists$DeleteList(element, state: state, key: key);
}

sealed class UserLists$NewList extends MutationBase<List<CustomList>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [UserLists.newList] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<List<CustomList>> call(
      String name, CustomListVisibility visibility, Iterable<String> mangaIds);
}

final class _$UserLists$NewList
    extends $AsyncMutationBase<List<CustomList>, _$UserLists$NewList, UserLists>
    implements UserLists$NewList {
  _$UserLists$NewList(this.element, {super.state, super.key});

  @override
  final _$UserListsElement element;

  @override
  $ElementLense<_$UserLists$NewList> get listenable => element._$newList;

  @override
  Future<List<CustomList>> call(
      String name, CustomListVisibility visibility, Iterable<String> mangaIds) {
    return mutateAsync(
      Invocation.method(
        #newList,
        [name, visibility, mangaIds],
      ),
      ($notifier) => $notifier.newList(
        name,
        visibility,
        mangaIds,
      ),
    );
  }

  @override
  _$UserLists$NewList copyWith(MutationState<List<CustomList>> state,
          {Object? key}) =>
      _$UserLists$NewList(element, state: state, key: key);
}

@ProviderFor(FollowedLists)
const followedListsProvider = FollowedListsFamily._();

final class FollowedListsProvider
    extends $AsyncNotifierProvider<FollowedLists, List<CustomList>> {
  const FollowedListsProvider._(
      {required FollowedListsFamily super.from,
      required String? super.argument,
      super.runNotifierBuildOverride,
      FollowedLists Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'followedListsProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FollowedLists Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$followedListsHash();

  @override
  String toString() {
    return r'followedListsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FollowedLists create() => _createCb?.call() ?? FollowedLists();

  @$internal
  @override
  FollowedListsProvider $copyWithCreate(
    FollowedLists Function() create,
  ) {
    return FollowedListsProvider._(
        argument: argument as String?,
        from: from! as FollowedListsFamily,
        create: create);
  }

  @$internal
  @override
  FollowedListsProvider $copyWithBuild(
    FutureOr<List<CustomList>> Function(
      Ref,
      FollowedLists,
    ) build,
  ) {
    return FollowedListsProvider._(
        argument: argument as String?,
        from: from! as FollowedListsFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$FollowedListsElement $createElement($ProviderPointer pointer) =>
      _$FollowedListsElement(this, pointer);

  ProviderListenable<FollowedLists$SetFollow> get setFollow =>
      $LazyProxyListenable<FollowedLists$SetFollow,
          AsyncValue<List<CustomList>>>(
        this,
        (element) {
          element as _$FollowedListsElement;

          return element._$setFollow;
        },
      );

  @override
  bool operator ==(Object other) {
    return other is FollowedListsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$followedListsHash() => r'770c515c15f79c49085a0a21ff96d5cd9e15314d';

final class FollowedListsFamily extends Family {
  const FollowedListsFamily._()
      : super(
          retry: null,
          name: r'followedListsProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FollowedListsProvider call(
    String? userId,
  ) =>
      FollowedListsProvider._(argument: userId, from: this);

  @override
  String debugGetCreateSourceHash() => _$followedListsHash();

  @override
  String toString() => r'followedListsProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FollowedLists Function(
      String? args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as FollowedListsProvider;

        final argument = provider.argument as String?;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<List<CustomList>> Function(
            Ref ref, FollowedLists notifier, String? argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as FollowedListsProvider;

        final argument = provider.argument as String?;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$FollowedLists extends $AsyncNotifier<List<CustomList>> {
  late final _$args = ref.$arg as String?;
  String? get userId => _$args;

  FutureOr<List<CustomList>> build(
    String? userId,
  );
  @$internal
  @override
  FutureOr<List<CustomList>> runBuild() => build(
        _$args,
      );
}

class _$FollowedListsElement
    extends $AsyncNotifierProviderElement<FollowedLists, List<CustomList>> {
  _$FollowedListsElement(super.provider, super.pointer) {
    _$setFollow.result = $Result.data(_$FollowedLists$SetFollow(this));
  }
  final _$setFollow = $ElementLense<_$FollowedLists$SetFollow>();
  @override
  void mount() {
    super.mount();
    _$setFollow.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$setFollow);
  }
}

sealed class FollowedLists$SetFollow extends MutationBase<List<CustomList>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [FollowedLists.setFollow] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<List<CustomList>> call(CustomList list, bool follow);
}

final class _$FollowedLists$SetFollow extends $AsyncMutationBase<
    List<CustomList>,
    _$FollowedLists$SetFollow,
    FollowedLists> implements FollowedLists$SetFollow {
  _$FollowedLists$SetFollow(this.element, {super.state, super.key});

  @override
  final _$FollowedListsElement element;

  @override
  $ElementLense<_$FollowedLists$SetFollow> get listenable =>
      element._$setFollow;

  @override
  Future<List<CustomList>> call(CustomList list, bool follow) {
    return mutateAsync(
      Invocation.method(
        #setFollow,
        [list, follow],
      ),
      ($notifier) => $notifier.setFollow(
        list,
        follow,
      ),
    );
  }

  @override
  _$FollowedLists$SetFollow copyWith(MutationState<List<CustomList>> state,
          {Object? key}) =>
      _$FollowedLists$SetFollow(element, state: state, key: key);
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

String _$customListFeedHash() => r'21e3e77eac362ecc6a00d0eef1f30b911f24067c';

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
    r'5cff2b1fd8df8e4d433bbfe96e94fd58e3ceaa36';

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
  _$PersistentMangaListPaginatorElement $createElement(
          $ProviderPointer pointer) =>
      _$PersistentMangaListPaginatorElement(this, pointer);

  ProviderListenable<PersistentMangaListPaginator$GetPage> get getPage =>
      $LazyProxyListenable<PersistentMangaListPaginator$GetPage,
          AsyncValue<List<Manga>>>(
        this,
        (element) {
          element as _$PersistentMangaListPaginatorElement;

          return element._$getPage;
        },
      );

  ProviderListenable<PersistentMangaListPaginator$UpdateList> get updateList =>
      $LazyProxyListenable<PersistentMangaListPaginator$UpdateList,
          AsyncValue<List<Manga>>>(
        this,
        (element) {
          element as _$PersistentMangaListPaginatorElement;

          return element._$updateList;
        },
      );

  ProviderListenable<PersistentMangaListPaginator$UpdateListPage>
      get updateListPage => $LazyProxyListenable<
              PersistentMangaListPaginator$UpdateListPage,
              AsyncValue<List<Manga>>>(
            this,
            (element) {
              element as _$PersistentMangaListPaginatorElement;

              return element._$updateListPage;
            },
          );

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
    r'6cbdfac489e89a7daab01cdd47884874d4414bd7';

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

class _$PersistentMangaListPaginatorElement
    extends $AsyncNotifierProviderElement<PersistentMangaListPaginator,
        List<Manga>> {
  _$PersistentMangaListPaginatorElement(super.provider, super.pointer) {
    _$getPage.result =
        $Result.data(_$PersistentMangaListPaginator$GetPage(this));
    _$updateList.result =
        $Result.data(_$PersistentMangaListPaginator$UpdateList(this));
    _$updateListPage.result =
        $Result.data(_$PersistentMangaListPaginator$UpdateListPage(this));
  }
  final _$getPage = $ElementLense<_$PersistentMangaListPaginator$GetPage>();
  final _$updateList =
      $ElementLense<_$PersistentMangaListPaginator$UpdateList>();
  final _$updateListPage =
      $ElementLense<_$PersistentMangaListPaginator$UpdateListPage>();
  @override
  void mount() {
    super.mount();
    _$getPage.result!.stateOrNull!.reset();
    _$updateList.result!.stateOrNull!.reset();
    _$updateListPage.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$getPage);
    listenableVisitor(_$updateList);
    listenableVisitor(_$updateListPage);
  }
}

sealed class PersistentMangaListPaginator$GetPage
    extends MutationBase<List<Manga>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [PersistentMangaListPaginator.getPage] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<List<Manga>> call(int page);
}

final class _$PersistentMangaListPaginator$GetPage extends $AsyncMutationBase<
        List<Manga>,
        _$PersistentMangaListPaginator$GetPage,
        PersistentMangaListPaginator>
    implements PersistentMangaListPaginator$GetPage {
  _$PersistentMangaListPaginator$GetPage(this.element,
      {super.state, super.key});

  @override
  final _$PersistentMangaListPaginatorElement element;

  @override
  $ElementLense<_$PersistentMangaListPaginator$GetPage> get listenable =>
      element._$getPage;

  @override
  Future<List<Manga>> call(int page) {
    return mutateAsync(
      Invocation.method(
        #getPage,
        [page],
      ),
      ($notifier) => $notifier.getPage(
        page,
      ),
    );
  }

  @override
  _$PersistentMangaListPaginator$GetPage copyWith(
          MutationState<List<Manga>> state,
          {Object? key}) =>
      _$PersistentMangaListPaginator$GetPage(element, state: state, key: key);
}

sealed class PersistentMangaListPaginator$UpdateList
    extends MutationBase<List<Manga>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [PersistentMangaListPaginator.updateList] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<List<Manga>> call(Iterable<String> list);
}

final class _$PersistentMangaListPaginator$UpdateList
    extends $AsyncMutationBase<List<Manga>,
        _$PersistentMangaListPaginator$UpdateList, PersistentMangaListPaginator>
    implements PersistentMangaListPaginator$UpdateList {
  _$PersistentMangaListPaginator$UpdateList(this.element,
      {super.state, super.key});

  @override
  final _$PersistentMangaListPaginatorElement element;

  @override
  $ElementLense<_$PersistentMangaListPaginator$UpdateList> get listenable =>
      element._$updateList;

  @override
  Future<List<Manga>> call(Iterable<String> list) {
    return mutateAsync(
      Invocation.method(
        #updateList,
        [list],
      ),
      ($notifier) => $notifier.updateList(
        list,
      ),
    );
  }

  @override
  _$PersistentMangaListPaginator$UpdateList copyWith(
          MutationState<List<Manga>> state,
          {Object? key}) =>
      _$PersistentMangaListPaginator$UpdateList(element,
          state: state, key: key);
}

sealed class PersistentMangaListPaginator$UpdateListPage
    extends MutationBase<List<Manga>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [PersistentMangaListPaginator.updateListPage] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<List<Manga>> call(Iterable<String> list, int page);
}

final class _$PersistentMangaListPaginator$UpdateListPage
    extends $AsyncMutationBase<
        List<Manga>,
        _$PersistentMangaListPaginator$UpdateListPage,
        PersistentMangaListPaginator>
    implements PersistentMangaListPaginator$UpdateListPage {
  _$PersistentMangaListPaginator$UpdateListPage(this.element,
      {super.state, super.key});

  @override
  final _$PersistentMangaListPaginatorElement element;

  @override
  $ElementLense<_$PersistentMangaListPaginator$UpdateListPage> get listenable =>
      element._$updateListPage;

  @override
  Future<List<Manga>> call(Iterable<String> list, int page) {
    return mutateAsync(
      Invocation.method(
        #updateListPage,
        [list, page],
      ),
      ($notifier) => $notifier.updateListPage(
        list,
        page,
      ),
    );
  }

  @override
  _$PersistentMangaListPaginator$UpdateListPage copyWith(
          MutationState<List<Manga>> state,
          {Object? key}) =>
      _$PersistentMangaListPaginator$UpdateListPage(element,
          state: state, key: key);
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

String _$listSourceHash() => r'24238a33758da64d216549cf99c749434c4a4059';

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

String _$mangaSearchHash() => r'08334a1dc1868a05e8c23e0db4c9ec3d940f932e';

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
  _$StatisticsElement $createElement($ProviderPointer pointer) =>
      _$StatisticsElement(this, pointer);

  ProviderListenable<Statistics$Get> get get => $LazyProxyListenable<
          Statistics$Get, AsyncValue<Map<String, MangaStatistics>>>(
        this,
        (element) {
          element as _$StatisticsElement;

          return element._$get;
        },
      );
}

String _$statisticsHash() => r'1886297bbf3f51e233cbe1b0bb1ace5515b527e5';

abstract class _$Statistics
    extends $AsyncNotifier<Map<String, MangaStatistics>> {
  FutureOr<Map<String, MangaStatistics>> build();
  @$internal
  @override
  FutureOr<Map<String, MangaStatistics>> runBuild() => build();
}

class _$StatisticsElement extends $AsyncNotifierProviderElement<Statistics,
    Map<String, MangaStatistics>> {
  _$StatisticsElement(super.provider, super.pointer) {
    _$get.result = $Result.data(_$Statistics$Get(this));
  }
  final _$get = $ElementLense<_$Statistics$Get>();
  @override
  void mount() {
    super.mount();
    _$get.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$get);
  }
}

sealed class Statistics$Get extends MutationBase<Map<String, MangaStatistics>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [Statistics.get] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, MangaStatistics>> call(Iterable<Manga> mangas);
}

final class _$Statistics$Get extends $AsyncMutationBase<
    Map<String, MangaStatistics>,
    _$Statistics$Get,
    Statistics> implements Statistics$Get {
  _$Statistics$Get(this.element, {super.state, super.key});

  @override
  final _$StatisticsElement element;

  @override
  $ElementLense<_$Statistics$Get> get listenable => element._$get;

  @override
  Future<Map<String, MangaStatistics>> call(Iterable<Manga> mangas) {
    return mutateAsync(
      Invocation.method(
        #get,
        [mangas],
      ),
      ($notifier) => $notifier.get(
        mangas,
      ),
    );
  }

  @override
  _$Statistics$Get copyWith(MutationState<Map<String, MangaStatistics>> state,
          {Object? key}) =>
      _$Statistics$Get(element, state: state, key: key);
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
  _$ChapterStatsElement $createElement($ProviderPointer pointer) =>
      _$ChapterStatsElement(this, pointer);

  ProviderListenable<ChapterStats$Get> get get => $LazyProxyListenable<
          ChapterStats$Get, AsyncValue<Map<String, ChapterStatistics>>>(
        this,
        (element) {
          element as _$ChapterStatsElement;

          return element._$get;
        },
      );
}

String _$chapterStatsHash() => r'df4469b6e66e59997ded830d77e1d0403b1b0b7a';

abstract class _$ChapterStats
    extends $AsyncNotifier<Map<String, ChapterStatistics>> {
  FutureOr<Map<String, ChapterStatistics>> build();
  @$internal
  @override
  FutureOr<Map<String, ChapterStatistics>> runBuild() => build();
}

class _$ChapterStatsElement extends $AsyncNotifierProviderElement<ChapterStats,
    Map<String, ChapterStatistics>> {
  _$ChapterStatsElement(super.provider, super.pointer) {
    _$get.result = $Result.data(_$ChapterStats$Get(this));
  }
  final _$get = $ElementLense<_$ChapterStats$Get>();
  @override
  void mount() {
    super.mount();
    _$get.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$get);
  }
}

sealed class ChapterStats$Get
    extends MutationBase<Map<String, ChapterStatistics>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [ChapterStats.get] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, ChapterStatistics>> call(Iterable<Chapter> chapters);
}

final class _$ChapterStats$Get extends $AsyncMutationBase<
    Map<String, ChapterStatistics>,
    _$ChapterStats$Get,
    ChapterStats> implements ChapterStats$Get {
  _$ChapterStats$Get(this.element, {super.state, super.key});

  @override
  final _$ChapterStatsElement element;

  @override
  $ElementLense<_$ChapterStats$Get> get listenable => element._$get;

  @override
  Future<Map<String, ChapterStatistics>> call(Iterable<Chapter> chapters) {
    return mutateAsync(
      Invocation.method(
        #get,
        [chapters],
      ),
      ($notifier) => $notifier.get(
        chapters,
      ),
    );
  }

  @override
  _$ChapterStats$Get copyWith(
          MutationState<Map<String, ChapterStatistics>> state,
          {Object? key}) =>
      _$ChapterStats$Get(element, state: state, key: key);
}

@ProviderFor(Ratings)
const ratingsProvider = RatingsFamily._();

final class RatingsProvider
    extends $AsyncNotifierProvider<Ratings, Map<String, SelfRating>> {
  const RatingsProvider._(
      {required RatingsFamily super.from,
      required String? super.argument,
      super.runNotifierBuildOverride,
      Ratings Function()? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'ratingsProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final Ratings Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$ratingsHash();

  @override
  String toString() {
    return r'ratingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Ratings create() => _createCb?.call() ?? Ratings();

  @$internal
  @override
  RatingsProvider $copyWithCreate(
    Ratings Function() create,
  ) {
    return RatingsProvider._(
        argument: argument as String?,
        from: from! as RatingsFamily,
        create: create);
  }

  @$internal
  @override
  RatingsProvider $copyWithBuild(
    FutureOr<Map<String, SelfRating>> Function(
      Ref,
      Ratings,
    ) build,
  ) {
    return RatingsProvider._(
        argument: argument as String?,
        from: from! as RatingsFamily,
        runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$RatingsElement $createElement($ProviderPointer pointer) =>
      _$RatingsElement(this, pointer);

  ProviderListenable<Ratings$Get> get get =>
      $LazyProxyListenable<Ratings$Get, AsyncValue<Map<String, SelfRating>>>(
        this,
        (element) {
          element as _$RatingsElement;

          return element._$get;
        },
      );

  ProviderListenable<Ratings$Set> get set =>
      $LazyProxyListenable<Ratings$Set, AsyncValue<Map<String, SelfRating>>>(
        this,
        (element) {
          element as _$RatingsElement;

          return element._$set;
        },
      );

  @override
  bool operator ==(Object other) {
    return other is RatingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ratingsHash() => r'333aad427f970d7826e2c7992af6bf4e035809cf';

final class RatingsFamily extends Family {
  const RatingsFamily._()
      : super(
          retry: null,
          name: r'ratingsProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  RatingsProvider call(
    String? userId,
  ) =>
      RatingsProvider._(argument: userId, from: this);

  @override
  String debugGetCreateSourceHash() => _$ratingsHash();

  @override
  String toString() => r'ratingsProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    Ratings Function(
      String? args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as RatingsProvider;

        final argument = provider.argument as String?;

        return provider
            .$copyWithCreate(() => create(argument))
            .$createElement(pointer);
      },
    );
  }

  /// {@macro riverpod.override_with_build}
  Override overrideWithBuild(
    FutureOr<Map<String, SelfRating>> Function(
            Ref ref, Ratings notifier, String? argument)
        build,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as RatingsProvider;

        final argument = provider.argument as String?;

        return provider
            .$copyWithBuild((ref, notifier) => build(ref, notifier, argument))
            .$createElement(pointer);
      },
    );
  }
}

abstract class _$Ratings extends $AsyncNotifier<Map<String, SelfRating>> {
  late final _$args = ref.$arg as String?;
  String? get userId => _$args;

  FutureOr<Map<String, SelfRating>> build(
    String? userId,
  );
  @$internal
  @override
  FutureOr<Map<String, SelfRating>> runBuild() => build(
        _$args,
      );
}

class _$RatingsElement
    extends $AsyncNotifierProviderElement<Ratings, Map<String, SelfRating>> {
  _$RatingsElement(super.provider, super.pointer) {
    _$get.result = $Result.data(_$Ratings$Get(this));
    _$set.result = $Result.data(_$Ratings$Set(this));
  }
  final _$get = $ElementLense<_$Ratings$Get>();
  final _$set = $ElementLense<_$Ratings$Set>();
  @override
  void mount() {
    super.mount();
    _$get.result!.stateOrNull!.reset();
    _$set.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$get);
    listenableVisitor(_$set);
  }
}

sealed class Ratings$Get extends MutationBase<Map<String, SelfRating>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [Ratings.get] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, SelfRating>> call(Iterable<Manga> mangas);
}

final class _$Ratings$Get
    extends $AsyncMutationBase<Map<String, SelfRating>, _$Ratings$Get, Ratings>
    implements Ratings$Get {
  _$Ratings$Get(this.element, {super.state, super.key});

  @override
  final _$RatingsElement element;

  @override
  $ElementLense<_$Ratings$Get> get listenable => element._$get;

  @override
  Future<Map<String, SelfRating>> call(Iterable<Manga> mangas) {
    return mutateAsync(
      Invocation.method(
        #get,
        [mangas],
      ),
      ($notifier) => $notifier.get(
        mangas,
      ),
    );
  }

  @override
  _$Ratings$Get copyWith(MutationState<Map<String, SelfRating>> state,
          {Object? key}) =>
      _$Ratings$Get(element, state: state, key: key);
}

sealed class Ratings$Set extends MutationBase<Map<String, SelfRating>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [Ratings.set] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, SelfRating>> call(Manga manga, int? rating);
}

final class _$Ratings$Set
    extends $AsyncMutationBase<Map<String, SelfRating>, _$Ratings$Set, Ratings>
    implements Ratings$Set {
  _$Ratings$Set(this.element, {super.state, super.key});

  @override
  final _$RatingsElement element;

  @override
  $ElementLense<_$Ratings$Set> get listenable => element._$set;

  @override
  Future<Map<String, SelfRating>> call(Manga manga, int? rating) {
    return mutateAsync(
      Invocation.method(
        #set,
        [manga, rating],
      ),
      ($notifier) => $notifier.set(
        manga,
        rating,
      ),
    );
  }

  @override
  _$Ratings$Set copyWith(MutationState<Map<String, SelfRating>> state,
          {Object? key}) =>
      _$Ratings$Set(element, state: state, key: key);
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
  _$ReadingStatusElement $createElement($ProviderPointer pointer) =>
      _$ReadingStatusElement(this, pointer);

  ProviderListenable<ReadingStatus$Set> get set =>
      $LazyProxyListenable<ReadingStatus$Set, AsyncValue<MangaReadingStatus?>>(
        this,
        (element) {
          element as _$ReadingStatusElement;

          return element._$set;
        },
      );

  @override
  bool operator ==(Object other) {
    return other is ReadingStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$readingStatusHash() => r'2b8c21d37a1b7be01aca10b130cb1f2bf57539fc';

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

class _$ReadingStatusElement
    extends $AsyncNotifierProviderElement<ReadingStatus, MangaReadingStatus?> {
  _$ReadingStatusElement(super.provider, super.pointer) {
    _$set.result = $Result.data(_$ReadingStatus$Set(this));
  }
  final _$set = $ElementLense<_$ReadingStatus$Set>();
  @override
  void mount() {
    super.mount();
    _$set.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$set);
  }
}

sealed class ReadingStatus$Set extends MutationBase<MangaReadingStatus?> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [ReadingStatus.set] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<MangaReadingStatus?> call(MangaReadingStatus? status);
}

final class _$ReadingStatus$Set extends $AsyncMutationBase<MangaReadingStatus?,
    _$ReadingStatus$Set, ReadingStatus> implements ReadingStatus$Set {
  _$ReadingStatus$Set(this.element, {super.state, super.key});

  @override
  final _$ReadingStatusElement element;

  @override
  $ElementLense<_$ReadingStatus$Set> get listenable => element._$set;

  @override
  Future<MangaReadingStatus?> call(MangaReadingStatus? status) {
    return mutateAsync(
      Invocation.method(
        #set,
        [status],
      ),
      ($notifier) => $notifier.set(
        status,
      ),
    );
  }

  @override
  _$ReadingStatus$Set copyWith(MutationState<MangaReadingStatus?> state,
          {Object? key}) =>
      _$ReadingStatus$Set(element, state: state, key: key);
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
  _$FollowingStatusElement $createElement($ProviderPointer pointer) =>
      _$FollowingStatusElement(this, pointer);

  ProviderListenable<FollowingStatus$Set> get set =>
      $LazyProxyListenable<FollowingStatus$Set, AsyncValue<bool>>(
        this,
        (element) {
          element as _$FollowingStatusElement;

          return element._$set;
        },
      );

  @override
  bool operator ==(Object other) {
    return other is FollowingStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$followingStatusHash() => r'283f69eb8a5a46c74ad68a98809c7632027274f9';

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

class _$FollowingStatusElement
    extends $AsyncNotifierProviderElement<FollowingStatus, bool> {
  _$FollowingStatusElement(super.provider, super.pointer) {
    _$set.result = $Result.data(_$FollowingStatus$Set(this));
  }
  final _$set = $ElementLense<_$FollowingStatus$Set>();
  @override
  void mount() {
    super.mount();
    _$set.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$set);
  }
}

sealed class FollowingStatus$Set extends MutationBase<bool> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [FollowingStatus.set] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<bool> call(bool following);
}

final class _$FollowingStatus$Set
    extends $AsyncMutationBase<bool, _$FollowingStatus$Set, FollowingStatus>
    implements FollowingStatus$Set {
  _$FollowingStatus$Set(this.element, {super.state, super.key});

  @override
  final _$FollowingStatusElement element;

  @override
  $ElementLense<_$FollowingStatus$Set> get listenable => element._$set;

  @override
  Future<bool> call(bool following) {
    return mutateAsync(
      Invocation.method(
        #set,
        [following],
      ),
      ($notifier) => $notifier.set(
        following,
      ),
    );
  }

  @override
  _$FollowingStatus$Set copyWith(MutationState<bool> state, {Object? key}) =>
      _$FollowingStatus$Set(element, state: state, key: key);
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
  _$MangaDexHistoryElement $createElement($ProviderPointer pointer) =>
      _$MangaDexHistoryElement(this, pointer);

  ProviderListenable<MangaDexHistory$Add> get add =>
      $LazyProxyListenable<MangaDexHistory$Add, AsyncValue<Queue<Chapter>>>(
        this,
        (element) {
          element as _$MangaDexHistoryElement;

          return element._$add;
        },
      );
}

String _$mangaDexHistoryHash() => r'311e39e2c47319cc22050958d302dfbe053d1ebd';

abstract class _$MangaDexHistory extends $AsyncNotifier<Queue<Chapter>> {
  FutureOr<Queue<Chapter>> build();
  @$internal
  @override
  FutureOr<Queue<Chapter>> runBuild() => build();
}

class _$MangaDexHistoryElement
    extends $AsyncNotifierProviderElement<MangaDexHistory, Queue<Chapter>> {
  _$MangaDexHistoryElement(super.provider, super.pointer) {
    _$add.result = $Result.data(_$MangaDexHistory$Add(this));
  }
  final _$add = $ElementLense<_$MangaDexHistory$Add>();
  @override
  void mount() {
    super.mount();
    _$add.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$add);
  }
}

sealed class MangaDexHistory$Add extends MutationBase<Queue<Chapter>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [MangaDexHistory.add] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Queue<Chapter>> call(Chapter chapter);
}

final class _$MangaDexHistory$Add extends $AsyncMutationBase<Queue<Chapter>,
    _$MangaDexHistory$Add, MangaDexHistory> implements MangaDexHistory$Add {
  _$MangaDexHistory$Add(this.element, {super.state, super.key});

  @override
  final _$MangaDexHistoryElement element;

  @override
  $ElementLense<_$MangaDexHistory$Add> get listenable => element._$add;

  @override
  Future<Queue<Chapter>> call(Chapter chapter) {
    return mutateAsync(
      Invocation.method(
        #add,
        [chapter],
      ),
      ($notifier) => $notifier.add(
        chapter,
      ),
    );
  }

  @override
  _$MangaDexHistory$Add copyWith(MutationState<Queue<Chapter>> state,
          {Object? key}) =>
      _$MangaDexHistory$Add(element, state: state, key: key);
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

String _$loggedUserHash() => r'661369d0e4ee922b460c6c3a86c32eaac36a80fa';

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
  _$AuthControlElement $createElement($ProviderPointer pointer) =>
      _$AuthControlElement(this, pointer);

  ProviderListenable<AuthControl$Login> get login =>
      $LazyProxyListenable<AuthControl$Login, AsyncValue<bool>>(
        this,
        (element) {
          element as _$AuthControlElement;

          return element._$login;
        },
      );

  ProviderListenable<AuthControl$Logout> get logout =>
      $LazyProxyListenable<AuthControl$Logout, AsyncValue<bool>>(
        this,
        (element) {
          element as _$AuthControlElement;

          return element._$logout;
        },
      );
}

String _$authControlHash() => r'8b71a67ac16746fb47853136068621f325098b78';

abstract class _$AuthControl extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$internal
  @override
  FutureOr<bool> runBuild() => build();
}

class _$AuthControlElement
    extends $AsyncNotifierProviderElement<AuthControl, bool> {
  _$AuthControlElement(super.provider, super.pointer) {
    _$login.result = $Result.data(_$AuthControl$Login(this));
    _$logout.result = $Result.data(_$AuthControl$Logout(this));
  }
  final _$login = $ElementLense<_$AuthControl$Login>();
  final _$logout = $ElementLense<_$AuthControl$Logout>();
  @override
  void mount() {
    super.mount();
    _$login.result!.stateOrNull!.reset();
    _$logout.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$login);
    listenableVisitor(_$logout);
  }
}

sealed class AuthControl$Login extends MutationBase<bool> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [AuthControl.login] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<bool> call(
      String user, String pass, String clientId, String clientSecret);
}

final class _$AuthControl$Login
    extends $AsyncMutationBase<bool, _$AuthControl$Login, AuthControl>
    implements AuthControl$Login {
  _$AuthControl$Login(this.element, {super.state, super.key});

  @override
  final _$AuthControlElement element;

  @override
  $ElementLense<_$AuthControl$Login> get listenable => element._$login;

  @override
  Future<bool> call(
      String user, String pass, String clientId, String clientSecret) {
    return mutateAsync(
      Invocation.method(
        #login,
        [user, pass, clientId, clientSecret],
      ),
      ($notifier) => $notifier.login(
        user,
        pass,
        clientId,
        clientSecret,
      ),
    );
  }

  @override
  _$AuthControl$Login copyWith(MutationState<bool> state, {Object? key}) =>
      _$AuthControl$Login(element, state: state, key: key);
}

sealed class AuthControl$Logout extends MutationBase<bool> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [AuthControl.logout] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<bool> call();
}

final class _$AuthControl$Logout
    extends $AsyncMutationBase<bool, _$AuthControl$Logout, AuthControl>
    implements AuthControl$Logout {
  _$AuthControl$Logout(this.element, {super.state, super.key});

  @override
  final _$AuthControlElement element;

  @override
  $ElementLense<_$AuthControl$Logout> get listenable => element._$logout;

  @override
  Future<bool> call() {
    return mutateAsync(
      Invocation.method(
        #logout,
        [],
      ),
      ($notifier) => $notifier.logout(),
    );
  }

  @override
  _$AuthControl$Logout copyWith(MutationState<bool> state, {Object? key}) =>
      _$AuthControl$Logout(element, state: state, key: key);
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
