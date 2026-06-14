import 'dart:math';

import 'package:flutter/material.dart';
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
