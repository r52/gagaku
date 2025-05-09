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
  const MangadexProvider._({MangaDexModel Function(Ref ref)? create})
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

  final MangaDexModel Function(Ref ref)? _createCb;

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
  MangadexProvider $copyWithCreate(MangaDexModel Function(Ref ref) create) {
    return MangadexProvider._(create: create);
  }

  @override
  MangaDexModel create(Ref ref) {
    final _$cb = _createCb ?? mangadex;
    return _$cb(ref);
  }
}

String _$mangadexHash() => r'2e60803c3e0b7b0065c423dcb31c862de55d8e53';

@ProviderFor(MangaChaptersListSort)
const mangaChaptersListSortProvider = MangaChaptersListSortProvider._();

final class MangaChaptersListSortProvider
    extends $NotifierProvider<MangaChaptersListSort, ListSort> {
  const MangaChaptersListSortProvider._({
    super.runNotifierBuildOverride,
    MangaChaptersListSort Function()? create,
  }) : _createCb = create,
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
    ListSort Function(Ref, MangaChaptersListSort) build,
  ) {
    return MangaChaptersListSortProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<MangaChaptersListSort, ListSort> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(this, pointer);
}

String _$mangaChaptersListSortHash() =>
    r'71b85b6dcf773f1b96a7175794184871a99dc3dc';

