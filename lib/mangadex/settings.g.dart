// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchGroupData)
const _fetchGroupDataProvider = _FetchGroupDataFamily._();

final class _FetchGroupDataProvider
    extends $FunctionalProvider<AsyncValue<Set<Group>>, FutureOr<Set<Group>>>
    with $FutureModifier<Set<Group>>, $FutureProvider<Set<Group>> {
  const _FetchGroupDataProvider._({
    required _FetchGroupDataFamily super.from,
    required Iterable<String> super.argument,
  }) : super(
         retry: null,
         name: r'_fetchGroupDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchGroupDataHash();

  @override
  String toString() {
    return r'_fetchGroupDataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Set<Group>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Set<Group>> create(Ref ref) {
    final argument = this.argument as Iterable<String>;
    return _fetchGroupData(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchGroupDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchGroupDataHash() => r'24d9984bf59cd196477e31f308827f4594f6115a';

final class _FetchGroupDataFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Set<Group>>, Iterable<String>> {
  const _FetchGroupDataFamily._()
    : super(
        retry: null,
        name: r'_fetchGroupDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchGroupDataProvider call(Iterable<String> uuids) =>
      _FetchGroupDataProvider._(argument: uuids, from: this);

  @override
  String toString() => r'_fetchGroupDataProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
