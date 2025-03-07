// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_fetchGroupFromId)
const _fetchGroupFromIdProvider = _FetchGroupFromIdFamily._();

final class _FetchGroupFromIdProvider
    extends $FunctionalProvider<AsyncValue<Group>, FutureOr<Group>>
    with $FutureModifier<Group>, $FutureProvider<Group> {
  const _FetchGroupFromIdProvider._({
    required _FetchGroupFromIdFamily super.from,
    required String super.argument,
    FutureOr<Group> Function(Ref ref, String groupId)? create,
  }) : _createCb = create,
       super(
         retry: null,
         name: r'_fetchGroupFromIdProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<Group> Function(Ref ref, String groupId)? _createCb;

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
      $FutureProviderElement(this, pointer);

  @override
  _FetchGroupFromIdProvider $copyWithCreate(
    FutureOr<Group> Function(Ref ref) create,
  ) {
    return _FetchGroupFromIdProvider._(
      argument: argument as String,
      from: from! as _FetchGroupFromIdFamily,
      create: (ref, String groupId) => create(ref),
    );
  }

  @override
  FutureOr<Group> create(Ref ref) {
    final _$cb = _createCb ?? _fetchGroupFromId;
    final argument = this.argument as String;
    return _$cb(ref, argument);
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

String _$fetchGroupFromIdHash() => r'a2edf2a8397c422faa6458d9bf2a3ae6bb7ba27d';

final class _FetchGroupFromIdFamily extends Family {
  const _FetchGroupFromIdFamily._()
    : super(
        retry: null,
        name: r'_fetchGroupFromIdProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _FetchGroupFromIdProvider call(String groupId) =>
      _FetchGroupFromIdProvider._(argument: groupId, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchGroupFromIdHash();

  @override
  String toString() => r'_fetchGroupFromIdProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(FutureOr<Group> Function(Ref ref, String args) create) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchGroupFromIdProvider;

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
