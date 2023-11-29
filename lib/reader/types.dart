import 'package:flutter/material.dart';

enum ReaderDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
}

extension ReaderDirectionExt on ReaderDirection {
  IconData get icon => const [
        Icons.arrow_forward,
        Icons.arrow_back,
        Icons.arrow_downward,
      ].elementAt(index);

  String get formatted => const [
        'Left to Right',
        'Right to Left',
        'Top to Bottom',
      ].elementAt(index);

  static ReaderDirection parse(int index) {
    return ReaderDirection.values.elementAt(index);
  }
}

class ReaderPage {
  final ImageProvider provider;
  final String? sortKey;

  bool cached = false;

  ReaderPage({required this.provider, this.sortKey});
}
