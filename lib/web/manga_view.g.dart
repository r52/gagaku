// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchWebMangaInfoHash() => r'b46d2f19b9ddef34e34e104b971c7a92cf0bcd6c';

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

/// See also [_fetchWebMangaInfo].
@ProviderFor(_fetchWebMangaInfo)
const _fetchWebMangaInfoProvider = _FetchWebMangaInfoFamily();

/// See also [_fetchWebMangaInfo].
class _FetchWebMangaInfoFamily extends Family<AsyncValue<WebManga>> {
  /// See also [_fetchWebMangaInfo].
  const _FetchWebMangaInfoFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchWebMangaInfoProvider';

  /// See also [_fetchWebMangaInfo].
  _FetchWebMangaInfoProvider call(
    ProxyInfo info,
  ) {
    return _FetchWebMangaInfoProvider(
      info,
    );
  }

  @visibleForOverriding
  @override
  _FetchWebMangaInfoProvider getProviderOverride(
    covariant _FetchWebMangaInfoProvider provider,
  ) {
    return call(
      provider.info,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<WebManga> Function(_FetchWebMangaInfoRef ref) create) {
    return _$FetchWebMangaInfoFamilyOverride(this, create);
  }
}

class _$FetchWebMangaInfoFamilyOverride
    implements FamilyOverride<AsyncValue<WebManga>> {
  _$FetchWebMangaInfoFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<WebManga> Function(_FetchWebMangaInfoRef ref) create;

  @override
  final _FetchWebMangaInfoFamily overriddenFamily;

  @override
  _FetchWebMangaInfoProvider getProviderOverride(
    covariant _FetchWebMangaInfoProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchWebMangaInfo].
class _FetchWebMangaInfoProvider extends AutoDisposeFutureProvider<WebManga> {
  /// See also [_fetchWebMangaInfo].
  _FetchWebMangaInfoProvider(
    ProxyInfo info,
  ) : this._internal(
          (ref) => _fetchWebMangaInfo(
            ref as _FetchWebMangaInfoRef,
            info,
          ),
          from: _fetchWebMangaInfoProvider,
          name: r'_fetchWebMangaInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchWebMangaInfoHash,
          dependencies: _FetchWebMangaInfoFamily._dependencies,
          allTransitiveDependencies:
              _FetchWebMangaInfoFamily._allTransitiveDependencies,
          info: info,
        );

  _FetchWebMangaInfoProvider._internal(
    super.create, {
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
    FutureOr<WebManga> Function(_FetchWebMangaInfoRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchWebMangaInfoProvider._internal(
        (ref) => create(ref as _FetchWebMangaInfoRef),
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
  AutoDisposeFutureProviderElement<WebManga> createElement() {
    return _FetchWebMangaInfoProviderElement(this);
  }

  _FetchWebMangaInfoProvider _copyWith(
    FutureOr<WebManga> Function(_FetchWebMangaInfoRef ref) create,
  ) {
    return _FetchWebMangaInfoProvider._internal(
      (ref) => create(ref as _FetchWebMangaInfoRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      info: info,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchWebMangaInfoProvider && other.info == info;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, info.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchWebMangaInfoRef on AutoDisposeFutureProviderRef<WebManga> {
  /// The parameter `info` of this provider.
  ProxyInfo get info;
}

class _FetchWebMangaInfoProviderElement
    extends AutoDisposeFutureProviderElement<WebManga>
    with _FetchWebMangaInfoRef {
  _FetchWebMangaInfoProviderElement(super.provider);

  @override
  ProxyInfo get info => (origin as _FetchWebMangaInfoProvider).info;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
