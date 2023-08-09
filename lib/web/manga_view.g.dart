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

typedef _FetchWebMangaInfoRef = AutoDisposeFutureProviderRef<WebManga>;

/// See also [_fetchWebMangaInfo].
@ProviderFor(_fetchWebMangaInfo)
const _fetchWebMangaInfoProvider = _FetchWebMangaInfoFamily();

/// See also [_fetchWebMangaInfo].
class _FetchWebMangaInfoFamily extends Family<AsyncValue<WebManga>> {
  /// See also [_fetchWebMangaInfo].
  const _FetchWebMangaInfoFamily();

  /// See also [_fetchWebMangaInfo].
  _FetchWebMangaInfoProvider call(
    ProxyInfo info,
  ) {
    return _FetchWebMangaInfoProvider(
      info,
    );
  }

  @override
  _FetchWebMangaInfoProvider getProviderOverride(
    covariant _FetchWebMangaInfoProvider provider,
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
  String? get name => r'_fetchWebMangaInfoProvider';
}

/// See also [_fetchWebMangaInfo].
class _FetchWebMangaInfoProvider extends AutoDisposeFutureProvider<WebManga> {
  /// See also [_fetchWebMangaInfo].
  _FetchWebMangaInfoProvider(
    this.info,
  ) : super.internal(
          (ref) => _fetchWebMangaInfo(
            ref,
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
        );

  final ProxyInfo info;

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
