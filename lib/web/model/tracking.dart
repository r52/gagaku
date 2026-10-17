import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart' show AppLifecycleListener;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/tracker_queue.dart';
import 'package:gagaku/web/model/tracking_types.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hive_ce/hive.dart' show Hive;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'tracking.freezed.dart';
part 'tracking.g.dart';

/// A chapter read that can be reported to trackers.
class TrackedChapterRead {
  const TrackedChapterRead({
    required this.chapterId,
    required this.chapNum,
    this.volume,
    this.chapter,
  });

  /// Pass 1 reports Paperback extension chapters only.
  static TrackedChapterRead? fromItem(WebChapterItem item) => switch (item) {
    WebChapterItemExtension(:final chapter) => TrackedChapterRead(
      chapterId: chapter.chapterId,
      chapNum: chapter.chapNum,
      volume: chapter.volume,
      chapter: chapter,
    ),
    WebChapterItemCubari() => null,
  };

  final String chapterId;
  final num chapNum;
  final num? volume;
  final Chapter? chapter;
}

/// Tracker links stored in ObjectBox.
class TrackerLinkRepository {
  TrackerLinkRepository({required this._store, required this.queue});

  final Store _store;
  final TrackerQueueStore queue;

  Box<TrackerLink> get _box => _store.box<TrackerLink>();

  List<TrackerLink> linksFor(TrackedSeriesRef series) {
    final query = _box.query(TrackerLink_.seriesKey.equals(series.key)).build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  Stream<List<TrackerLink>> watchLinksFor(TrackedSeriesRef series) => _box
      .query(TrackerLink_.seriesKey.equals(series.key))
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  /// Links [series] to [trackedManga] on [trackerId], replacing any existing
  /// link for that pair.
  TrackerLink link({
    required String trackerId,
    required TrackedSeriesRef series,
    required SourceManga trackedManga,
  }) {
    final link = TrackerLink.create(
      trackerId: trackerId,
      series: series,
      trackedManga: trackedManga,
    );
    _box.put(link);
    return link;
  }

  /// Removes [link] and any reads still queued for it.
  Future<void> unlink(TrackerLink link) async {
    _box.remove(link.dbid);
    await queue.removeForLink(link.linkKey);
  }
}

typedef TrackerQueueProcessor =
    Future<ChapterReadActionQueueProcessingResult> Function(
      String trackerId,
      List<TrackedMangaChapterReadAction> actions,
    );

@Riverpod(keepAlive: true)
TrackerQueueStore trackerQueueStore(Ref ref) =>
    TrackerQueueStore(Hive.box<String>(trackerQueueBox));

@Riverpod(keepAlive: true)
TrackerLinkRepository trackerLinkRepository(Ref ref) => TrackerLinkRepository(
  store: GagakuData().store,
  queue: ref.watch(trackerQueueStoreProvider),
);

/// Live links for one series; reflects backup restores and sync imports.
@riverpod
Stream<List<TrackerLink>> trackerLinksForSeries(
  Ref ref,
  TrackedSeriesRef series,
) => ref.watch(trackerLinkRepositoryProvider).watchLinksFor(series);

/// Sends a batch to the tracker's runtime. Overridden in tests.
@Riverpod(keepAlive: true)
TrackerQueueProcessor trackerQueueProcessor(Ref ref) =>
    (trackerId, actions) => ref
        .read(extensionSourceProvider(trackerId).notifier)
        .processChapterReadActionQueue(actions);

/// Current time for queue scheduling. Overridden in tests.
@Riverpod(keepAlive: true)
DateTime Function() trackerClock(Ref ref) => DateTime.now;

/// Installed extensions that can receive progress.
Set<String> _installedTrackerIds(Store store) => store
    .box<WebSourceInfo>()
    .getAll()
    .where((e) => e.hasCapability(SourceIntents.mangaProgress))
    .map((e) => e.id)
    .toSet();

@Riverpod(keepAlive: true)
TrackerReadReporter trackerReadReporter(Ref ref) => TrackerReadReporter(ref);

/// Turns chapter reads into queued tracker actions.
class TrackerReadReporter {
  TrackerReadReporter(this._ref);

  final Ref _ref;

