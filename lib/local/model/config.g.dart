// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocalLibConfig _$LocalLibConfigFromJson(Map<String, dynamic> json) =>
    _LocalLibConfig(
      libraryDirectory: json['libraryDirectory'] as String? ?? '',
    );

Map<String, dynamic> _$LocalLibConfigToJson(_LocalLibConfig instance) =>
    <String, dynamic>{'libraryDirectory': instance.libraryDirectory};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(LocalConfig)
const localConfigProvider = LocalConfigProvider._();

final class LocalConfigProvider
    extends $NotifierProvider<LocalConfig, LocalLibConfig> {
  const LocalConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localConfigHash();

  @$internal
  @override
  LocalConfig create() => LocalConfig();

  @$internal
  @override
  _$LocalConfigElement $createElement($ProviderPointer pointer) =>
      _$LocalConfigElement(pointer);

  ProviderListenable<LocalConfig$Save> get save =>
      $LazyProxyListenable<LocalConfig$Save, LocalLibConfig>(this, (element) {
        element as _$LocalConfigElement;

        return element._$save;
      });

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalLibConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<LocalLibConfig>(value),
    );
  }
}

String _$localConfigHash() => r'95b13d718adababe7f3396ca3becff593f1cc8c3';

abstract class _$LocalConfig extends $Notifier<LocalLibConfig> {
  LocalLibConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LocalLibConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LocalLibConfig>,
              LocalLibConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$LocalConfigElement
    extends $NotifierProviderElement<LocalConfig, LocalLibConfig> {
  _$LocalConfigElement(super.pointer) {
    _$save.result = $Result.data(_$LocalConfig$Save(this));
  }
  final _$save = $ElementLense<_$LocalConfig$Save>();
  @override
  void mount() {
    super.mount();
    _$save.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

    listenableVisitor(_$save);
  }
}

sealed class LocalConfig$Save extends MutationBase<LocalLibConfig> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [LocalConfig.save] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  LocalLibConfig call(LocalLibConfig update);
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
  LocalLibConfig call(LocalLibConfig update) {
    return mutate(
      Invocation.method(#save, [update]),
      ($notifier) => $notifier.save(update),
    );
  }

  @override
  _$LocalConfig$Save copyWith(
    MutationState<LocalLibConfig> state, {
    Object? key,
  }) => _$LocalConfig$Save(element, state: state, key: key);
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
