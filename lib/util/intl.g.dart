// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(numberFormatter)
final numberFormatterProvider = NumberFormatterFamily._();

final class NumberFormatterProvider
    extends $FunctionalProvider<NumberFormat, NumberFormat, NumberFormat>
    with $Provider<NumberFormat> {
  NumberFormatterProvider._({
    required NumberFormatterFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'numberFormatterProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$numberFormatterHash();

  @override
  String toString() {
    return r'numberFormatterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<NumberFormat> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NumberFormat create(Ref ref) {
    final argument = this.argument as String;
    return numberFormatter(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NumberFormat value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NumberFormat>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NumberFormatterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$numberFormatterHash() => r'032143a612c454e714669aa13b3d94fe29475ad4';

final class NumberFormatterFamily extends $Family
    with $FunctionalFamilyOverride<NumberFormat, String> {
  NumberFormatterFamily._()
    : super(
        retry: null,
        name: r'numberFormatterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  NumberFormatterProvider call(String locale) =>
      NumberFormatterProvider._(argument: locale, from: this);

  @override
  String toString() => r'numberFormatterProvider';
}
