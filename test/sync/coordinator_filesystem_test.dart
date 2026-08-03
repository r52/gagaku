import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:gagaku/sync/coordinator.dart';
import 'package:gagaku/sync/filesystem_store.dart';
import 'package:gagaku/sync/metadata.dart';
import 'package:gagaku/sync/repository.dart';

void main() {
  test(
    'two live coordinators hand off automatically through one directory',
    () async {
      final root = await Directory.systemTemp.createTemp(
        'gagaku-sync-coordinator-',
      );
      final deviceA = await _DeviceHarness.start(root, 'device-a', 'initial-a');
      final deviceB = await _DeviceHarness.start(root, 'device-b', 'initial-b');
      addTearDown(() async {
        await deviceA.dispose();
        await deviceB.dispose();
        if (await root.exists()) await root.delete(recursive: true);
      });
      expect(deviceB.data.payload, _payload('initial-a'));

      deviceA.data.payload = _payload('changed-on-a');
      deviceA.changes.add(null);
      await _waitFor(() => deviceA.metadata.state.lastPublishedGeneration == 1);
      await deviceB.coordinator.onResume();
      expect(deviceB.data.payload, _payload('changed-on-a'));

      deviceB.data.payload = _payload('changed-on-b');
      deviceB.changes.add(null);
      await _waitFor(() => deviceB.metadata.state.lastPublishedGeneration >= 1);
      await deviceA.coordinator.onResume();

      expect(deviceA.data.payload, _payload('changed-on-b'));
      expect(deviceA.coordinator.status.phase, SyncCoordinatorPhase.clean);
      expect(deviceB.coordinator.status.phase, SyncCoordinatorPhase.clean);
    },
  );
}

final class _DeviceHarness {
  _DeviceHarness({
    required this.metadata,
    required this.data,
    required this.changes,
    required this.coordinator,
  });

  final MemorySyncMetadataStore metadata;
  final _Data data;
  final StreamController<Object?> changes;
  final SyncCoordinator coordinator;

  static Future<_DeviceHarness> start(
    Directory root,
    String deviceId,
    String initialValue,
  ) async {
    final metadata = MemorySyncMetadataStore(
      SyncLocalState(
        enabled: true,
        profileId: 'profile-fixture',
        deviceId: deviceId,
      ),
    );
    final data = _Data(_payload(initialValue));
    final changes = StreamController<Object?>.broadcast(sync: true);
    var revision = 0;
    final coordinator = SyncCoordinator(
      repository: SyncRepository(
        store: FilesystemSyncStore(root.path),
        profileId: 'profile-fixture',
        deviceId: deviceId,
        revisionIdFactory: () => 'revision-$deviceId-${++revision}',
        now: () => DateTime.utc(2026, 1, 2, 3, 4, 5),
      ),
      metadataStore: metadata,
      exportData: data.export,
      importData: data.import,
      entityChanges: changes.stream,
      debounceDuration: const Duration(milliseconds: 20),
      operationTimeout: const Duration(seconds: 2),
    );
    final harness = _DeviceHarness(
      metadata: metadata,
      data: data,
      changes: changes,
      coordinator: coordinator,
    );
    await coordinator.start();
    return harness;
  }

  Future<void> dispose() async {
    await coordinator.dispose();
    await changes.close();
  }
}

final class _Data {
  _Data(this.payload);

  Map<String, dynamic> payload;

  Future<Map<String, dynamic>> export() async => _copy(payload);

  Future<void> import(Map<String, dynamic> value) async {
    payload = _copy(value);
  }
}

Map<String, dynamic> _payload(String value) => {
  'version': 2,
  'fixture': {'value': value},
};

Map<String, dynamic> _copy(Map<String, dynamic> value) =>
    Map<String, dynamic>.from(jsonDecode(jsonEncode(value)) as Map);

Future<void> _waitFor(bool Function() condition) async {
  final deadline = DateTime.now().add(const Duration(seconds: 3));
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      fail('Timed out waiting for automatic filesystem sync');
    }
    await Future<void>.delayed(const Duration(milliseconds: 5));
  }
}
