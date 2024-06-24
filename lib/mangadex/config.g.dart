// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaDexConfigImpl _$$MangaDexConfigImplFromJson(Map<String, dynamic> json) =>
    _$MangaDexConfigImpl(
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
      groupBlacklist: (json['groupBlacklist'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
    );

Map<String, dynamic> _$$MangaDexConfigImplToJson(
        _$MangaDexConfigImpl instance) =>
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

@ProviderFor(MdConfig)
const mdConfigProvider = MdConfigProvider._();

final class MdConfigProvider
    extends $NotifierProvider<MdConfig, MangaDexConfig> {
  const MdConfigProvider._(
      {super.runNotifierBuildOverride, MdConfig Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'mdConfigProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final MdConfig Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$mdConfigHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MangaDexConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<MangaDexConfig>(value),
    );
  }

  @$internal
  @override
  MdConfig create() => _createCb?.call() ?? MdConfig();

  @$internal
  @override
  MdConfigProvider $copyWithCreate(
    MdConfig Function() create,
  ) {
    return MdConfigProvider._(create: create);
  }

  @$internal
  @override
  MdConfigProvider $copyWithBuild(
    MangaDexConfig Function(
      Ref<MangaDexConfig>,
      MdConfig,
    ) build,
  ) {
    return MdConfigProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<MdConfig, MangaDexConfig> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(this, pointer);
}

String _$mdConfigHash() => r'422f9d65f920b9d170177915dd44611f9081332b';

abstract class _$MdConfig extends $Notifier<MangaDexConfig> {
  MangaDexConfig build();
  @$internal
  @override
  MangaDexConfig runBuild() => build();
}

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
