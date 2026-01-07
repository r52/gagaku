// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_fetchMangaFromId)
final _fetchMangaFromIdProvider = _FetchMangaFromIdFamily._();

final class _FetchMangaFromIdProvider
    extends $FunctionalProvider<AsyncValue<Manga>, Manga, FutureOr<Manga>>
    with $FutureModifier<Manga>, $FutureProvider<Manga> {
  _FetchMangaFromIdProvider._({
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
  String debugGetCreateSourceHash() => _$_fetchMangaFromIdHash();

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

String _$_fetchMangaFromIdHash() => r'2dad12988cca0a77cab47d87fb9b45a85561a5e4';

final class _FetchMangaFromIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Manga>, String> {
  _FetchMangaFromIdFamily._()
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
