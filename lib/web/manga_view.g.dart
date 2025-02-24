// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchWebMangaInfo)
const _fetchWebMangaInfoProvider = _FetchWebMangaInfoFamily._();

final class _FetchWebMangaInfoProvider
    extends $FunctionalProvider<AsyncValue<WebManga>, FutureOr<WebManga>>
    with $FutureModifier<WebManga>, $FutureProvider<WebManga> {
  const _FetchWebMangaInfoProvider._({
    required _FetchWebMangaInfoFamily super.from,
    required SourceHandler super.argument,
    FutureOr<WebManga> Function(Ref ref, SourceHandler handle)? create,
  }) : _createCb = create,
       super(
         retry: noRetry,
         name: r'_fetchWebMangaInfoProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<WebManga> Function(Ref ref, SourceHandler handle)? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchWebMangaInfoHash();

  @override
  String toString() {
    return r'_fetchWebMangaInfoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WebManga> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _FetchWebMangaInfoProvider $copyWithCreate(
    FutureOr<WebManga> Function(Ref ref) create,
  ) {
    return _FetchWebMangaInfoProvider._(
      argument: argument as SourceHandler,
      from: from! as _FetchWebMangaInfoFamily,
      create: (ref, SourceHandler handle) => create(ref),
    );
  }

  @override
  FutureOr<WebManga> create(Ref ref) {
    final _$cb = _createCb ?? _fetchWebMangaInfo;
    final argument = this.argument as SourceHandler;
    return _$cb(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchWebMangaInfoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchWebMangaInfoHash() => r'0622112342007844d48abb8e95b93836544d76dc';

final class _FetchWebMangaInfoFamily extends Family {
  const _FetchWebMangaInfoFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchWebMangaInfoProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchWebMangaInfoProvider call(SourceHandler handle) =>
      _FetchWebMangaInfoProvider._(argument: handle, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchWebMangaInfoHash();

  @override
  String toString() => r'_fetchWebMangaInfoProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<WebManga> Function(Ref ref, SourceHandler args) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchWebMangaInfoProvider;

        final argument = provider.argument as SourceHandler;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

@ProviderFor(_fetchWebMangaRedirect)
const _fetchWebMangaRedirectProvider = _FetchWebMangaRedirectFamily._();

final class _FetchWebMangaRedirectProvider
    extends
        $FunctionalProvider<AsyncValue<SourceHandler>, FutureOr<SourceHandler>>
    with $FutureModifier<SourceHandler>, $FutureProvider<SourceHandler> {
  const _FetchWebMangaRedirectProvider._({
    required _FetchWebMangaRedirectFamily super.from,
    required String super.argument,
    FutureOr<SourceHandler> Function(Ref ref, String url)? create,
  }) : _createCb = create,
       super(
         retry: noRetry,
         name: r'_fetchWebMangaRedirectProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<SourceHandler> Function(Ref ref, String url)? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchWebMangaRedirectHash();

  @override
  String toString() {
    return r'_fetchWebMangaRedirectProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SourceHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(this, pointer);

  @override
  _FetchWebMangaRedirectProvider $copyWithCreate(
    FutureOr<SourceHandler> Function(Ref ref) create,
  ) {
    return _FetchWebMangaRedirectProvider._(
      argument: argument as String,
      from: from! as _FetchWebMangaRedirectFamily,
      create: (ref, String url) => create(ref),
    );
  }

  @override
  FutureOr<SourceHandler> create(Ref ref) {
    final _$cb = _createCb ?? _fetchWebMangaRedirect;
    final argument = this.argument as String;
    return _$cb(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchWebMangaRedirectProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchWebMangaRedirectHash() =>
    r'7c18055102e449391dab2224a2ba3a240b1dc11b';

final class _FetchWebMangaRedirectFamily extends Family {
  const _FetchWebMangaRedirectFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchWebMangaRedirectProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchWebMangaRedirectProvider call(String url) =>
      _FetchWebMangaRedirectProvider._(argument: url, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchWebMangaRedirectHash();

  @override
  String toString() => r'_fetchWebMangaRedirectProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<SourceHandler> Function(Ref ref, String args) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchWebMangaRedirectProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
