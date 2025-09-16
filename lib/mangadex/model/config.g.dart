// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaDexConfig _$MangaDexConfigFromJson(Map<String, dynamic> json) =>
    MangaDexConfig(
      translatedLanguages:
          (json['translatedLanguages'] as List<dynamic>?)
              ?.map(const LanguageConverter().fromJson)
              .toSet() ??
          const {},
      originalLanguage:
          (json['originalLanguage'] as List<dynamic>?)
              ?.map(const LanguageConverter().fromJson)
              .toSet() ??
          const {},
      contentRating:
          (json['contentRating'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ContentRatingEnumMap, e))
              .toSet() ??
          const {
            ContentRating.safe,
            ContentRating.suggestive,
            ContentRating.erotica,
          },
      dataSaver: json['dataSaver'] as bool? ?? false,
      groupBlacklist:
          (json['groupBlacklist'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
    );

Map<String, dynamic> _$MangaDexConfigToJson(MangaDexConfig instance) =>
    <String, dynamic>{
      'translatedLanguages': instance.translatedLanguages
          .map(const LanguageConverter().toJson)
          .toList(),
      'originalLanguage': instance.originalLanguage
          .map(const LanguageConverter().toJson)
          .toList(),
      'contentRating': instance.contentRating
          .map((e) => _$ContentRatingEnumMap[e]!)
          .toList(),
      'dataSaver': instance.dataSaver,
      'groupBlacklist': instance.groupBlacklist.toList(),
    };

const _$ContentRatingEnumMap = {
  ContentRating.safe: 'safe',
  ContentRating.suggestive: 'suggestive',
  ContentRating.erotica: 'erotica',
  ContentRating.pornographic: 'pornographic',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MdConfig)
const mdConfigProvider = MdConfigProvider._();

final class MdConfigProvider
    extends $NotifierProvider<MdConfig, MangaDexConfig> {
  const MdConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mdConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mdConfigHash();

  @$internal
  @override
  MdConfig create() => MdConfig();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MangaDexConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MangaDexConfig>(value),
    );
  }
}

String _$mdConfigHash() => r'5bee396207d67c8d8ec0aab2f512bbe7dcad3c78';

abstract class _$MdConfig extends $Notifier<MangaDexConfig> {
  MangaDexConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MangaDexConfig, MangaDexConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MangaDexConfig, MangaDexConfig>,
              MangaDexConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
