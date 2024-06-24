// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _FetchGroupFromIdRef = Ref<AsyncValue<Group>>;

@ProviderFor(_fetchGroupFromId)
const _fetchGroupFromIdProvider = _FetchGroupFromIdFamily._();

final class _FetchGroupFromIdProvider
    extends $FunctionalProvider<AsyncValue<Group>, FutureOr<Group>>
    with $FutureModifier<Group>, $FutureProvider<Group, _FetchGroupFromIdRef> {
  const _FetchGroupFromIdProvider._(
      {required _FetchGroupFromIdFamily super.from,
      required String super.argument,
      FutureOr<Group> Function(
        _FetchGroupFromIdRef ref,
        String groupId,
      )? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'_fetchGroupFromIdProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<Group> Function(
    _FetchGroupFromIdRef ref,
    String groupId,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchGroupFromIdHash();

  @override
  String toString() {
    return r'_fetchGroupFromIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Group> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchGroupFromIdProvider $copyWithCreate(
    FutureOr<Group> Function(
      _FetchGroupFromIdRef ref,
    ) create,
  ) {
    return _FetchGroupFromIdProvider._(
        argument: argument as String,
        from: from! as _FetchGroupFromIdFamily,
        create: (
          ref,
          String groupId,
        ) =>
            create(ref));
  }

  @override
  FutureOr<Group> create(_FetchGroupFromIdRef ref) {
    final _$cb = _createCb ?? _fetchGroupFromId;
    final argument = this.argument as String;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchGroupFromIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchGroupFromIdHash() => r'e3d4cc80e72975244b843d666e4bc7876ba2132c';

final class _FetchGroupFromIdFamily extends Family {
  const _FetchGroupFromIdFamily._()
      : super(
          retry: null,
          name: r'_fetchGroupFromIdProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchGroupFromIdProvider call(
    String groupId,
  ) =>
      _FetchGroupFromIdProvider._(argument: groupId, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchGroupFromIdHash();

  @override
  String toString() => r'_fetchGroupFromIdProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<Group> Function(
      _FetchGroupFromIdRef ref,
      String args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchGroupFromIdProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

typedef _FetchGroupFeedRef = Ref<AsyncValue<List<ChapterFeedItemData>>>;

@ProviderFor(_fetchGroupFeed)
const _fetchGroupFeedProvider = _FetchGroupFeedFamily._();

final class _FetchGroupFeedProvider extends $FunctionalProvider<
        AsyncValue<List<ChapterFeedItemData>>,
        FutureOr<List<ChapterFeedItemData>>>
    with
        $FutureModifier<List<ChapterFeedItemData>>,
        $FutureProvider<List<ChapterFeedItemData>, _FetchGroupFeedRef> {
  const _FetchGroupFeedProvider._(
      {required _FetchGroupFeedFamily super.from,
      required Group super.argument,
      FutureOr<List<ChapterFeedItemData>> Function(
        _FetchGroupFeedRef ref,
        Group group,
      )? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'_fetchGroupFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ChapterFeedItemData>> Function(
    _FetchGroupFeedRef ref,
    Group group,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchGroupFeedHash();

  @override
  String toString() {
    return r'_fetchGroupFeedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ChapterFeedItemData>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchGroupFeedProvider $copyWithCreate(
    FutureOr<List<ChapterFeedItemData>> Function(
      _FetchGroupFeedRef ref,
    ) create,
  ) {
    return _FetchGroupFeedProvider._(
        argument: argument as Group,
        from: from! as _FetchGroupFeedFamily,
        create: (
          ref,
          Group group,
        ) =>
            create(ref));
  }

  @override
  FutureOr<List<ChapterFeedItemData>> create(_FetchGroupFeedRef ref) {
    final _$cb = _createCb ?? _fetchGroupFeed;
    final argument = this.argument as Group;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchGroupFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchGroupFeedHash() => r'7c30d812393caeb6cd791886a37a318e16b5578f';

final class _FetchGroupFeedFamily extends Family {
  const _FetchGroupFeedFamily._()
      : super(
          retry: null,
          name: r'_fetchGroupFeedProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchGroupFeedProvider call(
    Group group,
  ) =>
      _FetchGroupFeedProvider._(argument: group, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchGroupFeedHash();

  @override
  String toString() => r'_fetchGroupFeedProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<ChapterFeedItemData>> Function(
      _FetchGroupFeedRef ref,
      Group args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchGroupFeedProvider;

        final argument = provider.argument as Group;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

typedef _FetchGroupTitlesRef = Ref<AsyncValue<List<Manga>>>;

@ProviderFor(_fetchGroupTitles)
const _fetchGroupTitlesProvider = _FetchGroupTitlesFamily._();

final class _FetchGroupTitlesProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with
        $FutureModifier<List<Manga>>,
        $FutureProvider<List<Manga>, _FetchGroupTitlesRef> {
  const _FetchGroupTitlesProvider._(
      {required _FetchGroupTitlesFamily super.from,
      required Group super.argument,
      FutureOr<List<Manga>> Function(
        _FetchGroupTitlesRef ref,
        Group group,
      )? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'_fetchGroupTitlesProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<Manga>> Function(
    _FetchGroupTitlesRef ref,
    Group group,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchGroupTitlesHash();

  @override
  String toString() {
    return r'_fetchGroupTitlesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchGroupTitlesProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(
      _FetchGroupTitlesRef ref,
    ) create,
  ) {
    return _FetchGroupTitlesProvider._(
        argument: argument as Group,
        from: from! as _FetchGroupTitlesFamily,
        create: (
          ref,
          Group group,
        ) =>
            create(ref));
  }

  @override
  FutureOr<List<Manga>> create(_FetchGroupTitlesRef ref) {
    final _$cb = _createCb ?? _fetchGroupTitles;
    final argument = this.argument as Group;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchGroupTitlesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchGroupTitlesHash() => r'43e6496cadc600b08ee40a83485d2d6fe93cc4dd';

final class _FetchGroupTitlesFamily extends Family {
  const _FetchGroupTitlesFamily._()
      : super(
          retry: null,
          name: r'_fetchGroupTitlesProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchGroupTitlesProvider call(
    Group group,
  ) =>
      _FetchGroupTitlesProvider._(argument: group, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchGroupTitlesHash();

  @override
  String toString() => r'_fetchGroupTitlesProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<Manga>> Function(
      _FetchGroupTitlesRef ref,
      Group args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchGroupTitlesProvider;

        final argument = provider.argument as Group;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
