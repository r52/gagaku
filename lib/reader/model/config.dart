import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@unfreezed
@Entity()
@JsonSerializable()
class ReaderConfig with _$ReaderConfig {
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @Id()
  int dbid;

  /// Reader format
  @override
  @Transient()
  ReaderFormat format;

  /// Reader direction
  @override
  @Transient()
  ReaderDirection direction;

  /// Displays progress bar if true (default false)
  @override
  bool showProgressBar;

  /// Enable click/tap to turn page gesture
  @override
  bool clickToTurn;

  /// Enable swipe gestures
  @override
  bool swipeGestures;

  /// The number of images/pages to preload
  @override
  int precacheCount;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String get dbFormat => format.name;

  set dbFormat(String value) {
    format = ReaderFormat.values.byName(value);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  String get dbDirection => direction.name;

  set dbDirection(String value) {
    direction = ReaderDirection.values.byName(value);
  }

  ReaderConfig({
    this.dbid = 0,
    this.format = ReaderFormat.single,
    this.direction = ReaderDirection.leftToRight,
    this.showProgressBar = false,
    this.clickToTurn = true,
    this.swipeGestures = true,
    this.precacheCount = 3,
  });

  factory ReaderConfig.fromJson(Map<String, dynamic> json) =>
      _$ReaderConfigFromJson(json);

  Map<String, Object?> toJson() => _$ReaderConfigToJson(this);
}

@riverpod
class ReaderSettings extends _$ReaderSettings {
  ReaderConfig _fetch() {
    final box = GagakuData().store.box<ReaderConfig>();
    final query = box.query().build();

    ReaderConfig? cfg;
    cfg = query.findUnique();
    query.close();

    if (cfg == null) {
      cfg = ReaderConfig();
      box.put(cfg);
    }

    return cfg;
  }

  @override
  ReaderConfig build() {
    return _fetch();
  }

  ReaderConfig save(ReaderConfig update) {
    final box = GagakuData().store.box<ReaderConfig>();

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

final readerConfigSaveMutation = Mutation<ReaderConfig>();
