// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_network_image.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(extensionImageCache)
final extensionImageCacheProvider = ExtensionImageCacheProvider._();

final class ExtensionImageCacheProvider
    extends
        $FunctionalProvider<
          BaseCacheManager,
          BaseCacheManager,
          BaseCacheManager
        >
    with $Provider<BaseCacheManager> {
  ExtensionImageCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'extensionImageCacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$extensionImageCacheHash();

  @$internal
  @override
  $ProviderElement<BaseCacheManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BaseCacheManager create(Ref ref) {
    return extensionImageCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseCacheManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseCacheManager>(value),
    );
  }
}

String _$extensionImageCacheHash() =>
    r'5f4b3d11d2dcc8d1857def0c9933d28f712771f8';
