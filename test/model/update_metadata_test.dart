import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/model/update_metadata.dart';
import 'package:hive_ce/hive.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('gagaku_update_metadata_');
    Hive.init(tempDir.path);
    await Hive.openBox(gagakuLocalBox);
  });

  setUp(() => Hive.box(gagakuLocalBox).clear());

  tearDownAll(() async {
    await Hive.box(gagakuLocalBox).close();
    await tempDir.delete(recursive: true);
  });

  test('persists the last successful update check locally', () async {
    const store = HiveUpdateMetadataStore();
    final checkedAt = DateTime(2026, 8, 25, 12, 30);

    await store.recordUpdateCheck(checkedAt);

    expect(const HiveUpdateMetadataStore().lastUpdateCheck, checkedAt);
  });

  test(
    'persists ignored updates without duplicates and records the check',
    () async {
      const store = HiveUpdateMetadataStore();
      final checkedAt = DateTime(2026, 8, 25, 12, 30);

      await store.ignoreUpdate('1.2.3', checkedAt);
      await store.ignoreUpdate('1.2.3', checkedAt);

      const reloaded = HiveUpdateMetadataStore();
      expect(reloaded.ignoredUpdates, {'1.2.3'});
      expect(reloaded.lastUpdateCheck, checkedAt);
    },
  );

  test('tolerates malformed local metadata', () async {
    await Hive.box(gagakuLocalBox).putAll({
      updateLastCheckHiveKey: 42,
      updateIgnoredVersionsHiveKey: ['valid', 42],
    });

    const store = HiveUpdateMetadataStore();
    expect(store.lastUpdateCheck, isNull);
    expect(store.ignoredUpdates, {'valid'});
  });
}
