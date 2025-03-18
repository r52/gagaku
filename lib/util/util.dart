// ignore_for_file: invalid_use_of_internal_member

import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';

String cleanBaseDomains(String url) {
  url = url.startsWith('https://mangadex.org/') ? url.substring(20) : url;
  url = url.startsWith('https://cubari.moe/') ? url.substring(18) : url;
  return url;
}

Duration? noRetry(int retryCount, Object error) {
  return null;
}

mixin ExpiringData {
  DateTime get expiry;

  bool isExpired() => DateTime.now().compareTo(expiry) >= 0;
}

extension WidgetStateSet on Set<WidgetState> {
  bool get isSelected => contains(WidgetState.selected);
  bool get isHovered => contains(WidgetState.hovered);
  bool get isDisabled => contains(WidgetState.disabled);
}

extension IterableAsync<T> on Iterable<T> {
  Future<Iterable<T>> whereAsync(Future<bool> Function(T) test) async {
    final futures = map((e) async => (e, await test(e)));
    final results = await Future.wait(futures);
    return results.where((e) => e.$2).map((e) => e.$1);
  }
}

extension AsExtension on Object? {
  X as<X>() => this as X;
  X? asOrNull<X>() {
    var self = this;
    return self is X ? self : null;
  }
}

extension AsSubtypeExtension<X> on X {
  Y asSubtype<Y extends X>() => this as Y;
}

extension AsNotNullExtension<X> on X? {
  X asNotNull() => this as X;
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return '';

    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String crop() {
    if (length > 32) {
      return '${substring(0, 32)}...';
    }

    return this;
  }

  String format(List<String> values) {
    int index = 0;
    return replaceAllMapped(RegExp(r'{.*?}'), (_) {
      final value = values[index];
      index++;
      return value;
    });
  }

  String formatWithMap(Map<String, String> mappedValues) {
    return replaceAllMapped(RegExp(r'{(.*?)}'), (match) {
      final mapped = mappedValues[match[1]];
      if (mapped == null) {
        throw ArgumentError(
          '$mappedValues does not contain the key "${match[1]}"',
        );
      }
      return mapped;
    });
  }
}

class DeviceContext {
  static bool isMobile() => (Platform.isIOS || Platform.isAndroid);

  static bool isDesktop() =>
      (Platform.isLinux || Platform.isWindows || Platform.isMacOS);

  static bool screenWidthSmall(BuildContext context) {
    // Somewhat arbitrary measurement but w/e
    return MediaQuery.sizeOf(context).width <= 600;
  }

  static bool isPortraitMode(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.height > size.width;
  }
}

extension SearchUtil on StatefulWidget {
  void unfocusSearchBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }
}

extension SearchUtilX on State {
  void unfocusSearchBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex() =>
      '#${(toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
