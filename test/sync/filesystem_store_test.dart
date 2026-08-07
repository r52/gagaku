import 'dart:collection';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import 'package:gagaku/sync/filesystem_store.dart';
import 'package:gagaku/sync/protocol.dart';
import 'package:gagaku/sync/repository.dart';
import 'package:gagaku/sync/store.dart';

void main() {
  late Directory root;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('gagaku-sync-filesystem-');
  });

  tearDown(() async {
    if (await root.exists()) await root.delete(recursive: true);
  });

  test('creates, lists, reads, and deletes scoped objects', () async {
    final store = FilesystemSyncStore(root.path);
    const key = 'devices/device-a/0000000000000001-revision-a.snapshot';
    await store.create(key, [1, 2, 3]);

    final objects = await store.list('devices/device-a/');

    expect(objects, hasLength(1));
    expect(objects.single.key, key);
    expect(objects.single.length, 3);
    expect(await store.read(key), [1, 2, 3]);
    await store.delete(key);
    await store.delete(key);
    await store.delete('devices/missing/object.snapshot');
    await expectLater(
      store.read('devices/missing/object.snapshot'),
      throwsA(isA<SyncObjectNotFoundException>()),
    );
    expect(await store.list('devices/'), isEmpty);
  });

  test('never overwrites an existing immutable object', () async {
    final store = FilesystemSyncStore(root.path);
    const key = 'devices/device-a/object.snapshot';
    final input = [1, 2, 3];
    final create = store.create(key, input);
    input[0] = 9;
    await create;

    await expectLater(
      store.create(key, [4, 5, 6]),
      throwsA(isA<SyncObjectAlreadyExistsException>()),
    );

    expect(await store.read(key), [1, 2, 3]);
  });

  test(
    'rejects traversal, alternate separators, drive segments, and URIs',
    () async {
      final store = FilesystemSyncStore(root.path);
      for (final key in [
        '../outside.snapshot',
        '/absolute.snapshot',
        r'devices\outside.snapshot',
        'devices/C:/outside.snapshot',
        'devices//outside.snapshot',
      ]) {
        await expectLater(store.create(key, [1]), throwsArgumentError);
      }

      expect(
        () => FilesystemSyncStore('smb://server/share'),
        throwsArgumentError,
      );
      expect(await root.list().toList(), isEmpty);
    },
  );

  test('does not follow links below the selected root', () async {
    final outside = await Directory.systemTemp.createTemp(
      'gagaku-sync-outside-',
    );
    addTearDown(() async {
      if (await outside.exists()) await outside.delete(recursive: true);
    });
    await Link(p.join(root.path, 'devices')).create(outside.path);
    final store = FilesystemSyncStore(root.path);

    await expectLater(
      store.create('devices/device-a/object.snapshot', [1]),
      throwsA(isA<FileSystemException>()),
    );

    expect(await store.list(''), isEmpty);
    expect(await outside.list().toList(), isEmpty);
  });

  test(
    'falls back to a prior valid file when the newest file is corrupt',
    () async {
      final store = FilesystemSyncStore(root.path);
      final repository = _repository(store, 'device-a', [
        'revision-a1',
        'revision-a2',
      ]);
      await repository.publish(_payload('first'));
      final second = await repository.publish(_payload('second'));
      final corruptKey = SyncSnapshotCodec.objectKey(
        deviceId: 'device-a',
        deviceSequence: 3,
        revisionId: 'revision-a3',
      );
      await File(
        p.joinAll([root.path, ...corruptKey.split('/')]),
      ).writeAsBytes([1, 2, 3]);

      final discovery = await repository.discover();

      expect(discovery.invalidObjects, hasLength(1));
      expect(discovery.deviceHeads['device-a']?.key, second.snapshot.key);
    },
  );

  test(
    'two independent instances hand off and compact through one directory',
    () async {
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
    },
  );
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
