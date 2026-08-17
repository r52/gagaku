import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/model/update_feed.dart';
import 'package:gagaku/web/model/update_feed_controller.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  setUpAll(() => logger = Logger(level: Level.off));

  group('UpdateFeedRunner', () {
    test('resolves and fetches serially, sorts, and publishes once', () async {
      final older = _link('older');
      final newest = _link('newest');
      final undated = _link('undated');
      final repository = _FakeRepository(candidates: [older, newest, undated]);
      final platform = _FakePlatform();
      final calls = <String>[];
      final pacedAt = <int>[];
      final progress = <UpdateFeedProgress>[];
      final mangas = {
        older.requireSeries.key: _manga('older', DateTime.utc(2026, 1, 1)),
        newest.requireSeries.key: _manga('newest', DateTime.utc(2026, 2, 1)),
        undated.requireSeries.key: _manga('undated', null),
      };
      final runner = UpdateFeedRunner(
        repository: repository,
        platform: platform,
        resolveLink: (link) async {
          calls.add('resolve:${link.title}');
          return link;
        },
        fetchManga: (series) async {
          calls.add('fetch:${series.key}');
          return mangas[series.key];
        },
        pace: (processedCount, cancellation) async {
          cancellation.throwIfCancelled();
          pacedAt.add(processedCount);
        },
      );

      final result = await runner.run(
        categoryIds: const ['favorites'],
        messages: _messages,
        cancellation: UpdateFeedCancellationToken(),
        onProgress: progress.add,
      );

      expect(repository.loadedCategories, const ['favorites']);
      expect(calls, [
        'resolve:older',
        'resolve:newest',
        'resolve:undated',
        'fetch:${older.requireSeries.key}',
        'fetch:${newest.requireSeries.key}',
        'fetch:${undated.requireSeries.key}',
      ]);
      expect(result.map((item) => item.link.title), [
        'newest',
        'older',
        'undated',
      ]);
      expect(repository.published, hasLength(1));
      expect(repository.published.single, result);
      expect(pacedAt, [1, 2]);
      expect(progress.last.completed, 3);
      expect(platform.acquireCount, 1);
      expect(platform.releaseCount, 1);
      expect(platform.completedCount, 1);
      expect(platform.reportedProgress, hasLength(3));
    });

    test('cancellation suppresses publication and always releases', () async {
      final link = _link('blocked');
      final repository = _FakeRepository(candidates: [link]);
      final platform = _FakePlatform();
      final fetchStarted = Completer<void>();
      final releaseFetch = Completer<void>();
      final cancellation = UpdateFeedCancellationToken();
      final runner = UpdateFeedRunner(
        repository: repository,
        platform: platform,
        resolveLink: (link) async => link,
        fetchManga: (_) async {
          fetchStarted.complete();
          await releaseFetch.future;
          return _manga('blocked', DateTime.utc(2026));
        },
        pace: (_, _) async {},
      );

      final run = runner.run(
        categoryIds: const ['favorites'],
        messages: _messages,
        cancellation: cancellation,
        onProgress: (_) {},
      );
      final expectation = expectLater(run, throwsA(isA<UpdateFeedCancelled>()));
      await fetchStarted.future;
      cancellation.cancel();
      releaseFetch.complete();
      await expectation;

      expect(repository.published, isEmpty);
      expect(platform.completedCount, 0);
      expect(platform.releaseCount, 1);
    });

    test('publication is the cancellation commit point', () async {
      final publishStarted = Completer<void>();
      final releasePublish = Completer<void>();
      final repository = _FakeRepository(
        candidates: [_link('committed')],
        beforePublish: () async {
          publishStarted.complete();
          await releasePublish.future;
        },
      );
      final platform = _FakePlatform();
      final cancellation = UpdateFeedCancellationToken();
      final runner = UpdateFeedRunner(
        repository: repository,
        platform: platform,
        resolveLink: (link) async => link,
        fetchManga: (_) async => _manga('committed', DateTime.utc(2026)),
        pace: (_, _) async {},
      );

      final run = runner.run(
        categoryIds: const ['favorites'],
        messages: _messages,
        cancellation: cancellation,
        onProgress: (_) {},
      );
      await publishStarted.future;
      cancellation.cancel();
      releasePublish.complete();
      final result = await run;

      expect(result.single.link.title, 'committed');
      expect(repository.published.single, result);
      expect(platform.completedCount, 1);
      expect(platform.releaseCount, 1);
    });

    test('fetch failure preserves the old cache and releases', () async {
      final repository = _FakeRepository(candidates: [_link('failure')]);
      final platform = _FakePlatform();
      final runner = UpdateFeedRunner(
        repository: repository,
        platform: platform,
        resolveLink: (link) async => link,
        fetchManga: (_) => Future<WebManga?>.error(StateError('failed')),
        pace: (_, _) async {},
      );

      await expectLater(
        runner.run(
          categoryIds: const ['favorites'],
          messages: _messages,
          cancellation: UpdateFeedCancellationToken(),
          onProgress: (_) {},
        ),
        throwsStateError,
      );

      expect(repository.published, isEmpty);
      expect(platform.completedCount, 0);
      expect(platform.releaseCount, 1);
    });

    test('empty candidate sets publish a valid empty feed', () async {
      final repository = _FakeRepository();
      final platform = _FakePlatform();
      final runner = UpdateFeedRunner(
        repository: repository,
        platform: platform,
        resolveLink: (link) async => link,
        fetchManga: (_) async => throw UnimplementedError(),
        pace: (_, _) async {},
      );

      final result = await runner.run(
        categoryIds: const [],
        messages: _messages,
        cancellation: UpdateFeedCancellationToken(),
        onProgress: (_) {},
      );

      expect(result, isEmpty);
      expect(repository.published.single, isEmpty);
      expect(platform.completedCount, 1);
      expect(platform.releaseCount, 1);
    });
  });

  group('WebUpdateFeedController', () {
    test('coalesces simultaneous starts into one run', () async {
      final link = _link('single-flight');
      final repository = _FakeRepository(candidates: [link]);
      final platform = _FakePlatform();
      final fetchStarted = Completer<void>();
      final releaseFetch = Completer<void>();
      var fetchCount = 0;
      final runner = UpdateFeedRunner(
        repository: repository,
        platform: platform,
        resolveLink: (link) async => link,
        fetchManga: (_) async {
          fetchCount++;
          fetchStarted.complete();
          await releaseFetch.future;
          return _manga('single-flight', DateTime.utc(2026));
        },
        pace: (_, _) async {},
      );
      final container = _container(repository, runner);
      addTearDown(container.dispose);
      await container.read(webUpdateFeedControllerProvider.future);
      final controller = container.read(
        webUpdateFeedControllerProvider.notifier,
      );

      final first = controller.start(_messages);
      final second = controller.start(_messages);
      await fetchStarted.future;
      releaseFetch.complete();
      await Future.wait([first, second]);

      expect(fetchCount, 1);
      expect(platform.acquireCount, 1);
      expect(repository.published, hasLength(1));
      final state = container
          .read(webUpdateFeedControllerProvider)
          .requireValue;
      expect(state, isA<UpdateFeedIdle>());
      expect(state.items, hasLength(1));
    });

    test('cancellation restores the previous cached feed', () async {
      final previous = UpdateFeedItem(
        link: _link('previous'),
        manga: _manga('previous', DateTime.utc(2025)),
      );
      final next = _link('next');
      final repository = _FakeRepository(
        cached: [previous],
        candidates: [next],
      );
      final platform = _FakePlatform();
      final fetchStarted = Completer<void>();
      final releaseFetch = Completer<void>();
      final runner = UpdateFeedRunner(
        repository: repository,
        platform: platform,
        resolveLink: (link) async => link,
        fetchManga: (_) async {
          fetchStarted.complete();
          await releaseFetch.future;
          return _manga('next', DateTime.utc(2026));
        },
        pace: (_, _) async {},
      );
      final container = _container(repository, runner);
      addTearDown(container.dispose);
      await container.read(webUpdateFeedControllerProvider.future);
      final controller = container.read(
        webUpdateFeedControllerProvider.notifier,
      );

      final run = controller.start(_messages);
      await fetchStarted.future;
      controller.cancel();
      expect(
        container.read(webUpdateFeedControllerProvider).requireValue,
        isA<UpdateFeedRunning>().having(
          (state) => state.cancelling,
          'cancelling',
          isTrue,
        ),
      );
      releaseFetch.complete();
      await run;

      final state = container
          .read(webUpdateFeedControllerProvider)
          .requireValue;
      expect(state, isA<UpdateFeedIdle>());
      expect(state.items, [previous]);
      expect(repository.published, isEmpty);
      expect(platform.releaseCount, 1);
    });

    test('failure is retryable and retains previous items', () async {
      final previous = UpdateFeedItem(
        link: _link('previous'),
        manga: _manga('previous', DateTime.utc(2025)),
      );
      final next = _link('next');
      final repository = _FakeRepository(
        cached: [previous],
        candidates: [next],
      );
      final platform = _FakePlatform();
      var attempts = 0;
      final runner = UpdateFeedRunner(
        repository: repository,
        platform: platform,
        resolveLink: (link) async => link,
        fetchManga: (_) async {
          attempts++;
          if (attempts == 1) {
            throw StateError('transient');
          }
          return _manga('next', DateTime.utc(2026));
        },
        pace: (_, _) async {},
      );
      final container = _container(repository, runner);
      addTearDown(container.dispose);
      await container.read(webUpdateFeedControllerProvider.future);
      final controller = container.read(
        webUpdateFeedControllerProvider.notifier,
      );

      await controller.start(_messages);
      final failed = container
          .read(webUpdateFeedControllerProvider)
          .requireValue;
      expect(failed, isA<UpdateFeedFailure>());
      expect(failed.items, [previous]);

      await controller.start(_messages);
      final recovered = container
          .read(webUpdateFeedControllerProvider)
          .requireValue;
      expect(recovered, isA<UpdateFeedIdle>());
      expect(recovered.items?.single.link.title, 'next');
      expect(attempts, 2);
    });
  });
}

