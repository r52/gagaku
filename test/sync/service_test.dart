import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:gagaku/sync/filesystem_store.dart';
import 'package:gagaku/sync/metadata.dart';
import 'package:gagaku/sync/profile.dart';
import 'package:gagaku/sync/repository.dart';
import 'package:gagaku/sync/service.dart';

void main() {
  test(
    'disable preserves the configured profile and device identity',
    () async {
      final metadata = MemorySyncMetadataStore(_configuredState());
      final service = GagakuSyncService.withMetadata(metadata);

      await service.disable();

      expect(metadata.state.enabled, isFalse);
      expect(metadata.state.hasConfiguration, isTrue);
      expect(metadata.state.profileId, 'profile-fixture');
      expect(metadata.state.deviceId, 'device-fixture');
      expect(metadata.state.deviceName, 'Fictional Device');
    },
  );

  test('forget is explicit and clears only local sync configuration', () async {
    final metadata = MemorySyncMetadataStore(
      _configuredState()..enabled = false,
    );
    final service = GagakuSyncService.withMetadata(metadata);

    await service.forgetConfiguration();

    expect(metadata.state.enabled, isFalse);
    expect(metadata.state.hasConfiguration, isFalse);
    expect(metadata.state.profileId, isEmpty);
    expect(metadata.state.deviceId, isEmpty);
  });

  test('forget refuses an enabled configuration', () async {
    final metadata = MemorySyncMetadataStore(_configuredState());
    final service = GagakuSyncService.withMetadata(metadata);

    await expectLater(service.forgetConfiguration(), throwsStateError);

    expect(metadata.state.enabled, isTrue);
    expect(metadata.state.hasConfiguration, isTrue);
  });

  test('retiring the final current device removes the empty profile', () async {
    final root = await Directory.systemTemp.createTemp(
      'gagaku-sync-retire-final-',
    );
    addTearDown(() => root.delete(recursive: true));
    final store = FilesystemSyncStore(root.path);
    var idIndex = 0;
    final profile = await SyncProfileManager(
      store: store,
      idFactory: () => ['probe-create', 'profile-fixture'][idIndex++],
      now: () => DateTime.utc(2026, 1, 2, 3, 4, 5),
    ).create();
    await SyncRepository(
      store: store,
      profileId: profile.profileId,
      deviceId: 'device-fixture',
      revisionIdFactory: () => 'revision-fixture',
      now: () => DateTime.utc(2026, 1, 2, 3, 4, 5),
    ).publish({
      'version': 2,
      'fixture': {'value': 'synthetic'},
    });
    final metadata = MemorySyncMetadataStore(
      _configuredState()..locator = root.path,
    );
    final service = GagakuSyncService.withMetadata(metadata);

    final failures = await service.retireDevice('device-fixture');

    expect(failures, isEmpty);
    expect(metadata.state.hasConfiguration, isFalse);
    expect(await store.list(''), isEmpty);

    idIndex = 0;
    final recreated = await SyncProfileManager(
      store: store,
      idFactory: () => ['probe-recreate', 'profile-recreated'][idIndex++],
      now: () => DateTime.utc(2026, 1, 2, 3, 5, 6),
    ).create();
    expect(recreated.profileId, 'profile-recreated');
  });
}

SyncLocalState _configuredState() => SyncLocalState(
  enabled: true,
  locator: '/synthetic/filesystem/profile',
  profileId: 'profile-fixture',
  deviceId: 'device-fixture',
  deviceName: 'Fictional Device',
  dirtyGeneration: 3,
  lastPublishedGeneration: 2,
  retryPending: true,
  lastError: 'synthetic unavailable',
);
