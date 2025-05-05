import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@freezed
abstract class LocalLibConfig with _$LocalLibConfig {
  factory LocalLibConfig({@Default('') String libraryDirectory}) =
      _LocalLibConfig;

  factory LocalLibConfig.fromJson(Map<String, dynamic> json) =>
      _$LocalLibConfigFromJson(json);
}

@Riverpod(keepAlive: true)
class LocalConfig extends _$LocalConfig {
  LocalLibConfig _fetch() {
    final box = Hive.box(gagakuBox);
    final str = box.get('locallib');

    if (str == null) {
      return LocalLibConfig();
    }

    final content = json.decode(str) as Map<String, dynamic>;

    return LocalLibConfig.fromJson(content);
  }

  @override
  LocalLibConfig build() {
    return _fetch();
  }

  @mutation
  LocalLibConfig save(LocalLibConfig update) {
    state = update;
    final box = Hive.box(gagakuBox);
    box.put('locallib', json.encode(update.toJson()));

    return update;
  }
}
