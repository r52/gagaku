import 'package:flutter/material.dart';

class ThemeCache {
  ThemeCache._internal();

  static final ThemeCache _instance = ThemeCache._internal();

  factory ThemeCache() {
    return _instance;
  }

  final Map<double, TextStyle> _flagThemes = {};

  TextStyle getFlagTheme(double size) {
    if (_flagThemes[size] == null) {
      _flagThemes[size] = TextStyle(
        fontFamily: 'Twemoji',
        fontSize: size,
        overflow: TextOverflow.clip,
      );
    }
    return _flagThemes[size]!;
  }
}
