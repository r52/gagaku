import 'package:flutter/material.dart';

enum ReaderDirection {
  leftToRight('Left to Right', Icons.arrow_forward),
  rightToLeft('Right to Left', Icons.arrow_back);

  const ReaderDirection(this.label, this.icon);
  final String label;
  final IconData icon;
}

enum ReaderFormat {
  single(
    'Single',
    Icons.note,
  ),
  longstrip(
    'Long Strip',
    Icons.view_stream,
  );

  const ReaderFormat(this.label, this.icon);
  final String label;
  final IconData icon;
}

class ReaderPage {
  final ImageProvider provider;
  final String? sortKey;

  bool cached = false;

  ReaderPage({required this.provider, this.sortKey});
}
