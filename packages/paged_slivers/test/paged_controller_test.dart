import 'package:flutter_test/flutter_test.dart';
import 'package:paged_slivers/paged_slivers.dart';

import 'support.dart';

void main() {
  group('PageResult.offset', () {
    test('continues while the next offset is below the total', () {
      final result = PageResult.offset([1], offset: 0, limit: 10, total: 25);
      expect(result, isA<MorePageResult<int, int>>());
      expect((result as MorePageResult<int, int>).nextKey, 10);
    });

    test('ends when the next offset reaches the total exactly', () {
      final result = PageResult.offset([1], offset: 10, limit: 10, total: 20);
      expect(result, isA<LastPageResult<int, int>>());
    });

    test('ends when the next offset passes the total', () {
      final result = PageResult.offset([1], offset: 20, limit: 10, total: 25);
      expect(result, isA<LastPageResult<int, int>>());
    });

    test('ends for an empty total', () {
      final result = PageResult.offset(<int>[], offset: 0, limit: 10, total: 0);
      expect(result, isA<LastPageResult<int, int>>());
    });

    test('short pages do not end paging early', () {
      // Dropped entries make the page shorter than the consumed range.
      final result = PageResult.offset([1, 2], offset: 0, limit: 10, total: 30);
      expect((result as MorePageResult<int, int>).nextKey, 10);
    });
  });

  group('PagedController', () {
    late ManualScheduler scheduler;
    late ScriptedFetcher<int, String> fetcher;
    late PagedController<int, String> controller;

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

    test('starts in loadingFirst with nothing fetched', () {
      expect(controller.state.status, PagedStatus.loadingFirst);
      expect(controller.state.hasMore, isTrue);
      expect(controller.state.nextKey, 0);
      expect(fetcher.calls, 0);
    });

    test('fetchNext defers the fetch to the scheduler', () {
      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.fetchNext();
      expect(fetcher.calls, 0);
      expect(notifications, 0);

      scheduler.flush();
      expect(fetcher.keys, [0]);
      expect(controller.state.isLoading, isTrue);
      expect(notifications, 1);
    });

    test('deduplicates requests while scheduled or in flight', () async {
      controller
        ..fetchNext()
        ..fetchNext()
        ..fetchNext();
      expect(scheduler.pending, 1);
      scheduler.flush();
      controller.fetchNext();
      scheduler.flush();
      expect(fetcher.calls, 1);

      fetcher.complete(const PageResult.more(['a'], nextKey: 1));
      await settle();
      controller.fetchNext();
      scheduler.flush();
      expect(fetcher.keys, [0, 1]);
    });

    test('more and last carry keys, including null keys', () async {
      final nullable = ScriptedFetcher<String?, int>();
      final cursor = PagedController<String?, int>(
        firstKey: 'start',
        fetchPage: nullable.call,
        scheduler: scheduler.call,
      );
      addTearDown(cursor.dispose);

      cursor.fetchNext();
      scheduler.flush();
      nullable.complete(const PageResult.more([1], nextKey: null));
      await settle();
      expect(cursor.state.hasMore, isTrue);
      expect(cursor.state.nextKey, isNull);
      expect(cursor.state.status, PagedStatus.idle);

      cursor.fetchNext();
      scheduler.flush();
      expect(nullable.keys, ['start', null]);
      nullable.complete(const PageResult.last([2]));
      await settle();

      expect(cursor.state.hasMore, isFalse);
      expect(cursor.state.status, PagedStatus.complete);
      expect(cursor.state.items, [1, 2]);
      expect(cursor.state.keys, ['start', null]);
      expect(() => cursor.state.nextKey, throwsStateError);

      cursor.fetchNext();
      expect(scheduler.pending, 0);
    });

    test(
      'an error keeps pages, blocks fetchNext, and retry refetches',
      () async {
        controller.fetchNext();
        scheduler.flush();
        fetcher.complete(const PageResult.more(['a', 'b'], nextKey: 2));
        await settle();

        controller.fetchNext();
        scheduler.flush();
        fetcher.fail('boom');
        await settle();

        expect(controller.state.status, PagedStatus.nextError);
        expect(controller.state.error, 'boom');
        expect(controller.state.errorRevision, 1);
        expect(controller.state.items, ['a', 'b']);

        controller.fetchNext();
        expect(scheduler.pending, 0, reason: 'build must not retry on its own');

        controller.retry();
        expect(controller.state.error, isNull);
        scheduler.flush();
        expect(fetcher.keys, [0, 2, 2]);
        fetcher.complete(const PageResult.last(['c']));
        await settle();

        expect(controller.state.items, ['a', 'b', 'c']);
        expect(controller.state.status, PagedStatus.complete);
        expect(controller.state.errorRevision, 1);
      },
    );

    test('errorRevision increments once per failure', () async {
      controller.fetchNext();
      scheduler.flush();
      fetcher.fail('one');
      await settle();
      expect(controller.state.status, PagedStatus.firstError);
      final first = controller.state.errorRevision;

      controller.retry();
      scheduler.flush();
      fetcher.fail('two');
      await settle();
      expect(controller.state.errorRevision, first + 1);
    });

    test('a synchronous throw from the fetcher becomes an error', () async {
      final throwing = PagedController<int, int>(
        firstKey: 0,
        fetchPage: (_) => throw StateError('sync'),
        scheduler: scheduler.call,
      );
      addTearDown(throwing.dispose);
      throwing.fetchNext();
      scheduler.flush();
      await settle();
      expect(throwing.state.error, isA<StateError>());
    });

    test('refresh drops stale results and completes its future', () async {
      controller.fetchNext();
      scheduler.flush();
      fetcher.complete(const PageResult.more(['old'], nextKey: 1));
      await settle();
      controller.fetchNext();
      scheduler.flush();
      expect(fetcher.calls, 2);

      var refreshed = false;
      controller.refresh().then((_) => refreshed = true);
      expect(controller.state.items, isEmpty);
      expect(controller.state.status, PagedStatus.loadingFirst);

      // The in-flight page from the old generation resolves late.
      fetcher.completeAt(1, const PageResult.more(['stale'], nextKey: 2));
      await settle();
      expect(controller.state.items, isEmpty);
      expect(refreshed, isFalse);

      scheduler.flush();
      expect(fetcher.keys, [0, 1, 0]);
      fetcher.complete(const PageResult.more(['new'], nextKey: 1));
      await settle();

      expect(refreshed, isTrue);
      expect(controller.state.items, ['new']);
      expect(controller.state.keys, [0]);
    });

    test('refresh completes its future when the first page fails', () async {
      var refreshed = false;
      controller.refresh().then((_) => refreshed = true);
      scheduler.flush();
      fetcher.fail('down');
      await settle();
      expect(refreshed, isTrue);
      expect(controller.state.status, PagedStatus.firstError);
    });

    test('revisions increase monotonically across refresh', () async {
      final seen = <int>[controller.state.revision];
      controller.addListener(() => seen.add(controller.state.revision));
      controller.fetchNext();
      scheduler.flush();
      fetcher.complete(const PageResult.last(['a']));
      await settle();
      controller.refresh();
      for (var i = 1; i < seen.length; i++) {
        expect(seen[i], greaterThan(seen[i - 1]));
      }
    });

    test('disposal during a fetch drops the result', () async {
      final disposable = PagedController<int, String>(
        firstKey: 0,
        fetchPage: fetcher.call,
        scheduler: scheduler.call,
      );
      disposable.fetchNext();
      scheduler.flush();
      disposable.dispose();

      // Notifying a disposed ChangeNotifier would throw.
      fetcher.complete(const PageResult.last(['late']));
      await settle();
      expect(disposable.state.items, isEmpty);
      expect(disposable.state.isLoading, isTrue);
    });

    test('disposal completes a pending refresh', () async {
      final disposable = PagedController<int, String>(
        firstKey: 0,
        fetchPage: fetcher.call,
        scheduler: scheduler.call,
      );
      var refreshDone = false;
      disposable.refresh().then((_) => refreshDone = true);
      disposable.dispose();
      scheduler.flush();
      await settle();
      expect(refreshDone, isTrue);
      expect(fetcher.calls, 0);
    });

    test('snapshot is cached per revision', () async {
      final a = controller.snapshot;
      expect(identical(a, controller.snapshot), isTrue);
      controller.fetchNext();
      scheduler.flush();
      expect(identical(a, controller.snapshot), isFalse);
    });

    test('items list identity changes only on commit', () async {
      controller.fetchNext();
      scheduler.flush();
      final loadingItems = controller.state.items;
      fetcher.complete(const PageResult.more(['a'], nextKey: 1));
      await settle();
      final committed = controller.state.items;
      expect(identical(loadingItems, committed), isFalse);

      controller.fetchNext();
      scheduler.flush();
      expect(identical(committed, controller.state.items), isTrue);
    });
  });
}
