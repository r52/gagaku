import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gagaku/sync/profile.dart';
import 'package:gagaku/sync/saf_store.dart';
import 'package:gagaku/sync/store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const treeUri = 'content://synthetic.provider/tree/profile-fixture';
  final objects = <String, Uint8List>{};

  setUp(() {
    objects.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SafSyncStore.channel, (call) async {
          final arguments = Map<String, dynamic>.from(call.arguments as Map);
          switch (call.method) {
            case 'checkAccess':
              return null;
            case 'list':
              final prefix = arguments['prefix'] as String;
              return [
                for (final entry in objects.entries)
                  if (entry.key.startsWith(prefix))
                    {'key': entry.key, 'length': entry.value.length},
              ];
            case 'read':
              final key = arguments['key'] as String;
              final value = objects[key];
              if (value == null) {
                throw PlatformException(code: 'NOT_FOUND');
              }
              return Uint8List.fromList(value);
            case 'create':
              final key = arguments['key'] as String;
              if (objects.containsKey(key)) {
                throw PlatformException(code: 'ALREADY_EXISTS');
              }
              objects[key] = Uint8List.fromList(
                arguments['bytes'] as Uint8List,
              );
              return null;
            case 'delete':
              objects.remove(arguments['key']);
              return null;
            default:
              throw MissingPluginException(call.method);
          }
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SafSyncStore.channel, null);
  });

  test('adapts the platform channel to the immutable store contract', () async {
    final store = SafSyncStore(treeUri);
    await store.checkAccess();
    await store.create('devices/device-fixture/0001.json', [1, 2, 3]);

    expect(await store.read('devices/device-fixture/0001.json'), [1, 2, 3]);
    expect(await store.list('devices/'), hasLength(1));
    await expectLater(
      store.create('devices/device-fixture/0001.json', [4]),
      throwsA(isA<SyncObjectAlreadyExistsException>()),
    );

    await store.delete('devices/device-fixture/0001.json');
    await store.delete('devices/device-fixture/missing.json');
    await expectLater(
      store.read('devices/device-fixture/0001.json'),
      throwsA(isA<SyncObjectNotFoundException>()),
    );
  });

  test('runs profile create, probe, and readback through SAF', () async {
    final manager = SyncProfileManager(
      store: SafSyncStore(treeUri),
      idFactory: () => 'synthetic-profile-id',
      now: () => DateTime.utc(2030, 1, 2),
    );

    final profile = await manager.create();

    expect(profile.profileId, 'synthetic-profile-id');
    expect((await manager.join()).profileId, profile.profileId);
    expect(objects.keys, contains('profile.json'));
    expect(
      objects.keys,
      isNot(contains('.gagaku-sync-probe-synthetic-profile-id')),
    );
  });

  test('maps revoked persisted access to a dedicated exception', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          SafSyncStore.channel,
          (_) => throw PlatformException(
            code: 'PERMISSION_DENIED',
            message: 'Synthetic grant was revoked',
          ),
        );

    await expectLater(
      SafSyncStore(treeUri).checkAccess(),
      throwsA(isA<SafPermissionException>()),
    );
  });

  test('preserves provider-loading failures as transient errors', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          SafSyncStore.channel,
          (_) => throw PlatformException(
            code: 'PROVIDER_LOADING',
            message: 'Synthetic provider is loading',
          ),
        );

    await expectLater(
      SafSyncStore(treeUri).list(''),
      throwsA(
        isA<SafSyncStoreException>()
            .having((error) => error.code, 'code', 'PROVIDER_LOADING')
            .having((error) => error.isTransient, 'isTransient', isTrue),
      ),
    );
  });
}
