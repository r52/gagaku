// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReaderConfigImpl _$$ReaderConfigImplFromJson(Map<String, dynamic> json) =>
    _$ReaderConfigImpl(
      format: $enumDecodeNullable(_$ReaderFormatEnumMap, json['format']) ??
          ReaderFormat.single,
      direction:
          $enumDecodeNullable(_$ReaderDirectionEnumMap, json['direction']) ??
              ReaderDirection.leftToRight,
      showProgressBar: json['showProgressBar'] as bool? ?? false,
      clickToTurn: json['clickToTurn'] as bool? ?? true,
      swipeGestures: json['swipeGestures'] as bool? ?? true,
      precacheCount: json['precacheCount'] as int? ?? 3,
    );

Map<String, dynamic> _$$ReaderConfigImplToJson(_$ReaderConfigImpl instance) =>
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

String _$readerSettingsHash() => r'32da40797d96254b0532f7dd2f50636d78121465';

/// See also [ReaderSettings].
@ProviderFor(ReaderSettings)
final readerSettingsProvider =
    AutoDisposeNotifierProvider<ReaderSettings, ReaderConfig>.internal(
  ReaderSettings.new,
  name: r'readerSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$readerSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReaderSettings = AutoDisposeNotifier<ReaderConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
