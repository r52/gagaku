// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReaderConfig _$$_ReaderConfigFromJson(Map<String, dynamic> json) =>
    _$_ReaderConfig(
      direction:
          $enumDecodeNullable(_$ReaderDirectionEnumMap, json['direction']) ??
              ReaderDirection.leftToRight,
      showProgressBar: json['showProgressBar'] as bool? ?? false,
      clickToTurn: json['clickToTurn'] as bool? ?? true,
      swipeGestures: json['swipeGestures'] as bool? ?? true,
      precacheCount: json['precacheCount'] as int? ?? 3,
    );

Map<String, dynamic> _$$_ReaderConfigToJson(_$_ReaderConfig instance) =>
    <String, dynamic>{
      'direction': _$ReaderDirectionEnumMap[instance.direction]!,
      'showProgressBar': instance.showProgressBar,
      'clickToTurn': instance.clickToTurn,
      'swipeGestures': instance.swipeGestures,
      'precacheCount': instance.precacheCount,
    };

const _$ReaderDirectionEnumMap = {
  ReaderDirection.leftToRight: 'leftToRight',
  ReaderDirection.rightToLeft: 'rightToLeft',
  ReaderDirection.topToBottom: 'topToBottom',
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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
