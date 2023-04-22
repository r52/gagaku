// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchChapterPagesHash() => r'c79da4849fa22c88b7fb397628a9688293faea93';

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

typedef _FetchChapterPagesRef = AutoDisposeFutureProviderRef<List<ReaderPage>>;

/// See also [_fetchChapterPages].
@ProviderFor(_fetchChapterPages)
const _fetchChapterPagesProvider = _FetchChapterPagesFamily();

/// See also [_fetchChapterPages].
class _FetchChapterPagesFamily extends Family<AsyncValue<List<ReaderPage>>> {
  /// See also [_fetchChapterPages].
  const _FetchChapterPagesFamily();

  /// See also [_fetchChapterPages].
  _FetchChapterPagesProvider call(
    Chapter chapter,
  ) {
    return _FetchChapterPagesProvider(
      chapter,
    );
  }

  @override
  _FetchChapterPagesProvider getProviderOverride(
    covariant _FetchChapterPagesProvider provider,
  ) {
    return call(
      provider.chapter,
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
  String? get name => r'_fetchChapterPagesProvider';
}

/// See also [_fetchChapterPages].
class _FetchChapterPagesProvider
    extends AutoDisposeFutureProvider<List<ReaderPage>> {
  /// See also [_fetchChapterPages].
  _FetchChapterPagesProvider(
    this.chapter,
  ) : super.internal(
          (ref) => _fetchChapterPages(
            ref,
            chapter,
          ),
          from: _fetchChapterPagesProvider,
          name: r'_fetchChapterPagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchChapterPagesHash,
          dependencies: _FetchChapterPagesFamily._dependencies,
          allTransitiveDependencies:
              _FetchChapterPagesFamily._allTransitiveDependencies,
        );

  final Chapter chapter;

  @override
  bool operator ==(Object other) {
    return other is _FetchChapterPagesProvider && other.chapter == chapter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chapter.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
