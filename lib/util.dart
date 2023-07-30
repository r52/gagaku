// ignore_for_file: invalid_use_of_internal_member

import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:gagaku/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  static bool isMobile() => (Platform.isIOS || Platform.isAndroid);

  static bool isDesktop() =>
      (Platform.isLinux || Platform.isWindows || Platform.isMacOS);

  static bool screenWidthSmall(BuildContext context) {
    // Somewhat arbitrary measurement but w/e
    return MediaQuery.of(context).size.width <= 480;
  }

  static bool isPortraitMode(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.height > size.width;
  }
}

mixin AutoDisposeAsyncNotifierMix<T> on BuildlessAutoDisposeAsyncNotifier<T> {
  Timer? _staleTimer;
  DateTime? _expiry;

  void cancelStaleTime() {
    _staleTimer?.cancel();
  }

  void staleTime(Duration expiry) {
    _staleTimer?.cancel();

    _expiry = DateTime.now().add(expiry);

    _staleTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (_expiry == null) {
        timer.cancel();
      }

      if (_expiry != null && DateTime.now().compareTo(_expiry!) >= 0) {
        logger.d('${runtimeType.toString()}: staleTime expiry');
        ref.invalidateSelf();
      }
    });

    ref.onDispose(() {
      logger.d('${runtimeType.toString()}: disposed');
      _staleTimer?.cancel();
    });
  }
}

mixin AsyncNotifierMix<T> on BuildlessAsyncNotifier<T> {
  Timer? _staleTimer;
  DateTime? _expiry;

  void cancelStaleTime() {
    _staleTimer?.cancel();
  }

  void staleTime(Duration expiry) {
    _staleTimer?.cancel();

    _expiry = DateTime.now().add(expiry);

    _staleTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (_expiry == null) {
        timer.cancel();
      }

      if (_expiry != null && DateTime.now().compareTo(_expiry!) >= 0) {
        logger.d('${runtimeType.toString()}: staleTime expiry');
        ref.invalidateSelf();
      }
    });

    ref.onDispose(() {
      logger.d('${runtimeType.toString()}: disposed');
      _staleTimer?.cancel();
    });
  }
}
