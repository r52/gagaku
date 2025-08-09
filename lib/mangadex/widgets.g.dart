// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgets.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_MangaListView)
const _mangaListViewProvider = _MangaListViewProvider._();

final class _MangaListViewProvider
    extends $NotifierProvider<_MangaListView, MangaListView> {
  const _MangaListViewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_mangaListViewProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mangaListViewHash();

  @$internal
  @override
  _MangaListView create() => _MangaListView();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MangaListView value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MangaListView>(value),
    );
  }
}

String _$mangaListViewHash() => r'a50742a83f1633f48634570c1cd45301db55fad3';

abstract class _$MangaListView extends $Notifier<MangaListView> {
  MangaListView build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MangaListView, MangaListView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MangaListView, MangaListView>,
              MangaListView,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(readBorderTheme)
const readBorderThemeProvider = ReadBorderThemeFamily._();

final class ReadBorderThemeProvider
    extends $FunctionalProvider<BoxDecoration, BoxDecoration, BoxDecoration>
    with $Provider<BoxDecoration> {
  const ReadBorderThemeProvider._({
    required ReadBorderThemeFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'readBorderThemeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = themeProvider;

  @override
  String debugGetCreateSourceHash() => _$readBorderThemeHash();

  @override
  String toString() {
    return r'readBorderThemeProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<BoxDecoration> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BoxDecoration create(Ref ref) {
    final argument = this.argument as (String, String);
    return readBorderTheme(ref, argument.$1, argument.$2);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BoxDecoration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BoxDecoration>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ReadBorderThemeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$readBorderThemeHash() => r'af9b9b235f3f1d51a702fa382c66086fb8869b1d';

final class ReadBorderThemeFamily extends $Family
    with $FunctionalFamilyOverride<BoxDecoration, (String, String)> {
  const ReadBorderThemeFamily._()
    : super(
        retry: null,
        name: r'readBorderThemeProvider',
        dependencies: const <ProviderOrFamily>[themeProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          ReadBorderThemeProvider.$allTransitiveDependencies0,
        ],
        isAutoDispose: true,
      );

  ReadBorderThemeProvider call(String mangaId, String chapterId) =>
      ReadBorderThemeProvider._(argument: (mangaId, chapterId), from: this);

  @override
  String toString() => r'readBorderThemeProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
