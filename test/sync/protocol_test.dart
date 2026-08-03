import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/sync/protocol.dart';

void main() {
  group('canonical JSON', () {
    test('sorts object keys recursively and preserves array order', () {
      final encoded = utf8.decode(
        SyncSnapshotCodec.canonicalJsonBytes({
          'z': 1,
          'a': {
            'second': true,
            'first': [3, 2, 1],
          },
        }),
      );

      expect(encoded, '{"a":{"first":[3,2,1],"second":true},"z":1}');
    });

    test('rejects non-finite numbers and non-string keys', () {
      expect(
        () => SyncSnapshotCodec.canonicalJsonBytes({'value': double.nan}),
        throwsA(isA<SyncValidationException>()),
      );
      expect(
        () => SyncSnapshotCodec.canonicalJsonBytes({1: 'value'}),
        throwsA(isA<SyncValidationException>()),
      );
    });
  });

  group('SyncClock', () {
    test(
      'compares equality, dominance, and concurrency with missing zeros',
      () {
        expect(
          SyncClock.compare({'device-a': 1}, {'device-a': 1}),
          SyncClockRelation.equal,
        );
        expect(
          SyncClock.compare({'device-a': 2}, {'device-a': 1, 'device-b': 0}),
          SyncClockRelation.dominates,
        );
        expect(
          SyncClock.compare({'device-a': 1}, {'device-a': 2}),
          SyncClockRelation.dominated,
        );
        expect(
          SyncClock.compare({'device-a': 2}, {'device-b': 1}),
          SyncClockRelation.concurrent,
        );
      },
    );

    test('joins and increments without mutating the input', () {
      final original = {'device-a': 2};
      final joined = SyncClock.join([
        original,
        {'device-a': 1, 'device-b': 4},
      ]);
      final incremented = SyncClock.increment(joined, 'device-a');

      expect(joined, {'device-a': 2, 'device-b': 4});
      expect(incremented, {'device-a': 3, 'device-b': 4});
      expect(original, {'device-a': 2});
    });
  });

  group('SyncSnapshotCodec', () {
    test('round-trips and preserves unknown optional fields', () {
      final snapshot = _snapshot(
        deviceId: 'device-a',
        sequence: 1,
        seen: const {'device-a': 1},
        payload: const {'synthetic': 'value'},
        extra: const {
          'optionalFutureField': {'enabled': true},
        },
      );

      final decoded = SyncSnapshotCodec.decode(
        snapshot.key,
        SyncSnapshotCodec.encode(snapshot),
        expectedProfileId: 'synthetic-profile',
      );

      expect(decoded.payload, {'synthetic': 'value'});
      expect(decoded.payloadHash, startsWith('sha256:'));
      expect(decoded.payloadLength, greaterThan(0));
      expect(decoded.extra, {
        'optionalFutureField': {'enabled': true},
      });
    });

    test(
      'rejects profile, filename, protocol, hash, and truncation errors',
      () {
        final snapshot = _snapshot(
          deviceId: 'device-a',
          sequence: 1,
          seen: const {'device-a': 1},
          payload: const {'synthetic': 'value'},
        );
        final bytes = SyncSnapshotCodec.encode(snapshot);

        expect(
          () => SyncSnapshotCodec.decode(
            snapshot.key,
            bytes,
            expectedProfileId: 'different-profile',
          ),
          throwsA(isA<SyncValidationException>()),
        );
        expect(
          () => SyncSnapshotCodec.decode(
            'devices/device-a/0000000000000002-revision-1.snapshot',
            bytes,
            expectedProfileId: 'synthetic-profile',
          ),
          throwsA(isA<SyncValidationException>()),
        );

        final envelope = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
        expect(
          () => _decodeChanged(snapshot, envelope, {'protocolVersion': 2}),
          throwsA(isA<SyncValidationException>()),
        );
        expect(
          () => _decodeChanged(snapshot, envelope, {
            'payload': {'synthetic': 'tampered'},
          }),
          throwsA(isA<SyncValidationException>()),
        );
        expect(
          () => SyncSnapshotCodec.decode(
            snapshot.key,
            bytes.sublist(0, bytes.length - 5),
            expectedProfileId: 'synthetic-profile',
          ),
          throwsA(isA<SyncValidationException>()),
        );
      },
    );

    test('rejects invalid vector invariants', () {
      expect(
        () => SyncSnapshotCodec.create(
          profileId: 'synthetic-profile',
          deviceId: 'device-a',
          deviceSequence: 2,
          revisionId: 'revision-2',
          createdAt: DateTime.utc(2026, 1, 1),
          seen: const {'device-a': 1},
          payload: const {'synthetic': 'value'},
        ),
        throwsA(isA<SyncValidationException>()),
      );
    });

    test('rejects identities that are unsafe filesystem path segments', () {
      for (final deviceId in ['..', 'device/child', r'device\child', 'C:']) {
        expect(
          () => SyncSnapshotCodec.create(
            profileId: 'synthetic-profile',
            deviceId: deviceId,
            deviceSequence: 1,
            revisionId: 'revision-1',
            createdAt: DateTime.utc(2026, 1, 1),
            seen: {deviceId: 1},
            payload: const {'synthetic': 'value'},
          ),
          throwsA(isA<SyncValidationException>()),
        );
      }
    });
  });

  group('SyncHeadSelector', () {
    test('selects a unique dominating head', () {
      final older = _snapshot(
        deviceId: 'device-a',
        sequence: 1,
        seen: const {'device-a': 1},
        payload: const {'revision': 'older'},
      );
      final newer = _snapshot(
        deviceId: 'device-b',
        sequence: 1,
        seen: const {'device-a': 1, 'device-b': 1},
        payload: const {'revision': 'newer'},
      );

      final selection = SyncHeadSelector.select([newer, older]);

      expect(selection, isA<CanonicalSyncHead>());
      expect((selection as CanonicalSyncHead).head.key, newer.key);
    });

    test('detects different-payload concurrent branches', () {
      final left = _snapshot(
        deviceId: 'device-a',
        sequence: 2,
        seen: const {'device-a': 2},
        payload: const {'branch': 'left'},
      );
      final right = _snapshot(
        deviceId: 'device-b',
        sequence: 1,
        seen: const {'device-a': 1, 'device-b': 1},
        payload: const {'branch': 'right'},
      );

      final selection = SyncHeadSelector.select([right, left]);

      expect(selection, isA<ForkedSyncHeads>());
      expect(selection.heads, hasLength(2));
    });

    test('recognizes equal-payload concurrent heads for normalization', () {
      final left = _snapshot(
        deviceId: 'device-a',
        sequence: 1,
        seen: const {'device-a': 1},
        payload: const {'same': true},
      );
      final right = _snapshot(
        deviceId: 'device-b',
        sequence: 1,
        seen: const {'device-b': 1},
        payload: const {'same': true},
      );

      final selection = SyncHeadSelector.select([left, right]);

      expect(selection, isA<EquivalentSyncHeads>());
      expect((selection as EquivalentSyncHeads).joinedClock, {
        'device-a': 1,
        'device-b': 1,
      });
    });

    test('rejects equal clocks with different payloads', () {
      final left = _snapshot(
        deviceId: 'device-a',
        sequence: 1,
        seen: const {'device-a': 1, 'device-b': 1},
        payload: const {'branch': 'left'},
      );
      final right = _snapshot(
        deviceId: 'device-b',
        sequence: 1,
        seen: const {'device-a': 1, 'device-b': 1},
        payload: const {'branch': 'right'},
      );

      expect(
        () => SyncHeadSelector.select([right, left]),
        throwsA(isA<SyncValidationException>()),
      );
    });
  });
}

SyncSnapshot _snapshot({
  required String deviceId,
  required int sequence,
  required Map<String, int> seen,
  required Map<String, dynamic> payload,
  Map<String, dynamic> extra = const {},
}) => SyncSnapshotCodec.create(
  profileId: 'synthetic-profile',
  deviceId: deviceId,
  deviceSequence: sequence,
  revisionId: 'revision-$deviceId-$sequence',
  createdAt: DateTime.utc(2026, 1, 1),
  seen: seen,
  payload: payload,
  extra: extra,
);

SyncSnapshot _decodeChanged(
  SyncSnapshot snapshot,
  Map<String, dynamic> envelope,
  Map<String, dynamic> changes,
) => SyncSnapshotCodec.decode(
  snapshot.key,
  utf8.encode(jsonEncode({...envelope, ...changes})),
  expectedProfileId: 'synthetic-profile',
);
