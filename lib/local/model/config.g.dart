// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocalLibConfig _$LocalLibConfigFromJson(Map<String, dynamic> json) =>
    _LocalLibConfig(
      libraryDirectory: json['libraryDirectory'] as String? ?? '',
    );

Map<String, dynamic> _$LocalLibConfigToJson(_LocalLibConfig instance) =>
    <String, dynamic>{'libraryDirectory': instance.libraryDirectory};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(LocalConfig)
const localConfigProvider = LocalConfigProvider._();

final class LocalConfigProvider
    extends $NotifierProvider<LocalConfig, LocalLibConfig> {
  const LocalConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localConfigHash();

  @$internal
  @override
  LocalConfig create() => LocalConfig();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalLibConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalLibConfig>(value),
    );
  }
}

String _$localConfigHash() => r'7bbb8904996f16d0e588e2293eb4563822c78a7a';

abstract class _$LocalConfig extends $Notifier<LocalLibConfig> {
  LocalLibConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LocalLibConfig, LocalLibConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LocalLibConfig, LocalLibConfig>,
              LocalLibConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
