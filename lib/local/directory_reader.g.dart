// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getDirectoryPagesHash() => r'b0d54343c0f0f752fbf7c378626d8054632121c1';

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

/// See also [_getDirectoryPages].
@ProviderFor(_getDirectoryPages)
const _getDirectoryPagesProvider = _GetDirectoryPagesFamily();

/// See also [_getDirectoryPages].
class _GetDirectoryPagesFamily extends Family<AsyncValue<List<ReaderPage>>> {
  /// See also [_getDirectoryPages].
  const _GetDirectoryPagesFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_getDirectoryPagesProvider';

  /// See also [_getDirectoryPages].
  _GetDirectoryPagesProvider call(
    String path,
  ) {
    return _GetDirectoryPagesProvider(
      path,
    );
  }

  @visibleForOverriding
  @override
  _GetDirectoryPagesProvider getProviderOverride(
    covariant _GetDirectoryPagesProvider provider,
  ) {
    return call(
      provider.path,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<ReaderPage>> Function(_GetDirectoryPagesRef ref) create) {
    return _$GetDirectoryPagesFamilyOverride(this, create);
  }
}

class _$GetDirectoryPagesFamilyOverride
    implements FamilyOverride<AsyncValue<List<ReaderPage>>> {
  _$GetDirectoryPagesFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<ReaderPage>> Function(_GetDirectoryPagesRef ref) create;

  @override
  final _GetDirectoryPagesFamily overriddenFamily;

  @override
  _GetDirectoryPagesProvider getProviderOverride(
    covariant _GetDirectoryPagesProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_getDirectoryPages].
class _GetDirectoryPagesProvider
    extends AutoDisposeFutureProvider<List<ReaderPage>> {
  /// See also [_getDirectoryPages].
  _GetDirectoryPagesProvider(
    String path,
  ) : this._internal(
          (ref) => _getDirectoryPages(
            ref as _GetDirectoryPagesRef,
            path,
          ),
          from: _getDirectoryPagesProvider,
          name: r'_getDirectoryPagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDirectoryPagesHash,
          dependencies: _GetDirectoryPagesFamily._dependencies,
          allTransitiveDependencies:
              _GetDirectoryPagesFamily._allTransitiveDependencies,
          path: path,
        );

  _GetDirectoryPagesProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final String path;

  @override
  Override overrideWith(
    FutureOr<List<ReaderPage>> Function(_GetDirectoryPagesRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetDirectoryPagesProvider._internal(
        (ref) => create(ref as _GetDirectoryPagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
      ),
    );
  }

  @override
  (String,) get argument {
    return (path,);
  }

  @override
  AutoDisposeFutureProviderElement<List<ReaderPage>> createElement() {
    return _GetDirectoryPagesProviderElement(this);
  }

  _GetDirectoryPagesProvider _copyWith(
    FutureOr<List<ReaderPage>> Function(_GetDirectoryPagesRef ref) create,
  ) {
    return _GetDirectoryPagesProvider._internal(
      (ref) => create(ref as _GetDirectoryPagesRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      path: path,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _GetDirectoryPagesProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetDirectoryPagesRef on AutoDisposeFutureProviderRef<List<ReaderPage>> {
  /// The parameter `path` of this provider.
  String get path;
}

class _GetDirectoryPagesProviderElement
    extends AutoDisposeFutureProviderElement<List<ReaderPage>>
    with _GetDirectoryPagesRef {
  _GetDirectoryPagesProviderElement(super.provider);

  @override
  String get path => (origin as _GetDirectoryPagesProvider).path;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
