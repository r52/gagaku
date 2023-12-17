import 'package:flutter/material.dart';

enum ReaderDirection {
  leftToRight,
  rightToLeft,
}

enum ReaderFormat {
  single,
  longstrip,
}

extension ReaderDirectionExt on ReaderDirection {
  IconData get icon => const [
        Icons.arrow_forward,
        Icons.arrow_back,
      ].elementAt(index);

  String get formatted => const [
        'Left to Right',
        'Right to Left',
      ].elementAt(index);

  static ReaderDirection parse(int index) =>
      ReaderDirection.values.elementAt(index);
}

extension ReaderFormatExt on ReaderFormat {
  IconData get icon => const [
        Icons.note,
        Icons.view_stream,
      ].elementAt(index);

  String get formatted => const [
        'Single',
        'Long Strip',
      ].elementAt(index);

  static ReaderFormat parse(int index) => ReaderFormat.values.elementAt(index);
}

class ReaderPage {
  final ImageProvider provider;
  final String? sortKey;

  bool cached = false;

  ReaderPage({required this.provider, this.sortKey});
}
