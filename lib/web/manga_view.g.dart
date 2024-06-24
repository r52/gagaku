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
      required ProxyInfo super.argument,
      FutureOr<WebManga> Function(
        _FetchWebMangaInfoRef ref,
        ProxyInfo info,
      )? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'_fetchWebMangaInfoProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<WebManga> Function(
    _FetchWebMangaInfoRef ref,
    ProxyInfo info,
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
        argument: argument as ProxyInfo,
        from: from! as _FetchWebMangaInfoFamily,
        create: (
          ref,
          ProxyInfo info,
        ) =>
            create(ref));
  }

  @override
  FutureOr<WebManga> create(_FetchWebMangaInfoRef ref) {
    final _$cb = _createCb ?? _fetchWebMangaInfo;
    final argument = this.argument as ProxyInfo;
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

String _$fetchWebMangaInfoHash() => r'b46d2f19b9ddef34e34e104b971c7a92cf0bcd6c';

final class _FetchWebMangaInfoFamily extends Family {
  const _FetchWebMangaInfoFamily._()
      : super(
          retry: null,
          name: r'_fetchWebMangaInfoProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchWebMangaInfoProvider call(
    ProxyInfo info,
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
      ProxyInfo args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchWebMangaInfoProvider;

        final argument = provider.argument as ProxyInfo;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
