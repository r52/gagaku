import 'package:flutter/material.dart';
import 'package:gagaku/reader/model/session.dart';
import 'package:photo_view/photo_view.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class HorizontalReaderViewportController implements ReaderViewportController {
  final PageController pageController = PageController(initialPage: 0);
  final Map<int, PhotoViewScaleStateController> _scaleControllers = {};
  final Map<int, PhotoViewController> _viewControllers = {};

  PhotoViewController viewController(int index) {
    return _viewControllers.putIfAbsent(index, PhotoViewController.new);
  }

  PhotoViewScaleStateController scaleController(int index) {
    return _scaleControllers.putIfAbsent(
      index,
      PhotoViewScaleStateController.new,
    );
  }

  @override
  void jumpToPage(int page) {
    if (pageController.hasClients) {
      pageController.jumpToPage(page);
    }
  }

  void panVertically(int page, double offset) {
    final controller = viewController(page);
    controller.position = controller.position + Offset(0, offset);
  }

  void togglePageSize(int page) {
    final controller = scaleController(page);
    controller.scaleState = defaultScaleStateCycle(controller.scaleState);
  }

  @Deprecated('Remove with the legacy animated reader command.')
  void animateToPage(
    int page, {
    required Duration duration,
    required Curve curve,
  }) {
    if (pageController.hasClients) {
      pageController.animateToPage(page, duration: duration, curve: curve);
    }
  }

  void dispose() {
    pageController.dispose();

    for (final controller in _scaleControllers.values) {
      controller.dispose();
    }
    for (final controller in _viewControllers.values) {
      controller.dispose();
    }
  }
}

class LongStripReaderViewportController implements ReaderViewportController {
  LongStripReaderViewportController({required this.onVisiblePageChanged}) {
    listController.addListener(_handleVisibleRangeChanged);
  }

  final ValueChanged<int> onVisiblePageChanged;
  final ScrollController scrollController = ScrollController();
  final ListController listController = ListController();

  bool _visiblePageUpdateScheduled = false;
  int? _pendingVisiblePage;
  bool _disposed = false;

  @override
  void jumpToPage(int page) {
    if (!listController.isAttached) return;

    listController.jumpToItem(
      index: page,
      scrollController: scrollController,
      alignment: 0,
    );
  }

  void scrollBy(double offset) {
    if (!scrollController.hasClients) return;

    scrollController.animateTo(
      scrollController.offset + offset,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  bool isAtChapterEnd(int pageCount) {
    if (!listController.isAttached || !scrollController.hasClients) {
      return false;
    }

    final range = listController.visibleRange;
    return range != null &&
        range.$2 == pageCount - 1 &&
        scrollController.position.atEdge &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent;
  }

  void invalidateExtent(int index) {
    if (listController.isAttached && !listController.isLocked) {
      listController.invalidateExtent(index);
    }
  }

  void resize(double scaleRatio) {
    if (!scrollController.hasClients) return;
    final currentOffset = scrollController.offset;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_disposed) return;

      if (listController.isAttached && !listController.isLocked) {
        listController.invalidateAllExtents();
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_disposed || !scrollController.hasClients) return;

        final target = currentOffset * scaleRatio;
        scrollController.jumpTo(
          target.clamp(
            scrollController.position.minScrollExtent,
            scrollController.position.maxScrollExtent,
          ),
        );
      });
    });
  }

  @Deprecated('Remove with the legacy animated reader command.')
  void animateToPage(
    int page, {
    required Duration duration,
    required Curve curve,
  }) {
    if (!listController.isAttached) return;

    listController.animateToItem(
      index: page,
      scrollController: scrollController,
      alignment: 0,
      duration: (_) => duration,
      curve: (_) => curve,
    );
  }

  void _handleVisibleRangeChanged() {
    if (!listController.isAttached) return;
    final range = listController.visibleRange;
    if (range == null) return;

    _pendingVisiblePage = range.$1;
    if (_visiblePageUpdateScheduled) return;

    _visiblePageUpdateScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _visiblePageUpdateScheduled = false;
      final page = _pendingVisiblePage;
      _pendingVisiblePage = null;
      if (_disposed || page == null) return;
      onVisiblePageChanged(page);
    });
  }

  void dispose() {
    _disposed = true;
    listController.removeListener(_handleVisibleRangeChanged);
    scrollController.dispose();
    listController.dispose();
  }
}
