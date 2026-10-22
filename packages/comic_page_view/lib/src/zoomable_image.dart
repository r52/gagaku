import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'boundaries.dart';
import 'defaults.dart';
import 'page_controller.dart';
import 'recognizer.dart';
import 'scale.dart';

typedef ComicLoadingBuilder = Widget Function(
  BuildContext context,
  ImageChunkEvent? event,
);

typedef ComicErrorBuilder = Widget Function(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
);

typedef ComicTapUpCallback = void Function(
  BuildContext context,
  TapUpDetails details,
  ComicPageController controller,
);

const _animationDuration = Duration(milliseconds: 200);

/// Friction applied to pan flings; matches [InteractiveViewer]'s default.
const double _flingDrag = 0.0000135;

/// Scroll distance that zooms by a factor of e with Ctrl+wheel.
const double _wheelZoomDistance = 200;

/// A zoomable, pannable image bounded by scales relative to its fitted size.
class ComicZoomableImage extends StatefulWidget {
  const ComicZoomableImage({
    super.key,
    required this.image,
    this.controller,
    this.minScale = const ComicScale.contained(),
    this.maxScale = const ComicScale.covered(5),
    this.initialScale = const ComicScale.contained(),
    this.basePosition = Alignment.center,
    this.scaleStateCycle,
    this.backgroundDecoration,
    this.loadingBuilder,
    this.errorBuilder,
    this.onTapUp,
    this.wantKeepAlive = false,
    this.semanticLabel,
  });

  final ImageProvider image;

  /// Transform state; the widget creates and disposes its own when null.
  final ComicPageController? controller;

  final ComicScale minScale;
  final ComicScale maxScale;
  final ComicScale initialScale;

  /// Placement on any axis where the scaled image fits the viewport.
  final Alignment basePosition;

  /// Overrides the controller's double-tap cycle when non-null.
  final ComicScaleCycle? scaleStateCycle;

  /// Painted behind the image; defaults to opaque black.
  final BoxDecoration? backgroundDecoration;

  final ComicLoadingBuilder? loadingBuilder;
  final ComicErrorBuilder? errorBuilder;

  /// Called for a single tap once a double tap is ruled out.
  ///
  /// Adds a tap recognizer to the gesture arena, so leave it null when an
  /// ancestor observes taps.
  final ComicTapUpCallback? onTapUp;

  /// Keeps this page's state alive inside lazily built scrollables.
  final bool wantKeepAlive;

  final String? semanticLabel;

  @override
  State<ComicZoomableImage> createState() => _ComicZoomableImageState();
}

