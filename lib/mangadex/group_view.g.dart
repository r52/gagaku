// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchGroupFromId)
const _fetchGroupFromIdProvider = _FetchGroupFromIdFamily._();

final class _FetchGroupFromIdProvider
    extends $FunctionalProvider<AsyncValue<Group>, Group, FutureOr<Group>>
    with $FutureModifier<Group>, $FutureProvider<Group> {
  const _FetchGroupFromIdProvider._({
    required _FetchGroupFromIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'_fetchGroupFromIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchGroupFromIdHash();

  @override
  String toString() {
    return r'_fetchGroupFromIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Group> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Group> create(Ref ref) {
    final argument = this.argument as String;
    return _fetchGroupFromId(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchGroupFromIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchGroupFromIdHash() => r'f1a1c9382f6e492c172d9eeb3e8622b544612bea';

final class _FetchGroupFromIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Group>, String> {
  const _FetchGroupFromIdFamily._()
    : super(
        retry: noRetry,
        name: r'_fetchGroupFromIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchGroupFromIdProvider call(String groupId) =>
      _FetchGroupFromIdProvider._(argument: groupId, from: this);

  @override
  String toString() => r'_fetchGroupFromIdProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
