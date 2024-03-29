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

typedef _GetArchivePagesRef = AutoDisposeFutureProviderRef<List<ReaderPage>>;

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
    this.path,
  ) : super.internal(
          (ref) => _getArchivePages(
            ref,
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
        );

  final String path;

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
