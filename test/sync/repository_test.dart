import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/sync/protocol.dart';
import 'package:gagaku/sync/repository.dart';
import 'package:gagaku/sync/store.dart';

void main() {
  group('SyncRepository discovery', () {
    test(
      'falls back from a corrupt newest object to the latest valid head',
      () async {
        final store = MemorySyncStore();
        final repository = _repository(store, 'device-a', [
          'revision-a1',
          'revision-a2',
        ]);
        await repository.publish(_payload('first'));
        final second = await repository.publish(_payload('second'));
        store.seed(
          SyncSnapshotCodec.objectKey(
            deviceId: 'device-a',
            deviceSequence: 3,
            revisionId: 'revision-a3',
          ),
          [1, 2, 3],
        );

        final discovery = await repository.discover();

        expect(discovery.invalidObjects, hasLength(1));
        expect(discovery.deviceHeads['device-a']?.key, second.snapshot.key);
        expect(
          discovery.selection,
          isA<CanonicalSyncHead>().having(
            (selection) => selection.head.key,
            'head key',
            second.snapshot.key,
          ),
        );
      },
    );

    test('is deterministic when transport listings are reversed', () async {
      final normalStore = MemorySyncStore();
      final normal = _repository(normalStore, 'device-a', ['revision-a1']);
      final published = await normal.publish(_payload('same'));
      final reversedStore = MemorySyncStore(reverseListings: true)
        ..seed(
          published.snapshot.key,
          normalStore.objects[published.snapshot.key]!,
        );
      final reversed = _repository(reversedStore, 'device-a', ['unused']);

      final normalDiscovery = await normal.discover();
      final reversedDiscovery = await reversed.discover();

      expect(
        (reversedDiscovery.selection as CanonicalSyncHead).head.key,
        (normalDiscovery.selection as CanonicalSyncHead).head.key,
      );
    });
  });

  group('SyncRepository publication', () {
    test('supports a sequential two-device handoff', () async {
      final store = MemorySyncStore();
      final deviceA = _repository(store, 'device-a', [
        'revision-a1',
        'revision-a2',
      ]);
      final deviceB = _repository(store, 'device-b', ['revision-b1']);

      final first = await deviceA.publish(_payload('from-a'));
      final second = await deviceB.publish(_payload('from-b'));
      final third = await deviceA.publish(_payload('back-to-a'));
      final discovery = await deviceB.discover();

      expect(first.snapshot.seen, {'device-a': 1});
      expect(second.snapshot.seen, {'device-a': 1, 'device-b': 1});
      expect(third.snapshot.seen, {'device-a': 2, 'device-b': 1});
      expect(
        (discovery.selection as CanonicalSyncHead).head.payload,
        _payload('back-to-a'),
      );
    });

    test('retains only the newest two valid local snapshots', () async {
      final store = MemorySyncStore();
      final repository = _repository(store, 'device-a', [
        'revision-a1',
        'revision-a2',
        'revision-a3',
      ]);

      final first = await repository.publish(_payload('first'));
      final second = await repository.publish(_payload('second'));
      final third = await repository.publish(_payload('third'));

      expect(store.objects, isNot(contains(first.snapshot.key)));
      expect(store.objects, contains(second.snapshot.key));
      expect(store.objects, contains(third.snapshot.key));
      expect(
        store.objects.keys.where((key) => key.startsWith('devices/device-a/')),
        hasLength(2),
      );
    });

    test(
      'does not compact before a newly created object passes readback',
      () async {
        final delegate = MemorySyncStore();
        final store = _CorruptingCreateStore(delegate);
        final repository = _repository(store, 'device-a', [
          'revision-a1',
          'revision-a2',
          'revision-a3',
        ]);
        final first = await repository.publish(_payload('first'));
        final second = await repository.publish(_payload('second'));
        store.corruptNextCreate = true;

        await expectLater(
          repository.publish(_payload('third')),
          throwsA(isA<SyncValidationException>()),
        );

        expect(delegate.objects, contains(first.snapshot.key));
        expect(delegate.objects, contains(second.snapshot.key));
        expect(
          delegate.objects.keys.where(
            (key) => key.startsWith('devices/device-a/'),
          ),
          hasLength(3),
        );
        final discovery = await repository.discover();
        expect(discovery.invalidObjects, hasLength(1));
        expect(discovery.deviceHeads['device-a']?.key, second.snapshot.key);
      },
    );

    test(
      'reports cleanup failures without failing publication and retries later',
      () async {
        final store = MemorySyncStore();
        final repository = _repository(store, 'device-a', [
          'revision-a1',
          'revision-a2',
          'revision-a3',
          'revision-a4',
        ]);
        final first = await repository.publish(_payload('first'));
        await repository.publish(_payload('second'));
        store.deleteFailures.add(first.snapshot.key);

        final third = await repository.publish(_payload('third'));

        expect(third.cleanupFailures, [first.snapshot.key]);
        expect(store.objects, hasLength(3));
        store.deleteFailures.clear();

        await repository.publish(_payload('fourth'));

        expect(store.objects, hasLength(2));
        expect(store.objects, isNot(contains(first.snapshot.key)));
      },
    );

    test('compaction never removes another device namespace', () async {
      final store = MemorySyncStore();
      final deviceB = _snapshot(
        deviceId: 'device-b',
        sequence: 1,
        revisionId: 'revision-b1',
        seen: {'device-b': 1},
        value: 'foreign',
      );
      store.seed(deviceB.key, SyncSnapshotCodec.encode(deviceB));
      final repository = _repository(store, 'device-a', [
        'revision-a1',
        'revision-a2',
        'revision-a3',
      ]);

      await repository.publish(_payload('first'));
      await repository.publish(_payload('second'));
      await repository.publish(_payload('third'));

      expect(store.objects, contains(deviceB.key));
    });

    test(
      'removes resurrected dominated snapshots on the next publication',
      () async {
        final store = MemorySyncStore();
        final repository = _repository(store, 'device-a', [
          'revision-a1',
          'revision-a2',
          'revision-a3',
          'revision-a4',
        ]);
        final first = await repository.publish(_payload('first'));
        final firstBytes = store.objects[first.snapshot.key]!;
        await repository.publish(_payload('second'));
        await repository.publish(_payload('third'));
        expect(store.objects, isNot(contains(first.snapshot.key)));
        store.seed(first.snapshot.key, firstBytes);

        await repository.publish(_payload('fourth'));

        expect(store.objects, isNot(contains(first.snapshot.key)));
        expect(store.objects, hasLength(2));
      },
    );
  });

  group('SyncRepository concurrent heads', () {
    test('normalizes same-payload concurrent heads', () async {
      final store = MemorySyncStore();
      final deviceA = _snapshot(
        deviceId: 'device-a',
        sequence: 1,
        revisionId: 'revision-a1',
        seen: {'device-a': 1},
        value: 'shared',
      );
      final deviceB = _snapshot(
        deviceId: 'device-b',
        sequence: 1,
        revisionId: 'revision-b1',
        seen: {'device-b': 1},
        value: 'shared',
      );
      store
        ..seed(deviceA.key, SyncSnapshotCodec.encode(deviceA))
        ..seed(deviceB.key, SyncSnapshotCodec.encode(deviceB));
      final repository = _repository(store, 'device-a', ['revision-a2']);

      expect(
        (await repository.discover()).selection,
        isA<EquivalentSyncHeads>(),
      );
      final result = await repository.normalizeEquivalentHeads();
      final discovery = await repository.discover();

      expect(result.snapshot.seen, {'device-a': 2, 'device-b': 1});
      expect(result.snapshot.payload, _payload('shared'));
      expect(
        (discovery.selection as CanonicalSyncHead).head.key,
        result.snapshot.key,
      );
    });

    test(
      'requires fork resolution and publishes the selected whole payload',
      () async {
        final store = MemorySyncStore();
        final left = _snapshot(
          deviceId: 'device-a',
          sequence: 2,
          revisionId: 'revision-a2',
          seen: {'device-a': 2},
          value: 'left',
        );
        final right = _snapshot(
          deviceId: 'device-b',
          sequence: 1,
          revisionId: 'revision-b1',
          seen: {'device-a': 1, 'device-b': 1},
          value: 'right',
        );
        store
          ..seed(left.key, SyncSnapshotCodec.encode(left))
          ..seed(right.key, SyncSnapshotCodec.encode(right));
        final repository = _repository(store, 'device-a', ['revision-a3']);

        await expectLater(
          repository.publish(_payload('unresolved')),
          throwsA(isA<SyncForkException>()),
        );
        final discovery = await repository.discover();
        final fork = discovery.selection as ForkedSyncHeads;
        final selected = fork.heads.singleWhere(
          (head) => head.key == right.key,
        );
        final resolved = await repository.resolveFork(selected);

        expect(resolved.snapshot.seen, {'device-a': 3, 'device-b': 1});
        expect(resolved.snapshot.payload, _payload('right'));
        expect(
          (await repository.discover()).selection,
          isA<CanonicalSyncHead>(),
        );
      },
    );
  });

  group('SyncRepository device retirement', () {
    test('deletes only the explicitly selected device namespace', () async {
      final store = MemorySyncStore();
      final deviceA = _snapshot(
        deviceId: 'device-a',
        sequence: 1,
        revisionId: 'revision-a1',
        seen: {'device-a': 1},
        value: 'a',
      );
      final deviceB = _snapshot(
        deviceId: 'device-b',
        sequence: 1,
        revisionId: 'revision-b1',
        seen: {'device-b': 1},
        value: 'b',
      );
      store
        ..seed(deviceA.key, SyncSnapshotCodec.encode(deviceA))
        ..seed(deviceB.key, SyncSnapshotCodec.encode(deviceB));
      final repository = _repository(store, 'device-a', ['unused']);

      expect(await repository.retireDevice('device-b'), isEmpty);

      expect(store.objects, contains(deviceA.key));
      expect(store.objects, isNot(contains(deviceB.key)));
      await expectLater(
        repository.retireDevice('../device-a'),
        throwsArgumentError,
      );
    });
  });
}

