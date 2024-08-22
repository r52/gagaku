// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _FetchChaptersRef = Ref<AsyncValue<List<ChapterFeedItemData>>>;

@ProviderFor(_fetchChapters)
const _fetchChaptersProvider = _FetchChaptersProvider._();

final class _FetchChaptersProvider extends $FunctionalProvider<
        AsyncValue<List<ChapterFeedItemData>>,
        FutureOr<List<ChapterFeedItemData>>>
    with
        $FutureModifier<List<ChapterFeedItemData>>,
        $FutureProvider<List<ChapterFeedItemData>, _FetchChaptersRef> {
  const _FetchChaptersProvider._(
      {FutureOr<List<ChapterFeedItemData>> Function(
        _FetchChaptersRef ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: _noRetry,
          name: r'_fetchChaptersProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ChapterFeedItemData>> Function(
    _FetchChaptersRef ref,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchChaptersHash();

  @$internal
  @override
  $FutureProviderElement<List<ChapterFeedItemData>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchChaptersProvider $copyWithCreate(
    FutureOr<List<ChapterFeedItemData>> Function(
      _FetchChaptersRef ref,
    ) create,
  ) {
    return _FetchChaptersProvider._(create: create);
  }

  @override
  FutureOr<List<ChapterFeedItemData>> create(_FetchChaptersRef ref) {
    final _$cb = _createCb ?? _fetchChapters;
    return _$cb(ref);
  }
}

String _$fetchChaptersHash() => r'ebc682b7b2179a5ffb9d1e8f236402bf5579e614';

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
