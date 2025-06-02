// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchWebMangaInfo)
const _fetchWebMangaInfoProvider = _FetchWebMangaInfoFamily._();

final class _FetchWebMangaInfoProvider
    extends $FunctionalProvider<AsyncValue<WebManga>, FutureOr<WebManga>>
    with $FutureModifier<WebManga>, $FutureProvider<WebManga> {
  const _FetchWebMangaInfoProvider._({
    required _FetchWebMangaInfoFamily super.from,
    required SourceHandler super.argument,
  }) : super(
         retry: noRetry,
         name: r'_fetchWebMangaInfoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
      $FutureProviderElement(pointer);

  @override
  FutureOr<WebManga> create(Ref ref) {
    final argument = this.argument as SourceHandler;
    return _fetchWebMangaInfo(ref, argument);
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

String _$fetchWebMangaInfoHash() => r'e745e301b87e533d34606a34767ffee04286b1ec';

final class _FetchWebMangaInfoFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<WebManga>, SourceHandler> {
  const _FetchWebMangaInfoFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchWebMangaInfoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchWebMangaInfoProvider call(SourceHandler handle) =>
      _FetchWebMangaInfoProvider._(argument: handle, from: this);

  @override
  String toString() => r'_fetchWebMangaInfoProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
