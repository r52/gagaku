// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_SearchHistory)
const _searchHistoryProvider = _SearchHistoryProvider._();

final class _SearchHistoryProvider
    extends $NotifierProvider<_SearchHistory, List<String>> {
  const _SearchHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_searchHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchHistoryHash();

  @$internal
  @override
  _SearchHistory create() => _SearchHistory();

  @$internal
  @override
  $NotifierProviderElement<_SearchHistory, List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<List<String>>(value),
    );
  }
}

String _$searchHistoryHash() => r'03b2bdeb09ccc897e60e3e498de7f80aa8df9377';

abstract class _$SearchHistory extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
