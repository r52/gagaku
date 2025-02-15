// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(LibrarySortType)
const librarySortTypeProvider = LibrarySortTypeProvider._();

final class LibrarySortTypeProvider
    extends $NotifierProvider<LibrarySortType, LibrarySort> {
  const LibrarySortTypeProvider._(
      {super.runNotifierBuildOverride, LibrarySortType Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'librarySortTypeProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final LibrarySortType Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$librarySortTypeHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LibrarySort value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<LibrarySort>(value),
    );
  }

  @$internal
  @override
  LibrarySortType create() => _createCb?.call() ?? LibrarySortType();

  @$internal
  @override
  LibrarySortTypeProvider $copyWithCreate(
    LibrarySortType Function() create,
  ) {
    return LibrarySortTypeProvider._(create: create);
  }

  @$internal
  @override
  LibrarySortTypeProvider $copyWithBuild(
    LibrarySort Function(
      Ref,
      LibrarySortType,
    ) build,
  ) {
    return LibrarySortTypeProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<LibrarySortType, LibrarySort> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(this, pointer);
}

String _$librarySortTypeHash() => r'884ea733f1009d8831f3a6fd654e2480908cd7d6';

abstract class _$LibrarySortType extends $Notifier<LibrarySort> {
  LibrarySort build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LibrarySort>;
    final element = ref.element as $ClassProviderElement<
        NotifierBase<LibrarySort>, LibrarySort, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(LocalLibrary)
const localLibraryProvider = LocalLibraryProvider._();

final class LocalLibraryProvider
    extends $AsyncNotifierProvider<LocalLibrary, LocalLibraryItem> {
  const LocalLibraryProvider._(
      {super.runNotifierBuildOverride, LocalLibrary Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'localLibraryProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final LocalLibrary Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$localLibraryHash();

  @$internal
  @override
  LocalLibrary create() => _createCb?.call() ?? LocalLibrary();

  @$internal
  @override
  LocalLibraryProvider $copyWithCreate(
    LocalLibrary Function() create,
  ) {
    return LocalLibraryProvider._(create: create);
  }

  @$internal
  @override
  LocalLibraryProvider $copyWithBuild(
    FutureOr<LocalLibraryItem> Function(
      Ref,
      LocalLibrary,
    ) build,
  ) {
    return LocalLibraryProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<LocalLibrary, LocalLibraryItem> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);
}

String _$localLibraryHash() => r'c84099ad3537b9a8d1d1b4a5123062f4411cc5a2';

abstract class _$LocalLibrary extends $AsyncNotifier<LocalLibraryItem> {
  FutureOr<LocalLibraryItem> build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<LocalLibraryItem>>;
    final element = ref.element as $ClassProviderElement<
        NotifierBase<AsyncValue<LocalLibraryItem>>,
        AsyncValue<LocalLibraryItem>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SupportedFormats)
const supportedFormatsProvider = SupportedFormatsProvider._();

final class SupportedFormatsProvider
    extends $AsyncNotifierProvider<SupportedFormats, FormatInfo> {
  const SupportedFormatsProvider._(
      {super.runNotifierBuildOverride, SupportedFormats Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'supportedFormatsProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final SupportedFormats Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$supportedFormatsHash();

  @$internal
  @override
  SupportedFormats create() => _createCb?.call() ?? SupportedFormats();

  @$internal
  @override
  SupportedFormatsProvider $copyWithCreate(
    SupportedFormats Function() create,
  ) {
    return SupportedFormatsProvider._(create: create);
  }

  @$internal
  @override
  SupportedFormatsProvider $copyWithBuild(
    FutureOr<FormatInfo> Function(
      Ref,
      SupportedFormats,
    ) build,
  ) {
    return SupportedFormatsProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<SupportedFormats, FormatInfo> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);
}

String _$supportedFormatsHash() => r'3840c7ebd8357ef2b7163a74cb1335481d03be80';

abstract class _$SupportedFormats extends $AsyncNotifier<FormatInfo> {
  FutureOr<FormatInfo> build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<FormatInfo>>;
    final element = ref.element as $ClassProviderElement<
        NotifierBase<AsyncValue<FormatInfo>>,
        AsyncValue<FormatInfo>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
