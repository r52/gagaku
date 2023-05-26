// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LocalLibConfig _$$_LocalLibConfigFromJson(Map<String, dynamic> json) =>
    _$_LocalLibConfig(
      libraryDirectory: json['libraryDirectory'] as String? ?? '',
    );

Map<String, dynamic> _$$_LocalLibConfigToJson(_$_LocalLibConfig instance) =>
    <String, dynamic>{
      'libraryDirectory': instance.libraryDirectory,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localConfigHash() => r'a7542985371cc8fd8de7008d1a7f7ae65fa07f6e';

/// See also [LocalConfig].
@ProviderFor(LocalConfig)
final localConfigProvider =
    NotifierProvider<LocalConfig, LocalLibConfig>.internal(
  LocalConfig.new,
  name: r'localConfigProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$localConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocalConfig = Notifier<LocalLibConfig>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
