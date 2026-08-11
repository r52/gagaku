import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/reader/model/viewport_controller.dart';
import 'package:gagaku/reader/widgets/long_strip_page_image.dart';
import 'package:gagaku/reader/widgets/reader_viewports.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  test('long-strip precache indices stay within the nearby-page window', () {
    final indices = readerPrecacheIndices(
      currentIndex: 20,
      pageCount: 100,
      forwardCount: 9,
    ).toList();

    expect(indices, [21, 22, 23, 24, 25, 26, 27, 28, 29, 17, 18, 19]);
  });

  test('precache indices clamp to chapter boundaries', () {
    expect(
      readerPrecacheIndices(
        currentIndex: 1,
        pageCount: 4,
        forwardCount: 9,
      ).toList(),
      [2, 3, 0],
    );
  });

  test('backward precaching remains independent of the forward count', () {
    expect(
      readerPrecacheIndices(
        currentIndex: 20,
        pageCount: 100,
        forwardCount: 1,
      ).toList(),
      [21, 17, 18, 19],
    );
  });

  test('ReaderPage retains a valid image aspect ratio', () {
    final page = ReaderPage(provider: _TestImageProvider(null));

    expect(page.recordImageSize(const Size(800, 10000)), isTrue);
    expect(page.aspectRatio, closeTo(0.08, 0.00001));
    expect(page.recordImageSize(const Size(800, 10000)), isFalse);
    expect(page.recordImageSize(Size.zero), isFalse);
  });

  testWidgets('reserves the learned aspect ratio after image resolution', (
    tester,
  ) async {
    final image = await _createImage(2, 4);
    addTearDown(image.dispose);
    final page = ReaderPage(provider: _TestImageProvider(image));
    final callbackPhases = <SchedulerPhase>[];

    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: LongStripPageImage(
            page: page,
            displayWidth: 100,
            cacheWidth: 100,
            onAspectRatioChanged: () {
              callbackPhases.add(SchedulerBinding.instance.schedulerPhase);
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(page.aspectRatio, 0.5);
    expect(callbackPhases, [SchedulerPhase.postFrameCallbacks]);
    expect(
      tester.getSize(find.byType(LongStripPageImage)),
      const Size(100, 200),
    );
  });

  test('uses a width-aware image provider for decode caching', () {
    final page = ReaderPage(provider: _TestImageProvider(null));

    final provider = readerImageProvider(page, cacheWidth: 320);

    expect(provider, isA<ResizeImage>());
    expect((provider as ResizeImage).width, 320);
    expect(provider.allowUpscaling, isFalse);
  });

  testWidgets('double tap hoists the page into a Hero zoom overlay', (
    tester,
  ) async {
    final subject = await _pumpLongStrip(tester);
    addTearDown(subject.dispose);
    var centerTaps = 0;

    await subject.pump(onCenterTap: () => centerTaps++);

    final pageFinder = find.byType(LongStripPageImage);
    final position = tester.getCenter(pageFinder);
    await tester.tapAt(position);
    await tester.pump(kDoubleTapMinTime);
    await tester.tapAt(position);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(centerTaps, 0);
    expect(find.byType(LongStripPageOverlay), findsOneWidget);
    expect(find.byType(PhotoView), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Hero && widget.tag == subject.page.id,
      ),
      findsNWidgets(2),
    );
    final overlayContext = tester.element(find.byType(LongStripPageOverlay));
    expect(ModalRoute.of(overlayContext), isA<PageRoute<void>>());
    final colorScheme = Theme.of(overlayContext).colorScheme;
    final closeButton = tester.widget<CloseButton>(find.byType(CloseButton));
    expect(
      closeButton.style?.backgroundColor?.resolve({}),
      colorScheme.inverseSurface,
    );
    expect(
      closeButton.style?.foregroundColor?.resolve({}),
      colorScheme.onInverseSurface,
    );

    await _tapOverlayToDismiss(tester);

    expect(find.byType(LongStripPageOverlay), findsNothing);
    expect(find.byType(LongStripReaderView), findsOneWidget);
  });

  testWidgets('destination Hero exists while the overlay image is unresolved', (
    tester,
  ) async {
    final subject = await _pumpLongStrip(
      tester,
      provider: const _PendingImageProvider(),
    );
    addTearDown(subject.dispose);
    await subject.pump();

    final position = tester.getCenter(find.byType(LongStripPageImage));
    await tester.tapAt(position);
    await tester.pump(kDoubleTapMinTime);
    await tester.tapAt(position);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.byType(LongStripPageOverlay), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Hero && widget.tag == subject.page.id,
      ),
      findsNWidgets(2),
    );

    await tester.tap(find.byType(CloseButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.byType(LongStripPageOverlay), findsNothing);
  });

  testWidgets(
    'pinch motion opens the zoom overlay without a scale recognizer',
    (tester) async {
      final subject = await _pumpLongStrip(tester);
      addTearDown(subject.dispose);
      await subject.pump();

      final center = tester.getCenter(find.byType(LongStripPageImage));
      final first = await tester.startGesture(
        center - const Offset(40, 0),
        pointer: 1,
      );
      final second = await tester.startGesture(
        center + const Offset(40, 0),
        pointer: 2,
      );

      await first.moveBy(const Offset(-20, 0));
      await tester.pump();
      await first.up();
      await second.up();
      await tester.pumpAndSettle();

      expect(find.byType(LongStripPageOverlay), findsOneWidget);
      await _tapOverlayToDismiss(tester);
    },
  );

  testWidgets('one-finger strip scrolling does not open the zoom overlay', (
    tester,
  ) async {
    final subject = await _pumpLongStrip(tester);
    addTearDown(subject.dispose);
    await subject.pump();

    await tester.drag(find.byType(LongStripPageImage), const Offset(0, -200));
    await tester.pumpAndSettle();

    expect(find.byType(LongStripPageOverlay), findsNothing);
  });

  testWidgets('zoom overlay preserves the long-strip scroll position', (
    tester,
  ) async {
    final subject = await _pumpLongStrip(tester, pageCount: 3);
    addTearDown(subject.dispose);
    await subject.pump();

    await tester.drag(
      find.byType(LongStripPageImage).first,
      const Offset(0, -200),
    );
    await tester.pumpAndSettle();
    final initialOffset = subject.controller.scrollController.offset;
    expect(initialOffset, greaterThan(0));

    final position = tester.getCenter(find.byType(LongStripPageImage).first);
    await tester.tapAt(position);
    await tester.pump(kDoubleTapMinTime);
    await tester.tapAt(position);
    await tester.pumpAndSettle();
    await _tapOverlayToDismiss(tester);

    expect(subject.controller.scrollController.offset, initialOffset);
  });
}

