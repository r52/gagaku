import 'dart:io' show Platform;

import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return '';

    return "${this[0].toUpperCase()}${substring(1)}";
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
