import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/web/model/tracker_queue.dart';
import 'package:gagaku/web/model/tracking_types.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hive_ce/hive.dart';
import 'package:logger/logger.dart';

const _series = TrackedSeriesRef.web(
  WebSeriesRef.extension(sourceId: 'FictionalSource', mangaId: 'series-1'),
);
const _otherSeries = TrackedSeriesRef.nativeMangaDex(
  '00000000-0000-4000-8000-000000000001',
);

const _trackedManga = SourceManga(
  mangaId: 'tracker-entry-1',
  mangaInfo: MangaInfo(
    thumbnailUrl: '',
    synopsis: '',
    primaryTitle: 'Fictional Tracked Title',
    secondaryTitles: [],
    contentRating: ContentRating.EVERYONE,
  ),
);

TrackerQueueItem _item(
  String id,
  num chapterNum, {
  String trackerId = 'FictionalTracker',
  TrackedSeriesRef series = _series,
  int minute = 0,
}) => TrackerQueueItem(
  id: id,
  trackerId: trackerId,
  linkKey: '$trackerId|${series.key}',
  series: series,
  trackedManga: _trackedManga,
  chapterId: 'chapter-$chapterNum',
  chapterNum: chapterNum,
  creationDate: DateTime.utc(2026, 1, 1, 0, minute),
);

void main() {
  late Directory tempDir;
  late Box<String> box;
  late TrackerQueueStore store;
  final now = DateTime.utc(2026, 1, 1, 12);

  setUpAll(() async {
    logger = Logger(level: Level.off);
    tempDir = await Directory.systemTemp.createTemp('gagaku_tracker_queue');
    Hive.init(tempDir.path);
    box = await Hive.openBox<String>('tracker_queue_test');
    store = TrackerQueueStore(box);
  });

  setUp(() => box.clear());

  tearDownAll(() async {
    await box.close();
    await tempDir.delete(recursive: true);
  });

  test(
    'round-trips items and reports identity-derived action fields',
    () async {
      await store.enqueue(
        _item('a', 3, series: _otherSeries).copyWith(chapterVolume: 1),
      );

      final item = store.items.single;
      expect(item.series, _otherSeries);
      expect(item.creationDate, DateTime.utc(2026, 1, 1));

      final action = item.toAction();
      expect(action.chapterSourceId, nativeMangaDexSourceId);
      expect(action.chapterMangaId, '00000000-0000-4000-8000-000000000001');
      expect(action.sourceManga.mangaId, 'tracker-entry-1');
      expect(action.chapterNum, 3);
      expect(action.chapterVolume, 1);
    },
  );

  test('stores dates as absolute epoch milliseconds', () async {
    final local = DateTime(2026, 11, 1, 1, 30);
    await store.enqueue(
      _item('a', 1).copyWith(creationDate: local, nextAttempt: local),
    );

    final stored = json.decode(box.get('a')!) as Map<String, dynamic>;
    expect(stored['creationDate'], local.millisecondsSinceEpoch);
    expect(stored['nextAttempt'], local.millisecondsSinceEpoch);
    expect(stored['lastErrorDate'], isNull);

    final item = store.items.single;
    expect(item.creationDate.isAtSameMomentAs(local), isTrue);
    expect(item.creationDate.isUtc, isTrue);
  });

  test('keeps only the highest chapter per link', () async {
    await store.enqueue(_item('a', 3));
    await store.enqueue(_item('b', 5));
    expect(store.items.map((e) => e.id), ['b']);

    // A lower chapter for the same link is dropped.
    await store.enqueue(_item('c', 4));
    expect(store.items.map((e) => e.id), ['b']);

    // Other links and other trackers are independent.
    await store.enqueue(_item('d', 1, series: _otherSeries));
    await store.enqueue(_item('e', 1, trackerId: 'OtherTracker'));
    expect(store.items.map((e) => e.id).toSet(), {'b', 'd', 'e'});
  });

  test('returns due pending items oldest first, per tracker', () async {
    await store.enqueue(_item('late', 1, minute: 5));
    await store.enqueue(_item('early', 2, series: _otherSeries, minute: 1));
    await store.enqueue(_item('other', 1, trackerId: 'OtherTracker'));
    await store.defer(['late'], now.add(const Duration(minutes: 1)));

    expect(store.due('FictionalTracker', now).map((e) => e.id), ['early']);
    expect(
      store
          .due('FictionalTracker', now.add(const Duration(minutes: 1)))
          .map((e) => e.id),
      ['early', 'late'],
    );
    expect(store.due('FictionalTracker', now, limit: 0), isEmpty);
  });

  test('backs off failures and dead-letters after maxErrors', () async {
    await store.enqueue(_item('a', 1));

    await store.markFailed(['a'], now);
    var item = store.items.single;
    expect(item.errorCount, 1);
    expect(item.lastErrorDate, now);
    expect(item.nextAttempt, now.add(TrackerQueueStore.backoffFor(1)));
    expect(item.state, TrackerQueueState.pending);

    for (var i = 1; i < TrackerQueueStore.maxErrors; i++) {
      await store.markFailed(['a'], now);
    }
    item = store.items.single;
    expect(item.errorCount, TrackerQueueStore.maxErrors);
    expect(item.state, TrackerQueueState.dead);
    expect(store.due('FictionalTracker', DateTime.utc(2100)), isEmpty);

    await store.retryDead('FictionalTracker');
    item = store.items.single;
    expect(item.state, TrackerQueueState.pending);
    expect(item.errorCount, 0);
    expect(item.nextAttempt, isNull);
  });

  test('backoff doubles from one minute and caps at six hours', () {
    expect(TrackerQueueStore.backoffFor(1), const Duration(minutes: 1));
    expect(TrackerQueueStore.backoffFor(2), const Duration(minutes: 2));
    expect(TrackerQueueStore.backoffFor(4), const Duration(minutes: 8));
    expect(TrackerQueueStore.backoffFor(30), const Duration(hours: 6));
  });

  test('defer postpones without counting a failure', () async {
    await store.enqueue(_item('a', 1));
    await store.defer(['a'], now.add(const Duration(minutes: 10)));

    final item = store.items.single;
    expect(item.errorCount, 0);
    expect(item.nextAttempt, now.add(const Duration(minutes: 10)));
  });

  test('removes items by success, discard, link, and tracker', () async {
    await store.enqueue(_item('a', 1));
    await store.enqueue(_item('b', 1, series: _otherSeries));
    await store.enqueue(_item('c', 1, trackerId: 'OtherTracker'));
    await store.enqueue(
      _item('d', 1, trackerId: 'OtherTracker', series: _otherSeries),
    );

    await store.markSucceeded(['a']);
    await store.removeForLink('FictionalTracker|${_otherSeries.key}');
    expect(store.items.map((e) => e.id).toSet(), {'c', 'd'});

    await store.discard(['c']);
    expect(store.items.map((e) => e.id), ['d']);

    await store.removeForTracker('OtherTracker');
    expect(store.items, isEmpty);
  });

  test('drops entries that no longer decode', () async {
    await store.enqueue(_item('a', 1));
    await box.put('corrupt', '{"id": 42}');

    expect(store.items.map((e) => e.id), ['a']);
    await Future<void>.delayed(Duration.zero);
    expect(box.containsKey('corrupt'), isFalse);
  });
}
