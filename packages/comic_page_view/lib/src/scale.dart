import 'package:flutter/foundation.dart';

/// A scale expressed relative to an image's fitted sizes.
///
/// Resolved against [ComicBoundaries] once both the image and viewport sizes
/// are known.
@immutable
sealed class ComicScale {
  const ComicScale();

  /// [factor] times the scale at which the whole image fits the viewport.
  const factory ComicScale.contained([double factor]) = ContainedScale;

  /// [factor] times the scale at which the image fills the viewport.
  const factory ComicScale.covered([double factor]) = CoveredScale;

  /// A fixed scale, where `1.0` paints one image pixel per logical pixel.
  const factory ComicScale.absolute(double value) = AbsoluteScale;

  ComicScale operator *(double factor);

  double resolve({required double contained, required double covered});
}

final class ContainedScale extends ComicScale {
  const ContainedScale([this.factor = 1.0]);

  final double factor;

  @override
  ContainedScale operator *(double factor) =>
      ContainedScale(this.factor * factor);

  @override
  double resolve({required double contained, required double covered}) =>
      contained * factor;

  @override
  bool operator ==(Object other) =>
      other is ContainedScale && other.factor == factor;

  @override
  int get hashCode => Object.hash(ContainedScale, factor);

  @override
  String toString() => 'ComicScale.contained($factor)';
}

final class CoveredScale extends ComicScale {
  const CoveredScale([this.factor = 1.0]);

  final double factor;

  @override
  CoveredScale operator *(double factor) => CoveredScale(this.factor * factor);

  @override
  double resolve({required double contained, required double covered}) =>
      covered * factor;

  @override
  bool operator ==(Object other) =>
      other is CoveredScale && other.factor == factor;

  @override
  int get hashCode => Object.hash(CoveredScale, factor);

  @override
  String toString() => 'ComicScale.covered($factor)';
}

final class AbsoluteScale extends ComicScale {
  const AbsoluteScale(this.value);

  final double value;

  @override
  AbsoluteScale operator *(double factor) => AbsoluteScale(value * factor);

  @override
  double resolve({required double contained, required double covered}) => value;

  @override
  bool operator ==(Object other) =>
      other is AbsoluteScale && other.value == value;

  @override
  int get hashCode => Object.hash(AbsoluteScale, value);

  @override
  String toString() => 'ComicScale.absolute($value)';
}

/// Named positions in the double-tap cycle, plus the free-zoom states.
enum ComicScaleState {
  /// The configured initial scale.
  initial,

  /// The image fills the viewport.
  covering,

  /// One image pixel per logical pixel.
  originalSize,

  /// Freely zoomed above the initial scale.
  zoomedIn,

  /// Freely zoomed below the initial scale.
  zoomedOut;

  /// Whether this state corresponds to a fixed, recomputable scale.
  bool get isNamed => switch (this) {
    initial || covering || originalSize => true,
    zoomedIn || zoomedOut => false,
  };
}

/// Returns the state that follows [current] in the double-tap cycle.
typedef ComicScaleCycle = ComicScaleState Function(ComicScaleState current);

/// `initial → covering → originalSize → initial`; free zoom returns to
/// `initial`.
ComicScaleState defaultComicScaleCycle(ComicScaleState current) {
  return switch (current) {
    ComicScaleState.initial => ComicScaleState.covering,
    ComicScaleState.covering => ComicScaleState.originalSize,
    ComicScaleState.originalSize ||
    ComicScaleState.zoomedIn ||
    ComicScaleState.zoomedOut => ComicScaleState.initial,
  };
}
