// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getArchivePagesHash() => r'90ba0b7cb5c10495145604e5aef6e6bfb34b21db';

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
class _GetArchivePagesFamily extends Family<AsyncValue<List<ReaderPage>>> {
  /// See also [_getArchivePages].
  const _GetArchivePagesFamily();

  /// See also [_getArchivePages].
  _GetArchivePagesProvider call(
    String path,
  ) {
    return _GetArchivePagesProvider(
      path,
    );
  }

  @override
  _GetArchivePagesProvider getProviderOverride(
    covariant _GetArchivePagesProvider provider,
  ) {
    return call(
      provider.path,
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
  String? get name => r'_getArchivePagesProvider';
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
    super._createNotifier, {
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
    FutureOr<List<ReaderPage>> Function(_GetArchivePagesRef provider) create,
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
  AutoDisposeFutureProviderElement<List<ReaderPage>> createElement() {
    return _GetArchivePagesProviderElement(this);
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
