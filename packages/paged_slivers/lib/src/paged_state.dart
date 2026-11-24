import 'package:flutter/foundation.dart';

/// What a paged layout shows.
///
/// Statuses are derived from the number of *displayed* items, which for a
/// projection is the projected count rather than the fetched count.
enum PagedStatus {
  /// Nothing to display yet and more may come; a fetch is pending or running.
  loadingFirst,

  /// Nothing to display and the last fetch failed.
  firstError,

  /// Nothing to display and no more pages exist.
  empty,

  /// Items are displayed and more pages exist; no fetch is running.
  idle,

  /// Items are displayed, more pages exist, and a fetch is running (or a
  /// projection is refilling below its minimum).
  loadingMore,

  /// Items are displayed and fetching the next page failed.
  nextError,

  /// Items are displayed and no more pages exist.
  complete;

  /// Whether this status shows the item list rather than a first-page
  /// indicator.
  bool get showsItems => switch (this) {
    loadingFirst || firstError || empty => false,
    idle || loadingMore || nextError || complete => true,
  };
}

/// Derives a [PagedStatus] from the displayed item count and fetch state.
PagedStatus resolvePagedStatus({
  required int displayedCount,
  required bool hasMore,
  required bool isLoading,
  required bool hasError,
  bool belowMinimum = false,
}) {
  if (displayedCount == 0) {
    if (hasError) return PagedStatus.firstError;
    return hasMore ? PagedStatus.loadingFirst : PagedStatus.empty;
  }
  if (hasError) return PagedStatus.nextError;
  if (!hasMore) return PagedStatus.complete;
  if (isLoading || belowMinimum) return PagedStatus.loadingMore;
  return PagedStatus.idle;
}

/// One committed page.
@immutable
final class PagedPage<K, T> {
  const PagedPage(this.key, this.items);

  /// The key this page was fetched with.
  final K key;

  /// The items the fetcher returned for [key].
  final List<T> items;
}

/// Immutable paging state owned by a `PagedController`.
///
/// Every change produces a new instance with a larger [revision]. Equality is
/// identity: a state is never compared by its contents, so comparisons stay
/// cheap however many pages are loaded.
@immutable
final class PagedState<K, T> {
  PagedState._({
    required List<PagedPage<K, T>> pages,
    required this._next,
    required this.isLoading,
    required this.error,
    required this.stackTrace,
    required this.errorRevision,
    required this.revision,
    _ItemsCache<T>? items,
  }) : pages = List.unmodifiable(pages),
       _items = items ?? _ItemsCache<T>();

  /// The state before anything is fetched.
  factory PagedState.initial(K firstKey, {int revision = 0}) => PagedState._(
    pages: const [],
    next: (key: firstKey),
    isLoading: false,
    error: null,
    stackTrace: null,
    errorRevision: 0,
    revision: revision,
  );

  /// Committed pages in fetch order.
  final List<PagedPage<K, T>> pages;

  final ({K key})? _next;

  /// Whether a fetch is running.
  final bool isLoading;

  /// The error of the last fetch, until it is retried or refreshed.
  final Object? error;

  /// The stack trace accompanying [error].
  final StackTrace? stackTrace;

  /// Increments once per failed fetch, so listeners can react to each failure
  /// once rather than on every notification while an error is shown.
  final int errorRevision;

  /// Increments on every state change.
  final int revision;

  final _ItemsCache<T> _items;

  /// All committed items, flattened and cached.
  ///
  /// The list instance changes only when a page is committed or the state is
  /// reset, so it can be used as a memo key.
  List<T> get items => _items.value ??= List.unmodifiable([
    for (final page in pages) ...page.items,
  ]);

  /// The keys of [pages].
  Iterable<K> get keys => pages.map((p) => p.key);

  /// Whether another page exists.
  bool get hasMore => _next != null;

  /// The key of the next page. Throws when [hasMore] is false.
  K get nextKey {
    final next = _next;
    if (next == null) throw StateError('No more pages');
    return next.key;
  }

  /// The status for this state's own items.
  PagedStatus get status => resolvePagedStatus(
    displayedCount: items.length,
    hasMore: hasMore,
    isLoading: isLoading,
    hasError: error != null,
  );

  PagedState<K, T> _copy({
    List<PagedPage<K, T>>? pages,
    ({K key})? Function()? next,
    bool? isLoading,
    Object? Function()? error,
    StackTrace? Function()? stackTrace,
    int? errorRevision,
  }) => PagedState._(
    pages: pages ?? this.pages,
    next: next != null ? next() : _next,
    isLoading: isLoading ?? this.isLoading,
    error: error != null ? error() : this.error,
    stackTrace: stackTrace != null ? stackTrace() : this.stackTrace,
    errorRevision: errorRevision ?? this.errorRevision,
    revision: revision + 1,
    // Reuse the flattened list unless the pages change.
    items: pages == null ? _items : null,
  );

  @override
  String toString() =>
      'PagedState(pages: ${pages.length}, items: ${items.length}, '
      'hasMore: $hasMore, isLoading: $isLoading, error: $error, '
      'revision: $revision)';
}

class _ItemsCache<T> {
  List<T>? value;
}

/// Internal transitions used by `PagedController`.
extension PagedStateTransitions<K, T> on PagedState<K, T> {
  PagedState<K, T> loading() =>
      _copy(isLoading: true, error: () => null, stackTrace: () => null);

  PagedState<K, T> committed(K key, List<T> items, ({K key})? next) => _copy(
    pages: [...pages, PagedPage(key, List.unmodifiable(items))],
    next: () => next,
    isLoading: false,
  );

  PagedState<K, T> failed(Object error, StackTrace stackTrace) => _copy(
    isLoading: false,
    error: () => error,
    stackTrace: () => stackTrace,
    errorRevision: errorRevision + 1,
  );

  PagedState<K, T> errorCleared() =>
      _copy(error: () => null, stackTrace: () => null);
}
