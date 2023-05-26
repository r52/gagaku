// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPagesHash() => r'a5c443e9602ca74411b64cc3647796fef4673aad';

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

typedef _GetPagesRef = AutoDisposeFutureProviderRef<List<ReaderPage>>;

/// See also [_getPages].
@ProviderFor(_getPages)
const _getPagesProvider = _GetPagesFamily();

/// See also [_getPages].
class _GetPagesFamily extends Family<AsyncValue<List<ReaderPage>>> {
  /// See also [_getPages].
  const _GetPagesFamily();

  /// See also [_getPages].
  _GetPagesProvider call(
    String code,
  ) {
    return _GetPagesProvider(
      code,
    );
  }

  @override
  _GetPagesProvider getProviderOverride(
    covariant _GetPagesProvider provider,
  ) {
    return call(
      provider.code,
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
  String? get name => r'_getPagesProvider';
}

/// See also [_getPages].
class _GetPagesProvider extends AutoDisposeFutureProvider<List<ReaderPage>> {
  /// See also [_getPages].
  _GetPagesProvider(
    this.code,
  ) : super.internal(
          (ref) => _getPages(
            ref,
            code,
          ),
          from: _getPagesProvider,
          name: r'_getPagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPagesHash,
          dependencies: _GetPagesFamily._dependencies,
          allTransitiveDependencies: _GetPagesFamily._allTransitiveDependencies,
        );

  final String code;

  @override
  bool operator ==(Object other) {
    return other is _GetPagesProvider && other.code == code;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, code.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
