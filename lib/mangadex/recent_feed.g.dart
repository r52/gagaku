// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_feed.dart';

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
          retry: noRetry,
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

String _$fetchMangaFeedHash() => r'44ca19b3dcea9ba580d55bbce060ec6e56029f05';

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
