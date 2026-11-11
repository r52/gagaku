/// The outcome of fetching one page.
///
/// [PageResult.more] carries the key of the following page, which may be any
/// value of `K`, including `null`. [PageResult.last] ends pagination.
sealed class PageResult<K, T> {
  const PageResult._(this.items);

  /// A page followed by another page fetched with [nextKey].
  const factory PageResult.more(List<T> items, {required K nextKey}) =
      MorePageResult<K, T>;

  /// The final page.
  const factory PageResult.last(List<T> items) = LastPageResult<K, T>;

  /// Offset paging: the next key is `offset + limit` while it is below
  /// [total]; otherwise this is the last page.
  ///
  /// Termination compares offsets rather than the number of loaded items, so a
  /// page may hold fewer items than it consumed from the source (for example
  /// after dropping unresolved entries) without requesting past the end.
  static PageResult<int, T> offset<T>(
    List<T> items, {
    required int offset,
    required int limit,
    required int total,
  }) {
    assert(offset >= 0, 'offset must not be negative');
    assert(limit > 0, 'limit must be positive');
    final next = offset + limit;
    return next < total
        ? PageResult<int, T>.more(items, nextKey: next)
        : PageResult<int, T>.last(items);
  }

  /// The items of this page.
  final List<T> items;
}

/// A page followed by another page.
final class MorePageResult<K, T> extends PageResult<K, T> {
  const MorePageResult(super.items, {required this.nextKey}) : super._();

  /// The key of the following page.
  final K nextKey;
}

/// The final page.
final class LastPageResult<K, T> extends PageResult<K, T> {
  const LastPageResult(super.items) : super._();
}

/// Fetches the page identified by [key].
typedef PageFetcher<K, T> = Future<PageResult<K, T>> Function(K key);
