// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_getDirectoryPages)
const _getDirectoryPagesProvider = _GetDirectoryPagesFamily._();

final class _GetDirectoryPagesProvider extends $FunctionalProvider<
        AsyncValue<List<ReaderPage>>, FutureOr<List<ReaderPage>>>
    with $FutureModifier<List<ReaderPage>>, $FutureProvider<List<ReaderPage>> {
  const _GetDirectoryPagesProvider._(
      {required _GetDirectoryPagesFamily super.from,
      required String super.argument,
      FutureOr<List<ReaderPage>> Function(
        Ref ref,
        String path,
      )? create})
      : _createCb = create,
        super(
          retry: null,
          name: r'_getDirectoryPagesProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ReaderPage>> Function(
    Ref ref,
    String path,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$getDirectoryPagesHash();

  @override
  String toString() {
    return r'_getDirectoryPagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ReaderPage>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _GetDirectoryPagesProvider $copyWithCreate(
    FutureOr<List<ReaderPage>> Function(
      Ref ref,
    ) create,
  ) {
    return _GetDirectoryPagesProvider._(
        argument: argument as String,
        from: from! as _GetDirectoryPagesFamily,
        create: (
          ref,
          String path,
        ) =>
            create(ref));
  }

  @override
  FutureOr<List<ReaderPage>> create(Ref ref) {
    final _$cb = _createCb ?? _getDirectoryPages;
    final argument = this.argument as String;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _GetDirectoryPagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getDirectoryPagesHash() => r'599be990d7fb9529e4c9f52cd1d9057e839a3eab';

final class _GetDirectoryPagesFamily extends Family {
  const _GetDirectoryPagesFamily._()
      : super(
          retry: null,
          name: r'_getDirectoryPagesProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _GetDirectoryPagesProvider call(
    String path,
  ) =>
      _GetDirectoryPagesProvider._(argument: path, from: this);

  @override
  String debugGetCreateSourceHash() => _$getDirectoryPagesHash();

  @override
  String toString() => r'_getDirectoryPagesProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<ReaderPage>> Function(
      Ref ref,
      String args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _GetDirectoryPagesProvider;

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
