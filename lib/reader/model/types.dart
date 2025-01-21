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

class ReaderPage {
  final ImageProvider provider;
  final String? sortKey;

  bool cached = false;
  final id = const Uuid().v4();

  ReaderPage({required this.provider, this.sortKey});
}
