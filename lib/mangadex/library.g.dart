// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LibraryViewType)
final libraryViewTypeProvider = LibraryViewTypeProvider._();

final class LibraryViewTypeProvider
    extends $NotifierProvider<LibraryViewType, MangaReadingStatus> {
  LibraryViewTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'libraryViewTypeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$libraryViewTypeHash();

  @$internal
  @override
  LibraryViewType create() => LibraryViewType();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MangaReadingStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MangaReadingStatus>(value),
    );
  }
}

String _$libraryViewTypeHash() => r'fa2f63791b8cda5c72e6ee8d27bf417968d97753';

abstract class _$LibraryViewType extends $Notifier<MangaReadingStatus> {
  MangaReadingStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MangaReadingStatus, MangaReadingStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MangaReadingStatus, MangaReadingStatus>,
              MangaReadingStatus,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
