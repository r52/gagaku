// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_SearchHistory)
const _searchHistoryProvider = _SearchHistoryProvider._();

final class _SearchHistoryProvider
    extends $NotifierProvider<_SearchHistory, List<String>> {
  const _SearchHistoryProvider._(
      {super.runNotifierBuildOverride, _SearchHistory Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'_searchHistoryProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final _SearchHistory Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$searchHistoryHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<List<String>>(value),
    );
  }

  @$internal
  @override
  _SearchHistory create() => _createCb?.call() ?? _SearchHistory();

  @$internal
  @override
  _SearchHistoryProvider $copyWithCreate(
    _SearchHistory Function() create,
  ) {
    return _SearchHistoryProvider._(create: create);
  }

  @$internal
  @override
  _SearchHistoryProvider $copyWithBuild(
    List<String> Function(
      Ref<List<String>>,
      _SearchHistory,
    ) build,
  ) {
    return _SearchHistoryProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<_SearchHistory, List<String>> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(this, pointer);
}

String _$searchHistoryHash() => r'03b2bdeb09ccc897e60e3e498de7f80aa8df9377';

abstract class _$SearchHistory extends $Notifier<List<String>> {
  List<String> build();
  @$internal
  @override
  List<String> runBuild() => build();
}

// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