const _messages = UpdateFeedMessages(
  updatingFeed: 'Updating feed',
  done: 'Done',
  updatingItem: _updatingItem,
);

String _updatingItem(String title) => 'Updating $title';

ProviderContainer _container(
  UpdateFeedRepository repository,
  UpdateFeedRunner runner,
) {
  return ProviderContainer(
    overrides: [
      updateFeedRepositoryProvider.overrideWithValue(repository),
      updateFeedRunnerProvider.overrideWithValue(runner),
      updateFeedCategoriesProvider.overrideWithValue(const ['favorites']),
    ],
  );
}

HistoryLink _link(String id) => HistoryLink.fromSeries(
  title: id,
  series: WebSeriesRef.proxy(proxyId: 'gist', seriesId: id),
);

WebManga _manga(String title, DateTime? date) => WebManga.cubari(
  title: title,
  description: '',
  artist: '',
  author: '',
  cover: '',
  cubariChapters: date == null
      ? const []
      : [
          CubariChapterEntry(
            name: '1',
            chapter: CubariChapter(lastUpdated: date, groups: const {}),
          ),
        ],
);

final class _FakeRepository implements UpdateFeedRepository {
  _FakeRepository({
    this.cached,
    List<HistoryLink>? candidates,
    this.beforePublish,
  }) : candidates = candidates ?? [];

