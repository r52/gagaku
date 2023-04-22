import 'package:flutter/material.dart';

enum ReaderDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
}

extension ReaderDirectionExt on ReaderDirection {
  Icon get icon => const [
        Icon(Icons.arrow_forward),
        Icon(Icons.arrow_back),
        Icon(Icons.arrow_downward),
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

  bool cached = false;

  ReaderPage({required this.provider});
}
