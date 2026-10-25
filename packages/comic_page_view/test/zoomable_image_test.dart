import 'dart:ui' as ui;

import 'package:comic_page_view/comic_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Viewport the image is laid out in.
const _viewport = Size(400, 600);

class _TestCompleter extends ImageStreamCompleter {
  int listeners = 0;

  @override
  void addListener(ImageStreamListener listener) {
    listeners++;
    super.addListener(listener);
  }

  @override
  void removeListener(ImageStreamListener listener) {
    listeners--;
    super.removeListener(listener);
  }

  void chunk(int loaded, int total) => reportImageChunkEvent(
    ImageChunkEvent(cumulativeBytesLoaded: loaded, expectedTotalBytes: total),
  );

  void complete(ui.Image image) => setImage(ImageInfo(image: image));

  void fail(Object error) => reportError(exception: error, silent: true);
}

class _TestProvider extends ImageProvider<_TestProvider> {
  final completer = _TestCompleter();

  @override
  Future<_TestProvider> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(
    _TestProvider key,
    ImageDecoderCallback decode,
  ) => completer;
}

Future<ui.Image> _image(
  WidgetTester tester, {
  int width = 800,
  int height = 1600,
}) async {
  return (await tester.runAsync(
    () => createTestImage(width: width, height: height, cache: false),
  ))!;
}

/// Pumps [child] centred in a [_viewport]-sized box.
Future<void> _pump(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: SizedBox.fromSize(size: _viewport, child: child),
      ),
    ),
  );
}

/// Pumps a loaded 800x1600 image: contained 0.375, covered 0.5, max 2.5.
Future<ComicPageController> _pumpLoaded(
  WidgetTester tester, {
  ComicTapUpCallback? onTapUp,
}) async {
  final provider = _TestProvider();
  final controller = ComicPageController();
  addTearDown(controller.dispose);

  await _pump(
    tester,
    ComicZoomableImage(
      image: provider,
      controller: controller,
      onTapUp: onTapUp,
    ),
  );
  provider.completer.complete(await _image(tester));
  await tester.pump();
  return controller;
}

Offset get _center => const Offset(400, 300);

