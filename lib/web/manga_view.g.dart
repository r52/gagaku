// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_fetchWebMangaInfo)
final _fetchWebMangaInfoProvider = _FetchWebMangaInfoFamily._();

final class _FetchWebMangaInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<(WebManga, HistoryLink)>,
          (WebManga, HistoryLink),
          FutureOr<(WebManga, HistoryLink)>
        >
    with
        $FutureModifier<(WebManga, HistoryLink)>,
        $FutureProvider<(WebManga, HistoryLink)> {
  _FetchWebMangaInfoProvider._({
    required _FetchWebMangaInfoFamily super.from,
    required WebSeriesRef super.argument,
  }) : super(
         retry: noRetry,
         name: r'_fetchWebMangaInfoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$_fetchWebMangaInfoHash();

  @override
  String toString() {
    return r'_fetchWebMangaInfoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<(WebManga, HistoryLink)> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<(WebManga, HistoryLink)> create(Ref ref) {
    final argument = this.argument as WebSeriesRef;
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

String _$_fetchWebMangaInfoHash() =>
    r'03b92d838dec755f87219e318c54e75b0f295669';

final class _FetchWebMangaInfoFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<(WebManga, HistoryLink)>,
          WebSeriesRef
        > {
  _FetchWebMangaInfoFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchWebMangaInfoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchWebMangaInfoProvider call(WebSeriesRef series) =>
      _FetchWebMangaInfoProvider._(argument: series, from: this);

  @override
  String toString() => r'_fetchWebMangaInfoProvider';
}
