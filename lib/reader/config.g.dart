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
      precacheCount: (json['precacheCount'] as num?)?.toInt() ?? 3,
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

@ProviderFor(ReaderSettings)
const readerSettingsProvider = ReaderSettingsProvider._();

final class ReaderSettingsProvider
    extends $NotifierProvider<ReaderSettings, ReaderConfig> {
  const ReaderSettingsProvider._(
      {super.runNotifierBuildOverride, ReaderSettings Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'readerSettingsProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final ReaderSettings Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$readerSettingsHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReaderConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ReaderConfig>(value),
    );
  }

  @$internal
  @override
  ReaderSettings create() => _createCb?.call() ?? ReaderSettings();

  @$internal
  @override
  ReaderSettingsProvider $copyWithCreate(
    ReaderSettings Function() create,
  ) {
    return ReaderSettingsProvider._(create: create);
  }

  @$internal
  @override
  ReaderSettingsProvider $copyWithBuild(
    ReaderConfig Function(
      Ref,
      ReaderSettings,
    ) build,
  ) {
    return ReaderSettingsProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<ReaderSettings, ReaderConfig> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(this, pointer);
}

String _$readerSettingsHash() => r'32da40797d96254b0532f7dd2f50636d78121465';

abstract class _$ReaderSettings extends $Notifier<ReaderConfig> {
  ReaderConfig build();
  @$internal
  @override
  ReaderConfig runBuild() => build();
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
