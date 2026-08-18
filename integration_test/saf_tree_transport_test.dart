import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/sync/saf_store.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('selects and exercises an Android document tree', (tester) async {
    expect(Platform.isAndroid, isTrue);

    final selection = await tester.runAsync(SafSyncStore.pickTree);
    expect(selection, isNotNull);

    final store = SafSyncStore(selection!.uri);
    final prefix =
        'gagaku-phase5-${DateTime.now().microsecondsSinceEpoch}/nested/';
    final key = '${prefix}probe.bin';
    const bytes = <int>[0, 1, 2, 127, 128, 254, 255];
    addTearDown(() async {
      try {
        await store.delete(key);
      } on SafSyncStoreException {
        // The assertion path may fail before the object is created.
      }
    });

    await store.checkAccess();
    await store.create(key, bytes);
    expect(await store.read(key), bytes);

    final objects = await store.list(prefix);
    expect(objects, hasLength(1));
    expect(objects.single.key, key);
    expect(objects.single.length, bytes.length);

    await store.delete(key);
    expect(await store.list(prefix), isEmpty);
  });
}
