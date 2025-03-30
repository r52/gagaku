import 'dart:convert';

import 'package:gagaku/model/cache.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model/types.dart';

extension MDCacheManagerExt on CacheManager {
  /// Adds all API data from a [list] into the cache, resolving its ids automatically
  Future<void> putAllAPIResolved(
    Iterable<MangaDexEntity> list, [
    Duration expiry = const Duration(minutes: 15),
    UnserializeCallback? unserializer,
  ]) async {
    final resolved = {
      for (var e in list)
        e.id: CacheEntry(
          json.encode(e.toJson()),
          duration: expiry,
          reference: e,
          unserializer: unserializer,
        ),
    };

    await putAll(resolved);
  }

  Future<void> putEntityList(
    String key,
    MDEntityList list, {
    bool resolve = true,
    Duration expiry = const Duration(minutes: 15),
    UnserializeCallback? unserializer,
  }) async {
    logger.d(
      'CacheManager: caching entity list: $key for ${expiry.toString()}',
    );

    // Overwrite any previous entries
    await put(key, json.encode(list), list, true, expiry: expiry);

    if (resolve) {
      await putAllAPIResolved(list.data, expiry, unserializer);
    }
  }

  Future<MDEntityList> getEntityList(String key) async {
    logger.d('CacheManager: retrieving entity list: $key');

    final list = get<MDEntityList>(key, MDEntityList.fromJson);
    return list;
  }
}
