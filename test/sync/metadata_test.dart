import 'package:flutter_test/flutter_test.dart';

import 'package:gagaku/settings.dart';
import 'package:gagaku/sync/metadata.dart';

void main() {
  test('local sync metadata round-trips all crash-recovery fields', () {
    final original = SyncLocalState(
      enabled: true,
      transportKind: 'filesystem',
      locator: '/synthetic/sync/root',
      profileId: 'profile-fixture',
      deviceId: 'device-fixture',
      deviceName: 'Fictional Device',
      dirtyGeneration: 7,
      lastPublishedGeneration: 6,
      lastSeen: {'device-fixture': 3, 'peer-fixture': 2},
      lastBaselinePayloadHash: 'sha256:baseline',
      lastAppliedAt: DateTime.utc(2026, 1, 2, 3, 4, 5),
      lastPublishedAt: DateTime.utc(2026, 1, 2, 3, 5, 6),
      profileMissing: true,
      retryPending: true,
      lastError: 'synthetic unavailable',
    );

    final decoded = SyncLocalState.fromJson(original.toJson());

    expect(decoded.toJson(), original.toJson());
  });

  test('malformed counters and vector entries degrade safely', () {
    final decoded = SyncLocalState.fromJson({
      'enabled': true,
      'dirtyGeneration': 2,
      'lastPublishedGeneration': 8,
      'lastSeen': {'valid-device': 2, 'zero-device': 0, 'text-device': '3'},
    });

    expect(decoded.dirtyGeneration, 2);
    expect(decoded.lastPublishedGeneration, 2);
    expect(decoded.lastSeen, {'valid-device': 2});
  });

  test('legacy write-only diagnostics are ignored', () {
    final state = SyncLocalState.fromJson({
      'lastAppliedRevision': 'legacy-applied',
      'lastAppliedPayloadHash': 'sha256:legacy-applied',
      'lastPublishedRevision': 'legacy-published',
      'lastPublishedPayloadHash': 'sha256:legacy-published',
    });

    expect(state.toJson(), isNot(contains('lastAppliedRevision')));
    expect(state.toJson(), isNot(contains('lastAppliedPayloadHash')));
    expect(state.toJson(), isNot(contains('lastPublishedRevision')));
    expect(state.toJson(), isNot(contains('lastPublishedPayloadHash')));
  });

  test('sync metadata remains excluded from manual backup settings', () {
    expect(gagakuBackupExcludedLocalKeys, contains(syncMetadataHiveKey));
  });
}
