import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'common.g.dart';

@Riverpod(dependencies: [])
ThemeData theme(Ref ref) {
  throw UnimplementedError();
}

@Riverpod(dependencies: [])
TextStyle chipTextStyle(Ref ref) {
  throw UnimplementedError();
}

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
