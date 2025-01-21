// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchHistoryFeed)
const _fetchHistoryFeedProvider = _FetchHistoryFeedProvider._();

final class _FetchHistoryFeedProvider extends $FunctionalProvider<
        AsyncValue<List<ChapterFeedItemData>>,
        FutureOr<List<ChapterFeedItemData>>>
    with
        $FutureModifier<List<ChapterFeedItemData>>,
        $FutureProvider<List<ChapterFeedItemData>> {
  const _FetchHistoryFeedProvider._(
      {FutureOr<List<ChapterFeedItemData>> Function(
        Ref ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: noRetry,
          name: r'_fetchHistoryFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ChapterFeedItemData>> Function(
    Ref ref,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchHistoryFeedHash();

  @$internal
  @override
  $FutureProviderElement<List<ChapterFeedItemData>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchHistoryFeedProvider $copyWithCreate(
    FutureOr<List<ChapterFeedItemData>> Function(
      Ref ref,
    ) create,
  ) {
    return _FetchHistoryFeedProvider._(create: create);
  }

  @override
  FutureOr<List<ChapterFeedItemData>> create(Ref ref) {
    final _$cb = _createCb ?? _fetchHistoryFeed;
    return _$cb(ref);
  }
}

String _$fetchHistoryFeedHash() => r'83dc5ca66eb07364432d0fdcee800d9f1505d2eb';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
