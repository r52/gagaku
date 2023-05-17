// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMangaFromGistHash() => r'305a6534cc913f1f9eb812611ada214bd64dddd4';

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

typedef GetMangaFromGistRef = AutoDisposeFutureProviderRef<WebManga>;

/// See also [getMangaFromGist].
@ProviderFor(getMangaFromGist)
const getMangaFromGistProvider = GetMangaFromGistFamily();

/// See also [getMangaFromGist].
class GetMangaFromGistFamily extends Family<AsyncValue<WebManga>> {
  /// See also [getMangaFromGist].
  const GetMangaFromGistFamily();

  /// See also [getMangaFromGist].
  GetMangaFromGistProvider call(
    String code,
  ) {
    return GetMangaFromGistProvider(
      code,
    );
  }

  @override
  GetMangaFromGistProvider getProviderOverride(
    covariant GetMangaFromGistProvider provider,
  ) {
    return call(
      provider.code,
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
  String? get name => r'getMangaFromGistProvider';
}

/// See also [getMangaFromGist].
class GetMangaFromGistProvider extends AutoDisposeFutureProvider<WebManga> {
  /// See also [getMangaFromGist].
  GetMangaFromGistProvider(
    this.code,
  ) : super.internal(
          (ref) => getMangaFromGist(
            ref,
            code,
          ),
          from: getMangaFromGistProvider,
          name: r'getMangaFromGistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMangaFromGistHash,
          dependencies: GetMangaFromGistFamily._dependencies,
          allTransitiveDependencies:
              GetMangaFromGistFamily._allTransitiveDependencies,
        );

  final String code;

  @override
  bool operator ==(Object other) {
    return other is GetMangaFromGistProvider && other.code == code;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, code.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getImgurPagesHash() => r'0d5b23e0e304dae01c5d989bce519a3ce0b22104';
typedef GetImgurPagesRef = AutoDisposeFutureProviderRef<List<ImgurPage>>;

/// See also [getImgurPages].
@ProviderFor(getImgurPages)
const getImgurPagesProvider = GetImgurPagesFamily();

/// See also [getImgurPages].
class GetImgurPagesFamily extends Family<AsyncValue<List<ImgurPage>>> {
  /// See also [getImgurPages].
  const GetImgurPagesFamily();

  /// See also [getImgurPages].
  GetImgurPagesProvider call(
    String code,
  ) {
    return GetImgurPagesProvider(
      code,
    );
  }

  @override
  GetImgurPagesProvider getProviderOverride(
    covariant GetImgurPagesProvider provider,
  ) {
    return call(
      provider.code,
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
  String? get name => r'getImgurPagesProvider';
}

/// See also [getImgurPages].
class GetImgurPagesProvider extends AutoDisposeFutureProvider<List<ImgurPage>> {
  /// See also [getImgurPages].
  GetImgurPagesProvider(
    this.code,
  ) : super.internal(
          (ref) => getImgurPages(
            ref,
            code,
          ),
          from: getImgurPagesProvider,
          name: r'getImgurPagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getImgurPagesHash,
          dependencies: GetImgurPagesFamily._dependencies,
          allTransitiveDependencies:
              GetImgurPagesFamily._allTransitiveDependencies,
        );

  final String code;

  @override
  bool operator ==(Object other) {
    return other is GetImgurPagesProvider && other.code == code;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, code.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
