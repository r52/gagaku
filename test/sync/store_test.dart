import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/sync/store.dart';

import 'test_support.dart';

void main() {
  test('created objects are immutable and byte buffers are isolated', () async {
    final store = MemorySyncStore();
    final input = [1, 2, 3];
    await store.create('devices/device-a/object.snapshot', input);
    input[0] = 9;
    final firstRead = await store.read('devices/device-a/object.snapshot');
    firstRead[1] = 9;

    await expectLater(
      store.create('devices/device-a/object.snapshot', [4, 5, 6]),
      throwsA(isA<SyncObjectAlreadyExistsException>()),
    );

    expect(await store.read('devices/device-a/object.snapshot'), [1, 2, 3]);
  });

  test('listing and deletion are scoped by exact key prefixes', () async {
    final store = MemorySyncStore()
      ..seed('devices/device-a/one.snapshot', [1])
      ..seed('devices/device-ab/one.snapshot', [2]);

    final listed = await store.list('devices/device-a/');

    expect(listed.map((object) => object.key), [
      'devices/device-a/one.snapshot',
    ]);
    await store.delete(listed.single.key);
    expect(store.objects, isNot(contains('devices/device-a/one.snapshot')));
    expect(store.objects, contains('devices/device-ab/one.snapshot'));
  });

  test('missing reads fail explicitly', () async {
    final store = MemorySyncStore();

    await expectLater(
      store.read('devices/device-a/missing.snapshot'),
      throwsA(isA<SyncObjectNotFoundException>()),
    );
  });
}
