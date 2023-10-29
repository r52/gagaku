// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchChapterDataHash() => r'9e8b6fa7433ff78d9562ff05a58747eca63f1c30';

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

/// See also [_fetchChapterData].
@ProviderFor(_fetchChapterData)
const _fetchChapterDataProvider = _FetchChapterDataFamily();

/// See also [_fetchChapterData].
class _FetchChapterDataFamily extends Family<AsyncValue<ReaderData>> {
  /// See also [_fetchChapterData].
  const _FetchChapterDataFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchChapterDataProvider';

  /// See also [_fetchChapterData].
  _FetchChapterDataProvider call(
    String chapterId,
  ) {
    return _FetchChapterDataProvider(
      chapterId,
    );
  }

  @visibleForOverriding
  @override
  _FetchChapterDataProvider getProviderOverride(
    covariant _FetchChapterDataProvider provider,
  ) {
    return call(
      provider.chapterId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<ReaderData> Function(_FetchChapterDataRef ref) create) {
    return _$FetchChapterDataFamilyOverride(this, create);
  }
}

class _$FetchChapterDataFamilyOverride
    implements FamilyOverride<AsyncValue<ReaderData>> {
  _$FetchChapterDataFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<ReaderData> Function(_FetchChapterDataRef ref) create;

  @override
  final _FetchChapterDataFamily overriddenFamily;

  @override
  _FetchChapterDataProvider getProviderOverride(
    covariant _FetchChapterDataProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchChapterData].
class _FetchChapterDataProvider extends AutoDisposeFutureProvider<ReaderData> {
  /// See also [_fetchChapterData].
  _FetchChapterDataProvider(
    String chapterId,
  ) : this._internal(
          (ref) => _fetchChapterData(
            ref as _FetchChapterDataRef,
            chapterId,
          ),
          from: _fetchChapterDataProvider,
          name: r'_fetchChapterDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchChapterDataHash,
          dependencies: _FetchChapterDataFamily._dependencies,
          allTransitiveDependencies:
              _FetchChapterDataFamily._allTransitiveDependencies,
          chapterId: chapterId,
        );

  _FetchChapterDataProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chapterId,
  }) : super.internal();

  final String chapterId;

  @override
  Override overrideWith(
    FutureOr<ReaderData> Function(_FetchChapterDataRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchChapterDataProvider._internal(
        (ref) => create(ref as _FetchChapterDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chapterId: chapterId,
      ),
    );
  }

  @override
  (String,) get argument {
    return (chapterId,);
  }

  @override
  AutoDisposeFutureProviderElement<ReaderData> createElement() {
    return _FetchChapterDataProviderElement(this);
  }

  _FetchChapterDataProvider _copyWith(
    FutureOr<ReaderData> Function(_FetchChapterDataRef ref) create,
  ) {
    return _FetchChapterDataProvider._internal(
      (ref) => create(ref as _FetchChapterDataRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      chapterId: chapterId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchChapterDataProvider && other.chapterId == chapterId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chapterId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchChapterDataRef on AutoDisposeFutureProviderRef<ReaderData> {
  /// The parameter `chapterId` of this provider.
  String get chapterId;
}

class _FetchChapterDataProviderElement
    extends AutoDisposeFutureProviderElement<ReaderData>
    with _FetchChapterDataRef {
  _FetchChapterDataProviderElement(super.provider);

  @override
  String get chapterId => (origin as _FetchChapterDataProvider).chapterId;
}

String _$fetchChapterPagesHash() => r'd95fb71f4cc56d537abd2ffe7db4441503825b39';

/// See also [_fetchChapterPages].
@ProviderFor(_fetchChapterPages)
const _fetchChapterPagesProvider = _FetchChapterPagesFamily();

/// See also [_fetchChapterPages].
class _FetchChapterPagesFamily extends Family<AsyncValue<List<ReaderPage>>> {
  /// See also [_fetchChapterPages].
  const _FetchChapterPagesFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_fetchChapterPagesProvider';

  /// See also [_fetchChapterPages].
  _FetchChapterPagesProvider call(
    Chapter chapter,
  ) {
    return _FetchChapterPagesProvider(
      chapter,
    );
  }

  @visibleForOverriding
  @override
  _FetchChapterPagesProvider getProviderOverride(
    covariant _FetchChapterPagesProvider provider,
  ) {
    return call(
      provider.chapter,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<ReaderPage>> Function(_FetchChapterPagesRef ref) create) {
    return _$FetchChapterPagesFamilyOverride(this, create);
  }
}

class _$FetchChapterPagesFamilyOverride
    implements FamilyOverride<AsyncValue<List<ReaderPage>>> {
  _$FetchChapterPagesFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<ReaderPage>> Function(_FetchChapterPagesRef ref) create;

  @override
  final _FetchChapterPagesFamily overriddenFamily;

  @override
  _FetchChapterPagesProvider getProviderOverride(
    covariant _FetchChapterPagesProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_fetchChapterPages].
class _FetchChapterPagesProvider
    extends AutoDisposeFutureProvider<List<ReaderPage>> {
  /// See also [_fetchChapterPages].
  _FetchChapterPagesProvider(
    Chapter chapter,
  ) : this._internal(
          (ref) => _fetchChapterPages(
            ref as _FetchChapterPagesRef,
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
          chapter: chapter,
        );

  _FetchChapterPagesProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chapter,
  }) : super.internal();

  final Chapter chapter;

  @override
  Override overrideWith(
    FutureOr<List<ReaderPage>> Function(_FetchChapterPagesRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchChapterPagesProvider._internal(
        (ref) => create(ref as _FetchChapterPagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chapter: chapter,
      ),
    );
  }

  @override
  (Chapter,) get argument {
    return (chapter,);
  }

  @override
  AutoDisposeFutureProviderElement<List<ReaderPage>> createElement() {
    return _FetchChapterPagesProviderElement(this);
  }

  _FetchChapterPagesProvider _copyWith(
    FutureOr<List<ReaderPage>> Function(_FetchChapterPagesRef ref) create,
  ) {
    return _FetchChapterPagesProvider._internal(
      (ref) => create(ref as _FetchChapterPagesRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      chapter: chapter,
    );
  }

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

mixin _FetchChapterPagesRef on AutoDisposeFutureProviderRef<List<ReaderPage>> {
  /// The parameter `chapter` of this provider.
  Chapter get chapter;
}

class _FetchChapterPagesProviderElement
    extends AutoDisposeFutureProviderElement<List<ReaderPage>>
    with _FetchChapterPagesRef {
  _FetchChapterPagesProviderElement(super.provider);

  @override
  Chapter get chapter => (origin as _FetchChapterPagesProvider).chapter;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
