import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
}

class DeviceContext {
  static bool isMobile() {
    return (Platform.isIOS || Platform.isAndroid);
  }

  static bool isDesktop() {
    return (Platform.isLinux || Platform.isWindows || Platform.isMacOS);
  }

  static bool screenWidthSmall(BuildContext context) {
    // Somewhat arbitrary measurement but w/e
    return MediaQuery.of(context).size.width <= 480;
  }

  static bool isPortraitMode(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.height > size.width;
  }
}

extension AutoDisposeRefExt on AutoDisposeRef {
  void staleTime(Duration duration) {
    var timer = Timer(duration, invalidateSelf);

    onDispose(() {
      timer.cancel();
    });
  }
}
