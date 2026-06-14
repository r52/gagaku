import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/reader/widgets/long_strip_page_image.dart';

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
