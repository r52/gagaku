import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gagaku/reader/model/session.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:photo_view/photo_view.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class HorizontalReaderViewportController implements ReaderViewportController {
  PageController _pageController = PageController();
  final Map<int, PhotoViewScaleStateController> _scaleControllers = {};
  final Map<int, PhotoViewController> _viewControllers = {};

  PageController get pageController => _pageController;

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
  bool get turnsPages => true;

  @override
  void prepareInitialPage(int page) {
    // A mounted gallery keeps its position; only a fresh one needs the page.
    if (_pageController.hasClients || _pageController.initialPage == page) {
      return;
    }

    _pageController.dispose();
    _pageController = PageController(initialPage: page);
  }

  @override
  void jumpToPage(int page) {
    if (_pageController.hasClients) {
      _pageController.jumpToPage(page);
    }
  }

  @override
  ReaderPageTurnResult scrollBy(double delta, {required int currentPage}) {
    final controller = viewController(currentPage);
    controller.position = controller.position + Offset(0, -delta);
    return ReaderPageTurnResult.handled;
  }

  @override
  void togglePageSize(int currentPage) {
    final controller = scaleController(currentPage);
    controller.scaleState = defaultScaleStateCycle(controller.scaleState);
  }

  void dispose() {
    _pageController.dispose();

    for (final controller in _scaleControllers.values) {
      controller.dispose();
    }
    for (final controller in _viewControllers.values) {
      controller.dispose();
    }
  }
}

typedef _LongStripAnchor = ({int index, double fraction});

class LongStripReaderViewportController implements ReaderViewportController {
  LongStripReaderViewportController({
    required this.onVisiblePageChanged,
    this._schedulePostFrame = scheduleReaderPostFrame,
  }) {
    listController.addListener(_handleVisibleRangeChanged);
  }

  final ValueChanged<int> onVisiblePageChanged;
  final ReaderPostFrameScheduler _schedulePostFrame;
  final ScrollController scrollController = ScrollController();
  final ListController listController = ListController();

  /// Display scale of the strip. Follows the orientation default until the
  /// user picks a scale.
  final ValueNotifier<LongStripScale> scale = ValueNotifier(
    LongStripScale.full,
  );
  bool _scaleSelected = false;

  bool _visiblePageUpdateScheduled = false;
  int? _pendingVisiblePage;
  bool _disposed = false;

  /// Position re-applied whenever an item's extent changes until the user
  /// scrolls. Items above a jump target are laid out at estimated extents
  /// and push the target away once their images resolve.
  _LongStripAnchor? _pinnedAnchor;
  bool _repinScheduled = false;

  /// Destination of the scroll started by [scrollBy], while it runs.
  double? _scrollTarget;

  void applyDefaultScale({required bool portrait}) {
    if (_scaleSelected) return;
    scale.value = portrait ? LongStripScale.full : LongStripScale.small;
  }

  @override
  bool get turnsPages => false;

  @override
  void prepareInitialPage(int page) {
    // The list cannot open at an item before its extents are known; the
    // session's post-frame jump positions it.
  }

  @override
  void jumpToPage(int page) {
    if (!listController.isAttached) return;

    _pinnedAnchor = (index: page, fraction: 0.0);
    _jumpToAnchor(_pinnedAnchor!);
  }

  /// Stops holding the last programmatic position; called on user scrolls.
  void releasePin() {
    _pinnedAnchor = null;
  }

  @override
  ReaderPageTurnResult scrollBy(double delta, {required int currentPage}) {
    if (delta > 0 && isAtChapterEnd) {
      return ReaderPageTurnResult.closeReader;
    }
    if (!scrollController.hasClients) return ReaderPageTurnResult.handled;

    releasePin();

    // Key repeats extend the running scroll instead of restarting an eased
    // animation from wherever the previous one had reached.
    final position = scrollController.position;
    final target = ((_scrollTarget ?? position.pixels) + delta).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    _scrollTarget = target;
    scrollController
        .animateTo(
          target,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
        )
        .whenComplete(() {
          if (_scrollTarget == target) _scrollTarget = null;
        });
    return ReaderPageTurnResult.handled;
  }

