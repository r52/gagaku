import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:gagaku/sync/coordinator.dart';
import 'package:gagaku/sync/metadata.dart';
import 'package:gagaku/sync/protocol.dart';
import 'package:gagaku/sync/repository.dart';
import 'package:gagaku/sync/store.dart';

void main() {
  test(
    'clean startup pulls a dominating remote head without republishing',
    () async {
      final store = MemorySyncStore();
      final remote = _repository(store, 'device-a');
      await remote.publish(_payload('remote'));
      final changes = StreamController<Object?>.broadcast(sync: true);
      final data = _FakeData(
        _payload('local'),
        onImport: () => changes.add(null),
      );
      final metadata = _metadata('device-b');
      final coordinator = _coordinator(
        store,
        metadata,
        data,
        changes.stream,
        deviceId: 'device-b',
      );
      addTearDown(() async {
        await coordinator.dispose();
        await changes.close();
      });

      await coordinator.start();
      await _waitFor(
        () => coordinator.status.phase == SyncCoordinatorPhase.clean,
      );
      await Future<void>.delayed(const Duration(milliseconds: 40));

      expect(data.payload, _payload('remote'));
      expect(data.importCount, 1);
      expect(
        store.objects.keys.where((key) => key.startsWith('devices/device-b/')),
        isEmpty,
      );
      expect(metadata.state.lastAppliedPayloadHash, isNotNull);
    },
  );

  test('ten change events in one operation produce one publication', () async {
    final harness = await _Harness.start(
      debounce: const Duration(milliseconds: 20),
    );
    addTearDown(harness.dispose);
    harness.data.payload = _payload('changed');

    for (var index = 0; index < 10; index++) {
      harness.changes.add(index);
    }
    await _waitFor(() => harness.metadata.state.lastPublishedGeneration == 10);

    final head = await harness.head();
    expect(head.deviceSequence, 2);
    expect(head.payload, _payload('changed'));
  });

  test('device name changes publish without a logical data change', () async {
    final store = MemorySyncStore();
    final repository = _repository(store, 'device-a');
    final first = await repository.publish(_payload('same'));
    final metadata = _metadata(
      'device-a',
      lastSeen: first.snapshot.seen,
      baselineHash: first.snapshot.payloadHash,
    );
    final changes = StreamController<Object?>.broadcast(sync: true);
    final data = _FakeData(_payload('same'));
    final coordinator = SyncCoordinator(
      repository: repository,
      metadataStore: metadata,
      exportData: data.export,
      importData: data.import,
      entityChanges: changes.stream,
      operationTimeout: const Duration(seconds: 2),
    );
    addTearDown(() async {
      await coordinator.dispose();
      await changes.close();
    });

    await coordinator.start();
    await coordinator.renameDevice('Fictional Tablet');

    final head = (await repository.discover()).deviceHeads['device-a']!;
    expect(head.deviceSequence, 2);
    expect(head.payload, _payload('same'));
    expect(head.extra['deviceName'], 'Fictional Tablet');
    expect(metadata.state.deviceName, 'Fictional Tablet');
  });

  test(
    'operations separated by the quiet period publish independently',
    () async {
      final harness = await _Harness.start(
        debounce: const Duration(milliseconds: 15),
      );
      addTearDown(harness.dispose);

      harness.data.payload = _payload('operation-one');
      harness.changes.add(null);
      await _waitFor(() => harness.metadata.state.lastPublishedGeneration == 1);
      harness.data.payload = _payload('operation-two');
      harness.changes.add(null);
      await _waitFor(() => harness.metadata.state.lastPublishedGeneration == 2);

      expect((await harness.head()).deviceSequence, 3);
    },
  );

  test('pause bypasses the remaining debounce delay', () async {
    final harness = await _Harness.start(debounce: const Duration(hours: 1));
    addTearDown(harness.dispose);
    harness.data.payload = _payload('paused');
    harness.changes.add(null);
    await _waitFor(() => harness.metadata.state.dirtyGeneration == 1);

    await harness.coordinator.onPause();

    expect((await harness.head()).deviceSequence, 2);
    expect(harness.metadata.state.lastPublishedGeneration, 1);
  });

  test(
    'resume pulls remote advancement through the serialized coordinator',
    () async {
      final harness = await _Harness.start(debounce: const Duration(hours: 1));
      addTearDown(harness.dispose);
      await _repository(
        harness.store,
        'device-a',
      ).publish(_payload('advanced-while-paused'));

      await harness.coordinator.onResume();

      expect(harness.data.payload, _payload('advanced-while-paused'));
      expect(harness.coordinator.status.phase, SyncCoordinatorPhase.clean);
    },
  );

  test(
    'unchanged payload hashes settle generations without snapshots',
    () async {
      final harness = await _Harness.start(
        debounce: const Duration(milliseconds: 15),
      );
      addTearDown(harness.dispose);

      harness.changes.add(null);
      await _waitFor(() => harness.metadata.state.lastPublishedGeneration == 1);

      expect((await harness.head()).deviceSequence, 1);
    },
  );

  test(
    'a commit during export schedules a follow-up with the latest state',
    () async {
      final harness = await _Harness.start(debounce: const Duration(hours: 1));
      addTearDown(harness.dispose);
      final entered = Completer<void>();
      final release = Completer<void>();
      harness.data.beforeNextExport = () async {
        entered.complete();
        await release.future;
      };
      harness.data.payload = _payload('intermediate');
      harness.changes.add(null);
      await _waitFor(() => harness.metadata.state.dirtyGeneration == 1);

      final pause = harness.coordinator.onPause();
      await entered.future;
      harness.data.payload = _payload('latest');
      harness.changes.add(null);
      await _waitFor(() => harness.metadata.state.dirtyGeneration == 2);
      release.complete();
      await pause;

      final head = await harness.head();
      expect(head.deviceSequence, 2);
      expect(head.payload, _payload('latest'));
      expect(harness.metadata.state.lastPublishedGeneration, 2);
    },
  );

  test('remote advancement during export preserves a fork', () async {
    final harness = await _Harness.start(debounce: const Duration(hours: 1));
    addTearDown(harness.dispose);
    final remote = _repository(harness.store, 'device-a');
    final entered = Completer<void>();
    final release = Completer<void>();
    harness.data.beforeNextExport = () async {
      entered.complete();
      await release.future;
    };
    harness.data.payload = _payload('local-branch');
    harness.changes.add(null);
    await _waitFor(() => harness.metadata.state.dirtyGeneration == 1);

    final pause = harness.coordinator.onPause();
    await entered.future;
    await remote.publish(_payload('remote-branch'));
    release.complete();
    await pause;

    expect(harness.coordinator.status.phase, SyncCoordinatorPhase.forked);
    expect(harness.coordinator.status.forkHeads, hasLength(2));
    expect(
      (await harness.repository.discover()).selection,
      isA<ForkedSyncHeads>(),
    );
  });

  test(
    'user-selected fork resolution publishes a dominating snapshot',
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
      final changes = StreamController<Object?>.broadcast(sync: true);
      final data = _FakeData(
        _payload('left'),
        onImport: () => changes.add(null),
      );
      final metadata = _metadata(
        'device-c',
        lastSeen: {'device-a': 2},
        baselineHash: left.payloadHash,
      );
      final coordinator = _coordinator(
        store,
        metadata,
        data,
        changes.stream,
        deviceId: 'device-c',
      );
      addTearDown(() async {
        await coordinator.dispose();
        await changes.close();
      });
      await coordinator.start();
      expect(coordinator.status.phase, SyncCoordinatorPhase.forked);

      await coordinator.resolveFork(right);

      final discovery = await _repository(store, 'device-c').discover();
      expect(coordinator.status.phase, SyncCoordinatorPhase.clean);
      expect(data.payload, _payload('right'));
      expect(discovery.selection, isA<CanonicalSyncHead>());
      expect((discovery.selection as CanonicalSyncHead).head.seen, {
        'device-a': 2,
        'device-b': 1,
        'device-c': 1,
      });
    },
  );

  test('offline startup remains local and persists retry state', () async {
    final changes = StreamController<Object?>.broadcast(sync: true);
    final metadata = _metadata('device-a');
    final coordinator = SyncCoordinator(
      repository: SyncRepository(
        store: _UnavailableStore(),
        profileId: 'profile-fixture',
        deviceId: 'device-a',
      ),
      metadataStore: metadata,
      exportData: () async => _payload('local'),
      importData: (_) async {},
      entityChanges: changes.stream,
      operationTimeout: const Duration(seconds: 1),
    );
    addTearDown(() async {
      await coordinator.dispose();
      await changes.close();
    });

    await coordinator.start();

    expect(coordinator.status.phase, SyncCoordinatorPhase.offline);
    expect(metadata.state.retryPending, isTrue);
    expect(metadata.state.lastError, contains('unavailable'));
  });

  test(
    'resume retries an unavailable store without blocking local data',
    () async {
      final changes = StreamController<Object?>.broadcast(sync: true);
      final metadata = _metadata('device-a');
      final store = _ToggleStore();
      final data = _FakeData(_payload('local'));
      final coordinator = _coordinator(
        store,
        metadata,
        data,
        changes.stream,
        deviceId: 'device-a',
      );
      addTearDown(() async {
        await coordinator.dispose();
        await changes.close();
      });
      await coordinator.start();
      expect(coordinator.status.phase, SyncCoordinatorPhase.offline);

      store.available = true;
      await coordinator.onResume();

      expect(coordinator.status.phase, SyncCoordinatorPhase.clean);
      expect(metadata.state.retryPending, isFalse);
      expect(
        (await _repository(store, 'device-a').discover()).selection,
        isA<CanonicalSyncHead>(),
      );
    },
  );

  test('requests coalesce behind one serialized export', () async {
    final harness = await _Harness.start(debounce: const Duration(hours: 1));
    addTearDown(harness.dispose);
    final entered = Completer<void>();
    final release = Completer<void>();
    harness.data.beforeNextExport = () async {
      entered.complete();
      await release.future;
    };

    final first = harness.coordinator.requestSync();
    await entered.future;
    final second = harness.coordinator.requestSync();
    final third = harness.coordinator.onResume();
    release.complete();
    await Future.wait([first, second, third]);

    expect(harness.data.maxConcurrentExports, 1);
  });

  test(
    'persisted dirty generation resumes publication after restart',
    () async {
      final store = MemorySyncStore();
      final metadata = _metadata('device-a');
      await metadata.write(
        SyncLocalState(
          enabled: true,
          profileId: 'profile-fixture',
          deviceId: 'device-a',
          dirtyGeneration: 3,
          lastPublishedGeneration: 2,
        ),
      );
      final changes = StreamController<Object?>.broadcast(sync: true);
      final data = _FakeData(_payload('recovered'));
      final coordinator = _coordinator(
        store,
        metadata,
        data,
        changes.stream,
        deviceId: 'device-a',
      );
      addTearDown(() async {
        await coordinator.dispose();
        await changes.close();
      });

      await coordinator.start();

      expect(
        (await _repository(store, 'device-a').discover()).selection,
        isA<CanonicalSyncHead>(),
      );
      expect(metadata.state.lastPublishedGeneration, 3);
    },
  );
}

