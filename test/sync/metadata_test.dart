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
      lastAppliedRevision: 'revision-applied',
      lastAppliedPayloadHash: 'sha256:applied',
      lastPublishedRevision: 'revision-published',
      lastPublishedPayloadHash: 'sha256:published',
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

  test('sync metadata remains excluded from manual backup settings', () {
    expect(gagakuBackupExcludedLocalKeys, contains(syncMetadataHiveKey));
  });
}
