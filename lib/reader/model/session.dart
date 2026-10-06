import 'dart:async';
import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gagaku/reader/model/types.dart';

enum ReaderPageTurnResult { handled, closeReader }

abstract interface class ReaderViewportController {
  /// Whether horizontal turns move between pages in this viewport.
  bool get turnsPages;

  /// Prepares the viewport to open at [page] when its widget next mounts.
  ///
  /// Called while the viewport's widget is not built yet, before the session
  /// schedules [jumpToPage] for after the first frame.
  void prepareInitialPage(int page);

  void jumpToPage(int page);

  /// Scrolls or pans by [delta] logical pixels; positive values move towards
  /// the end of the chapter.
  ReaderPageTurnResult scrollBy(double delta, {required int currentPage});

  void togglePageSize(int currentPage);
}

final class ReaderPrefetchPolicy {
  const ReaderPrefetchPolicy({
    required this.forwardCount,
    this.backwardCount = 3,
    this.cacheWidth,
  });

  factory ReaderPrefetchPolicy.forReader({
    required ReaderFormat format,
    required int configuredCount,
    required int pageCount,
    int? longStripCacheWidth,
  }) {
    return switch (format) {
      ReaderFormat.longstrip => ReaderPrefetchPolicy(
        forwardCount: configuredCount.clamp(1, 9),
        cacheWidth: longStripCacheWidth,
      ),
      ReaderFormat.single => ReaderPrefetchPolicy(
        forwardCount: configuredCount > 9 ? pageCount : configuredCount,
      ),
    };
  }

  final int forwardCount;
  final int backwardCount;
  final int? cacheWidth;

  @override
  bool operator ==(Object other) {
    return other is ReaderPrefetchPolicy &&
        other.forwardCount == forwardCount &&
        other.backwardCount == backwardCount &&
        other.cacheWidth == cacheWidth;
  }

  @override
  int get hashCode => Object.hash(forwardCount, backwardCount, cacheWidth);
}

/// Decodes [provider] into the image cache and returns its decoded size in
/// bytes, or null if it failed to load.
typedef ReaderPrecacheImage = Future<int?> Function(
  ImageProvider<Object> provider,
);
typedef ReaderPostFrameScheduler = void Function(VoidCallback callback);

void scheduleReaderPostFrame(VoidCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) => callback());
}

int _imageCacheBudgetBytes() =>
    PaintingBinding.instance.imageCache.maximumSizeBytes;

/// Resolves [provider] like [precacheImage], additionally reporting the
/// decoded size so the prefetch window can be sized to the image cache.
Future<int?> precacheReaderImage(
  ImageProvider<Object> provider,
  ImageConfiguration configuration,
) {
  final completer = Completer<int?>();
  final stream = provider.resolve(configuration);
  ImageStreamListener? listener;
  listener = ImageStreamListener(
    (image, sync) {
      if (!completer.isCompleted) {
        completer.complete(image.sizeBytes);
      }
      image.dispose();
      // Same as precacheImage: keep the stream alive until the end of the
      // frame so the cache can retain the completed image.
      SchedulerBinding.instance.addPostFrameCallback((_) {
        stream.removeListener(listener!);
      });
    },
    onError: (exception, stackTrace) {
      if (!completer.isCompleted) {
        completer.complete(null);
      }
      stream.removeListener(listener!);
    },
  );
  stream.addListener(listener);
  return completer.future;
}

class ReaderSession {
  ReaderSession({
    required this._pages,
    required this._precacheImage,
    this._schedulePostFrame = scheduleReaderPostFrame,
    this._cacheBudgetBytes = _imageCacheBudgetBytes,
  }) : currentPage = ValueNotifier<int>(0),
       chromeVisible = ValueNotifier<bool>(false);

  /// Share of the image cache the prefetch window may occupy, leaving room
  /// for pages that are on screen or kept by the viewport.
  static const _prefetchCacheShare = 0.75;

  final List<ReaderPage> _pages;
  final ReaderPrecacheImage _precacheImage;
  final ReaderPostFrameScheduler _schedulePostFrame;
  final int Function() _cacheBudgetBytes;
  ReaderViewportController? _viewport;
  ReaderPrefetchPolicy? _prefetchPolicy;

  final Set<ImageProvider<Object>> _precacheInFlight = {};
  final Map<int, int> _decodedPageBytes = {};
  int? _lastPrefetchCapacity;
  int _cacheScheduleToken = 0;
  bool _disposed = false;

  final ValueNotifier<int> currentPage;
  final ValueNotifier<bool> chromeVisible;

  int get pageCount => _pages.length;

  void bindViewport(ReaderViewportController viewport) {
    if (identical(_viewport, viewport)) return;
    _viewport = viewport;

    final page = currentPage.value;
    viewport.prepareInitialPage(page);
    _schedulePostFrame(() {
      if (_disposed || !identical(_viewport, viewport)) return;
      viewport.jumpToPage(page);
    });
  }

