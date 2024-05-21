// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchGroupFromIdHash() => r'e3d4cc80e72975244b843d666e4bc7876ba2132c';

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

/// See also [_fetchGroupFromId].
@ProviderFor(_fetchGroupFromId)
const _fetchGroupFromIdProvider = _FetchGroupFromIdFamily();

/// See also [_fetchGroupFromId].
class _FetchGroupFromIdFamily extends Family {
  /// See also [_fetchGroupFromId].
  const _FetchGroupFromIdFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchGroupFromIdProvider';

  /// See also [_fetchGroupFromId].
  _FetchGroupFromIdProvider call(
    String groupId,
  ) {
    return _FetchGroupFromIdProvider(
      groupId,
    );
  }

  @visibleForOverriding
  @override
  _FetchGroupFromIdProvider getProviderOverride(
    covariant _FetchGroupFromIdProvider provider,
  ) {
    return call(
      provider.groupId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<Group> Function(_FetchGroupFromIdRef ref) create) {
    return _$FetchGroupFromIdFamilyOverride(this, create);
  }
}

class _$FetchGroupFromIdFamilyOverride implements FamilyOverride {
  _$FetchGroupFromIdFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Group> Function(_FetchGroupFromIdRef ref) create;

  @override
  final _FetchGroupFromIdFamily overriddenFamily;

  @override
  _FetchGroupFromIdProvider getProviderOverride(
    covariant _FetchGroupFromIdProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchGroupFromId].
class _FetchGroupFromIdProvider extends AutoDisposeFutureProvider<Group> {
  /// See also [_fetchGroupFromId].
  _FetchGroupFromIdProvider(
    String groupId,
  ) : this._internal(
          (ref) => _fetchGroupFromId(
            ref as _FetchGroupFromIdRef,
            groupId,
          ),
          from: _fetchGroupFromIdProvider,
          name: r'_fetchGroupFromIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchGroupFromIdHash,
          dependencies: _FetchGroupFromIdFamily._dependencies,
          allTransitiveDependencies:
              _FetchGroupFromIdFamily._allTransitiveDependencies,
          groupId: groupId,
        );

