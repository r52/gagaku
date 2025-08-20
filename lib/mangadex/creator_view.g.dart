// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchCreatorFromId)
const _fetchCreatorFromIdProvider = _FetchCreatorFromIdFamily._();

final class _FetchCreatorFromIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<CreatorType>,
          CreatorType,
          FutureOr<CreatorType>
        >
    with $FutureModifier<CreatorType>, $FutureProvider<CreatorType> {
  const _FetchCreatorFromIdProvider._({
    required _FetchCreatorFromIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'_fetchCreatorFromIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$_fetchCreatorFromIdHash();

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
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CreatorType> create(Ref ref) {
    final argument = this.argument as String;
    return _fetchCreatorFromId(ref, argument);
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

String _$_fetchCreatorFromIdHash() =>
    r'4c8996715ea032e63f63141f4711917fa730362f';

final class _FetchCreatorFromIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CreatorType>, String> {
  const _FetchCreatorFromIdFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchCreatorFromIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchCreatorFromIdProvider call(String creatorId) =>
      _FetchCreatorFromIdProvider._(argument: creatorId, from: this);

  @override
  String toString() => r'_fetchCreatorFromIdProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