void main() {
  setUp(() => imageCache.clear());

  testWidgets('shows loading progress, then paints the image', (tester) async {
    final provider = _TestProvider();
    final events = <ImageChunkEvent?>[];

    await _pump(
      tester,
      ComicZoomableImage(
        image: provider,
        loadingBuilder: (context, event) {
          events.add(event);
          return const SizedBox();
        },
      ),
    );
    provider.completer.chunk(50, 100);
    await tester.pump();

    expect(events.first, isNull);
    expect(events.last?.cumulativeBytesLoaded, 50);
    expect(find.byType(RawImage), findsNothing);

    provider.completer.complete(await _image(tester));
    await tester.pump();

    expect(find.byType(RawImage), findsOneWidget);
    expect(tester.getSize(find.byType(RawImage)), const Size(800, 1600));
  });

  testWidgets('first layout starts at the initial scale', (tester) async {
    final controller = await _pumpLoaded(tester);

    expect(controller.boundaries?.viewportSize, _viewport);
    expect(controller.scale, 0.375);
    expect(controller.scaleState, ComicScaleState.initial);
  });

  testWidgets('shows the error builder when loading fails', (tester) async {
    final provider = _TestProvider();
    Object? reported;

    await _pump(
      tester,
      ComicZoomableImage(
        image: provider,
        errorBuilder: (context, error, stackTrace) {
          reported = error;
          return const SizedBox();
        },
      ),
    );
    provider.completer.fail('boom');
    await tester.pump();

    expect(reported, 'boom');
  });

  testWidgets('default placeholders build without a theme', (tester) async {
    final provider = _TestProvider();

    await _pump(tester, ComicZoomableImage(image: provider));
    expect(find.byType(ComicDefaultLoading), findsOneWidget);

    provider.completer.fail('boom');
    await tester.pump();
    expect(find.byType(ComicDefaultError), findsOneWidget);
  });

  testWidgets('swapping the provider releases the old stream', (tester) async {
    final first = _TestProvider();
    final second = _TestProvider();
    final controller = ComicPageController();
    addTearDown(controller.dispose);

    await _pump(
      tester,
      ComicZoomableImage(image: first, controller: controller),
    );
    first.completer.complete(await _image(tester));
    await tester.pump();
    controller.setScaleState(ComicScaleState.covering, animate: false);
    final firstListeners = first.completer.listeners;

    await _pump(
      tester,
      ComicZoomableImage(image: second, controller: controller),
    );
    expect(first.completer.listeners, firstListeners - 1);
    expect(find.byType(ComicDefaultLoading), findsOneWidget);

    second.completer.complete(await _image(tester, width: 400, height: 400));
    await tester.pump();
    expect(controller.boundaries?.imageSize, const Size(400, 400));
    expect(controller.scaleState, ComicScaleState.initial);
  });

  testWidgets('double tap cycles through the named states', (tester) async {
    final controller = await _pumpLoaded(tester);

    Future<void> doubleTap() async {
      await tester.tapAt(_center);
      await tester.pump(kDoubleTapMinTime);
      await tester.tapAt(_center);
      await tester.pumpAndSettle();
    }

    await doubleTap();
    expect(controller.scaleState, ComicScaleState.covering);
    await doubleTap();
    expect(controller.scaleState, ComicScaleState.originalSize);
    await doubleTap();
    expect(controller.scaleState, ComicScaleState.initial);
  });

  testWidgets('double tap zooms toward the tapped point', (tester) async {
    final controller = await _pumpLoaded(tester);
    final topLeft = _center - const Offset(150, 250);

    await tester.tapAt(topLeft);
    await tester.pump(kDoubleTapMinTime);
    await tester.tapAt(topLeft);
    await tester.pumpAndSettle();

    // Covered (0.5) fits the width exactly, so only y can move.
    expect(controller.scaleState, ComicScaleState.covering);
    expect(controller.offset.dx, 0);
    expect(controller.offset.dy, greaterThan(0));
  });

  testWidgets('pinch zooms around the focal point', (tester) async {
    final controller = await _pumpLoaded(tester);
    final focal = _center - const Offset(100, 150);

    final a = await tester.startGesture(
      focal - const Offset(40, 0),
      pointer: 1,
    );
    final b = await tester.startGesture(
      focal + const Offset(40, 0),
      pointer: 2,
    );
    for (var i = 0; i < 5; i++) {
      await a.moveBy(const Offset(-20, 0));
      await b.moveBy(const Offset(20, 0));
      await tester.pump();
    }
    await a.up();
    await b.up();
    await tester.pumpAndSettle();

    expect(controller.scale, greaterThan(0.375));
    // Zooming around a point above-left of centre reveals that region.
    expect(controller.offset.dx, greaterThan(0));
    expect(controller.offset.dy, greaterThan(0));
  });

  testWidgets('a pinch past the maximum animates back', (tester) async {
    final controller = await _pumpLoaded(tester);
    final max = controller.boundaries!.maxScale;

    final a = await tester.startGesture(
      _center - const Offset(5, 0),
      pointer: 1,
    );
    final b = await tester.startGesture(
      _center + const Offset(5, 0),
      pointer: 2,
    );
    for (var i = 0; i < 20; i++) {
      await a.moveBy(const Offset(-25, 0));
      await b.moveBy(const Offset(25, 0));
      await tester.pump();
    }
    expect(controller.scale, greaterThan(max));

    await a.up();
    await b.up();
    await tester.pumpAndSettle();
    expect(controller.scale, max);
  });

  testWidgets('a one-finger pan while zoomed clamps at the edges', (
    tester,
  ) async {
    final controller = await _pumpLoaded(tester);
    controller.setScaleState(ComicScaleState.originalSize, animate: false);
    await tester.pump();

    // 800x1600 at 1.0 overflows 400x600 by 200 and 500 per side.
    await tester.dragFrom(_center, const Offset(1000, 1000));
    await tester.pumpAndSettle();
    expect(controller.offset, const Offset(200, 500));

    await tester.dragFrom(_center, const Offset(-50, -60));
    await tester.pumpAndSettle();
    expect(controller.offset.dx, lessThan(200));
    expect(controller.offset.dy, lessThan(500));
  });

  testWidgets('a fling continues the pan and settles inside the bounds', (
    tester,
  ) async {
    final controller = await _pumpLoaded(tester);
    controller.setScaleState(ComicScaleState.originalSize, animate: false);
    await tester.pump();

    await tester.flingFrom(_center, const Offset(0, -100), 3000);
    final released = controller.offset;
    await tester.pumpAndSettle();

    expect(controller.offset.dy, lessThan(released.dy));
    expect(controller.offset.dy, greaterThanOrEqualTo(-500));
    expect(controller.offset.dx, closeTo(0, 1e-9));
  });

  testWidgets('a fling at contained scale does not move the image', (
    tester,
  ) async {
    final controller = await _pumpLoaded(tester);

    await tester.flingFrom(_center, const Offset(0, -100), 3000);
    await tester.pumpAndSettle();

    expect(controller.offset, Offset.zero);
  });

  testWidgets('ctrl+wheel zooms around the pointer', (tester) async {
    final controller = await _pumpLoaded(tester);
    final pointer = TestPointer(1, PointerDeviceKind.mouse);

    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendEventToBinding(pointer.hover(_center));
    await tester.sendEventToBinding(pointer.scroll(const Offset(0, -100)));
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pump();

    expect(controller.scale, greaterThan(0.375));
  });

  testWidgets('the wheel pans only while the image can move', (tester) async {
    final controller = await _pumpLoaded(tester);
    final pointer = TestPointer(1, PointerDeviceKind.mouse);
    await tester.sendEventToBinding(pointer.hover(_center));

    await tester.sendEventToBinding(pointer.scroll(const Offset(0, 100)));
    await tester.pump();
    expect(controller.offset, Offset.zero);

    controller.setScaleState(ComicScaleState.originalSize, animate: false);
    await tester.sendEventToBinding(pointer.scroll(const Offset(0, 100)));
    await tester.pump();
    expect(controller.offset, const Offset(0, -100));
  });

  testWidgets('onTapUp fires once a double tap is ruled out', (tester) async {
    var taps = 0;
    final controller = await _pumpLoaded(
      tester,
      onTapUp: (context, details, controller) => taps++,
    );

    await tester.tapAt(_center);
    await tester.pump();
    expect(taps, 0);
    await tester.pump(kDoubleTapTimeout);
    expect(taps, 1);
    expect(controller.scaleState, ComicScaleState.initial);
  });

  for (final keepAlive in [true, false]) {
    testWidgets('wantKeepAlive: $keepAlive', (tester) async {
      final provider = _TestProvider();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ListView(
            itemExtent: 600,
            scrollCacheExtent: const ScrollCacheExtent.pixels(0),
            children: [
              ComicZoomableImage(image: provider, wantKeepAlive: keepAlive),
              for (var i = 0; i < 5; i++) const SizedBox(),
            ],
          ),
        ),
      );
      await tester.drag(find.byType(ListView), const Offset(0, -2400));
      await tester.pump(kDoubleTapTimeout);

      expect(
        find.byType(ComicZoomableImage, skipOffstage: false),
        keepAlive ? findsOneWidget : findsNothing,
      );
    });
  }

  testWidgets('exposes the semantic label as an image', (tester) async {
    final handle = tester.ensureSemantics();
    await _pump(
      tester,
      ComicZoomableImage(image: _TestProvider(), semanticLabel: 'Page 3'),
    );

    expect(
      tester.getSemantics(find.byType(ComicZoomableImage)),
      matchesSemantics(label: 'Page 3', isImage: true),
    );
    handle.dispose();
  });
}
