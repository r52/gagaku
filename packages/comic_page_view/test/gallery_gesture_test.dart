import 'dart:ui' as ui;

import 'package:comic_page_view/comic_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Gallery viewport, centred on the 800x600 test surface.
const _viewport = Size(400, 600);
const _center = Offset(400, 300);

/// Resolves immediately to a clone of [image].
class _ReadyProvider extends ImageProvider<_ReadyProvider> {
  _ReadyProvider(this.image);

  final ui.Image image;

  @override
  Future<_ReadyProvider> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(
    _ReadyProvider key,
    ImageDecoderCallback decode,
  ) => OneFrameImageStreamCompleter(
    SynchronousFuture(ImageInfo(image: image.clone())),
  );
}

class _Gallery {
  _Gallery(this.tester, this.controller);

  final WidgetTester tester;
  final ComicGalleryController controller;

  double get page => controller.pageController.page!;
  ComicPageController pageAt(int index) => controller.pageAt(index)!;

  /// Puts page [index] at original size (1.0) with [offset]. An 800x1600
  /// image at 1.0 overflows the viewport by 200 horizontally and 500
  /// vertically on each side.
  Future<void> zoom(int index, {Offset offset = Offset.zero}) async {
    pageAt(index)
      ..setScaleState(ComicScaleState.originalSize, animate: false)
      ..panBy(offset);
    await tester.pump();
  }

  Future<void> drag(Offset delta, {Offset from = _center}) async {
    await tester.dragFrom(from, delta);
    await tester.pumpAndSettle();
  }