class _ComicZoomableImageState extends State<ComicZoomableImage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin
    implements ComicTransformAnimator {
  ComicPageController? _ownController;
  ComicPageController get _controller =>
      widget.controller ?? (_ownController ??= ComicPageController());

  late final AnimationController _animation = AnimationController.unbounded(
    vsync: this,
  )..addListener(_handleAnimationTick);
  ValueChanged<double>? _tick;

  ImageStream? _stream;
  ImageInfo? _imageInfo;
  ImageChunkEvent? _chunk;
  (Object, StackTrace?)? _error;
  late final _listener = ImageStreamListener(
    _handleImage,
    onChunk: _handleChunk,
    onError: _handleError,
  );
  bool _boundariesNotificationScheduled = false;

  double _gestureBaseScale = 1.0;
  Offset _lastFocalPoint = Offset.zero;
  bool _gestureScaled = false;
  Offset? _doubleTapPosition;

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

  @override
  void initState() {
    super.initState();
    _attach(_controller);
  }

  void _attach(ComicPageController controller) {
    controller.attachAnimator(this);
    if (widget.scaleStateCycle case final cycle?) {
      controller.scaleStateCycle = cycle;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveImage();
  }

  @override
  void didUpdateWidget(ComicZoomableImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      stopAnimation();
      (oldWidget.controller ?? _ownController)?.detachAnimator(this);
      if (oldWidget.controller == null) {
        _ownController?.dispose();
        _ownController = null;
      }
      _attach(_controller);
    } else if (widget.scaleStateCycle case final cycle?
        when cycle != oldWidget.scaleStateCycle) {
      _controller.scaleStateCycle = cycle;
    }

    if (widget.image != oldWidget.image) _resolveImage();
    if (widget.wantKeepAlive != oldWidget.wantKeepAlive) updateKeepAlive();
  }

  @override
  void dispose() {
    _stream?.removeListener(_listener);
    _imageInfo?.dispose();
    (widget.controller ?? _ownController)?.detachAnimator(this);
    _ownController?.dispose();
    _animation.dispose();
    super.dispose();
  }

  void _resolveImage() {
    final stream = widget.image.resolve(createLocalImageConfiguration(context));
    if (stream.key == _stream?.key) return;

    final previous = _stream;
    previous?.removeListener(_listener);
    _imageInfo?.dispose();
    _imageInfo = null;
    _chunk = null;
    _error = null;
    if (previous != null) _controller.clearBoundaries();

    _stream = stream..addListener(_listener);
  }

  void _handleImage(ImageInfo info, bool synchronousCall) {
    setState(() {
      _imageInfo?.dispose();
      _imageInfo = info;
      _chunk = null;
      _error = null;
    });
  }

  void _handleChunk(ImageChunkEvent event) {
    if (_imageInfo != null) return;
    setState(() => _chunk = event);
  }

  void _handleError(Object error, StackTrace? stackTrace) {
    setState(() => _error = (error, stackTrace));
  }

  /// Supplies boundaries for the laid-out viewport without notifying
  /// listeners mid-layout; they are notified after the frame instead.
  void _syncBoundaries(Size imageSize, Size viewport) {
    final boundaries = ComicBoundaries(
      imageSize: imageSize,
      viewportSize: viewport,
      minScale: widget.minScale,
      maxScale: widget.maxScale,
      initialScale: widget.initialScale,
      basePosition: widget.basePosition,
    );

    final controller = _controller;
    if (!controller.updateBoundaries(boundaries, notify: false) ||
        _boundariesNotificationScheduled) {
      return;
    }

    _boundariesNotificationScheduled = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _boundariesNotificationScheduled = false;
      if (mounted) controller.notifyBoundariesChanged();
    });
  }

  @override
  void animateTransform({required double scale, required Offset offset}) {
    final controller = _controller;
    final fromScale = controller.scale;
    final fromOffset = controller.offset;

    _tick = (t) => controller.applyTransform(
      scale: ui.lerpDouble(fromScale, scale, t)!,
      offset: Offset.lerp(fromOffset, offset, t)!,
      softScale: true,
    );
    _animation.value = 0;
    _animation.animateTo(
      1,
      duration: _animationDuration,
      curve: Curves.easeOut,
    );
  }

  @override
  void stopAnimation() {
    _animation.stop();
    _tick = null;
  }

  void _handleAnimationTick() => _tick?.call(_animation.value);

  void _fling(Offset velocity) {
    final controller = _controller;
    final speed = velocity.distance;
    final direction = velocity / speed;
    final start = controller.offset;
    final scale = controller.scale;

    _tick = (distance) {
      final before = controller.offset;
      controller.applyTransform(
        scale: scale,
        offset: start + direction * distance,
      );
      // Both axes are pinned against their bounds.
      if (distance > 0 && controller.offset == before) stopAnimation();
    };
    _animation.animateWith(FrictionSimulation(_flingDrag, 0, speed));
  }

  void _handleScaleStart(ScaleStartDetails details) {
    stopAnimation();
    _gestureBaseScale = _controller.scale;
    _lastFocalPoint = details.localFocalPoint;
    _gestureScaled = false;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    final controller = _controller;
    final boundaries = controller.boundaries;
    if (boundaries == null) return;

    if (details.scale != 1.0) _gestureScaled = true;
    final scale = boundaries.softClampScale(_gestureBaseScale * details.scale);
    // Zoom around the previous focal point, then follow its movement, so the
    // content under the fingers stays under them.
    final offset =
        boundaries.zoomOffset(
          offset: controller.offset,
          fromScale: controller.scale,
          toScale: scale,
          focalPoint: details.localFocalPoint - details.focalPointDelta,
        ) +
        details.focalPointDelta;

    controller.applyTransform(scale: scale, offset: offset, softScale: true);
    _lastFocalPoint = details.localFocalPoint;
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    final controller = _controller;
    final boundaries = controller.boundaries;
    if (boundaries == null) return;

    final target = boundaries.clampScale(controller.scale);
    if (target != controller.scale) {
      final offset = boundaries.zoomOffset(
        offset: controller.offset,
        fromScale: controller.scale,
        toScale: target,
        focalPoint: _lastFocalPoint,
      );
      animateTransform(
        scale: target,
        offset: boundaries.clampOffset(offset, target),
      );
      return;
    }

    final velocity = details.velocity.pixelsPerSecond;
    if (!_gestureScaled && velocity.distance >= kMinFlingVelocity) {
      _fling(velocity);
    }
  }

  bool _canPan(Axis axis, double delta) {
    final controller = _controller;
    return controller.boundaries?.canPan(
          controller.offset,
          controller.scale,
          axis,
          delta,
        ) ??
        false;
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapPosition = details.localPosition;
  }

  void _handleDoubleTap() {
    _controller.cycleScale(focalPoint: _doubleTapPosition);
  }

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;
    final controller = _controller;
    final boundaries = controller.boundaries;
    if (boundaries == null) return;
    final resolver = GestureBinding.instance.pointerSignalResolver;

    if (HardwareKeyboard.instance.isControlPressed) {
      resolver.register(event, (_) {
        stopAnimation();
        final target = boundaries.clampScale(
          controller.scale *
              math.exp(-event.scrollDelta.dy / _wheelZoomDistance),
        );
        final offset = boundaries.zoomOffset(
          offset: controller.offset,
          fromScale: controller.scale,
          toScale: target,
          focalPoint: event.localPosition,
        );
        controller.applyTransform(scale: target, offset: offset);
      });
      return;
    }

    // Leave the wheel to an enclosing scrollable unless the image can pan.
    final delta = -event.scrollDelta;
    final (axis, component) = delta.dx.abs() > delta.dy.abs()
        ? (Axis.horizontal, delta.dx)
        : (Axis.vertical, delta.dy);
    if (!boundaries.canPan(
      controller.offset,
      controller.scale,
      axis,
      component,
    )) {
      return;
    }
    resolver.register(event, (_) => controller.panBy(delta));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = _controller;
    final info = _imageInfo;
    final onTapUp = widget.onTapUp;
    final pagerAxis = ComicGalleryScope.maybeOf(context)?.axis;

    final Widget content;
    if (_error case (final error, final stackTrace)) {
      content =
          widget.errorBuilder?.call(context, error, stackTrace) ??
          const ComicDefaultError();
    } else if (info == null) {
      content =
          widget.loadingBuilder?.call(context, _chunk) ??
          ComicDefaultLoading(event: _chunk);
    } else {
      final image = info.image;
      final imageSize = Size(
        image.width / info.scale,
        image.height / info.scale,
      );

      content = LayoutBuilder(
        builder: (context, constraints) {
          final viewport = constraints.biggest;
          if (!viewport.isFinite || viewport.isEmpty || imageSize.isEmpty) {
            return const SizedBox.shrink();
          }

          _syncBoundaries(imageSize, viewport);
          return ListenableBuilder(
            listenable: controller,
            builder: (context, _) => _TransformedImage(
              image: image,
              imageScale: info.scale,
              imageSize: imageSize,
              scale: controller.scale,
              offset: controller.offset,
            ),
          );
        },
      );
    }

    return Semantics(
      image: true,
      label: widget.semanticLabel,
      child: DecoratedBox(
        decoration:
            widget.backgroundDecoration ??
            const BoxDecoration(color: Color(0xFF000000)),
        child: Listener(
          onPointerSignal: _handlePointerSignal,
          child: RawGestureDetector(
            behavior: HitTestBehavior.opaque,
            gestures: {
              DoubleTapGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                    DoubleTapGestureRecognizer
                  >(() => DoubleTapGestureRecognizer(debugOwner: this), (
                    instance,
                  ) {
                    instance
                      ..onDoubleTapDown = _handleDoubleTapDown
                      ..onDoubleTap = _handleDoubleTap;
                  }),
              if (onTapUp != null)
                TapGestureRecognizer:
                    GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
                      () => TapGestureRecognizer(debugOwner: this),
                      (instance) =>
                          instance.onTapUp = (details) =>
                              onTapUp(context, details, _controller),
                    ),
              ComicZoomGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                    ComicZoomGestureRecognizer
                  >(() => ComicZoomGestureRecognizer(debugOwner: this), (
                    instance,
                  ) {
                    instance
                      ..pagerAxis = pagerAxis
                      ..canPan = _canPan
                      ..dragStartBehavior = DragStartBehavior.start
                      ..onStart = _handleScaleStart
                      ..onUpdate = _handleScaleUpdate
                      ..onEnd = _handleScaleEnd;
                  }),
            },
            child: content,
          ),
        ),
      ),
    );
  }
}

/// Paints [image] at [scale], translated by [offset] from the centre.
class _TransformedImage extends StatelessWidget {
  const _TransformedImage({
    required this.image,
    required this.imageScale,
    required this.imageSize,
    required this.scale,
    required this.offset,
  });

  final ui.Image image;
  final double imageScale;
  final Size imageSize;
  final double scale;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(scale, scale, 1)
          ..setTranslationRaw(offset.dx, offset.dy, 0),
        child: OverflowBox(
          minWidth: imageSize.width,
          maxWidth: imageSize.width,
          minHeight: imageSize.height,
          maxHeight: imageSize.height,
          child: RawImage(
            image: image,
            width: imageSize.width,
            height: imageSize.height,
            scale: imageScale,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.medium,
          ),
        ),
      ),
    );
  }
}
