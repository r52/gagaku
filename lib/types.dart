import 'package:flutter/material.dart';

enum GagakuTheme {
  lime(Color(0xFF827717), 'Lime'),
  grey(Color(0xFF424242), 'Grey'),
  amber(Color(0xFFFFAB00), 'Amber'),
  blue(Color(0xFF1565C0), 'Blue'),
  teal(Color(0xFF00695C), 'Teal'),
  green(Color(0xFF2E7D32), 'Green'),
  lightgreen(Color(0xFF558B2F), 'Light Green'),
  red(Color(0xFFC62828), 'Red'),
  orange(Color(0xFFEF6C00), 'Orange'),
  yellow(Color(0xFFF9A825), 'Yellow'),
  purple(Color(0xFF6A1B9A), 'Purple');

  const GagakuTheme(this.color, this.label);

  final Color color;
  final String label;
}
