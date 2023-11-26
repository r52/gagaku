// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchListFromIdHash() => r'aa4480431cd83acf5336d0c3d0cdadd9562fcc73';

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

/// See also [_fetchListFromId].
@ProviderFor(_fetchListFromId)
const _fetchListFromIdProvider = _FetchListFromIdFamily();

/// See also [_fetchListFromId].
class _FetchListFromIdFamily extends Family {
  /// See also [_fetchListFromId].
  const _FetchListFromIdFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchListFromIdProvider';

  /// See also [_fetchListFromId].
  _FetchListFromIdProvider call(
    String listId,
  ) {
    return _FetchListFromIdProvider(
      listId,
    );
  }

  @visibleForOverriding
  @override
  _FetchListFromIdProvider getProviderOverride(
    covariant _FetchListFromIdProvider provider,
  ) {
    return call(
      provider.listId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<CustomList?> Function(_FetchListFromIdRef ref) create) {
    return _$FetchListFromIdFamilyOverride(this, create);
  }
}

class _$FetchListFromIdFamilyOverride implements FamilyOverride {
  _$FetchListFromIdFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<CustomList?> Function(_FetchListFromIdRef ref) create;

  @override
  final _FetchListFromIdFamily overriddenFamily;

  @override
  _FetchListFromIdProvider getProviderOverride(
    covariant _FetchListFromIdProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchListFromId].
class _FetchListFromIdProvider extends AutoDisposeFutureProvider<CustomList?> {
  /// See also [_fetchListFromId].
  _FetchListFromIdProvider(
    String listId,
  ) : this._internal(
          (ref) => _fetchListFromId(
            ref as _FetchListFromIdRef,
            listId,
          ),
          from: _fetchListFromIdProvider,
          name: r'_fetchListFromIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchListFromIdHash,
          dependencies: _FetchListFromIdFamily._dependencies,
          allTransitiveDependencies:
              _FetchListFromIdFamily._allTransitiveDependencies,
          listId: listId,
        );

  _FetchListFromIdProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listId,
  }) : super.internal();

  final String listId;