final class _Harness {
  _Harness({
    required this.store,
    required this.metadata,
    required this.data,
    required this.changes,
    required this.repository,
    required this.coordinator,
  });

  final MemorySyncStore store;
  final MemorySyncMetadataStore metadata;
  final _FakeData data;
  final StreamController<Object?> changes;
  final SyncRepository repository;
  final SyncCoordinator coordinator;

  static Future<_Harness> start({required Duration debounce}) async {
    final store = MemorySyncStore();
    final metadata = _metadata('device-b');
    final data = _FakeData(_payload('initial'));
    final changes = StreamController<Object?>.broadcast(sync: true);
    final repository = _repository(store, 'device-b');
    final coordinator = SyncCoordinator(
      repository: repository,
      metadataStore: metadata,
      exportData: data.export,
      importData: data.import,
      entityChanges: changes.stream,
      debounceDuration: debounce,
      operationTimeout: const Duration(seconds: 2),
    );
    final harness = _Harness(
      store: store,
      metadata: metadata,
      data: data,
      changes: changes,
      repository: repository,
      coordinator: coordinator,
    );
    await coordinator.start();
    return harness;
  }

  Future<SyncSnapshot> head() async =>
      (await repository.discover()).deviceHeads['device-b']!;

  Future<void> dispose() async {
    await coordinator.dispose();
    await changes.close();
  }
}

