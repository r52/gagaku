import 'package:flutter_test/flutter_test.dart';

import 'package:gagaku/model/config.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/settings/convert.dart';
import 'package:gagaku/sync/coordinator.dart';
import 'package:gagaku/sync/metadata.dart';
import 'package:gagaku/sync/repository.dart';
import 'package:gagaku/sync/store.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';

import 'test_support.dart';

void main() {
  test(
    'ObjectBox extension-state burst produces one debounced snapshot',
    () async {
      final objectBox = Store(
        getObjectBoxModel(),
        directory: 'memory:gagaku_sync_coordinator_burst',
      );
      final remote = MemorySyncStore();
      _seedCodecRequiredState(objectBox);
      final metadata = _metadata('device-a');
      final repository = _repository(remote, 'device-a');
      final codec = GagakuDataCodec(store: objectBox);
      final coordinator = SyncCoordinator(
        repository: repository,
        metadataStore: metadata,
        exportData: codec.export,
        importData: codec.import,
        entityChanges: objectBox.entityChanges,
        debounceDuration: const Duration(milliseconds: 20),
        foregroundCooldown: Duration.zero,
        operationTimeout: const Duration(seconds: 2),
      );
      addTearDown(() async {
        await coordinator.dispose();
        objectBox.close();
      });
      await coordinator.start();
      final box = objectBox.box<ExtensionStateDB>();
      final state = ExtensionStateDB();

      for (var index = 0; index < 10; index++) {
        state.state['synthetic-extension'] = {'operation-step': index};
        box.put(state);
      }
      await _waitFor(() => metadata.state.lastPublishedGeneration == 10);

      final discovery = await repository.discover();
      expect(discovery.deviceHeads['device-a']?.deviceSequence, 2);
      expect(
        remote.objects.keys.where((key) => key.startsWith('devices/device-a/')),
        hasLength(2),
      );
    },
  );

  test(
    'ObjectBox import events hash-suppress identical remote feedback',
    () async {
      final localObjectBox = Store(
        getObjectBoxModel(),
        directory: 'memory:gagaku_sync_coordinator_import_local',
      );
      final remoteObjectBox = Store(
        getObjectBoxModel(),
        directory: 'memory:gagaku_sync_coordinator_import_remote',
      );
      _seedCodecRequiredState(localObjectBox);
      _seedCodecRequiredState(remoteObjectBox);
      remoteObjectBox.box<GagakuConfig>().put(
        GagakuConfig(updateChannel: 'synthetic-remote'),
      );
      final remotePayload = await GagakuDataCodec(
        store: remoteObjectBox,
      ).export();
      final transport = MemorySyncStore();
      await _repository(transport, 'device-a').publish(remotePayload);
      final metadata = _metadata('device-b');
      final localCodec = GagakuDataCodec(store: localObjectBox);
      final coordinator = SyncCoordinator(
        repository: _repository(transport, 'device-b'),
        metadataStore: metadata,
        exportData: localCodec.export,
        importData: localCodec.import,
        entityChanges: localObjectBox.entityChanges,
        debounceDuration: const Duration(milliseconds: 20),
        foregroundCooldown: Duration.zero,
        operationTimeout: const Duration(seconds: 2),
      );
      addTearDown(() async {
        await coordinator.dispose();
        localObjectBox.close();
        remoteObjectBox.close();
      });

      await coordinator.start();
      await _waitFor(() => metadata.state.lastPublishedGeneration > 0);
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(
        localObjectBox.box<GagakuConfig>().getAll().single.updateChannel,
        'synthetic-remote',
      );
      expect(
        transport.objects.keys.where(
          (key) => key.startsWith('devices/device-b/'),
        ),
        isEmpty,
      );
      expect(coordinator.status.phase, SyncCoordinatorPhase.clean);
    },
  );
}

void _seedCodecRequiredState(Store store) {
  store.box<WebFavoritesList>().put(
    WebFavoritesList(id: historyListUUID, name: 'Synthetic History'),
  );
}

MemorySyncMetadataStore _metadata(String deviceId) => MemorySyncMetadataStore(
  SyncLocalState(
    enabled: true,
    profileId: 'profile-fixture',
    deviceId: deviceId,
  ),
);

SyncRepository _repository(SyncStore store, String deviceId) {
  var revision = 0;
  return SyncRepository(
    store: store,
    profileId: 'profile-fixture',
    deviceId: deviceId,
    revisionIdFactory: () => 'revision-$deviceId-${++revision}',
    now: () => DateTime.utc(2026, 1, 2, 3, 4, 5),
  );
}

Future<void> _waitFor(bool Function() condition) async {
  final deadline = DateTime.now().add(const Duration(seconds: 3));
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      fail('Timed out waiting for coordinator condition');
    }
    await Future<void>.delayed(const Duration(milliseconds: 5));
  }
}