  Future<void> pinch(Offset focal) async {
    final a = await tester.startGesture(
      focal - const Offset(20, 0),
      pointer: 1,
    );
    final b = await tester.startGesture(
      focal + const Offset(20, 0),
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
  }
}

Future<_Gallery> _pumpGallery(
  WidgetTester tester, {
  int itemCount = 5,
  bool reverse = false,
  ScrollPhysics? physics,
  bool allowImplicitScrolling = false,
  bool resetOffscreenPages = false,
  ValueChanged<int>? onPageChanged,
}) async {
  final image = (await tester.runAsync(
    () => createTestImage(width: 800, height: 1600, cache: false),
  ))!;
  addTearDown(image.dispose);
  final controller = ComicGalleryController();
  addTearDown(controller.dispose);
  final providers = [for (var i = 0; i < itemCount; i++) _ReadyProvider(image)];

  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: SizedBox.fromSize(
          size: _viewport,
          child: ComicPageGallery.builder(
            controller: controller,
            itemCount: itemCount,
            reverse: reverse,
            scrollPhysics: physics,
            allowImplicitScrolling: allowImplicitScrolling,
            resetOffscreenPages: resetOffscreenPages,
            onPageChanged: onPageChanged,
            builder: (context, index) =>
                ComicPageOptions(image: providers[index]),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  return _Gallery(tester, controller);
}

void main() {
  setUp(() => imageCache.clear());

  group('at contained scale', () {
    testWidgets('a horizontal swipe turns exactly one page', (tester) async {
      final pages = <int>[];
      final gallery = await _pumpGallery(tester, onPageChanged: pages.add);

      await gallery.drag(const Offset(-300, 0));
      expect(gallery.page, 1);
      expect(pages, [1]);
      expect(gallery.pageAt(1).scale, 0.375);

      await gallery.drag(const Offset(300, 0));
      expect(gallery.page, 0);
    });

    testWidgets('reverse direction turns pages the other way', (tester) async {
      final gallery = await _pumpGallery(tester, reverse: true);

      await gallery.drag(const Offset(-300, 0));
      expect(gallery.page, 0);

      await gallery.drag(const Offset(300, 0));
      expect(gallery.page, 1);
    });

    testWidgets('a drag within the touch slop neither pans nor turns', (
      tester,
    ) async {
      final gallery = await _pumpGallery(tester);
      await gallery.zoom(0);

      final gesture = await tester.startGesture(_center);
      await gesture.moveBy(const Offset(-10, 0));
      await tester.pump();
      await gesture.up();
      await tester.pump(kDoubleTapTimeout);
      await tester.pumpAndSettle();

      expect(gallery.page, 0);
      expect(gallery.pageAt(0).offset, Offset.zero);
    });
  });

  for (final (zone, x) in [
    ('left', 230.0),
    ('centre', 400.0),
    ('right', 570.0),
  ]) {
    testWidgets('a pinch started in the $zone third zooms without turning', (
      tester,
    ) async {
      final gallery = await _pumpGallery(tester);

      await gallery.pinch(Offset(x, 300));

      expect(gallery.page, 0);
      expect(gallery.pageAt(0).scale, greaterThan(0.375));
    });
  }

  group('while zoomed', () {
    testWidgets('a horizontal drag pans instead of turning', (tester) async {
      final gallery = await _pumpGallery(tester);
      await gallery.zoom(0);

      await gallery.drag(const Offset(-100, 0));

      expect(gallery.page, 0);
      expect(gallery.pageAt(0).offset.dx, lessThan(-50));
    });

    testWidgets('at the right edge, a leftward drag turns the page', (
      tester,
    ) async {
      final gallery = await _pumpGallery(tester);
      await gallery.zoom(0, offset: const Offset(-200, 0));

      await gallery.drag(const Offset(-300, 0));
      expect(gallery.page, 1);
    });

    testWidgets('at the right edge, a rightward drag pans', (tester) async {
      final gallery = await _pumpGallery(tester);
      await gallery.zoom(0, offset: const Offset(-200, 0));

      await gallery.drag(const Offset(100, 0));
      expect(gallery.page, 0);
      expect(gallery.pageAt(0).offset.dx, greaterThan(-150));
    });

    testWidgets('edges are physical in reverse direction', (tester) async {
      final gallery = await _pumpGallery(tester, reverse: true);
      await gallery.zoom(0, offset: const Offset(200, 0));

      // The left edge is visible, so a rightward drag goes to the pager,
      // which advances when reversed.
      await gallery.drag(const Offset(300, 0));
      expect(gallery.page, 1);
    });

    testWidgets('a vertical drag pans vertically', (tester) async {
      final gallery = await _pumpGallery(tester);
      await gallery.zoom(0);

      await gallery.drag(const Offset(0, -150));

      expect(gallery.page, 0);
      expect(gallery.pageAt(0).offset.dy, lessThan(-100));
    });
  });

  testWidgets('disabled swipes never turn pages but still pan when zoomed', (
    tester,
  ) async {
    final gallery = await _pumpGallery(
      tester,
      physics: const NeverScrollableScrollPhysics(),
    );

    await gallery.drag(const Offset(-300, 0));
    expect(gallery.page, 0);

    await gallery.zoom(0);
    await gallery.drag(const Offset(-100, 0));
    expect(gallery.page, 0);
    expect(gallery.pageAt(0).offset.dx, lessThan(-50));
  });

  group('trackpad', () {
    testWidgets('a pinch zooms without turning', (tester) async {
      final gallery = await _pumpGallery(tester);
      final pointer = TestPointer(1, PointerDeviceKind.trackpad);

      await tester.sendEventToBinding(pointer.panZoomStart(_center));
      for (var scale = 1.1; scale <= 2.0; scale += 0.1) {
        await tester.sendEventToBinding(
          pointer.panZoomUpdate(_center, scale: scale),
        );
        await tester.pump();
      }
      await tester.sendEventToBinding(pointer.panZoomEnd());
      await tester.pumpAndSettle();

      expect(gallery.page, 0);
      expect(gallery.pageAt(0).scale, greaterThan(0.375));
    });

    testWidgets('a horizontal pan at contained scale turns the page', (
      tester,
    ) async {
      final gallery = await _pumpGallery(tester);
      final pointer = TestPointer(1, PointerDeviceKind.trackpad);

      await tester.sendEventToBinding(pointer.panZoomStart(_center));
      for (var dx = -20.0; dx >= -300; dx -= 20) {
        await tester.sendEventToBinding(
          pointer.panZoomUpdate(_center, pan: Offset(dx, 0)),
        );
        await tester.pump();
      }
      await tester.sendEventToBinding(pointer.panZoomEnd());
      await tester.pumpAndSettle();

      expect(gallery.page, 1);
    });
  });

  group('page controllers', () {
    testWidgets('exist only for mounted pages', (tester) async {
      final gallery = await _pumpGallery(tester, itemCount: 60);

      expect(gallery.controller.pageAt(0), isNotNull);
      for (var page = 1; page <= 50; page++) {
        gallery.controller.jumpToPage(page);
        await tester.pump();
      }

      expect(gallery.controller.mountedPages, [50]);
      expect(gallery.controller.pageAt(0), isNull);
    });

    testWidgets('keep an adjacent page zoomed by default', (tester) async {
      final gallery = await _pumpGallery(tester, allowImplicitScrolling: true);
      await gallery.zoom(0);

      gallery.controller.jumpToPage(1);
      await tester.pump();

      expect(gallery.pageAt(0).scale, 1.0);
    });

    testWidgets('reset off-screen pages when requested', (tester) async {
      final gallery = await _pumpGallery(
        tester,
        allowImplicitScrolling: true,
        resetOffscreenPages: true,
      );
      await gallery.zoom(0);

      gallery.controller.jumpToPage(1);
      await tester.pump();

      expect(gallery.pageAt(0).scale, 0.375);
    });
  });
}
