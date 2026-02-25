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
