// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(LibraryViewType)
const libraryViewTypeProvider = LibraryViewTypeProvider._();

final class LibraryViewTypeProvider
    extends $NotifierProvider<LibraryViewType, MangaReadingStatus> {
  const LibraryViewTypeProvider._()
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
    final created = build();
    final ref = this.ref as $Ref<MangaReadingStatus, MangaReadingStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MangaReadingStatus, MangaReadingStatus>,
              MangaReadingStatus,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(_getLibraryListByType)
const _getLibraryListByTypeProvider = _GetLibraryListByTypeFamily._();

final class _GetLibraryListByTypeProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  const _GetLibraryListByTypeProvider._({
    required _GetLibraryListByTypeFamily super.from,
    required MangaReadingStatus super.argument,
  }) : super(
         retry: noRetry,
         name: r'_getLibraryListByTypeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$_getLibraryListByTypeHash();

  @override
  String toString() {
    return r'_getLibraryListByTypeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    final argument = this.argument as MangaReadingStatus;
    return _getLibraryListByType(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetLibraryListByTypeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$_getLibraryListByTypeHash() =>
    r'a6aea92fe0c99298555dacf03ab6856d99923016';

final class _GetLibraryListByTypeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<String>>, MangaReadingStatus> {
  const _GetLibraryListByTypeFamily._()
    : super(
        retry: noRetry,
        name: r'_getLibraryListByTypeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _GetLibraryListByTypeProvider call(MangaReadingStatus type) =>
      _GetLibraryListByTypeProvider._(argument: type, from: this);

  @override
  String toString() => r'_getLibraryListByTypeProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
