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

/// See also [_fetchGroupData].
@ProviderFor(_fetchGroupData)
const _fetchGroupDataProvider = _FetchGroupDataFamily();

/// See also [_fetchGroupData].
class _FetchGroupDataFamily extends Family {
  /// See also [_fetchGroupData].
  const _FetchGroupDataFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchGroupDataProvider';

  /// See also [_fetchGroupData].
  _FetchGroupDataProvider call(
    Iterable<String> uuids,
  ) {
    return _FetchGroupDataProvider(
      uuids,
    );
  }

  @visibleForOverriding
  @override
  _FetchGroupDataProvider getProviderOverride(
    covariant _FetchGroupDataProvider provider,
  ) {
    return call(
      provider.uuids,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<Set<Group>> Function(_FetchGroupDataRef ref) create) {
    return _$FetchGroupDataFamilyOverride(this, create);
  }
}

class _$FetchGroupDataFamilyOverride implements FamilyOverride {
  _$FetchGroupDataFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Set<Group>> Function(_FetchGroupDataRef ref) create;

  @override
  final _FetchGroupDataFamily overriddenFamily;

  @override
  _FetchGroupDataProvider getProviderOverride(
    covariant _FetchGroupDataProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchGroupData].
class _FetchGroupDataProvider extends AutoDisposeFutureProvider<Set<Group>> {
  /// See also [_fetchGroupData].
  _FetchGroupDataProvider(
    Iterable<String> uuids,
  ) : this._internal(
          (ref) => _fetchGroupData(
            ref as _FetchGroupDataRef,
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
          uuids: uuids,
        );

  _FetchGroupDataProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uuids,
  }) : super.internal();

  final Iterable<String> uuids;

  @override
  Override overrideWith(
    FutureOr<Set<Group>> Function(_FetchGroupDataRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchGroupDataProvider._internal(
        (ref) => create(ref as _FetchGroupDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uuids: uuids,
      ),
    );
  }

  @override
  (Iterable<String>,) get argument {
    return (uuids,);
  }

  @override
  AutoDisposeFutureProviderElement<Set<Group>> createElement() {
    return _FetchGroupDataProviderElement(this);
  }

  _FetchGroupDataProvider _copyWith(
    FutureOr<Set<Group>> Function(_FetchGroupDataRef ref) create,
  ) {
    return _FetchGroupDataProvider._internal(
      (ref) => create(ref as _FetchGroupDataRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      uuids: uuids,
    );
  }

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

mixin _FetchGroupDataRef on AutoDisposeFutureProviderRef<Set<Group>> {
  /// The parameter `uuids` of this provider.
  Iterable<String> get uuids;
}

class _FetchGroupDataProviderElement
    extends AutoDisposeFutureProviderElement<Set<Group>>
    with _FetchGroupDataRef {
  _FetchGroupDataProviderElement(super.provider);

  @override
  Iterable<String> get uuids => (origin as _FetchGroupDataProvider).uuids;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
