// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchGroupDataHash() => r'c9009d905ce312badc17d76d527a3c084ce2dee4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef _FetchGroupDataRef = AutoDisposeFutureProviderRef<Set<Group>>;

/// See also [_fetchGroupData].
@ProviderFor(_fetchGroupData)
const _fetchGroupDataProvider = _FetchGroupDataFamily();

/// See also [_fetchGroupData].
class _FetchGroupDataFamily extends Family<AsyncValue<Set<Group>>> {
  /// See also [_fetchGroupData].
  const _FetchGroupDataFamily();

  /// See also [_fetchGroupData].
  _FetchGroupDataProvider call(
    Iterable<String> uuids,
  ) {
    return _FetchGroupDataProvider(
      uuids,
    );
  }

  @override
  _FetchGroupDataProvider getProviderOverride(
    covariant _FetchGroupDataProvider provider,
  ) {
    return call(
      provider.uuids,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchGroupDataProvider';
}

/// See also [_fetchGroupData].
class _FetchGroupDataProvider extends AutoDisposeFutureProvider<Set<Group>> {
  /// See also [_fetchGroupData].
  _FetchGroupDataProvider(
    this.uuids,
  ) : super.internal(
          (ref) => _fetchGroupData(
            ref,
            uuids,
          ),
          from: _fetchGroupDataProvider,
          name: r'_fetchGroupDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchGroupDataHash,
          dependencies: _FetchGroupDataFamily._dependencies,
          allTransitiveDependencies:
              _FetchGroupDataFamily._allTransitiveDependencies,
        );

  final Iterable<String> uuids;

  @override
  bool operator ==(Object other) {
    return other is _FetchGroupDataProvider && other.uuids == uuids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uuids.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
