import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/web/model/extension_image.dart';
import 'package:gagaku/web/model/extension_runtime.dart';

class _FakeExtensionRuntime implements ExtensionRuntime {
  _FakeExtensionRuntime(this.bytes);

  final Uint8List bytes;

  @override
  Future<Uint8List> processImageRequest(String url) async => bytes;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('reports received bytes before completing the image', (
    tester,
  ) async {
    final bytes = Uint8List.fromList([1, 2, 3]);
    final provider = ExtensionImage(
      'https://example.com/page.jpg',
      _FakeExtensionRuntime(bytes),
    );
    final pendingCodec = Completer<ui.Codec>();
    final completer = provider.loadImage(
      provider,
      (
        ui.ImmutableBuffer buffer, {
        ui.TargetImageSizeCallback? getTargetSize,
      }) => pendingCodec.future,
    );
    final chunkCompleter = Completer<ImageChunkEvent>();
    late final ImageStreamListener listener;
    listener = ImageStreamListener(
      (image, _) => image.dispose(),
      onChunk: chunkCompleter.complete,
    );
    completer.addListener(listener);
    addTearDown(() => completer.removeListener(listener));

    final event = await chunkCompleter.future;

    expect(event.cumulativeBytesLoaded, bytes.lengthInBytes);
    expect(event.expectedTotalBytes, bytes.lengthInBytes);
  });

  test('uses the runtime as part of its cache identity', () {
    final firstRuntime = _FakeExtensionRuntime(Uint8List(0));
    final secondRuntime = _FakeExtensionRuntime(Uint8List(0));

    expect(
      ExtensionImage('https://example.com/page.jpg', firstRuntime),
      ExtensionImage('https://example.com/page.jpg', firstRuntime),
    );
    expect(
      ExtensionImage('https://example.com/page.jpg', firstRuntime),
      isNot(ExtensionImage('https://example.com/page.jpg', secondRuntime)),
    );
  });
}
