import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/web/model/types.dart' show RepoInfo, WebSourceInfo;
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'config.freezed.dart';
part 'config.g.dart';

typedef ExtensionStateMap = Map<String, Map<String, dynamic>>;

const _defaultUUID = 'e9d5c6c4-a29c-4a74-aaf2-8f2f8d2c06c2';
const _defaultCategory = WebSourceCategory(_defaultUUID, 'Default');

@JsonSerializable()
class WebSourceCategory {
  const WebSourceCategory(this.id, this.name);
  WebSourceCategory.name(this.name) : id = const Uuid().v4();

  final String id;
  final String name;

  factory WebSourceCategory.fromJson(Map<String, dynamic> json) =>
      _$WebSourceCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$WebSourceCategoryToJson(this);
}

class RepoConverter implements JsonConverter<RepoInfo, dynamic> {
  const RepoConverter();

  @override
  RepoInfo fromJson(dynamic item) {
    if (item is String) {
      return RepoInfo(name: item, url: item);
    }

    return RepoInfo.fromJson(item);
  }

  @override
  dynamic toJson(RepoInfo item) => item.toJson();
}

@freezed
abstract class WebSourceConfig with _$WebSourceConfig {
  factory WebSourceConfig({
    @Default([]) List<WebSourceInfo> installedSources,
    @RepoConverter() @Default([]) List<RepoInfo> repoList,
    @Default([_defaultCategory]) List<WebSourceCategory> categories,
    @Default(_defaultUUID) String defaultCategory,
  }) = _WebSourceConfig;

  factory WebSourceConfig.fromJson(Map<String, dynamic> json) =>
      _$WebSourceConfigFromJson(json);
}

@Riverpod(keepAlive: true)
class WebConfig extends _$WebConfig {
  WebSourceConfig _fetch() {
    final box = Hive.box(gagakuDataBox);
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

  @mutation
  WebSourceConfig saveWith({
    List<WebSourceInfo>? installedSources,
    List<RepoInfo>? repoList,
    List<WebSourceCategory>? categories,
    String? defaultCategory,
  }) {
    var update = state;

    if (installedSources != null) {
      update = update.copyWith(installedSources: installedSources);
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

    final box = Hive.box(gagakuDataBox);
    box.put('websource', json.encode(update.toJson()));

    return update;
  }

  @mutation
  WebSourceConfig save(WebSourceConfig update) {
    state = update;
    final box = Hive.box(gagakuDataBox);
    box.put('websource', json.encode(update.toJson()));

    return update;
  }
}

@Riverpod(keepAlive: true)
class ExtensionState extends _$ExtensionState {
  ExtensionStateMap _fetch() {
    final box = Hive.box(gagakuDataBox);
    final str = box.get('extension-state');

    if (str == null) {
      return {};
    }

    final content = json.decode(str) as Map<String, dynamic>;

    final result = content.cast<String, Map<String, dynamic>>();

    return result;
  }

  @override
  ExtensionStateMap build() {
    return _fetch();
  }

  dynamic getState(String sourceId, String stateName) {
    final result = state[sourceId]?[stateName];
    return result;
  }

  void setState(String sourceId, String stateName, dynamic data) {
    if (!state.containsKey(sourceId)) {
      state[sourceId] = {};
    }

    state[sourceId]![stateName] = data;

    final box = Hive.box(gagakuDataBox);
    box.put('extension-state', json.encode(state));
  }
}

@Riverpod(keepAlive: true)
class ExtensionSecureState extends _$ExtensionSecureState {
  ExtensionStateMap _fetch() {
    final box = Hive.box(gagakuDataBox);
    final str = box.get('extension-secure-state');

    if (str == null) {
      return {};
    }

    final content = json.decode(str) as Map<String, dynamic>;

    final result = content.cast<String, Map<String, dynamic>>();

    return result;
  }

  @override
  ExtensionStateMap build() {
    return _fetch();
  }

  dynamic getState(String sourceId, String stateName) {
    final result = state[sourceId]?[stateName];
    return result;
  }

  void setState(String sourceId, String stateName, dynamic data) {
    if (!state.containsKey(sourceId)) {
      state[sourceId] = {};
    }

    state[sourceId]![stateName] = data;

    final box = Hive.box(gagakuDataBox);
    box.put('extension-secure-state', json.encode(state));
  }
}
