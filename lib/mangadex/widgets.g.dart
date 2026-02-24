// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgets.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_MangaListView)
final _mangaListViewProvider = _MangaListViewProvider._();

final class _MangaListViewProvider
    extends $NotifierProvider<_MangaListView, MangaListView> {
  _MangaListViewProvider._()
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
  String debugGetCreateSourceHash() => _$_mangaListViewHash();

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

String _$_mangaListViewHash() => r'a50742a83f1633f48634570c1cd45301db55fad3';

abstract class _$MangaListView extends $Notifier<MangaListView> {
  MangaListView build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MangaListView, MangaListView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MangaListView, MangaListView>,
              MangaListView,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(readBorderTheme)
final readBorderThemeProvider = ReadBorderThemeFamily._();

final class ReadBorderThemeProvider
    extends $FunctionalProvider<BoxDecoration, BoxDecoration, BoxDecoration>
    with $Provider<BoxDecoration> {
  ReadBorderThemeProvider._({
    required ReadBorderThemeFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'readBorderThemeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = themeProvider;

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

String _$readBorderThemeHash() => r'960e26849bec4bc2f3e384adf5f9303bf3221869';

final class ReadBorderThemeFamily extends $Family
    with $FunctionalFamilyOverride<BoxDecoration, (String, String)> {
  ReadBorderThemeFamily._()
    : super(
        retry: null,
        name: r'readBorderThemeProvider',
        dependencies: <ProviderOrFamily>[themeProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ReadBorderThemeProvider.$allTransitiveDependencies0,
        ],
        isAutoDispose: true,
      );

  ReadBorderThemeProvider call(String mangaId, String chapterId) =>
      ReadBorderThemeProvider._(argument: (mangaId, chapterId), from: this);

  @override
  String toString() => r'readBorderThemeProvider';
}
