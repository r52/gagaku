import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/tracker_queue.dart';
import 'package:gagaku/web/model/tracking.dart';
import 'package:gagaku/web/model/tracking_types.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hive_ce/hive.dart' show Hive;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

const _trackerId = 'FictionalTracker';
const _series = TrackedSeriesRef.web(
  WebSeriesRef.extension(sourceId: 'FictionalSource', mangaId: 'series-1'),
);
const _otherSeries = TrackedSeriesRef.web(
  WebSeriesRef.extension(sourceId: 'FictionalSource', mangaId: 'series-2'),
);

SourceManga _entry(String id) => SourceManga(
  mangaId: id,
  mangaInfo: const MangaInfo(
    thumbnailUrl: '',
    synopsis: '',
    primaryTitle: 'Fictional Tracked Title',
    secondaryTitles: [],
    contentRating: ContentRating.EVERYONE,
  ),
);

TrackedChapterRead _read(num chapNum) =>
    TrackedChapterRead(chapterId: 'chapter-$chapNum', chapNum: chapNum);

/// Scripted stand-in for a tracker runtime.
class _FakeProcessor {
  final calls = <List<TrackedMangaChapterReadAction>>[];
  ChapterReadActionQueueProcessingResult Function(
    List<TrackedMangaChapterReadAction> actions,
  )
  respond = (actions) => ChapterReadActionQueueProcessingResult(
    successfulItems: actions.map((e) => e.id).toList(),
  );
  Completer<void>? gate;
  int active = 0;
  int maxActive = 0;

  Future<ChapterReadActionQueueProcessingResult> call(
    String trackerId,
    List<TrackedMangaChapterReadAction> actions,
  ) async {
    calls.add(actions);
    active++;
    maxActive = active > maxActive ? active : maxActive;
    try {
      await gate?.future;
      return respond(actions);
    } finally {
      active--;
    }
  }
}

