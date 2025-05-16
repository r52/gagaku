// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(LibrarySortType)
const librarySortTypeProvider = LibrarySortTypeProvider._();

final class LibrarySortTypeProvider
    extends $NotifierProvider<LibrarySortType, LibrarySort> {
  const LibrarySortTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'librarySortTypeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$librarySortTypeHash();

  @$internal
  @override
  LibrarySortType create() => LibrarySortType();

  @$internal
  @override
  $NotifierProviderElement<LibrarySortType, LibrarySort> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LibrarySort value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<LibrarySort>(value),
    );
  }
}

String _$librarySortTypeHash() => r'884ea733f1009d8831f3a6fd654e2480908cd7d6';

abstract class _$LibrarySortType extends $Notifier<LibrarySort> {
  LibrarySort build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LibrarySort>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LibrarySort>,
              LibrarySort,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(LocalLibrary)
const localLibraryProvider = LocalLibraryProvider._();

final class LocalLibraryProvider
    extends $AsyncNotifierProvider<LocalLibrary, LocalLibraryItem> {
  const LocalLibraryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localLibraryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localLibraryHash();

  @$internal
  @override
  LocalLibrary create() => LocalLibrary();

  @$internal
  @override
  $AsyncNotifierProviderElement<LocalLibrary, LocalLibraryItem> $createElement(
    $ProviderPointer pointer,
  ) => $AsyncNotifierProviderElement(pointer);
}

String _$localLibraryHash() => r'e5304b940c79acd9ee306bed67941dd1f590840b';

abstract class _$LocalLibrary extends $AsyncNotifier<LocalLibraryItem> {
  FutureOr<LocalLibraryItem> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<LocalLibraryItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LocalLibraryItem>>,
              AsyncValue<LocalLibraryItem>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SupportedFormats)
const supportedFormatsProvider = SupportedFormatsProvider._();

final class SupportedFormatsProvider
    extends $AsyncNotifierProvider<SupportedFormats, FormatInfo> {
  const SupportedFormatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supportedFormatsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supportedFormatsHash();

  @$internal
  @override
  SupportedFormats create() => SupportedFormats();

  @$internal
  @override
  $AsyncNotifierProviderElement<SupportedFormats, FormatInfo> $createElement(
    $ProviderPointer pointer,
  ) => $AsyncNotifierProviderElement(pointer);
}

String _$supportedFormatsHash() => r'3840c7ebd8357ef2b7163a74cb1335481d03be80';

abstract class _$SupportedFormats extends $AsyncNotifier<FormatInfo> {
  FutureOr<FormatInfo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<FormatInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FormatInfo>>,
              AsyncValue<FormatInfo>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
