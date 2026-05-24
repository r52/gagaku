// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_checker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateChecker)
final updateCheckerProvider = UpdateCheckerProvider._();

final class UpdateCheckerProvider
    extends $AsyncNotifierProvider<UpdateChecker, UpdateResult> {
  UpdateCheckerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateCheckerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateCheckerHash();

  @$internal
  @override
  UpdateChecker create() => UpdateChecker();
}

String _$updateCheckerHash() => r'238956bc17c9f1ca933b799ae3f24c73355b4f23';

abstract class _$UpdateChecker extends $AsyncNotifier<UpdateResult> {
  FutureOr<UpdateResult> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UpdateResult>, UpdateResult>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UpdateResult>, UpdateResult>,
              AsyncValue<UpdateResult>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
