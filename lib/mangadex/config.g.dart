// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MangaDexConfig _$$_MangaDexConfigFromJson(Map<String, dynamic> json) =>
    _$_MangaDexConfig(
      translatedLanguages: (json['translatedLanguages'] as List<dynamic>?)
              ?.map(const LanguageConverter().fromJson)
              .toSet() ??
          const {},
      originalLanguage: (json['originalLanguage'] as List<dynamic>?)
              ?.map(const LanguageConverter().fromJson)
              .toSet() ??
          const {},
      contentRating: (json['contentRating'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ContentRatingEnumMap, e))
              .toSet() ??
          const {
            ContentRating.safe,
            ContentRating.suggestive,
            ContentRating.erotica
          },
      dataSaver: json['dataSaver'] as bool? ?? false,
    );

Map<String, dynamic> _$$_MangaDexConfigToJson(_$_MangaDexConfig instance) =>
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

String _$mdConfigHash() => r'422f9d65f920b9d170177915dd44611f9081332b';

/// See also [MdConfig].
@ProviderFor(MdConfig)
final mdConfigProvider =
    AutoDisposeNotifierProvider<MdConfig, MangaDexConfig>.internal(
  MdConfig.new,
  name: r'mdConfigProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mdConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MdConfig = AutoDisposeNotifier<MangaDexConfig>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
