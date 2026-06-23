// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(resolveWebChapter)
final resolveWebChapterProvider = ResolveWebChapterFamily._();

final class ResolveWebChapterProvider
    extends
        $FunctionalProvider<
          AsyncValue<ResolvedWebChapter>,
          ResolvedWebChapter,
          FutureOr<ResolvedWebChapter>
        >
    with
        $FutureModifier<ResolvedWebChapter>,
        $FutureProvider<ResolvedWebChapter> {
  ResolveWebChapterProvider._({
    required ResolveWebChapterFamily super.from,
    required WebChapterRef super.argument,
  }) : super(
         retry: noRetry,
         name: r'resolveWebChapterProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$resolveWebChapterHash();

  @override
  String toString() {
    return r'resolveWebChapterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ResolvedWebChapter> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ResolvedWebChapter> create(Ref ref) {
    final argument = this.argument as WebChapterRef;
    return resolveWebChapter(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ResolveWebChapterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$resolveWebChapterHash() => r'b179d3e1c0ad5dde4137ababa9c4fa8c008c0811';

final class ResolveWebChapterFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<ResolvedWebChapter>, WebChapterRef> {
  ResolveWebChapterFamily._()
    : super(
        retry: noRetry,
        name: r'resolveWebChapterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ResolveWebChapterProvider call(WebChapterRef chapterRef) =>
      ResolveWebChapterProvider._(argument: chapterRef, from: this);

  @override
  String toString() => r'resolveWebChapterProvider';
}
