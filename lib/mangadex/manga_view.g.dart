// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchMangaFromId)
const _fetchMangaFromIdProvider = _FetchMangaFromIdFamily._();

final class _FetchMangaFromIdProvider
    extends $FunctionalProvider<AsyncValue<Manga>, FutureOr<Manga>>
    with $FutureModifier<Manga>, $FutureProvider<Manga> {
  const _FetchMangaFromIdProvider._({
    required _FetchMangaFromIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'_fetchMangaFromIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
      $FutureProviderElement(pointer);

  @override
  FutureOr<Manga> create(Ref ref) {
    final argument = this.argument as String;
    return _fetchMangaFromId(ref, argument);
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

String _$fetchMangaFromIdHash() => r'f62fea15fddc9b97b851c6e9779ee6bfd7448f3b';

final class _FetchMangaFromIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Manga>, String> {
  const _FetchMangaFromIdFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchMangaFromIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchMangaFromIdProvider call(String mangaId) =>
      _FetchMangaFromIdProvider._(argument: mangaId, from: this);

  @override
  String toString() => r'_fetchMangaFromIdProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
