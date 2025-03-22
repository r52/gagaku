// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchTagFromId)
const _fetchTagFromIdProvider = _FetchTagFromIdFamily._();

final class _FetchTagFromIdProvider
    extends $FunctionalProvider<AsyncValue<Tag>, FutureOr<Tag>>
    with $FutureModifier<Tag>, $FutureProvider<Tag> {
  const _FetchTagFromIdProvider._({
    required _FetchTagFromIdFamily super.from,
    required String super.argument,
    FutureOr<Tag> Function(Ref ref, String tagId)? create,
  }) : _createCb = create,
       super(
         retry: noRetry,
         name: r'_fetchTagFromIdProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<Tag> Function(Ref ref, String tagId)? _createCb;

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
      $FutureProviderElement(this, pointer);

  @override
  _FetchTagFromIdProvider $copyWithCreate(
    FutureOr<Tag> Function(Ref ref) create,
  ) {
    return _FetchTagFromIdProvider._(
      argument: argument as String,
      from: from! as _FetchTagFromIdFamily,
      create: (ref, String tagId) => create(ref),
    );
  }

  @override
  FutureOr<Tag> create(Ref ref) {
    final _$cb = _createCb ?? _fetchTagFromId;
    final argument = this.argument as String;
    return _$cb(ref, argument);
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

final class _FetchTagFromIdFamily extends Family {
  const _FetchTagFromIdFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchTagFromIdProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchTagFromIdProvider call(String tagId) =>
      _FetchTagFromIdProvider._(argument: tagId, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchTagFromIdHash();

  @override
  String toString() => r'_fetchTagFromIdProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(FutureOr<Tag> Function(Ref ref, String args) create) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchTagFromIdProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

@ProviderFor(_trendingThisYear)
const _trendingThisYearProvider = _TrendingThisYearFamily._();

final class _TrendingThisYearProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _TrendingThisYearProvider._({
    required _TrendingThisYearFamily super.from,
    required Tag super.argument,
    FutureOr<List<Manga>> Function(Ref ref, Tag tag)? create,
  }) : _createCb = create,
       super(
         retry: noRetry,
         name: r'_trendingThisYearProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<List<Manga>> Function(Ref ref, Tag tag)? _createCb;

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
  ) => $FutureProviderElement(this, pointer);

  @override
  _TrendingThisYearProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(Ref ref) create,
  ) {
    return _TrendingThisYearProvider._(
      argument: argument as Tag,
      from: from! as _TrendingThisYearFamily,
      create: (ref, Tag tag) => create(ref),
    );
  }

  @override
  FutureOr<List<Manga>> create(Ref ref) {
    final _$cb = _createCb ?? _trendingThisYear;
    final argument = this.argument as Tag;
    return _$cb(ref, argument);
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

final class _TrendingThisYearFamily extends Family {
  const _TrendingThisYearFamily._()
    : super(
        retry: noRetry,
        name: r'_trendingThisYearProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _TrendingThisYearProvider call(Tag tag) =>
      _TrendingThisYearProvider._(argument: tag, from: this);

  @override
  String debugGetCreateSourceHash() => _$trendingThisYearHash();

  @override
  String toString() => r'_trendingThisYearProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<Manga>> Function(Ref ref, Tag args) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _TrendingThisYearProvider;

        final argument = provider.argument as Tag;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

@ProviderFor(_recentlyAdded)
const _recentlyAddedProvider = _RecentlyAddedFamily._();

final class _RecentlyAddedProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _RecentlyAddedProvider._({
    required _RecentlyAddedFamily super.from,
    required Tag super.argument,
    FutureOr<List<Manga>> Function(Ref ref, Tag tag)? create,
  }) : _createCb = create,
       super(
         retry: noRetry,
         name: r'_recentlyAddedProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<List<Manga>> Function(Ref ref, Tag tag)? _createCb;

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
  ) => $FutureProviderElement(this, pointer);

  @override
  _RecentlyAddedProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(Ref ref) create,
  ) {
    return _RecentlyAddedProvider._(
      argument: argument as Tag,
      from: from! as _RecentlyAddedFamily,
      create: (ref, Tag tag) => create(ref),
    );
  }

  @override
  FutureOr<List<Manga>> create(Ref ref) {
    final _$cb = _createCb ?? _recentlyAdded;
    final argument = this.argument as Tag;
    return _$cb(ref, argument);
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

final class _RecentlyAddedFamily extends Family {
  const _RecentlyAddedFamily._()
    : super(
        retry: noRetry,
        name: r'_recentlyAddedProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _RecentlyAddedProvider call(Tag tag) =>
      _RecentlyAddedProvider._(argument: tag, from: this);

  @override
  String debugGetCreateSourceHash() => _$recentlyAddedHash();

  @override
  String toString() => r'_recentlyAddedProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<Manga>> Function(Ref ref, Tag args) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _RecentlyAddedProvider;

        final argument = provider.argument as Tag;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
