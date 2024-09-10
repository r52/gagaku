import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@unfreezed
class WebSourceConfig with _$WebSourceConfig {
  factory WebSourceConfig({
    @Default('') String sourceDirectory,
    @Default([]) List<String> repoList,
  }) = _WebSourceConfig;

  factory WebSourceConfig.fromJson(Map<String, dynamic> json) => _$WebSourceConfigFromJson(json);
}

@Riverpod(keepAlive: true)
class WebConfig extends _$WebConfig {
  WebSourceConfig _fetch() {
    final box = Hive.box(gagakuBox);
    final str = box.get('websource');

    if (str == null) {
      return WebSourceConfig();
    }

    final content = json.decode(str) as Map<String, dynamic>;

    return WebSourceConfig.fromJson(content);
  }

  @override
  WebSourceConfig build() {
    return _fetch();
  }

  void saveWith({String? sourceDirectory, List<String>? repoList}) {
    var update = state;

    if (sourceDirectory != null) {
      update = update.copyWith(sourceDirectory: sourceDirectory);
    }

    if (repoList != null) {
      update = update.copyWith(repoList: repoList);
    }

    state = update;

    final box = Hive.box(gagakuBox);
    box.put('websource', json.encode(state.toJson()));
  }

  void save(WebSourceConfig update) {
    state = update;

    final box = Hive.box(gagakuBox);
    box.put('websource', json.encode(state.toJson()));
  }
}
