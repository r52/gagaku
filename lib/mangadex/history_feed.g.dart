// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _FetchHistoryFeedRef = Ref<AsyncValue<List<ChapterFeedItemData>>>;

@ProviderFor(_fetchHistoryFeed)
const _fetchHistoryFeedProvider = _FetchHistoryFeedProvider._();

final class _FetchHistoryFeedProvider extends $FunctionalProvider<
        AsyncValue<List<ChapterFeedItemData>>,
        FutureOr<List<ChapterFeedItemData>>>
    with
        $FutureModifier<List<ChapterFeedItemData>>,
        $FutureProvider<List<ChapterFeedItemData>, _FetchHistoryFeedRef> {
  const _FetchHistoryFeedProvider._(
      {FutureOr<List<ChapterFeedItemData>> Function(
        _FetchHistoryFeedRef ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'_fetchHistoryFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ChapterFeedItemData>> Function(
    _FetchHistoryFeedRef ref,
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
      _FetchHistoryFeedRef ref,
    ) create,
  ) {
    return _FetchHistoryFeedProvider._(create: create);
  }

  @override
  FutureOr<List<ChapterFeedItemData>> create(_FetchHistoryFeedRef ref) {
    final _$cb = _createCb ?? _fetchHistoryFeed;
    return _$cb(ref);
  }
}

String _$fetchHistoryFeedHash() => r'4dd56fd463930deeaefceae0e803cfc1c2a6e115';

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
