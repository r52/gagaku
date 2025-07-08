// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_getDirectoryPages)
const _getDirectoryPagesProvider = _GetDirectoryPagesFamily._();

final class _GetDirectoryPagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReaderPage>>,
          List<ReaderPage>,
          FutureOr<List<ReaderPage>>
        >
    with $FutureModifier<List<ReaderPage>>, $FutureProvider<List<ReaderPage>> {
  const _GetDirectoryPagesProvider._({
    required _GetDirectoryPagesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'_getDirectoryPagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReaderPage>> create(Ref ref) {
    final argument = this.argument as String;
    return _getDirectoryPages(ref, argument);
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

final class _GetDirectoryPagesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ReaderPage>>, String> {
  const _GetDirectoryPagesFamily._()
    : super(
        retry: null,
        name: r'_getDirectoryPagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _GetDirectoryPagesProvider call(String path) =>
      _GetDirectoryPagesProvider._(argument: path, from: this);

  @override
  String toString() => r'_getDirectoryPagesProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
