import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:hive_ce/hive.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:gagaku/model/model.dart';
import 'package:gagaku/settings/convert.dart';
import 'package:gagaku/settings/refresh.dart';
import 'package:gagaku/sync/coordinator.dart';
import 'package:gagaku/sync/filesystem_store.dart';
import 'package:gagaku/sync/metadata.dart';
import 'package:gagaku/sync/profile.dart';
import 'package:gagaku/sync/protocol.dart';
import 'package:gagaku/sync/repository.dart';
import 'package:gagaku/sync/saf_store.dart';
import 'package:gagaku/sync/store.dart';

enum SyncProfileMode { create, join }

final class GagakuSyncService extends ChangeNotifier {
  GagakuSyncService._();

  @visibleForTesting
  GagakuSyncService.withMetadata(SyncMetadataStore metadata)
    : _metadata = metadata;

  static final GagakuSyncService _instance = GagakuSyncService._();

  factory GagakuSyncService() => _instance;

  SyncCoordinator? _coordinator;
  _SyncLifecycleObserver? _lifecycleObserver;
  StreamSubscription<SyncCoordinatorStatus>? _statusSubscription;
  ProviderContainer? _providerContainer;
  SyncMetadataStore? _metadata;

  SyncCoordinator? get coordinator => _coordinator;
  SyncCoordinatorStatus get status =>
      _coordinator?.status ??
      const SyncCoordinatorStatus(SyncCoordinatorPhase.disabled);

  Future<SyncLocalState> readState() async =>
      (_metadata ??= HiveSyncMetadataStore(Hive.box(gagakuLocalBox))).read();

  Future<void> start(ProviderContainer providerContainer) async {
    _providerContainer = providerContainer;
    _metadata ??= HiveSyncMetadataStore(Hive.box(gagakuLocalBox));
    if (_coordinator != null) return;
    final state = await _metadata!.read();
    if (!state.enabled) {
      notifyListeners();
      return;
    }
    await _startConfigured(state);
  }

  Future<SyncProfile> configureFilesystem({
    required String rootPath,
    required SyncProfileMode mode,
    required String deviceName,
  }) {
    final store = FilesystemSyncStore(rootPath);
    return _configureStore(
      store: store,
      transportKind: 'filesystem',
      locator: store.rootPath,
      mode: mode,
      deviceName: deviceName,
    );
  }

  Future<SyncProfile> configureSaf({
    required String treeUri,
    required SyncProfileMode mode,
    required String deviceName,
  }) async {
    final store = SafSyncStore(treeUri);
    await store.checkAccess();
    return _configureStore(
      store: store,
      transportKind: 'saf',
      locator: store.treeUri,
      mode: mode,
      deviceName: deviceName,
    );
  }

  Future<SyncProfile> _configureStore({
    required SyncStore store,
    required String transportKind,
    required String locator,
    required SyncProfileMode mode,
    required String deviceName,
  }) async {
    final providerContainer = _providerContainer;
    if (providerContainer == null) {
      throw StateError('Sync service has not started');
    }
    final previous = await readState();
    await _stopCoordinator();
    late final SyncProfile profile;
    late final String deviceId;
    try {
      final manager = SyncProfileManager(store: store);
      profile = switch (mode) {
        SyncProfileMode.create => await manager.create(),
        SyncProfileMode.join => await manager.join(),
      };
      deviceId = const Uuid().v4();
      if (mode == SyncProfileMode.join) {
        await manager.probe();
        final discovery = await SyncRepository(
          store: store,
          profileId: profile.profileId,
          deviceId: deviceId,
          deviceName: deviceName,
        ).discover();
        if (discovery.selection is NoSyncHeads) {
          throw StateError('Sync profile has no valid snapshots');
        }
      }
    } catch (_) {
      if (previous.enabled) await _startConfigured(previous);
      rethrow;
    }

    final state = SyncLocalState(
      enabled: true,
      transportKind: transportKind,
      locator: locator,
      profileId: profile.profileId,
      deviceId: deviceId,
      deviceName: deviceName.trim(),
    );
    await _metadata!.write(state);
    await _startConfigured(state);
    return profile;
  }

  Future<void> syncNow() async => _coordinator?.requestSync();

  Future<void> enable() async {
    final state = await readState();
    if (state.enabled) return;
    if (_providerContainer == null) {
      throw StateError('Sync service has not started');
    }
    if (!state.hasConfiguration) {
      throw StateError('Sync configuration is incomplete');
    }
    await _stopCoordinator();

    final store = _storeForState(state);
    final manager = SyncProfileManager(store: store);
    final profile = await manager.join();
    if (profile.profileId != state.profileId) {
      throw const SyncValidationException('profile ID mismatch');
    }
    await manager.probe();
    final discovery = await SyncRepository(
      store: store,
      profileId: state.profileId,
      deviceId: state.deviceId,
      deviceName: state.deviceName,
    ).discover();
    if (discovery.selection is NoSyncHeads) {
      throw StateError('Sync profile has no valid snapshots');
    }

    final wasProfileMissing = state.profileMissing;
    state
      ..enabled = true
      ..profileMissing = false;
    await _metadata!.write(state);
    try {
      await _startConfigured(state);
    } catch (_) {
      await _stopCoordinator();
      state
        ..enabled = false
        ..profileMissing = wasProfileMissing;
      await _metadata!.write(state);
      rethrow;
    }
    notifyListeners();
  }

