// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchMangaFeed)
const _fetchMangaFeedProvider = _FetchMangaFeedProvider._();

final class _FetchMangaFeedProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with $FutureModifier<List<Manga>>, $FutureProvider<List<Manga>> {
  const _FetchMangaFeedProvider._(
      {FutureOr<List<Manga>> Function(
        Ref ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: noRetry,
          name: r'_fetchMangaFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<Manga>> Function(
    Ref ref,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchMangaFeedHash();

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchMangaFeedProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(
      Ref ref,
    ) create,
  ) {
    return _FetchMangaFeedProvider._(create: create);
  }

  @override
  FutureOr<List<Manga>> create(Ref ref) {
    final _$cb = _createCb ?? _fetchMangaFeed;
    return _$cb(ref);
  }
}

String _$fetchMangaFeedHash() => r'c8fa93483b00fa30d67b0efa74c346e4b20325b8';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
