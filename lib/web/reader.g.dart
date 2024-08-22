// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _FetchWebChapterInfoRef = Ref<AsyncValue<WebReaderData>>;

@ProviderFor(_fetchWebChapterInfo)
const _fetchWebChapterInfoProvider = _FetchWebChapterInfoFamily._();

final class _FetchWebChapterInfoProvider extends $FunctionalProvider<
        AsyncValue<WebReaderData>, FutureOr<WebReaderData>>
    with
        $FutureModifier<WebReaderData>,
        $FutureProvider<WebReaderData, _FetchWebChapterInfoRef> {
  const _FetchWebChapterInfoProvider._(
      {required _FetchWebChapterInfoFamily super.from,
      required ProxyInfo super.argument,
      FutureOr<WebReaderData> Function(
        _FetchWebChapterInfoRef ref,
        ProxyInfo info,
      )? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'_fetchWebChapterInfoProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<WebReaderData> Function(
    _FetchWebChapterInfoRef ref,
    ProxyInfo info,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchWebChapterInfoHash();

  @override
  String toString() {
    return r'_fetchWebChapterInfoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WebReaderData> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchWebChapterInfoProvider $copyWithCreate(
    FutureOr<WebReaderData> Function(
      _FetchWebChapterInfoRef ref,
    ) create,
  ) {
    return _FetchWebChapterInfoProvider._(
        argument: argument as ProxyInfo,
        from: from! as _FetchWebChapterInfoFamily,
        create: (
          ref,
          ProxyInfo info,
        ) =>
            create(ref));
  }

  @override
  FutureOr<WebReaderData> create(_FetchWebChapterInfoRef ref) {
    final _$cb = _createCb ?? _fetchWebChapterInfo;
    final argument = this.argument as ProxyInfo;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchWebChapterInfoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchWebChapterInfoHash() =>
    r'd5f51eb0e901ac6ac2fbe386459d08d2ee354ee6';

final class _FetchWebChapterInfoFamily extends Family {
  const _FetchWebChapterInfoFamily._()
      : super(
          retry: null,
          name: r'_fetchWebChapterInfoProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchWebChapterInfoProvider call(
    ProxyInfo info,
  ) =>
      _FetchWebChapterInfoProvider._(argument: info, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchWebChapterInfoHash();

  @override
  String toString() => r'_fetchWebChapterInfoProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<WebReaderData> Function(
      _FetchWebChapterInfoRef ref,
      ProxyInfo args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchWebChapterInfoProvider;

        final argument = provider.argument as ProxyInfo;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

typedef _GetPagesRef = Ref<AsyncValue<List<ReaderPage>>>;

@ProviderFor(_getPages)
const _getPagesProvider = _GetPagesFamily._();

final class _GetPagesProvider extends $FunctionalProvider<
        AsyncValue<List<ReaderPage>>, FutureOr<List<ReaderPage>>>
    with
        $FutureModifier<List<ReaderPage>>,
        $FutureProvider<List<ReaderPage>, _GetPagesRef> {
  const _GetPagesProvider._(
      {required _GetPagesFamily super.from,
      required dynamic super.argument,
      FutureOr<List<ReaderPage>> Function(
        _GetPagesRef ref,
        dynamic source,
      )? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'_getPagesProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ReaderPage>> Function(
    _GetPagesRef ref,
    dynamic source,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$getPagesHash();

  @override
  String toString() {
    return r'_getPagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ReaderPage>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _GetPagesProvider $copyWithCreate(
    FutureOr<List<ReaderPage>> Function(
      _GetPagesRef ref,
    ) create,
  ) {
    return _GetPagesProvider._(
        argument: argument as dynamic,
        from: from! as _GetPagesFamily,
        create: (
          ref,
          dynamic source,
        ) =>
            create(ref));
  }

  @override
  FutureOr<List<ReaderPage>> create(_GetPagesRef ref) {
    final _$cb = _createCb ?? _getPages;
    final argument = this.argument as dynamic;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getPagesHash() => r'406c422b6962a0656219d12106da8b524748e055';

final class _GetPagesFamily extends Family {
  const _GetPagesFamily._()
      : super(
          retry: null,
          name: r'_getPagesProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _GetPagesProvider call(
    dynamic source,
  ) =>
      _GetPagesProvider._(argument: source, from: this);

  @override
  String debugGetCreateSourceHash() => _$getPagesHash();

  @override
  String toString() => r'_getPagesProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<ReaderPage>> Function(
      _GetPagesRef ref,
      dynamic args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _GetPagesProvider;

        final argument = provider.argument as dynamic;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
