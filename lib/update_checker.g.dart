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

String _$updateCheckerHash() => r'752ed6c495e0d9e0197fa214c420d2db8076dc21';

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
