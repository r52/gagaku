// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(mangadex)
const mangadexProvider = MangadexProvider._();

final class MangadexProvider
    extends $FunctionalProvider<MangaDexModel, MangaDexModel, MangaDexModel>
    with $Provider<MangaDexModel> {
  const MangadexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mangadexProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mangadexHash();

  @$internal
  @override
  $ProviderElement<MangaDexModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MangaDexModel create(Ref ref) {
    return mangadex(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MangaDexModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MangaDexModel>(value),
    );
  }
}

String _$mangadexHash() => r'4f95e2d6037a2e23987c4eafa80322c88c003f20';

@ProviderFor(MangaChaptersListSort)
const mangaChaptersListSortProvider = MangaChaptersListSortProvider._();

final class MangaChaptersListSortProvider
    extends $NotifierProvider<MangaChaptersListSort, ListSort> {
  const MangaChaptersListSortProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mangaChaptersListSortProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mangaChaptersListSortHash();

  @$internal
  @override
  MangaChaptersListSort create() => MangaChaptersListSort();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListSort value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListSort>(value),
    );
  }
}

String _$mangaChaptersListSortHash() =>
    r'71b85b6dcf773f1b96a7175794184871a99dc3dc';

abstract class _$MangaChaptersListSort extends $Notifier<ListSort> {
  ListSort build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ListSort, ListSort>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ListSort, ListSort>,
              ListSort,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ReadChapters)
const readChaptersProvider = ReadChaptersFamily._();

