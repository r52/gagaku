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

  @visibleForOverriding
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
    ProxyInfo info,
  ) : this._internal(
          (ref) => _fetchWebChapterInfo(
            ref as _FetchWebChapterInfoRef,
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
          info: info,
        );

  _FetchWebChapterInfoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.info,
  }) : super.internal();

  final ProxyInfo info;

  @override
  Override overrideWith(
    FutureOr<WebReaderData> Function(_FetchWebChapterInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchWebChapterInfoProvider._internal(
        (ref) => create(ref as _FetchWebChapterInfoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        info: info,
      ),
    );
  }

  @override
  (ProxyInfo,) get argument {
    return (info,);
  }

  @override
  AutoDisposeFutureProviderElement<WebReaderData> createElement() {
    return _FetchWebChapterInfoProviderElement(this);
  }

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

mixin _FetchWebChapterInfoRef on AutoDisposeFutureProviderRef<WebReaderData> {
  /// The parameter `info` of this provider.
  ProxyInfo get info;
}

class _FetchWebChapterInfoProviderElement
    extends AutoDisposeFutureProviderElement<WebReaderData>
    with _FetchWebChapterInfoRef {
  _FetchWebChapterInfoProviderElement(super.provider);

  @override
  ProxyInfo get info => (origin as _FetchWebChapterInfoProvider).info;
}

String _$getPagesHash() => r'2f561a3d26939d96cfbadbfa68d5ce72f08e92f4';

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

  @visibleForOverriding
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
    dynamic source,
  ) : this._internal(
          (ref) => _getPages(
            ref as _GetPagesRef,
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
          source: source,
        );

  _GetPagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.source,
  }) : super.internal();

  final dynamic source;

  @override
  Override overrideWith(
    FutureOr<List<ReaderPage>> Function(_GetPagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetPagesProvider._internal(
        (ref) => create(ref as _GetPagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        source: source,
      ),
    );
  }

  @override
  (dynamic,) get argument {
    return (source,);
  }

  @override
  AutoDisposeFutureProviderElement<List<ReaderPage>> createElement() {
    return _GetPagesProviderElement(this);
  }

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

mixin _GetPagesRef on AutoDisposeFutureProviderRef<List<ReaderPage>> {
  /// The parameter `source` of this provider.
  dynamic get source;
}

class _GetPagesProviderElement
    extends AutoDisposeFutureProviderElement<List<ReaderPage>>
    with _GetPagesRef {
  _GetPagesProviderElement(super.provider);

  @override
  dynamic get source => (origin as _GetPagesProvider).source;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
