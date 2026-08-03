import 'dart:collection';

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
    required this.invalidObjects,
    required this.selection,
  });

  final Map<String, SyncSnapshot> deviceHeads;
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

final class SyncRepository {
  SyncRepository({
    required this.store,
    required this.profileId,
    required this.deviceId,
    SyncRevisionIdFactory? revisionIdFactory,
    SyncNow? now,
  }) : _revisionIdFactory = revisionIdFactory ?? const Uuid().v4,
       _now = now ?? DateTime.now;

  final SyncStore store;
  final String profileId;
  final String deviceId;
  final SyncRevisionIdFactory _revisionIdFactory;
  final SyncNow _now;

  Future<SyncDiscovery> discover() async {
    final objects = await store.list('devices/');
    final invalid = <InvalidSyncObject>[];
    final valid = <SyncSnapshot>[];

    for (final object in objects) {
      try {
        final bytes = await store.read(object.key);
        valid.add(
          SyncSnapshotCodec.decode(
            object.key,
            bytes,
            expectedProfileId: profileId,
          ),
        );
      } on SyncValidationException catch (error) {
        invalid.add(InvalidSyncObject(object: object, error: error));
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
      invalidObjects: List.unmodifiable(invalid),
      selection: SyncHeadSelector.select(sortedHeads.values),
    );
  }

  Future<SyncPublication> publish(Map<String, dynamic> payload) async {
    final discovery = await discover();
    final baseClock = switch (discovery.selection) {
      NoSyncHeads() => const <String, int>{},
      CanonicalSyncHead(:final head) => head.seen,
      EquivalentSyncHeads(:final joinedClock) => joinedClock,
      ForkedSyncHeads(:final heads) => throw SyncForkException(heads),
    };
    return _publish(payload, baseClock, discovery);
  }

  Future<SyncPublication> normalizeEquivalentHeads() async {
    final discovery = await discover();
    return switch (discovery.selection) {
      EquivalentSyncHeads(:final heads, :final joinedClock) => _publish(
        heads.first.payload,
        joinedClock,
        discovery,
      ),
      _ => throw StateError('No equivalent concurrent heads to normalize'),
    };
  }

  Future<SyncPublication> resolveFork(SyncSnapshot selected) async {
    final discovery = await discover();
    final heads = switch (discovery.selection) {
      ForkedSyncHeads(:final heads) => heads,
      _ => throw StateError('No fork to resolve'),
    };
    if (!heads.any((head) => head.key == selected.key)) {
      throw ArgumentError.value(selected.key, 'selected', 'not a fork head');
    }
    final joined = SyncClock.join(heads.map((head) => head.seen));
    return _publish(selected.payload, joined, discovery);
  }

  /// Publishes a local branch from a previously synchronized clock.
  ///
  /// This deliberately does not join newly discovered remote advancement. It
  /// is used when local data changed concurrently, so both complete branches
  /// remain visible for explicit resolution.
  Future<SyncPublication> publishFromClock(
    Map<String, dynamic> payload,
    Map<String, int> baseClock,
  ) async => _publish(payload, baseClock, await discover());

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

  Future<SyncPublication> _publish(
    Map<String, dynamic> payload,
    Map<String, int> baseClock,
    SyncDiscovery discovery,
  ) async {
    final localHead = discovery.deviceHeads[deviceId];
    final nextSequence =
        [
          baseClock[deviceId] ?? 0,
          localHead?.deviceSequence ?? 0,
        ].reduce((left, right) => left > right ? left : right) +
        1;
    final seen = Map<String, int>.of(baseClock)..[deviceId] = nextSequence;
    final snapshot = SyncSnapshotCodec.create(
      profileId: profileId,
      deviceId: deviceId,
      deviceSequence: nextSequence,
      revisionId: _revisionIdFactory(),
      createdAt: _now().toUtc(),
      seen: seen,
      payload: payload,
    );

    await store.create(snapshot.key, SyncSnapshotCodec.encode(snapshot));
    final readback = await store.read(snapshot.key);
    final validated = SyncSnapshotCodec.decode(
      snapshot.key,
      readback,
      expectedProfileId: profileId,
    );
    final cleanupFailures = await _compactLocalNamespace();
    return SyncPublication(
      snapshot: validated,
      cleanupFailures: List.unmodifiable(cleanupFailures),
    );
  }

  Future<List<String>> _compactLocalNamespace() async {
    final objects = await store.list('devices/$deviceId/');
    final valid = <SyncSnapshot>[];
    for (final object in objects) {
      try {
        valid.add(
          SyncSnapshotCodec.decode(
            object.key,
            await store.read(object.key),
            expectedProfileId: profileId,
          ),
        );
      } on SyncValidationException {
        // Invalid objects are retained for explicit repair/recovery.
      }
    }
    valid.sort((left, right) {
      final sequence = right.deviceSequence.compareTo(left.deviceSequence);
      return sequence != 0 ? sequence : left.key.compareTo(right.key);
    });

    final failures = <String>[];
    for (final snapshot in valid.skip(2)) {
      try {
        await store.delete(snapshot.key);
      } catch (_) {
        failures.add(snapshot.key);
      }
    }
    return failures;
  }
}
