// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloudflare.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CloudflareBrowserStates)
final cloudflareBrowserStatesProvider = CloudflareBrowserStatesProvider._();

final class CloudflareBrowserStatesProvider
    extends
        $NotifierProvider<
          CloudflareBrowserStates,
          Map<String, CloudflareBrowserState>
        > {
  CloudflareBrowserStatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cloudflareBrowserStatesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cloudflareBrowserStatesHash();

  @$internal
  @override
  CloudflareBrowserStates create() => CloudflareBrowserStates();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, CloudflareBrowserState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, CloudflareBrowserState>>(
        value,
      ),
    );
  }
}

String _$cloudflareBrowserStatesHash() =>
    r'684ae8e8828c5ab88d3c1273ce9129fe7a770984';

abstract class _$CloudflareBrowserStates
    extends $Notifier<Map<String, CloudflareBrowserState>> {
  Map<String, CloudflareBrowserState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              Map<String, CloudflareBrowserState>,
              Map<String, CloudflareBrowserState>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, CloudflareBrowserState>,
                Map<String, CloudflareBrowserState>
              >,
              Map<String, CloudflareBrowserState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
