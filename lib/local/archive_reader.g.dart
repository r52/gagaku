// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

typedef _GetArchivePagesRef = Ref<AsyncValue<List<ReaderPage>>>;

@ProviderFor(_getArchivePages)
const _getArchivePagesProvider = _GetArchivePagesFamily._();

final class _GetArchivePagesProvider extends $FunctionalProvider<
        AsyncValue<List<ReaderPage>>, FutureOr<List<ReaderPage>>>
    with
        $FutureModifier<List<ReaderPage>>,
        $FutureProvider<List<ReaderPage>, _GetArchivePagesRef> {
  const _GetArchivePagesProvider._(
      {required _GetArchivePagesFamily super.from,
      required String super.argument,
      FutureOr<List<ReaderPage>> Function(
        _GetArchivePagesRef ref,
        String path,
      )? create})
      : _createCb = create,
        super(
          name: r'_getArchivePagesProvider',
          isAutoDispose: true,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final FutureOr<List<ReaderPage>> Function(
    _GetArchivePagesRef ref,
    String path,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$getArchivePagesHash();

  @override
  String toString() {
    return r'_getArchivePagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ReaderPage>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(this, pointer);

  @override
  _GetArchivePagesProvider $copyWithCreate(
    FutureOr<List<ReaderPage>> Function(
      _GetArchivePagesRef ref,
    ) create,
  ) {
    return _GetArchivePagesProvider._(
        argument: argument as String,
        from: from! as _GetArchivePagesFamily,
        create: (
          ref,
          String path,
        ) =>
            create(ref));
  }

  @override
  FutureOr<List<ReaderPage>> create(_GetArchivePagesRef ref) {
    final _$cb = _createCb ?? _getArchivePages;
    final argument = this.argument as String;
    return _$cb(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _GetArchivePagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getArchivePagesHash() => r'8e067b0ef41b21e8601fde9ff2db2cb087b32036';

final class _GetArchivePagesFamily extends Family {
  const _GetArchivePagesFamily._()
      : super(
          name: r'_getArchivePagesProvider',
          dependencies: null,
          allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  _GetArchivePagesProvider call(
    String path,
  ) =>
      _GetArchivePagesProvider._(argument: path, from: this);

  @override
  String debugGetCreateSourceHash() => _$getArchivePagesHash();

  @override
  String toString() => r'_getArchivePagesProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<ReaderPage>> Function(
      _GetArchivePagesRef ref,
      String args,
    ) create,
  ) {
    return $FamilyOverride(
      from: this,
      createElement: (pointer) {
        final provider = pointer.origin as _GetArchivePagesProvider;

        final argument = provider.argument as String;

        return provider
            .$copyWithCreate((ref) => create(ref, argument))
            .$createElement(pointer);
      },
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use_from_same_package, unreachable_from_main, invalid_use_of_internal_member
