import 'package:flutter/material.dart';
import 'package:gagaku/reader/model/types.dart';

ImageProvider<Object> readerImageProvider(
  ReaderPage page, {
  required int cacheWidth,
}) {
  return ResizeImage.resizeIfNeeded(cacheWidth, null, page.provider);
}

class LongStripPageImage extends StatefulWidget {
  const LongStripPageImage({
    super.key,
    required this.page,
    required this.displayWidth,
    required this.cacheWidth,
    this.onAspectRatioChanged,
  });

  final ReaderPage page;
  final double displayWidth;
  final int cacheWidth;
  final VoidCallback? onAspectRatioChanged;

  @override
  State<LongStripPageImage> createState() => _LongStripPageImageState();
}

class _LongStripPageImageState extends State<LongStripPageImage> {
  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;
  bool _aspectRatioUpdateScheduled = false;
  ReaderPage? _pendingAspectRatioPage;

  ImageProvider<Object> get _provider =>
      readerImageProvider(widget.page, cacheWidth: widget.cacheWidth);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveImage();
  }

  @override
  void didUpdateWidget(LongStripPageImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.page != oldWidget.page ||
        widget.cacheWidth != oldWidget.cacheWidth) {
      _resolveImage();
    }
  }

  @override
  void dispose() {
    _stopListening();
    super.dispose();
  }

  void _resolveImage() {
    final stream = _provider.resolve(createLocalImageConfiguration(context));
    if (stream.key == _imageStream?.key) return;

    _stopListening();
    _imageStream = stream;
    _imageStreamListener = ImageStreamListener(_handleImage);
    stream.addListener(_imageStreamListener!);
  }

  void _stopListening() {
    final listener = _imageStreamListener;
    if (listener != null) {
      _imageStream?.removeListener(listener);
    }
    _imageStream = null;
    _imageStreamListener = null;
  }

  void _handleImage(ImageInfo imageInfo, bool synchronousCall) {
    final changed = widget.page.recordImageSize(
      Size(imageInfo.image.width.toDouble(), imageInfo.image.height.toDouble()),
    );
    imageInfo.dispose();

    if (!changed || !mounted) return;

    _pendingAspectRatioPage = widget.page;
    if (_aspectRatioUpdateScheduled) return;
    _aspectRatioUpdateScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _aspectRatioUpdateScheduled = false;
      final page = _pendingAspectRatioPage;
      _pendingAspectRatioPage = null;
      if (!mounted || page == null || !identical(widget.page, page)) return;

      setState(() {});
      widget.onAspectRatioChanged?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final image = Image(
      image: _provider,
      fit: BoxFit.contain,
      alignment: Alignment.topCenter,
      loadingBuilder: (context, child, event) {
        if (event == null) {
          return child;
        }

        return Center(
          child: CircularProgressIndicator(
            value: event.expectedTotalBytes != null
                ? event.cumulativeBytesLoaded / event.expectedTotalBytes!
                : null,
          ),
        );
      },
    );

    final aspectRatio = widget.page.aspectRatio;
    return SizedBox(
      width: widget.displayWidth,
      child: aspectRatio == null
          ? image
          : AspectRatio(aspectRatio: aspectRatio, child: image),
    );
  }
}
