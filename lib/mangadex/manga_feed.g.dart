// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchMangaFeedHash() => r'c3640bb83ead43bc2f70dd846df402c678d9e4af';

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

typedef FetchMangaFeedRef = AutoDisposeFutureProviderRef<FeedResults>;

/// See also [fetchMangaFeed].
@ProviderFor(fetchMangaFeed)
const fetchMangaFeedProvider = FetchMangaFeedFamily();

/// See also [fetchMangaFeed].
class FetchMangaFeedFamily extends Family<AsyncValue<FeedResults>> {
  /// See also [fetchMangaFeed].
  const FetchMangaFeedFamily();

  /// See also [fetchMangaFeed].
  FetchMangaFeedProvider call(
    int offset,
  ) {
    return FetchMangaFeedProvider(
      offset,
    );
  }

  @override
  FetchMangaFeedProvider getProviderOverride(
    covariant FetchMangaFeedProvider provider,
  ) {
    return call(
      provider.offset,
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
  String? get name => r'fetchMangaFeedProvider';
}

/// See also [fetchMangaFeed].
class FetchMangaFeedProvider extends AutoDisposeFutureProvider<FeedResults> {
  /// See also [fetchMangaFeed].
  FetchMangaFeedProvider(
    this.offset,
  ) : super.internal(
          (ref) => fetchMangaFeed(
            ref,
            offset,
          ),
          from: fetchMangaFeedProvider,
          name: r'fetchMangaFeedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchMangaFeedHash,
          dependencies: FetchMangaFeedFamily._dependencies,
          allTransitiveDependencies:
              FetchMangaFeedFamily._allTransitiveDependencies,
        );

  final int offset;

  @override
  bool operator ==(Object other) {
    return other is FetchMangaFeedProvider && other.offset == offset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
