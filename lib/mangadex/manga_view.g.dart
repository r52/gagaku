// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _FetchMangaFromIdRef = Ref<AsyncValue<Manga>>;

@ProviderFor(_fetchMangaFromId)
const _fetchMangaFromIdProvider = _FetchMangaFromIdFamily._();

final class _FetchMangaFromIdProvider
    extends $FunctionalProvider<AsyncValue<Manga>, FutureOr<Manga>>
    with $FutureModifier<Manga>, $FutureProvider<Manga, _FetchMangaFromIdRef> {
  const _FetchMangaFromIdProvider._(
      {required _FetchMangaFromIdFamily super.from,
      required String super.argument,
      FutureOr<Manga> Function(
        _FetchMangaFromIdRef ref,
        String mangaId,
      )? create})
      : _createCb = create,
        super(
          retry: noRetry,
          name: r'_fetchMangaFromIdProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<Manga> Function(
    _FetchMangaFromIdRef ref,
    String mangaId,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchMangaFromIdHash();

  @override
  String toString() {
    return r'_fetchMangaFromIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Manga> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchMangaFromIdProvider $copyWithCreate(
    FutureOr<Manga> Function(
      _FetchMangaFromIdRef ref,
    ) create,
  ) {
    return _FetchMangaFromIdProvider._(
        argument: argument as String,
        from: from! as _FetchMangaFromIdFamily,
        create: (
          ref,
          String mangaId,
        ) =>
            create(ref));
  }

  @override
  FutureOr<Manga> create(_FetchMangaFromIdRef ref) {
    final _$cb = _createCb ?? _fetchMangaFromId;
    final argument = this.argument as String;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchMangaFromIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchMangaFromIdHash() => r'd1d5f44a9d560a7dfa6a228ef3c0918b710b03ce';

final class _FetchMangaFromIdFamily extends Family {
  const _FetchMangaFromIdFamily._()
      : super(
          retry: noRetry,
          name: r'_fetchMangaFromIdProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchMangaFromIdProvider call(
    String mangaId,
  ) =>
      _FetchMangaFromIdProvider._(argument: mangaId, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchMangaFromIdHash();

  @override
  String toString() => r'_fetchMangaFromIdProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<Manga> Function(
      _FetchMangaFromIdRef ref,
      String args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchMangaFromIdProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

typedef _FetchRelatedMangaRef = Ref<AsyncValue<List<Manga>>>;

@ProviderFor(_fetchRelatedManga)
const _fetchRelatedMangaProvider = _FetchRelatedMangaFamily._();

final class _FetchRelatedMangaProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with
        $FutureModifier<List<Manga>>,
        $FutureProvider<List<Manga>, _FetchRelatedMangaRef> {
  const _FetchRelatedMangaProvider._(
      {required _FetchRelatedMangaFamily super.from,
      required Manga super.argument,
      FutureOr<List<Manga>> Function(
        _FetchRelatedMangaRef ref,
        Manga manga,
      )? create})
      : _createCb = create,
        super(
          retry: noRetry,
          name: r'_fetchRelatedMangaProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<Manga>> Function(
    _FetchRelatedMangaRef ref,
    Manga manga,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchRelatedMangaHash();

  @override
  String toString() {
    return r'_fetchRelatedMangaProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchRelatedMangaProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(
      _FetchRelatedMangaRef ref,
    ) create,
  ) {
    return _FetchRelatedMangaProvider._(
        argument: argument as Manga,
        from: from! as _FetchRelatedMangaFamily,
        create: (
          ref,
          Manga manga,
        ) =>
            create(ref));
  }

  @override
  FutureOr<List<Manga>> create(_FetchRelatedMangaRef ref) {
    final _$cb = _createCb ?? _fetchRelatedManga;
    final argument = this.argument as Manga;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchRelatedMangaProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchRelatedMangaHash() => r'ccb56a2018d024c015559e92335d0cb7bd743b8a';

final class _FetchRelatedMangaFamily extends Family {
  const _FetchRelatedMangaFamily._()
      : super(
          retry: noRetry,
          name: r'_fetchRelatedMangaProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchRelatedMangaProvider call(
    Manga manga,
  ) =>
      _FetchRelatedMangaProvider._(argument: manga, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchRelatedMangaHash();

  @override
  String toString() => r'_fetchRelatedMangaProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<Manga>> Function(
      _FetchRelatedMangaRef ref,
      Manga args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchRelatedMangaProvider;

        final argument = provider.argument as Manga;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
