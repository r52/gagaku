import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/model/model.dart';
import 'package:hive_ce/hive.dart';
import 'package:logger/logger.dart';

void main() {
  group('CacheManager', () {
    late Directory tempDir;
    late LazyBox<CacheEntry> box;

    setUpAll(() async {
      logger = Logger(level: Level.off);
      tempDir = await Directory.systemTemp.createTemp('gagaku_cache_test');
      Hive.init(tempDir.path);
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(CacheEntryAdapter());
      }
    });

    setUp(() async {
      if (Hive.isBoxOpen(gagakuCache)) {
        box = Hive.lazyBox<CacheEntry>(gagakuCache);
      } else {
        box = await Hive.openLazyBox<CacheEntry>(gagakuCache);
      }
      await box.clear();
    });

    tearDownAll(() async {
      if (Hive.isBoxOpen(gagakuCache)) {
        await Hive.lazyBox<CacheEntry>(gagakuCache).close();
      }
      await tempDir.delete(recursive: true);
    });

    test('invalidateAll removes disk-only matching entries', () async {
      final cache = CacheManager();
      addTearDown(cache.dispose);

      await box.put('feed:one', CacheEntry(json.encode({'value': 1})));
      await box.put('other:one', CacheEntry(json.encode({'value': 2})));

      await cache.invalidateAll('feed:');

      expect(box.containsKey('feed:one'), isFalse);
      expect(box.containsKey('other:one'), isTrue);
      expect(await cache.exists('feed:one'), isFalse);
      expect(await cache.exists('other:one'), isTrue);
    });

    test('put overwrites memory and disk entries', () async {
      final cache = CacheManager();
      addTearDown(cache.dispose);

      await cache.put<Map<String, dynamic>>(
        'entry',
        json.encode({'value': 'old'}),
        {'value': 'old'},
      );
      await cache.put<Map<String, dynamic>>(
        'entry',
        json.encode({'value': 'new'}),
        {'value': 'new'},
      );

      expect(cache.get<Map<String, dynamic>>('entry'), {'value': 'new'});
      expect((await box.get('entry'))?.data, json.encode({'value': 'new'}));
    });
  });
}
