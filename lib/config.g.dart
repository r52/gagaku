// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GagakuConfigImpl _$$GagakuConfigImplFromJson(Map<String, dynamic> json) =>
    _$GagakuConfigImpl(
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      theme: json['theme'] == null
          ? Colors.amber
          : const ColorConverter().fromJson(json['theme']),
    );

Map<String, dynamic> _$$GagakuConfigImplToJson(_$GagakuConfigImpl instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'theme': const ColorConverter().toJson(instance.theme),
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gagakuSettingsHash() => r'9a86d3ab2de272269cf61bf2eb0c64e22ae2b701';

/// See also [GagakuSettings].
@ProviderFor(GagakuSettings)
final gagakuSettingsProvider =
    AutoDisposeNotifierProvider<GagakuSettings, GagakuConfig>.internal(
  GagakuSettings.new,
  name: r'gagakuSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gagakuSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GagakuSettings = AutoDisposeNotifier<GagakuConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
