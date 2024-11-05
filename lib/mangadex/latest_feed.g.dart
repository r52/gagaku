// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchGlobalChapters)
const _fetchGlobalChaptersProvider = _FetchGlobalChaptersProvider._();

final class _FetchGlobalChaptersProvider extends $FunctionalProvider<
        AsyncValue<List<ChapterFeedItemData>>,
        FutureOr<List<ChapterFeedItemData>>>
    with
        $FutureModifier<List<ChapterFeedItemData>>,
        $FutureProvider<List<ChapterFeedItemData>> {
  const _FetchGlobalChaptersProvider._(
      {FutureOr<List<ChapterFeedItemData>> Function(
        Ref ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: noRetry,
          name: r'_fetchGlobalChaptersProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ChapterFeedItemData>> Function(
    Ref ref,
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
      Ref ref,
    ) create,
  ) {
    return _FetchGlobalChaptersProvider._(create: create);
  }

  @override
  FutureOr<List<ChapterFeedItemData>> create(Ref ref) {
    final _$cb = _createCb ?? _fetchGlobalChapters;
    return _$cb(ref);
  }
}

String _$fetchGlobalChaptersHash() =>
    r'7272922a90fae39a9f9bad842847d5af45538fd8';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
