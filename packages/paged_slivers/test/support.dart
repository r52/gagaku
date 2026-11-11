import 'dart:async';

import 'package:flutter/rendering.dart' show ScrollCacheExtent;
import 'package:material_ui/material_ui.dart';
import 'package:paged_slivers/paged_slivers.dart';

/// A post-frame scheduler that runs callbacks only when [flush] is called.
class ManualScheduler {
  final List<VoidCallback> _queue = [];

  int get pending => _queue.length;

  void call(VoidCallback callback) => _queue.add(callback);

  void flush() {
    while (_queue.isNotEmpty) {
      final batch = List.of(_queue);
      _queue.clear();
      for (final callback in batch) {
        callback();
      }
    }
  }
}

/// A fetcher whose results are completed by the test.
class ScriptedFetcher<K, T> {
  final List<K> keys = [];
  final List<Completer<PageResult<K, T>>> _completers = [];

  int get calls => keys.length;

  Future<PageResult<K, T>> call(K key) {
    keys.add(key);
    final completer = Completer<PageResult<K, T>>();
    _completers.add(completer);
    return completer.future;
  }

  /// Completes the most recent call.
  void complete(PageResult<K, T> result) => _completers.last.complete(result);

  /// Completes the call at [index].
  void completeAt(int index, PageResult<K, T> result) =>
      _completers[index].complete(result);

  /// Fails the most recent call.
  void fail(Object error) => _completers.last.completeError(error);
}

/// Lets pending microtasks (fetch completions) run.
Future<void> settle() => Future<void>.delayed(Duration.zero);

const testStatusBuilders = PagedStatusBuilders(
  retryLabel: 'Try again',
  emptyMessage: 'Nothing here',
);

/// Wraps [slivers] in an app with a [CustomScrollView].
Widget sliverApp(
  List<Widget> slivers, {
  ScrollController? controller,
  double? cacheExtent,
}) => MaterialApp(
  home: Scaffold(
    body: CustomScrollView(
      controller: controller,
      scrollCacheExtent: cacheExtent == null
          ? null
          : ScrollCacheExtent.pixels(cacheExtent),
      slivers: slivers,
    ),
  ),
);