  _FetchGroupFromIdProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  Override overrideWith(
    FutureOr<Group> Function(_FetchGroupFromIdRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchGroupFromIdProvider._internal(
        (ref) => create(ref as _FetchGroupFromIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  (String,) get argument {
    return (groupId,);
  }

  @override
  AutoDisposeFutureProviderElement<Group> createElement() {
    return _FetchGroupFromIdProviderElement(this);
  }

  _FetchGroupFromIdProvider _copyWith(
    FutureOr<Group> Function(_FetchGroupFromIdRef ref) create,
  ) {
    return _FetchGroupFromIdProvider._internal(
      (ref) => create(ref as _FetchGroupFromIdRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      groupId: groupId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchGroupFromIdProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchGroupFromIdRef on AutoDisposeFutureProviderRef<Group> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _FetchGroupFromIdProviderElement
    extends AutoDisposeFutureProviderElement<Group> with _FetchGroupFromIdRef {
  _FetchGroupFromIdProviderElement(super.provider);

  @override
  String get groupId => (origin as _FetchGroupFromIdProvider).groupId;
}

String _$fetchGroupFeedHash() => r'da2869a27034fa8fffc23229d9f3a809d3b6c479';

/// See also [_fetchGroupFeed].
@ProviderFor(_fetchGroupFeed)
const _fetchGroupFeedProvider = _FetchGroupFeedFamily();

/// See also [_fetchGroupFeed].
class _FetchGroupFeedFamily extends Family {
  /// See also [_fetchGroupFeed].
  const _FetchGroupFeedFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchGroupFeedProvider';

  /// See also [_fetchGroupFeed].
  _FetchGroupFeedProvider call(
    Group group,
  ) {
    return _FetchGroupFeedProvider(
      group,
    );
  }

  @visibleForOverriding
  @override
  _FetchGroupFeedProvider getProviderOverride(
    covariant _FetchGroupFeedProvider provider,
  ) {
    return call(
      provider.group,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<ChapterFeedItemData>> Function(_FetchGroupFeedRef ref)
          create) {
    return _$FetchGroupFeedFamilyOverride(this, create);
  }
}

class _$FetchGroupFeedFamilyOverride implements FamilyOverride {
  _$FetchGroupFeedFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<ChapterFeedItemData>> Function(_FetchGroupFeedRef ref)
      create;

  @override
  final _FetchGroupFeedFamily overriddenFamily;

  @override
  _FetchGroupFeedProvider getProviderOverride(
    covariant _FetchGroupFeedProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchGroupFeed].
class _FetchGroupFeedProvider
    extends AutoDisposeFutureProvider<List<ChapterFeedItemData>> {
  /// See also [_fetchGroupFeed].
  _FetchGroupFeedProvider(
    Group group,
  ) : this._internal(
          (ref) => _fetchGroupFeed(
            ref as _FetchGroupFeedRef,
            group,
          ),
          from: _fetchGroupFeedProvider,
          name: r'_fetchGroupFeedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchGroupFeedHash,
          dependencies: _FetchGroupFeedFamily._dependencies,
          allTransitiveDependencies:
              _FetchGroupFeedFamily._allTransitiveDependencies,
          group: group,
        );

  _FetchGroupFeedProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.group,
  }) : super.internal();

  final Group group;

  @override
  Override overrideWith(
    FutureOr<List<ChapterFeedItemData>> Function(_FetchGroupFeedRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchGroupFeedProvider._internal(
        (ref) => create(ref as _FetchGroupFeedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        group: group,
      ),
    );
  }

  @override
  (Group,) get argument {
    return (group,);
  }

  @override
  AutoDisposeFutureProviderElement<List<ChapterFeedItemData>> createElement() {
    return _FetchGroupFeedProviderElement(this);
  }

  _FetchGroupFeedProvider _copyWith(
    FutureOr<List<ChapterFeedItemData>> Function(_FetchGroupFeedRef ref) create,
  ) {
    return _FetchGroupFeedProvider._internal(
      (ref) => create(ref as _FetchGroupFeedRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      group: group,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchGroupFeedProvider && other.group == group;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, group.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchGroupFeedRef
    on AutoDisposeFutureProviderRef<List<ChapterFeedItemData>> {
  /// The parameter `group` of this provider.
  Group get group;
}

class _FetchGroupFeedProviderElement
    extends AutoDisposeFutureProviderElement<List<ChapterFeedItemData>>
    with _FetchGroupFeedRef {
  _FetchGroupFeedProviderElement(super.provider);

  @override
  Group get group => (origin as _FetchGroupFeedProvider).group;
}

String _$fetchGroupTitlesHash() => r'bfb5727668119145d1f694d28e1c80a56ace5757';

/// See also [_fetchGroupTitles].
@ProviderFor(_fetchGroupTitles)
const _fetchGroupTitlesProvider = _FetchGroupTitlesFamily();

/// See also [_fetchGroupTitles].
class _FetchGroupTitlesFamily extends Family {
  /// See also [_fetchGroupTitles].
  const _FetchGroupTitlesFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchGroupTitlesProvider';

  /// See also [_fetchGroupTitles].
  _FetchGroupTitlesProvider call(
    Group group,
  ) {
    return _FetchGroupTitlesProvider(
      group,
    );
  }

  @visibleForOverriding
  @override
  _FetchGroupTitlesProvider getProviderOverride(
    covariant _FetchGroupTitlesProvider provider,
  ) {
    return call(
      provider.group,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<Manga>> Function(_FetchGroupTitlesRef ref) create) {
    return _$FetchGroupTitlesFamilyOverride(this, create);
  }
}

class _$FetchGroupTitlesFamilyOverride implements FamilyOverride {
  _$FetchGroupTitlesFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<Manga>> Function(_FetchGroupTitlesRef ref) create;

  @override
  final _FetchGroupTitlesFamily overriddenFamily;

  @override
  _FetchGroupTitlesProvider getProviderOverride(
    covariant _FetchGroupTitlesProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchGroupTitles].
class _FetchGroupTitlesProvider extends AutoDisposeFutureProvider<List<Manga>> {
  /// See also [_fetchGroupTitles].
  _FetchGroupTitlesProvider(
    Group group,
  ) : this._internal(
          (ref) => _fetchGroupTitles(
            ref as _FetchGroupTitlesRef,
            group,
          ),
          from: _fetchGroupTitlesProvider,
          name: r'_fetchGroupTitlesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchGroupTitlesHash,
          dependencies: _FetchGroupTitlesFamily._dependencies,
          allTransitiveDependencies:
              _FetchGroupTitlesFamily._allTransitiveDependencies,
          group: group,
        );

  _FetchGroupTitlesProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.group,
  }) : super.internal();

  final Group group;

  @override
  Override overrideWith(
    FutureOr<List<Manga>> Function(_FetchGroupTitlesRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchGroupTitlesProvider._internal(
        (ref) => create(ref as _FetchGroupTitlesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        group: group,
      ),
    );
  }

  @override
  (Group,) get argument {
    return (group,);
  }

  @override
  AutoDisposeFutureProviderElement<List<Manga>> createElement() {
    return _FetchGroupTitlesProviderElement(this);
  }

  _FetchGroupTitlesProvider _copyWith(
    FutureOr<List<Manga>> Function(_FetchGroupTitlesRef ref) create,
  ) {
    return _FetchGroupTitlesProvider._internal(
      (ref) => create(ref as _FetchGroupTitlesRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      group: group,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchGroupTitlesProvider && other.group == group;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, group.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchGroupTitlesRef on AutoDisposeFutureProviderRef<List<Manga>> {
  /// The parameter `group` of this provider.
  Group get group;
}

class _FetchGroupTitlesProviderElement
    extends AutoDisposeFutureProviderElement<List<Manga>>
    with _FetchGroupTitlesRef {
  _FetchGroupTitlesProviderElement(super.provider);

  @override
  Group get group => (origin as _FetchGroupTitlesProvider).group;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
