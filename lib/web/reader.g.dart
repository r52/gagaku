// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchWebChapterInfo)
const _fetchWebChapterInfoProvider = _FetchWebChapterInfoFamily._();

final class _FetchWebChapterInfoProvider extends $FunctionalProvider<
        AsyncValue<WebReaderData>, FutureOr<WebReaderData>>
    with $FutureModifier<WebReaderData>, $FutureProvider<WebReaderData> {
  const _FetchWebChapterInfoProvider._(
      {required _FetchWebChapterInfoFamily super.from,
      required SourceInfo super.argument,
      FutureOr<WebReaderData> Function(
        Ref ref,
        SourceInfo info,
      )? create})
      : _createCb = create,
        super(
          retry: noRetry,
          name: r'_fetchWebChapterInfoProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<WebReaderData> Function(
    Ref ref,
    SourceInfo info,
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
      Ref ref,
    ) create,
  ) {
    return _FetchWebChapterInfoProvider._(
        argument: argument as SourceInfo,
        from: from! as _FetchWebChapterInfoFamily,
        create: (
          ref,
          SourceInfo info,
        ) =>
            create(ref));
  }

  @override
  FutureOr<WebReaderData> create(Ref ref) {
    final _$cb = _createCb ?? _fetchWebChapterInfo;
    final argument = this.argument as SourceInfo;
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
    r'c0e9447e98e4d1e1a7bdfc32c6305f9cd62e3815';

final class _FetchWebChapterInfoFamily extends Family {
  const _FetchWebChapterInfoFamily._()
      : super(
          retry: noRetry,
          name: r'_fetchWebChapterInfoProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchWebChapterInfoProvider call(
    SourceInfo info,
  ) =>
      _FetchWebChapterInfoProvider._(argument: info, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchWebChapterInfoHash();

  @override
  String toString() => r'_fetchWebChapterInfoProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<WebReaderData> Function(
      Ref ref,
      SourceInfo args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchWebChapterInfoProvider;

        final argument = provider.argument as SourceInfo;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

@ProviderFor(_getPages)
const _getPagesProvider = _GetPagesFamily._();

final class _GetPagesProvider extends $FunctionalProvider<
        AsyncValue<List<ReaderPage>>, FutureOr<List<ReaderPage>>>
    with $FutureModifier<List<ReaderPage>>, $FutureProvider<List<ReaderPage>> {
  const _GetPagesProvider._(
      {required _GetPagesFamily super.from,
      required dynamic super.argument,
      FutureOr<List<ReaderPage>> Function(
        Ref ref,
        dynamic source,
      )? create})
      : _createCb = create,
        super(
          retry: noRetry,
          name: r'_getPagesProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ReaderPage>> Function(
    Ref ref,
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
      Ref ref,
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
  FutureOr<List<ReaderPage>> create(Ref ref) {
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

String _$getPagesHash() => r'5320750977e9ac6f538a3e72f33d50420ace0501';

final class _GetPagesFamily extends Family {
  const _GetPagesFamily._()
      : super(
          retry: noRetry,
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
      Ref ref,
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

@ProviderFor(_getSourcePages)
const _getSourcePagesProvider = _GetSourcePagesFamily._();

final class _GetSourcePagesProvider extends $FunctionalProvider<
        AsyncValue<List<ReaderPage>>, FutureOr<List<ReaderPage>>>
    with $FutureModifier<List<ReaderPage>>, $FutureProvider<List<ReaderPage>> {
  const _GetSourcePagesProvider._(
      {required _GetSourcePagesFamily super.from,
      required (
        dynamic,
        SourceInfo,
      )
          super.argument,
      FutureOr<List<ReaderPage>> Function(
        Ref ref,
        dynamic source,
        SourceInfo info,
      )? create})
      : _createCb = create,
        super(
          retry: noRetry,
          name: r'_getSourcePagesProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ReaderPage>> Function(
    Ref ref,
    dynamic source,
    SourceInfo info,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$getSourcePagesHash();

  @override
  String toString() {
    return r'_getSourcePagesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<ReaderPage>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _GetSourcePagesProvider $copyWithCreate(
    FutureOr<List<ReaderPage>> Function(
      Ref ref,
    ) create,
  ) {
    return _GetSourcePagesProvider._(
        argument: argument as (
          dynamic,
          SourceInfo,
        ),
        from: from! as _GetSourcePagesFamily,
        create: (
          ref,
          dynamic source,
          SourceInfo info,
        ) =>
            create(ref));
  }

  @override
  FutureOr<List<ReaderPage>> create(Ref ref) {
    final _$cb = _createCb ?? _getSourcePages;
    final argument = this.argument as (
      dynamic,
      SourceInfo,
    );
    return _$cb(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _GetSourcePagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getSourcePagesHash() => r'78a61684dc20a9829f72f8556313e3cf7d96a3fb';

final class _GetSourcePagesFamily extends Family {
  const _GetSourcePagesFamily._()
      : super(
          retry: noRetry,
          name: r'_getSourcePagesProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _GetSourcePagesProvider call(
    dynamic source,
    SourceInfo info,
  ) =>
      _GetSourcePagesProvider._(argument: (
        source,
        info,
      ), from: this);

  @override
  String debugGetCreateSourceHash() => _$getSourcePagesHash();

  @override
  String toString() => r'_getSourcePagesProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<ReaderPage>> Function(
      Ref ref,
      (
        dynamic,
        SourceInfo,
      ) args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _GetSourcePagesProvider;

        final argument = provider.argument as (
          dynamic,
          SourceInfo,
        );

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
