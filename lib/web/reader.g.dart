// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_fetchWebChapterInfo)
final _fetchWebChapterInfoProvider = _FetchWebChapterInfoFamily._();

final class _FetchWebChapterInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<WebReaderData>,
          WebReaderData,
          FutureOr<WebReaderData>
        >
    with $FutureModifier<WebReaderData>, $FutureProvider<WebReaderData> {
  _FetchWebChapterInfoProvider._({
    required _FetchWebChapterInfoFamily super.from,
    required SourceHandler super.argument,
  }) : super(
         retry: noRetry,
         name: r'_fetchWebChapterInfoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$_fetchWebChapterInfoHash();

  @override
  String toString() {
    return r'_fetchWebChapterInfoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WebReaderData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WebReaderData> create(Ref ref) {
    final argument = this.argument as SourceHandler;
    return _fetchWebChapterInfo(ref, argument);
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

String _$_fetchWebChapterInfoHash() =>
    r'b722225992e996830f367c14f2a08a9f4d30b879';

final class _FetchWebChapterInfoFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<WebReaderData>, SourceHandler> {
  _FetchWebChapterInfoFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchWebChapterInfoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchWebChapterInfoProvider call(SourceHandler handle) =>
      _FetchWebChapterInfoProvider._(argument: handle, from: this);

  @override
  String toString() => r'_fetchWebChapterInfoProvider';
}

@ProviderFor(_getPages)
final _getPagesProvider = _GetPagesFamily._();

final class _GetPagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReaderPage>>,
          List<ReaderPage>,
          FutureOr<List<ReaderPage>>
        >
    with $FutureModifier<List<ReaderPage>>, $FutureProvider<List<ReaderPage>> {
  _GetPagesProvider._({
    required _GetPagesFamily super.from,
    required dynamic super.argument,
  }) : super(
         retry: noRetry,
         name: r'_getPagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$_getPagesHash();

  @override
  String toString() {
    return r'_getPagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ReaderPage>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReaderPage>> create(Ref ref) {
    final argument = this.argument as dynamic;
    return _getPages(ref, argument);
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

String _$_getPagesHash() => r'1c52150fc757ca675597728dac032870411f5988';

final class _GetPagesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ReaderPage>>, dynamic> {
  _GetPagesFamily._()
    : super(
        retry: noRetry,
        name: r'_getPagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _GetPagesProvider call(dynamic data) =>
      _GetPagesProvider._(argument: data, from: this);

  @override
  String toString() => r'_getPagesProvider';
}

@ProviderFor(_getSourcePages)
final _getSourcePagesProvider = _GetSourcePagesFamily._();

final class _GetSourcePagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReaderPage>>,
          List<ReaderPage>,
          FutureOr<List<ReaderPage>>
        >
    with $FutureModifier<List<ReaderPage>>, $FutureProvider<List<ReaderPage>> {
  _GetSourcePagesProvider._({
    required _GetSourcePagesFamily super.from,
    required (dynamic, SourceHandler) super.argument,
  }) : super(
         retry: noRetry,
         name: r'_getSourcePagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$_getSourcePagesHash();

  @override
  String toString() {
    return r'_getSourcePagesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<ReaderPage>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReaderPage>> create(Ref ref) {
    final argument = this.argument as (dynamic, SourceHandler);
    return _getSourcePages(ref, argument.$1, argument.$2);
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

String _$_getSourcePagesHash() => r'99c3df3feed20a625d4a795389b5771359fce7a5';

final class _GetSourcePagesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ReaderPage>>,
          (dynamic, SourceHandler)
        > {
  _GetSourcePagesFamily._()
    : super(
        retry: noRetry,
        name: r'_getSourcePagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _GetSourcePagesProvider call(dynamic chapter, SourceHandler handle) =>
      _GetSourcePagesProvider._(argument: (chapter, handle), from: this);

  @override
  String toString() => r'_getSourcePagesProvider';
}
