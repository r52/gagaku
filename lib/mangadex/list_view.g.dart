// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchListFeed)
const _fetchListFeedProvider = _FetchListFeedFamily._();

final class _FetchListFeedProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ChapterFeedItemData>>,
          FutureOr<List<ChapterFeedItemData>>
        >
    with
        $FutureModifier<List<ChapterFeedItemData>>,
        $FutureProvider<List<ChapterFeedItemData>> {
  const _FetchListFeedProvider._({
    required _FetchListFeedFamily super.from,
    required CustomList super.argument,
    FutureOr<List<ChapterFeedItemData>> Function(Ref ref, CustomList list)?
    create,
  }) : _createCb = create,
       super(
         retry: noRetry,
         name: r'_fetchListFeedProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<List<ChapterFeedItemData>> Function(Ref ref, CustomList list)?
  _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchListFeedHash();

  @override
  String toString() {
    return r'_fetchListFeedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ChapterFeedItemData>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(this, pointer);

  @override
  _FetchListFeedProvider $copyWithCreate(
    FutureOr<List<ChapterFeedItemData>> Function(Ref ref) create,
  ) {
    return _FetchListFeedProvider._(
      argument: argument as CustomList,
      from: from! as _FetchListFeedFamily,
      create: (ref, CustomList list) => create(ref),
    );
  }

  @override
  FutureOr<List<ChapterFeedItemData>> create(Ref ref) {
    final _$cb = _createCb ?? _fetchListFeed;
    final argument = this.argument as CustomList;
    return _$cb(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchListFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchListFeedHash() => r'167d220b058834e0b1c3f941ce21cfa34ed8792e';

final class _FetchListFeedFamily extends Family {
  const _FetchListFeedFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchListFeedProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchListFeedProvider call(CustomList list) =>
      _FetchListFeedProvider._(argument: list, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchListFeedHash();

  @override
  String toString() => r'_fetchListFeedProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<ChapterFeedItemData>> Function(Ref ref, CustomList args)
    create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchListFeedProvider;

        final argument = provider.argument as CustomList;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

@ProviderFor(_getList)
const _getListProvider = _GetListFamily._();

final class _GetListProvider
    extends $FunctionalProvider<AsyncValue<CustomList?>, FutureOr<CustomList?>>
    with $FutureModifier<CustomList?>, $FutureProvider<CustomList?> {
  const _GetListProvider._({
    required _GetListFamily super.from,
    required String super.argument,
    FutureOr<CustomList?> Function(Ref ref, String listId)? create,
  }) : _createCb = create,
       super(
         retry: noRetry,
         name: r'_getListProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<CustomList?> Function(Ref ref, String listId)? _createCb;

  @override
  String debugGetCreateSourceHash() => _$getListHash();

  @override
  String toString() {
    return r'_getListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CustomList?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(this, pointer);

  @override
  _GetListProvider $copyWithCreate(
    FutureOr<CustomList?> Function(Ref ref) create,
  ) {
    return _GetListProvider._(
      argument: argument as String,
      from: from! as _GetListFamily,
      create: (ref, String listId) => create(ref),
    );
  }

  @override
  FutureOr<CustomList?> create(Ref ref) {
    final _$cb = _createCb ?? _getList;
    final argument = this.argument as String;
    return _$cb(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getListHash() => r'7223b393ab63d2ecb03e3bfb704b339286537b49';

final class _GetListFamily extends Family {
  const _GetListFamily._()
    : super(
        retry: noRetry,
        name: r'_getListProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _GetListProvider call(String listId) =>
      _GetListProvider._(argument: listId, from: this);

  @override
  String debugGetCreateSourceHash() => _$getListHash();

  @override
  String toString() => r'_getListProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<CustomList?> Function(Ref ref, String args) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _GetListProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
