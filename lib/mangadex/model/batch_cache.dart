part of 'model.dart';

typedef _BatchCacheFetch<Item, Value> =
    Future<Map<String, Value>> Function(Iterable<Item> items);
typedef _BatchCacheRead<Value> = Future<Map<String, Value>> Function();
typedef _BatchCacheWrite<Value> = void Function(Map<String, Value> value);

/// Coalesces keyed cache misses into batched requests and merges fetched values
/// into the latest cache snapshot.
///
/// All callers participating in a drain receive the same complete cache. Good
/// cache state remains visible while requests are in flight and is not replaced
/// if a request fails.
class _BatchCacheCoordinator<Item, Value> {
  _BatchCacheCoordinator({
    required this.keyOf,
    required this.fetch,
    required this.read,
    required this.write,
    this.isExpired,
    this.batchDelay = Duration.zero,
  });

  final String Function(Item item) keyOf;
  final _BatchCacheFetch<Item, Value> fetch;
  final _BatchCacheRead<Value> read;
  final _BatchCacheWrite<Value> write;
  final bool Function(Value value)? isExpired;
  final Duration batchDelay;

  final Map<String, Item> _queue = {};
  Completer<Map<String, Value>>? _drainCompleter;
  Timer? _batchTimer;
  bool _isDraining = false;

  Future<Map<String, Value>> get(Iterable<Item> items) async {
    final currentState = await read();
    _enqueueMissing(items, currentState);

    if (_queue.isEmpty && !_isDraining) {
      return currentState;
    }

    final completer = _drainCompleter ??= Completer<Map<String, Value>>();
    _scheduleDrain();
    return completer.future;
  }

  void _enqueueMissing(Iterable<Item> items, Map<String, Value> currentState) {
    for (final item in items) {
      final key = keyOf(item);
      if (_needsFetch(key, currentState)) {
        _queue[key] = item;
      }
    }
  }

  void _scheduleDrain() {
    if (_isDraining || _batchTimer != null) {
      return;
    }

    _batchTimer = Timer(batchDelay, _drain);
  }

  Future<void> _drain() async {
    _batchTimer = null;
    _isDraining = true;
    final completer = _drainCompleter!;

    try {
      var currentState = await read();

      while (_queue.isNotEmpty) {
        final batch = _takeMissing(currentState);
        if (batch.isEmpty) {
          break;
        }

        final fetched = await fetch(batch);
        currentState = {...await read(), ...fetched};
        write(currentState);
      }

      _drainCompleter = null;
      completer.complete(currentState);
    } catch (error, stackTrace) {
      _queue.clear();
      _drainCompleter = null;
      completer.completeError(error, stackTrace);
    } finally {
      _isDraining = false;
      if (_queue.isNotEmpty) {
        _scheduleDrain();
      }
    }
  }

  List<Item> _takeMissing(Map<String, Value> currentState) {
    final batch = <Item>[];

    for (final entry in _queue.entries) {
      if (_needsFetch(entry.key, currentState)) {
        batch.add(entry.value);
      }
    }

    _queue.clear();
    return batch;
  }

  bool _needsFetch(String key, Map<String, Value> currentState) {
    if (!currentState.containsKey(key)) {
      return true;
    }

    final expiryCheck = isExpired;
    return expiryCheck != null && expiryCheck(currentState[key] as Value);
  }
}
