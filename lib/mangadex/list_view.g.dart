// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_getList)
const _getListProvider = _GetListFamily._();

final class _GetListProvider
    extends $FunctionalProvider<AsyncValue<CustomList?>, FutureOr<CustomList?>>
    with $FutureModifier<CustomList?>, $FutureProvider<CustomList?> {
  const _GetListProvider._({
    required _GetListFamily super.from,
    required String super.argument,
    FutureOr<CustomList?> Function(Ref ref, String listId)? create,
  }) : _createCb = create,
       super(
         retry: noRetry,
         name: r'_getListProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<CustomList?> Function(Ref ref, String listId)? _createCb;

  @override
  String debugGetCreateSourceHash() => _$getListHash();

  @override
  String toString() {
    return r'_getListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CustomList?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(this, pointer);

  @override
  _GetListProvider $copyWithCreate(
    FutureOr<CustomList?> Function(Ref ref) create,
  ) {
    return _GetListProvider._(
      argument: argument as String,
      from: from! as _GetListFamily,
      create: (ref, String listId) => create(ref),
    );
  }

  @override
  FutureOr<CustomList?> create(Ref ref) {
    final _$cb = _createCb ?? _getList;
    final argument = this.argument as String;
    return _$cb(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getListHash() => r'7223b393ab63d2ecb03e3bfb704b339286537b49';

final class _GetListFamily extends Family {
  const _GetListFamily._()
    : super(
        retry: noRetry,
        name: r'_getListProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _GetListProvider call(String listId) =>
      _GetListProvider._(argument: listId, from: this);

  @override
  String debugGetCreateSourceHash() => _$getListHash();

  @override
  String toString() => r'_getListProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<CustomList?> Function(Ref ref, String args) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _GetListProvider;

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
