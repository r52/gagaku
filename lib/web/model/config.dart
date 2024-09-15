import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'config.freezed.dart';
part 'config.g.dart';

const _defaultUUID = 'e9d5c6c4-a29c-4a74-aaf2-8f2f8d2c06c2';
const _defaultCategory = WebSourceCategory(_defaultUUID, 'Default');

@JsonSerializable()
class WebSourceCategory {
  const WebSourceCategory(this.id, this.name);
  WebSourceCategory.name(this.name) : id = const Uuid().v4();

  final String id;
  final String name;

  factory WebSourceCategory.fromJson(Map<String, dynamic> json) => _$WebSourceCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$WebSourceCategoryToJson(this);
}

@unfreezed
class WebSourceConfig with _$WebSourceConfig {
  factory WebSourceConfig({
    @Default('') String sourceDirectory,
    @Default([]) List<String> repoList,
    @Default([_defaultCategory]) List<WebSourceCategory> categories,
    @Default(_defaultUUID) String defaultCategory,
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

  void saveWith({
    String? sourceDirectory,
    List<String>? repoList,
    List<WebSourceCategory>? categories,
    String? defaultCategory,
  }) {
    var update = state;

    if (sourceDirectory != null) {
      update = update.copyWith(sourceDirectory: sourceDirectory);
    }

    if (repoList != null) {
      update = update.copyWith(repoList: repoList);
    }

    if (categories != null) {
      update = update.copyWith(categories: categories);
    }

    if (defaultCategory != null) {
      update = update.copyWith(defaultCategory: defaultCategory);
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
