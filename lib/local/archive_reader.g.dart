// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getArchivePagesHash() => r'8e067b0ef41b21e8601fde9ff2db2cb087b32036';

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

/// See also [_getArchivePages].
@ProviderFor(_getArchivePages)
const _getArchivePagesProvider = _GetArchivePagesFamily();

/// See also [_getArchivePages].
class _GetArchivePagesFamily extends Family {
  /// See also [_getArchivePages].
  const _GetArchivePagesFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_getArchivePagesProvider';

  /// See also [_getArchivePages].
  _GetArchivePagesProvider call(
    String path,
  ) {
    return _GetArchivePagesProvider(
      path,
    );
  }

  @visibleForOverriding
  @override
  _GetArchivePagesProvider getProviderOverride(
    covariant _GetArchivePagesProvider provider,
  ) {
    return call(
      provider.path,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<ReaderPage>> Function(_GetArchivePagesRef ref) create) {
    return _$GetArchivePagesFamilyOverride(this, create);
  }
}

class _$GetArchivePagesFamilyOverride implements FamilyOverride {
  _$GetArchivePagesFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<ReaderPage>> Function(_GetArchivePagesRef ref) create;

  @override
  final _GetArchivePagesFamily overriddenFamily;

  @override
  _GetArchivePagesProvider getProviderOverride(
    covariant _GetArchivePagesProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_getArchivePages].
class _GetArchivePagesProvider
    extends AutoDisposeFutureProvider<List<ReaderPage>> {
  /// See also [_getArchivePages].
  _GetArchivePagesProvider(
    String path,
  ) : this._internal(
          (ref) => _getArchivePages(
            ref as _GetArchivePagesRef,
            path,
          ),
          from: _getArchivePagesProvider,
          name: r'_getArchivePagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getArchivePagesHash,
          dependencies: _GetArchivePagesFamily._dependencies,
          allTransitiveDependencies:
              _GetArchivePagesFamily._allTransitiveDependencies,
          path: path,
        );

  _GetArchivePagesProvider._internal(
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
    FutureOr<List<ReaderPage>> Function(_GetArchivePagesRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetArchivePagesProvider._internal(
        (ref) => create(ref as _GetArchivePagesRef),
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
    return _GetArchivePagesProviderElement(this);
  }

  _GetArchivePagesProvider _copyWith(
    FutureOr<List<ReaderPage>> Function(_GetArchivePagesRef ref) create,
  ) {
    return _GetArchivePagesProvider._internal(
      (ref) => create(ref as _GetArchivePagesRef),
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
    return other is _GetArchivePagesProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetArchivePagesRef on AutoDisposeFutureProviderRef<List<ReaderPage>> {
  /// The parameter `path` of this provider.
  String get path;
}

class _GetArchivePagesProviderElement
    extends AutoDisposeFutureProviderElement<List<ReaderPage>>
    with _GetArchivePagesRef {
  _GetArchivePagesProviderElement(super.provider);

  @override
  String get path => (origin as _GetArchivePagesProvider).path;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
