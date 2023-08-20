// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchWebChapterInfoHash() =>
    r'19a39d1b745fd329d6845bb254994d8a68983cbe';

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

typedef _FetchWebChapterInfoRef = AutoDisposeFutureProviderRef<WebReaderData>;

/// See also [_fetchWebChapterInfo].
@ProviderFor(_fetchWebChapterInfo)
const _fetchWebChapterInfoProvider = _FetchWebChapterInfoFamily();

/// See also [_fetchWebChapterInfo].
class _FetchWebChapterInfoFamily extends Family<AsyncValue<WebReaderData>> {
  /// See also [_fetchWebChapterInfo].
  const _FetchWebChapterInfoFamily();

  /// See also [_fetchWebChapterInfo].
  _FetchWebChapterInfoProvider call(
    ProxyInfo info,
  ) {
    return _FetchWebChapterInfoProvider(
      info,
    );
  }

  @override
  _FetchWebChapterInfoProvider getProviderOverride(
    covariant _FetchWebChapterInfoProvider provider,
  ) {
    return call(
      provider.info,
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
  String? get name => r'_fetchWebChapterInfoProvider';
}

/// See also [_fetchWebChapterInfo].
class _FetchWebChapterInfoProvider
    extends AutoDisposeFutureProvider<WebReaderData> {
  /// See also [_fetchWebChapterInfo].
  _FetchWebChapterInfoProvider(
    this.info,
  ) : super.internal(
          (ref) => _fetchWebChapterInfo(
            ref,
            info,
          ),
          from: _fetchWebChapterInfoProvider,
          name: r'_fetchWebChapterInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchWebChapterInfoHash,
          dependencies: _FetchWebChapterInfoFamily._dependencies,
          allTransitiveDependencies:
              _FetchWebChapterInfoFamily._allTransitiveDependencies,
        );

  final ProxyInfo info;

  @override
  bool operator ==(Object other) {
    return other is _FetchWebChapterInfoProvider && other.info == info;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, info.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getPagesHash() => r'2f561a3d26939d96cfbadbfa68d5ce72f08e92f4';
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
    dynamic source,
  ) {
    return _GetPagesProvider(
      source,
    );
  }

  @override
  _GetPagesProvider getProviderOverride(
    covariant _GetPagesProvider provider,
  ) {
    return call(
      provider.source,
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
    this.source,
  ) : super.internal(
          (ref) => _getPages(
            ref,
            source,
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

  final dynamic source;

  @override
  bool operator ==(Object other) {
    return other is _GetPagesProvider && other.source == source;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, source.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
