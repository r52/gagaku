import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:gagaku/sync/filesystem_store.dart';
import 'package:gagaku/sync/profile.dart';
import 'package:gagaku/sync/protocol.dart';
import 'package:gagaku/sync/store.dart';

void main() {
  test('creates, probes, rereads, and joins an immutable profile', () async {
    final store = MemorySyncStore();
    final ids = ['probe-create', 'profile-fixture', 'probe-join'].iterator;
    final manager = SyncProfileManager(
      store: store,
      idFactory: () {
        ids.moveNext();
        return ids.current;
      },
      now: () => DateTime.utc(2026, 1, 2, 3, 4, 5),
    );

    final created = await manager.create();
    await manager.probe();
    final joined = await manager.join();

    expect(created.profileId, 'profile-fixture');
    expect(joined.profileId, created.profileId);
    expect(joined.createdAt, DateTime.utc(2026, 1, 2, 3, 4, 5));
    expect(await manager.hasExpectedProfile(created.profileId), isTrue);
    expect(store.objects.keys, [SyncProfileCodec.key]);
  });

  test('refuses non-empty and incompatible profile directories', () async {
    final nonEmpty = MemorySyncStore()
      ..seed('unrelated-file.txt', utf8.encode('synthetic'));
    await expectLater(
      SyncProfileManager(store: nonEmpty).create(),
      throwsStateError,
    );

    final incompatible = MemorySyncStore()
      ..seed(
        SyncProfileCodec.key,
        utf8.encode(
          jsonEncode({
            'format': SyncProfileCodec.format,
            'protocolVersion': 2,
            'profileId': 'profile-fixture',
            'createdAt': DateTime.utc(2026).toIso8601String(),
          }),
        ),
      );
    await expectLater(
      SyncProfileManager(store: incompatible).join(),
      throwsA(isA<SyncValidationException>()),
    );
  });

  test('creates beside Syncthing metadata without modifying it', () async {
    final root = await Directory.systemTemp.createTemp(
      'gagaku-sync-syncthing-metadata-',
    );
    addTearDown(() => root.delete(recursive: true));
    final marker = File('${root.path}/.stfolder/marker')
      ..createSync(recursive: true)
      ..writeAsStringSync('synthetic marker');
    final version = File('${root.path}/.stversion/state')
      ..createSync(recursive: true)
      ..writeAsStringSync('synthetic version state');
    File(
      '${root.path}/.stignore',
    ).writeAsStringSync('// synthetic ignore rules');
    var idIndex = 0;

    final profile = await SyncProfileManager(
      store: FilesystemSyncStore(root.path),
      idFactory: () => ['probe-fixture', 'profile-fixture'][idIndex++],
      now: () => DateTime.utc(2026, 1, 2, 3, 4, 5),
    ).create();

    expect(profile.profileId, 'profile-fixture');
    expect(marker.readAsStringSync(), 'synthetic marker');
    expect(version.readAsStringSync(), 'synthetic version state');
    expect(File('${root.path}/.stignore').existsSync(), isTrue);
    expect(File('${root.path}/${SyncProfileCodec.key}').existsSync(), isTrue);
  });

  test(
    'repair deletes invalid and excess snapshots but retains two per device',
    () async {
      final store = MemorySyncStore();
      _seedProfile(store);
      final snapshots = [
        for (var sequence = 1; sequence <= 4; sequence++)
          _snapshot('device-a', sequence),
        for (var sequence = 1; sequence <= 2; sequence++)
          _snapshot('device-b', sequence),
      ];
      for (final snapshot in snapshots) {
        store.seed(snapshot.key, SyncSnapshotCodec.encode(snapshot));
      }
      store
        ..seed('devices/device-a/corrupt.snapshot', [1, 2, 3])
        ..seed('unrelated-file.txt', [4, 5, 6]);

      final result = await SyncProfileManager(
        store: store,
      ).repair('profile-fixture');

      expect(result.failures, isEmpty);
      expect(result.deleted, hasLength(3));
      expect(store.objects, contains(SyncProfileCodec.key));
      expect(store.objects, contains('unrelated-file.txt'));
      expect(
        store.objects.keys.where((key) => key.startsWith('devices/device-a/')),
        hasLength(2),
      );
      expect(
        store.objects.keys.where((key) => key.startsWith('devices/device-b/')),
        hasLength(2),
      );
    },
  );

  test(
    'reset deletes only profile-owned objects and keeps profile on failure',
    () async {
      final store = MemorySyncStore();
      _seedProfile(store);
      final snapshot = _snapshot('device-a', 1);
      store
        ..seed(snapshot.key, SyncSnapshotCodec.encode(snapshot))
        ..seed('unrelated-file.txt', [1]);
      store.deleteFailures.add(snapshot.key);
      final manager = SyncProfileManager(store: store);

      final failed = await manager.reset('profile-fixture');

      expect(failed.failures, [snapshot.key]);
      expect(store.objects, contains(SyncProfileCodec.key));
      store.deleteFailures.clear();

      final succeeded = await manager.reset('profile-fixture');

      expect(succeeded.failures, isEmpty);
      expect(store.objects, contains('unrelated-file.txt'));
      expect(store.objects, isNot(contains(SyncProfileCodec.key)));
      expect(
        store.objects.keys.where((key) => key.startsWith('devices/')),
        isEmpty,
      );
    },
  );
}

void _seedProfile(MemorySyncStore store) {
  store.seed(
    SyncProfileCodec.key,
    SyncProfileCodec.encode(
      SyncProfile(
        profileId: 'profile-fixture',
        createdAt: DateTime.utc(2026, 1, 2, 3, 4, 5),
      ),
    ),
  );
}

SyncSnapshot _snapshot(String deviceId, int sequence) =>
    SyncSnapshotCodec.create(
      profileId: 'profile-fixture',
      deviceId: deviceId,
      deviceSequence: sequence,
      revisionId: 'revision-$deviceId-$sequence',
      createdAt: DateTime.utc(2026, 1, 2, 3, 4, 5),
      seen: {deviceId: sequence},
      payload: {
        'version': 2,
        'fixture': {'sequence': sequence},
      },
    );
