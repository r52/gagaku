// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_thumbnail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(archiveThumbnail)
final archiveThumbnailProvider = ArchiveThumbnailFamily._();

final class ArchiveThumbnailProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  ArchiveThumbnailProvider._({
    required ArchiveThumbnailFamily super.from,
    required LocalLibraryItem super.argument,
  }) : super(
         retry: null,
         name: r'archiveThumbnailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$archiveThumbnailHash();

  @override
  String toString() {
    return r'archiveThumbnailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    final argument = this.argument as LocalLibraryItem;
    return archiveThumbnail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ArchiveThumbnailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$archiveThumbnailHash() => r'acb489d0905c63fdff4955f2d14ab3b788a3b2ce';

final class ArchiveThumbnailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String?>, LocalLibraryItem> {
  ArchiveThumbnailFamily._()
    : super(
        retry: null,
        name: r'archiveThumbnailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArchiveThumbnailProvider call(LocalLibraryItem item) =>
      ArchiveThumbnailProvider._(argument: item, from: this);

  @override
  String toString() => r'archiveThumbnailProvider';
}
