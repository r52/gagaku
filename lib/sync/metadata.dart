import 'dart:convert';

import 'package:hive_ce/hive.dart';

const syncMetadataHiveKey = 'sync_metadata_v1';

final class SyncLocalState {
  SyncLocalState({
    this.enabled = false,
    this.transportKind = 'filesystem',
    this.locator = '',
    this.profileId = '',
    this.deviceId = '',
    this.deviceName = '',
    this.dirtyGeneration = 0,
    this.lastPublishedGeneration = 0,
    this.lastSeen = const {},
    this.lastBaselinePayloadHash,
    this.lastAppliedRevision,
    this.lastAppliedPayloadHash,
    this.lastAppliedAt,
    this.lastPublishedRevision,
    this.lastPublishedPayloadHash,
    this.lastPublishedAt,
    this.retryPending = false,
    this.lastError,
  });

  bool enabled;
  String transportKind;
  String locator;
  String profileId;
  String deviceId;
  String deviceName;
  int dirtyGeneration;
  int lastPublishedGeneration;
  Map<String, int> lastSeen;
  String? lastBaselinePayloadHash;
  String? lastAppliedRevision;
  String? lastAppliedPayloadHash;
  DateTime? lastAppliedAt;
  String? lastPublishedRevision;
  String? lastPublishedPayloadHash;
  DateTime? lastPublishedAt;
  bool retryPending;
  String? lastError;

  bool get hasConfiguration =>
      locator.isNotEmpty && profileId.isNotEmpty && deviceId.isNotEmpty;

  factory SyncLocalState.fromJson(Map<String, dynamic> json) {
    Map<String, int> readClock(Object? value) {
      if (value is! Map) return const {};
      return {
        for (final MapEntry(:key, :value) in value.entries)
          if (key is String && value is int && value > 0) key: value,
      };
    }

    int readGeneration(String key) {
      final value = json[key];
      return value is int && value >= 0 ? value : 0;
    }

    String readString(String key, [String fallback = '']) =>
        json[key] is String ? json[key] as String : fallback;

    String? readOptionalString(String key) =>
        json[key] is String ? json[key] as String : null;

    DateTime? readDate(String key) {
      final value = readOptionalString(key);
      return value == null ? null : DateTime.tryParse(value)?.toUtc();
    }

    final dirtyGeneration = readGeneration('dirtyGeneration');
    final lastPublishedGeneration = readGeneration('lastPublishedGeneration');
    return SyncLocalState(
      enabled: json['enabled'] == true,
      transportKind: readString('transportKind', 'filesystem'),
      locator: readString('locator'),
      profileId: readString('profileId'),
      deviceId: readString('deviceId'),
      deviceName: readString('deviceName'),
      dirtyGeneration: dirtyGeneration,
      lastPublishedGeneration: lastPublishedGeneration > dirtyGeneration
          ? dirtyGeneration
          : lastPublishedGeneration,
      lastSeen: readClock(json['lastSeen']),
      lastBaselinePayloadHash: readOptionalString('lastBaselinePayloadHash'),
      lastAppliedRevision: readOptionalString('lastAppliedRevision'),
      lastAppliedPayloadHash: readOptionalString('lastAppliedPayloadHash'),
      lastAppliedAt: readDate('lastAppliedAt'),
      lastPublishedRevision: readOptionalString('lastPublishedRevision'),
      lastPublishedPayloadHash: readOptionalString('lastPublishedPayloadHash'),
      lastPublishedAt: readDate('lastPublishedAt'),
      retryPending: json['retryPending'] == true,
      lastError: readOptionalString('lastError'),
    );
  }

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'transportKind': transportKind,
    'locator': locator,
    'profileId': profileId,
    'deviceId': deviceId,
    'deviceName': deviceName,
    'dirtyGeneration': dirtyGeneration,
    'lastPublishedGeneration': lastPublishedGeneration,
    'lastSeen': lastSeen,
    'lastBaselinePayloadHash': lastBaselinePayloadHash,
    'lastAppliedRevision': lastAppliedRevision,
    'lastAppliedPayloadHash': lastAppliedPayloadHash,
    'lastAppliedAt': lastAppliedAt?.toUtc().toIso8601String(),
    'lastPublishedRevision': lastPublishedRevision,
    'lastPublishedPayloadHash': lastPublishedPayloadHash,
    'lastPublishedAt': lastPublishedAt?.toUtc().toIso8601String(),
    'retryPending': retryPending,
    'lastError': lastError,
  };

  SyncLocalState copy() => SyncLocalState.fromJson(toJson());
}

abstract interface class SyncMetadataStore {
  Future<SyncLocalState> read();

  Future<void> write(SyncLocalState state);
}

final class HiveSyncMetadataStore implements SyncMetadataStore {
  HiveSyncMetadataStore(this.box);

  final Box<dynamic> box;

  @override
  Future<SyncLocalState> read() async {
    final value = box.get(syncMetadataHiveKey);
    if (value is! String) return SyncLocalState();
    try {
      final decoded = jsonDecode(value);
      return decoded is Map
          ? SyncLocalState.fromJson(Map<String, dynamic>.from(decoded))
          : SyncLocalState();
    } catch (_) {
      return SyncLocalState();
    }
  }

  @override
  Future<void> write(SyncLocalState state) =>
      box.put(syncMetadataHiveKey, jsonEncode(state.toJson()));
}

final class MemorySyncMetadataStore implements SyncMetadataStore {
  MemorySyncMetadataStore([SyncLocalState? initial])
    : _state = (initial ?? SyncLocalState()).copy();

  SyncLocalState _state;

  @override
  Future<SyncLocalState> read() async => _state.copy();

  @override
  Future<void> write(SyncLocalState state) async {
    _state = state.copy();
  }

  SyncLocalState get state => _state.copy();
}
