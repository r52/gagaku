import 'dart:collection';
import 'dart:isolate';

import 'package:uuid/uuid.dart';

import 'package:gagaku/sync/protocol.dart';
import 'package:gagaku/sync/store.dart';

final class InvalidSyncObject {
  const InvalidSyncObject({required this.object, required this.error});

  final SyncObject object;
  final SyncValidationException error;
}

final class SyncDiscovery {
  const SyncDiscovery({
    required this.deviceHeads,
    required this.validSnapshots,
    required this.invalidObjects,
    required this.selection,
  });

  final Map<String, SyncSnapshot> deviceHeads;
  final List<SyncSnapshot> validSnapshots;
  final List<InvalidSyncObject> invalidObjects;
  final SyncHeadSelection selection;
}

final class SyncPublication {
  const SyncPublication({
    required this.snapshot,
    required this.cleanupFailures,
  });

  final SyncSnapshot snapshot;
  final List<String> cleanupFailures;
}

final class SyncForkException implements Exception {
  const SyncForkException(this.heads);

  final List<SyncSnapshot> heads;

  @override
  String toString() => 'Sync fork requires resolution (${heads.length} heads)';
}

typedef SyncRevisionIdFactory = String Function();
typedef SyncNow = DateTime Function();
typedef _PendingSnapshot = ({String key, List<int> bytes});
typedef _DecodedSnapshot = ({SyncSnapshot? snapshot, String? error});

List<_DecodedSnapshot> _decodeSnapshots(
  List<_PendingSnapshot> pending,
  String profileId,
) {
  final decoded = <_DecodedSnapshot>[];
  for (final object in pending) {
    try {
      decoded.add((
        snapshot: SyncSnapshotCodec.decode(
          object.key,
          object.bytes,
          expectedProfileId: profileId,
        ),
        error: null,
      ));
    } on SyncValidationException catch (error) {
      decoded.add((snapshot: null, error: error.message));
    }
  }
  return decoded;
}

final class SyncRepository {
  SyncRepository({
    required this.store,
    required this.profileId,
    required this.deviceId,
    this.deviceName = '',
    SyncRevisionIdFactory? revisionIdFactory,
    SyncNow? now,
  }) : _revisionIdFactory = revisionIdFactory ?? const Uuid().v4,
       _now = now ?? DateTime.now;

  final SyncStore store;
  final String profileId;
  final String deviceId;
  String deviceName;
  final SyncRevisionIdFactory _revisionIdFactory;
  final SyncNow _now;

  Future<SyncDiscovery> discover({
    Iterable<SyncSnapshot> previouslyValidated = const [],
  }) async {
    final objects = await store.list('devices/');
    final invalid = <InvalidSyncObject>[];
    final valid = <SyncSnapshot>[];
    final validatedByKey = {
      for (final snapshot in previouslyValidated) snapshot.key: snapshot,
    };
    final pendingObjects = <SyncObject>[];
    final pendingSnapshots = <_PendingSnapshot>[];

    for (final object in objects) {
      final validated = validatedByKey[object.key];
      if (validated != null) {
        valid.add(validated);
        continue;
      }
      pendingObjects.add(object);
      pendingSnapshots.add((
        key: object.key,
        bytes: await store.read(object.key),
      ));
    }

    if (pendingSnapshots.isNotEmpty) {
      final decoded = await Isolate.run(
        () => _decodeSnapshots(pendingSnapshots, profileId),
      );
      for (var index = 0; index < decoded.length; index++) {
        final result = decoded[index];
        final snapshot = result.snapshot;
        if (snapshot != null) {
          valid.add(snapshot);
        } else {
          invalid.add(
            InvalidSyncObject(
              object: pendingObjects[index],
              error: SyncValidationException(
                result.error ?? 'invalid snapshot encoding',
                key: pendingObjects[index].key,
              ),
            ),
          );
        }
      }
    }

    final deviceHeads = <String, SyncSnapshot>{};
    for (final snapshot in valid..sort((a, b) => a.key.compareTo(b.key))) {
      final existing = deviceHeads[snapshot.deviceId];
      if (existing == null ||
          snapshot.deviceSequence > existing.deviceSequence) {
        deviceHeads[snapshot.deviceId] = snapshot;
        continue;
      }
      if (snapshot.deviceSequence == existing.deviceSequence) {
        if (snapshot.payloadHash != existing.payloadHash ||
            SyncClock.compare(snapshot.seen, existing.seen) !=
                SyncClockRelation.equal) {
          throw SyncValidationException(
            'device sequence was reused with different content',
            key: snapshot.key,
          );
        }
        if (snapshot.key.compareTo(existing.key) < 0) {
          deviceHeads[snapshot.deviceId] = snapshot;
        }
      }
    }

    final sortedHeads = SplayTreeMap<String, SyncSnapshot>.from(deviceHeads);
    return SyncDiscovery(
      deviceHeads: UnmodifiableMapView(sortedHeads),
      validSnapshots: List.unmodifiable(valid),
      invalidObjects: List.unmodifiable(invalid),
      selection: SyncHeadSelector.select(sortedHeads.values),
    );
  }

