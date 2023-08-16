// ignore_for_file: invalid_use_of_internal_member

import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:gagaku/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

mixin ExpiringData {
  DateTime get expiry;

  bool isExpired() => DateTime.now().compareTo(expiry) >= 0;
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
