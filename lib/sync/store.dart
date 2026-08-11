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
