// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchListFeedHash() => r'4f41c43146a989372ae39f7c0fe479fea35adece';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