  /// Enqueues the highest-numbered read in [chapters] for every installed
  /// tracker linked to [series]. Never throws: reporting must not affect the
  /// read-marker update that triggered it.
  Future<void> reportRead(
    TrackedSeriesRef series,
    Iterable<TrackedChapterRead> chapters,
  ) async {
    try {
      if (_ref.read(webConfigProvider).pauseTrackerUpdates) {
        return;
      }

      // Cheapest check first: an indexed query that is usually empty. The
      // installed-source scan and the chapter scan only run for linked series.
      final linked = _ref.read(trackerLinkRepositoryProvider).linksFor(series);
      if (linked.isEmpty) {
        return;
      }

      final installed = _installedTrackerIds(GagakuData().store);
      final links = linked
          .where((link) => installed.contains(link.trackerId))
          .toList();
      if (links.isEmpty) {
        return;
      }

      final latest = chapters
          .where((c) => c.chapNum.isFinite)
          .fold<TrackedChapterRead?>(
            null,
            (best, c) => best == null || c.chapNum > best.chapNum ? c : best,
          );
      if (latest == null) {
        return;
      }

      final queue = _ref.read(trackerQueueStoreProvider);
      final now = _ref.read(trackerClockProvider)();
      for (final link in links) {
        await queue.enqueue(
          TrackerQueueItem(
            id: const Uuid().v4(),
            trackerId: link.trackerId,
            linkKey: link.linkKey,
            series: series,
            trackedManga: link.trackedManga,
            chapterId: latest.chapterId,
            chapterNum: latest.chapNum,
            chapterVolume: latest.volume,
            readChapter: latest.chapter,
            creationDate: now,
          ),
        );
      }

      _ref.read(trackerQueueCoordinatorProvider.notifier).schedule();
    } catch (error, stackTrace) {
      logger.w(
        'Failed to queue tracker progress for ${series.key}',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

@freezed
abstract class TrackerSyncStatus with _$TrackerSyncStatus {
  const factory TrackerSyncStatus({
    @Default(0) int pending,
    @Default(0) int dead,
    @Default(false) bool running,
    DateTime? lastSuccess,

    /// The tracker's last tracker-wide failure, until a batch succeeds.
    String? lastError,

    /// Tracker-wide backoff after a batch with no successes.
    DateTime? retryAfter,
  }) = _TrackerSyncStatus;
}

/// Sends queued reads to trackers and reports per-tracker status.
@Riverpod(keepAlive: true)
class TrackerQueueCoordinator extends _$TrackerQueueCoordinator {
  static const debounce = Duration(seconds: 15);
  static const startupDelay = Duration(seconds: 30);

  /// Retry delay for actions a tracker did not attempt (for example while
  /// logged out, where AniList attempts nothing).
  static const notAttemptedDelay = Duration(minutes: 15);
  static const batchSize = 50;

  /// Bounds repeated batches in one flush when more than [batchSize] are due.
  static const _maxBatchesPerFlush = 10;

  Timer? _timer;
  AppLifecycleListener? _lifecycle;
  final _inFlight = <String, Future<void>>{};
  final _rerun = <String>{};
  final _trackerFailures = <String, int>{};
  final _retryAfter = <String, DateTime>{};
  final _lastSuccess = <String, DateTime>{};
  final _lastError = <String, String>{};

  TrackerQueueStore get _queue => ref.read(trackerQueueStoreProvider);
  DateTime _now() => ref.read(trackerClockProvider)();

  @override
  Map<String, TrackerSyncStatus> build() {
    final queue = ref.watch(trackerQueueStoreProvider);
    final subscription = queue.watch().listen((_) => _publish());
    ref.onDispose(() {
      subscription.cancel();
      _timer?.cancel();
      _lifecycle?.dispose();
    });
    return _statuses(queue.items);
  }

  /// Starts app-lifetime triggers: a delayed startup flush, and flushes on
  /// resume and pause. Not called in tests.
  void start() {
    _lifecycle ??= AppLifecycleListener(
      onResume: () => unawaited(flush()),
      onPause: () => unawaited(flush()),
    );
    schedule(startupDelay);
  }

  /// Flushes after [delay], restarting any pending debounce.
  void schedule([Duration delay = debounce]) {
    _timer?.cancel();
    _timer = Timer(delay, () => unawaited(flush()));
  }

  /// Processes due items for every tracker with pending work. With [force]
  /// (a manual sync), tracker-wide and per-item backoffs are ignored.
  Future<void> flush({bool force = false}) async {
    _timer?.cancel();
    final trackerIds = _queue.items
        .where((e) => e.state == TrackerQueueState.pending)
        .map((e) => e.trackerId)
        .toSet();
    await Future.wait(trackerIds.map((id) => _flushTracker(id, force)));
  }

  /// Runs one tracker's flush, or queues a single follow-up if one is already
  /// running, so batches for a tracker never overlap.
  Future<void> _flushTracker(String trackerId, bool force) {
    final running = _inFlight[trackerId];
    if (running != null) {
      _rerun.add(trackerId);
      return running;
    }

    final future = () async {
      try {
        do {
          _rerun.remove(trackerId);
          await _processTracker(trackerId, force);
        } while (_rerun.contains(trackerId));
      } finally {
        _inFlight.remove(trackerId);
        _publish();
      }
    }();
    _inFlight[trackerId] = future;
    _publish();
    return future;
  }

  Future<void> _processTracker(String trackerId, bool force) async {
    if (!_installedTrackerIds(GagakuData().store).contains(trackerId)) {
      return; // Items stay queued until the tracker is reinstalled or pruned.
    }

    final retryAfter = _retryAfter[trackerId];
    if (!force && retryAfter != null && _now().isBefore(retryAfter)) {
      return;
    }

    for (var round = 0; round < _maxBatchesPerFlush; round++) {
      final now = _now();
      final batch = _queue.due(
        trackerId,
        force ? DateTime.utc(9999) : now,
        limit: batchSize,
      );
      if (batch.isEmpty) {
        return;
      }

      final ids = batch.map((e) => e.id).toSet();
      ChapterReadActionQueueProcessingResult result;
      try {
        result = await ref.read(trackerQueueProcessorProvider)(
          trackerId,
          batch.map((e) => e.toAction()).toList(),
        );
      } catch (error) {
        logger.w('Tracker $trackerId queue batch failed: $error');
        await _trackerWideFailure(trackerId, ids, error.toString());
        return;
      }

      final succeeded = result.successfulItems.where(ids.contains).toSet();
      final failed = result.failedItems
          .where((id) => ids.contains(id) && !succeeded.contains(id))
          .toSet();
      final notAttempted = ids.difference(succeeded).difference(failed);

      await _queue.markSucceeded(succeeded);
      if (succeeded.isEmpty) {
        if (failed.isNotEmpty) {
          // No successes: a tracker-wide problem (MangaUpdates reports every
          // action failed while logged out). Queued reads are not penalized.
          await _trackerWideFailure(
            trackerId,
            ids,
            'Tracker reported ${failed.length} failed update(s)',
          );
        } else {
          await _queue.defer(notAttempted, now.add(notAttemptedDelay));
        }
        return;
      }

      _trackerFailures.remove(trackerId);
      _retryAfter.remove(trackerId);
      _lastError.remove(trackerId);
      _lastSuccess[trackerId] = now;
      await _queue.markFailed(failed, now);
      await _queue.defer(notAttempted, now.add(notAttemptedDelay));
    }
  }

  Future<void> _trackerWideFailure(
    String trackerId,
    Set<String> ids,
    String error,
  ) async {
    final failures = (_trackerFailures[trackerId] ?? 0) + 1;
    _trackerFailures[trackerId] = failures;
    _lastError[trackerId] = error;
    final until = _now().add(TrackerQueueStore.backoffFor(failures));
    _retryAfter[trackerId] = until;
    await _queue.defer(ids, until);
  }

  void _publish() {
    if (ref.mounted) {
      state = _statuses(_queue.items);
    }
  }

  Map<String, TrackerSyncStatus> _statuses(List<TrackerQueueItem> items) {
    final byTracker = items.groupListsBy((e) => e.trackerId);
    final ids = {
      ...byTracker.keys,
      ..._inFlight.keys,
      ..._lastSuccess.keys,
      ..._lastError.keys,
    };
    return {
      for (final id in ids)
        id: TrackerSyncStatus(
          pending:
              byTracker[id]
                  ?.where((e) => e.state == TrackerQueueState.pending)
                  .length ??
              0,
          dead:
              byTracker[id]
                  ?.where((e) => e.state == TrackerQueueState.dead)
                  .length ??
              0,
          running: _inFlight.containsKey(id),
          lastSuccess: _lastSuccess[id],
          lastError: _lastError[id],
          retryAfter: _retryAfter[id],
        ),
    };
  }
}