  void updatePrefetchPolicy(ReaderPrefetchPolicy policy) {
    final previous = _prefetchPolicy;
    if (previous == policy) return;
    _prefetchPolicy = policy;

    // Decoded sizes depend on the decode width; measure again after a change.
    if (previous?.cacheWidth != policy.cacheWidth) {
      _decodedPageBytes.clear();
    }
    _schedulePrefetch();
  }

  void reportVisiblePage(int page, {ReaderViewportController? source}) {
    if (source != null && !identical(_viewport, source)) return;
    if (!_isValidPage(page) || currentPage.value == page) return;

    currentPage.value = page;
    _schedulePrefetch();
  }

  void jumpToPage(int page) {
    if (!_isValidPage(page)) return;
    _viewport?.jumpToPage(page);
  }

  void jumpToPreviousPage() {
    jumpToPage(currentPage.value - 1);
  }

  void jumpToNextPage() {
    jumpToPage(currentPage.value + 1);
  }

  ReaderPageTurnResult turnLeft(ReaderDirection direction) {
    if (_viewport?.turnsPages != true) return ReaderPageTurnResult.handled;

    return switch (direction) {
      ReaderDirection.leftToRight => _turnPrevious(),
      ReaderDirection.rightToLeft => _turnNext(),
    };
  }

  ReaderPageTurnResult turnRight(ReaderDirection direction) {
    if (_viewport?.turnsPages != true) return ReaderPageTurnResult.handled;

    return switch (direction) {
      ReaderDirection.leftToRight => _turnNext(),
      ReaderDirection.rightToLeft => _turnPrevious(),
    };
  }

  ReaderPageTurnResult scrollBy(double delta) {
    return _viewport?.scrollBy(delta, currentPage: currentPage.value) ??
        ReaderPageTurnResult.handled;
  }

  void togglePageSize() {
    _viewport?.togglePageSize(currentPage.value);
  }

  void toggleChrome() {
    chromeVisible.value = !chromeVisible.value;
  }

  ReaderPageTurnResult _turnPrevious() {
    jumpToPreviousPage();
    return ReaderPageTurnResult.handled;
  }

  ReaderPageTurnResult _turnNext() {
    if (currentPage.value >= pageCount - 1) {
      return ReaderPageTurnResult.closeReader;
    }

    jumpToNextPage();
    return ReaderPageTurnResult.handled;
  }

  bool _isValidPage(int page) => page >= 0 && page < _pages.length;

  void _schedulePrefetch() {
    final policy = _prefetchPolicy;
    if (policy == null || _pages.isEmpty) return;

    final token = ++_cacheScheduleToken;
    _schedulePostFrame(() {
      if (_disposed || token != _cacheScheduleToken) return;
      _prefetch(policy);
    });
  }

  /// How many pages besides the current one fit in the cache share, or null
  /// until a decoded page size has been measured.
  int? _prefetchCapacity() {
    if (_decodedPageBytes.isEmpty) return null;

    final totalBytes = _decodedPageBytes.values.reduce((a, b) => a + b);
    final averageBytes = max(1, totalBytes ~/ _decodedPageBytes.length);
    final budget = (_cacheBudgetBytes() * _prefetchCacheShare) ~/ averageBytes;
    return max(1, budget - 1);
  }

  void _prefetch(ReaderPrefetchPolicy policy) {
    final capacity = _prefetchCapacity();
    _lastPrefetchCapacity = capacity;

    // Until a page size is known, probe a single page rather than flooding
    // the cache with an unbounded window.
    final forwardCount = min(policy.forwardCount, capacity ?? 1);
    final backwardCount = capacity == null
        ? 0
        : min(policy.backwardCount, capacity - forwardCount);

    for (final index in readerPrecacheIndices(
      currentIndex: currentPage.value,
      pageCount: _pages.length,
      forwardCount: forwardCount,
      backwardCount: backwardCount,
    )) {
      final page = _pages[index];
      final provider = switch (policy.cacheWidth) {
        final width? => ResizeImage.resizeIfNeeded(width, null, page.provider),
        null => page.provider,
      };

      // Pages that already completed are requested again: a cache hit is a
      // cheap synchronous resolve that also refreshes their LRU position,
      // and an evicted page is decoded anew.
      if (!_precacheInFlight.add(provider)) continue;

      unawaited(
        _precacheImage(provider)
            .then(
              (bytes) => _handlePrecached(policy, index, bytes),
              onError: (Object _) {},
            )
            .whenComplete(() => _precacheInFlight.remove(provider)),
      );
    }
  }

  void _handlePrecached(ReaderPrefetchPolicy policy, int index, int? bytes) {
    if (_disposed || bytes == null || bytes <= 0) return;
    if (policy.cacheWidth != _prefetchPolicy?.cacheWidth) return;

    _decodedPageBytes[index] = bytes;
    if (_prefetchCapacity() != _lastPrefetchCapacity) {
      _schedulePrefetch();
    }
  }

  void dispose() {
    _disposed = true;
    _viewport = null;
    currentPage.dispose();
    chromeVisible.dispose();
  }
}
