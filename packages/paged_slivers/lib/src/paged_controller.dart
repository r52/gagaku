import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import 'page_result.dart';
import 'paged_state.dart';
import 'paged_view.dart';

/// Runs [callback] after the current frame.
typedef PagedPostFrameScheduler = void Function(VoidCallback callback);

/// The default [PagedPostFrameScheduler]: a post-frame callback, with a frame
/// requested so the callback also runs while the app is otherwise idle.
void schedulePagedPostFrame(VoidCallback callback) {
  final binding = SchedulerBinding.instance;
  binding.addPostFrameCallback((_) => callback());
  binding.ensureVisualUpdate();
}

/// Owns the pages fetched through a [PageFetcher].
///
/// Fetches start through a post-frame scheduler, so [fetchNext] is safe to
/// call from build: neither the fetch nor its notifications happen
/// synchronously.
class PagedController<K, T> extends ChangeNotifier
    implements ValueListenable<PagedState<K, T>>, PagedView<T> {
  PagedController({
    required this._firstKey,
    required this._fetchPage,
    this._scheduler = schedulePagedPostFrame,
  }) : _state = PagedState<K, T>.initial(_firstKey);

  final K _firstKey;
  final PageFetcher<K, T> _fetchPage;
  final PagedPostFrameScheduler _scheduler;

  PagedState<K, T> _state;

  /// Bumped by [refresh] and [dispose]; results of older generations are
  /// dropped.
  int _generation = 0;
  bool _startScheduled = false;
  bool _disposed = false;
  Completer<void>? _refreshCompleter;

  PagedSnapshot<T>? _snapshot;

  /// The current state.
  PagedState<K, T> get state => _state;

  @override
  PagedState<K, T> get value => _state;

  @override
  PagedSnapshot<T> get snapshot {
    final cached = _snapshot;
    if (cached != null && cached.revision == _state.revision) return cached;
    final state = _state;
    return _snapshot = PagedSnapshot<T>(
      items: state.items,
      status: state.status,
      hasMore: state.hasMore,
      isLoading: state.isLoading,
      error: state.error,
      stackTrace: state.stackTrace,
      errorRevision: state.errorRevision,
      revision: state.revision,
    );
  }

  bool get _canStart =>
      !_disposed && !_state.isLoading && _state.hasMore && _state.error == null;

  @override
  void fetchNext() {
    if (_startScheduled || !_canStart) return;
    _startScheduled = true;
    final generation = _generation;
    _scheduler(() {
      if (generation != _generation) return;
      _startScheduled = false;
      _start();
    });
  }

  @override
  void retry() {
    if (_disposed || _state.error == null) return;
    _emit(_state.errorCleared());
    fetchNext();
  }

  /// Discards every page and fetches from the first key again.
  ///
  /// Results of fetches started before the refresh are dropped. The returned
  /// future completes when the first page of the new generation is committed
  /// or fails, or when the refresh is superseded or the controller disposed.
  Future<void> refresh() {
    if (_disposed) return Future.value();
    _generation++;
    _startScheduled = false;
    _completeRefresh();
    final completer = _refreshCompleter = Completer<void>();
    _emit(PagedState<K, T>.initial(_firstKey, revision: _state.revision + 1));
    fetchNext();
    return completer.future;
  }

  Future<void> _start() async {
    if (!_canStart) return;
    final generation = _generation;
    final key = _state.nextKey;
    _emit(_state.loading());

    final PageResult<K, T> result;
    try {
      result = await Future.sync(() => _fetchPage(key));
    } catch (error, stackTrace) {
      if (generation != _generation) return;
      _emit(_state.failed(error, stackTrace));
      _completeRefresh();
      return;
    }

    if (generation != _generation) return;
    final next = switch (result) {
      MorePageResult(:final nextKey) => (key: nextKey),
      LastPageResult() => null,
    };
    _emit(_state.committed(key, result.items, next));
    _completeRefresh();
  }

  void _emit(PagedState<K, T> state) {
    _state = state;
    notifyListeners();
  }

  void _completeRefresh() {
    final completer = _refreshCompleter;
    _refreshCompleter = null;
    if (completer != null && !completer.isCompleted) completer.complete();
  }

  @override
  void dispose() {
    _disposed = true;
    _generation++;
    _completeRefresh();
    super.dispose();
  }
}
