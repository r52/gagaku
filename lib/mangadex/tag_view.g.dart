// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchTagFromId)
const _fetchTagFromIdProvider = _FetchTagFromIdFamily._();

final class _FetchTagFromIdProvider
    extends $FunctionalProvider<AsyncValue<Tag>, Tag, FutureOr<Tag>>
    with $FutureModifier<Tag>, $FutureProvider<Tag> {
  const _FetchTagFromIdProvider._({
    required _FetchTagFromIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'_fetchTagFromIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchTagFromIdHash();

  @override
  String toString() {
    return r'_fetchTagFromIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Tag> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Tag> create(Ref ref) {
    final argument = this.argument as String;
    return _fetchTagFromId(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchTagFromIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchTagFromIdHash() => r'2c3e3ce63b6f16972e9614f7e4b35c823accb4b8';

final class _FetchTagFromIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Tag>, String> {
  const _FetchTagFromIdFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchTagFromIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchTagFromIdProvider call(String tagId) =>
      _FetchTagFromIdProvider._(argument: tagId, from: this);

  @override
  String toString() => r'_fetchTagFromIdProvider';
}

@ProviderFor(_trendingThisYear)
const _trendingThisYearProvider = _TrendingThisYearFamily._();

final class _TrendingThisYearProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Manga>>,
          List<Manga>,
          FutureOr<List<Manga>>
        >
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _TrendingThisYearProvider._({
    required _TrendingThisYearFamily super.from,
    required Tag super.argument,
  }) : super(
         retry: noRetry,
         name: r'_trendingThisYearProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$trendingThisYearHash();

  @override
  String toString() {
    return r'_trendingThisYearProvider'
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
    final argument = this.argument as Tag;
    return _trendingThisYear(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _TrendingThisYearProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$trendingThisYearHash() => r'47ab90f1630dc5d55dd7ae5fea6f357bf4b6b497';

final class _TrendingThisYearFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Manga>>, Tag> {
  const _TrendingThisYearFamily._()
    : super(
        retry: noRetry,
        name: r'_trendingThisYearProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _TrendingThisYearProvider call(Tag tag) =>
      _TrendingThisYearProvider._(argument: tag, from: this);

  @override
  String toString() => r'_trendingThisYearProvider';
}

@ProviderFor(_recentlyAdded)
const _recentlyAddedProvider = _RecentlyAddedFamily._();

final class _RecentlyAddedProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Manga>>,
          List<Manga>,
          FutureOr<List<Manga>>
        >
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _RecentlyAddedProvider._({
    required _RecentlyAddedFamily super.from,
    required Tag super.argument,
  }) : super(
         retry: noRetry,
         name: r'_recentlyAddedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$recentlyAddedHash();

  @override
  String toString() {
    return r'_recentlyAddedProvider'
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
    final argument = this.argument as Tag;
    return _recentlyAdded(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _RecentlyAddedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$recentlyAddedHash() => r'db80c62e64ad17d0dc404af963c83b475bd891dd';

final class _RecentlyAddedFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Manga>>, Tag> {
  const _RecentlyAddedFamily._()
    : super(
        retry: noRetry,
        name: r'_recentlyAddedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _RecentlyAddedProvider call(Tag tag) =>
      _RecentlyAddedProvider._(argument: tag, from: this);

  @override
  String toString() => r'_recentlyAddedProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
