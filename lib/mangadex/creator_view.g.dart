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

/// See also [_fetchCreatorFromId].
@ProviderFor(_fetchCreatorFromId)
const _fetchCreatorFromIdProvider = _FetchCreatorFromIdFamily();

/// See also [_fetchCreatorFromId].
class _FetchCreatorFromIdFamily extends Family<AsyncValue<CreatorType>> {
  /// See also [_fetchCreatorFromId].
  const _FetchCreatorFromIdFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchCreatorFromIdProvider';

  /// See also [_fetchCreatorFromId].
  _FetchCreatorFromIdProvider call(
    String creatorId,
  ) {
    return _FetchCreatorFromIdProvider(
      creatorId,
    );
  }

  @visibleForOverriding
  @override
  _FetchCreatorFromIdProvider getProviderOverride(
    covariant _FetchCreatorFromIdProvider provider,
  ) {
    return call(
      provider.creatorId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<CreatorType> Function(_FetchCreatorFromIdRef ref) create) {
    return _$FetchCreatorFromIdFamilyOverride(this, create);
  }
}

class _$FetchCreatorFromIdFamilyOverride
    implements FamilyOverride<AsyncValue<CreatorType>> {
  _$FetchCreatorFromIdFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<CreatorType> Function(_FetchCreatorFromIdRef ref) create;

  @override
  final _FetchCreatorFromIdFamily overriddenFamily;

  @override
  _FetchCreatorFromIdProvider getProviderOverride(
    covariant _FetchCreatorFromIdProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchCreatorFromId].
class _FetchCreatorFromIdProvider
    extends AutoDisposeFutureProvider<CreatorType> {
  /// See also [_fetchCreatorFromId].
  _FetchCreatorFromIdProvider(
    String creatorId,
  ) : this._internal(
          (ref) => _fetchCreatorFromId(
            ref as _FetchCreatorFromIdRef,
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
          creatorId: creatorId,
        );

  _FetchCreatorFromIdProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.creatorId,
  }) : super.internal();

  final String creatorId;

  @override
  Override overrideWith(
    FutureOr<CreatorType> Function(_FetchCreatorFromIdRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchCreatorFromIdProvider._internal(
        (ref) => create(ref as _FetchCreatorFromIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        creatorId: creatorId,
      ),
    );
  }

  @override
  (String,) get argument {
    return (creatorId,);
  }

  @override
  AutoDisposeFutureProviderElement<CreatorType> createElement() {
    return _FetchCreatorFromIdProviderElement(this);
  }

  _FetchCreatorFromIdProvider _copyWith(
    FutureOr<CreatorType> Function(_FetchCreatorFromIdRef ref) create,
  ) {
    return _FetchCreatorFromIdProvider._internal(
      (ref) => create(ref as _FetchCreatorFromIdRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      creatorId: creatorId,
    );
  }

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

mixin _FetchCreatorFromIdRef on AutoDisposeFutureProviderRef<CreatorType> {
  /// The parameter `creatorId` of this provider.
  String get creatorId;
}

class _FetchCreatorFromIdProviderElement
    extends AutoDisposeFutureProviderElement<CreatorType>
    with _FetchCreatorFromIdRef {
  _FetchCreatorFromIdProviderElement(super.provider);

  @override
  String get creatorId => (origin as _FetchCreatorFromIdProvider).creatorId;
}

String _$fetchCreatorTitlesHash() =>
    r'efd02209a7239c89af2fdf44b2e5db30b1626f4f';

/// See also [_fetchCreatorTitles].
@ProviderFor(_fetchCreatorTitles)
const _fetchCreatorTitlesProvider = _FetchCreatorTitlesFamily();

/// See also [_fetchCreatorTitles].
class _FetchCreatorTitlesFamily extends Family<AsyncValue<Iterable<Manga>>> {
  /// See also [_fetchCreatorTitles].
  const _FetchCreatorTitlesFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchCreatorTitlesProvider';

  /// See also [_fetchCreatorTitles].
  _FetchCreatorTitlesProvider call(
    CreatorType creator,
  ) {
    return _FetchCreatorTitlesProvider(
      creator,
    );
  }

  @visibleForOverriding
  @override
  _FetchCreatorTitlesProvider getProviderOverride(
    covariant _FetchCreatorTitlesProvider provider,
  ) {
    return call(
      provider.creator,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<Iterable<Manga>> Function(_FetchCreatorTitlesRef ref) create) {
    return _$FetchCreatorTitlesFamilyOverride(this, create);
  }
}

class _$FetchCreatorTitlesFamilyOverride
    implements FamilyOverride<AsyncValue<Iterable<Manga>>> {
  _$FetchCreatorTitlesFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Iterable<Manga>> Function(_FetchCreatorTitlesRef ref) create;

  @override
  final _FetchCreatorTitlesFamily overriddenFamily;

  @override
  _FetchCreatorTitlesProvider getProviderOverride(
    covariant _FetchCreatorTitlesProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchCreatorTitles].
class _FetchCreatorTitlesProvider
    extends AutoDisposeFutureProvider<Iterable<Manga>> {
  /// See also [_fetchCreatorTitles].
  _FetchCreatorTitlesProvider(
    CreatorType creator,
  ) : this._internal(
          (ref) => _fetchCreatorTitles(
            ref as _FetchCreatorTitlesRef,
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
          creator: creator,
        );

  _FetchCreatorTitlesProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.creator,
  }) : super.internal();

  final CreatorType creator;

  @override
  Override overrideWith(
    FutureOr<Iterable<Manga>> Function(_FetchCreatorTitlesRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchCreatorTitlesProvider._internal(
        (ref) => create(ref as _FetchCreatorTitlesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        creator: creator,
      ),
    );
  }

  @override
  (CreatorType,) get argument {
    return (creator,);
  }

  @override
  AutoDisposeFutureProviderElement<Iterable<Manga>> createElement() {
    return _FetchCreatorTitlesProviderElement(this);
  }

  _FetchCreatorTitlesProvider _copyWith(
    FutureOr<Iterable<Manga>> Function(_FetchCreatorTitlesRef ref) create,
  ) {
    return _FetchCreatorTitlesProvider._internal(
      (ref) => create(ref as _FetchCreatorTitlesRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      creator: creator,
    );
  }

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

mixin _FetchCreatorTitlesRef on AutoDisposeFutureProviderRef<Iterable<Manga>> {
  /// The parameter `creator` of this provider.
  CreatorType get creator;
}

class _FetchCreatorTitlesProviderElement
    extends AutoDisposeFutureProviderElement<Iterable<Manga>>
    with _FetchCreatorTitlesRef {
  _FetchCreatorTitlesProviderElement(super.provider);

  @override
  CreatorType get creator => (origin as _FetchCreatorTitlesProvider).creator;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