  Future<void> resolveFork(SyncSnapshot selected) async =>
      _coordinator?.resolveFork(selected);

  Future<SyncDiscovery?> discover() async =>
      _coordinator?.repository.discover();

  Future<void> renameDevice(String name) async {
    final coordinator = _coordinator;
    if (coordinator != null) {
      await coordinator.renameDevice(name);
    } else {
      final state = await readState();
      state.deviceName = name.trim();
      await _metadata!.write(state);
    }
    notifyListeners();
  }

  Future<List<String>> retireDevice(String deviceId) async {
    final state = await readState();
    await _stopCoordinator();
    try {
      final store = _storeForState(state);
      final profileManager = SyncProfileManager(store: store);
      final profile = await profileManager.join();
      if (profile.profileId != state.profileId) {
        throw const SyncValidationException('profile ID mismatch');
      }
      final failures = List<String>.of(
        await SyncRepository(
          store: store,
          profileId: state.profileId,
          deviceId: state.deviceId,
        ).retireDevice(deviceId),
      );
      if (deviceId == state.deviceId && failures.isEmpty) {
        final remaining = await store.list('devices/');
        if (remaining.isEmpty) {
          final reset = await profileManager.reset(state.profileId);
          failures.addAll(reset.failures);
        }
      }
      if (deviceId == state.deviceId && failures.isEmpty) {
        await _metadata!.write(SyncLocalState());
      } else if (state.enabled) {
        await _startConfigured(state);
      }
      notifyListeners();
      return failures;
    } catch (_) {
      if (state.enabled && _coordinator == null) {
        await _startConfigured(state);
      }
      rethrow;
    }
  }

  Future<SyncRepairResult> repairRemote() async {
    final state = await readState();
    await _stopCoordinator();
    try {
      return await SyncProfileManager(
        store: _storeForState(state),
      ).repair(state.profileId);
    } finally {
      if (state.enabled && _coordinator == null) {
        await _startConfigured(state);
      }
    }
  }

  Future<SyncResetResult> resetRemote() async {
    final state = await readState();
    await _stopCoordinator();
    try {
      final result = await SyncProfileManager(
        store: _storeForState(state),
      ).reset(state.profileId);
      if (result.failures.isEmpty) {
        await _metadata!.write(SyncLocalState());
      } else if (state.enabled) {
        await _startConfigured(state);
      }
      notifyListeners();
      return result;
    } catch (_) {
      if (state.enabled && _coordinator == null) {
        await _startConfigured(state);
      }
      rethrow;
    }
  }

  Future<void> disable() async {
    await _stopCoordinator();
    final state = await readState();
    state
      ..enabled = false
      ..profileMissing = false
      ..retryPending = false
      ..lastError = null;
    await _metadata!.write(state);
    notifyListeners();
  }

  Future<void> forgetConfiguration() async {
    final state = await readState();
    if (state.enabled) {
      throw StateError('Disable sync before forgetting its configuration');
    }
    await _stopCoordinator();
    await _metadata!.write(SyncLocalState());
    notifyListeners();
  }

  Future<void> _startConfigured(SyncLocalState state) async {
    final providerContainer = _providerContainer!;
    if (!const {'filesystem', 'saf'}.contains(state.transportKind) ||
        state.locator.isEmpty ||
        state.profileId.isEmpty ||
        state.deviceId.isEmpty) {
      state
        ..retryPending = true
        ..lastError = 'Incomplete sync configuration';
      await _metadata!.write(state);
      notifyListeners();
      return;
    }

    final syncStore = _storeForState(state);
    final profileManager = SyncProfileManager(store: syncStore);
    final codec = GagakuDataCodec(store: GagakuData().store);
    final coordinator = SyncCoordinator(
      repository: SyncRepository(
        store: syncStore,
        profileId: state.profileId,
        deviceId: state.deviceId,
        deviceName: state.deviceName,
      ),
      validateProfile: () => profileManager.hasExpectedProfile(state.profileId),
      metadataStore: _metadata!,
      exportData: codec.export,
      importData: (payload) => codec.import(
        payload,
        refresh: () => refreshImportedGagakuData(providerContainer),
      ),
      entityChanges: GagakuData().store.entityChanges,
      operationTimeout: state.transportKind == 'saf'
          ? const Duration(seconds: 30)
          : const Duration(seconds: 5),
    );
    _coordinator = coordinator;
    _statusSubscription = coordinator.statuses.listen((_) => notifyListeners());
    final observer = _SyncLifecycleObserver(coordinator);
    _lifecycleObserver = observer;
    WidgetsBinding.instance.addObserver(observer);
    notifyListeners();

    await coordinator.start().timeout(
      const Duration(seconds: 5),
      onTimeout: () {},
    );
    notifyListeners();
  }

  SyncStore _storeForState(SyncLocalState state) =>
      switch (state.transportKind) {
        'filesystem' => FilesystemSyncStore(state.locator),
        'saf' => SafSyncStore(state.locator),
        final kind => throw StateError('Unsupported sync transport: $kind'),
      };

  Future<void> _stopCoordinator() async {
    final observer = _lifecycleObserver;
    if (observer != null) WidgetsBinding.instance.removeObserver(observer);
    _lifecycleObserver = null;
    await _statusSubscription?.cancel();
    _statusSubscription = null;
    await _coordinator?.dispose();
    _coordinator = null;
  }

  Future<void> stop() async {
    await _stopCoordinator();
    _providerContainer = null;
    notifyListeners();
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
