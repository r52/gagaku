// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frontpage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _PopularTitlesRef = Ref<AsyncValue<List<Manga>>>;

@ProviderFor(_popularTitles)
const _popularTitlesProvider = _PopularTitlesProvider._();

final class _PopularTitlesProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with
        $FutureModifier<List<Manga>>,
        $FutureProvider<List<Manga>, _PopularTitlesRef> {
  const _PopularTitlesProvider._(
      {FutureOr<List<Manga>> Function(
        _PopularTitlesRef ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: noRetry,
          name: r'_popularTitlesProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<Manga>> Function(
    _PopularTitlesRef ref,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$popularTitlesHash();

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _PopularTitlesProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(
      _PopularTitlesRef ref,
    ) create,
  ) {
    return _PopularTitlesProvider._(create: create);
  }

  @override
  FutureOr<List<Manga>> create(_PopularTitlesRef ref) {
    final _$cb = _createCb ?? _popularTitles;
    return _$cb(ref);
  }
}

String _$popularTitlesHash() => r'3e3dd7db23591547693673d72487f8b5b108fbc6';

typedef _RecentlyAddedRef = Ref<AsyncValue<List<Manga>>>;

@ProviderFor(_recentlyAdded)
const _recentlyAddedProvider = _RecentlyAddedProvider._();

final class _RecentlyAddedProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with
        $FutureModifier<List<Manga>>,
        $FutureProvider<List<Manga>, _RecentlyAddedRef> {
  const _RecentlyAddedProvider._(
      {FutureOr<List<Manga>> Function(
        _RecentlyAddedRef ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: noRetry,
          name: r'_recentlyAddedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<Manga>> Function(
    _RecentlyAddedRef ref,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$recentlyAddedHash();

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _RecentlyAddedProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(
      _RecentlyAddedRef ref,
    ) create,
  ) {
    return _RecentlyAddedProvider._(create: create);
  }

  @override
  FutureOr<List<Manga>> create(_RecentlyAddedRef ref) {
    final _$cb = _createCb ?? _recentlyAdded;
    return _$cb(ref);
  }
}

String _$recentlyAddedHash() => r'549bd9c62f2ce2ad5336a6d8e753c7248b7e55c9';

typedef _LatestUpdatesRef = Ref<AsyncValue<List<Manga>>>;

@ProviderFor(_latestUpdates)
const _latestUpdatesProvider = _LatestUpdatesProvider._();

final class _LatestUpdatesProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with
        $FutureModifier<List<Manga>>,
        $FutureProvider<List<Manga>, _LatestUpdatesRef> {
  const _LatestUpdatesProvider._(
      {FutureOr<List<Manga>> Function(
        _LatestUpdatesRef ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: noRetry,
          name: r'_latestUpdatesProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<Manga>> Function(
    _LatestUpdatesRef ref,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$latestUpdatesHash();

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _LatestUpdatesProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(
      _LatestUpdatesRef ref,
    ) create,
  ) {
    return _LatestUpdatesProvider._(create: create);
  }

  @override
  FutureOr<List<Manga>> create(_LatestUpdatesRef ref) {
    final _$cb = _createCb ?? _latestUpdates;
    return _$cb(ref);
  }
}

String _$latestUpdatesHash() => r'ca3c517ed27d802704ceb8b9497617ee4c33da7f';

typedef _FetchCustomListMangaRef = Ref<AsyncValue<List<Manga>>>;

@ProviderFor(_fetchCustomListManga)
const _fetchCustomListMangaProvider = _FetchCustomListMangaFamily._();

final class _FetchCustomListMangaProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with
        $FutureModifier<List<Manga>>,
        $FutureProvider<List<Manga>, _FetchCustomListMangaRef> {
  const _FetchCustomListMangaProvider._(
      {required _FetchCustomListMangaFamily super.from,
      required String super.argument,
      FutureOr<List<Manga>> Function(
        _FetchCustomListMangaRef ref,
        String listid,
      )? create})
      : _createCb = create,
        super(
          retry: noRetry,
          name: r'_fetchCustomListMangaProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<Manga>> Function(
    _FetchCustomListMangaRef ref,
    String listid,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchCustomListMangaHash();

  @override
  String toString() {
    return r'_fetchCustomListMangaProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchCustomListMangaProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(
      _FetchCustomListMangaRef ref,
    ) create,
  ) {
    return _FetchCustomListMangaProvider._(
        argument: argument as String,
        from: from! as _FetchCustomListMangaFamily,
        create: (
          ref,
          String listid,
        ) =>
            create(ref));
  }

  @override
  FutureOr<List<Manga>> create(_FetchCustomListMangaRef ref) {
    final _$cb = _createCb ?? _fetchCustomListManga;
    final argument = this.argument as String;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchCustomListMangaProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchCustomListMangaHash() =>
    r'62a0353c93fce0ca94c66dee7883e3c9e5d7bb90';

final class _FetchCustomListMangaFamily extends Family {
  const _FetchCustomListMangaFamily._()
      : super(
          retry: noRetry,
          name: r'_fetchCustomListMangaProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchCustomListMangaProvider call(
    String listid,
  ) =>
      _FetchCustomListMangaProvider._(argument: listid, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchCustomListMangaHash();

  @override
  String toString() => r'_fetchCustomListMangaProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<Manga>> Function(
      _FetchCustomListMangaRef ref,
      String args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchCustomListMangaProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
