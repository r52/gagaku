import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@freezed
abstract class ReaderConfig with _$ReaderConfig {
  const factory ReaderConfig({
    /// Reader format
    @Default(ReaderFormat.single) ReaderFormat format,

    /// Reader direction
    @Default(ReaderDirection.leftToRight) ReaderDirection direction,

    /// Displays progress bar if true (default false)
    @Default(false) bool showProgressBar,

    /// Enable click/tap to turn page gesture
    @Default(true) bool clickToTurn,

    /// Enable swipe gestures
    @Default(true) bool swipeGestures,

    /// The number of images/pages to preload
    @Default(3) int precacheCount,
  }) = _ReaderConfig;

  factory ReaderConfig.fromJson(Map<String, dynamic> json) =>
      _$ReaderConfigFromJson(json);
}

@riverpod
class ReaderSettings extends _$ReaderSettings {
  ReaderConfig _fetch() {
    final box = Hive.box(gagakuBox);
    final str = box.get('reader');

    if (str == null) {
      return const ReaderConfig();
    }

    final content = json.decode(str) as Map<String, dynamic>;

    return ReaderConfig.fromJson(content);
  }

  @override
  ReaderConfig build() {
    return _fetch();
  }

  @mutation
  ReaderConfig save(ReaderConfig update) {
    state = update;
    final box = Hive.box(gagakuBox);
    box.put('reader', json.encode(update.toJson()));

    return update;
  }
}
