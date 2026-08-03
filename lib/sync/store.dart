import 'dart:collection';

final class SyncObject {
  const SyncObject({required this.key, required this.length});

  final String key;
  final int length;
}

abstract interface class SyncStore {
  Future<List<SyncObject>> list(String prefix);

  Future<List<int>> read(String key);

  Future<void> create(String key, List<int> bytes);

  Future<void> delete(String key);
}

final class SyncObjectAlreadyExistsException implements Exception {
  const SyncObjectAlreadyExistsException(this.key);

  final String key;

  @override
  String toString() => 'Sync object already exists: $key';
}

final class SyncObjectNotFoundException implements Exception {
  const SyncObjectNotFoundException(this.key);

  final String key;

  @override
  String toString() => 'Sync object not found: $key';
}

/// Deterministic transport used by protocol tests and simulations.
final class MemorySyncStore implements SyncStore {
  MemorySyncStore({this.reverseListings = false});

  final bool reverseListings;
  final Map<String, List<int>> _objects = {};
  final Set<String> deleteFailures = {};

  UnmodifiableMapView<String, List<int>> get objects => UnmodifiableMapView({
    for (final MapEntry(:key, :value) in _objects.entries)
      key: List<int>.unmodifiable(value),
  });

  void seed(String key, List<int> bytes) {
    _objects[key] = List<int>.of(bytes);
  }

  @override
  Future<void> create(String key, List<int> bytes) async {
    if (_objects.containsKey(key)) {
      throw SyncObjectAlreadyExistsException(key);
    }
    _objects[key] = List<int>.of(bytes);
  }

  @override
  Future<void> delete(String key) async {
    if (deleteFailures.contains(key)) {
      throw StateError('Injected delete failure for $key');
    }
    _objects.remove(key);
  }

  @override
  Future<List<SyncObject>> list(String prefix) async {
    final result = [
      for (final MapEntry(:key, :value) in _objects.entries)
        if (key.startsWith(prefix)) SyncObject(key: key, length: value.length),
    ]..sort((a, b) => a.key.compareTo(b.key));
    return reverseListings ? result.reversed.toList() : result;
  }

  @override
  Future<List<int>> read(String key) async {
    final bytes = _objects[key];
    if (bytes == null) {
      throw SyncObjectNotFoundException(key);
    }
    return List<int>.of(bytes);
  }
}
