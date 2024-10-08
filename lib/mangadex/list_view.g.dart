// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _FetchListFeedRef = Ref<AsyncValue<List<ChapterFeedItemData>>>;

@ProviderFor(_fetchListFeed)
const _fetchListFeedProvider = _FetchListFeedFamily._();

final class _FetchListFeedProvider extends $FunctionalProvider<
        AsyncValue<List<ChapterFeedItemData>>,
        FutureOr<List<ChapterFeedItemData>>>
    with
        $FutureModifier<List<ChapterFeedItemData>>,
        $FutureProvider<List<ChapterFeedItemData>, _FetchListFeedRef> {
  const _FetchListFeedProvider._(
      {required _FetchListFeedFamily super.from,
      required CustomList super.argument,
      FutureOr<List<ChapterFeedItemData>> Function(
        _FetchListFeedRef ref,
        CustomList list,
      )? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'_fetchListFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ChapterFeedItemData>> Function(
    _FetchListFeedRef ref,
    CustomList list,
  )? _createCb;

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
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchListFeedProvider $copyWithCreate(
    FutureOr<List<ChapterFeedItemData>> Function(
      _FetchListFeedRef ref,
    ) create,
  ) {
    return _FetchListFeedProvider._(
        argument: argument as CustomList,
        from: from! as _FetchListFeedFamily,
        create: (
          ref,
          CustomList list,
        ) =>
            create(ref));
  }

  @override
  FutureOr<List<ChapterFeedItemData>> create(_FetchListFeedRef ref) {
    final _$cb = _createCb ?? _fetchListFeed;
    final argument = this.argument as CustomList;
    return _$cb(
      ref,
      argument,
    );
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

String _$fetchListFeedHash() => r'05633bbaa50ac827f1c362ef9d1c47a86b83940c';

final class _FetchListFeedFamily extends Family {
  const _FetchListFeedFamily._()
      : super(
          retry: null,
          name: r'_fetchListFeedProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchListFeedProvider call(
    CustomList list,
  ) =>
      _FetchListFeedProvider._(argument: list, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchListFeedHash();

  @override
  String toString() => r'_fetchListFeedProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<ChapterFeedItemData>> Function(
      _FetchListFeedRef ref,
      CustomList args,
    ) create,
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
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
