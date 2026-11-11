import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paged_slivers/paged_slivers.dart';

import 'support.dart';

/// A chapter-feed-like entry: consecutive entries of one series merge.
typedef Entry = ({int series, String chapter});

/// A merged card: one series with its consecutive chapters.
typedef Card = ({int series, List<String> chapters});

/// Mirrors the chapter feed's grouping: consecutive entries with the same
/// series become one card, wherever page boundaries fall.
List<Card> groupConsecutive(List<Entry> entries) {
  final cards = <Card>[];
  for (final entry in entries) {
    if (cards.isNotEmpty && cards.last.series == entry.series) {
      cards.last.chapters.add(entry.chapter);
    } else {
      cards.add((series: entry.series, chapters: [entry.chapter]));
    }
  }
  return cards;
}

void main() {
  late ManualScheduler scheduler;
  late ScriptedFetcher<int, int> fetcher;
  late PagedController<int, int> controller;

  setUp(() {
    scheduler = ManualScheduler();
    fetcher = ScriptedFetcher();
    controller = PagedController(
      firstKey: 0,
      fetchPage: fetcher.call,
      scheduler: scheduler.call,
    );
  });

  tearDown(() => controller.dispose());

  /// Fetches the pending page and completes it with [result].
  Future<void> commit(PageResult<int, int> result) async {
    scheduler.flush();
    fetcher.complete(result);
    await settle();
  }

  test('memoizes on source items, not on every revision', () async {
    var runs = 0;
    final doubled = controller.project((items) {
      runs++;
      return [for (final i in items) i * 2];
    });
    doubled.addListener(() {});

    doubled.snapshot;
    final initialRuns = runs;

    controller.fetchNext();
    scheduler.flush(); // isLoading: revision changes, items do not
    final loading = doubled.snapshot;
    expect(runs, initialRuns);
    expect(loading.status, PagedStatus.loadingFirst);
    expect(loading.isLoading, isTrue);

    fetcher.complete(const PageResult.more([1, 2], nextKey: 2));
    await settle();
    final committed = doubled.snapshot;
    expect(runs, initialRuns + 1);
    expect(committed.items, [2, 4]);
    expect(committed.revision, greaterThan(loading.revision));

    // Repeated reads reuse the snapshot.
    expect(identical(committed, doubled.snapshot), isTrue);
    expect(runs, initialRuns + 1);
  });

  test('dependencies notifying recomputes and notifies', () async {
    final threshold = ValueNotifier(0);
    addTearDown(threshold.dispose);
    final filtered = controller.project(
      (items) => [
        for (final i in items)
          if (i >= threshold.value) i,
      ],
      dependencies: threshold,
    );
    var notifications = 0;
    filtered.addListener(() => notifications++);

    controller.fetchNext();
    await commit(const PageResult.last([1, 2, 3, 4]));
    expect(filtered.snapshot.items, [1, 2, 3, 4]);

    final before = notifications;
    threshold.value = 3;
    expect(notifications, before + 1);
    expect(filtered.snapshot.items, [3, 4]);
  });

  test('an empty projection with more pages keeps fetching', () async {
    final odd = controller.project(
      (items) => [
        for (final i in items)
          if (i.isOdd) i,
      ],
    );
    odd.addListener(() {});

    controller.fetchNext();
    await commit(const PageResult.more([2, 4], nextKey: 2));

    expect(odd.snapshot.items, isEmpty);
    expect(odd.snapshot.status, PagedStatus.loadingFirst);
    expect(controller.state.status, PagedStatus.idle);
    expect(scheduler.pending, 1, reason: 'projection requests the next page');

    await commit(const PageResult.last([6]));
    expect(fetcher.keys, [0, 2]);
    expect(odd.snapshot.status, PagedStatus.empty);
    expect(scheduler.pending, 0);
  });

  test('minItems refills until reached', () async {
    final view = controller.project((items) => items, minItems: 3);
    view.addListener(() {});

    controller.fetchNext();
    await commit(const PageResult.more([1], nextKey: 1));
    expect(view.snapshot.status, PagedStatus.loadingMore);
    await commit(const PageResult.more([2], nextKey: 2));
    await commit(const PageResult.more([3], nextKey: 3));

    expect(fetcher.keys, [0, 1, 2]);
    expect(view.snapshot.status, PagedStatus.idle);
    expect(scheduler.pending, 0);
  });

  test('minItems refill stops at the end', () async {
    final view = controller.project((items) => items, minItems: 10);
    view.addListener(() {});

    controller.fetchNext();
    await commit(const PageResult.more([1, 2], nextKey: 2));
    await commit(const PageResult.last([3]));

    expect(fetcher.keys, [0, 2]);
    expect(view.snapshot.status, PagedStatus.complete);
    expect(view.snapshot.items, [1, 2, 3]);
    expect(scheduler.pending, 0);
  });

  test('refill pauses on error and resumes on retry', () async {
    final view = controller.project((items) => items, minItems: 5);
    view.addListener(() {});

    controller.fetchNext();
    await commit(const PageResult.more([1], nextKey: 1));
    scheduler.flush();
    fetcher.fail('boom');
    await settle();
    expect(view.snapshot.status, PagedStatus.nextError);
    expect(scheduler.pending, 0);

    view.retry();
    await commit(const PageResult.last([2]));
    expect(fetcher.keys, [0, 1, 1]);
    expect(view.snapshot.items, [1, 2]);
  });

  test('projections chain and fetch through the chain', () async {
    final view = controller
        .project(
          (items) => [
            for (final i in items)
              if (i.isEven) i,
          ],
        )
        .project((items) => items.reversed.toList());
    view.addListener(() {});

    view.fetchNext();
    await commit(const PageResult.more([1, 2, 3, 4], nextKey: 4));
    expect(view.snapshot.items, [4, 2]);

    view.fetchNext();
    await commit(const PageResult.last([5, 6]));
    expect(view.snapshot.items, [6, 4, 2]);
    expect(view.snapshot.status, PagedStatus.complete);
  });

  test('source pages and keys are untouched', () async {
    final view = controller.project((items) => [items.length]);
    view.addListener(() {});

    controller.fetchNext();
    await commit(const PageResult.more([1, 2], nextKey: 2));
    controller.fetchNext();
    await commit(const PageResult.last([3]));

    expect(view.snapshot.items, [3]);
    expect(controller.state.keys, [0, 2]);
    expect(controller.state.pages.map((p) => p.items), [
      [1, 2],
      [3],
    ]);
    expect(controller.state.items, [1, 2, 3]);
  });

  test('a group spanning a page boundary stays one item', () async {
    final entries = ScriptedFetcher<int, Entry>();
    final feed = PagedController<int, Entry>(
      firstKey: 0,
      fetchPage: entries.call,
      scheduler: scheduler.call,
    );
    addTearDown(feed.dispose);
    final cards = feed.project(groupConsecutive);
    cards.addListener(() {});

    feed.fetchNext();
    scheduler.flush();
    entries.complete(
      const PageResult.more([
        (series: 1, chapter: 'a'),
        (series: 1, chapter: 'b'),
      ], nextKey: 2),
    );
    await settle();
    expect(cards.snapshot.items, hasLength(1));

    feed.fetchNext();
    scheduler.flush();
    entries.complete(
      const PageResult.last([
        (series: 1, chapter: 'c'),
        (series: 2, chapter: 'd'),
      ]),
    );
    await settle();

    final result = cards.snapshot.items;
    expect(result.map((c) => c.series), [1, 2]);
    expect(result.first.chapters, ['a', 'b', 'c']);
    expect(result.last.chapters, ['d']);
    // Pages keep their original split.
    expect(feed.state.pages.map((p) => p.items.length), [2, 2]);
  });

  test('unsubscribed projections stop listening to the source', () async {
    var runs = 0;
    final view = controller.project((items) {
      runs++;
      return items;
    });
    void listener() {}
    view.addListener(listener);
    view.removeListener(listener);
    final base = runs;

    controller.fetchNext();
    await commit(const PageResult.last([1]));
    expect(runs, base, reason: 'no listener means no recompute on notify');

    // Reading still produces fresh data.
    expect(view.snapshot.items, [1]);
    expect(runs, base + 1);
  });
}
