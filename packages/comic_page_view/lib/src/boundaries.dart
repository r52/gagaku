import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'scale.dart';

/// Relative tolerance used when comparing scales.
const double _scaleEpsilon = 1e-3;

/// Fraction a pinch may overshoot the scale bounds before the result is
/// animated back.
const double _scaleOvershoot = 0.1;

/// Which ends of the image are visible along one axis.
///
/// When the image fits within the viewport on that axis, both ends are
/// visible.
typedef ComicAxisEdges = ({bool start, bool end});

/// Scale and translation limits for one image in one viewport.
///
/// Offsets are the translation of the image centre from the viewport centre,
/// in logical pixels. Scales multiply the image's logical size.
@immutable
class ComicBoundaries {
  factory ComicBoundaries({
    required Size imageSize,
    required Size viewportSize,
    ComicScale minScale = const ComicScale.contained(),
    ComicScale maxScale = const ComicScale.covered(5),
    ComicScale initialScale = const ComicScale.contained(),
    Alignment basePosition = Alignment.center,
  }) {
    assert(!imageSize.isEmpty, 'imageSize must not be empty');
    assert(!viewportSize.isEmpty, 'viewportSize must not be empty');

    final widthRatio = viewportSize.width / imageSize.width;
    final heightRatio = viewportSize.height / imageSize.height;
    final contained = math.min(widthRatio, heightRatio);
    final covered = math.max(widthRatio, heightRatio);

    double resolve(ComicScale scale) =>
        scale.resolve(contained: contained, covered: covered);

    final min = resolve(minScale);
    final max = math.max(min, resolve(maxScale));

    return ComicBoundaries._(
      imageSize: imageSize,
      viewportSize: viewportSize,
      containedScale: contained,
      coveredScale: covered,
      minScale: min,
      maxScale: max,
      initialScale: resolve(initialScale).clamp(min, max),
      basePosition: basePosition,
      minScaleSpec: minScale,
      maxScaleSpec: maxScale,
      initialScaleSpec: initialScale,
    );
  }

  const ComicBoundaries._({
    required this.imageSize,
    required this.viewportSize,
    required this.containedScale,
    required this.coveredScale,
    required this.minScale,
    required this.maxScale,
    required this.initialScale,
    required this.basePosition,
    required this._minScaleSpec,
    required this._maxScaleSpec,
    required this._initialScaleSpec,
  });

  final ComicScale _minScaleSpec;
  final ComicScale _maxScaleSpec;
  final ComicScale _initialScaleSpec;

  /// Logical size of the image at scale `1.0`.
  final Size imageSize;
  final Size viewportSize;

  /// Scale at which the whole image fits the viewport.
  final double containedScale;

  /// Scale at which the image fills the viewport.
  final double coveredScale;

  final double minScale;
  final double maxScale;
  final double initialScale;

  /// Placement on any axis where the scaled image fits the viewport.
  final Alignment basePosition;

  /// Scale painting one image pixel per logical pixel.
  double get originalScale => 1.0;

  double clampScale(double scale) => scale.clamp(minScale, maxScale);

  /// Clamps [scale] to the bounds widened by the pinch overshoot allowance.
  double softClampScale(double scale) => scale.clamp(
    minScale * (1 - _scaleOvershoot),
    maxScale * (1 + _scaleOvershoot),
  );

  /// Clamps [offset] so the image at [scale] never leaves the viewport.
  ///
  /// On an axis where the image fits, the offset is fixed by [basePosition].
  Offset clampOffset(Offset offset, double scale) {
    return Offset(
      _clampAxis(
        offset.dx,
        imageSize.width * scale,
        viewportSize.width,
        basePosition.x,
      ),
      _clampAxis(
        offset.dy,
        imageSize.height * scale,
        viewportSize.height,
        basePosition.y,
      ),
    );
  }

  static double _clampAxis(
    double offset,
    double childExtent,
    double viewportExtent,
    double alignment,
  ) {
    final slack = viewportExtent - childExtent;
    if (slack >= 0) return alignment * slack / 2;
    final limit = -slack / 2;
    return offset.clamp(-limit, limit);
  }

  /// Which ends of the image are visible on [axis] at [offset] and [scale].
  ComicAxisEdges edgesAt(Offset offset, double scale, Axis axis) {
    final (value, childExtent, viewportExtent) = switch (axis) {
      Axis.horizontal => (
        offset.dx,
        imageSize.width * scale,
        viewportSize.width,
      ),
      Axis.vertical => (
        offset.dy,
        imageSize.height * scale,
        viewportSize.height,
      ),
    };

    final limit = (childExtent - viewportExtent) / 2;
    if (limit <= precisionErrorTolerance) return (start: true, end: true);

    // A positive offset shifts the image toward the end, revealing its start.
    return (
      start: value >= limit - precisionErrorTolerance,
      end: value <= -limit + precisionErrorTolerance,
    );
  }

  /// Whether panning by [delta] along [axis] would move the image.
  bool canPan(Offset offset, double scale, Axis axis, double delta) {
    if (delta == 0) return false;
    final edges = edgesAt(offset, scale, axis);
    return delta > 0 ? !edges.start : !edges.end;
  }

  /// The offset keeping the content under [focalPoint] fixed when the scale
  /// changes from [fromScale] to [toScale].
  ///
  /// [focalPoint] is in viewport-local coordinates. The result is unclamped.
  Offset zoomOffset({
    required Offset offset,
    required double fromScale,
    required double toScale,
    required Offset focalPoint,
  }) {
    final focal = focalPoint - viewportSize.center(Offset.zero);
    return focal - (focal - offset) * (toScale / fromScale);
  }

  /// The scale for a named [state], or `null` for free-zoom states.
  double? scaleFor(ComicScaleState state) {
    return switch (state) {
      ComicScaleState.initial => initialScale,
      ComicScaleState.covering => clampScale(coveredScale),
      ComicScaleState.originalSize => clampScale(originalScale),
      ComicScaleState.zoomedIn || ComicScaleState.zoomedOut => null,
    };
  }

  /// The state best describing [scale].
  ComicScaleState scaleStateFor(double scale) {
    if (scalesEqual(scale, initialScale)) return ComicScaleState.initial;
    if (scalesEqual(scale, coveredScale)) return ComicScaleState.covering;
    if (scalesEqual(scale, originalScale)) return ComicScaleState.originalSize;
    return scale > initialScale
        ? ComicScaleState.zoomedIn
        : ComicScaleState.zoomedOut;
  }

  /// Whether [a] and [b] are the same scale within a relative tolerance.
  static bool scalesEqual(double a, double b) =>
      (a - b).abs() <= _scaleEpsilon * math.max(a.abs(), b.abs());

  /// These boundaries re-resolved for a different image or viewport size.
  ComicBoundaries copyWith({Size? imageSize, Size? viewportSize}) {
    return ComicBoundaries(
      imageSize: imageSize ?? this.imageSize,
      viewportSize: viewportSize ?? this.viewportSize,
      minScale: _minScaleSpec,
      maxScale: _maxScaleSpec,
      initialScale: _initialScaleSpec,
      basePosition: basePosition,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ComicBoundaries &&
      other.imageSize == imageSize &&
      other.viewportSize == viewportSize &&
      other.minScale == minScale &&
      other.maxScale == maxScale &&
      other.initialScale == initialScale &&
      other.basePosition == basePosition;

  @override
  int get hashCode => Object.hash(
    imageSize,
    viewportSize,
    minScale,
    maxScale,
    initialScale,
    basePosition,
  );
}
