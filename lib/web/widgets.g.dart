// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgets.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_extensionIcon)
const _extensionIconProvider = _ExtensionIconProvider._();

final class _ExtensionIconProvider
    extends
        $FunctionalProvider<
          Map<String, Widget>,
          Map<String, Widget>,
          Map<String, Widget>
        >
    with $Provider<Map<String, Widget>> {
  const _ExtensionIconProvider._()
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

String _$_extensionIconHash() => r'fdf9ba6fcf51980d54414ebae2514f1e107aef30';

@ProviderFor(_MangaListView)
const _mangaListViewProvider = _MangaListViewProvider._();

final class _MangaListViewProvider
    extends $NotifierProvider<_MangaListView, WebMangaListView> {
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
    final created = build();
    final ref = this.ref as $Ref<WebMangaListView, WebMangaListView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WebMangaListView, WebMangaListView>,
              WebMangaListView,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
