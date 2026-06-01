import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:gagaku/web/model/extension_runtime.dart';

/// An image provider that fetches images via [ExtensionRuntime].
///
/// Unlike [NetworkImage], this uses the extension runtime to fetch
/// page images after extension interceptors have processed them.
@immutable
class ExtensionImage extends ImageProvider<ExtensionImage> {
  /// Creates an [ExtensionImage] that fetches the image at [url]
  /// using the given [runtime].
  const ExtensionImage(this.url, this.runtime, {this.scale = 1.0});

  /// The URL of the image to fetch.
  final String url;

  /// The extension runtime used to fetch the image data.
  final ExtensionRuntime runtime;

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

      final bytes = await runtime.processImageRequest(key.url);

      if (bytes.isEmpty) {
        throw Exception('ExtensionImage is an empty file: $url');
      }

      chunkEvents.add(
        ImageChunkEvent(
          cumulativeBytesLoaded: bytes.lengthInBytes,
          expectedTotalBytes: bytes.lengthInBytes,
        ),
      );

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
    return other is ExtensionImage &&
        other.url == url &&
        other.runtime == runtime &&
        other.scale == scale;
  }

  @override
  int get hashCode => Object.hash(url, runtime, scale);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'ExtensionImage')}("$url", scale: ${scale.toStringAsFixed(1)})';
}

/// Method signature for _loadAsync decode callbacks.
typedef _SimpleDecoderCallback =
    Future<ui.Codec> Function(ui.ImmutableBuffer buffer);
