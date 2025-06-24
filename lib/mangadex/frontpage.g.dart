// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frontpage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_popularTitles)
const _popularTitlesProvider = _PopularTitlesProvider._();

final class _PopularTitlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Manga>>,
          List<Manga>,
          FutureOr<List<Manga>>
        >
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _PopularTitlesProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'_popularTitlesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popularTitlesHash();

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Manga>> create(Ref ref) {
    return _popularTitles(ref);
  }
}

String _$popularTitlesHash() => r'bd736590bbe6e6adcb7fbb060e3794725e3fc049';

@ProviderFor(_recentlyAdded)
const _recentlyAddedProvider = _RecentlyAddedProvider._();

final class _RecentlyAddedProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Manga>>,
          List<Manga>,
          FutureOr<List<Manga>>
        >
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _RecentlyAddedProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'_recentlyAddedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentlyAddedHash();

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Manga>> create(Ref ref) {
    return _recentlyAdded(ref);
  }
}

String _$recentlyAddedHash() => r'c674998b67a04d66d78727ed66605b1af2dfa8db';

@ProviderFor(_latestUpdates)
const _latestUpdatesProvider = _LatestUpdatesProvider._();

final class _LatestUpdatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Manga>>,
          List<Manga>,
          FutureOr<List<Manga>>
        >
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _LatestUpdatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'_latestUpdatesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$latestUpdatesHash();

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Manga>> create(Ref ref) {
    return _latestUpdates(ref);
  }
}

String _$latestUpdatesHash() => r'7681a094cf7bb2e9c23ef54b0bd3d06a8fc198ec';

@ProviderFor(_fetchCustomListManga)
const _fetchCustomListMangaProvider = _FetchCustomListMangaFamily._();

final class _FetchCustomListMangaProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Manga>>,
          List<Manga>,
          FutureOr<List<Manga>>
        >
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _FetchCustomListMangaProvider._({
    required _FetchCustomListMangaFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'_fetchCustomListMangaProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Manga>> create(Ref ref) {
    final argument = this.argument as String;
    return _fetchCustomListManga(ref, argument);
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

final class _FetchCustomListMangaFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Manga>>, String> {
  const _FetchCustomListMangaFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchCustomListMangaProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchCustomListMangaProvider call(String listid) =>
      _FetchCustomListMangaProvider._(argument: listid, from: this);

  @override
  String toString() => r'_fetchCustomListMangaProvider';
}

@ProviderFor(_fetchFrontPageData)
const _fetchFrontPageDataProvider = _FetchFrontPageDataProvider._();

final class _FetchFrontPageDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<FrontPageData>,
          FrontPageData,
          FutureOr<FrontPageData>
        >
    with $FutureModifier<FrontPageData>, $FutureProvider<FrontPageData> {
  const _FetchFrontPageDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'_fetchFrontPageDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchFrontPageDataHash();

  @$internal
  @override
  $FutureProviderElement<FrontPageData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FrontPageData> create(Ref ref) {
    return _fetchFrontPageData(ref);
  }
}

String _$fetchFrontPageDataHash() =>
    r'245417f155ec4ebbefb21699348d9bf828acaeff';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
