// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchListFromIdHash() => r'c38dbc92caa6104d680b36e78dc0d5717f5993bd';

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

String _$getListPageHash() => r'beb8c91bfdf04e031ca9f7c561a4b07e8e551a0a';

/// See also [_getListPage].
@ProviderFor(_getListPage)
const _getListPageProvider = _GetListPageFamily();

/// See also [_getListPage].
class _GetListPageFamily extends Family {
  /// See also [_getListPage].
  const _GetListPageFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_getListPageProvider';

  /// See also [_getListPage].
  _GetListPageProvider call(
    Set<String> list,
    int page,
  ) {
    return _GetListPageProvider(
      list,
      page,
    );
  }

  @visibleForOverriding
  @override
  _GetListPageProvider getProviderOverride(
    covariant _GetListPageProvider provider,
  ) {
    return call(
      provider.list,
      provider.page,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<Iterable<Manga>> Function(_GetListPageRef ref) create) {
    return _$GetListPageFamilyOverride(this, create);
  }
}

class _$GetListPageFamilyOverride implements FamilyOverride {
  _$GetListPageFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Iterable<Manga>> Function(_GetListPageRef ref) create;

  @override
  final _GetListPageFamily overriddenFamily;

  @override
  _GetListPageProvider getProviderOverride(
    covariant _GetListPageProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_getListPage].
class _GetListPageProvider extends AutoDisposeFutureProvider<Iterable<Manga>> {
  /// See also [_getListPage].
  _GetListPageProvider(
    Set<String> list,
    int page,
  ) : this._internal(
          (ref) => _getListPage(
            ref as _GetListPageRef,
            list,
            page,
          ),
          from: _getListPageProvider,
          name: r'_getListPageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getListPageHash,
          dependencies: _GetListPageFamily._dependencies,
          allTransitiveDependencies:
              _GetListPageFamily._allTransitiveDependencies,
          list: list,
          page: page,
        );

  _GetListPageProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.list,
    required this.page,
  }) : super.internal();

  final Set<String> list;
  final int page;

  @override
  Override overrideWith(
    FutureOr<Iterable<Manga>> Function(_GetListPageRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetListPageProvider._internal(
        (ref) => create(ref as _GetListPageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        list: list,
        page: page,
      ),
    );
  }

  @override
  (
    Set<String>,
    int,
  ) get argument {
    return (
      list,
      page,
    );
  }

  @override
  AutoDisposeFutureProviderElement<Iterable<Manga>> createElement() {
    return _GetListPageProviderElement(this);
  }

  _GetListPageProvider _copyWith(
    FutureOr<Iterable<Manga>> Function(_GetListPageRef ref) create,
  ) {
    return _GetListPageProvider._internal(
      (ref) => create(ref as _GetListPageRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      list: list,
      page: page,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _GetListPageProvider &&
        other.list == list &&
        other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, list.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetListPageRef on AutoDisposeFutureProviderRef<Iterable<Manga>> {
  /// The parameter `list` of this provider.
  Set<String> get list;

  /// The parameter `page` of this provider.
  int get page;
}

class _GetListPageProviderElement
    extends AutoDisposeFutureProviderElement<Iterable<Manga>>
    with _GetListPageRef {
  _GetListPageProviderElement(super.provider);

  @override
  Set<String> get list => (origin as _GetListPageProvider).list;
  @override
  int get page => (origin as _GetListPageProvider).page;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
