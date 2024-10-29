// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _FetchGroupDataRef = Ref<AsyncValue<Set<Group>>>;

@ProviderFor(_fetchGroupData)
const _fetchGroupDataProvider = _FetchGroupDataFamily._();

final class _FetchGroupDataProvider
    extends $FunctionalProvider<AsyncValue<Set<Group>>, FutureOr<Set<Group>>>
    with
        $FutureModifier<Set<Group>>,
        $FutureProvider<Set<Group>, _FetchGroupDataRef> {
  const _FetchGroupDataProvider._(
      {required _FetchGroupDataFamily super.from,
      required Iterable<String> super.argument,
      FutureOr<Set<Group>> Function(
        _FetchGroupDataRef ref,
        Iterable<String> uuids,
      )? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'_fetchGroupDataProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<Set<Group>> Function(
    _FetchGroupDataRef ref,
    Iterable<String> uuids,
  )? _createCb;

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
      $FutureProviderElement(this, pointer);

  @override
  _FetchGroupDataProvider $copyWithCreate(
    FutureOr<Set<Group>> Function(
      _FetchGroupDataRef ref,
    ) create,
  ) {
    return _FetchGroupDataProvider._(
        argument: argument as Iterable<String>,
        from: from! as _FetchGroupDataFamily,
        create: (
          ref,
          Iterable<String> uuids,
        ) =>
            create(ref));
  }

  @override
  FutureOr<Set<Group>> create(_FetchGroupDataRef ref) {
    final _$cb = _createCb ?? _fetchGroupData;
    final argument = this.argument as Iterable<String>;
    return _$cb(
      ref,
      argument,
    );
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

final class _FetchGroupDataFamily extends Family {
  const _FetchGroupDataFamily._()
      : super(
          retry: null,
          name: r'_fetchGroupDataProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _FetchGroupDataProvider call(
    Iterable<String> uuids,
  ) =>
      _FetchGroupDataProvider._(argument: uuids, from: this);

  @override
  String debugGetCreateSourceHash() => _$fetchGroupDataHash();

  @override
  String toString() => r'_fetchGroupDataProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<Set<Group>> Function(
      _FetchGroupDataRef ref,
      Iterable<String> args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _FetchGroupDataProvider;

        final argument = provider.argument as Iterable<String>;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