  @override
  Override overrideWith(
    FutureOr<CustomList?> Function(_FetchListFromIdRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchListFromIdProvider._internal(
        (ref) => create(ref as _FetchListFromIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listId: listId,
      ),
    );
  }

  @override
  (String,) get argument {
    return (listId,);
  }

  @override
  AutoDisposeFutureProviderElement<CustomList?> createElement() {
    return _FetchListFromIdProviderElement(this);
  }

  _FetchListFromIdProvider _copyWith(
    FutureOr<CustomList?> Function(_FetchListFromIdRef ref) create,
  ) {
    return _FetchListFromIdProvider._internal(
      (ref) => create(ref as _FetchListFromIdRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      listId: listId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchListFromIdProvider && other.listId == listId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchListFromIdRef on AutoDisposeFutureProviderRef<CustomList?> {
  /// The parameter `listId` of this provider.
  String get listId;
}

class _FetchListFromIdProviderElement
    extends AutoDisposeFutureProviderElement<CustomList?>
    with _FetchListFromIdRef {
  _FetchListFromIdProviderElement(super.provider);

  @override
  String get listId => (origin as _FetchListFromIdProvider).listId;
}

String _$fetchListFeedHash() => r'8706dde3905759d148996ebbf85add52ba6c8c8e';

/// See also [_fetchListFeed].
@ProviderFor(_fetchListFeed)
const _fetchListFeedProvider = _FetchListFeedFamily();

/// See also [_fetchListFeed].
class _FetchListFeedFamily extends Family {
  /// See also [_fetchListFeed].
  const _FetchListFeedFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchListFeedProvider';

  /// See also [_fetchListFeed].
  _FetchListFeedProvider call(
    CustomList list,
  ) {
    return _FetchListFeedProvider(
      list,
    );
  }

  @visibleForOverriding
  @override
  _FetchListFeedProvider getProviderOverride(
    covariant _FetchListFeedProvider provider,
  ) {
    return call(
      provider.list,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<ChapterFeedItemData>> Function(_FetchListFeedRef ref)
          create) {
    return _$FetchListFeedFamilyOverride(this, create);
  }
}

class _$FetchListFeedFamilyOverride implements FamilyOverride {
  _$FetchListFeedFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<ChapterFeedItemData>> Function(_FetchListFeedRef ref)
      create;

  @override
  final _FetchListFeedFamily overriddenFamily;

  @override
  _FetchListFeedProvider getProviderOverride(
    covariant _FetchListFeedProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchListFeed].
class _FetchListFeedProvider
    extends AutoDisposeFutureProvider<List<ChapterFeedItemData>> {
  /// See also [_fetchListFeed].
  _FetchListFeedProvider(
    CustomList list,
  ) : this._internal(
          (ref) => _fetchListFeed(
            ref as _FetchListFeedRef,
            list,
          ),
          from: _fetchListFeedProvider,
          name: r'_fetchListFeedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchListFeedHash,
          dependencies: _FetchListFeedFamily._dependencies,
          allTransitiveDependencies:
              _FetchListFeedFamily._allTransitiveDependencies,
          list: list,
        );

  _FetchListFeedProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.list,
  }) : super.internal();

  final CustomList list;

  @override
  Override overrideWith(
    FutureOr<List<ChapterFeedItemData>> Function(_FetchListFeedRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchListFeedProvider._internal(
        (ref) => create(ref as _FetchListFeedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        list: list,
      ),
    );
  }

  @override
  (CustomList,) get argument {
    return (list,);
  }

  @override
  AutoDisposeFutureProviderElement<List<ChapterFeedItemData>> createElement() {
    return _FetchListFeedProviderElement(this);
  }

  _FetchListFeedProvider _copyWith(
    FutureOr<List<ChapterFeedItemData>> Function(_FetchListFeedRef ref) create,
  ) {
    return _FetchListFeedProvider._internal(
      (ref) => create(ref as _FetchListFeedRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      list: list,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchListFeedProvider && other.list == list;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, list.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchListFeedRef
    on AutoDisposeFutureProviderRef<List<ChapterFeedItemData>> {
  /// The parameter `list` of this provider.
  CustomList get list;
}

class _FetchListFeedProviderElement
    extends AutoDisposeFutureProviderElement<List<ChapterFeedItemData>>
    with _FetchListFeedRef {
  _FetchListFeedProviderElement(super.provider);

  @override
  CustomList get list => (origin as _FetchListFeedProvider).list;
}

String _$fetchListTitlesHash() => r'4f37294a1deb0e40bed04ea64ed433dc171435c6';

/// See also [_fetchListTitles].
@ProviderFor(_fetchListTitles)
const _fetchListTitlesProvider = _FetchListTitlesFamily();

/// See also [_fetchListTitles].
class _FetchListTitlesFamily extends Family {
  /// See also [_fetchListTitles].
  const _FetchListTitlesFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchListTitlesProvider';

  /// See also [_fetchListTitles].
  _FetchListTitlesProvider call(
    CustomList list,
  ) {
    return _FetchListTitlesProvider(
      list,
    );
  }

  @visibleForOverriding
  @override
  _FetchListTitlesProvider getProviderOverride(
    covariant _FetchListTitlesProvider provider,
  ) {
    return call(
      provider.list,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<Iterable<Manga>> Function(_FetchListTitlesRef ref) create) {
    return _$FetchListTitlesFamilyOverride(this, create);
  }
}

class _$FetchListTitlesFamilyOverride implements FamilyOverride {
  _$FetchListTitlesFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Iterable<Manga>> Function(_FetchListTitlesRef ref) create;

  @override
  final _FetchListTitlesFamily overriddenFamily;

  @override
  _FetchListTitlesProvider getProviderOverride(
    covariant _FetchListTitlesProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchListTitles].
class _FetchListTitlesProvider
    extends AutoDisposeFutureProvider<Iterable<Manga>> {
  /// See also [_fetchListTitles].
  _FetchListTitlesProvider(
    CustomList list,
  ) : this._internal(
          (ref) => _fetchListTitles(
            ref as _FetchListTitlesRef,
            list,
          ),
          from: _fetchListTitlesProvider,
          name: r'_fetchListTitlesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchListTitlesHash,
          dependencies: _FetchListTitlesFamily._dependencies,
          allTransitiveDependencies:
              _FetchListTitlesFamily._allTransitiveDependencies,
          list: list,
        );

  _FetchListTitlesProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.list,
  }) : super.internal();

  final CustomList list;

  @override
  Override overrideWith(
    FutureOr<Iterable<Manga>> Function(_FetchListTitlesRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchListTitlesProvider._internal(
        (ref) => create(ref as _FetchListTitlesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        list: list,
      ),
    );
  }

  @override
  (CustomList,) get argument {
    return (list,);
  }

  @override
  AutoDisposeFutureProviderElement<Iterable<Manga>> createElement() {
    return _FetchListTitlesProviderElement(this);
  }

  _FetchListTitlesProvider _copyWith(
    FutureOr<Iterable<Manga>> Function(_FetchListTitlesRef ref) create,
  ) {
    return _FetchListTitlesProvider._internal(
      (ref) => create(ref as _FetchListTitlesRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      list: list,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchListTitlesProvider && other.list == list;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, list.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchListTitlesRef on AutoDisposeFutureProviderRef<Iterable<Manga>> {
  /// The parameter `list` of this provider.
  CustomList get list;
}

class _FetchListTitlesProviderElement
    extends AutoDisposeFutureProviderElement<Iterable<Manga>>
    with _FetchListTitlesRef {
  _FetchListTitlesProviderElement(super.provider);

  @override
  CustomList get list => (origin as _FetchListTitlesProvider).list;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
