// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(theme)
final themeProvider = ThemeProvider._();

final class ThemeProvider
    extends $FunctionalProvider<ThemeData, ThemeData, ThemeData>
    with $Provider<ThemeData> {
  ThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$themeHash();

  @$internal
  @override
  $ProviderElement<ThemeData> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeData create(Ref ref) {
    return theme(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeData>(value),
    );
  }
}

String _$themeHash() => r'0fea6438c8bee8be98515c10e8e67c2e75c6af46';

@ProviderFor(chipTextStyle)
final chipTextStyleProvider = ChipTextStyleProvider._();

final class ChipTextStyleProvider
    extends $FunctionalProvider<TextStyle, TextStyle, TextStyle>
    with $Provider<TextStyle> {
  ChipTextStyleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chipTextStyleProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$chipTextStyleHash();

  @$internal
  @override
  $ProviderElement<TextStyle> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TextStyle create(Ref ref) {
    return chipTextStyle(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TextStyle value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TextStyle>(value),
    );
  }
}

String _$chipTextStyleHash() => r'6628d3ccc477b307542773061b0d6f06c5007dc0';
