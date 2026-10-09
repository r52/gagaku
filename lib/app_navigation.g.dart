// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_navigation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Inline rail expansion on wide layouts, shared by all app contexts.

@ProviderFor(NavigationRailExpanded)
final navigationRailExpandedProvider = NavigationRailExpandedProvider._();

/// Inline rail expansion on wide layouts, shared by all app contexts.
final class NavigationRailExpandedProvider
    extends $NotifierProvider<NavigationRailExpanded, bool> {
  /// Inline rail expansion on wide layouts, shared by all app contexts.
  NavigationRailExpandedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationRailExpandedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationRailExpandedHash();

  @$internal
  @override
  NavigationRailExpanded create() => NavigationRailExpanded();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$navigationRailExpandedHash() =>
    r'cad1eaf95282430f299e06b6cc3462a5a5e9123e';

/// Inline rail expansion on wide layouts, shared by all app contexts.

abstract class _$NavigationRailExpanded extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
