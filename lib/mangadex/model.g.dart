// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchChapterFeedHash() => r'3ad78da1661a8838c5c31addf3da6b98459bb0e3';

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

typedef FetchChapterFeedRef = AutoDisposeFutureProviderRef<Iterable<Chapter>>;

/// See also [fetchChapterFeed].
@ProviderFor(fetchChapterFeed)
const fetchChapterFeedProvider = FetchChapterFeedFamily();

/// See also [fetchChapterFeed].
class FetchChapterFeedFamily extends Family<AsyncValue<Iterable<Chapter>>> {
  /// See also [fetchChapterFeed].
  const FetchChapterFeedFamily();

  /// See also [fetchChapterFeed].
  FetchChapterFeedProvider call(
    int offset,
  ) {
    return FetchChapterFeedProvider(
      offset,
    );
  }

  @override
  FetchChapterFeedProvider getProviderOverride(
    covariant FetchChapterFeedProvider provider,
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
  String? get name => r'fetchChapterFeedProvider';
}

/// See also [fetchChapterFeed].
class FetchChapterFeedProvider
    extends AutoDisposeFutureProvider<Iterable<Chapter>> {
  /// See also [fetchChapterFeed].
  FetchChapterFeedProvider(
    this.offset,
  ) : super.internal(
          (ref) => fetchChapterFeed(
            ref,
            offset,
          ),
          from: fetchChapterFeedProvider,
          name: r'fetchChapterFeedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchChapterFeedHash,
          dependencies: FetchChapterFeedFamily._dependencies,
          allTransitiveDependencies:
              FetchChapterFeedFamily._allTransitiveDependencies,
        );

  final int offset;

  @override
  bool operator ==(Object other) {
    return other is FetchChapterFeedProvider && other.offset == offset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$authControlHash() => r'f8be09eda62cb7aef4301595371cdb20bc07059e';

/// See also [AuthControl].
@ProviderFor(AuthControl)
final authControlProvider =
    AutoDisposeAsyncNotifierProvider<AuthControl, bool>.internal(
  AuthControl.new,
  name: r'authControlProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authControlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthControl = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
