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

typedef _GetDirectoryPagesRef = AutoDisposeFutureProviderRef<List<ReaderPage>>;

/// See also [_getDirectoryPages].
@ProviderFor(_getDirectoryPages)
const _getDirectoryPagesProvider = _GetDirectoryPagesFamily();

/// See also [_getDirectoryPages].
class _GetDirectoryPagesFamily extends Family<AsyncValue<List<ReaderPage>>> {
  /// See also [_getDirectoryPages].
  const _GetDirectoryPagesFamily();

  /// See also [_getDirectoryPages].
  _GetDirectoryPagesProvider call(
    String path,
  ) {
    return _GetDirectoryPagesProvider(
      path,
    );
  }

  @override
  _GetDirectoryPagesProvider getProviderOverride(
    covariant _GetDirectoryPagesProvider provider,
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
  String? get name => r'_getDirectoryPagesProvider';
}

/// See also [_getDirectoryPages].
class _GetDirectoryPagesProvider
    extends AutoDisposeFutureProvider<List<ReaderPage>> {
  /// See also [_getDirectoryPages].
  _GetDirectoryPagesProvider(
    this.path,
  ) : super.internal(
          (ref) => _getDirectoryPages(
            ref,
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
        );

  final String path;

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
