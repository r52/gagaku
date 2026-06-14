import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gagaku/reader/model/types.dart';

abstract interface class ReaderViewportController {
  void jumpToPage(int page);
}

enum ReaderPageTurnResult { handled, closeReader }

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

  bool get retainsCompletedPages => cacheWidth == null;

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

typedef ReaderPrecacheImage =
    Future<void> Function(ImageProvider<Object> provider);
typedef ReaderPostFrameScheduler = void Function(VoidCallback callback);

void _scheduleAfterFrame(VoidCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) => callback());
}

class ReaderSession {
  ReaderSession({
    required List<ReaderPage> pages,
    required String? subtitle,
    required ReaderPrecacheImage precacheImage,
    ReaderPostFrameScheduler schedulePostFrame = _scheduleAfterFrame,
  }) : _pages = pages,
       _subtitle = subtitle,
       _precacheImage = precacheImage,
       _schedulePostFrame = schedulePostFrame,
       currentPage = ValueNotifier<int>(0),
       subtext = ValueNotifier<String?>(
         subtitle ?? (pages.isNotEmpty ? pages.first.sortKey : ''),
       ),
       chromeVisible = ValueNotifier<bool>(false);

  List<ReaderPage> _pages;
  String? _subtitle;
  final ReaderPrecacheImage _precacheImage;
  final ReaderPostFrameScheduler _schedulePostFrame;
  ReaderViewportController? _viewport;
  ReaderPrefetchPolicy? _prefetchPolicy;

  final Set<ImageProvider<Object>> _precacheInFlight = {};
  final Set<ImageProvider<Object>> _completedPrecache = {};
  int _cacheScheduleToken = 0;
  bool _disposed = false;

  final ValueNotifier<int> currentPage;
  final ValueNotifier<String?> subtext;
  final ValueNotifier<bool> chromeVisible;

  int get pageCount => _pages.length;

  void bindViewport(ReaderViewportController viewport) {
    if (identical(_viewport, viewport)) return;
    _viewport = viewport;

    _schedulePostFrame(() {
      if (_disposed || !identical(_viewport, viewport)) return;
      viewport.jumpToPage(currentPage.value);
    });
  }

  void updateContent({
    required List<ReaderPage> pages,
    required String? subtitle,
  }) {
    _pages = pages;
    _subtitle = subtitle;

    if (_pages.isEmpty) {
      currentPage.value = 0;
      subtext.value = subtitle ?? '';
      return;
    }

    final page = currentPage.value.clamp(0, _pages.length - 1);
    reportVisiblePage(page);
    _schedulePrefetch();
  }

  void updatePrefetchPolicy(ReaderPrefetchPolicy policy) {
    if (_prefetchPolicy == policy) return;
    _prefetchPolicy = policy;
    _schedulePrefetch();
  }

  void reportVisiblePage(int page, {ReaderViewportController? source}) {
    if (source != null && !identical(_viewport, source)) return;
    if (!_isValidPage(page)) return;

    final changed = currentPage.value != page;
    if (changed) {
      currentPage.value = page;
    }

    final nextSubtext = _subtitle ?? _pages[page].sortKey;
    if (subtext.value != nextSubtext) {
      subtext.value = nextSubtext;
    }

    if (changed) {
      _schedulePrefetch();
    }
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
    return switch (direction) {
      ReaderDirection.leftToRight => _turnPrevious(),
      ReaderDirection.rightToLeft => _turnNext(),
    };
  }

  ReaderPageTurnResult turnRight(ReaderDirection direction) {
    return switch (direction) {
      ReaderDirection.leftToRight => _turnNext(),
      ReaderDirection.rightToLeft => _turnPrevious(),
    };
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

  void _prefetch(ReaderPrefetchPolicy policy) {
    for (final index in readerPrecacheIndices(
      currentIndex: currentPage.value,
      pageCount: _pages.length,
      forwardCount: policy.forwardCount,
      backwardCount: policy.backwardCount,
    )) {
      final page = _pages[index];
      final provider = switch (policy.cacheWidth) {
        final width? => ResizeImage.resizeIfNeeded(width, null, page.provider),
        null => page.provider,
      };

      if (policy.retainsCompletedPages &&
          _completedPrecache.contains(provider)) {
        continue;
      }
      if (!_precacheInFlight.add(provider)) continue;

      unawaited(
        _precacheImage(provider).whenComplete(() {
          _precacheInFlight.remove(provider);
          if (policy.retainsCompletedPages) {
            _completedPrecache.add(provider);
          }
        }),
      );
    }
  }

  void dispose() {
    _disposed = true;
    _viewport = null;
    currentPage.dispose();
    subtext.dispose();
    chromeVisible.dispose();
  }
}
