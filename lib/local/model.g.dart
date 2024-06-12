// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
      Ref<AsyncValue<LocalLibraryItem>>,
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

String _$localLibraryHash() => r'9f011f22650d03b07338a61270d62ee5f9cac2c3';

abstract class _$LocalLibrary extends $AsyncNotifier<LocalLibraryItem> {
  FutureOr<LocalLibraryItem> build();
  @$internal
  @override
  FutureOr<LocalLibraryItem> runBuild() => build();
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
      Ref<AsyncValue<FormatInfo>>,
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
  FutureOr<FormatInfo> runBuild() => build();
}

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
