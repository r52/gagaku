// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GagakuConfigImpl _$$GagakuConfigImplFromJson(Map<String, dynamic> json) =>
    _$GagakuConfigImpl(
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      theme: $enumDecodeNullable(_$GagakuThemeEnumMap, json['theme'],
              unknownValue: GagakuTheme.lime) ??
          GagakuTheme.lime,
      gridAlbumExtent: $enumDecodeNullable(
              _$GridAlbumExtentEnumMap, json['gridAlbumExtent']) ??
          GridAlbumExtent.medium,
    );

Map<String, dynamic> _$$GagakuConfigImplToJson(_$GagakuConfigImpl instance) =>
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
  const GagakuSettingsProvider._(
      {super.runNotifierBuildOverride, GagakuSettings Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'gagakuSettingsProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final GagakuSettings Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$gagakuSettingsHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GagakuConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<GagakuConfig>(value),
    );
  }

  @$internal
  @override
  GagakuSettings create() => _createCb?.call() ?? GagakuSettings();

  @$internal
  @override
  GagakuSettingsProvider $copyWithCreate(
    GagakuSettings Function() create,
  ) {
    return GagakuSettingsProvider._(create: create);
  }

  @$internal
  @override
  GagakuSettingsProvider $copyWithBuild(
    GagakuConfig Function(
      Ref,
      GagakuSettings,
    ) build,
  ) {
    return GagakuSettingsProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<GagakuSettings, GagakuConfig> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(this, pointer);
}

String _$gagakuSettingsHash() => r'9a86d3ab2de272269cf61bf2eb0c64e22ae2b701';

abstract class _$GagakuSettings extends $Notifier<GagakuConfig> {
  GagakuConfig build();
  @$internal
  @override
  GagakuConfig runBuild() => build();
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
