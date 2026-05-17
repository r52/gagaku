// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frontpage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_popularTitles)
final _popularTitlesProvider = _PopularTitlesProvider._();

final class _PopularTitlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Manga>>,
          List<Manga>,
          FutureOr<List<Manga>>
        >
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  _PopularTitlesProvider._()
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
  String debugGetCreateSourceHash() => _$_popularTitlesHash();

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

String _$_popularTitlesHash() => r'd1f3dcdfc2a1f69bc9c1593f4dacf51c9de15f9e';

@ProviderFor(_recentlyAdded)
final _recentlyAddedProvider = _RecentlyAddedProvider._();

final class _RecentlyAddedProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Manga>>,
          List<Manga>,
          FutureOr<List<Manga>>
        >
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  _RecentlyAddedProvider._()
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
  String debugGetCreateSourceHash() => _$_recentlyAddedHash();

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

String _$_recentlyAddedHash() => r'c62da84fd51b626344a62554b18b8be768eae30d';

@ProviderFor(_latestUpdates)
final _latestUpdatesProvider = _LatestUpdatesProvider._();

final class _LatestUpdatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Manga>>,
          List<Manga>,
          FutureOr<List<Manga>>
        >
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  _LatestUpdatesProvider._()
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
  String debugGetCreateSourceHash() => _$_latestUpdatesHash();

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

String _$_latestUpdatesHash() => r'e53fe8e044cf7b73529f44a8d5c41f53996ebfaa';

@ProviderFor(_fetchCustomListManga)
final _fetchCustomListMangaProvider = _FetchCustomListMangaFamily._();

final class _FetchCustomListMangaProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Manga>>,
          List<Manga>,
          FutureOr<List<Manga>>
        >
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  _FetchCustomListMangaProvider._({
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
  String debugGetCreateSourceHash() => _$_fetchCustomListMangaHash();

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

String _$_fetchCustomListMangaHash() =>
    r'648d090100f7187d80742bc2314663f501e62bc1';

final class _FetchCustomListMangaFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Manga>>, String> {
  _FetchCustomListMangaFamily._()
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
final _fetchFrontPageDataProvider = _FetchFrontPageDataProvider._();

final class _FetchFrontPageDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<FrontPageData>,
          FrontPageData,
          FutureOr<FrontPageData>
        >
    with $FutureModifier<FrontPageData>, $FutureProvider<FrontPageData> {
  _FetchFrontPageDataProvider._()
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
  String debugGetCreateSourceHash() => _$_fetchFrontPageDataHash();

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

String _$_fetchFrontPageDataHash() =>
    r'245417f155ec4ebbefb21699348d9bf828acaeff';