  Future<SyncPublication> publish(Map<String, dynamic> payload) async {
    final discovery = await discover();
    final prepared = await SyncSnapshotCodec.preparePayload(payload);
    final baseClock = switch (discovery.selection) {
      NoSyncHeads() => const <String, int>{},
      CanonicalSyncHead(:final head) => head.seen,
      EquivalentSyncHeads(:final joinedClock) => joinedClock,
      ForkedSyncHeads(:final heads) => throw SyncForkException(heads),
    };
    return publishPrepared(prepared, baseClock, discovery);
  }

  Future<SyncPublication> normalizeEquivalentHeads(
    SyncDiscovery discovery,
  ) async {
    return switch (discovery.selection) {
      EquivalentSyncHeads(:final heads, :final joinedClock) => publishPrepared(
        await SyncSnapshotCodec.preparePayload(heads.first.payload),
        joinedClock,
        discovery,
      ),
      _ => throw StateError('No equivalent concurrent heads to normalize'),
    };
  }

  Future<SyncPublication> resolveFork(
    SyncDiscovery discovery,
    SyncSnapshot selected,
  ) async {
    final heads = switch (discovery.selection) {
      ForkedSyncHeads(:final heads) => heads,
      _ => throw StateError('No fork to resolve'),
    };
    if (!heads.any((head) => head.key == selected.key)) {
      throw ArgumentError.value(selected.key, 'selected', 'not a fork head');
    }
    final joined = SyncClock.join(heads.map((head) => head.seen));
    return publishPrepared(
      await SyncSnapshotCodec.preparePayload(selected.payload),
      joined,
      discovery,
    );
  }

  /// Publishes a local branch from a previously synchronized clock.
  ///
  /// This deliberately does not join newly discovered remote advancement. It
  /// is used when local data changed concurrently, so both complete branches
  /// remain visible for explicit resolution.
  Future<SyncPublication> publishPrepared(
    SyncPreparedPayload prepared,
    Map<String, int> baseClock,
    SyncDiscovery discovery,
  ) async {
    final localHead = discovery.deviceHeads[deviceId];
    final baseSequence = baseClock[deviceId] ?? 0;
    final localSequence = localHead?.deviceSequence ?? 0;
    final nextSequence =
        (baseSequence > localSequence ? baseSequence : localSequence) + 1;
    final seen = Map<String, int>.of(baseClock)..[deviceId] = nextSequence;
    final encoded = await SyncSnapshotCodec.createEncoded(
      profileId: profileId,
      deviceId: deviceId,
      deviceSequence: nextSequence,
      revisionId: _revisionIdFactory(),
      createdAt: _now().toUtc(),
      seen: seen,
      prepared: prepared,
      extra: {
        if (deviceName.trim().isNotEmpty) 'deviceName': deviceName.trim(),
      },
    );
    final snapshot = encoded.snapshot;

    await store.create(snapshot.key, encoded.bytes);
    final readback = await store.read(snapshot.key);
    final validated = await Isolate.run(
      () => SyncSnapshotCodec.decode(
        snapshot.key,
        readback,
        expectedProfileId: profileId,
      ),
    );
    final cleanupFailures = await _compactLocalNamespace([
      ...discovery.validSnapshots,
      validated,
    ]);
    return SyncPublication(
      snapshot: validated,
      cleanupFailures: List.unmodifiable(cleanupFailures),
    );
  }

  Future<List<String>> retireDevice(String retiredDeviceId) async {
    if (retiredDeviceId.isEmpty || retiredDeviceId.contains('/')) {
      throw ArgumentError.value(
        retiredDeviceId,
        'retiredDeviceId',
        'must be a non-empty path segment',
      );
    }

    final prefix = 'devices/$retiredDeviceId/';
    final failures = <String>[];
    for (final object in await store.list(prefix)) {
      if (!object.key.startsWith(prefix)) {
        continue;
      }
      try {
        await store.delete(object.key);
      } catch (_) {
        failures.add(object.key);
      }
    }
    return List.unmodifiable(failures);
  }

  Future<List<String>> _compactLocalNamespace(
    Iterable<SyncSnapshot> validatedSnapshots,
  ) async {
    final failures = <String>[];
    for (final key in syncSnapshotRetentionCandidates(
      validatedSnapshots,
      deviceId: deviceId,
    )) {
      try {
        await store.delete(key);
      } catch (_) {
        failures.add(key);
      }
    }
    return failures;
  }
}

List<String> syncSnapshotRetentionCandidates(
  Iterable<SyncSnapshot> snapshots, {
  String? deviceId,
}) {
  final byDevice = <String, Map<String, SyncSnapshot>>{};
  for (final snapshot in snapshots) {
    if (deviceId != null && snapshot.deviceId != deviceId) continue;
    byDevice.putIfAbsent(snapshot.deviceId, () => {})[snapshot.key] = snapshot;
  }
  final candidates = <String>[];
  for (final snapshots in byDevice.values) {
    final ordered = snapshots.values.toList()
      ..sort((left, right) {
        final sequence = right.deviceSequence.compareTo(left.deviceSequence);
        return sequence != 0 ? sequence : left.key.compareTo(right.key);
      });
    candidates.addAll(ordered.skip(2).map((snapshot) => snapshot.key));
  }
  return candidates..sort();
}
