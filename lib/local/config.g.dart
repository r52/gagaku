// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalLibConfigImpl _$$LocalLibConfigImplFromJson(Map<String, dynamic> json) =>
    _$LocalLibConfigImpl(
      libraryDirectory: json['libraryDirectory'] as String? ?? '',
    );

Map<String, dynamic> _$$LocalLibConfigImplToJson(
        _$LocalLibConfigImpl instance) =>
    <String, dynamic>{
      'libraryDirectory': instance.libraryDirectory,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(LocalConfig)
const localConfigProvider = LocalConfigProvider._();

final class LocalConfigProvider
    extends $NotifierProvider<LocalConfig, LocalLibConfig> {
  const LocalConfigProvider._(
      {super.runNotifierBuildOverride, LocalConfig Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'localConfigProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final LocalConfig Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$localConfigHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalLibConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<LocalLibConfig>(value),
    );
  }

  @$internal
  @override
  LocalConfig create() => _createCb?.call() ?? LocalConfig();

  @$internal
  @override
  LocalConfigProvider $copyWithCreate(
    LocalConfig Function() create,
  ) {
    return LocalConfigProvider._(create: create);
  }

  @$internal
  @override
  LocalConfigProvider $copyWithBuild(
    LocalLibConfig Function(
      Ref<LocalLibConfig>,
      LocalConfig,
    ) build,
  ) {
    return LocalConfigProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<LocalConfig, LocalLibConfig> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(this, pointer);
}

String _$localConfigHash() => r'a7542985371cc8fd8de7008d1a7f7ae65fa07f6e';

abstract class _$LocalConfig extends $Notifier<LocalLibConfig> {
  LocalLibConfig build();
  @$internal
  @override
  LocalLibConfig runBuild() => build();
}

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
