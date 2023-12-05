// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLibraryListByTypeHash() =>
    r'576bfd0924e507660e503b96beb1a2bfc76b8e6f';

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

/// See also [_getLibraryListByType].
@ProviderFor(_getLibraryListByType)
const _getLibraryListByTypeProvider = _GetLibraryListByTypeFamily();

/// See also [_getLibraryListByType].
class _GetLibraryListByTypeFamily extends Family {
  /// See also [_getLibraryListByType].
  const _GetLibraryListByTypeFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_getLibraryListByTypeProvider';

  /// See also [_getLibraryListByType].
  _GetLibraryListByTypeProvider call(
    MangaReadingStatus type,
  ) {
    return _GetLibraryListByTypeProvider(
      type,
    );
  }

  @visibleForOverriding
  @override
  _GetLibraryListByTypeProvider getProviderOverride(
    covariant _GetLibraryListByTypeProvider provider,
  ) {
    return call(
      provider.type,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<String>> Function(_GetLibraryListByTypeRef ref) create) {
    return _$GetLibraryListByTypeFamilyOverride(this, create);
  }
}

class _$GetLibraryListByTypeFamilyOverride implements FamilyOverride {
  _$GetLibraryListByTypeFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<String>> Function(_GetLibraryListByTypeRef ref) create;

  @override
  final _GetLibraryListByTypeFamily overriddenFamily;

  @override
  _GetLibraryListByTypeProvider getProviderOverride(
    covariant _GetLibraryListByTypeProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_getLibraryListByType].
class _GetLibraryListByTypeProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [_getLibraryListByType].
  _GetLibraryListByTypeProvider(
    MangaReadingStatus type,
  ) : this._internal(
          (ref) => _getLibraryListByType(
            ref as _GetLibraryListByTypeRef,
            type,
          ),
          from: _getLibraryListByTypeProvider,
          name: r'_getLibraryListByTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getLibraryListByTypeHash,
          dependencies: _GetLibraryListByTypeFamily._dependencies,
          allTransitiveDependencies:
              _GetLibraryListByTypeFamily._allTransitiveDependencies,
          type: type,
        );

  _GetLibraryListByTypeProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final MangaReadingStatus type;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(_GetLibraryListByTypeRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetLibraryListByTypeProvider._internal(
        (ref) => create(ref as _GetLibraryListByTypeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  (MangaReadingStatus,) get argument {
    return (type,);
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _GetLibraryListByTypeProviderElement(this);
  }

  _GetLibraryListByTypeProvider _copyWith(
    FutureOr<List<String>> Function(_GetLibraryListByTypeRef ref) create,
  ) {
    return _GetLibraryListByTypeProvider._internal(
      (ref) => create(ref as _GetLibraryListByTypeRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      type: type,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _GetLibraryListByTypeProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetLibraryListByTypeRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `type` of this provider.
  MangaReadingStatus get type;
}

class _GetLibraryListByTypeProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with _GetLibraryListByTypeRef {
  _GetLibraryListByTypeProviderElement(super.provider);

  @override
  MangaReadingStatus get type => (origin as _GetLibraryListByTypeProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
