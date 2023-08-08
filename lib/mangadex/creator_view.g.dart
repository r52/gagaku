// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchCreatorFromIdHash() =>
    r'de996798e5488880f40df3da59b157931b1d0e6d';

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

typedef _FetchCreatorFromIdRef = AutoDisposeFutureProviderRef<CreatorType>;

/// See also [_fetchCreatorFromId].
@ProviderFor(_fetchCreatorFromId)
const _fetchCreatorFromIdProvider = _FetchCreatorFromIdFamily();

/// See also [_fetchCreatorFromId].
class _FetchCreatorFromIdFamily extends Family<AsyncValue<CreatorType>> {
  /// See also [_fetchCreatorFromId].
  const _FetchCreatorFromIdFamily();

  /// See also [_fetchCreatorFromId].
  _FetchCreatorFromIdProvider call(
    String creatorId,
  ) {
    return _FetchCreatorFromIdProvider(
      creatorId,
    );
  }

  @override
  _FetchCreatorFromIdProvider getProviderOverride(
    covariant _FetchCreatorFromIdProvider provider,
  ) {
    return call(
      provider.creatorId,
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
  String? get name => r'_fetchCreatorFromIdProvider';
}

/// See also [_fetchCreatorFromId].
class _FetchCreatorFromIdProvider
    extends AutoDisposeFutureProvider<CreatorType> {
  /// See also [_fetchCreatorFromId].
  _FetchCreatorFromIdProvider(
    this.creatorId,
  ) : super.internal(
          (ref) => _fetchCreatorFromId(
            ref,
            creatorId,
          ),
          from: _fetchCreatorFromIdProvider,
          name: r'_fetchCreatorFromIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchCreatorFromIdHash,
          dependencies: _FetchCreatorFromIdFamily._dependencies,
          allTransitiveDependencies:
              _FetchCreatorFromIdFamily._allTransitiveDependencies,
        );

  final String creatorId;

  @override
  bool operator ==(Object other) {
    return other is _FetchCreatorFromIdProvider && other.creatorId == creatorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, creatorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$fetchCreatorTitlesHash() =>
    r'efd02209a7239c89af2fdf44b2e5db30b1626f4f';
typedef _FetchCreatorTitlesRef = AutoDisposeFutureProviderRef<Iterable<Manga>>;

/// See also [_fetchCreatorTitles].
@ProviderFor(_fetchCreatorTitles)
const _fetchCreatorTitlesProvider = _FetchCreatorTitlesFamily();

/// See also [_fetchCreatorTitles].
class _FetchCreatorTitlesFamily extends Family<AsyncValue<Iterable<Manga>>> {
  /// See also [_fetchCreatorTitles].
  const _FetchCreatorTitlesFamily();

  /// See also [_fetchCreatorTitles].
  _FetchCreatorTitlesProvider call(
    CreatorType creator,
  ) {
    return _FetchCreatorTitlesProvider(
      creator,
    );
  }

  @override
  _FetchCreatorTitlesProvider getProviderOverride(
    covariant _FetchCreatorTitlesProvider provider,
  ) {
    return call(
      provider.creator,
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
  String? get name => r'_fetchCreatorTitlesProvider';
}

/// See also [_fetchCreatorTitles].
class _FetchCreatorTitlesProvider
    extends AutoDisposeFutureProvider<Iterable<Manga>> {
  /// See also [_fetchCreatorTitles].
  _FetchCreatorTitlesProvider(
    this.creator,
  ) : super.internal(
          (ref) => _fetchCreatorTitles(
            ref,
            creator,
          ),
          from: _fetchCreatorTitlesProvider,
          name: r'_fetchCreatorTitlesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchCreatorTitlesHash,
          dependencies: _FetchCreatorTitlesFamily._dependencies,
          allTransitiveDependencies:
              _FetchCreatorTitlesFamily._allTransitiveDependencies,
        );

  final CreatorType creator;

  @override
  bool operator ==(Object other) {
    return other is _FetchCreatorTitlesProvider && other.creator == creator;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, creator.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
