import 'package:comic_page_view/comic_page_view.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

ComicBoundaries _boundaries({
  Size image = const Size(800, 1200),
  Size viewport = const Size(400, 800),
  ComicScale minScale = const ComicScale.contained(),
  ComicScale maxScale = const ComicScale.covered(5),
  ComicScale initialScale = const ComicScale.contained(),
  Alignment basePosition = Alignment.center,
}) {
  return ComicBoundaries(
    imageSize: image,
    viewportSize: viewport,
    minScale: minScale,
    maxScale: maxScale,
    initialScale: initialScale,
    basePosition: basePosition,
  );
}

void main() {
  group('fitted scales', () {
    const cases = <(String, Size, Size, double, double)>[
      // (name, image, viewport, contained, covered)
      (
        'portrait image, portrait viewport',
        Size(800, 1200),
        Size(400, 800),
        0.5,
        800 / 1200,
      ),
      (
        'portrait image, landscape viewport',
        Size(800, 1200),
        Size(800, 400),
        400 / 1200,
        1.0,
      ),
      (
        'landscape image, portrait viewport',
        Size(1200, 800),
        Size(400, 800),
        400 / 1200,
        1.0,
      ),
      (
        'landscape image, landscape viewport',
        Size(1200, 800),
        Size(800, 400),
        0.5,
        800 / 1200,
      ),
      (
        'square image, portrait viewport',
        Size(1000, 1000),
        Size(400, 800),
        0.4,
        0.8,
      ),
      (
        'square image, landscape viewport',
        Size(1000, 1000),
        Size(800, 400),
        0.4,
        0.8,
      ),
    ];

    for (final (name, image, viewport, contained, covered) in cases) {
      test(name, () {
        final b = _boundaries(image: image, viewport: viewport);
        expect(b.containedScale, closeTo(contained, 1e-9));
        expect(b.coveredScale, closeTo(covered, 1e-9));
      });
    }
  });

  test('resolves relative and absolute scale specs', () {
    final b = _boundaries(
      minScale: const ComicScale.contained(0.8),
      maxScale: const ComicScale.covered() * 5,
      initialScale: const ComicScale.absolute(0.6),
    );

    expect(b.minScale, closeTo(0.4, 1e-9));
    expect(b.maxScale, closeTo(800 / 1200 * 5, 1e-9));
    expect(b.initialScale, closeTo(0.6, 1e-9));
  });

  test('normalizes max below min and clamps initial into range', () {
    final b = _boundaries(
      minScale: const ComicScale.covered(),
      maxScale: const ComicScale.contained(),
      initialScale: const ComicScale.contained(0.5),
    );

    expect(b.maxScale, b.minScale);
    expect(b.initialScale, b.minScale);
  });

  test('soft clamp allows a bounded overshoot', () {
    final b = _boundaries();

    expect(b.clampScale(0.1), b.minScale);
    expect(
      b.softClampScale(b.minScale * 0.95),
      closeTo(b.minScale * 0.95, 1e-9),
    );
    expect(b.softClampScale(0.01), closeTo(b.minScale * 0.9, 1e-9));
    expect(b.softClampScale(100), closeTo(b.maxScale * 1.1, 1e-9));
  });

  group('offset clamping', () {
    test('centres an axis where the image fits', () {
      final b = _boundaries();

      expect(
        b.clampOffset(const Offset(50, -70), b.containedScale),
        Offset.zero,
      );
    });

    test('applies the base position on fitting axes', () {
      final b = _boundaries(basePosition: Alignment.topLeft);
      // Contained 0.5: 400x600 inside 400x800 leaves 200 of vertical slack.
      expect(b.clampOffset(Offset.zero, 0.5), const Offset(0, -100));
    });

    test('limits each axis to the overflow when larger than the viewport', () {
      final b = _boundaries();
      // At 1.0 the 800x1200 image overflows 400x800 by 400x400.
      expect(
        b.clampOffset(const Offset(500, -500), 1.0),
        const Offset(200, -200),
      );
      expect(b.clampOffset(const Offset(50, 60), 1.0), const Offset(50, 60));
    });

    test('mixes fitting and overflowing axes', () {
      final b = _boundaries(
        image: const Size(1000, 500),
        viewport: const Size(400, 800),
      );
      // At 0.8: 800x400; width overflows by 400, height fits.
      expect(
        b.clampOffset(const Offset(-900, 300), 0.8),
        const Offset(-200, 0),
      );
    });
  });

  group('edges', () {
    test('both ends are visible when the image fits', () {
      final b = _boundaries();

      expect(b.edgesAt(Offset.zero, 0.5, Axis.horizontal), (
        start: true,
        end: true,
      ));
      expect(b.canPan(Offset.zero, 0.5, Axis.horizontal, 10), isFalse);
      expect(b.canPan(Offset.zero, 0.5, Axis.horizontal, -10), isFalse);
    });

    test('reports the visible end of an overflowing axis', () {
      final b = _boundaries();

      expect(b.edgesAt(Offset.zero, 1.0, Axis.horizontal), (
        start: false,
        end: false,
      ));
      // Offset +200 shifts the image right, showing its left (start) edge.
      expect(b.edgesAt(const Offset(200, 0), 1.0, Axis.horizontal), (
        start: true,
        end: false,
      ));
      expect(b.edgesAt(const Offset(-200, 0), 1.0, Axis.horizontal), (
        start: false,
        end: true,
      ));
      expect(b.edgesAt(const Offset(0, -200), 1.0, Axis.vertical), (
        start: false,
        end: true,
      ));
    });

    test('panning is allowed only away from a visible edge', () {
      final b = _boundaries();
      const atStart = Offset(200, 0);

      expect(b.canPan(atStart, 1.0, Axis.horizontal, 10), isFalse);
      expect(b.canPan(atStart, 1.0, Axis.horizontal, -10), isTrue);
      expect(b.canPan(atStart, 1.0, Axis.horizontal, 0), isFalse);
      expect(b.canPan(Offset.zero, 1.0, Axis.vertical, 10), isTrue);
    });
  });

  test('focal zoom keeps the point under the focal fixed', () {
    final b = _boundaries();
    const offset = Offset(30, -40);
    const focal = Offset(100, 650);
    const from = 0.8;
    const to = 2.0;
    final center = b.viewportSize.center(Offset.zero);

    // Image-space coordinate under the focal point before and after.
    Offset imagePoint(Offset offset, double scale) =>
        (focal - center - offset) / scale;

    final zoomed = b.zoomOffset(
      offset: offset,
      fromScale: from,
      toScale: to,
      focalPoint: focal,
    );

    final before = imagePoint(offset, from);
    final after = imagePoint(zoomed, to);
    expect(after.dx, closeTo(before.dx, 1e-9));
    expect(after.dy, closeTo(before.dy, 1e-9));
  });

  group('scale states', () {
    test('maps scales to named and free states', () {
      final b = _boundaries(image: const Size(300, 450));
      // contained 4/3 (width-bound 400/300), covered 800/450.

      expect(b.scaleStateFor(b.initialScale), ComicScaleState.initial);
      expect(b.scaleStateFor(b.coveredScale), ComicScaleState.covering);
      expect(b.scaleStateFor(b.coveredScale * 1.5), ComicScaleState.zoomedIn);
    });

    test('maps original size and zoomed-out scales', () {
      final b = _boundaries(minScale: const ComicScale.contained(0.5));

      expect(b.scaleStateFor(1.0), ComicScaleState.originalSize);
      expect(b.scaleStateFor(0.3), ComicScaleState.zoomedOut);
    });

    test('initial wins when named scales coincide', () {
      final b = _boundaries(
        image: const Size(400, 800),
        viewport: const Size(400, 800),
      );

      expect(b.scaleStateFor(1.0), ComicScaleState.initial);
    });

    test('named states resolve to clamped scales', () {
      final b = _boundaries(
        image: const Size(4000, 6000),
        maxScale: const ComicScale.covered(),
      );

      expect(b.scaleFor(ComicScaleState.initial), b.initialScale);
      expect(b.scaleFor(ComicScaleState.covering), b.coveredScale);
      expect(b.scaleFor(ComicScaleState.originalSize), b.maxScale);
      expect(b.scaleFor(ComicScaleState.zoomedIn), isNull);
    });

    test('default cycle', () {
      expect(
        defaultComicScaleCycle(ComicScaleState.initial),
        ComicScaleState.covering,
      );
      expect(
        defaultComicScaleCycle(ComicScaleState.covering),
        ComicScaleState.originalSize,
      );
      expect(
        defaultComicScaleCycle(ComicScaleState.originalSize),
        ComicScaleState.initial,
      );
      expect(
        defaultComicScaleCycle(ComicScaleState.zoomedIn),
        ComicScaleState.initial,
      );
      expect(
        defaultComicScaleCycle(ComicScaleState.zoomedOut),
        ComicScaleState.initial,
      );
    });
  });

  test('copyWith re-resolves scale specs for a new viewport', () {
    final b = _boundaries(maxScale: const ComicScale.covered(5));
    final rotated = b.copyWith(viewportSize: const Size(800, 400));

    expect(rotated.containedScale, closeTo(400 / 1200, 1e-9));
    expect(rotated.coveredScale, closeTo(1.0, 1e-9));
    expect(rotated.minScale, rotated.containedScale);
    expect(rotated.maxScale, closeTo(5.0, 1e-9));
    expect(rotated.initialScale, rotated.containedScale);
    expect(rotated, isNot(b));
    expect(b.copyWith(), b);
  });

  test('scale specs compare by value', () {
    expect(const ComicScale.covered() * 5, const ComicScale.covered(5));
    expect(
      const ComicScale.contained(0.8),
      isNot(const ComicScale.covered(0.8)),
    );
    expect(const ComicScale.absolute(2) * 0.5, const ComicScale.absolute(1));
  });
}