void main() {
  late Store store;
  late Directory tempDir;
  late TrackerQueueStore queue;
  late _FakeProcessor processor;
  late DateTime now;
  late ProviderContainer container;

  setUpAll(() async {
    logger = Logger(level: Level.off);
    store = Store(getObjectBoxModel(), directory: 'memory:gagaku_tracking');
    GagakuData().store = store;
    tempDir = await Directory.systemTemp.createTemp('gagaku_tracking');
    Hive.init(tempDir.path);
    queue = TrackerQueueStore(await Hive.openBox<String>('tracking_test'));
  });

  setUp(() async {
    store.box<TrackerLink>().removeAll();
    store.box<WebSourceInfo>().removeAll();
    store.box<ExtensionConfig>().removeAll();
    store.box<WebSourceInfo>().put(
      WebSourceInfo(
        id: _trackerId,
        name: 'Fictional Tracker',
        repo: 'tracker-fixture',
        icon: '',
        capabilities: const [SourceIntents.mangaProgress],
      ),
    );
    for (final item in queue.items) {
      await queue.discard([item.id]);
    }

    processor = _FakeProcessor();
    now = DateTime.utc(2026, 1, 1, 12);
    container = ProviderContainer(
      overrides: [
        trackerQueueStoreProvider.overrideWithValue(queue),
        trackerQueueProcessorProvider.overrideWithValue(processor.call),
        trackerClockProvider.overrideWithValue(() => now),
      ],
    );
  });

  tearDown(() => container.dispose());

  tearDownAll(() async {
    store.close();
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  TrackerLinkRepository links() =>
      container.read(trackerLinkRepositoryProvider);
  TrackerReadReporter reporter() => container.read(trackerReadReporterProvider);
  TrackerQueueCoordinator coordinator() =>
      container.read(trackerQueueCoordinatorProvider.notifier);
  TrackerSyncStatus? status() =>
      container.read(trackerQueueCoordinatorProvider)[_trackerId];

  Future<void> linkAndRead(
    List<num> chapters, {
    TrackedSeriesRef? series,
  }) async {
    final target = series ?? _series;
    links().link(
      trackerId: _trackerId,
      series: target,
      trackedManga: _entry('entry-${target.key}'),
    );
    await reporter().reportRead(target, chapters.map(_read));
  }

  group('TrackerReadReporter', () {
    test('queues the highest finite chapter for each linked tracker', () async {
      store.box<WebSourceInfo>().put(
        WebSourceInfo(
          id: 'SecondTracker',
          name: 'Second Tracker',
          repo: 'tracker-fixture',
          icon: '',
          capabilities: const [SourceIntents.mangaProgress],
        ),
      );
      links().link(
        trackerId: 'SecondTracker',
        series: _series,
        trackedManga: _entry('second-entry'),
      );
      links().link(
        trackerId: 'UninstalledTracker',
        series: _series,
        trackedManga: _entry('uninstalled-entry'),
      );

      await linkAndRead([3, 7.5, double.nan, 5]);

      final items = queue.items;
      expect(items.map((e) => e.trackerId).toSet(), {
        _trackerId,
        'SecondTracker',
      });
      expect(items.map((e) => e.chapterNum).toSet(), {7.5});
      final action = items.firstWhere((e) => e.trackerId == _trackerId);
      expect(action.trackedManga.mangaId, 'entry-${_series.key}');
      expect(action.toAction().chapterSourceId, 'FictionalSource');
    });

    test(
      'does nothing for unlinked series, no numbers, or when paused',
      () async {
        await reporter().reportRead(_otherSeries, [_read(1)]);
        await linkAndRead([double.infinity]);
        expect(queue.items, isEmpty);

        container
            .read(webConfigProvider.notifier)
            .saveWith(pauseTrackerUpdates: true);
        await linkAndRead([4]);
        expect(queue.items, isEmpty);
      },
    );

    test('unlinking removes the link and its queued reads', () async {
      await linkAndRead([2]);
      await linkAndRead([1], series: _otherSeries);

      await links().unlink(links().linksFor(_series).single);

      expect(links().linksFor(_series), isEmpty);
      expect(queue.items.single.series, _otherSeries);
    });
  });

  group('TrackerQueueCoordinator', () {
    test('removes items the tracker reports successful', () async {
      await linkAndRead([4]);

      await coordinator().flush();

      expect(processor.calls.single.single.chapterNum, 4);
      expect(queue.items, isEmpty);
      expect(status()?.lastSuccess, now);
      expect(status()?.lastError, isNull);
    });

    test(
      'counts failures per item only when the batch has successes',
      () async {
        await linkAndRead([1]);
        await linkAndRead([2], series: _otherSeries);
        await linkAndRead([
          3,
        ], series: const TrackedSeriesRef.nativeMangaDex('x'));
        final byChapter = {for (final e in queue.items) e.chapterNum: e.id};
        processor.respond = (_) => ChapterReadActionQueueProcessingResult(
          successfulItems: [byChapter[1]!],
          failedItems: [byChapter[2]!],
        );

        await coordinator().flush();

        final failed = queue.items.singleWhere((e) => e.chapterNum == 2);
        expect(failed.errorCount, 1);
        expect(failed.nextAttempt, now.add(TrackerQueueStore.backoffFor(1)));
        final skipped = queue.items.singleWhere((e) => e.chapterNum == 3);
        expect(skipped.errorCount, 0);
        expect(
          skipped.nextAttempt,
          now.add(TrackerQueueCoordinator.notAttemptedDelay),
        );
        expect(status()?.lastError, isNull);
      },
    );

    test('treats an all-failed batch as a tracker-wide failure', () async {
      await linkAndRead([1]);
      processor.respond = (actions) => ChapterReadActionQueueProcessingResult(
        failedItems: actions.map((e) => e.id).toList(),
      );

      await coordinator().flush();

      final item = queue.items.single;
      expect(item.errorCount, 0);
      expect(item.state, TrackerQueueState.pending);
      final retryAfter = now.add(TrackerQueueStore.backoffFor(1));
      expect(item.nextAttempt, retryAfter);
      expect(status()?.lastError, const TrackerSyncError.rejected(1));
      expect(status()?.retryAfter, retryAfter);

      // The tracker stays backed off until a manual sync.
      now = now.add(const Duration(seconds: 30));
      await coordinator().flush();
      expect(processor.calls, hasLength(1));

      processor.respond = (actions) => ChapterReadActionQueueProcessingResult(
        successfulItems: actions.map((e) => e.id).toList(),
      );
      await coordinator().flush(force: true);
      expect(processor.calls, hasLength(2));
      expect(queue.items, isEmpty);
      expect(status()?.lastError, isNull);
      expect(status()?.retryAfter, isNull);
    });

    test('treats a thrown batch as a tracker-wide failure', () async {
      await linkAndRead([1]);
      processor.respond = (_) => throw StateError('fictional runtime failure');

      await coordinator().flush();

      expect(queue.items.single.errorCount, 0);
      expect(
        status()?.lastError,
        isA<TrackerBatchException>().having(
          (e) => e.message,
          'message',
          contains('fictional runtime failure'),
        ),
      );
    });

    test('defers actions that were not attempted without an error', () async {
      await linkAndRead([1]);
      processor.respond = (_) => const ChapterReadActionQueueProcessingResult();

      await coordinator().flush();

      final item = queue.items.single;
      expect(item.errorCount, 0);
      expect(
        item.nextAttempt,
        now.add(TrackerQueueCoordinator.notAttemptedDelay),
      );
      expect(status()?.lastError, isNull);
    });

    test('leaves items queued while the tracker is not installed', () async {
      await linkAndRead([1]);
      store.box<WebSourceInfo>().removeAll();

      await coordinator().flush();

      expect(processor.calls, isEmpty);
      expect(queue.items, hasLength(1));
    });

    test('never runs overlapping batches for one tracker', () async {
      await linkAndRead([1]);
      processor.gate = Completer<void>();

      final first = coordinator().flush();
      await Future<void>.delayed(Duration.zero);
      expect(status()?.running, isTrue);
      await linkAndRead([2], series: _otherSeries);
      final second = coordinator().flush();

      processor.gate!.complete();
      await Future.wait([first, second]);

      expect(processor.maxActive, 1);
      expect(processor.calls.expand((c) => c).length, 2);
      expect(queue.items, isEmpty);
      expect(status()?.running, isFalse);
    });
  });

  group('TrackerLinkRepository maintenance', () {
    const nativeSeries = TrackedSeriesRef.nativeMangaDex(
      '00000000-0000-4000-8000-000000000001',
    );
    const mangadexExtensionSeries = TrackedSeriesRef.web(
      WebSeriesRef.extension(
        sourceId: 'mangadex',
        mangaId: '00000000-0000-4000-8000-000000000001',
      ),
    );

    TrackerLink linkTo(
      TrackedSeriesRef series, {
      String tracker = _trackerId,
    }) => links().link(
      trackerId: tracker,
      series: series,
      trackedManga: _entry('entry-${series.key}'),
    );

    test('finds links whose tracker or reading source is gone', () {
      final healthy = linkTo(_series);
      final goneTracker = linkTo(_otherSeries, tracker: 'UninstalledTracker');
      final goneSource = linkTo(mangadexExtensionSeries);
      final native = linkTo(nativeSeries);
      final proxy = linkTo(
        const TrackedSeriesRef.web(
          WebSeriesRef.proxy(proxyId: 'gist', seriesId: 'fictional'),
        ),
      );

      final stale = links()
          .staleLinks({_trackerId, 'FictionalSource'})
          .map((e) => e.linkKey)
          .toSet();

      expect(stale, {goneTracker.linkKey, goneSource.linkKey});
      // An uninstalled `mangadex` extension never orphans native links.
      expect(stale, isNot(contains(native.linkKey)));
      expect(stale, isNot(contains(proxy.linkKey)));
      expect(stale, isNot(contains(healthy.linkKey)));
    });

    test('prunes links with their queued reads, and orphaned reads', () async {
      await linkAndRead([1]);
      await linkAndRead([2], series: _otherSeries);
      final orphan = queue.items.singleWhere((e) => e.series == _otherSeries);
      store.box<TrackerLink>().remove(
        links().linksFor(_otherSeries).single.dbid,
      );

      expect(links().orphanedQueueItems().map((e) => e.id), [orphan.id]);

      await links().pruneLinks(links().linksFor(_series));
      expect(links().linksFor(_series), isEmpty);
      expect(queue.items.map((e) => e.id), [orphan.id]);
    });

    test('migrates extension links and their queued reads only', () async {
      final original = linkTo(mangadexExtensionSeries);
      final native = linkTo(nativeSeries);
      await reporter().reportRead(mangadexExtensionSeries, [_read(3)]);
      await reporter().reportRead(nativeSeries, [_read(4)]);

      final moved = await links().migrateSource('mangadex', 'MangaDexV2');

      expect(moved, 1);
      const migratedSeries = TrackedSeriesRef.web(
        WebSeriesRef.extension(
          sourceId: 'MangaDexV2',
          mangaId: '00000000-0000-4000-8000-000000000001',
        ),
      );
      expect(links().linksFor(mangadexExtensionSeries), isEmpty);
      final migrated = links().linksFor(migratedSeries).single;
      expect(migrated.trackedManga.mangaId, original.trackedMangaId);
      // ObjectBox stores dates to the millisecond.
      expect(
        migrated.createdAt.millisecondsSinceEpoch,
        original.createdAt.millisecondsSinceEpoch,
      );
      expect(links().linksFor(nativeSeries).single.linkKey, native.linkKey);

      final item = queue.items.singleWhere((e) => e.chapterNum == 3);
      expect(item.linkKey, migrated.linkKey);
      expect(item.series, migratedSeries);
      expect(
        queue.items.singleWhere((e) => e.chapterNum == 4).linkKey,
        native.linkKey,
      );
    });
  });
}
