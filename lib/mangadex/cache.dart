import 'dart:convert';

import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// A simple in-memory + on-disk cache for temporarily storing MangaDex data.
/// Mainly to stop gagaku from querying the API for the same stuff
/// too often.

class CacheEntryAdapter extends TypeAdapter<CacheEntry> {
  @override
  final typeId = 0;

  @override
  CacheEntry read(BinaryReader reader) {
    final expiry = DateTime.parse(reader.readString());
    final entry = reader.readString();

    return CacheEntry(entry, expiry: expiry);
  }

  @override
  void write(BinaryWriter writer, CacheEntry obj) {
    writer.writeString(obj.expiry.toString());
    writer.writeString(obj.entry);
  }
}

class CacheEntry with ShortLivedData {
  @override
  late final DateTime expiry;

  final String _entry;
  String get entry => _entry;

  CacheEntry(this._entry,
      {DateTime? expiry, Duration duration = const Duration(minutes: 10)}) {
    if (expiry != null) {
      this.expiry = expiry;
    } else {
      this.expiry = DateTime.now().add(duration);
    }
  }
}

class CacheManager {
  static const _preferredMaxEntries = 20000;
  static const _preferredMaxDiskEntries = 2000;

  final LazyBox<CacheEntry> _box;

  /// Cache of API data
  final Map<String, CacheEntry> _cache = <String, CacheEntry>{};

  CacheManager() : _box = Hive.lazyBox(gagakuCache);

  /// Prunes all expired entries
  Future<void> _pruneExpired() async {
    logger.d('CacheManager: pruning expired entries...');

    final matchingKeys = <String>{};
    for (final MapEntry(key: key, value: value) in _cache.entries) {
      if (value.isExpired()) {
        matchingKeys.add(key);
      }
    }
    _cache.removeWhere((key, value) => matchingKeys.contains(key));
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
      if (!_cache[key]!.isExpired()) {
        exists = true;
      } else {
        remove(key);
      }
    }

    return exists;
  }

  /// Returns a single entry from the cache. Assumes the entry [exists].
  T get<T>(String key, [T Function(Map<String, dynamic> json)? unserializer]) {
    final interm = json.decode(_cache[key]!.entry);

    if (unserializer == null) {
      return interm as T;
    }

    return unserializer(interm);
  }

  /// Inserts a single entry into the cache if it doesn't [exists]
  /// If [overwrite] is true, then the entry is inserted regardless, overwriting
  /// existing values
  Future<void> put(String key, dynamic val, bool overwrite,
      [Duration expiry = const Duration(minutes: 10)]) async {
    final entry = CacheEntry(json.encode(val), duration: expiry);
    if (!await exists(key)) {
      _cache.putIfAbsent(key, () => entry);
      await _box.put(key, entry);
    } else if (overwrite) {
      _cache[key] = entry;
      await _box.put(key, entry);
    }

    if (_cache.length > _preferredMaxEntries ||
        _box.length > _preferredMaxDiskEntries) {
      _pruneExpired();
    }
  }

  /// Adds all API data from a [list] into the cache, resolving its ids automatically
  Future<void> putAllAPIResolved(Iterable<MangaDexUUID> list,
      [Duration expiry = const Duration(minutes: 10)]) async {
    final resolved = list.map((e) =>
        MapEntry(e.id, CacheEntry(json.encode(e.toJson()), duration: expiry)));

    _cache.addEntries(resolved);

    for (final e in resolved) {
      await _box.put(e.key, e.value);
    }

    if (_cache.length > _preferredMaxEntries ||
        _box.length > _preferredMaxDiskEntries) {
      _pruneExpired();
    }
  }

  /// Adds all API data from a [list] into the cache, resolving its ids automatically
  /// if requested, as a part of a special query given by [key]
  Future<void> putSpecialList(String key, Iterable<MangaDexUUID> list,
      {bool resolve = true,
      Duration expiry = const Duration(minutes: 10)}) async {
    logger.d('CacheManager: caching list: $key');

    // Transform data list to a list of uuids
    final ids = list.map((e) => e.id).toList();
    final entry = CacheEntry(json.encode(ids), duration: expiry);
    _cache[key] = entry; // Just overwrite it
    await _box.put(key, entry);

    if (resolve) {
      await putAllAPIResolved(list, expiry);
    }
  }

  /// Gets all API data that is a part of a special query given by [key]
  /// Assumes the special query [key] exists.
  Future<Iterable<T>> getSpecialList<T>(String key,
      [T Function(Map<String, dynamic> json)? unserializer]) async {
    logger.d('CacheManager: retrieving list: $key');

    final List<String> ids = List<String>.from(json.decode(_cache[key]!.entry));

    List<T> list = [];

    for (var e in ids) {
      if (await exists(e)) {
        final entry = get(e, unserializer);
        list.add(entry);
      }
    }

    return list;
  }
}
