// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _FetchCreatorFromIdRef = Ref<AsyncValue<CreatorType>>;

@ProviderFor(_fetchCreatorFromId)
const _fetchCreatorFromIdProvider = _FetchCreatorFromIdFamily._();

final class _FetchCreatorFromIdProvider
    extends $FunctionalProvider<AsyncValue<CreatorType>, FutureOr<CreatorType>>
    with
        $FutureModifier<CreatorType>,
        $FutureProvider<CreatorType, _FetchCreatorFromIdRef> {
  const _FetchCreatorFromIdProvider._(
      {required _FetchCreatorFromIdFamily super.from,
      required String super.argument,
      FutureOr<CreatorType> Function(
        _FetchCreatorFromIdRef ref,
        String creatorId,
      )? create})
      : _createCb = create,
        super(
          name: r'_fetchCreatorFromIdProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<CreatorType> Function(
    _FetchCreatorFromIdRef ref,
    String creatorId,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchCreatorFromIdHash();

  @override
  String toString() {
    return r'_fetchCreatorFromIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CreatorType> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchCreatorFromIdProvider $copyWithCreate(
    FutureOr<CreatorType> Function(
      _FetchCreatorFromIdRef ref,
    ) create,
  ) {
    return _FetchCreatorFromIdProvider._(
        argument: argument as String,
        from: from! as _FetchCreatorFromIdFamily,
        create: (
          ref,
          String creatorId,
        ) =>
            create(ref));
  }

  @override
  FutureOr<CreatorType> create(_FetchCreatorFromIdRef ref) {
    final _$cb = _createCb ?? _fetchCreatorFromId;
    final argument = this.argument as String;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchCreatorFromIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchCreatorFromIdHash() =>
    r'de996798e5488880f40df3da59b157931b1d0e6d';

final class _FetchCreatorFromIdFamily extends Family {
  const _FetchCreatorFromIdFamily._()
      : super(
          name: r'_fetchCreatorFromIdProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchCreatorFromIdProvider call(
    String creatorId,
  ) =>
      _FetchCreatorFromIdProvider._(argument: creatorId, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchCreatorFromIdHash();

  @override
  String toString() => r'_fetchCreatorFromIdProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<CreatorType> Function(
      _FetchCreatorFromIdRef ref,
      String args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchCreatorFromIdProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

typedef _FetchCreatorTitlesRef = Ref<AsyncValue<List<Manga>>>;

@ProviderFor(_fetchCreatorTitles)
const _fetchCreatorTitlesProvider = _FetchCreatorTitlesFamily._();

final class _FetchCreatorTitlesProvider
    extends $FunctionalProvider<AsyncValue<List<Manga>>, FutureOr<List<Manga>>>
    with
        $FutureModifier<List<Manga>>,
        $FutureProvider<List<Manga>, _FetchCreatorTitlesRef> {
  const _FetchCreatorTitlesProvider._(
      {required _FetchCreatorTitlesFamily super.from,
      required CreatorType super.argument,
      FutureOr<List<Manga>> Function(
        _FetchCreatorTitlesRef ref,
        CreatorType creator,
      )? create})
      : _createCb = create,
        super(
          name: r'_fetchCreatorTitlesProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<Manga>> Function(
    _FetchCreatorTitlesRef ref,
    CreatorType creator,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchCreatorTitlesHash();

  @override
  String toString() {
    return r'_fetchCreatorTitlesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Manga>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchCreatorTitlesProvider $copyWithCreate(
    FutureOr<List<Manga>> Function(
      _FetchCreatorTitlesRef ref,
    ) create,
  ) {
    return _FetchCreatorTitlesProvider._(
        argument: argument as CreatorType,
        from: from! as _FetchCreatorTitlesFamily,
        create: (
          ref,
          CreatorType creator,
        ) =>
            create(ref));
  }

  @override
  FutureOr<List<Manga>> create(_FetchCreatorTitlesRef ref) {
    final _$cb = _createCb ?? _fetchCreatorTitles;
    final argument = this.argument as CreatorType;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchCreatorTitlesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchCreatorTitlesHash() =>
    r'30b2ada9d357c41f5383faef4b85cf4b4999aa50';

final class _FetchCreatorTitlesFamily extends Family {
  const _FetchCreatorTitlesFamily._()
      : super(
          name: r'_fetchCreatorTitlesProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchCreatorTitlesProvider call(
    CreatorType creator,
  ) =>
      _FetchCreatorTitlesProvider._(argument: creator, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchCreatorTitlesHash();

  @override
  String toString() => r'_fetchCreatorTitlesProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<Manga>> Function(
      _FetchCreatorTitlesRef ref,
      CreatorType args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchCreatorTitlesProvider;

        final argument = provider.argument as CreatorType;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
