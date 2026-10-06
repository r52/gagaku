import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';
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

  testWidgets('a jump discards the visible page observed before it', (
    tester,
  ) async {
    final subject = await _pumpLongStrip(tester, pageCount: 6);
    addTearDown(subject.dispose);

    // Mirrors ReaderSession.bindViewport: the restore jump is scheduled
    // before the list's first layout reports the range at offset zero.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      subject.controller.jumpToPage(3);
    });
    await subject.pump();

    expect(subject.reports, [3]);
  });

  testWidgets('keeps the top item in place when the display width changes', (
    tester,
  ) async {
    final subject = await _pumpLongStrip(tester, pageCount: 6);
    addTearDown(subject.dispose);
    await subject.pump();

    // 2:4 pages at 300 wide are 600 tall: offset 900 is halfway into page 1.
    subject.controller.scrollController.jumpTo(900);
    await tester.pumpAndSettle();
    expect(subject.reports.last, 1);
    subject.reports.clear();

    await subject.pump(displayWidth: 150);

    expect(subject.controller.scrollController.offset, closeTo(450, 0.5));
    expect(subject.reports, everyElement(1));
  });

  testWidgets('anchors relative to the leading list padding', (tester) async {
    final subject = await _pumpLongStrip(tester, pageCount: 6);
    addTearDown(subject.dispose);
    await subject.pump(topPadding: 100);

    // Page 1 spans 700..1300 after the 100px padding: 1000 is its middle.
    subject.controller.scrollController.jumpTo(1000);
    await tester.pumpAndSettle();

    await subject.pump(displayWidth: 150, topPadding: 100);
    expect(subject.controller.scrollController.offset, closeTo(550, 0.5));

    await subject.pump(displayWidth: 150, topPadding: 40);
    expect(subject.controller.scrollController.offset, closeTo(490, 0.5));
  });

  testWidgets('holds a jump target while pages above learn their size', (
    tester,
  ) async {
    final image = await _createImage(2, 2);
    final provider = _DeferredImageProvider();
    // Square pages lay out at 300px once resolved, half the 600px estimate
    // reserved for them while loading.
    final subject = await _pumpLongStrip(
      tester,
      pageCount: 8,
      provider: provider,
      knownAspectRatio: false,
    );
    addTearDown(() {
      subject.dispose();
      image.dispose();
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      subject.controller.jumpToPage(5);
    });
    await subject.pump();

    provider.complete(image);
    await tester.pumpAndSettle();

    final target = find.byKey(ValueKey(subject.pages[5].id));
    expect(subject.pages[4].aspectRatio, 1);
    expect(tester.getTopLeft(target).dy, closeTo(0, 0.5));
    expect(subject.reports, isNotEmpty);
    expect(subject.reports, everyElement(5));

    // A user scroll releases the pin and reports again.
    await tester.drag(find.byType(LongStripReaderView), const Offset(0, -400));
    await tester.pumpAndSettle();
    expect(subject.reports.last, 6);
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
  Size imageSize = const Size(2, 4),
  bool knownAspectRatio = true,
}) async {
  final image = provider == null
      ? await _createImage(imageSize.width.toInt(), imageSize.height.toInt())
      : null;
  final pageProvider = provider ?? _TestImageProvider(image);
  final pages = List.generate(pageCount, (_) {
    final page = ReaderPage(provider: pageProvider);
    if (knownAspectRatio) page.recordImageSize(imageSize);
    return page;
  });
  final reports = <int>[];
  final controller = LongStripReaderViewportController(
    onVisiblePageChanged: reports.add,
  );
  return _LongStripSubject(tester, image, pages, controller, reports);
}

class _LongStripSubject {
  const _LongStripSubject(
    this.tester,
    this.image,
    this.pages,
    this.controller,
    this.reports,
  );

  final WidgetTester tester;
  final ui.Image? image;
  final List<ReaderPage> pages;
  final LongStripReaderViewportController controller;
  final List<int> reports;

  ReaderPage get page => pages.first;

  Future<void> pump({
    VoidCallback? onCenterTap,
    double displayWidth = 300,
    double topPadding = 0,
    bool settle = true,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(padding: EdgeInsets.only(top: topPadding)),
            child: Scaffold(
              body: LongStripReaderView(
                controller: controller,
                pages: pages,
                displayWidth: displayWidth,
                cacheWidth: 300,
                onCenterTap: onCenterTap ?? () {},
              ),
            ),
          ),
        ),
      ),
    );
    if (settle) await tester.pumpAndSettle();
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
    final image = this.image;
    return SynchronousFuture(
      image == null ? 0 : image.width * 100000 + image.height,
    );
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

class _DeferredImageProvider extends ImageProvider<_DeferredImageProvider> {
  final Completer<ImageInfo> _completer = Completer();

  void complete(ui.Image image) {
    _completer.complete(ImageInfo(image: image.clone()));
  }

  @override
  Future<_DeferredImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(this);
  }

  @override
  ImageStreamCompleter loadImage(
    _DeferredImageProvider key,
    ImageDecoderCallback decode,
  ) {
    return OneFrameImageStreamCompleter(_completer.future);
  }
}