SyncRepository _repository(
  SyncStore store,
  String deviceId,
  List<String> revisions,
) {
  final remaining = Queue<String>.of(revisions);
  return SyncRepository(
    store: store,
    profileId: 'profile-fixture',
    deviceId: deviceId,
    revisionIdFactory: () => remaining.removeFirst(),
    now: () => DateTime.utc(2026, 1, 2, 3, 4, 5),
  );
}

SyncSnapshot _snapshot({
  required String deviceId,
  required int sequence,
  required String revisionId,
  required Map<String, int> seen,
  required String value,
}) => SyncSnapshotCodec.create(
  profileId: 'profile-fixture',
  deviceId: deviceId,
  deviceSequence: sequence,
  revisionId: revisionId,
  createdAt: DateTime.utc(2026, 1, 2, 3, 4, 5),
  seen: seen,
  payload: _payload(value),
);

Map<String, dynamic> _payload(String value) => {
  'version': 2,
  'fixture': {'value': value},
};

final class _CorruptingCreateStore implements SyncStore {
  _CorruptingCreateStore(this.delegate);

  final MemorySyncStore delegate;
  bool corruptNextCreate = false;

  @override
  Future<void> create(String key, List<int> bytes) async {
    await delegate.create(key, bytes);
    if (corruptNextCreate) {
      corruptNextCreate = false;
      delegate.seed(key, [1, 2, 3]);
    }
  }

  @override
  Future<void> delete(String key) => delegate.delete(key);

  @override
  Future<List<SyncObject>> list(String prefix) => delegate.list(prefix);

  @override
  Future<List<int>> read(String key) => delegate.read(key);
}
