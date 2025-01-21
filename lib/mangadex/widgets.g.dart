// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgets.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_MangaListView)
const _mangaListViewProvider = _MangaListViewProvider._();

final class _MangaListViewProvider
    extends $NotifierProvider<_MangaListView, MangaListView> {
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
  Override overrideWithValue(MangaListView value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<MangaListView>(value),
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
    MangaListView Function(
      Ref,
      _MangaListView,
    ) build,
  ) {
    return _MangaListViewProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<_MangaListView, MangaListView> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(this, pointer);
}

String _$mangaListViewHash() => r'a50742a83f1633f48634570c1cd45301db55fad3';

abstract class _$MangaListView extends $Notifier<MangaListView> {
  MangaListView build();
  @$internal
  @override
  MangaListView runBuild() => build();
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
