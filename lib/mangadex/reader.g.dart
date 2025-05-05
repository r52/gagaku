// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchChapterData)
const _fetchChapterDataProvider = _FetchChapterDataFamily._();

final class _FetchChapterDataProvider
    extends $FunctionalProvider<AsyncValue<ReaderData>, FutureOr<ReaderData>>
    with $FutureModifier<ReaderData>, $FutureProvider<ReaderData> {
  const _FetchChapterDataProvider._({
    required _FetchChapterDataFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'_fetchChapterDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchChapterDataHash();

  @override
  String toString() {
    return r'_fetchChapterDataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ReaderData> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ReaderData> create(Ref ref) {
    final argument = this.argument as String;
    return _fetchChapterData(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchChapterDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchChapterDataHash() => r'bd8f9de01ae3994fb8c48e31214f6d5cd6d7ed42';

final class _FetchChapterDataFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ReaderData>, String> {
  const _FetchChapterDataFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchChapterDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchChapterDataProvider call(String chapterId) =>
      _FetchChapterDataProvider._(argument: chapterId, from: this);

  @override
  String toString() => r'_fetchChapterDataProvider';
}

@ProviderFor(_fetchChapterPages)
const _fetchChapterPagesProvider = _FetchChapterPagesFamily._();

final class _FetchChapterPagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReaderPage>>,
          FutureOr<List<ReaderPage>>
        >
    with $FutureModifier<List<ReaderPage>>, $FutureProvider<List<ReaderPage>> {
  const _FetchChapterPagesProvider._({
    required _FetchChapterPagesFamily super.from,
    required Chapter super.argument,
  }) : super(
         retry: noRetry,
         name: r'_fetchChapterPagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchChapterPagesHash();

  @override
  String toString() {
    return r'_fetchChapterPagesProvider'
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
    final argument = this.argument as Chapter;
    return _fetchChapterPages(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchChapterPagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchChapterPagesHash() => r'3663bdc5e029081976b001c22486f86c43530c38';

final class _FetchChapterPagesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ReaderPage>>, Chapter> {
  const _FetchChapterPagesFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchChapterPagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchChapterPagesProvider call(Chapter chapter) =>
      _FetchChapterPagesProvider._(argument: chapter, from: this);

  @override
  String toString() => r'_fetchChapterPagesProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
