// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_getArchivePages)
final _getArchivePagesProvider = _GetArchivePagesFamily._();

final class _GetArchivePagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReaderPage>>,
          List<ReaderPage>,
          FutureOr<List<ReaderPage>>
        >
    with $FutureModifier<List<ReaderPage>>, $FutureProvider<List<ReaderPage>> {
  _GetArchivePagesProvider._({
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
  String debugGetCreateSourceHash() => _$_getArchivePagesHash();

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

String _$_getArchivePagesHash() => r'a1e7575662cd6f4c098bd314d1b7308a3e29b50a';

final class _GetArchivePagesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ReaderPage>>, String> {
  _GetArchivePagesFamily._()
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
