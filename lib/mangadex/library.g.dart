// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(LibraryViewType)
const libraryViewTypeProvider = LibraryViewTypeProvider._();

final class LibraryViewTypeProvider
    extends $NotifierProvider<LibraryViewType, MangaReadingStatus> {
  const LibraryViewTypeProvider._({
    super.runNotifierBuildOverride,
    LibraryViewType Function()? create,
  }) : _createCb = create,
       super(
         from: null,
         argument: null,
         retry: null,
         name: r'libraryViewTypeProvider',
         isAutoDispose: false,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final LibraryViewType Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$libraryViewTypeHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MangaReadingStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<MangaReadingStatus>(value),
    );
  }

  @$internal
  @override
  LibraryViewType create() => _createCb?.call() ?? LibraryViewType();

  @$internal
  @override
  LibraryViewTypeProvider $copyWithCreate(LibraryViewType Function() create) {
    return LibraryViewTypeProvider._(create: create);
  }

  @$internal
  @override
  LibraryViewTypeProvider $copyWithBuild(
    MangaReadingStatus Function(Ref, LibraryViewType) build,
  ) {
    return LibraryViewTypeProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<LibraryViewType, MangaReadingStatus> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(this, pointer);
}

String _$libraryViewTypeHash() => r'fa2f63791b8cda5c72e6ee8d27bf417968d97753';

abstract class _$LibraryViewType extends $Notifier<MangaReadingStatus> {
  MangaReadingStatus build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MangaReadingStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<MangaReadingStatus>,
              MangaReadingStatus,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(_getLibraryListByType)
const _getLibraryListByTypeProvider = _GetLibraryListByTypeFamily._();

final class _GetLibraryListByTypeProvider
    extends
        $FunctionalProvider<AsyncValue<List<String>>, FutureOr<List<String>>>
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  const _GetLibraryListByTypeProvider._({
    required _GetLibraryListByTypeFamily super.from,
    required MangaReadingStatus super.argument,
    FutureOr<List<String>> Function(Ref ref, MangaReadingStatus type)? create,
  }) : _createCb = create,
       super(
         retry: null,
         name: r'_getLibraryListByTypeProvider',
         isAutoDispose: true,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final FutureOr<List<String>> Function(Ref ref, MangaReadingStatus type)?
  _createCb;

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
    $ProviderPointer pointer,
  ) => $FutureProviderElement(this, pointer);

  @override
  _GetLibraryListByTypeProvider $copyWithCreate(
    FutureOr<List<String>> Function(Ref ref) create,
  ) {
    return _GetLibraryListByTypeProvider._(
      argument: argument as MangaReadingStatus,
      from: from! as _GetLibraryListByTypeFamily,
      create: (ref, MangaReadingStatus type) => create(ref),
    );
  }

  @override
  FutureOr<List<String>> create(Ref ref) {
    final _$cb = _createCb ?? _getLibraryListByType;
    final argument = this.argument as MangaReadingStatus;
    return _$cb(ref, argument);
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
    r'748e235cf8af47055ca070f34f55bd5c07d82229';

final class _GetLibraryListByTypeFamily extends Family {
  const _GetLibraryListByTypeFamily._()
    : super(
        retry: null,
        name: r'_getLibraryListByTypeProvider',
        dependencies: null,
        allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _GetLibraryListByTypeProvider call(MangaReadingStatus type) =>
      _GetLibraryListByTypeProvider._(argument: type, from: this);

  @override
  String debugGetCreateSourceHash() => _$getLibraryListByTypeHash();

  @override
  String toString() => r'_getLibraryListByTypeProvider';

  /// {@macro riverpod.override_with}
  Override overrideWith(
    FutureOr<List<String>> Function(Ref ref, MangaReadingStatus args) create,
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