  @override
  void togglePageSize(int currentPage) {
    _scaleSelected = true;
    scale.value = scale.value.next;
  }

  bool get isAtChapterEnd {
    if (!listController.isAttached || !scrollController.hasClients) {
      return false;
    }

    final range = listController.visibleRange;
    final position = scrollController.position;
    return range != null &&
        range.$2 == listController.numberOfItems - 1 &&
        position.pixels >= position.maxScrollExtent - precisionErrorTolerance;
  }

  void invalidateExtent(int index) {
    if (listController.isAttached && !listController.isLocked) {
      listController.invalidateExtent(index);
      _scheduleRepin();
    }
  }

  /// Keeps the item at the top of the viewport in place across a relayout:
  /// every item changing size (scale toggle, rotation) when [extentsChanged],
  /// or only the list's leading padding changing (system bars shown/hidden).
  ///
  /// Must be called before the relayout, while [leadingPadding] and the old
  /// extents still describe the current scroll offset.
  void preserveAnchorForRelayout({
    required double leadingPadding,
    bool extentsChanged = true,
  }) {
    final anchor = _captureAnchor(leadingPadding);
    if (anchor == null) return;

    if (extentsChanged && !listController.isLocked) {
      listController.invalidateAllExtents();
    }
    _pinnedAnchor = anchor;
    _scheduleRepin();
  }

  void _scheduleRepin() {
    if (_pinnedAnchor == null || _repinScheduled) return;

    _repinScheduled = true;
    _schedulePostFrame(() {
      _repinScheduled = false;
      final anchor = _pinnedAnchor;
      if (_disposed || anchor == null) return;
      _jumpToAnchor(anchor);
    });
  }

  _LongStripAnchor? _captureAnchor(double leadingPadding) {
    if (!listController.isAttached || !scrollController.hasClients) {
      return null;
    }

    // Locate the leading item from the extents rather than visibleRange,
    // which can still describe an earlier layout while scrolling.
    final offset = scrollController.offset - leadingPadding;
    final itemCount = listController.numberOfItems;
    var index = 0;
    var itemStart = 0.0;
    var extent = 0.0;
    for (; index < itemCount; index++) {
      extent = listController.extentForIndex(index).$1;
      if (itemStart + extent > offset) break;
      itemStart += extent;
    }
    if (index >= itemCount) return null;

    final fraction = extent > 0
        ? ((offset - itemStart) / extent).clamp(0.0, 1.0)
        : 0.0;
    return (index: index, fraction: fraction);
  }

  void _jumpToAnchor(_LongStripAnchor anchor) {
    if (!listController.isAttached || !scrollController.hasClients) return;
    if (anchor.index >= listController.numberOfItems) return;

    final (extent, _) = listController.extentForIndex(anchor.index);
    _discardObservedVisiblePage();
    listController.jumpToItem(
      index: anchor.index,
      scrollController: scrollController,
      alignment: 0,
      rect: Rect.fromLTWH(0, extent * anchor.fraction, 0, 0),
    );
  }

  /// Drops a visible page observed before a programmatic jump. The list
  /// reports the range of the layout preceding the jump after the frame, and
  /// forwarding it would briefly move the session to the wrong page.
  void _discardObservedVisiblePage() {
    _pendingVisiblePage = null;
  }

  void _handleVisibleRangeChanged() {
    if (!listController.isAttached) return;
    final range = listController.visibleRange;
    if (range == null) return;

    _pendingVisiblePage = range.$1;
    if (_visiblePageUpdateScheduled) return;

    _visiblePageUpdateScheduled = true;
    _schedulePostFrame(() {
      _visiblePageUpdateScheduled = false;
      final page = _pendingVisiblePage;
      _pendingVisiblePage = null;
      if (_disposed || page == null) return;
      // While pinned, another leading item is a transient layout before the
      // pin is re-applied, or the pin cannot reach the top near the end.
      final pinned = _pinnedAnchor;
      if (pinned != null && pinned.index != page) return;
      onVisiblePageChanged(page);
    });
  }

  void dispose() {
    _disposed = true;
    listController.removeListener(_handleVisibleRangeChanged);
    scrollController.dispose();
    listController.dispose();
    scale.dispose();
  }
}
