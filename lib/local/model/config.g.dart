// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalLibConfigImpl _$$LocalLibConfigImplFromJson(Map<String, dynamic> json) =>
    _$LocalLibConfigImpl(
      libraryDirectory: json['libraryDirectory'] as String? ?? '',
    );

Map<String, dynamic> _$$LocalLibConfigImplToJson(
        _$LocalLibConfigImpl instance) =>
    <String, dynamic>{
      'libraryDirectory': instance.libraryDirectory,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(LocalConfig)
const localConfigProvider = LocalConfigProvider._();

final class LocalConfigProvider
    extends $NotifierProvider<LocalConfig, LocalLibConfig> {
  const LocalConfigProvider._(
      {super.runNotifierBuildOverride, LocalConfig Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'localConfigProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final LocalConfig Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$localConfigHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalLibConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<LocalLibConfig>(value),
    );
  }

  @$internal
  @override
  LocalConfig create() => _createCb?.call() ?? LocalConfig();

  @$internal
  @override
  LocalConfigProvider $copyWithCreate(
    LocalConfig Function() create,
  ) {
    return LocalConfigProvider._(create: create);
  }

  @$internal
  @override
  LocalConfigProvider $copyWithBuild(
    LocalLibConfig Function(
      Ref,
      LocalConfig,
    ) build,
  ) {
    return LocalConfigProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$LocalConfigElement $createElement($ProviderPointer pointer) =>
      _$LocalConfigElement(this, pointer);

  ProviderListenable<LocalConfig$Save> get save =>
      $LazyProxyListenable<LocalConfig$Save, LocalLibConfig>(
        this,
        (element) {
          element as _$LocalConfigElement;

          return element._$save;
        },
      );
}

String _$localConfigHash() => r'fb372f5d9185395eac934b890e8f1c409970d07b';

abstract class _$LocalConfig extends $Notifier<LocalLibConfig> {
  LocalLibConfig build();
  @$internal
  @override
  LocalLibConfig runBuild() => build();
}

class _$LocalConfigElement
    extends $NotifierProviderElement<LocalConfig, LocalLibConfig> {
  _$LocalConfigElement(super.provider, super.pointer) {
    _$save.result = $Result.data(_$LocalConfig$Save(this));
  }
  final _$save = $ElementLense<_$LocalConfig$Save>();
  @override
  void mount() {
    super.mount();
    _$save.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$save);
  }
}

sealed class LocalConfig$Save extends MutationBase<LocalLibConfig> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [LocalConfig.save] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<LocalLibConfig> call(LocalLibConfig update);
}

final class _$LocalConfig$Save
    extends $SyncMutationBase<LocalLibConfig, _$LocalConfig$Save, LocalConfig>
    implements LocalConfig$Save {
  _$LocalConfig$Save(this.element, {super.state, super.key});

  @override
  final _$LocalConfigElement element;

  @override
  $ElementLense<_$LocalConfig$Save> get listenable => element._$save;

  @override
  Future<LocalLibConfig> call(LocalLibConfig update) {
    return mutateAsync(
      Invocation.method(
        #save,
        [update],
      ),
      ($notifier) => $notifier.save(
        update,
      ),
    );
  }

  @override
  _$LocalConfig$Save copyWith(MutationState<LocalLibConfig> state,
          {Object? key}) =>
      _$LocalConfig$Save(element, state: state, key: key);
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
