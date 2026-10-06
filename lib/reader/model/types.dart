import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:uuid/uuid.dart';

enum ReaderDirection {
  leftToRight(Icons.arrow_forward),
  rightToLeft(Icons.arrow_back);

  const ReaderDirection(this.icon);
  final IconData icon;

  static const _key = 'reader.direction.';
  String get label => '$_key$name';
}

enum ReaderFormat {
  single(Icons.note),
  longstrip(Icons.view_stream);

  const ReaderFormat(this.icon);
  final IconData icon;

  static const _key = 'reader.format.';
  String get label => '$_key$name';
}

/// Horizontal tap regions of the reader: the outer 40% on each side turn
/// pages, the middle 20% toggles the reader chrome.
enum ReaderTapZone {
  left,
  center,
  right;

  static const _sideFraction = 0.4;

  static ReaderTapZone of(double dx, double width) {
    final margin = width * _sideFraction;
    if (dx <= margin) return ReaderTapZone.left;
    if (dx >= width - margin) return ReaderTapZone.right;
    return ReaderTapZone.center;
  }
}

enum LongStripScale {
  small(0.4),
  large(0.8),
  full(1.0);

  const LongStripScale(this.scale);
  final double scale;

  LongStripScale get next => switch (this) {
    LongStripScale.small => LongStripScale.large,
    LongStripScale.large => LongStripScale.full,
    LongStripScale.full => LongStripScale.small,
  };
}

Iterable<int> readerPrecacheIndices({
  required int currentIndex,
  required int pageCount,
  required int forwardCount,
  int backwardCount = 3,
}) sync* {
  if (currentIndex < 0 || currentIndex >= pageCount) return;

  final forwardEnd = min(currentIndex + 1 + forwardCount, pageCount);
  for (var index = currentIndex + 1; index < forwardEnd; index++) {
    yield index;
  }

  final backwardStart = max(0, currentIndex - backwardCount);
  for (var index = backwardStart; index < currentIndex; index++) {
    yield index;
  }
}

/// Largest decoded page dimension. The engine clamps images beyond the GPU
/// texture limit per axis, distorting very tall webtoon slices; decoding
/// within this bound keeps their proportions on GPUs with 16384px textures,
/// at the cost of horizontal resolution for such slices.
const readerMaxDecodeDimension = 16384;

/// The provider every reader surface decodes [page] through, so displayed
/// and prefetched images share cache entries. Never upscales.
ImageProvider<Object> readerImageProvider(ReaderPage page, {int? cacheWidth}) {
  return ResizeImage(
    page.provider,
    width: min(
      cacheWidth ?? readerMaxDecodeDimension,
      readerMaxDecodeDimension,
    ),
    height: readerMaxDecodeDimension,
    policy: ResizeImagePolicy.fit,
  );
}

class ReaderPage {
  final ImageProvider provider;
  final String? sortKey;

  double? aspectRatio;
  final id = const Uuid().v4();

  ReaderPage({required this.provider, this.sortKey});

  bool recordImageSize(Size size) {
    if (size.width <= 0 || size.height <= 0) return false;

    final nextAspectRatio = size.width / size.height;
    if (aspectRatio == nextAspectRatio) return false;

    aspectRatio = nextAspectRatio;
    return true;
  }
}
