// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchCreatorFromId)
const _fetchCreatorFromIdProvider = _FetchCreatorFromIdFamily._();

final class _FetchCreatorFromIdProvider
    extends $FunctionalProvider<AsyncValue<CreatorType>, FutureOr<CreatorType>>
    with $FutureModifier<CreatorType>, $FutureProvider<CreatorType> {
  const _FetchCreatorFromIdProvider._({
    required _FetchCreatorFromIdFamily super.from,
    required String super.argument,
    FutureOr<CreatorType> Function(Ref ref, String creatorId)? create,
  }) : _createCb = create,
       super(
         retry: noRetry,
         name: r'_fetchCreatorFromIdProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<CreatorType> Function(Ref ref, String creatorId)? _createCb;

  @override
  String debugGetCreateSourceHash() => _$fetchCreatorFromIdHash();

  @override
  String toString() {
    return r'_fetchCreatorFromIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CreatorType> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(this, pointer);

  @override
  _FetchCreatorFromIdProvider $copyWithCreate(
    FutureOr<CreatorType> Function(Ref ref) create,
  ) {
    return _FetchCreatorFromIdProvider._(
      argument: argument as String,
      from: from! as _FetchCreatorFromIdFamily,
      create: (ref, String creatorId) => create(ref),
    );
  }

  @override
  FutureOr<CreatorType> create(Ref ref) {
    final _$cb = _createCb ?? _fetchCreatorFromId;
    final argument = this.argument as String;
    return _$cb(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchCreatorFromIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchCreatorFromIdHash() =>
    r'4c8996715ea032e63f63141f4711917fa730362f';

final class _FetchCreatorFromIdFamily extends Family {
  const _FetchCreatorFromIdFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchCreatorFromIdProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchCreatorFromIdProvider call(String creatorId) =>
      _FetchCreatorFromIdProvider._(argument: creatorId, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchCreatorFromIdHash();

  @override
  String toString() => r'_fetchCreatorFromIdProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<CreatorType> Function(Ref ref, String args) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchCreatorFromIdProvider;

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
