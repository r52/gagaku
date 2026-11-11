import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'paged_state.dart';

/// What a layout needs from a paged source at one point in time.
@immutable
final class PagedSnapshot<V> {
  const PagedSnapshot({
    required this.items,
    required this.status,
    required this.hasMore,
    required this.isLoading,
    required this.error,
    required this.stackTrace,
    required this.errorRevision,
    required this.revision,
  });

  /// The displayed items. The instance changes only when the items do.
  final List<V> items;

  /// The status derived from [items] and the fetch state.
  final PagedStatus status;

  /// Whether the underlying source has more pages.
  final bool hasMore;

  /// Whether the underlying source is fetching.
  final bool isLoading;

  /// The underlying source's last fetch error.
  final Object? error;

  /// The stack trace accompanying [error].
  final StackTrace? stackTrace;

  /// Increments once per failed fetch of the underlying source.
  final int errorRevision;

  /// Changes whenever anything in this snapshot may have changed.
  final int revision;
}

/// A read-only paged sequence that layouts consume.
///
/// Implemented by `PagedController` and by projections created with
/// [PagedViewProjection.project]. [fetchNext] must be idempotent and safe to
/// call during build.
abstract interface class PagedView<V> implements Listenable {
  /// The current snapshot.
  PagedSnapshot<V> get snapshot;

  /// Requests the next page if one exists and none is pending, running, or
  /// failed. Safe to call during build.
  void fetchNext();

  /// Clears a failed fetch and requests the failed page again, keeping the
  /// committed pages.
  void retry();
}

/// Creates projections of a [PagedView].
extension PagedViewProjection<T> on PagedView<T> {
  /// Returns a view whose items are `transform(items)`.
  ///
  /// [transform] runs over the full list of source items and must be pure: its
  /// result may depend only on its argument and on state that notifies
  /// [dependencies]. It reruns only when the source items change or
  /// [dependencies] notifies.
  ///
  /// Status and fetching delegate to this view, except that emptiness and the
  /// fetch trigger use the projected count. While the projection holds fewer
  /// than `max(minItems, 1)` items and more pages exist, it keeps fetching.
  ///
  /// Projections subscribe to this view only while they have listeners, so
  /// they need no disposal. Projections may chain.
  PagedView<V> project<V>(
    List<V> Function(List<T> items) transform, {
    Listenable? dependencies,
    int minItems = 0,
  }) => PagedProjection<T, V>(
    this,
    transform,
    dependencies: dependencies,
    minItems: minItems,
  );
}

/// A [PagedView] whose items are derived from another view's items.
///
/// The source's pages and keys are never rewritten.
final class PagedProjection<T, V> implements PagedView<V> {
  PagedProjection(
    this._source,
    this._transform, {
    this._dependencies,
    this._minItems = 0,
  });

  final PagedView<T> _source;
  final List<V> Function(List<T> items) _transform;
  final Listenable? _dependencies;
  final int _minItems;

  final List<VoidCallback> _listeners = [];
  bool get _subscribed => _listeners.isNotEmpty;

  /// Bumped when [_dependencies] notifies while subscribed.
  int _dependencyVersion = 0;

  List<T>? _lastSourceItems;
  int? _lastDependencyVersion;
  List<V> _projected = const [];
  int _transformCount = 0;

  int? _lastSourceRevision;
  PagedSnapshot<V>? _snapshot;
  int _revision = 0;

  /// How many times the transform has run. Exposed for tests.
  @visibleForTesting
  int get transformCount => _transformCount;

  int get _effectiveMin => math.max(_minItems, 1);

  @override
  PagedSnapshot<V> get snapshot {
    final source = _source.snapshot;
    // Without a subscription, dependency changes cannot be observed, so a
    // projection with dependencies recomputes on every unsubscribed read.
    if (!_subscribed && _dependencies != null) _dependencyVersion++;

    final itemsChanged =
        !identical(source.items, _lastSourceItems) ||
        _dependencyVersion != _lastDependencyVersion;
    if (itemsChanged) {
      _projected = List.unmodifiable(_transform(source.items));
      _transformCount++;
      _lastSourceItems = source.items;
      _lastDependencyVersion = _dependencyVersion;
    }

    final cached = _snapshot;
    if (cached != null &&
        !itemsChanged &&
        _lastSourceRevision == source.revision) {
      return cached;
    }
    _lastSourceRevision = source.revision;

    final count = _projected.length;
    return _snapshot = PagedSnapshot<V>(
      items: _projected,
      status: resolvePagedStatus(
        displayedCount: count,
        hasMore: source.hasMore,
        isLoading: source.isLoading,
        hasError: source.error != null,
        belowMinimum: count < _effectiveMin,
      ),
      hasMore: source.hasMore,
      isLoading: source.isLoading,
      error: source.error,
      stackTrace: source.stackTrace,
      errorRevision: source.errorRevision,
      revision: ++_revision,
    );
  }

  @override
  void fetchNext() => _source.fetchNext();

  @override
  void retry() => _source.retry();

  /// Keeps fetching while the projection is below its minimum.
  void _refillIfNeeded() {
    final current = snapshot;
    if (current.hasMore &&
        !current.isLoading &&
        current.error == null &&
        current.items.length < _effectiveMin) {
      _source.fetchNext();
    }
  }

  void _onSourceChanged() {
    _refillIfNeeded();
    _notify();
  }

  void _onDependenciesChanged() {
    _dependencyVersion++;
    _refillIfNeeded();
    _notify();
  }

  void _notify() {
    for (final listener in List.of(_listeners)) {
      if (_listeners.contains(listener)) listener();
    }
  }

  @override
  void addListener(VoidCallback listener) {
    final wasSubscribed = _subscribed;
    _listeners.add(listener);
    if (!wasSubscribed) {
      _source.addListener(_onSourceChanged);
      _dependencies?.addListener(_onDependenciesChanged);
      // Dependency changes while unsubscribed were not observed.
      if (_dependencies != null) _dependencyVersion++;
      _refillIfNeeded();
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    if (!_listeners.remove(listener)) return;
    if (!_subscribed) {
      _source.removeListener(_onSourceChanged);
      _dependencies?.removeListener(_onDependenciesChanged);
    }
  }
}
