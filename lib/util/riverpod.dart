import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gagaku/log.dart';

/// XXX: this may break because its depending on an internal riverpod class
mixin ListBasedInfiniteScrollMix<T> on $AsyncNotifier<List<T>> {
  int offset = 0;
  bool hasNextPage = true;

  @protected
  @mustBeOverridden
  int get limit;

  @protected
  @mustBeOverridden
  Future<List<T>> fetchData(int offset);

  @mustBeOverridden
  Future<List<T>> getNextPage();

  @protected
  Future<List<T>> getMore() async {
    final current = await future;

    if (!hasNextPage) {
      return [];
    }

    // If there is more content, get more
    if (current.length == offset + limit && hasNextPage) {
      final result = await fetchData(offset + limit);
      offset += limit;

      if (result.isEmpty) {
        hasNextPage = false;
      }

      state = AsyncData([...current, ...result]);

      return result;
    }

    // Otherwise, do nothing because there is no more content
    hasNextPage = false;

    return [];
  }
}

mixin AutoDisposeExpiryMix<T> on AnyNotifier<AsyncValue<T>> {
  Timer? _staleTimer;
  DateTime? _expiry;

  void cancelStaleTime() {
    _staleTimer?.cancel();
  }

  /// Invalidates the provider after [expiry]
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

  /// Keeps the provider alive for [duration] after pause
  void disposeAfter(Duration duration) {
    _staleTimer?.cancel();

    final link = ref.keepAlive();

    ref.onCancel(() {
      _staleTimer = Timer(duration, () {
        logger.d(
          '${runtimeType.toString()}: disposeAfter ${duration.toString()}',
        );
        link.close();
      });
    });

    ref.onResume(() {
      _staleTimer?.cancel();
    });

    ref.onDispose(() {
      logger.d('${runtimeType.toString()}: disposed');
      _staleTimer?.cancel();
    });
  }
}

// From riverpod doc https://riverpod.dev/docs/essentials/auto_dispose
extension CacheForExtension on Ref {
  /// Keeps the provider alive for [duration].
  void cacheFor(Duration duration) {
    // Immediately prevent the state from getting destroyed.
    final link = keepAlive();
    // After duration has elapsed, we re-enable automatic disposal.
    final timer = Timer(duration, link.close);

    // Optional: when the provider is recomputed (such as with ref.watch),
    // we cancel the pending timer.
    onDispose(timer.cancel);
  }

  /// Keeps the provider alive for [duration] after pause
  void disposeAfter(Duration duration) {
    Timer? timer;

    final link = keepAlive();

    onCancel(() {
      logger.d(
        '${runtimeType.toString()}: disposeAfter ${duration.toString()}',
      );
      timer = Timer(duration, link.close);
    });

    onResume(() {
      timer?.cancel();
    });

    onDispose(() {
      logger.d('${runtimeType.toString()}: disposed');
      timer?.cancel();
    });
  }
}

extension WidgetRefWorkaround on WidgetRef {
  void invalidateifExists(
    ProviderBase<Object?> provider, {
    bool asReload = false,
  }) {
    if (exists(provider)) {
      invalidate(provider, asReload: asReload);
    }
  }
}

extension RefWorkaround on Ref {
  void invalidateifExists(
    ProviderBase<Object?> provider, {
    bool asReload = false,
  }) {
    if (exists(provider)) {
      invalidate(provider, asReload: asReload);
    }
  }

  T readFuture<T>(Refreshable<T> listenable) {
    T result;
    final sub = listen(listenable, (_, __) {});

    try {
      result = sub.read();
    } finally {
      sub.close();
    }

    return result;
  }
}
