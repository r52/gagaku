// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_feed_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateFeedRepository)
final updateFeedRepositoryProvider = UpdateFeedRepositoryProvider._();

final class UpdateFeedRepositoryProvider
    extends
        $FunctionalProvider<
          UpdateFeedRepository,
          UpdateFeedRepository,
          UpdateFeedRepository
        >
    with $Provider<UpdateFeedRepository> {
  UpdateFeedRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateFeedRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateFeedRepositoryHash();

  @$internal
  @override
  $ProviderElement<UpdateFeedRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateFeedRepository create(Ref ref) {
    return updateFeedRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateFeedRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateFeedRepository>(value),
    );
  }
}

String _$updateFeedRepositoryHash() =>
    r'76c519825115b15863112d32b2b9a003220d12af';

@ProviderFor(updateFeedPlatform)
final updateFeedPlatformProvider = UpdateFeedPlatformProvider._();

final class UpdateFeedPlatformProvider
    extends
        $FunctionalProvider<
          UpdateFeedPlatform,
          UpdateFeedPlatform,
          UpdateFeedPlatform
        >
    with $Provider<UpdateFeedPlatform> {
  UpdateFeedPlatformProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateFeedPlatformProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateFeedPlatformHash();

  @$internal
  @override
  $ProviderElement<UpdateFeedPlatform> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateFeedPlatform create(Ref ref) {
    return updateFeedPlatform(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateFeedPlatform value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateFeedPlatform>(value),
    );
  }
}

String _$updateFeedPlatformHash() =>
    r'50805807eef0ad737af7ffbf66624bdc0ecbbc1b';

@ProviderFor(updateFeedRunner)
final updateFeedRunnerProvider = UpdateFeedRunnerProvider._();

final class UpdateFeedRunnerProvider
    extends
        $FunctionalProvider<
          UpdateFeedRunner,
          UpdateFeedRunner,
          UpdateFeedRunner
        >
    with $Provider<UpdateFeedRunner> {
  UpdateFeedRunnerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateFeedRunnerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateFeedRunnerHash();

  @$internal
  @override
  $ProviderElement<UpdateFeedRunner> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateFeedRunner create(Ref ref) {
    return updateFeedRunner(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateFeedRunner value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateFeedRunner>(value),
    );
  }
}

String _$updateFeedRunnerHash() => r'32ef7657b3c4bf9061b27bad92262387b70c1e6a';

@ProviderFor(updateFeedCategories)
final updateFeedCategoriesProvider = UpdateFeedCategoriesProvider._();

final class UpdateFeedCategoriesProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  UpdateFeedCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateFeedCategoriesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateFeedCategoriesHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return updateFeedCategories(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$updateFeedCategoriesHash() =>
    r'81539c99c9ab782356cbcb1a8a08b2f26bf699f9';

@ProviderFor(WebUpdateFeedController)
final webUpdateFeedControllerProvider = WebUpdateFeedControllerProvider._();

final class WebUpdateFeedControllerProvider
    extends $AsyncNotifierProvider<WebUpdateFeedController, UpdateFeedState> {
  WebUpdateFeedControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webUpdateFeedControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webUpdateFeedControllerHash();

  @$internal
  @override
  WebUpdateFeedController create() => WebUpdateFeedController();
}

String _$webUpdateFeedControllerHash() =>
    r'203b369cd7263f221c20450be87b476ad8c92659';

abstract class _$WebUpdateFeedController
    extends $AsyncNotifier<UpdateFeedState> {
  FutureOr<UpdateFeedState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UpdateFeedState>, UpdateFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UpdateFeedState>, UpdateFeedState>,
              AsyncValue<UpdateFeedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
