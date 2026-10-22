import 'package:comic_page_view/comic_page_view.dart';
import 'package:comic_page_view/src/page_controller.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

ComicBoundaries _boundaries({
  Size image = const Size(800, 1200),
  Size viewport = const Size(400, 800),
  ComicScale maxScale = const ComicScale.covered(5),
}) {
  return ComicBoundaries(
    imageSize: image,
    viewportSize: viewport,
    maxScale: maxScale,
  );
}

class _RecordingAnimator implements ComicTransformAnimator {
  final targets = <(double, Offset)>[];
  var stops = 0;

  @override
  void animateTransform({required double scale, required Offset offset}) {
    targets.add((scale, offset));
  }

  @override
  void stopAnimation() => stops++;
}

void main() {
  late ComicPageController controller;
  late int notifications;

  setUp(() {
    controller = ComicPageController();
    notifications = 0;
    controller.addListener(() => notifications++);
  });

  tearDown(() => controller.dispose());

  test('ignores transform commands until boundaries are known', () {
    controller.panBy(const Offset(10, 10));
    controller.cycleScale(animate: false);
    controller.reset();

    expect(controller.boundaries, isNull);
    expect(controller.scaleState, ComicScaleState.initial);
    expect(notifications, 0);
  });

  test('first boundaries start at the initial scale and base position', () {
    controller.updateBoundaries(_boundaries());

    expect(controller.scale, 0.5);
    expect(controller.offset, Offset.zero);
    expect(controller.scaleState, ComicScaleState.initial);
    expect(notifications, 1);

    controller.updateBoundaries(_boundaries());
    expect(notifications, 1, reason: 'equal boundaries are a no-op');
  });

  test('panBy clamps and does not notify when nothing moves', () {
    controller.updateBoundaries(_boundaries());

    controller.panBy(const Offset(0, 100));
    expect(controller.offset, Offset.zero, reason: 'contained image is fixed');
    expect(notifications, 1);

    controller.applyTransform(scale: 1.0, offset: Offset.zero);
    controller.panBy(const Offset(-50, 500));
    expect(controller.offset, const Offset(-50, 200));
  });

  test('cycleScale follows the default cycle around the focal point', () {
    controller.updateBoundaries(_boundaries());
    final b = controller.boundaries!;

    controller.cycleScale(animate: false);
    expect(controller.scaleState, ComicScaleState.covering);
    expect(controller.scale, closeTo(b.coveredScale, 1e-9));

    controller.cycleScale(focalPoint: const Offset(0, 0), animate: false);
    expect(controller.scaleState, ComicScaleState.originalSize);
    expect(controller.scale, 1.0);
    // The top-left corner stays put: x is free, y reaches the top edge.
    expect(controller.offset, const Offset(100, 200));

    controller.cycleScale(animate: false);
    expect(controller.scaleState, ComicScaleState.initial);
    expect(controller.offset, Offset.zero);
  });

  test('cycleScale skips states that resolve to the current scale', () {
    // Contained and covered coincide at 0.5 for this image and viewport.
    controller.updateBoundaries(
      _boundaries(image: const Size(800, 1600), viewport: const Size(400, 800)),
    );
    expect(controller.scale, 0.5);

    controller.cycleScale(animate: false);
    expect(controller.scaleState, ComicScaleState.originalSize);
    expect(controller.scale, 1.0);

    controller.cycleScale(animate: false);
    expect(controller.scaleState, ComicScaleState.initial);
  });

  test('cycleScale is a no-op when every state has the same scale', () {
    controller.updateBoundaries(
      _boundaries(image: const Size(400, 800), viewport: const Size(400, 800)),
    );

    controller.cycleScale(animate: false);
    expect(controller.scale, 1.0);
    expect(notifications, 1);
  });

  test('cycleScale from free zoom returns to the initial scale', () {
    controller.updateBoundaries(_boundaries());
    controller.applyTransform(scale: 2.5, offset: const Offset(100, 100));
    expect(controller.scaleState, ComicScaleState.zoomedIn);

    controller.cycleScale(animate: false);
    expect(controller.scaleState, ComicScaleState.initial);
    expect(controller.offset, Offset.zero);
  });

  test('a custom cycle is honored', () {
    controller.scaleStateCycle = (state) => state == ComicScaleState.initial
        ? ComicScaleState.originalSize
        : ComicScaleState.initial;
    controller.updateBoundaries(_boundaries());

    controller.cycleScale(animate: false);
    expect(controller.scaleState, ComicScaleState.originalSize);
  });

  test('applyTransform clamps scale strictly unless soft', () {
    controller.updateBoundaries(_boundaries());
    final b = controller.boundaries!;

    controller.applyTransform(scale: 0.01, offset: Offset.zero);
    expect(controller.scale, b.minScale);

    controller.applyTransform(
      scale: 0.01,
      offset: Offset.zero,
      softScale: true,
    );
    expect(controller.scale, closeTo(b.minScale * 0.9, 1e-9));
  });

  test('reset returns to the initial transform', () {
    controller.updateBoundaries(_boundaries());
    controller.applyTransform(scale: 2.0, offset: const Offset(-300, 300));

    controller.reset();
    expect(controller.scale, 0.5);
    expect(controller.offset, Offset.zero);
  });

  group('resize', () {
    test('keeps a named state at its new scale', () {
      controller.updateBoundaries(_boundaries());
      controller.setScaleState(ComicScaleState.covering, animate: false);

      controller.updateBoundaries(
        controller.boundaries!.copyWith(viewportSize: const Size(800, 400)),
      );

      expect(controller.scaleState, ComicScaleState.covering);
      expect(controller.scale, closeTo(1.0, 1e-9));
    });

    test('keeps free zoom relative to the contained scale and re-clamps', () {
      controller.updateBoundaries(_boundaries());
      // 4x contained, panned to the bottom-right corner.
      controller.applyTransform(scale: 2.0, offset: const Offset(-1000, -1000));
      expect(controller.offset, const Offset(-600, -800));

      controller.updateBoundaries(
        controller.boundaries!.copyWith(viewportSize: const Size(800, 400)),
      );

      final b = controller.boundaries!;
      expect(controller.scale, closeTo(b.containedScale * 4, 1e-9));
      // The image point at the viewport centre is kept where it still fits.
      expect(-controller.offset.dy / controller.scale, closeTo(400, 1e-9));
      // The narrower overflow clamps horizontally to the right edge.
      expect(
        b.edgesAt(controller.offset, controller.scale, Axis.horizontal).end,
        isTrue,
      );
    });
  });

  group('animator', () {
    test('animated commands delegate to the attached animator', () {
      final animator = _RecordingAnimator();
      controller.updateBoundaries(_boundaries());
      controller.attachAnimator(animator);

      controller.cycleScale();
      expect(animator.targets, hasLength(1));
      expect(animator.targets.single.$1, closeTo(800 / 1200, 1e-9));
      expect(controller.scale, 0.5, reason: 'the animator applies the change');

      controller.cycleScale(animate: false);
      expect(animator.stops, 1);
      expect(controller.scaleState, ComicScaleState.covering);
    });

    test('panBy stops a running animation', () {
      final animator = _RecordingAnimator();
      controller.updateBoundaries(_boundaries());
      controller.attachAnimator(animator);

      controller.panBy(const Offset(0, 10));
      expect(animator.stops, 1);
    });

    test('animated commands jump when no animator is attached', () {
      final animator = _RecordingAnimator();
      controller.updateBoundaries(_boundaries());
      controller.attachAnimator(animator);
      controller.detachAnimator(animator);

      controller.cycleScale();
      expect(animator.targets, isEmpty);
      expect(controller.scaleState, ComicScaleState.covering);
    });

    test('detaching a different animator keeps the attached one', () {
      final animator = _RecordingAnimator();
      controller.updateBoundaries(_boundaries());
      controller.attachAnimator(animator);
      controller.detachAnimator(_RecordingAnimator());

      controller.cycleScale();
      expect(animator.targets, hasLength(1));
    });
  });
}
