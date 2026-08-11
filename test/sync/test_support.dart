import 'dart:collection';

import 'package:gagaku/sync/metadata.dart';
import 'package:gagaku/sync/store.dart';

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
    if (bytes == null) throw SyncObjectNotFoundException(key);
    return List<int>.of(bytes);
  }
}

final class MemorySyncMetadataStore implements SyncMetadataStore {
  MemorySyncMetadataStore([SyncLocalState? initial])
    : _state = (initial ?? SyncLocalState()).copy();

  SyncLocalState _state;

  @override
  Future<SyncLocalState> read() async => _state.copy();

  @override
  Future<void> write(SyncLocalState state) async {
    _state = state.copy();
  }

  SyncLocalState get state => _state.copy();
}
