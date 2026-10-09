import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gagaku/reader/model/config.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/reader/model/viewport_controller.dart';
import 'package:gagaku/reader/widgets/long_strip_page_image.dart';
import 'package:gagaku/reader/widgets/passive_tap_listener.dart';
import 'package:gagaku/util/ui.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class HorizontalReaderView extends StatelessWidget {
  const HorizontalReaderView({
    super.key,
    required this.controller,
    required this.pages,
    required this.settings,
    required this.onTapZone,
    required this.onPageChanged,
    required this.onInteraction,
  });

  final HorizontalReaderViewportController controller;
  final List<ReaderPage> pages;
  final ReaderConfig settings;
  final ValueChanged<ReaderTapZone> onTapZone;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onInteraction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => PassiveTapListener(
        onTap: (position) =>
            onTapZone(ReaderTapZone.of(position.dx, constraints.maxWidth)),
        child: PhotoViewGallery.builder(
          allowImplicitScrolling: true,
          reverse: settings.direction == ReaderDirection.rightToLeft,
          scrollPhysics: !settings.swipeGestures
              ? const NeverScrollableScrollPhysics()
              : null,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          pageController: controller.pageController,
          onPageChanged: (index) {
            onPageChanged(index);
            onInteraction();
          },
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                value: event != null && event.expectedTotalBytes != null
                    ? event.cumulativeBytesLoaded / event.expectedTotalBytes!
                    : null,
              ),
            ),
          ),
          itemCount: pages.length,
          builder: (context, index) {
            final page = pages[index];
            return PhotoViewGalleryPageOptions(
              imageProvider: readerImageProvider(page),
              controller: controller.viewController(index),
              scaleStateController: controller.scaleController(index),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 5,
              initialScale: PhotoViewComputedScale.contained,
              basePosition: Alignment.center,
            );
          },
        ),
      ),
    );
  }
}

class LongStripReaderView extends StatefulWidget {
  const LongStripReaderView({
    super.key,
    required this.controller,
    required this.pages,
    required this.displayWidth,
    required this.cacheWidth,
    required this.onCenterTap,
  });

  final LongStripReaderViewportController controller;
  final List<ReaderPage> pages;
  final double displayWidth;
  final int cacheWidth;
  final VoidCallback onCenterTap;

  @override
  State<LongStripReaderView> createState() => _LongStripReaderViewState();
}

class _LongStripReaderViewState extends State<LongStripReaderView> {
  /// Vertical insets applied as list padding; tracked so anchors can be
  /// captured relative to the first item.
  EdgeInsets? _padding;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final padding = MediaQuery.paddingOf(context).copyWith(left: 0, right: 0);
    final previous = _padding;
    _padding = padding;

    // System bars toggling with the reader chrome change the top inset,
    // which would otherwise shift every page.
    if (previous != null && previous.top != padding.top) {
      widget.controller.preserveAnchorForRelayout(
        leadingPadding: previous.top,
        extentsChanged: false,
      );
    }
  }

  @override
  void didUpdateWidget(LongStripReaderView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.displayWidth != oldWidget.displayWidth) {
      widget.controller.preserveAnchorForRelayout(
        leadingPadding: _padding?.top ?? 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);
    final LongStripReaderView(
      :controller,
      :pages,
      :displayWidth,
      :cacheWidth,
      :onCenterTap,
    ) = widget;

    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapUp: (details) {
          final zone = ReaderTapZone.of(
            details.localPosition.dx,
            constraints.maxWidth,
          );
          if (zone == ReaderTapZone.center) {
            onCenterTap();
          }
        },
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction != ScrollDirection.idle) {
              controller.releasePin();
            }
            return false;
          },
          child: SuperListView.builder(
            padding: _padding,
            listController: controller.listController,
            controller: controller.scrollController,
            cacheExtent: mediaSize.height * 3,
            addAutomaticKeepAlives: false,
            extentEstimation: (index, _) {
              if (index == null) return 0;
              final aspectRatio = pages[index].aspectRatio;
              return aspectRatio == null
                  ? mediaSize.height
                  : displayWidth / aspectRatio;
            },
            itemCount: pages.length,
            itemBuilder: (context, index) {
              final page = pages[index];
              return Center(
                key: ValueKey(page.id),
                child: _LongStripZoomGesture(
                  onZoomRequested: () {
                    Navigator.of(context).push<void>(
                      TransparentOverlay(
                        builder: (context) => LongStripPageOverlay(page: page),
                      ),
                    );
                  },
                  child: Hero(
                    tag: page.id,
                    child: RepaintBoundary(
                      child: LongStripPageImage(
                        page: page,
                        displayWidth: displayWidth,
                        cacheWidth: cacheWidth,
                        placeholderExtent: mediaSize.height,
                        onAspectRatioChanged: () =>
                            controller.invalidateExtent(index),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LongStripPageOverlay extends StatelessWidget {
  const LongStripPageOverlay({super.key, required this.page});

  final ReaderPage page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const OverlayCloseButton(),
      ),
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Hero(
        tag: page.id,
        child: PhotoView(
          imageProvider: readerImageProvider(page),
          backgroundDecoration: const BoxDecoration(color: Colors.transparent),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 5,
          initialScale: PhotoViewComputedScale.contained,
          basePosition: Alignment.center,
          onTapUp: (context, _, _) => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

class _LongStripZoomGesture extends StatefulWidget {
  const _LongStripZoomGesture({
    required this.onZoomRequested,
    required this.child,
  });

  final VoidCallback onZoomRequested;
  final Widget child;

  @override
  State<_LongStripZoomGesture> createState() => _LongStripZoomGestureState();
}

class _LongStripZoomGestureState extends State<_LongStripZoomGesture> {
  static const _minimumPinchDelta = 12.0;
  static const _relativePinchDelta = 0.05;

  final Map<int, Offset> _pointerPositions = {};
  double? _initialSpan;
  bool _zoomRequested = false;

  void _handlePointerDown(PointerDownEvent event) {
    _pointerPositions[event.pointer] = event.localPosition;
    if (_pointerPositions.length == 2 && !_zoomRequested) {
      _initialSpan = _currentSpan;
    } else if (_pointerPositions.length > 2) {
      _initialSpan = null;
    }
  }

  void _handlePointerMove(PointerMoveEvent event) {
    if (!_pointerPositions.containsKey(event.pointer)) return;
    _pointerPositions[event.pointer] = event.localPosition;

    final initialSpan = _initialSpan;
    if (_zoomRequested ||
        initialSpan == null ||
        _pointerPositions.length != 2) {
      return;
    }

    final threshold = math.max(
      _minimumPinchDelta,
      initialSpan * _relativePinchDelta,
    );
    if ((_currentSpan - initialSpan).abs() < threshold) return;

    _zoomRequested = true;
    widget.onZoomRequested();
  }

  void _handlePointerEnd(PointerEvent event) {
    _pointerPositions.remove(event.pointer);
    if (_pointerPositions.length < 2) {
      _initialSpan = null;
    }
    if (_pointerPositions.isEmpty) {
      _zoomRequested = false;
    }
  }

  double get _currentSpan {
    final positions = _pointerPositions.values;
    return (positions.first - positions.last).distance;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _handlePointerDown,
      onPointerMove: _handlePointerMove,
      onPointerUp: _handlePointerEnd,
      onPointerCancel: _handlePointerEnd,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onDoubleTap: widget.onZoomRequested,
        child: widget.child,
      ),
    );
  }
}
