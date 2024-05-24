// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _FetchGlobalChaptersRef = Ref<AsyncValue<List<ChapterFeedItemData>>>;

@ProviderFor(_fetchGlobalChapters)
const _fetchGlobalChaptersProvider = _FetchGlobalChaptersProvider._();

final class _FetchGlobalChaptersProvider extends $FunctionalProvider<
        AsyncValue<List<ChapterFeedItemData>>,
        FutureOr<List<ChapterFeedItemData>>>
    with
        $FutureModifier<List<ChapterFeedItemData>>,
        $FutureProvider<List<ChapterFeedItemData>, _FetchGlobalChaptersRef> {
  const _FetchGlobalChaptersProvider._(
      {FutureOr<List<ChapterFeedItemData>> Function(
        _FetchGlobalChaptersRef ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          name: r'_fetchGlobalChaptersProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ChapterFeedItemData>> Function(
    _FetchGlobalChaptersRef ref,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchGlobalChaptersHash();

  @$internal
  @override
  $FutureProviderElement<List<ChapterFeedItemData>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchGlobalChaptersProvider $copyWithCreate(
    FutureOr<List<ChapterFeedItemData>> Function(
      _FetchGlobalChaptersRef ref,
    ) create,
  ) {
    return _FetchGlobalChaptersProvider._(create: create);
  }

  @override
  FutureOr<List<ChapterFeedItemData>> create(_FetchGlobalChaptersRef ref) {
    final _$cb = _createCb ?? _fetchGlobalChapters;
    return _$cb(ref);
  }
}

String _$fetchGlobalChaptersHash() =>
    r'de77e10566804d5f19c93d86996e8073f773e033';

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