final class ReadChaptersProvider
    extends $AsyncNotifierProvider<ReadChapters, ReadChaptersMap> {
  const ReadChaptersProvider._({
    required ReadChaptersFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'readChaptersProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
  ReadChapters create() => ReadChapters();

  @override
  bool operator ==(Object other) {
    return other is ReadChaptersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$readChaptersHash() => r'162e6b6a6de0c6ccee87196034d5aa543e8c1bbc';

final class ReadChaptersFamily extends $Family
    with
        $ClassFamilyOverride<
          ReadChapters,
          AsyncValue<ReadChaptersMap>,
          ReadChaptersMap,
          FutureOr<ReadChaptersMap>,
          String?
        > {
  const ReadChaptersFamily._()
    : super(
        retry: null,
        name: r'readChaptersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ReadChaptersProvider call(String? userId) =>
      ReadChaptersProvider._(argument: userId, from: this);

  @override
  String toString() => r'readChaptersProvider';
}

abstract class _$ReadChapters extends $AsyncNotifier<ReadChaptersMap> {
  late final _$args = ref.$arg as String?;
  String? get userId => _$args;

  FutureOr<ReadChaptersMap> build(String? userId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<ReadChaptersMap>, ReadChaptersMap>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ReadChaptersMap>, ReadChaptersMap>,
              AsyncValue<ReadChaptersMap>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(UserLibrary)
const userLibraryProvider = UserLibraryFamily._();

final class UserLibraryProvider
    extends
        $AsyncNotifierProvider<UserLibrary, Map<String, MangaReadingStatus>> {
  const UserLibraryProvider._({
    required UserLibraryFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'userLibraryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
  UserLibrary create() => UserLibrary();

  @override
  bool operator ==(Object other) {
    return other is UserLibraryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userLibraryHash() => r'ea56d099e6c781ce26f14be4fc53d052c80b6ff8';

final class UserLibraryFamily extends $Family
    with
        $ClassFamilyOverride<
          UserLibrary,
          AsyncValue<Map<String, MangaReadingStatus>>,
          Map<String, MangaReadingStatus>,
          FutureOr<Map<String, MangaReadingStatus>>,
          String?
        > {
  const UserLibraryFamily._()
    : super(
        retry: null,
        name: r'userLibraryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserLibraryProvider call(String? userId) =>
      UserLibraryProvider._(argument: userId, from: this);

  @override
  String toString() => r'userLibraryProvider';
}

abstract class _$UserLibrary
    extends $AsyncNotifier<Map<String, MangaReadingStatus>> {
  late final _$args = ref.$arg as String?;
  String? get userId => _$args;

  FutureOr<Map<String, MangaReadingStatus>> build(String? userId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, MangaReadingStatus>>,
              Map<String, MangaReadingStatus>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, MangaReadingStatus>>,
                Map<String, MangaReadingStatus>
              >,
              AsyncValue<Map<String, MangaReadingStatus>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(UserLists)
const userListsProvider = UserListsFamily._();

final class UserListsProvider
    extends $AsyncNotifierProvider<UserLists, List<CustomList>> {
  const UserListsProvider._({
    required UserListsFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'userListsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
  UserLists create() => UserLists();

  @override
  bool operator ==(Object other) {
    return other is UserListsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userListsHash() => r'd81822ac7862464faac52a965edaf4d105a7f082';

final class UserListsFamily extends $Family
    with
        $ClassFamilyOverride<
          UserLists,
          AsyncValue<List<CustomList>>,
          List<CustomList>,
          FutureOr<List<CustomList>>,
          String?
        > {
  const UserListsFamily._()
    : super(
        retry: null,
        name: r'userListsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserListsProvider call(String? userId) =>
      UserListsProvider._(argument: userId, from: this);

  @override
  String toString() => r'userListsProvider';
}

abstract class _$UserLists extends $AsyncNotifier<List<CustomList>> {
  late final _$args = ref.$arg as String?;
  String? get userId => _$args;

  FutureOr<List<CustomList>> build(String? userId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<List<CustomList>>, List<CustomList>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CustomList>>, List<CustomList>>,
              AsyncValue<List<CustomList>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(FollowedLists)
const followedListsProvider = FollowedListsFamily._();

final class FollowedListsProvider
    extends $AsyncNotifierProvider<FollowedLists, List<CustomList>> {
  const FollowedListsProvider._({
    required FollowedListsFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'followedListsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
  FollowedLists create() => FollowedLists();

  @override
  bool operator ==(Object other) {
    return other is FollowedListsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$followedListsHash() => r'54cee419f2a26ec151129216f934f9e248b90445';

final class FollowedListsFamily extends $Family
    with
        $ClassFamilyOverride<
          FollowedLists,
          AsyncValue<List<CustomList>>,
          List<CustomList>,
          FutureOr<List<CustomList>>,
          String?
        > {
  const FollowedListsFamily._()
    : super(
        retry: null,
        name: r'followedListsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FollowedListsProvider call(String? userId) =>
      FollowedListsProvider._(argument: userId, from: this);

  @override
  String toString() => r'followedListsProvider';
}

abstract class _$FollowedLists extends $AsyncNotifier<List<CustomList>> {
  late final _$args = ref.$arg as String?;
  String? get userId => _$args;

  FutureOr<List<CustomList>> build(String? userId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<List<CustomList>>, List<CustomList>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CustomList>>, List<CustomList>>,
              AsyncValue<List<CustomList>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ListSource)
const listSourceProvider = ListSourceFamily._();

final class ListSourceProvider
    extends $AsyncNotifierProvider<ListSource, CustomList?> {
  const ListSourceProvider._({
    required ListSourceFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'listSourceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
  ListSource create() => ListSource();

  @override
  bool operator ==(Object other) {
    return other is ListSourceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listSourceHash() => r'd6b059c04284e56b5c818ebad91096b37d67ce4c';

final class ListSourceFamily extends $Family
    with
        $ClassFamilyOverride<
          ListSource,
          AsyncValue<CustomList?>,
          CustomList?,
          FutureOr<CustomList?>,
          String
        > {
  const ListSourceFamily._()
    : super(
        retry: noRetry,
        name: r'listSourceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ListSourceProvider call(String listId) =>
      ListSourceProvider._(argument: listId, from: this);

  @override
  String toString() => r'listSourceProvider';
}

abstract class _$ListSource extends $AsyncNotifier<CustomList?> {
  late final _$args = ref.$arg as String;
  String get listId => _$args;

  FutureOr<CustomList?> build(String listId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<CustomList?>, CustomList?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CustomList?>, CustomList?>,
              AsyncValue<CustomList?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(TagList)
const tagListProvider = TagListProvider._();

final class TagListProvider
    extends $AsyncNotifierProvider<TagList, Iterable<Tag>> {
  const TagListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagListHash();

  @$internal
  @override
  TagList create() => TagList();
}

String _$tagListHash() => r'0196fc7cdaa7989fc6255d343c1c3b2e19c37d1f';

abstract class _$TagList extends $AsyncNotifier<Iterable<Tag>> {
  FutureOr<Iterable<Tag>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Iterable<Tag>>, Iterable<Tag>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Iterable<Tag>>, Iterable<Tag>>,
              AsyncValue<Iterable<Tag>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(Statistics)
const statisticsProvider = StatisticsProvider._();

final class StatisticsProvider
    extends $AsyncNotifierProvider<Statistics, Map<String, MangaStatistics>> {
  const StatisticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statisticsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statisticsHash();

  @$internal
  @override
  Statistics create() => Statistics();
}

String _$statisticsHash() => r'4fe2227af78ec4cb5b188c17df7eed900d8d6f9e';

abstract class _$Statistics
    extends $AsyncNotifier<Map<String, MangaStatistics>> {
  FutureOr<Map<String, MangaStatistics>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, MangaStatistics>>,
              Map<String, MangaStatistics>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, MangaStatistics>>,
                Map<String, MangaStatistics>
              >,
              AsyncValue<Map<String, MangaStatistics>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ChapterStats)
const chapterStatsProvider = ChapterStatsProvider._();

final class ChapterStatsProvider
    extends
        $AsyncNotifierProvider<ChapterStats, Map<String, ChapterStatistics>> {
  const ChapterStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chapterStatsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chapterStatsHash();

  @$internal
  @override
  ChapterStats create() => ChapterStats();
}

String _$chapterStatsHash() => r'1898d92ddb47ef7ca62042a080b7a4e7b96e54d9';

abstract class _$ChapterStats
    extends $AsyncNotifier<Map<String, ChapterStatistics>> {
  FutureOr<Map<String, ChapterStatistics>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, ChapterStatistics>>,
              Map<String, ChapterStatistics>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, ChapterStatistics>>,
                Map<String, ChapterStatistics>
              >,
              AsyncValue<Map<String, ChapterStatistics>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(Ratings)
const ratingsProvider = RatingsFamily._();

final class RatingsProvider
    extends $AsyncNotifierProvider<Ratings, Map<String, SelfRating>> {
  const RatingsProvider._({
    required RatingsFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'ratingsProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
  Ratings create() => Ratings();

  @override
  bool operator ==(Object other) {
    return other is RatingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ratingsHash() => r'c3ca1836cb5c3420059aff0b19a7242afd6a8f8a';

final class RatingsFamily extends $Family
    with
        $ClassFamilyOverride<
          Ratings,
          AsyncValue<Map<String, SelfRating>>,
          Map<String, SelfRating>,
          FutureOr<Map<String, SelfRating>>,
          String?
        > {
  const RatingsFamily._()
    : super(
        retry: null,
        name: r'ratingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  RatingsProvider call(String? userId) =>
      RatingsProvider._(argument: userId, from: this);

  @override
  String toString() => r'ratingsProvider';
}

abstract class _$Ratings extends $AsyncNotifier<Map<String, SelfRating>> {
  late final _$args = ref.$arg as String?;
  String? get userId => _$args;

  FutureOr<Map<String, SelfRating>> build(String? userId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, SelfRating>>,
              Map<String, SelfRating>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, SelfRating>>,
                Map<String, SelfRating>
              >,
              AsyncValue<Map<String, SelfRating>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ReadingStatus)
const readingStatusProvider = ReadingStatusFamily._();

final class ReadingStatusProvider
    extends $AsyncNotifierProvider<ReadingStatus, MangaReadingStatus?> {
  const ReadingStatusProvider._({
    required ReadingStatusFamily super.from,
    required Manga super.argument,
  }) : super(
         retry: null,
         name: r'readingStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
  ReadingStatus create() => ReadingStatus();

  @override
  bool operator ==(Object other) {
    return other is ReadingStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$readingStatusHash() => r'78d76663556b421dc500308b42a32d079beba417';

final class ReadingStatusFamily extends $Family
    with
        $ClassFamilyOverride<
          ReadingStatus,
          AsyncValue<MangaReadingStatus?>,
          MangaReadingStatus?,
          FutureOr<MangaReadingStatus?>,
          Manga
        > {
  const ReadingStatusFamily._()
    : super(
        retry: null,
        name: r'readingStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReadingStatusProvider call(Manga manga) =>
      ReadingStatusProvider._(argument: manga, from: this);

  @override
  String toString() => r'readingStatusProvider';
}

abstract class _$ReadingStatus extends $AsyncNotifier<MangaReadingStatus?> {
  late final _$args = ref.$arg as Manga;
  Manga get manga => _$args;

  FutureOr<MangaReadingStatus?> build(Manga manga);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<MangaReadingStatus?>, MangaReadingStatus?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MangaReadingStatus?>, MangaReadingStatus?>,
              AsyncValue<MangaReadingStatus?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(FollowingStatus)
const followingStatusProvider = FollowingStatusFamily._();

final class FollowingStatusProvider
    extends $AsyncNotifierProvider<FollowingStatus, bool> {
  const FollowingStatusProvider._({
    required FollowingStatusFamily super.from,
    required Manga super.argument,
  }) : super(
         retry: null,
         name: r'followingStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
  FollowingStatus create() => FollowingStatus();

  @override
  bool operator ==(Object other) {
    return other is FollowingStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$followingStatusHash() => r'431485be4207365c3609295abe3c8af8214a00e4';

final class FollowingStatusFamily extends $Family
    with
        $ClassFamilyOverride<
          FollowingStatus,
          AsyncValue<bool>,
          bool,
          FutureOr<bool>,
          Manga
        > {
  const FollowingStatusFamily._()
    : super(
        retry: null,
        name: r'followingStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FollowingStatusProvider call(Manga manga) =>
      FollowingStatusProvider._(argument: manga, from: this);

  @override
  String toString() => r'followingStatusProvider';
}

abstract class _$FollowingStatus extends $AsyncNotifier<bool> {
  late final _$args = ref.$arg as Manga;
  Manga get manga => _$args;

  FutureOr<bool> build(Manga manga);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(MangaDexHistory)
const mangaDexHistoryProvider = MangaDexHistoryProvider._();

final class MangaDexHistoryProvider
    extends $AsyncNotifierProvider<MangaDexHistory, Queue<Chapter>> {
  const MangaDexHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mangaDexHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mangaDexHistoryHash();

  @$internal
  @override
  MangaDexHistory create() => MangaDexHistory();
}

String _$mangaDexHistoryHash() => r'69a7136e00bba032eb52913de7e66d3bc8429d49';

abstract class _$MangaDexHistory extends $AsyncNotifier<Queue<Chapter>> {
  FutureOr<Queue<Chapter>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Queue<Chapter>>, Queue<Chapter>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Queue<Chapter>>, Queue<Chapter>>,
              AsyncValue<Queue<Chapter>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(LoggedUser)
const loggedUserProvider = LoggedUserProvider._();

final class LoggedUserProvider
    extends $AsyncNotifierProvider<LoggedUser, User?> {
  const LoggedUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loggedUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loggedUserHash();

  @$internal
  @override
  LoggedUser create() => LoggedUser();
}

String _$loggedUserHash() => r'd57241dc04aa26bc80bbb5b0bdb1b3b2e38c5ee2';

abstract class _$LoggedUser extends $AsyncNotifier<User?> {
  FutureOr<User?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<User?>, User?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User?>, User?>,
              AsyncValue<User?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(AuthControl)
const authControlProvider = AuthControlProvider._();

final class AuthControlProvider
    extends $StreamNotifierProvider<AuthControl, AuthenticationStatus> {
  const AuthControlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControlHash();

  @$internal
  @override
  AuthControl create() => AuthControl();
}

String _$authControlHash() => r'13720c5ff5dd59eee2b9627e9897aadff31a6983';

abstract class _$AuthControl extends $StreamNotifier<AuthenticationStatus> {
  Stream<AuthenticationStatus> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<AuthenticationStatus>, AuthenticationStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<AuthenticationStatus>,
                AuthenticationStatus
              >,
              AsyncValue<AuthenticationStatus>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
