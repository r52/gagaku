// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocalLibConfig _$LocalLibConfigFromJson(Map<String, dynamic> json) =>
    _LocalLibConfig(
      libraryDirectory: json['libraryDirectory'] as String? ?? '',
      epubFontSize: (json['epubFontSize'] as num?)?.toDouble() ?? 1.0,
      epubScroll: json['epubScroll'] as bool? ?? false,
      pdfScroll: json['pdfScroll'] as bool? ?? false,
    );

Map<String, dynamic> _$LocalLibConfigToJson(_LocalLibConfig instance) =>
    <String, dynamic>{
      'libraryDirectory': instance.libraryDirectory,
      'epubFontSize': instance.epubFontSize,
      'epubScroll': instance.epubScroll,
      'pdfScroll': instance.pdfScroll,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocalConfig)
final localConfigProvider = LocalConfigProvider._();

final class LocalConfigProvider
    extends $NotifierProvider<LocalConfig, LocalLibConfig> {
  LocalConfigProvider._()
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

String _$localConfigHash() => r'd985ae7c7be09ef72b1ef4f482bf9214e99047d2';

abstract class _$LocalConfig extends $Notifier<LocalLibConfig> {
  LocalLibConfig build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<LocalLibConfig, LocalLibConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LocalLibConfig, LocalLibConfig>,
              LocalLibConfig,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
