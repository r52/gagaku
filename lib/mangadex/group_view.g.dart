// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchGroupFeedHash() => r'2accd66c235ba80d1b919b2fe8e0299eb984ae5d';

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

typedef _FetchGroupFeedRef
    = AutoDisposeFutureProviderRef<List<ChapterFeedItemData>>;

/// See also [_fetchGroupFeed].
@ProviderFor(_fetchGroupFeed)
const _fetchGroupFeedProvider = _FetchGroupFeedFamily();

/// See also [_fetchGroupFeed].
class _FetchGroupFeedFamily
    extends Family<AsyncValue<List<ChapterFeedItemData>>> {
  /// See also [_fetchGroupFeed].
  const _FetchGroupFeedFamily();

  /// See also [_fetchGroupFeed].
  _FetchGroupFeedProvider call(
    Group group,
  ) {
    return _FetchGroupFeedProvider(
      group,
    );
  }

  @override
  _FetchGroupFeedProvider getProviderOverride(
    covariant _FetchGroupFeedProvider provider,
  ) {
    return call(
      provider.group,
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
  String? get name => r'_fetchGroupFeedProvider';
}

/// See also [_fetchGroupFeed].
class _FetchGroupFeedProvider
    extends AutoDisposeFutureProvider<List<ChapterFeedItemData>> {
  /// See also [_fetchGroupFeed].
  _FetchGroupFeedProvider(
    this.group,
  ) : super.internal(
          (ref) => _fetchGroupFeed(
            ref,
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
        );

  final Group group;

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

String _$fetchGroupTitlesHash() => r'7807d9d1023b067036001ef4fe0045d8b256766a';
typedef _FetchGroupTitlesRef = AutoDisposeFutureProviderRef<Iterable<Manga>>;

/// See also [_fetchGroupTitles].
@ProviderFor(_fetchGroupTitles)
const _fetchGroupTitlesProvider = _FetchGroupTitlesFamily();

/// See also [_fetchGroupTitles].
class _FetchGroupTitlesFamily extends Family<AsyncValue<Iterable<Manga>>> {
  /// See also [_fetchGroupTitles].
  const _FetchGroupTitlesFamily();

  /// See also [_fetchGroupTitles].
  _FetchGroupTitlesProvider call(
    Group group,
  ) {
    return _FetchGroupTitlesProvider(
      group,
    );
  }

  @override
  _FetchGroupTitlesProvider getProviderOverride(
    covariant _FetchGroupTitlesProvider provider,
  ) {
    return call(
      provider.group,
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
  String? get name => r'_fetchGroupTitlesProvider';
}

/// See also [_fetchGroupTitles].
class _FetchGroupTitlesProvider
    extends AutoDisposeFutureProvider<Iterable<Manga>> {
  /// See also [_fetchGroupTitles].
  _FetchGroupTitlesProvider(
    this.group,
  ) : super.internal(
          (ref) => _fetchGroupTitles(
            ref,
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
        );

  final Group group;

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
