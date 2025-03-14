// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_SearchHistory)
const _searchHistoryProvider = _SearchHistoryProvider._();

final class _SearchHistoryProvider
    extends $NotifierProvider<_SearchHistory, List<String>> {
  const _SearchHistoryProvider._({
    super.runNotifierBuildOverride,
    _SearchHistory Function()? create,
  }) : _createCb = create,
       super(
         from: null,
         argument: null,
         retry: null,
         name: r'_searchHistoryProvider',
         isAutoDispose: false,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final _SearchHistory Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$searchHistoryHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<List<String>>(value),
    );
  }

  @$internal
  @override
  _SearchHistory create() => _createCb?.call() ?? _SearchHistory();

  @$internal
  @override
  _SearchHistoryProvider $copyWithCreate(_SearchHistory Function() create) {
    return _SearchHistoryProvider._(create: create);
  }

  @$internal
  @override
  _SearchHistoryProvider $copyWithBuild(
    List<String> Function(Ref, _SearchHistory) build,
  ) {
    return _SearchHistoryProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<_SearchHistory, List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(this, pointer);
}

String _$searchHistoryHash() => r'03b2bdeb09ccc897e60e3e498de7f80aa8df9377';

abstract class _$SearchHistory extends $Notifier<List<String>> {
  List<String> build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(_SearchParams)
const _searchParamsProvider = _SearchParamsProvider._();

final class _SearchParamsProvider
    extends $NotifierProvider<_SearchParams, MangaSearchParameters> {
  const _SearchParamsProvider._({
    super.runNotifierBuildOverride,
    _SearchParams Function()? create,
  }) : _createCb = create,
       super(
         from: null,
         argument: null,
         retry: null,
         name: r'_searchParamsProvider',
         isAutoDispose: false,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final _SearchParams Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$searchParamsHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MangaSearchParameters value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<MangaSearchParameters>(value),
    );
  }

  @$internal
  @override
  _SearchParams create() => _createCb?.call() ?? _SearchParams();

  @$internal
  @override
  _SearchParamsProvider $copyWithCreate(_SearchParams Function() create) {
    return _SearchParamsProvider._(create: create);
  }

  @$internal
  @override
  _SearchParamsProvider $copyWithBuild(
    MangaSearchParameters Function(Ref, _SearchParams) build,
  ) {
    return _SearchParamsProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<_SearchParams, MangaSearchParameters> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(this, pointer);
}

String _$searchParamsHash() => r'f582a835c216b1a198b6d5c3357f2e354b05cf68';

abstract class _$SearchParams extends $Notifier<MangaSearchParameters> {
  MangaSearchParameters build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MangaSearchParameters>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<MangaSearchParameters>,
              MangaSearchParameters,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
