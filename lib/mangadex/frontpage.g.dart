// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frontpage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_popularTitles)
const _popularTitlesProvider = _PopularTitlesProvider._();

final class _PopularTitlesProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _PopularTitlesProvider._({
    FutureOr<List<Manga>> Function(Ref ref)? create,
  }) : _createCb = create,
       super(
         from: null,
         argument: null,
         retry: noRetry,
         name: r'_popularTitlesProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<List<Manga>> Function(Ref ref)? _createCb;

  @override
  String debugGetCreateSourceHash() => _$popularTitlesHash();

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(this, pointer);

  @override
  _PopularTitlesProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(Ref ref) create,
  ) {
    return _PopularTitlesProvider._(create: create);
  }

  @override
  FutureOr<List<Manga>> create(Ref ref) {
    final _$cb = _createCb ?? _popularTitles;
    return _$cb(ref);
  }
}

String _$popularTitlesHash() => r'bd736590bbe6e6adcb7fbb060e3794725e3fc049';

@ProviderFor(_recentlyAdded)
const _recentlyAddedProvider = _RecentlyAddedProvider._();

final class _RecentlyAddedProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _RecentlyAddedProvider._({
    FutureOr<List<Manga>> Function(Ref ref)? create,
  }) : _createCb = create,
       super(
         from: null,
         argument: null,
         retry: noRetry,
         name: r'_recentlyAddedProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<List<Manga>> Function(Ref ref)? _createCb;

  @override
  String debugGetCreateSourceHash() => _$recentlyAddedHash();

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(this, pointer);

  @override
  _RecentlyAddedProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(Ref ref) create,
  ) {
    return _RecentlyAddedProvider._(create: create);
  }

  @override
  FutureOr<List<Manga>> create(Ref ref) {
    final _$cb = _createCb ?? _recentlyAdded;
    return _$cb(ref);
  }
}

String _$recentlyAddedHash() => r'c674998b67a04d66d78727ed66605b1af2dfa8db';

@ProviderFor(_latestUpdates)
const _latestUpdatesProvider = _LatestUpdatesProvider._();

final class _LatestUpdatesProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _LatestUpdatesProvider._({
    FutureOr<List<Manga>> Function(Ref ref)? create,
  }) : _createCb = create,
       super(
         from: null,
         argument: null,
         retry: noRetry,
         name: r'_latestUpdatesProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<List<Manga>> Function(Ref ref)? _createCb;

  @override
  String debugGetCreateSourceHash() => _$latestUpdatesHash();

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(this, pointer);

  @override
  _LatestUpdatesProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(Ref ref) create,
  ) {
    return _LatestUpdatesProvider._(create: create);
  }

  @override
  FutureOr<List<Manga>> create(Ref ref) {
    final _$cb = _createCb ?? _latestUpdates;
    return _$cb(ref);
  }
}

String _$latestUpdatesHash() => r'7681a094cf7bb2e9c23ef54b0bd3d06a8fc198ec';

@ProviderFor(_fetchCustomListManga)
const _fetchCustomListMangaProvider = _FetchCustomListMangaFamily._();

final class _FetchCustomListMangaProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _FetchCustomListMangaProvider._({
    required _FetchCustomListMangaFamily super.from,
    required String super.argument,
    FutureOr<List<Manga>> Function(Ref ref, String listid)? create,
  }) : _createCb = create,
       super(
         retry: noRetry,
         name: r'_fetchCustomListMangaProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<List<Manga>> Function(Ref ref, String listid)? _createCb;

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
    $ProviderPointer pointer,
  ) => $FutureProviderElement(this, pointer);

  @override
  _FetchCustomListMangaProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(Ref ref) create,
  ) {
    return _FetchCustomListMangaProvider._(
      argument: argument as String,
      from: from! as _FetchCustomListMangaFamily,
      create: (ref, String listid) => create(ref),
    );
  }

  @override
  FutureOr<List<Manga>> create(Ref ref) {
    final _$cb = _createCb ?? _fetchCustomListManga;
    final argument = this.argument as String;
    return _$cb(ref, argument);
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
    r'648d090100f7187d80742bc2314663f501e62bc1';

final class _FetchCustomListMangaFamily extends Family {
  const _FetchCustomListMangaFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchCustomListMangaProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchCustomListMangaProvider call(String listid) =>
      _FetchCustomListMangaProvider._(argument: listid, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchCustomListMangaHash();

  @override
  String toString() => r'_fetchCustomListMangaProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<Manga>> Function(Ref ref, String args) create,
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

@ProviderFor(_fetchFrontPageData)
const _fetchFrontPageDataProvider = _FetchFrontPageDataProvider._();

final class _FetchFrontPageDataProvider
    extends
        $FunctionalProvider<AsyncValue<FrontPageData>, FutureOr<FrontPageData>>
    with $FutureModifier<FrontPageData>, $FutureProvider<FrontPageData> {
  const _FetchFrontPageDataProvider._({
    FutureOr<FrontPageData> Function(Ref ref)? create,
  }) : _createCb = create,
       super(
         from: null,
         argument: null,
         retry: noRetry,
         name: r'_fetchFrontPageDataProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<FrontPageData> Function(Ref ref)? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchFrontPageDataHash();

  @$internal
  @override
  $FutureProviderElement<FrontPageData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(this, pointer);

  @override
  _FetchFrontPageDataProvider $copyWithCreate(
    FutureOr<FrontPageData> Function(Ref ref) create,
  ) {
    return _FetchFrontPageDataProvider._(create: create);
  }

  @override
  FutureOr<FrontPageData> create(Ref ref) {
    final _$cb = _createCb ?? _fetchFrontPageData;
    return _$cb(ref);
  }
}

String _$fetchFrontPageDataHash() =>
    r'245417f155ec4ebbefb21699348d9bf828acaeff';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
