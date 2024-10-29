// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _FetchWebMangaInfoRef = Ref<AsyncValue<WebManga>>;

@ProviderFor(_fetchWebMangaInfo)
const _fetchWebMangaInfoProvider = _FetchWebMangaInfoFamily._();

final class _FetchWebMangaInfoProvider
    extends $FunctionalProvider<AsyncValue<WebManga>, FutureOr<WebManga>>
    with
        $FutureModifier<WebManga>,
        $FutureProvider<WebManga, _FetchWebMangaInfoRef> {
  const _FetchWebMangaInfoProvider._(
      {required _FetchWebMangaInfoFamily super.from,
      required SourceInfo super.argument,
      FutureOr<WebManga> Function(
        _FetchWebMangaInfoRef ref,
        SourceInfo info,
      )? create})
      : _createCb = create,
        super(
          retry: noRetry,
          name: r'_fetchWebMangaInfoProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<WebManga> Function(
    _FetchWebMangaInfoRef ref,
    SourceInfo info,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchWebMangaInfoHash();

  @override
  String toString() {
    return r'_fetchWebMangaInfoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WebManga> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchWebMangaInfoProvider $copyWithCreate(
    FutureOr<WebManga> Function(
      _FetchWebMangaInfoRef ref,
    ) create,
  ) {
    return _FetchWebMangaInfoProvider._(
        argument: argument as SourceInfo,
        from: from! as _FetchWebMangaInfoFamily,
        create: (
          ref,
          SourceInfo info,
        ) =>
            create(ref));
  }

  @override
  FutureOr<WebManga> create(_FetchWebMangaInfoRef ref) {
    final _$cb = _createCb ?? _fetchWebMangaInfo;
    final argument = this.argument as SourceInfo;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchWebMangaInfoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchWebMangaInfoHash() => r'de355fd84a63a4346a5a310266b8e59e4dfb512c';

final class _FetchWebMangaInfoFamily extends Family {
  const _FetchWebMangaInfoFamily._()
      : super(
          retry: noRetry,
          name: r'_fetchWebMangaInfoProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchWebMangaInfoProvider call(
    SourceInfo info,
  ) =>
      _FetchWebMangaInfoProvider._(argument: info, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchWebMangaInfoHash();

  @override
  String toString() => r'_fetchWebMangaInfoProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<WebManga> Function(
      _FetchWebMangaInfoRef ref,
      SourceInfo args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchWebMangaInfoProvider;

        final argument = provider.argument as SourceInfo;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

typedef _FetchWebMangaRedirectRef = Ref<AsyncValue<SourceInfo>>;

@ProviderFor(_fetchWebMangaRedirect)
const _fetchWebMangaRedirectProvider = _FetchWebMangaRedirectFamily._();

final class _FetchWebMangaRedirectProvider
    extends $FunctionalProvider<AsyncValue<SourceInfo>, FutureOr<SourceInfo>>
    with
        $FutureModifier<SourceInfo>,
        $FutureProvider<SourceInfo, _FetchWebMangaRedirectRef> {
  const _FetchWebMangaRedirectProvider._(
      {required _FetchWebMangaRedirectFamily super.from,
      required String super.argument,
      FutureOr<SourceInfo> Function(
        _FetchWebMangaRedirectRef ref,
        String url,
      )? create})
      : _createCb = create,
        super(
          retry: noRetry,
          name: r'_fetchWebMangaRedirectProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<SourceInfo> Function(
    _FetchWebMangaRedirectRef ref,
    String url,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchWebMangaRedirectHash();

  @override
  String toString() {
    return r'_fetchWebMangaRedirectProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SourceInfo> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchWebMangaRedirectProvider $copyWithCreate(
    FutureOr<SourceInfo> Function(
      _FetchWebMangaRedirectRef ref,
    ) create,
  ) {
    return _FetchWebMangaRedirectProvider._(
        argument: argument as String,
        from: from! as _FetchWebMangaRedirectFamily,
        create: (
          ref,
          String url,
        ) =>
            create(ref));
  }

  @override
  FutureOr<SourceInfo> create(_FetchWebMangaRedirectRef ref) {
    final _$cb = _createCb ?? _fetchWebMangaRedirect;
    final argument = this.argument as String;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchWebMangaRedirectProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchWebMangaRedirectHash() =>
    r'fbc7fe3c4db83257e6e51a5a1e6c3a0039f29797';

final class _FetchWebMangaRedirectFamily extends Family {
  const _FetchWebMangaRedirectFamily._()
      : super(
          retry: noRetry,
          name: r'_fetchWebMangaRedirectProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchWebMangaRedirectProvider call(
    String url,
  ) =>
      _FetchWebMangaRedirectProvider._(argument: url, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchWebMangaRedirectHash();

  @override
  String toString() => r'_fetchWebMangaRedirectProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<SourceInfo> Function(
      _FetchWebMangaRedirectRef ref,
      String args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchWebMangaRedirectProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