Future<void> _tapOverlayToDismiss(WidgetTester tester) async {
  await tester.tap(find.byType(PhotoView));
  await tester.pump(kDoubleTapTimeout);
  await tester.pumpAndSettle();
}

Future<_LongStripSubject> _pumpLongStrip(
  WidgetTester tester, {
  int pageCount = 1,
  ImageProvider<Object>? provider,
}) async {
  final image = provider == null ? await _createImage(2, 4) : null;
  final pageProvider = provider ?? _TestImageProvider(image);
  final pages = List.generate(
    pageCount,
    (_) =>
        ReaderPage(provider: pageProvider)..recordImageSize(const Size(2, 4)),
  );
  final controller = LongStripReaderViewportController(
    onVisiblePageChanged: (_) {},
  );
  return _LongStripSubject(tester, image, pages, controller);
}

class _LongStripSubject {
  const _LongStripSubject(this.tester, this.image, this.pages, this.controller);

  final WidgetTester tester;
  final ui.Image? image;
  final List<ReaderPage> pages;
  final LongStripReaderViewportController controller;

  ReaderPage get page => pages.first;

  Future<void> pump({VoidCallback? onCenterTap}) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LongStripReaderView(
            controller: controller,
            pages: pages,
            displayWidth: 300,
            cacheWidth: 300,
            onCenterTap: onCenterTap ?? () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  void dispose() {
    controller.dispose();
    image?.dispose();
  }
}

Future<ui.Image> _createImage(int width, int height) {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawRect(
    Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    Paint()..color = Colors.black,
  );
  return recorder.endRecording().toImage(width, height);
}

class _TestImageProvider extends ImageProvider<int> {
  const _TestImageProvider(this.image);

  final ui.Image? image;

  @override
  Future<int> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(image?.width ?? 0);
  }

  @override
  ImageStreamCompleter loadImage(int key, ImageDecoderCallback decode) {
    final image = this.image;
    if (image == null) {
      throw StateError(
        'This provider is only used as a cache-key placeholder.',
      );
    }

    return OneFrameImageStreamCompleter(
      SynchronousFuture(ImageInfo(image: image.clone())),
    );
  }
}

class _PendingImageProvider extends ImageProvider<int> {
  const _PendingImageProvider();

  @override
  Future<int> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(1);
  }

  @override
  ImageStreamCompleter loadImage(int key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(Completer<ImageInfo>().future);
  }
}
