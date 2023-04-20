/// A simple in-memory cache for temporarily storing MangaDex data.
/// Mainly to stop gagaku from querying the API for the same stuff
/// too often.

class CacheEntry<T> {
  final T _entry;
  final DateTime _created;
  final int _cacheExpiration; // in minutes

  T get entry => _entry;
  DateTime get created => _created;
  bool get expired =>
      (DateTime.now().difference(_created).inMinutes > _cacheExpiration);

  CacheEntry(this._entry, [this._cacheExpiration = 10])
      : _created = DateTime.now();
}

class CacheManager {
  static const _preferredMaxEntries = 20000;

  /// Cache of API data
  final Map<String, CacheEntry<dynamic>> _cache =
      <String, CacheEntry<dynamic>>{};

  /// Prunes all expired entries
  void _pruneExpired() {
    _cache.removeWhere((key, value) => value.expired);
  }

  /// Clears the cache
  void clearAll() {
    _cache.clear();
  }

  /// Removes an entry with the given [key]
  void remove(String key) {
    _cache.remove(key);
  }

  /// Returns true if the given [key] exists in the cache and has not expired
  /// Returns false otherwise.
  /// The cache entry provided by [key] is pruned if it has expired.
  bool exists(String key) {
    bool exists = false;

    if (_cache.containsKey(key)) {
      if (!_cache[key]!.expired) {
        exists = true;
      } else {
        remove(key);
      }
    }

    return exists;
  }

  /// Returns a single entry from the cache. Assumes the entry [exists].
  T get<T>(String key) {
    T entry = _cache[key]!.entry;
    return entry;
  }

  /// Inserts a single entry into the cache if it doesn't [exists]
  /// If [overwrite] is true, then the entry is inserted regardless, overwriting
  /// existing values
  void put(String key, dynamic val, bool overwrite, [int expiry = 10]) {
    if (!exists(key)) {
      _cache.putIfAbsent(key, () => CacheEntry(val, expiry));
    } else if (overwrite) {
      _cache[key] = CacheEntry(val, expiry);
    }

    if (_cache.length > _preferredMaxEntries) {
      _pruneExpired();
    }
  }

  /// Adds all API data from a [list] into the cache, resolving its ids automatically
  void putAllAPIResolved(Iterable<dynamic> list) {
    final resolved = list.map((e) => MapEntry(e.id as String, CacheEntry(e)));
    _cache.addEntries(resolved);

    if (_cache.length > _preferredMaxEntries) {
      _pruneExpired();
    }
  }

  /// Adds all API data from a [list] into the cache, resolving its ids automatically
  /// if requested, as a part of a special query given by [key]
  void putSpecialList(String key, Iterable<dynamic> list,
      {bool resolve = true, int expiry = 10}) {
    // Transform data list to a list of uuids
    final ids = list.map((e) => e.id as String).toList();
    _cache[key] = CacheEntry(ids, expiry); // Just overwrite it

    if (resolve) {
      putAllAPIResolved(list);
    }
  }

  /// Gets all API data that is a part of a special query given by [key]
  /// Assumes the special query [key] exists.
  Iterable<T> getSpecialList<T>(String key) {
    final List<String> ids = _cache[key]!.entry;

    List<T> list = [];

    for (var e in ids) {
      if (exists(e)) {
        T entry = _cache[e]!.entry;
        list.add(entry);
      }
    }

    return list;
  }
}
