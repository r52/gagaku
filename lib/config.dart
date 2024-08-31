import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

enum GridAlbumExtent {
  xsmall(128, 512),
  small(192, 768),
  medium(256, 1024),
  large(512, 2048);

  final double grid;
  final double detailed;

  const GridAlbumExtent(this.grid, this.detailed);
}

class ColorConverter implements JsonConverter<Color, dynamic> {
  const ColorConverter();

  @override
  Color fromJson(dynamic code) => Color(int.parse(code as String));

  @override
  dynamic toJson(Color color) => color.value.toString();
}

@freezed
class GagakuConfig with _$GagakuConfig {
  const factory GagakuConfig({
    /// Theme mode
    @Default(ThemeMode.system) ThemeMode themeMode,

    /// Theme color
    @Default(Color(0xFF827717)) @ColorConverter() Color theme,

    // Grid view size
    @Default(GridAlbumExtent.medium) GridAlbumExtent gridAlbumExtent,
  }) = _GagakuConfig;

  factory GagakuConfig.fromJson(Map<String, dynamic> json) => _$GagakuConfigFromJson(json);
}

@riverpod
class GagakuSettings extends _$GagakuSettings {
  GagakuConfig _fetch() {
    final box = Hive.box(gagakuBox);
    final str = box.get('gagaku');

    if (str == null) {
      return const GagakuConfig();
    }

    final content = json.decode(str) as Map<String, dynamic>;

    return GagakuConfig.fromJson(content);
  }

  @override
  GagakuConfig build() {
    return _fetch();
  }

  void save(GagakuConfig update) {
    state = update;

    final box = Hive.box(gagakuBox);
    box.put('gagaku', json.encode(update.toJson()));
  }
}
