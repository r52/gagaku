// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _FetchMangaFeedRef = Ref<AsyncValue<List<Manga>>>;

@ProviderFor(_fetchMangaFeed)
const _fetchMangaFeedProvider = _FetchMangaFeedProvider._();

final class _FetchMangaFeedProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with
        $FutureModifier<List<Manga>>,
        $FutureProvider<List<Manga>, _FetchMangaFeedRef> {
  const _FetchMangaFeedProvider._(
      {FutureOr<List<Manga>> Function(
        _FetchMangaFeedRef ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'_fetchMangaFeedProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<Manga>> Function(
    _FetchMangaFeedRef ref,
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
      _FetchMangaFeedRef ref,
    ) create,
  ) {
    return _FetchMangaFeedProvider._(create: create);
  }

  @override
  FutureOr<List<Manga>> create(_FetchMangaFeedRef ref) {
    final _$cb = _createCb ?? _fetchMangaFeed;
    return _$cb(ref);
  }
}

String _$fetchMangaFeedHash() => r'a1a1dd400c006bc9bdb6fb1cf39c9ced046f5888';

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
