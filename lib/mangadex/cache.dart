import 'dart:convert';

import 'package:gagaku/cache.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/types.dart';

extension MDCacheManagerExt on CacheManager {
  /// Adds all API data from a [list] into the cache, resolving its ids automatically
  Future<void> putAllAPIResolved(Iterable<MangaDexUUID> list,
      [Duration expiry = const Duration(minutes: 15), UnserializeCallback? unserializer]) async {
    final resolved = {
      for (var e in list)
        e.id: CacheEntry(json.encode(e.toJson()), duration: expiry, reference: e, unserializer: unserializer)
    };

    await putAll(resolved);
  }

  /// Adds all API data from a [list] into the cache, resolving its ids automatically
  /// if requested, as a part of a special query given by [key]
  Future<void> putSpecialList(
    String key,
    Iterable<MangaDexUUID> list, {
    bool resolve = true,
    Duration expiry = const Duration(minutes: 15),
    UnserializeCallback? unserializer,
  }) async {
    logger.d('CacheManager: caching list: $key for ${expiry.toString()}');

    // Transform data list to a list of uuids
    final ids = list.map((e) => e.id).toList();

    // Overwrite any previous entries
    await put(key, json.encode(ids), ids, true, expiry: expiry);

    if (resolve) {
      await putAllAPIResolved(list, expiry, unserializer);
    }
  }

  /// Gets all API data that is a part of a special query given by [key]
  /// Assumes the special query [key] exists.
  Future<Iterable<CRef>> getSpecialList(String key, [UnserializeCallback? unserializer]) async {
    logger.d('CacheManager: retrieving list: $key');

    final entry = get(key).get<List<dynamic>>();
    final List<String> ids = List<String>.from(entry);

    List<CRef> list = [];

    for (var e in ids) {
      if (await exists(e)) {
        final entry = get(e, unserializer);
        list.add(entry);
      }
    }

    return list;
  }
}
