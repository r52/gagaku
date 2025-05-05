// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_getArchivePages)
const _getArchivePagesProvider = _GetArchivePagesFamily._();

final class _GetArchivePagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReaderPage>>,
          FutureOr<List<ReaderPage>>
        >
    with $FutureModifier<List<ReaderPage>>, $FutureProvider<List<ReaderPage>> {
  const _GetArchivePagesProvider._({
    required _GetArchivePagesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'_getArchivePagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

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
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReaderPage>> create(Ref ref) {
    final argument = this.argument as String;
    return _getArchivePages(ref, argument);
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

String _$getArchivePagesHash() => r'a1e7575662cd6f4c098bd314d1b7308a3e29b50a';

final class _GetArchivePagesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ReaderPage>>, String> {
  const _GetArchivePagesFamily._()
    : super(
        retry: null,
        name: r'_getArchivePagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _GetArchivePagesProvider call(String path) =>
      _GetArchivePagesProvider._(argument: path, from: this);

  @override
  String toString() => r'_getArchivePagesProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
