import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:hive_ce/hive.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod/riverpod.dart';

import 'package:gagaku/model/model.dart';
import 'package:gagaku/settings/convert.dart';
import 'package:gagaku/settings/refresh.dart';
import 'package:gagaku/sync/coordinator.dart';
import 'package:gagaku/sync/filesystem_store.dart';
import 'package:gagaku/sync/metadata.dart';
import 'package:gagaku/sync/repository.dart';

final class GagakuSyncService {
  GagakuSyncService._();

  static final GagakuSyncService _instance = GagakuSyncService._();

  factory GagakuSyncService() => _instance;

  SyncCoordinator? _coordinator;
  _SyncLifecycleObserver? _lifecycleObserver;

  SyncCoordinator? get coordinator => _coordinator;

  Future<void> start(ProviderContainer providerContainer) async {
    if (_coordinator != null) return;
    final metadata = HiveSyncMetadataStore(Hive.box(gagakuLocalBox));
    final state = await metadata.read();
    if (!state.enabled) return;
    if (state.transportKind != 'filesystem' ||
        state.locator.isEmpty ||
        state.profileId.isEmpty ||
        state.deviceId.isEmpty) {
      state
        ..retryPending = true
        ..lastError = 'Incomplete filesystem sync configuration';
      await metadata.write(state);
      return;
    }

    final codec = GagakuDataCodec(store: GagakuData().store);
    final coordinator = SyncCoordinator(
      repository: SyncRepository(
        store: FilesystemSyncStore(state.locator),
        profileId: state.profileId,
        deviceId: state.deviceId,
      ),
      metadataStore: metadata,
      exportData: codec.export,
      importData: (payload) => codec.import(
        payload,
        refresh: () => refreshImportedGagakuData(providerContainer),
      ),
      entityChanges: GagakuData().store.entityChanges,
    );
    _coordinator = coordinator;
    final observer = _SyncLifecycleObserver(coordinator);
    _lifecycleObserver = observer;
    WidgetsBinding.instance.addObserver(observer);

    // Filesystem startup is normally immediate. The coordinator keeps its
    // serialized operation alive after this gate so a slow/unavailable mount
    // cannot prevent the local application from starting.
    await coordinator.start().timeout(
      const Duration(seconds: 5),
      onTimeout: () {},
    );
  }

  Future<void> stop() async {
    final observer = _lifecycleObserver;
    if (observer != null) WidgetsBinding.instance.removeObserver(observer);
    _lifecycleObserver = null;
    await _coordinator?.dispose();
    _coordinator = null;
  }
}

final class _SyncLifecycleObserver with WidgetsBindingObserver {
  _SyncLifecycleObserver(this.coordinator);

  final SyncCoordinator coordinator;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        unawaited(coordinator.onResume());
      case AppLifecycleState.inactive ||
          AppLifecycleState.hidden ||
          AppLifecycleState.paused ||
          AppLifecycleState.detached:
        unawaited(coordinator.onPause());
    }
  }
}
