// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchListFeed)
const _fetchListFeedProvider = _FetchListFeedFamily._();

final class _FetchListFeedProvider extends $FunctionalProvider<
        AsyncValue<List<ChapterFeedItemData>>,
        FutureOr<List<ChapterFeedItemData>>>
    with
        $FutureModifier<List<ChapterFeedItemData>>,
        $FutureProvider<List<ChapterFeedItemData>> {
  const _FetchListFeedProvider._(
      {required _FetchListFeedFamily super.from,
      required CustomList super.argument,
      FutureOr<List<ChapterFeedItemData>> Function(
        Ref ref,
        CustomList list,
      )? create})
      : _createCb = create,
        super(
          retry: noRetry,
          name: r'_fetchListFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ChapterFeedItemData>> Function(
    Ref ref,
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
      Ref ref,
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
  FutureOr<List<ChapterFeedItemData>> create(Ref ref) {
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

String _$fetchListFeedHash() => r'53fed169a43ef3443ebdddbaeef5fcf3131d0e75';

final class _FetchListFeedFamily extends Family {
  const _FetchListFeedFamily._()
      : super(
          retry: noRetry,
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
      Ref ref,
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
