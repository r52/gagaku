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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GagakuConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GagakuConfig>(value),
    );
  }
}

String _$gagakuSettingsHash() => r'fe542021bde33b2b0d97ab5ccd4354255d348e1c';

abstract class _$GagakuSettings extends $Notifier<GagakuConfig> {
  GagakuConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GagakuConfig, GagakuConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GagakuConfig, GagakuConfig>,
              GagakuConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
