// ignore_for_file: invalid_annotation_target

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/model/types.dart';
import 'package:objectbox/objectbox.dart';
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

  /// Whether to check for updates on startup (default: true)
  @override
  bool checkForUpdates;

  /// Update check cooldown in hours: 1 (hourly), 24 (daily), 168 (weekly), 720 (monthly)
  @override
  int updateCheckCooldownHours;

  /// Update channel: 'stable' or 'beta' (default: 'stable')
  @override
  String updateChannel;

  /// List of update versions the user has explicitly ignored
  @override
  List<String> ignoredUpdates;

  /// Timestamp of the last update check (used for cooldown)
  @Property(type: PropertyType.date)
  @override
  DateTime? lastUpdateCheck;

  GagakuConfig({
    this.dbid = 0,
    this.themeMode = ThemeMode.system,
    this.theme = GagakuTheme.lime,
    this.gridAlbumExtent = GridAlbumExtent.medium,
    this.checkForUpdates = true,
    this.updateCheckCooldownHours = 24,
    this.updateChannel = 'stable',
    this.ignoredUpdates = const [],
    this.lastUpdateCheck,
  });

  factory GagakuConfig.fromJson(Map<String, dynamic> json) =>
      _$GagakuConfigFromJson(json);

  Map<String, Object?> toJson() => _$GagakuConfigToJson(this);
}

@riverpod
class GagakuSettings extends _$GagakuSettings {
  GagakuConfig _fetch() {
    final box = GagakuData().store.box<GagakuConfig>();
    final query = box.query().build();

    GagakuConfig? cfg;
    cfg = query.findUnique();
    query.close();

    if (cfg == null) {
      cfg = GagakuConfig();
      box.put(cfg);
    } else {
      // Ensure all fields are present (for backward compatibility)
      bool updated = false;

      if (cfg.updateCheckCooldownHours == 0) {
        cfg.updateCheckCooldownHours = 24;
        updated = true;
      }
      if (cfg.updateChannel.isEmpty) {
        cfg.updateChannel = 'stable';
        updated = true;
      }

      if (updated) {
        box.put(cfg);
      }
    }

    return cfg;
  }

  @override
  GagakuConfig build() {
    return _fetch();
  }

  GagakuConfig save(GagakuConfig update) {
    final box = GagakuData().store.box<GagakuConfig>();

    if (update.dbid == 0) {
      final query = box.query().build();
      final cfg = query.findUnique();
      query.close();

      if (cfg != null) {
        update.dbid = cfg.dbid;
      }
    }

    state = update;

    box.put(update);

    return update;
  }
}