  List<UpdateFeedItem>? cached;
  final List<HistoryLink> candidates;
  final Future<void> Function()? beforePublish;
  final List<List<UpdateFeedItem>> published = [];
  List<String>? loadedCategories;

  @override
  Future<List<HistoryLink>> loadCandidates(List<String> categoryIds) async {
    loadedCategories = List.of(categoryIds);
    return List.of(candidates);
  }

  @override
  Future<void> publish(List<UpdateFeedItem> items) async {
    await beforePublish?.call();
    final snapshot = List<UpdateFeedItem>.unmodifiable(items);
    published.add(snapshot);
    cached = snapshot;
  }

  @override
  Future<List<UpdateFeedItem>?> readCached() async =>
      cached == null ? null : List.of(cached!);
}

final class _FakePlatform implements UpdateFeedPlatform {
  int acquireCount = 0;
  int releaseCount = 0;
  int completedCount = 0;
  final List<UpdateFeedProgress> reportedProgress = [];

  @override
  Future<UpdateFeedExecutionLease> acquire(UpdateFeedMessages messages) async {
    acquireCount++;
    return _FakeLease(() => releaseCount++);
  }

  @override
  Future<bool> hasBackgroundPermissions() async => true;

  @override
  Future<void> reportCompleted(UpdateFeedMessages messages) async {
    completedCount++;
  }

  @override
  Future<void> reportProgress(
    UpdateFeedProgress progress,
    UpdateFeedMessages messages,
  ) async {
    reportedProgress.add(progress);
  }
}

final class _FakeLease implements UpdateFeedExecutionLease {
  _FakeLease(this._onRelease);

  final void Function() _onRelease;
  bool _released = false;

  @override
  Future<void> release() async {
    if (_released) {
      return;
    }
    _released = true;
    _onRelease();
  }
}
