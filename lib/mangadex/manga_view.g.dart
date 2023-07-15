// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchReadChaptersRedunHash() =>
    r'ee6e26ca0ad2a94741b4f9afe8e5e7ec62fe52ef';

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

typedef _FetchReadChaptersRedunRef = AutoDisposeFutureProviderRef<void>;

/// See also [_fetchReadChaptersRedun].
@ProviderFor(_fetchReadChaptersRedun)
const _fetchReadChaptersRedunProvider = _FetchReadChaptersRedunFamily();

/// See also [_fetchReadChaptersRedun].
class _FetchReadChaptersRedunFamily extends Family<AsyncValue<void>> {
  /// See also [_fetchReadChaptersRedun].
  const _FetchReadChaptersRedunFamily();

  /// See also [_fetchReadChaptersRedun].
  _FetchReadChaptersRedunProvider call(
    Manga manga,
  ) {
    return _FetchReadChaptersRedunProvider(
      manga,
    );
  }

  @override
  _FetchReadChaptersRedunProvider getProviderOverride(
    covariant _FetchReadChaptersRedunProvider provider,
  ) {
    return call(
      provider.manga,
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
  String? get name => r'_fetchReadChaptersRedunProvider';
}

/// See also [_fetchReadChaptersRedun].
class _FetchReadChaptersRedunProvider extends AutoDisposeFutureProvider<void> {
  /// See also [_fetchReadChaptersRedun].
  _FetchReadChaptersRedunProvider(
    this.manga,
  ) : super.internal(
          (ref) => _fetchReadChaptersRedun(
            ref,
            manga,
          ),
          from: _fetchReadChaptersRedunProvider,
          name: r'_fetchReadChaptersRedunProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchReadChaptersRedunHash,
          dependencies: _FetchReadChaptersRedunFamily._dependencies,
          allTransitiveDependencies:
              _FetchReadChaptersRedunFamily._allTransitiveDependencies,
        );

  final Manga manga;

  @override
  bool operator ==(Object other) {
    return other is _FetchReadChaptersRedunProvider && other.manga == manga;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manga.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
