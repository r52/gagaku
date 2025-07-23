import 'dart:async';
import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache.g.dart';

/// A simple in-memory + on-disk cache for temporarily storing MangaDex data.
/// Mainly to stop gagaku from querying the API for the same stuff
/// too often.

typedef UnserializeCallback<T extends Object> =
    T Function(Map<String, dynamic> json);

@Riverpod(keepAlive: true)
CacheManager cache(Ref ref) {
  return CacheManager();
}

class CacheEntryAdapter extends TypeAdapter<CacheEntry> {
  @override
  final typeId = 0;

  @override
  CacheEntry read(BinaryReader reader) {
    final expiry = DateTime.parse(reader.readString());
    final entry = reader.readString();

    return CacheEntry(entry, expire: expiry);
  }

  @override
  void write(BinaryWriter writer, CacheEntry obj) {
    writer.writeString(obj.expiry.toString());
    writer.writeString(obj.data);
  }
}

class CacheEntry with ExpiringData {
  @override
  DateTime expiry;

  final String _data;
  String get data => _data;

  Object? _ref;
  UnserializeCallback? unserializer;

  CacheEntry(
    this._data, {
    DateTime? expire,
    Duration duration = const Duration(minutes: 15),
    Object? reference,
    this.unserializer,
  }) : expiry = (expire != null) ? expire : DateTime.now().add(duration),
       _ref = reference;

  T get<T>([UnserializeCallback? unserialize]) {
    if (_ref != null) {
      return _ref! as T;
    }

    // Load from data if a ref doesn't already exist

    final interm = json.decode(data);

    if (unserialize == null && unserializer == null) {
      _ref = interm;
    } else if (unserialize != null) {
      _ref = unserialize(interm);
    } else {
      _ref = unserializer!(interm);
    }

    return _ref! as T;
  }
}

class CacheManager {
  static const _preferredMaxEntries = 20000;
  static const _preferredMaxDiskEntries = 5000;

  final LazyBox<CacheEntry> _box;
  // ignore: unused_field
  Timer? _pruneSchedule;

  /// Cache of API data
  final Map<String, CacheEntry> _cache = <String, CacheEntry>{};

  CacheManager() : _box = Hive.lazyBox(gagakuCache) {
    _pruneSchedule = Timer.periodic(const Duration(minutes: 15), (timer) async {
      await _checkForPrune();
    });
  }

  Future<void> _checkForPrune() async {
    if (_cache.length > _preferredMaxEntries) {
      _pruneExpiredMemory();
    }

    if (_box.length > _preferredMaxDiskEntries) {
      _pruneExpiredDisk();
    }

    final imageCache = PaintingBinding.instance.imageCache;
    if (imageCache.currentSize >= imageCache.maximumSize) {
      imageCache.clear();
    }

    // clean stale HistoryLinks
    final store = GagakuData().store;
    final box = store.box<HistoryLink>();

    final builder = box.query();
    builder.backlinkMany(WebFavoritesList_.list);
    final inuseLinksQuery = builder.build();
    final inuseLinks = await inuseLinksQuery.findIdsAsync();
    inuseLinksQuery.close();

    final notInuseQuery = box
        .query(HistoryLink_.dbid.notOneOf(inuseLinks))
        .build();
    await notInuseQuery.removeAsync();
    notInuseQuery.close();
  }

  /// Prunes all expired entries
  Future<void> _pruneExpiredMemory() async {
    logger.d('CacheManager: pruning expired entries...');

    final matchingKeys = <String>{};
    for (final MapEntry(key: key, value: value) in _cache.entries) {
      if (value.isExpired) {
        matchingKeys.add(key);
      }
    }
    _cache.removeWhere((key, value) => matchingKeys.contains(key));
    await _box.deleteAll(matchingKeys);
  }

  Future<void> _pruneExpiredDisk() async {
    logger.d('CacheManager: pruning expired entries from disk...');

    final matchingKeys = <String>{};
    for (final (key as String) in _box.keys) {
      final entry = await _box.get(key);
      if (entry != null && entry.isExpired) {
        matchingKeys.add(key);
      }
    }

    await _box.deleteAll(matchingKeys);
  }

  /// Clears the cache
  Future<void> clearAll() async {
    _cache.clear();
    await _box.clear();
  }

  /// Removes an entry with the given [key]
  Future<void> remove(String key) async {
    _cache.remove(key);
    await _box.delete(key);
  }

  Future<void> invalidateAll(String startsWith) async {
    logger.d('CacheManager: removing all entries starting with: $startsWith');

    final matchingKeys = <String>{};
    for (final e in _cache.entries) {
      if (e.key.startsWith(startsWith)) {
        matchingKeys.add(e.key);
      }
    }

    _cache.removeWhere((key, value) => matchingKeys.contains(key));
    await _box.deleteAll(matchingKeys);
  }

  /// Returns true if the given [key] exists in the cache and has not expired
  /// Returns false otherwise.
  /// The cache entry provided by [key] is pruned if it has expired.
  Future<bool> exists(String key) async {
    bool exists = false;

    bool inMemory = _cache.containsKey(key);
    bool onDisk = _box.containsKey(key);

    if (onDisk && !inMemory) {
      // Load it into memory
      final entry = await _box.get(key);
      if (entry != null) {
        _cache[key] = entry;
        inMemory = true;
      }
    }

    if (inMemory) {
      if (!_cache[key]!.isExpired) {
        exists = true;
      } else {
        await remove(key);
      }
    }

    return exists;
  }

  /// Returns a single entry from the cache. Assumes the entry [exists].
  T get<T>(String key, [UnserializeCallback? unserializer]) =>
      _cache[key]!.get(unserializer);

  /// Inserts a single entry into the cache if it doesn't [exists]
  /// If [overwrite] is true, then the entry is inserted regardless, overwriting
  /// existing values
  Future<T> put<T>(
    String key,
    String data,
    T reference,
    bool overwrite, {
    Duration expiry = const Duration(minutes: 15),
    UnserializeCallback? unserializer,
  }) async {
    final entry = CacheEntry(
      data,
      duration: expiry,
      reference: reference,
      unserializer: unserializer,
    );
    if (!await exists(key)) {
      _cache.putIfAbsent(key, () => entry);
    } else if (overwrite) {
      _cache[key] = entry;
    }

    await _box.put(key, entry);

    logger.d(
      "CacheManager: memory cache size: ${_cache.length}; disk cache size: ${_box.length}",
    );

    return _cache[key]!.get(unserializer);
  }

  /// Inserts all provided entries into the cache, overwriting any existing
  /// entries
  Future<void> putAll(Map<String, CacheEntry> map) async {
    for (var MapEntry(:key, value: entry) in map.entries) {
      if (!await exists(key)) {
        _cache.putIfAbsent(key, () => entry);
      } else {
        _cache[key] = entry;
      }
    }

    await _box.putAll(map);

    logger.d(
      "CacheManager: memory cache size: ${_cache.length}; disk cache size: ${_box.length}",
    );
  }
}
