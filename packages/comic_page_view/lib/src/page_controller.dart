import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'boundaries.dart';
import 'scale.dart';

/// Animates a [ComicPageController] toward a target transform.
///
/// Implemented by the widget displaying the page, which owns the ticker.
abstract interface class ComicTransformAnimator {
  void animateTransform({required double scale, required Offset offset});

  /// Stops any running animation, leaving the current transform in place.
  void stopAnimation();
}

/// Scale and translation of one zoomable page.
///
/// Transform changes are ignored until the displaying widget supplies
/// [boundaries], which needs the image's intrinsic size and the viewport.
class ComicPageController extends ChangeNotifier {
  ComicPageController({this.scaleStateCycle = defaultComicScaleCycle});

  /// Order of named states visited by [cycleScale].
  ComicScaleCycle scaleStateCycle;

  ComicBoundaries? _boundaries;
  double _scale = 1.0;
  Offset _offset = Offset.zero;
  ComicTransformAnimator? _animator;

  ComicBoundaries? get boundaries => _boundaries;

  /// Multiplier on the image's logical size.
  double get scale => _scale;

  /// Translation of the image centre from the viewport centre.
  Offset get offset => _offset;

  ComicScaleState get scaleState =>
      _boundaries?.scaleStateFor(_scale) ?? ComicScaleState.initial;

  /// Pans by [delta], clamped to the boundaries.
  void panBy(Offset delta) {
    final boundaries = _boundaries;
    if (boundaries == null) return;
    _animator?.stopAnimation();
    _set(_scale, boundaries.clampOffset(_offset + delta, _scale));
  }

  /// Moves to the next distinct state in [scaleStateCycle].
  ///
  /// States resolving to the current scale are skipped so the scale always
  /// visibly changes when another state differs. [focalPoint] is the
  /// viewport-local point kept fixed; it defaults to the viewport centre.
  void cycleScale({Offset? focalPoint, bool animate = true}) {
    final boundaries = _boundaries;
    if (boundaries == null) return;

    var state = scaleState;
    for (var i = 0; i < ComicScaleState.values.length; i++) {
      state = scaleStateCycle(state);
      final target = boundaries.scaleFor(state);
      if (target != null && !ComicBoundaries.scalesEqual(target, _scale)) {
        _moveToScale(target, focalPoint: focalPoint, animate: animate);
        return;
      }
    }
  }

  /// Moves to the scale of a named [state].
  void setScaleState(
    ComicScaleState state, {
    Offset? focalPoint,
    bool animate = true,
  }) {
    assert(state.isNamed, 'only named states have a fixed scale');
    final target = _boundaries?.scaleFor(state);
    if (target == null) return;
    _moveToScale(target, focalPoint: focalPoint, animate: animate);
  }

  /// Returns to the initial scale and base position.
  void reset({bool animate = false}) {
    final boundaries = _boundaries;
    if (boundaries == null) return;
    final scale = boundaries.initialScale;
    _transition(scale, boundaries.clampOffset(Offset.zero, scale), animate);
  }

  void _moveToScale(
    double target, {
    required Offset? focalPoint,
    required bool animate,
  }) {
    final boundaries = _boundaries!;
    final focal = focalPoint ?? boundaries.viewportSize.center(Offset.zero);
    final offset = boundaries.zoomOffset(
      offset: _offset,
      fromScale: _scale,
      toScale: target,
      focalPoint: focal,
    );
    _transition(target, boundaries.clampOffset(offset, target), animate);
  }

  void _transition(double scale, Offset offset, bool animate) {
    final animator = _animator;
    if (animate && animator != null) {
      animator.animateTransform(scale: scale, offset: offset);
    } else {
      _animator?.stopAnimation();
      _set(scale, offset);
    }
  }

  /// Applies boundaries for a newly resolved image or resized viewport.
  ///
  /// The first boundaries start the page at its initial scale. Later updates
  /// keep a named scale state, or the scale relative to the contained scale,
  /// and keep the offset proportional before clamping.
  ///
  /// Returns whether the boundaries changed. With [notify] false, listeners
  /// are not called; the caller must call [notifyBoundariesChanged] later.
  /// Layout uses this to avoid notifying listeners mid-frame.
  @internal
  bool updateBoundaries(ComicBoundaries boundaries, {bool notify = true}) {
    final previous = _boundaries;
    if (previous == boundaries) return false;
    _boundaries = boundaries;

    final double scale;
    final Offset offset;
    if (previous == null) {
      scale = boundaries.initialScale;
      offset = Offset.zero;
    } else {
      scale =
          boundaries.scaleFor(previous.scaleStateFor(_scale)) ??
          boundaries.clampScale(
            _scale / previous.containedScale * boundaries.containedScale,
          );
      offset = _offset * (scale / _scale);
    }

    _scale = scale;
    _offset = boundaries.clampOffset(offset, scale);
    if (notify) notifyListeners();
    return true;
  }

  /// Notifies listeners after a silent [updateBoundaries].
  @internal
  void notifyBoundariesChanged() => notifyListeners();

  /// Forgets the boundaries so the next [updateBoundaries] starts the page
  /// over at its initial scale. Used when the displayed image changes.
  @internal
  void clearBoundaries() {
    _animator?.stopAnimation();
    _boundaries = null;
  }

  /// Sets the transform from gesture or animation input.
  ///
  /// The offset is always clamped. With [softScale], the scale may overshoot
  /// its bounds by the pinch allowance.
  @internal
  void applyTransform({
    required double scale,
    required Offset offset,
    bool softScale = false,
  }) {
    final boundaries = _boundaries;
    if (boundaries == null) return;
    final clampedScale = softScale
        ? boundaries.softClampScale(scale)
        : boundaries.clampScale(scale);
    _set(clampedScale, boundaries.clampOffset(offset, clampedScale));
  }

  @internal
  void attachAnimator(ComicTransformAnimator animator) {
    assert(_animator == null, 'a controller drives one page at a time');
    _animator = animator;
  }

  @internal
  void detachAnimator(ComicTransformAnimator animator) {
    if (identical(_animator, animator)) _animator = null;
  }

  void _set(double scale, Offset offset) {
    if (scale == _scale && offset == _offset) return;
    _scale = scale;
    _offset = offset;
    notifyListeners();
  }

  @override
  void dispose() {
    _animator = null;
    super.dispose();
  }
}
