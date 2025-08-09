// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart' show ExtensionStateDB_;
import 'package:objectbox/objectbox.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

typedef ExtensionStateMap = Map<String, Map<String, dynamic>>;

@unfreezed
abstract class ExtensionConfig with _$ExtensionConfig {
  @Entity(realClass: ExtensionConfig)
  factory ExtensionConfig({
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Id()
    @Default(0)
    int dbid,
    @Default([]) List<String> categoriesToUpdate,
  }) = _ExtensionConfig;

  factory ExtensionConfig.fromJson(Map<String, dynamic> json) =>
      _$ExtensionConfigFromJson(json);
}

@Riverpod(keepAlive: true)
class WebConfig extends _$WebConfig {
  ExtensionConfig _fetch() {
    final box = GagakuData().store.box<ExtensionConfig>();
    final query = box.query().build();

    ExtensionConfig? cfg;
    cfg = query.findUnique();
    query.close();

    if (cfg == null) {
      cfg = ExtensionConfig();
      box.put(cfg);
    }

    return cfg;
  }

  @override
  ExtensionConfig build() {
    return _fetch();
  }

  ExtensionConfig saveWith({List<String>? categoriesToUpdate}) {
    var update = state;

    if (categoriesToUpdate != null) {
      update = update.copyWith(categoriesToUpdate: categoriesToUpdate);
    }

    state = update;

    final box = GagakuData().store.box<ExtensionConfig>();
    box.put(update);

    return update;
  }

  ExtensionConfig save(ExtensionConfig update) {
    final box = GagakuData().store.box<ExtensionConfig>();

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

final webConfigSaveMutation = Mutation<ExtensionConfig>();

@Entity()
class ExtensionStateDB {
  @Id()
  int dbid;

  final bool secure;

  @Transient()
  ExtensionStateMap state;

  ExtensionStateDB({this.dbid = 0, this.secure = false, this.state = const {}});

  String get dbState => json.encode(state);

  set dbState(String value) {
    state = (json.decode(value) as Map<String, dynamic>)
        .cast<String, Map<String, dynamic>>();
  }
}

@Riverpod(keepAlive: true)
class ExtensionState extends _$ExtensionState {
  ExtensionStateDB _fetch() {
    final box = GagakuData().store.box<ExtensionStateDB>();

    final query = box.query(ExtensionStateDB_.secure.equals(false)).build();

    ExtensionStateDB? db;

    db = query.findUnique();
    query.close();

    if (db == null) {
      db = ExtensionStateDB(secure: false);
      box.put(db);
    }

    return db;
  }

  @override
  ExtensionStateDB build() {
    return _fetch();
  }

  dynamic getExtensionState(String sourceId) {
    final result = state.state[sourceId];
    return result;
  }

  void setExtensionState(String sourceId, dynamic data) {
    state.state[sourceId] = data;

    final box = GagakuData().store.box<ExtensionStateDB>();
    box.put(state);
  }

  void resetAllState(String sourceId) {
    state.state.remove(sourceId);

    final box = GagakuData().store.box<ExtensionStateDB>();
    box.put(state);
  }

  void clearAll() {
    state.state.clear();

    final box = GagakuData().store.box<ExtensionStateDB>();
    box.put(state);
  }
}

@Riverpod(keepAlive: true)
class ExtensionSecureState extends _$ExtensionSecureState {
  ExtensionStateDB _fetch() {
    final box = GagakuData().store.box<ExtensionStateDB>();

    final query = box.query(ExtensionStateDB_.secure.equals(true)).build();

    ExtensionStateDB? db;

    db = query.findUnique();
    query.close();

    if (db == null) {
      db = ExtensionStateDB(secure: true);
      box.put(db);
    }

    return db;
  }

  @override
  ExtensionStateDB build() {
    return _fetch();
  }

  dynamic getExtensionState(String sourceId) {
    final result = state.state[sourceId];
    return result;
  }

  void setExtensionState(String sourceId, dynamic data) {
    state.state[sourceId] = data;

    final box = GagakuData().store.box<ExtensionStateDB>();
    box.put(state);
  }

  void clearAll() {
    state.state.clear();

    final box = GagakuData().store.box<ExtensionStateDB>();
    box.put(state);
  }
}
