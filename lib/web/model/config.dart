import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/web/model/types.dart' show RepoInfo, WebSourceInfo;
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod/experimental/mutation.dart';
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
    @Default([]) List<String> categoriesToUpdate,
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

  WebSourceConfig saveWith({
    List<WebSourceInfo>? installedSources,
    List<RepoInfo>? repoList,
    List<WebSourceCategory>? categories,
    String? defaultCategory,
    List<String>? categoriesToUpdate,
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

    if (categoriesToUpdate != null) {
      update = update.copyWith(categoriesToUpdate: categoriesToUpdate);
    }

    state = update;

    final box = Hive.box(gagakuDataBox);
    box.put('websource', json.encode(update.toJson()));

    return update;
  }

  WebSourceConfig save(WebSourceConfig update) {
    state = update;
    final box = Hive.box(gagakuDataBox);
    box.put('websource', json.encode(update.toJson()));

    return update;
  }
}

final webConfigSaveMutation = Mutation<WebSourceConfig>();

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

  dynamic getExtensionState(String sourceId) {
    final result = state[sourceId];
    return result;
  }

  void setExtensionState(String sourceId, dynamic data) {
    state[sourceId] = data;

    final box = Hive.box(gagakuDataBox);
    box.put('extension-state', json.encode(state));
  }

  void resetAllState(String sourceId) {
    state.remove(sourceId);

    final box = Hive.box(gagakuDataBox);
    box.put('extension-state', json.encode(state));
  }

  void clearAll() {
    final box = Hive.box(gagakuDataBox);
    box.delete('extension-state');
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

  dynamic getExtensionState(String sourceId) {
    final result = state[sourceId];
    return result;
  }

  void setExtensionState(String sourceId, dynamic data) {
    state[sourceId] = data;

    final box = Hive.box(gagakuDataBox);
    box.put('extension-secure-state', json.encode(state));
  }

  void clearAll() {
    final box = Hive.box(gagakuDataBox);
    box.delete('extension-secure-state');
  }
}
