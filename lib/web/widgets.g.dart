// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgets.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_MangaListView)
const _mangaListViewProvider = _MangaListViewProvider._();

final class _MangaListViewProvider
    extends $NotifierProvider<_MangaListView, WebMangaListView> {
  const _MangaListViewProvider._(
      {super.runNotifierBuildOverride, _MangaListView Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'_mangaListViewProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final _MangaListView Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$mangaListViewHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebMangaListView value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<WebMangaListView>(value),
    );
  }

  @$internal
  @override
  _MangaListView create() => _createCb?.call() ?? _MangaListView();

  @$internal
  @override
  _MangaListViewProvider $copyWithCreate(
    _MangaListView Function() create,
  ) {
    return _MangaListViewProvider._(create: create);
  }

  @$internal
  @override
  _MangaListViewProvider $copyWithBuild(
    WebMangaListView Function(
      Ref,
      _MangaListView,
    ) build,
  ) {
    return _MangaListViewProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<_MangaListView, WebMangaListView> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(this, pointer);
}

String _$mangaListViewHash() => r'7612ea641ea8b61bcc8a8f95606c95d63d0d5111';

abstract class _$MangaListView extends $Notifier<WebMangaListView> {
  WebMangaListView build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WebMangaListView>;
    final element = ref.element as $ClassProviderElement<
        NotifierBase<WebMangaListView>, WebMangaListView, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