final class _FakeData {
  _FakeData(this.payload, {this.onImport});

  Map<String, dynamic> payload;
  final void Function()? onImport;
  Future<void> Function()? beforeNextExport;
  int importCount = 0;
  int concurrentExports = 0;
  int maxConcurrentExports = 0;

  Future<Map<String, dynamic>> export() async {
    concurrentExports++;
    if (concurrentExports > maxConcurrentExports) {
      maxConcurrentExports = concurrentExports;
    }
    try {
      final before = beforeNextExport;
      beforeNextExport = null;
      await before?.call();
      return _copy(payload);
    } finally {
      concurrentExports--;
    }
  }

  Future<void> import(Map<String, dynamic> value) async {
    importCount++;
    payload = _copy(value);
    onImport?.call();
  }
}

MemorySyncMetadataStore _metadata(
  String deviceId, {
  Map<String, int> lastSeen = const {},
  String? baselineHash,
}) => MemorySyncMetadataStore(
  SyncLocalState(
    enabled: true,
    profileId: 'profile-fixture',
    deviceId: deviceId,
    lastSeen: lastSeen,
    lastBaselinePayloadHash: baselineHash,
  ),
);

SyncCoordinator _coordinator(
  SyncStore store,
  SyncMetadataStore metadata,
  _FakeData data,
  Stream<Object?> changes, {
  required String deviceId,
}) => SyncCoordinator(
  repository: _repository(store, deviceId),
  metadataStore: metadata,
  exportData: data.export,
  importData: data.import,
  entityChanges: changes,
  debounceDuration: const Duration(milliseconds: 15),
  operationTimeout: const Duration(seconds: 2),
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

Map<String, dynamic> _copy(Map<String, dynamic> value) =>
    Map<String, dynamic>.from(jsonDecode(jsonEncode(value)) as Map);

Future<void> _waitFor(bool Function() condition) async {
  final deadline = DateTime.now().add(const Duration(seconds: 3));
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      fail('Timed out waiting for coordinator condition');
    }
    await Future<void>.delayed(const Duration(milliseconds: 5));
  }
}

final class _UnavailableStore implements SyncStore {
  @override
  Future<void> create(String key, List<int> bytes) =>
      throw const FileSystemException('synthetic unavailable');

  @override
  Future<void> delete(String key) =>
      throw const FileSystemException('synthetic unavailable');

  @override
  Future<List<SyncObject>> list(String prefix) =>
      throw const FileSystemException('synthetic unavailable');

  @override
  Future<List<int>> read(String key) =>
      throw const FileSystemException('synthetic unavailable');
}

final class _ToggleStore implements SyncStore {
  final MemorySyncStore delegate = MemorySyncStore();
  bool available = false;

  void _check() {
    if (!available) throw const FileSystemException('synthetic unavailable');
  }

  @override
  Future<void> create(String key, List<int> bytes) {
    _check();
    return delegate.create(key, bytes);
  }

  @override
  Future<void> delete(String key) {
    _check();
    return delegate.delete(key);
  }

  @override
  Future<List<SyncObject>> list(String prefix) {
    _check();
    return delegate.list(prefix);
  }

  @override
  Future<List<int>> read(String key) {
    _check();
    return delegate.read(key);
  }
}
