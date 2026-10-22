import 'dart:ui' as ui;

import 'package:comic_page_view/comic_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/reader/model/config.dart';
import 'package:gagaku/reader/model/session.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/reader/model/viewport_controller.dart';
import 'package:gagaku/reader/widgets/reader_viewports.dart';
import 'package:material_ui/material_ui.dart';

class _ImageProvider extends ImageProvider<_ImageProvider> {
  _ImageProvider(this.image);

  final ui.Image image;

  @override
  Future<_ImageProvider> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(
    _ImageProvider key,
    ImageDecoderCallback decode,
  ) => OneFrameImageStreamCompleter(
    SynchronousFuture(ImageInfo(image: image.clone())),
  );
}

class _Subject {
  _Subject(this.controller);

  final HorizontalReaderViewportController controller;
  final zones = <ReaderTapZone>[];
  final pages = <int>[];

  ComicPageController? pageAt(int index) => controller.gallery.pageAt(index);
  double get page => controller.gallery.pageController.page!;
}

Future<_Subject> _pump(
  WidgetTester tester, {
  ReaderConfig? settings,
  int pageCount = 3,
}) async {
  final image = (await tester.runAsync(
    () => createTestImage(width: 800, height: 1600, cache: false),
  ))!;
  addTearDown(image.dispose);
  final controller = HorizontalReaderViewportController();
  addTearDown(controller.dispose);
  final subject = _Subject(controller);
  final pages = [
    for (var i = 0; i < pageCount; i++)
      ReaderPage(provider: _ImageProvider(image)),
  ];

  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: HorizontalReaderView(
        controller: controller,
        pages: pages,
        settings: settings ?? ReaderConfig(),
        onTapZone: subject.zones.add,
        onPageChanged: subject.pages.add,
        onInteraction: () {},
      ),
    ),
  );
  await tester.pump();
  return subject;
}

void main() {
  setUp(() => imageCache.clear());

  testWidgets('togglePageSize cycles the current page scale', (tester) async {
    final subject = await _pump(tester);

    subject.controller.togglePageSize(0);
    await tester.pumpAndSettle();
    expect(subject.pageAt(0)?.scaleState, ComicScaleState.covering);

    subject.controller.togglePageSize(2);
    expect(subject.pageAt(2), isNull, reason: 'unmounted pages are ignored');
  });

  testWidgets('scrollBy pans the current page while zoomed', (tester) async {
    final subject = await _pump(tester);

    expect(
      subject.controller.scrollBy(250, currentPage: 0),
      ReaderPageTurnResult.handled,
    );
    expect(subject.pageAt(0)?.offset, Offset.zero);

    subject.controller.togglePageSize(0);
    await tester.pumpAndSettle();
    subject.controller.scrollBy(250, currentPage: 0);
    expect(subject.pageAt(0)?.offset.dy, -250);
  });

  testWidgets('a stationary tap reports its zone without turning', (
    tester,
  ) async {
    final subject = await _pump(tester);

    await tester.tapAt(const Offset(50, 300));
    await tester.pump(kDoubleTapTimeout);
    await tester.pumpAndSettle();

    expect(subject.zones, [ReaderTapZone.left]);
    expect(subject.page, 0);
  });

  testWidgets('a pinch in a tap zone zooms without a tap or turn', (
    tester,
  ) async {
    final subject = await _pump(tester);
    const focal = Offset(80, 300);

    final a = await tester.startGesture(
      focal - const Offset(20, 0),
      pointer: 1,
    );
    final b = await tester.startGesture(
      focal + const Offset(20, 0),
      pointer: 2,
    );
    for (var i = 0; i < 5; i++) {
      await a.moveBy(const Offset(-15, 0));
      await b.moveBy(const Offset(15, 0));
      await tester.pump();
    }
    await a.up();
    await b.up();
    await tester.pumpAndSettle();

    expect(subject.zones, isEmpty);
    expect(subject.page, 0);
    // 800x1600 pages are contained at 0.375 on the 800x600 surface.
    expect(subject.pageAt(0)!.scale, greaterThan(0.375));
  });

  testWidgets('right-to-left swipes advance with a rightward drag', (
    tester,
  ) async {
    final subject = await _pump(
      tester,
      settings: ReaderConfig(direction: ReaderDirection.rightToLeft),
    );

    await tester.dragFrom(const Offset(100, 300), const Offset(600, 0));
    await tester.pumpAndSettle();

    expect(subject.pages, [1]);
  });

  testWidgets('disabled swipe gestures keep the page', (tester) async {
    final subject = await _pump(
      tester,
      settings: ReaderConfig(swipeGestures: false),
    );

    await tester.dragFrom(const Offset(700, 300), const Offset(-600, 0));
    await tester.pumpAndSettle();

    expect(subject.pages, isEmpty);
  });

  test('prepareInitialPage replaces only an unattached gallery', () {
    final controller = HorizontalReaderViewportController();
    addTearDown(controller.dispose);
    final first = controller.gallery;

    controller.prepareInitialPage(0);
    expect(controller.gallery, same(first));

    controller.prepareInitialPage(4);
    expect(controller.gallery, isNot(same(first)));
    expect(controller.gallery.pageController.initialPage, 4);
  });
}
