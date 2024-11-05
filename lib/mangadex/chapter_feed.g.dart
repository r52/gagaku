// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchChapters)
const _fetchChaptersProvider = _FetchChaptersProvider._();

final class _FetchChaptersProvider extends $FunctionalProvider<
        AsyncValue<List<ChapterFeedItemData>>,
        FutureOr<List<ChapterFeedItemData>>>
    with
        $FutureModifier<List<ChapterFeedItemData>>,
        $FutureProvider<List<ChapterFeedItemData>> {
  const _FetchChaptersProvider._(
      {FutureOr<List<ChapterFeedItemData>> Function(
        Ref ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: noRetry,
          name: r'_fetchChaptersProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ChapterFeedItemData>> Function(
    Ref ref,
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
      Ref ref,
    ) create,
  ) {
    return _FetchChaptersProvider._(create: create);
  }

  @override
  FutureOr<List<ChapterFeedItemData>> create(Ref ref) {
    final _$cb = _createCb ?? _fetchChapters;
    return _$cb(ref);
  }
}

String _$fetchChaptersHash() => r'f878b33531a1281328874a104183124413ab82e5';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
