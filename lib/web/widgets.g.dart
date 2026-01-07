// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgets.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_extensionIcon)
final _extensionIconProvider = _ExtensionIconProvider._();

final class _ExtensionIconProvider
    extends
        $FunctionalProvider<
          Map<String, Widget>,
          Map<String, Widget>,
          Map<String, Widget>
        >
    with $Provider<Map<String, Widget>> {
  _ExtensionIconProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_extensionIconProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_extensionIconHash();

  @$internal
  @override
  $ProviderElement<Map<String, Widget>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, Widget> create(Ref ref) {
    return _extensionIcon(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, Widget> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, Widget>>(value),
    );
  }
}

String _$_extensionIconHash() => r'61813649fc5f797bcabfa31fff00b6c8cdc096f3';

@ProviderFor(_MangaListView)
final _mangaListViewProvider = _MangaListViewProvider._();

final class _MangaListViewProvider
    extends $NotifierProvider<_MangaListView, WebMangaListView> {
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
  Override overrideWithValue(WebMangaListView value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebMangaListView>(value),
    );
  }
}

String _$_mangaListViewHash() => r'7612ea641ea8b61bcc8a8f95606c95d63d0d5111';

abstract class _$MangaListView extends $Notifier<WebMangaListView> {
  WebMangaListView build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<WebMangaListView, WebMangaListView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WebMangaListView, WebMangaListView>,
              WebMangaListView,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
