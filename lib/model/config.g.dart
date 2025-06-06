// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GagakuConfig _$GagakuConfigFromJson(Map<String, dynamic> json) =>
    _GagakuConfig(
      themeMode:
          $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      theme:
          $enumDecodeNullable(
            _$GagakuThemeEnumMap,
            json['theme'],
            unknownValue: GagakuTheme.lime,
          ) ??
          GagakuTheme.lime,
      gridAlbumExtent:
          $enumDecodeNullable(
            _$GridAlbumExtentEnumMap,
            json['gridAlbumExtent'],
          ) ??
          GridAlbumExtent.medium,
    );

Map<String, dynamic> _$GagakuConfigToJson(_GagakuConfig instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'theme': _$GagakuThemeEnumMap[instance.theme]!,
      'gridAlbumExtent': _$GridAlbumExtentEnumMap[instance.gridAlbumExtent]!,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$GagakuThemeEnumMap = {
  GagakuTheme.lime: 'lime',
  GagakuTheme.grey: 'grey',
  GagakuTheme.amber: 'amber',
  GagakuTheme.blue: 'blue',
  GagakuTheme.teal: 'teal',
  GagakuTheme.green: 'green',
  GagakuTheme.lightgreen: 'lightgreen',
  GagakuTheme.red: 'red',
  GagakuTheme.orange: 'orange',
  GagakuTheme.yellow: 'yellow',
  GagakuTheme.purple: 'purple',
};

const _$GridAlbumExtentEnumMap = {
  GridAlbumExtent.xsmall: 'xsmall',
  GridAlbumExtent.small: 'small',
  GridAlbumExtent.medium: 'medium',
  GridAlbumExtent.large: 'large',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(GagakuSettings)
const gagakuSettingsProvider = GagakuSettingsProvider._();

final class GagakuSettingsProvider
    extends $NotifierProvider<GagakuSettings, GagakuConfig> {
  const GagakuSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gagakuSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gagakuSettingsHash();

  @$internal
  @override
  GagakuSettings create() => GagakuSettings();

  @$internal
  @override
  _$GagakuSettingsElement $createElement($ProviderPointer pointer) =>
      _$GagakuSettingsElement(pointer);

  ProviderListenable<GagakuSettings$Save> get save =>
      $LazyProxyListenable<GagakuSettings$Save, GagakuConfig>(this, (element) {
        element as _$GagakuSettingsElement;

        return element._$save;
      });

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GagakuConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<GagakuConfig>(value),
    );
  }
}

String _$gagakuSettingsHash() => r'3174dadb28b7bc4f1b2521e6e41201bdbe5d0814';

abstract class _$GagakuSettings extends $Notifier<GagakuConfig> {
  GagakuConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GagakuConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GagakuConfig>,
              GagakuConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$GagakuSettingsElement
    extends $NotifierProviderElement<GagakuSettings, GagakuConfig> {
  _$GagakuSettingsElement(super.pointer) {
    _$save.result = $Result.data(_$GagakuSettings$Save(this));
  }
  final _$save = $ElementLense<_$GagakuSettings$Save>();
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

sealed class GagakuSettings$Save extends MutationBase<GagakuConfig> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [GagakuSettings.save] with the provided parameters.
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
  GagakuConfig call(GagakuConfig update);
}

final class _$GagakuSettings$Save
    extends
        $SyncMutationBase<GagakuConfig, _$GagakuSettings$Save, GagakuSettings>
    implements GagakuSettings$Save {
  _$GagakuSettings$Save(this.element, {super.state, super.key});

  @override
  final _$GagakuSettingsElement element;

  @override
  $ElementLense<_$GagakuSettings$Save> get listenable => element._$save;

  @override
  GagakuConfig call(GagakuConfig update) {
    return mutate(
      Invocation.method(#save, [update]),
      ($notifier) => $notifier.save(update),
    );
  }

  @override
  _$GagakuSettings$Save copyWith(
    MutationState<GagakuConfig> state, {
    Object? key,
  }) => _$GagakuSettings$Save(element, state: state, key: key);
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
