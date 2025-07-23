// ignore_for_file: invalid_annotation_target

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/model/types.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod/experimental/mutation.dart';
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

// @freezed
// abstract class GagakuConfig with _$GagakuConfig {
//   const factory GagakuConfig({
//     /// Theme mode
//     @Default(ThemeMode.system) ThemeMode themeMode,

//     /// Theme color
//     @JsonKey(unknownEnumValue: GagakuTheme.lime)
//     @Default(GagakuTheme.lime)
//     GagakuTheme theme,

//     // Grid view size
//     @Default(GridAlbumExtent.medium) GridAlbumExtent gridAlbumExtent,
//   }) = _GagakuConfig;

//   factory GagakuConfig.fromJson(Map<String, dynamic> json) =>
//       _$GagakuConfigFromJson(json);
// }

@unfreezed
@Entity()
@JsonSerializable()
class GagakuConfig with _$GagakuConfig {
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @Id()
  int dbid;

  /// Theme mode
  @override
  @Transient()
  ThemeMode themeMode;

  /// Theme color
  @override
  @JsonKey(unknownEnumValue: GagakuTheme.lime)
  @Transient()
  GagakuTheme theme;

  /// Grid view size
  @override
  @Transient()
  GridAlbumExtent gridAlbumExtent;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String get dbThemeMode => themeMode.name;

  set dbThemeMode(String value) {
    themeMode = ThemeMode.values.byName(value);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  String get dbTheme => theme.name;

  set dbTheme(String value) {
    theme = GagakuTheme.values.byName(value);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  String get dbGridAlbumExtent => gridAlbumExtent.name;

  set dbGridAlbumExtent(String value) {
    gridAlbumExtent = GridAlbumExtent.values.byName(value);
  }

  GagakuConfig({
    this.dbid = 0,
    this.themeMode = ThemeMode.system,
    this.theme = GagakuTheme.lime,
    this.gridAlbumExtent = GridAlbumExtent.medium,
  });

  factory GagakuConfig.fromJson(Map<String, dynamic> json) =>
      _$GagakuConfigFromJson(json);

  Map<String, Object?> toJson() => _$GagakuConfigToJson(this);
}

@riverpod
class GagakuSettings extends _$GagakuSettings {
  late final Query<GagakuConfig> query;

  GagakuConfig _fetch() {
    final box = GagakuData().store.box<GagakuConfig>();

    query = box.query().build();

    GagakuConfig? cfg;

    cfg = query.findUnique();

    if (cfg == null) {
      cfg = GagakuConfig();
      box.put(cfg);
    }

    ref.onDispose(() {
      query.close();
    });

    return cfg;

    // final box = Hive.box(gagakuDataBox);
    // final str = box.get('gagaku');

    // if (str == null) {
    //   return const GagakuConfig();
    // }

    // final content = json.decode(str) as Map<String, dynamic>;

    // return GagakuConfig.fromJson(content);
  }

  @override
  GagakuConfig build() {
    return _fetch();
  }

  GagakuConfig save(GagakuConfig update) {
    if (update.dbid == 0) {
      final cfg = query.findUnique();

      if (cfg != null) {
        update.dbid = cfg.dbid;
      }
    }

    state = update;

    final box = GagakuData().store.box<GagakuConfig>();
    box.put(update);

    return update;
  }
}

final gagakuConfigSaveMutation = Mutation<GagakuConfig>();
