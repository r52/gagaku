// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReaderConfig _$ReaderConfigFromJson(Map<String, dynamic> json) =>
    _ReaderConfig(
      format:
          $enumDecodeNullable(_$ReaderFormatEnumMap, json['format']) ??
          ReaderFormat.single,
      direction:
          $enumDecodeNullable(_$ReaderDirectionEnumMap, json['direction']) ??
          ReaderDirection.leftToRight,
      showProgressBar: json['showProgressBar'] as bool? ?? false,
      clickToTurn: json['clickToTurn'] as bool? ?? true,
      swipeGestures: json['swipeGestures'] as bool? ?? true,
      precacheCount: (json['precacheCount'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$ReaderConfigToJson(_ReaderConfig instance) =>
    <String, dynamic>{
      'format': _$ReaderFormatEnumMap[instance.format]!,
      'direction': _$ReaderDirectionEnumMap[instance.direction]!,
      'showProgressBar': instance.showProgressBar,
      'clickToTurn': instance.clickToTurn,
      'swipeGestures': instance.swipeGestures,
      'precacheCount': instance.precacheCount,
    };

const _$ReaderFormatEnumMap = {
  ReaderFormat.single: 'single',
  ReaderFormat.longstrip: 'longstrip',
};

const _$ReaderDirectionEnumMap = {
  ReaderDirection.leftToRight: 'leftToRight',
  ReaderDirection.rightToLeft: 'rightToLeft',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ReaderSettings)
const readerSettingsProvider = ReaderSettingsProvider._();

final class ReaderSettingsProvider
    extends $NotifierProvider<ReaderSettings, ReaderConfig> {
  const ReaderSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readerSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readerSettingsHash();

  @$internal
  @override
  ReaderSettings create() => ReaderSettings();

  @$internal
  @override
  _$ReaderSettingsElement $createElement($ProviderPointer pointer) =>
      _$ReaderSettingsElement(pointer);

  ProviderListenable<ReaderSettings$Save> get save =>
      $LazyProxyListenable<ReaderSettings$Save, ReaderConfig>(this, (element) {
        element as _$ReaderSettingsElement;

        return element._$save;
      });

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReaderConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ReaderConfig>(value),
    );
  }
}

String _$readerSettingsHash() => r'3a6d6cfe488873955a1dc0fbab82f33d87eab125';

abstract class _$ReaderSettings extends $Notifier<ReaderConfig> {
  ReaderConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ReaderConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReaderConfig>,
              ReaderConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$ReaderSettingsElement
    extends $NotifierProviderElement<ReaderSettings, ReaderConfig> {
  _$ReaderSettingsElement(super.pointer) {
    _$save.result = $Result.data(_$ReaderSettings$Save(this));
  }
  final _$save = $ElementLense<_$ReaderSettings$Save>();
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

sealed class ReaderSettings$Save extends MutationBase<ReaderConfig> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [ReaderSettings.save] with the provided parameters.
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
  ReaderConfig call(ReaderConfig update);
}

final class _$ReaderSettings$Save
    extends
        $SyncMutationBase<ReaderConfig, _$ReaderSettings$Save, ReaderSettings>
    implements ReaderSettings$Save {
  _$ReaderSettings$Save(this.element, {super.state, super.key});

  @override
  final _$ReaderSettingsElement element;

  @override
  $ElementLense<_$ReaderSettings$Save> get listenable => element._$save;

  @override
  ReaderConfig call(ReaderConfig update) {
    return mutate(
      Invocation.method(#save, [update]),
      ($notifier) => $notifier.save(update),
    );
  }

  @override
  _$ReaderSettings$Save copyWith(
    MutationState<ReaderConfig> state, {
    Object? key,
  }) => _$ReaderSettings$Save(element, state: state, key: key);
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
