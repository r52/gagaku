// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GagakuConfig _$GagakuConfigFromJson(Map<String, dynamic> json) => GagakuConfig(
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
      $enumDecodeNullable(_$GridAlbumExtentEnumMap, json['gridAlbumExtent']) ??
      GridAlbumExtent.medium,
  checkForUpdates: json['checkForUpdates'] as bool? ?? true,
  updateCheckCooldownHours:
      (json['updateCheckCooldownHours'] as num?)?.toInt() ?? 24,
  updateChannel: json['updateChannel'] as String? ?? 'stable',
  ignoredUpdates:
      (json['ignoredUpdates'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  lastUpdateCheck: json['lastUpdateCheck'] == null
      ? null
      : DateTime.parse(json['lastUpdateCheck'] as String),
);

Map<String, dynamic> _$GagakuConfigToJson(GagakuConfig instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'theme': _$GagakuThemeEnumMap[instance.theme]!,
      'gridAlbumExtent': _$GridAlbumExtentEnumMap[instance.gridAlbumExtent]!,
      'checkForUpdates': instance.checkForUpdates,
      'updateCheckCooldownHours': instance.updateCheckCooldownHours,
      'updateChannel': instance.updateChannel,
      'ignoredUpdates': instance.ignoredUpdates,
      'lastUpdateCheck': instance.lastUpdateCheck?.toIso8601String(),
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

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GagakuSettings)
final gagakuSettingsProvider = GagakuSettingsProvider._();

final class GagakuSettingsProvider
    extends $NotifierProvider<GagakuSettings, GagakuConfig> {
  GagakuSettingsProvider._()
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

String _$gagakuSettingsHash() => r'96625ca037bbe36bbc09bec40472ead5f1b393d8';

abstract class _$GagakuSettings extends $Notifier<GagakuConfig> {
  GagakuConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GagakuConfig, GagakuConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GagakuConfig, GagakuConfig>,
              GagakuConfig,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