abstract class _$MangaChaptersListSort extends $Notifier<ListSort> {
  ListSort build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ListSort>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<ListSort>,
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
    super.runNotifierBuildOverride,
    ReadChapters Function()? create,
  }) : _createCb = create,
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
  ReadChaptersProvider $copyWithCreate(ReadChapters Function() create) {
    return ReadChaptersProvider._(
      argument: argument as String?,
      from: from! as ReadChaptersFamily,
      create: create,
    );
  }

  @$internal
  @override
  ReadChaptersProvider $copyWithBuild(
    FutureOr<ReadChaptersMap> Function(Ref, ReadChapters) build,
  ) {
    return ReadChaptersProvider._(
      argument: argument as String?,
      from: from! as ReadChaptersFamily,
      runNotifierBuildOverride: build,
    );
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

String _$readChaptersHash() => r'1e52eceee5ec71ee240aa09663fbd4c633cabbdd';

final class ReadChaptersFamily extends Family {
  const ReadChaptersFamily._()
    : super(
        retry: null,
        name: r'readChaptersProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ReadChaptersProvider call(String? userId) =>
      ReadChaptersProvider._(argument: userId, from: this);

  @override
  String debugGetCreateSourceHash() => _$readChaptersHash();

  @override
  String toString() => r'readChaptersProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(ReadChapters Function(String? args) create) {
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
      Ref ref,
      ReadChapters notifier,
      String? argument,
    )
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

  FutureOr<ReadChaptersMap> build(String? userId);
  @$internal
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<ReadChaptersMap>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<ReadChaptersMap>>,
              AsyncValue<ReadChaptersMap>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
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
    _$get.result!.value!.reset();
    _$set.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

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
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<ReadChaptersMap> call(Iterable<Manga> mangas);
}

final class _$ReadChapters$Get
    extends
        $AsyncMutationBase<ReadChaptersMap, _$ReadChapters$Get, ReadChapters>
    implements ReadChapters$Get {
  _$ReadChapters$Get(this.element, {super.state, super.key});

  @override
  final _$ReadChaptersElement element;

  @override
  $ElementLense<_$ReadChapters$Get> get listenable => element._$get;

  @override
  Future<ReadChaptersMap> call(Iterable<Manga> mangas) {
    return mutate(
      Invocation.method(#get, [mangas]),
      ($notifier) => $notifier.get(mangas),
    );
  }

  @override
  _$ReadChapters$Get copyWith(
    MutationState<ReadChaptersMap> state, {
    Object? key,
  }) => _$ReadChapters$Get(element, state: state, key: key);
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
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<ReadChaptersMap> call(
    Manga manga, {
    Iterable<Chapter>? read,
    Iterable<Chapter>? unread,
  });
}

final class _$ReadChapters$Set
    extends
        $AsyncMutationBase<ReadChaptersMap, _$ReadChapters$Set, ReadChapters>
    implements ReadChapters$Set {
  _$ReadChapters$Set(this.element, {super.state, super.key});

  @override
  final _$ReadChaptersElement element;

  @override
  $ElementLense<_$ReadChapters$Set> get listenable => element._$set;

  @override
  Future<ReadChaptersMap> call(
    Manga manga, {
    Iterable<Chapter>? read,
    Iterable<Chapter>? unread,
  }) {
    return mutate(
      Invocation.method(#set, [manga], {#read: read, #unread: unread}),
      ($notifier) => $notifier.set(manga, read: read, unread: unread),
    );
  }

  @override
  _$ReadChapters$Set copyWith(
    MutationState<ReadChaptersMap> state, {
    Object? key,
  }) => _$ReadChapters$Set(element, state: state, key: key);
}

@ProviderFor(UserLibrary)
const userLibraryProvider = UserLibraryFamily._();

final class UserLibraryProvider
    extends
        $AsyncNotifierProvider<UserLibrary, Map<String, MangaReadingStatus>> {
  const UserLibraryProvider._({
    required UserLibraryFamily super.from,
    required String? super.argument,
    super.runNotifierBuildOverride,
    UserLibrary Function()? create,
  }) : _createCb = create,
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
  UserLibraryProvider $copyWithCreate(UserLibrary Function() create) {
    return UserLibraryProvider._(
      argument: argument as String?,
      from: from! as UserLibraryFamily,
      create: create,
    );
  }

  @$internal
  @override
  UserLibraryProvider $copyWithBuild(
    FutureOr<Map<String, MangaReadingStatus>> Function(Ref, UserLibrary) build,
  ) {
    return UserLibraryProvider._(
      argument: argument as String?,
      from: from! as UserLibraryFamily,
      runNotifierBuildOverride: build,
    );
  }

  @$internal
  @override
  _$UserLibraryElement $createElement($ProviderPointer pointer) =>
      _$UserLibraryElement(this, pointer);

  ProviderListenable<UserLibrary$Set> get set => $LazyProxyListenable<
    UserLibrary$Set,
    AsyncValue<Map<String, MangaReadingStatus>>
  >(this, (element) {
    element as _$UserLibraryElement;

    return element._$set;
  });

  @override
  bool operator ==(Object other) {
    return other is UserLibraryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userLibraryHash() => r'8c20b25da530b2241f508d90111dce2a68e3f3e1';

final class UserLibraryFamily extends Family {
  const UserLibraryFamily._()
    : super(
        retry: null,
        name: r'userLibraryProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserLibraryProvider call(String? userId) =>
      UserLibraryProvider._(argument: userId, from: this);

  @override
  String debugGetCreateSourceHash() => _$userLibraryHash();

  @override
  String toString() => r'userLibraryProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(UserLibrary Function(String? args) create) {
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
      Ref ref,
      UserLibrary notifier,
      String? argument,
    )
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

  FutureOr<Map<String, MangaReadingStatus>> build(String? userId);
  @$internal
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<Map<String, MangaReadingStatus>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<Map<String, MangaReadingStatus>>>,
              AsyncValue<Map<String, MangaReadingStatus>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$UserLibraryElement
    extends
        $AsyncNotifierProviderElement<
          UserLibrary,
          Map<String, MangaReadingStatus>
        > {
  _$UserLibraryElement(super.provider, super.pointer) {
    _$set.result = $Result.data(_$UserLibrary$Set(this));
  }
  final _$set = $ElementLense<_$UserLibrary$Set>();
  @override
  void mount() {
    super.mount();
    _$set.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

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
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, MangaReadingStatus>> call(
    Manga manga,
    MangaReadingStatus? status,
  );
}

final class _$UserLibrary$Set
    extends
        $AsyncMutationBase<
          Map<String, MangaReadingStatus>,
          _$UserLibrary$Set,
          UserLibrary
        >
    implements UserLibrary$Set {
  _$UserLibrary$Set(this.element, {super.state, super.key});

  @override
  final _$UserLibraryElement element;

  @override
  $ElementLense<_$UserLibrary$Set> get listenable => element._$set;

  @override
  Future<Map<String, MangaReadingStatus>> call(
    Manga manga,
    MangaReadingStatus? status,
  ) {
    return mutate(
      Invocation.method(#set, [manga, status]),
      ($notifier) => $notifier.set(manga, status),
    );
  }

  @override
  _$UserLibrary$Set copyWith(
    MutationState<Map<String, MangaReadingStatus>> state, {
    Object? key,
  }) => _$UserLibrary$Set(element, state: state, key: key);
}

@ProviderFor(UserLists)
const userListsProvider = UserListsFamily._();

final class UserListsProvider
    extends $AsyncNotifierProvider<UserLists, List<CustomList>> {
  const UserListsProvider._({
    required UserListsFamily super.from,
    required String? super.argument,
    super.runNotifierBuildOverride,
    UserLists Function()? create,
  }) : _createCb = create,
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
  UserListsProvider $copyWithCreate(UserLists Function() create) {
    return UserListsProvider._(
      argument: argument as String?,
      from: from! as UserListsFamily,
      create: create,
    );
  }

  @$internal
  @override
  UserListsProvider $copyWithBuild(
    FutureOr<List<CustomList>> Function(Ref, UserLists) build,
  ) {
    return UserListsProvider._(
      argument: argument as String?,
      from: from! as UserListsFamily,
      runNotifierBuildOverride: build,
    );
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

  ProviderListenable<UserLists$GetNextPage> get getNextPage =>
      $LazyProxyListenable<UserLists$GetNextPage, AsyncValue<List<CustomList>>>(
        this,
        (element) {
          element as _$UserListsElement;

          return element._$getNextPage;
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

String _$userListsHash() => r'4951bb130b0667eb9730ebb159af25933675fa7b';

final class UserListsFamily extends Family {
  const UserListsFamily._()
    : super(
        retry: null,
        name: r'userListsProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserListsProvider call(String? userId) =>
      UserListsProvider._(argument: userId, from: this);

  @override
  String debugGetCreateSourceHash() => _$userListsHash();

  @override
  String toString() => r'userListsProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(UserLists Function(String? args) create) {
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
      Ref ref,
      UserLists notifier,
      String? argument,
    )
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

  FutureOr<List<CustomList>> build(String? userId);
  @$internal
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<List<CustomList>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<List<CustomList>>>,
              AsyncValue<List<CustomList>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$UserListsElement
    extends $AsyncNotifierProviderElement<UserLists, List<CustomList>> {
  _$UserListsElement(super.provider, super.pointer) {
    _$updateList.result = $Result.data(_$UserLists$UpdateList(this));
    _$editList.result = $Result.data(_$UserLists$EditList(this));
    _$deleteList.result = $Result.data(_$UserLists$DeleteList(this));
    _$newList.result = $Result.data(_$UserLists$NewList(this));
    _$getNextPage.result = $Result.data(_$UserLists$GetNextPage(this));
  }
  final _$updateList = $ElementLense<_$UserLists$UpdateList>();
  final _$editList = $ElementLense<_$UserLists$EditList>();
  final _$deleteList = $ElementLense<_$UserLists$DeleteList>();
  final _$newList = $ElementLense<_$UserLists$NewList>();
  final _$getNextPage = $ElementLense<_$UserLists$GetNextPage>();
  @override
  void mount() {
    super.mount();
    _$updateList.result!.value!.reset();
    _$editList.result!.value!.reset();
    _$deleteList.result!.value!.reset();
    _$newList.result!.value!.reset();
    _$getNextPage.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

    listenableVisitor(_$updateList);
    listenableVisitor(_$editList);
    listenableVisitor(_$deleteList);
    listenableVisitor(_$newList);
    listenableVisitor(_$getNextPage);
  }
}

sealed class UserLists$UpdateList extends MutationBase<CustomList?> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [UserLists.updateList] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<CustomList?> call(CustomList list, Manga manga, bool add);
}

final class _$UserLists$UpdateList
    extends $AsyncMutationBase<CustomList?, _$UserLists$UpdateList, UserLists>
    implements UserLists$UpdateList {
  _$UserLists$UpdateList(this.element, {super.state, super.key});

  @override
  final _$UserListsElement element;

  @override
  $ElementLense<_$UserLists$UpdateList> get listenable => element._$updateList;

  @override
  Future<CustomList?> call(CustomList list, Manga manga, bool add) {
    return mutate(
      Invocation.method(#updateList, [list, manga, add]),
      ($notifier) => $notifier.updateList(list, manga, add),
    );
  }

  @override
  _$UserLists$UpdateList copyWith(
    MutationState<CustomList?> state, {
    Object? key,
  }) => _$UserLists$UpdateList(element, state: state, key: key);
}

sealed class UserLists$EditList extends MutationBase<CustomList> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [UserLists.editList] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<CustomList> call(
    CustomList list,
    String name,
    CustomListVisibility visibility,
    Iterable<String> mangaIds,
  );
}

final class _$UserLists$EditList
    extends $AsyncMutationBase<CustomList, _$UserLists$EditList, UserLists>
    implements UserLists$EditList {
  _$UserLists$EditList(this.element, {super.state, super.key});

  @override
  final _$UserListsElement element;

  @override
  $ElementLense<_$UserLists$EditList> get listenable => element._$editList;

  @override
  Future<CustomList> call(
    CustomList list,
    String name,
    CustomListVisibility visibility,
    Iterable<String> mangaIds,
  ) {
    return mutate(
      Invocation.method(#editList, [list, name, visibility, mangaIds]),
      ($notifier) => $notifier.editList(list, name, visibility, mangaIds),
    );
  }

  @override
  _$UserLists$EditList copyWith(
    MutationState<CustomList> state, {
    Object? key,
  }) => _$UserLists$EditList(element, state: state, key: key);
}

sealed class UserLists$DeleteList extends MutationBase<CustomList> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [UserLists.deleteList] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<CustomList> call(CustomList list);
}

final class _$UserLists$DeleteList
    extends $AsyncMutationBase<CustomList, _$UserLists$DeleteList, UserLists>
    implements UserLists$DeleteList {
  _$UserLists$DeleteList(this.element, {super.state, super.key});

  @override
  final _$UserListsElement element;

  @override
  $ElementLense<_$UserLists$DeleteList> get listenable => element._$deleteList;

  @override
  Future<CustomList> call(CustomList list) {
    return mutate(
      Invocation.method(#deleteList, [list]),
      ($notifier) => $notifier.deleteList(list),
    );
  }

  @override
  _$UserLists$DeleteList copyWith(
    MutationState<CustomList> state, {
    Object? key,
  }) => _$UserLists$DeleteList(element, state: state, key: key);
}

sealed class UserLists$NewList extends MutationBase<CustomList> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [UserLists.newList] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<CustomList> call(
    String name,
    CustomListVisibility visibility,
    Iterable<String> mangaIds,
  );
}

final class _$UserLists$NewList
    extends $AsyncMutationBase<CustomList, _$UserLists$NewList, UserLists>
    implements UserLists$NewList {
  _$UserLists$NewList(this.element, {super.state, super.key});

  @override
  final _$UserListsElement element;

  @override
  $ElementLense<_$UserLists$NewList> get listenable => element._$newList;

  @override
  Future<CustomList> call(
    String name,
    CustomListVisibility visibility,
    Iterable<String> mangaIds,
  ) {
    return mutate(
      Invocation.method(#newList, [name, visibility, mangaIds]),
      ($notifier) => $notifier.newList(name, visibility, mangaIds),
    );
  }

  @override
  _$UserLists$NewList copyWith(
    MutationState<CustomList> state, {
    Object? key,
  }) => _$UserLists$NewList(element, state: state, key: key);
}

sealed class UserLists$GetNextPage extends MutationBase<List<CustomList>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [UserLists.getNextPage] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<List<CustomList>> call();
}

final class _$UserLists$GetNextPage
    extends
        $AsyncMutationBase<List<CustomList>, _$UserLists$GetNextPage, UserLists>
    implements UserLists$GetNextPage {
  _$UserLists$GetNextPage(this.element, {super.state, super.key});

  @override
  final _$UserListsElement element;

  @override
  $ElementLense<_$UserLists$GetNextPage> get listenable =>
      element._$getNextPage;

  @override
  Future<List<CustomList>> call() {
    return mutate(
      Invocation.method(#getNextPage, []),
      ($notifier) => $notifier.getNextPage(),
    );
  }

  @override
  _$UserLists$GetNextPage copyWith(
    MutationState<List<CustomList>> state, {
    Object? key,
  }) => _$UserLists$GetNextPage(element, state: state, key: key);
}

@ProviderFor(FollowedLists)
const followedListsProvider = FollowedListsFamily._();

final class FollowedListsProvider
    extends $AsyncNotifierProvider<FollowedLists, List<CustomList>> {
  const FollowedListsProvider._({
    required FollowedListsFamily super.from,
    required String? super.argument,
    super.runNotifierBuildOverride,
    FollowedLists Function()? create,
  }) : _createCb = create,
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
  FollowedListsProvider $copyWithCreate(FollowedLists Function() create) {
    return FollowedListsProvider._(
      argument: argument as String?,
      from: from! as FollowedListsFamily,
      create: create,
    );
  }

  @$internal
  @override
  FollowedListsProvider $copyWithBuild(
    FutureOr<List<CustomList>> Function(Ref, FollowedLists) build,
  ) {
    return FollowedListsProvider._(
      argument: argument as String?,
      from: from! as FollowedListsFamily,
      runNotifierBuildOverride: build,
    );
  }

  @$internal
  @override
  _$FollowedListsElement $createElement($ProviderPointer pointer) =>
      _$FollowedListsElement(this, pointer);

  ProviderListenable<FollowedLists$SetFollow> get setFollow =>
      $LazyProxyListenable<
        FollowedLists$SetFollow,
        AsyncValue<List<CustomList>>
      >(this, (element) {
        element as _$FollowedListsElement;

        return element._$setFollow;
      });

  ProviderListenable<FollowedLists$GetNextPage> get getNextPage =>
      $LazyProxyListenable<
        FollowedLists$GetNextPage,
        AsyncValue<List<CustomList>>
      >(this, (element) {
        element as _$FollowedListsElement;

        return element._$getNextPage;
      });

  @override
  bool operator ==(Object other) {
    return other is FollowedListsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$followedListsHash() => r'0aceef3d3132e86e87bd51ea8ebd8a7486bfd73d';

final class FollowedListsFamily extends Family {
  const FollowedListsFamily._()
    : super(
        retry: null,
        name: r'followedListsProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FollowedListsProvider call(String? userId) =>
      FollowedListsProvider._(argument: userId, from: this);

  @override
  String debugGetCreateSourceHash() => _$followedListsHash();

  @override
  String toString() => r'followedListsProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(FollowedLists Function(String? args) create) {
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
      Ref ref,
      FollowedLists notifier,
      String? argument,
    )
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

  FutureOr<List<CustomList>> build(String? userId);
  @$internal
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<List<CustomList>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<List<CustomList>>>,
              AsyncValue<List<CustomList>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$FollowedListsElement
    extends $AsyncNotifierProviderElement<FollowedLists, List<CustomList>> {
  _$FollowedListsElement(super.provider, super.pointer) {
    _$setFollow.result = $Result.data(_$FollowedLists$SetFollow(this));
    _$getNextPage.result = $Result.data(_$FollowedLists$GetNextPage(this));
  }
  final _$setFollow = $ElementLense<_$FollowedLists$SetFollow>();
  final _$getNextPage = $ElementLense<_$FollowedLists$GetNextPage>();
  @override
  void mount() {
    super.mount();
    _$setFollow.result!.value!.reset();
    _$getNextPage.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

    listenableVisitor(_$setFollow);
    listenableVisitor(_$getNextPage);
  }
}

sealed class FollowedLists$SetFollow extends MutationBase<bool> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [FollowedLists.setFollow] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<bool> call(CustomList list, bool follow);
}

final class _$FollowedLists$SetFollow
    extends $AsyncMutationBase<bool, _$FollowedLists$SetFollow, FollowedLists>
    implements FollowedLists$SetFollow {
  _$FollowedLists$SetFollow(this.element, {super.state, super.key});

  @override
  final _$FollowedListsElement element;

  @override
  $ElementLense<_$FollowedLists$SetFollow> get listenable =>
      element._$setFollow;

  @override
  Future<bool> call(CustomList list, bool follow) {
    return mutate(
      Invocation.method(#setFollow, [list, follow]),
      ($notifier) => $notifier.setFollow(list, follow),
    );
  }

  @override
  _$FollowedLists$SetFollow copyWith(
    MutationState<bool> state, {
    Object? key,
  }) => _$FollowedLists$SetFollow(element, state: state, key: key);
}

sealed class FollowedLists$GetNextPage extends MutationBase<List<CustomList>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [FollowedLists.getNextPage] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<List<CustomList>> call();
}

final class _$FollowedLists$GetNextPage
    extends
        $AsyncMutationBase<
          List<CustomList>,
          _$FollowedLists$GetNextPage,
          FollowedLists
        >
    implements FollowedLists$GetNextPage {
  _$FollowedLists$GetNextPage(this.element, {super.state, super.key});

  @override
  final _$FollowedListsElement element;

  @override
  $ElementLense<_$FollowedLists$GetNextPage> get listenable =>
      element._$getNextPage;

  @override
  Future<List<CustomList>> call() {
    return mutate(
      Invocation.method(#getNextPage, []),
      ($notifier) => $notifier.getNextPage(),
    );
  }

  @override
  _$FollowedLists$GetNextPage copyWith(
    MutationState<List<CustomList>> state, {
    Object? key,
  }) => _$FollowedLists$GetNextPage(element, state: state, key: key);
}

@ProviderFor(ListSource)
const listSourceProvider = ListSourceFamily._();

final class ListSourceProvider
    extends $AsyncNotifierProvider<ListSource, CustomList?> {
  const ListSourceProvider._({
    required ListSourceFamily super.from,
    required String super.argument,
    super.runNotifierBuildOverride,
    ListSource Function()? create,
  }) : _createCb = create,
       super(
         retry: noRetry,
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
  ListSourceProvider $copyWithCreate(ListSource Function() create) {
    return ListSourceProvider._(
      argument: argument as String,
      from: from! as ListSourceFamily,
      create: create,
    );
  }

  @$internal
  @override
  ListSourceProvider $copyWithBuild(
    FutureOr<CustomList?> Function(Ref, ListSource) build,
  ) {
    return ListSourceProvider._(
      argument: argument as String,
      from: from! as ListSourceFamily,
      runNotifierBuildOverride: build,
    );
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<ListSource, CustomList?> $createElement(
    $ProviderPointer pointer,
  ) => $AsyncNotifierProviderElement(this, pointer);

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

final class ListSourceFamily extends Family {
  const ListSourceFamily._()
    : super(
        retry: noRetry,
        name: r'listSourceProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ListSourceProvider call(String listId) =>
      ListSourceProvider._(argument: listId, from: this);

  @override
  String debugGetCreateSourceHash() => _$listSourceHash();

  @override
  String toString() => r'listSourceProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(ListSource Function(String args) create) {
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
      Ref ref,
      ListSource notifier,
      String argument,
    )
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

  FutureOr<CustomList?> build(String listId);
  @$internal
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<CustomList?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<CustomList?>>,
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
  const TagListProvider._({
    super.runNotifierBuildOverride,
    TagList Function()? create,
  }) : _createCb = create,
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
  TagListProvider $copyWithCreate(TagList Function() create) {
    return TagListProvider._(create: create);
  }

  @$internal
  @override
  TagListProvider $copyWithBuild(
    FutureOr<Iterable<Tag>> Function(Ref, TagList) build,
  ) {
    return TagListProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<TagList, Iterable<Tag>> $createElement(
    $ProviderPointer pointer,
  ) => $AsyncNotifierProviderElement(this, pointer);
}

String _$tagListHash() => r'7710550e802e80112d520dbd855732c41c68ab29';

abstract class _$TagList extends $AsyncNotifier<Iterable<Tag>> {
  FutureOr<Iterable<Tag>> build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Iterable<Tag>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<Iterable<Tag>>>,
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
  const StatisticsProvider._({
    super.runNotifierBuildOverride,
    Statistics Function()? create,
  }) : _createCb = create,
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
  StatisticsProvider $copyWithCreate(Statistics Function() create) {
    return StatisticsProvider._(create: create);
  }

  @$internal
  @override
  StatisticsProvider $copyWithBuild(
    FutureOr<Map<String, MangaStatistics>> Function(Ref, Statistics) build,
  ) {
    return StatisticsProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$StatisticsElement $createElement($ProviderPointer pointer) =>
      _$StatisticsElement(this, pointer);

  ProviderListenable<Statistics$Get> get get => $LazyProxyListenable<
    Statistics$Get,
    AsyncValue<Map<String, MangaStatistics>>
  >(this, (element) {
    element as _$StatisticsElement;

    return element._$get;
  });
}

String _$statisticsHash() => r'239a7a9095d0d55aefada8a1e7d64d09175443b3';

abstract class _$Statistics
    extends $AsyncNotifier<Map<String, MangaStatistics>> {
  FutureOr<Map<String, MangaStatistics>> build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Map<String, MangaStatistics>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<Map<String, MangaStatistics>>>,
              AsyncValue<Map<String, MangaStatistics>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$StatisticsElement
    extends
        $AsyncNotifierProviderElement<
          Statistics,
          Map<String, MangaStatistics>
        > {
  _$StatisticsElement(super.provider, super.pointer) {
    _$get.result = $Result.data(_$Statistics$Get(this));
  }
  final _$get = $ElementLense<_$Statistics$Get>();
  @override
  void mount() {
    super.mount();
    _$get.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

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
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, MangaStatistics>> call(Iterable<Manga> mangas);
}

final class _$Statistics$Get
    extends
        $AsyncMutationBase<
          Map<String, MangaStatistics>,
          _$Statistics$Get,
          Statistics
        >
    implements Statistics$Get {
  _$Statistics$Get(this.element, {super.state, super.key});

  @override
  final _$StatisticsElement element;

  @override
  $ElementLense<_$Statistics$Get> get listenable => element._$get;

  @override
  Future<Map<String, MangaStatistics>> call(Iterable<Manga> mangas) {
    return mutate(
      Invocation.method(#get, [mangas]),
      ($notifier) => $notifier.get(mangas),
    );
  }

  @override
  _$Statistics$Get copyWith(
    MutationState<Map<String, MangaStatistics>> state, {
    Object? key,
  }) => _$Statistics$Get(element, state: state, key: key);
}

@ProviderFor(ChapterStats)
const chapterStatsProvider = ChapterStatsProvider._();

final class ChapterStatsProvider
    extends
        $AsyncNotifierProvider<ChapterStats, Map<String, ChapterStatistics>> {
  const ChapterStatsProvider._({
    super.runNotifierBuildOverride,
    ChapterStats Function()? create,
  }) : _createCb = create,
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
  ChapterStatsProvider $copyWithCreate(ChapterStats Function() create) {
    return ChapterStatsProvider._(create: create);
  }

  @$internal
  @override
  ChapterStatsProvider $copyWithBuild(
    FutureOr<Map<String, ChapterStatistics>> Function(Ref, ChapterStats) build,
  ) {
    return ChapterStatsProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$ChapterStatsElement $createElement($ProviderPointer pointer) =>
      _$ChapterStatsElement(this, pointer);

  ProviderListenable<ChapterStats$Get> get get => $LazyProxyListenable<
    ChapterStats$Get,
    AsyncValue<Map<String, ChapterStatistics>>
  >(this, (element) {
    element as _$ChapterStatsElement;

    return element._$get;
  });
}

String _$chapterStatsHash() => r'6b0d401ef5fe20f1d08ca68ea63060a9382bbc3e';

abstract class _$ChapterStats
    extends $AsyncNotifier<Map<String, ChapterStatistics>> {
  FutureOr<Map<String, ChapterStatistics>> build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Map<String, ChapterStatistics>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<Map<String, ChapterStatistics>>>,
              AsyncValue<Map<String, ChapterStatistics>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$ChapterStatsElement
    extends
        $AsyncNotifierProviderElement<
          ChapterStats,
          Map<String, ChapterStatistics>
        > {
  _$ChapterStatsElement(super.provider, super.pointer) {
    _$get.result = $Result.data(_$ChapterStats$Get(this));
  }
  final _$get = $ElementLense<_$ChapterStats$Get>();
  @override
  void mount() {
    super.mount();
    _$get.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

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
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, ChapterStatistics>> call(Iterable<Chapter> chapters);
}

final class _$ChapterStats$Get
    extends
        $AsyncMutationBase<
          Map<String, ChapterStatistics>,
          _$ChapterStats$Get,
          ChapterStats
        >
    implements ChapterStats$Get {
  _$ChapterStats$Get(this.element, {super.state, super.key});

  @override
  final _$ChapterStatsElement element;

  @override
  $ElementLense<_$ChapterStats$Get> get listenable => element._$get;

  @override
  Future<Map<String, ChapterStatistics>> call(Iterable<Chapter> chapters) {
    return mutate(
      Invocation.method(#get, [chapters]),
      ($notifier) => $notifier.get(chapters),
    );
  }

  @override
  _$ChapterStats$Get copyWith(
    MutationState<Map<String, ChapterStatistics>> state, {
    Object? key,
  }) => _$ChapterStats$Get(element, state: state, key: key);
}

@ProviderFor(Ratings)
const ratingsProvider = RatingsFamily._();

final class RatingsProvider
    extends $AsyncNotifierProvider<Ratings, Map<String, SelfRating>> {
  const RatingsProvider._({
    required RatingsFamily super.from,
    required String? super.argument,
    super.runNotifierBuildOverride,
    Ratings Function()? create,
  }) : _createCb = create,
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
  RatingsProvider $copyWithCreate(Ratings Function() create) {
    return RatingsProvider._(
      argument: argument as String?,
      from: from! as RatingsFamily,
      create: create,
    );
  }

  @$internal
  @override
  RatingsProvider $copyWithBuild(
    FutureOr<Map<String, SelfRating>> Function(Ref, Ratings) build,
  ) {
    return RatingsProvider._(
      argument: argument as String?,
      from: from! as RatingsFamily,
      runNotifierBuildOverride: build,
    );
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

String _$ratingsHash() => r'4cbf0300ac8e1bac2ea41d0b575b47be0d942f1f';

final class RatingsFamily extends Family {
  const RatingsFamily._()
    : super(
        retry: null,
        name: r'ratingsProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  RatingsProvider call(String? userId) =>
      RatingsProvider._(argument: userId, from: this);

  @override
  String debugGetCreateSourceHash() => _$ratingsHash();

  @override
  String toString() => r'ratingsProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(Ratings Function(String? args) create) {
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
      Ref ref,
      Ratings notifier,
      String? argument,
    )
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

  FutureOr<Map<String, SelfRating>> build(String? userId);
  @$internal
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<Map<String, SelfRating>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<Map<String, SelfRating>>>,
              AsyncValue<Map<String, SelfRating>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
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
    _$get.result!.value!.reset();
    _$set.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

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
    return mutate(
      Invocation.method(#get, [mangas]),
      ($notifier) => $notifier.get(mangas),
    );
  }

  @override
  _$Ratings$Get copyWith(
    MutationState<Map<String, SelfRating>> state, {
    Object? key,
  }) => _$Ratings$Get(element, state: state, key: key);
}

sealed class Ratings$Set extends MutationBase<bool> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [Ratings.set] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<bool> call(Manga manga, int? rating);
}

final class _$Ratings$Set
    extends $AsyncMutationBase<bool, _$Ratings$Set, Ratings>
    implements Ratings$Set {
  _$Ratings$Set(this.element, {super.state, super.key});

  @override
  final _$RatingsElement element;

  @override
  $ElementLense<_$Ratings$Set> get listenable => element._$set;

  @override
  Future<bool> call(Manga manga, int? rating) {
    return mutate(
      Invocation.method(#set, [manga, rating]),
      ($notifier) => $notifier.set(manga, rating),
    );
  }

  @override
  _$Ratings$Set copyWith(MutationState<bool> state, {Object? key}) =>
      _$Ratings$Set(element, state: state, key: key);
}

@ProviderFor(ReadingStatus)
const readingStatusProvider = ReadingStatusFamily._();

final class ReadingStatusProvider
    extends $AsyncNotifierProvider<ReadingStatus, MangaReadingStatus?> {
  const ReadingStatusProvider._({
    required ReadingStatusFamily super.from,
    required Manga super.argument,
    super.runNotifierBuildOverride,
    ReadingStatus Function()? create,
  }) : _createCb = create,
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
  ReadingStatusProvider $copyWithCreate(ReadingStatus Function() create) {
    return ReadingStatusProvider._(
      argument: argument as Manga,
      from: from! as ReadingStatusFamily,
      create: create,
    );
  }

  @$internal
  @override
  ReadingStatusProvider $copyWithBuild(
    FutureOr<MangaReadingStatus?> Function(Ref, ReadingStatus) build,
  ) {
    return ReadingStatusProvider._(
      argument: argument as Manga,
      from: from! as ReadingStatusFamily,
      runNotifierBuildOverride: build,
    );
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

String _$readingStatusHash() => r'894553c73b09455414aba31e2363c6044e7e7947';

final class ReadingStatusFamily extends Family {
  const ReadingStatusFamily._()
    : super(
        retry: null,
        name: r'readingStatusProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReadingStatusProvider call(Manga manga) =>
      ReadingStatusProvider._(argument: manga, from: this);

  @override
  String debugGetCreateSourceHash() => _$readingStatusHash();

  @override
  String toString() => r'readingStatusProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(ReadingStatus Function(Manga args) create) {
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
      Ref ref,
      ReadingStatus notifier,
      Manga argument,
    )
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

  FutureOr<MangaReadingStatus?> build(Manga manga);
  @$internal
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<MangaReadingStatus?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<MangaReadingStatus?>>,
              AsyncValue<MangaReadingStatus?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
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
    _$set.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

    listenableVisitor(_$set);
  }
}

sealed class ReadingStatus$Set extends MutationBase<bool> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [ReadingStatus.set] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<bool> call(MangaReadingStatus? status);
}

final class _$ReadingStatus$Set
    extends $AsyncMutationBase<bool, _$ReadingStatus$Set, ReadingStatus>
    implements ReadingStatus$Set {
  _$ReadingStatus$Set(this.element, {super.state, super.key});

  @override
  final _$ReadingStatusElement element;

  @override
  $ElementLense<_$ReadingStatus$Set> get listenable => element._$set;

  @override
  Future<bool> call(MangaReadingStatus? status) {
    return mutate(
      Invocation.method(#set, [status]),
      ($notifier) => $notifier.set(status),
    );
  }

  @override
  _$ReadingStatus$Set copyWith(MutationState<bool> state, {Object? key}) =>
      _$ReadingStatus$Set(element, state: state, key: key);
}

@ProviderFor(FollowingStatus)
const followingStatusProvider = FollowingStatusFamily._();

final class FollowingStatusProvider
    extends $AsyncNotifierProvider<FollowingStatus, bool> {
  const FollowingStatusProvider._({
    required FollowingStatusFamily super.from,
    required Manga super.argument,
    super.runNotifierBuildOverride,
    FollowingStatus Function()? create,
  }) : _createCb = create,
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
  FollowingStatusProvider $copyWithCreate(FollowingStatus Function() create) {
    return FollowingStatusProvider._(
      argument: argument as Manga,
      from: from! as FollowingStatusFamily,
      create: create,
    );
  }

  @$internal
  @override
  FollowingStatusProvider $copyWithBuild(
    FutureOr<bool> Function(Ref, FollowingStatus) build,
  ) {
    return FollowingStatusProvider._(
      argument: argument as Manga,
      from: from! as FollowingStatusFamily,
      runNotifierBuildOverride: build,
    );
  }

  @$internal
  @override
  _$FollowingStatusElement $createElement($ProviderPointer pointer) =>
      _$FollowingStatusElement(this, pointer);

  ProviderListenable<FollowingStatus$Set> get set =>
      $LazyProxyListenable<FollowingStatus$Set, AsyncValue<bool>>(this, (
        element,
      ) {
        element as _$FollowingStatusElement;

        return element._$set;
      });

  @override
  bool operator ==(Object other) {
    return other is FollowingStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$followingStatusHash() => r'1de36b37907bc85db5d2581c90f5762e02d98f02';

final class FollowingStatusFamily extends Family {
  const FollowingStatusFamily._()
    : super(
        retry: null,
        name: r'followingStatusProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FollowingStatusProvider call(Manga manga) =>
      FollowingStatusProvider._(argument: manga, from: this);

  @override
  String debugGetCreateSourceHash() => _$followingStatusHash();

  @override
  String toString() => r'followingStatusProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(FollowingStatus Function(Manga args) create) {
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

  FutureOr<bool> build(Manga manga);
  @$internal
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<bool>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<bool>>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
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
    _$set.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

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
    return mutate(
      Invocation.method(#set, [following]),
      ($notifier) => $notifier.set(following),
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
  const MangaDexHistoryProvider._({
    super.runNotifierBuildOverride,
    MangaDexHistory Function()? create,
  }) : _createCb = create,
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
  MangaDexHistoryProvider $copyWithCreate(MangaDexHistory Function() create) {
    return MangaDexHistoryProvider._(create: create);
  }

  @$internal
  @override
  MangaDexHistoryProvider $copyWithBuild(
    FutureOr<Queue<Chapter>> Function(Ref, MangaDexHistory) build,
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

String _$mangaDexHistoryHash() => r'878b924c71458b17deb8e7f16a9e44ddf17fba91';

abstract class _$MangaDexHistory extends $AsyncNotifier<Queue<Chapter>> {
  FutureOr<Queue<Chapter>> build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Queue<Chapter>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<Queue<Chapter>>>,
              AsyncValue<Queue<Chapter>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
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
    _$add.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

    listenableVisitor(_$add);
  }
}

sealed class MangaDexHistory$Add extends MutationBase<Chapter> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [MangaDexHistory.add] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Chapter> call(Chapter chapter);
}

final class _$MangaDexHistory$Add
    extends $AsyncMutationBase<Chapter, _$MangaDexHistory$Add, MangaDexHistory>
    implements MangaDexHistory$Add {
  _$MangaDexHistory$Add(this.element, {super.state, super.key});

  @override
  final _$MangaDexHistoryElement element;

  @override
  $ElementLense<_$MangaDexHistory$Add> get listenable => element._$add;

  @override
  Future<Chapter> call(Chapter chapter) {
    return mutate(
      Invocation.method(#add, [chapter]),
      ($notifier) => $notifier.add(chapter),
    );
  }

  @override
  _$MangaDexHistory$Add copyWith(MutationState<Chapter> state, {Object? key}) =>
      _$MangaDexHistory$Add(element, state: state, key: key);
}

@ProviderFor(LoggedUser)
const loggedUserProvider = LoggedUserProvider._();

final class LoggedUserProvider
    extends $AsyncNotifierProvider<LoggedUser, User?> {
  const LoggedUserProvider._({
    super.runNotifierBuildOverride,
    LoggedUser Function()? create,
  }) : _createCb = create,
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
  LoggedUserProvider $copyWithCreate(LoggedUser Function() create) {
    return LoggedUserProvider._(create: create);
  }

  @$internal
  @override
  LoggedUserProvider $copyWithBuild(
    FutureOr<User?> Function(Ref, LoggedUser) build,
  ) {
    return LoggedUserProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<LoggedUser, User?> $createElement(
    $ProviderPointer pointer,
  ) => $AsyncNotifierProviderElement(this, pointer);
}

String _$loggedUserHash() => r'661369d0e4ee922b460c6c3a86c32eaac36a80fa';

abstract class _$LoggedUser extends $AsyncNotifier<User?> {
  FutureOr<User?> build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<User?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<User?>>,
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
    extends $AsyncNotifierProvider<AuthControl, bool> {
  const AuthControlProvider._({
    super.runNotifierBuildOverride,
    AuthControl Function()? create,
  }) : _createCb = create,
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
  AuthControlProvider $copyWithCreate(AuthControl Function() create) {
    return AuthControlProvider._(create: create);
  }

  @$internal
  @override
  AuthControlProvider $copyWithBuild(
    FutureOr<bool> Function(Ref, AuthControl) build,
  ) {
    return AuthControlProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$AuthControlElement $createElement($ProviderPointer pointer) =>
      _$AuthControlElement(this, pointer);

  ProviderListenable<AuthControl$Login> get login =>
      $LazyProxyListenable<AuthControl$Login, AsyncValue<bool>>(this, (
        element,
      ) {
        element as _$AuthControlElement;

        return element._$login;
      });

  ProviderListenable<AuthControl$Logout> get logout =>
      $LazyProxyListenable<AuthControl$Logout, AsyncValue<bool>>(this, (
        element,
      ) {
        element as _$AuthControlElement;

        return element._$logout;
      });
}

String _$authControlHash() => r'74fa09c8df5d9ceef2fc2d4a4f8a80a7a34ef14a';

abstract class _$AuthControl extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<AsyncValue<bool>>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
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
    _$login.result!.value!.reset();
    _$logout.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

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
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<bool> call(
    String user,
    String pass,
    String clientId,
    String clientSecret,
  );
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
    String user,
    String pass,
    String clientId,
    String clientSecret,
  ) {
    return mutate(
      Invocation.method(#login, [user, pass, clientId, clientSecret]),
      ($notifier) => $notifier.login(user, pass, clientId, clientSecret),
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
    return mutate(
      Invocation.method(#logout, []),
      ($notifier) => $notifier.logout(),
    );
  }

  @override
  _$AuthControl$Logout copyWith(MutationState<bool> state, {Object? key}) =>
      _$AuthControl$Logout(element, state: state, key: key);
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
