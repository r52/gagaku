import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// Tells descendant zoomable images that they share drags with a pager
/// scrolling along [axis].
///
/// [ComicPageGallery] provides this. Wrap another paged scrollable in it so
/// its [ComicZoomableImage]s yield drags the image cannot use.
class ComicGalleryScope extends InheritedWidget {
  const ComicGalleryScope({
    super.key,
    required this.axis,
    required super.child,
  });

  final Axis axis;

  static ComicGalleryScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ComicGalleryScope>();

  @override
  bool updateShouldNotify(ComicGalleryScope oldWidget) =>
      axis != oldWidget.axis;
}

/// Whether the image can pan by [delta] along [axis].
typedef ComicCanPan = bool Function(Axis axis, double delta);

/// Scale recognizer that yields single-pointer drags the image cannot use to
/// an enclosing pager.
///
/// Without a [pagerAxis] it behaves like [ScaleGestureRecognizer]. With one:
///
/// - A second pointer or a trackpad pinch claims the gesture.
/// - A single pointer is undecided until it moves beyond the touch slop,
///   which is the distance at which the pager's drag recognizer claims it.
///   A drag mostly along [pagerAxis] is then claimed only if [canPan]
///   allows it, otherwise the recognizer rejects so the pager wins. Any
///   other drag is claimed.
class ComicZoomGestureRecognizer extends ScaleGestureRecognizer {
  ComicZoomGestureRecognizer({super.debugOwner});

  Axis? pagerAxis;
  ComicCanPan? canPan;

  final Map<int, Offset> _downPositions = {};
  bool _decided = false;

  /// Minimum scale change that marks a trackpad gesture as a pinch.
  static const double _trackpadScaleSlop = 0.05;

  @override
  void addAllowedPointer(PointerDownEvent event) {
    final multiPointer = _downPositions.isNotEmpty;
    _downPositions[event.pointer] = event.position;
    super.addAllowedPointer(event);
    if (pagerAxis != null && multiPointer) _decide(accept: true);
  }

  @override
  void handleEvent(PointerEvent event) {
    if (pagerAxis != null && !_decided) {
      switch (event) {
        case PointerMoveEvent() when _downPositions.length == 1:
          final down = _downPositions[event.pointer];
          if (down != null &&
              _resolveDrag(event.position - down, event.kind) == false) {
            return;
          }
        case PointerPanZoomUpdateEvent():
          if ((event.scale - 1).abs() > _trackpadScaleSlop) {
            _decide(accept: true);
          } else if (_resolveDrag(event.pan, event.kind) == false) {
            return;
          }
        default:
      }
    }

    if (event is PointerUpEvent || event is PointerCancelEvent) {
      _downPositions.remove(event.pointer);
    }
    super.handleEvent(event);
  }

  /// Decides a drag of [delta] once it passes the touch slop.
  ///
  /// Returns `false` if the gesture was rejected, `true` if accepted, and
  /// `null` while undecided.
  bool? _resolveDrag(Offset delta, PointerDeviceKind kind) {
    if (delta.distance <= computeHitSlop(kind, gestureSettings)) return null;

    final (main, cross) = switch (pagerAxis!) {
      Axis.horizontal => (delta.dx, delta.dy),
      Axis.vertical => (delta.dy, delta.dx),
    };
    final accept =
        main.abs() <= cross.abs() || (canPan?.call(pagerAxis!, main) ?? false);
    _decide(accept: accept);
    return accept;
  }

  void _decide({required bool accept}) {
    _decided = true;
    resolve(accept ? GestureDisposition.accepted : GestureDisposition.rejected);
  }

  @override
  void rejectGesture(int pointer) {
    _downPositions.remove(pointer);
    super.rejectGesture(pointer);
  }

  @override
  void didStopTrackingLastPointer(int pointer) {
    _downPositions.clear();
    _decided = false;
    super.didStopTrackingLastPointer(pointer);
  }

  @override
  String get debugDescription => 'comic zoom';
}
