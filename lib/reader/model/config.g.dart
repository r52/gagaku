// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReaderConfig _$ReaderConfigFromJson(Map<String, dynamic> json) => ReaderConfig(
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

Map<String, dynamic> _$ReaderConfigToJson(ReaderConfig instance) =>
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

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReaderSettings)
final readerSettingsProvider = ReaderSettingsProvider._();

final class ReaderSettingsProvider
    extends $NotifierProvider<ReaderSettings, ReaderConfig> {
  ReaderSettingsProvider._()
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReaderConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReaderConfig>(value),
    );
  }
}

String _$readerSettingsHash() => r'e897742a9f4b6c07b0a15cbaf3d861ce9fd741e4';

abstract class _$ReaderSettings extends $Notifier<ReaderConfig> {
  ReaderConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ReaderConfig, ReaderConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReaderConfig, ReaderConfig>,
              ReaderConfig,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
