import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:gagaku/web/model/extension_bridge.dart';

/// An image provider that fetches images via [ExtensionWebViewBridge].
///
/// Unlike [NetworkImage], this uses the extension bridge to fetch
/// page images. The proxy server handles CORS bypass and large image
/// data transfer (avoiding the ~1MB IPC limit).
@immutable
class ExtensionImage extends ImageProvider<ExtensionImage> {
  /// Creates an [ExtensionImage] that fetches the image at [url]
  /// using the given [bridge].
  const ExtensionImage(this.url, this.bridge, {this.scale = 1.0});

  /// The URL of the image to fetch.
  final String url;

  /// The extension bridge used to fetch the image data.
  final ExtensionWebViewBridge bridge;

  /// The scale factor.
  final double scale;

  @override
  Future<ExtensionImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<ExtensionImage>(this);
  }

  @override
  ImageStreamCompleter loadImage(
    ExtensionImage key,
    ImageDecoderCallback decode,
  ) {
    final chunkEvents = StreamController<ImageChunkEvent>();

    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, chunkEvents, decode: decode),
      chunkEvents: chunkEvents.stream,
      scale: key.scale,
      debugLabel: key.url,
      informationCollector: () => <DiagnosticsNode>[
        DiagnosticsProperty<ImageProvider>('Image provider', this),
        DiagnosticsProperty<ExtensionImage>('Image key', key),
      ],
    );
  }

  Future<ui.Codec> _loadAsync(
    ExtensionImage key,
    StreamController<ImageChunkEvent> chunkEvents, {
    required _SimpleDecoderCallback decode,
  }) async {
    try {
      assert(key == this);

      final bytes = await bridge.registerImageCompleter(key.url);

      if (bytes.isEmpty) {
        throw Exception('ExtensionImage is an empty file: $url');
      }

      return decode(await ui.ImmutableBuffer.fromUint8List(bytes));
    } catch (e) {
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    } finally {
      // ignore: unawaited_futures
      chunkEvents.close().catchError((Object error, StackTrace stack) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: error,
            stack: stack,
            library: 'painting library',
            context: ErrorDescription(
              'while closing chunkEvents stream in ExtensionImage.load',
            ),
          ),
        );
      });
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is ExtensionImage && other.url == url && other.scale == scale;
  }

  @override
  int get hashCode => Object.hash(url, scale);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'ExtensionImage')}("$url", scale: ${scale.toStringAsFixed(1)})';
}

/// Method signature for _loadAsync decode callbacks.
typedef _SimpleDecoderCallback =
    Future<ui.Codec> Function(ui.ImmutableBuffer buffer);
