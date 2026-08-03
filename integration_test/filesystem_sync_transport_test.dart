import 'dart:collection';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:gagaku/sync/filesystem_store.dart';
import 'package:gagaku/sync/protocol.dart';
import 'package:gagaku/sync/repository.dart';
import 'package:gagaku/sync/store.dart';

const _configuredTestDirectory = String.fromEnvironment(
  'GAGAKU_SYNC_TEST_DIRECTORY',
);

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('synchronizes through an Android-accessible filesystem path', (
    tester,
  ) async {
    expect(Platform.isAndroid, isTrue);
    final baseDirectory = _configuredTestDirectory.isEmpty
        ? await getExternalStorageDirectory()
        : Directory(_configuredTestDirectory);
    expect(baseDirectory, isNotNull);
    final root = Directory(
      p.join(
        baseDirectory!.path,
        'gagaku-sync-phase3-${DateTime.now().microsecondsSinceEpoch}',
      ),
    );
    await root.create(recursive: true);
    addTearDown(() async {
      if (await root.exists()) await root.delete(recursive: true);
    });

    final deviceA = _repository(FilesystemSyncStore(root.path), 'device-a', [
      'revision-a1',
      'revision-a2',
      'revision-a3',
    ]);
    final deviceB = _repository(FilesystemSyncStore(root.path), 'device-b', [
      'revision-b1',
    ]);

    await deviceA.publish(_payload('from-a'));
    await deviceB.publish(_payload('from-b'));
    await deviceA.publish(_payload('back-to-a'));
    final finalPublication = await deviceA.publish(_payload('newest-a'));

    final discovery = await deviceB.discover();
    final objects = await FilesystemSyncStore(root.path).list('devices/');
    expect(
      (discovery.selection as CanonicalSyncHead).head.key,
      finalPublication.snapshot.key,
    );
    expect(
      objects.where((object) => object.key.startsWith('devices/device-a/')),
      hasLength(2),
    );
    expect(
      objects.where((object) => object.key.startsWith('devices/device-b/')),
      hasLength(1),
    );
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

Map<String, dynamic> _payload(String value) => {
  'version': 2,
  'fixture': {'value': value},
};
