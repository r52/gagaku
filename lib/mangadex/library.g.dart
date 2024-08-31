// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _GetLibraryListByTypeRef = Ref<AsyncValue<List<String>>>;

@ProviderFor(_getLibraryListByType)
const _getLibraryListByTypeProvider = _GetLibraryListByTypeFamily._();

final class _GetLibraryListByTypeProvider extends $FunctionalProvider<
        AsyncValue<List<String>>, FutureOr<List<String>>>
    with
        $FutureModifier<List<String>>,
        $FutureProvider<List<String>, _GetLibraryListByTypeRef> {
  const _GetLibraryListByTypeProvider._(
      {required _GetLibraryListByTypeFamily super.from,
      required MangaReadingStatus super.argument,
      FutureOr<List<String>> Function(
        _GetLibraryListByTypeRef ref,
        MangaReadingStatus type,
      )? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'_getLibraryListByTypeProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<String>> Function(
    _GetLibraryListByTypeRef ref,
    MangaReadingStatus type,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$getLibraryListByTypeHash();

  @override
  String toString() {
    return r'_getLibraryListByTypeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _GetLibraryListByTypeProvider $copyWithCreate(
    FutureOr<List<String>> Function(
      _GetLibraryListByTypeRef ref,
    ) create,
  ) {
    return _GetLibraryListByTypeProvider._(
        argument: argument as MangaReadingStatus,
        from: from! as _GetLibraryListByTypeFamily,
        create: (
          ref,
          MangaReadingStatus type,
        ) =>
            create(ref));
  }

  @override
  FutureOr<List<String>> create(_GetLibraryListByTypeRef ref) {
    final _$cb = _createCb ?? _getLibraryListByType;
    final argument = this.argument as MangaReadingStatus;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _GetLibraryListByTypeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getLibraryListByTypeHash() =>
    r'576bfd0924e507660e503b96beb1a2bfc76b8e6f';

final class _GetLibraryListByTypeFamily extends Family {
  const _GetLibraryListByTypeFamily._()
      : super(
          retry: null,
          name: r'_getLibraryListByTypeProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _GetLibraryListByTypeProvider call(
    MangaReadingStatus type,
  ) =>
      _GetLibraryListByTypeProvider._(argument: type, from: this);

  @override
  String debugGetCreateSourceHash() => _$getLibraryListByTypeHash();

  @override
  String toString() => r'_getLibraryListByTypeProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<String>> Function(
      _GetLibraryListByTypeRef ref,
      MangaReadingStatus args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _GetLibraryListByTypeProvider;

        final argument = provider.argument as MangaReadingStatus;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
