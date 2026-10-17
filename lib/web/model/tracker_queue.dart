import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/util/freezed.dart';
import 'package:gagaku/web/model/tracking_types.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hive_ce/hive.dart';

part 'tracker_queue.freezed.dart';
part 'tracker_queue.g.dart';

enum TrackerQueueState { pending, dead }

/// A chapter read waiting to be reported to one tracker.
///
/// Device-local: lives in the `trackerQueueBox` Hive box, never in ObjectBox,
/// so it is excluded from backups and sync.
@freezed
abstract class TrackerQueueItem with _$TrackerQueueItem {
  const TrackerQueueItem._();

  const factory TrackerQueueItem({
    required String id,
    required String trackerId,

    /// [TrackerLink.linkKey] of the link this read was reported through.
    required String linkKey,

    /// The reading series. Identity comes from here, never from the
    /// `chapterSourceId`/`chapterMangaId` values reported to the tracker.
    @TrackedSeriesRefConverter() required TrackedSeriesRef series,

    /// Snapshot of the tracker's entry, passed to the tracker as `sourceManga`.
    required SourceManga trackedManga,
    required String chapterId,
    required num chapterNum,
    num? chapterVolume,
    Chapter? readChapter,
    @EpochMillisTimestampSerializer() required DateTime creationDate,
    @Default(0) int errorCount,
    @NullableEpochMillisTimestampSerializer() DateTime? lastErrorDate,

    /// Not retried before this time; `null` means due now.
    @NullableEpochMillisTimestampSerializer() DateTime? nextAttempt,
    @Default(TrackerQueueState.pending) TrackerQueueState state,
  }) = _TrackerQueueItem;

  factory TrackerQueueItem.fromJson(Map<String, dynamic> json) =>
      _$TrackerQueueItemFromJson(json);

  /// The Paperback action handed to `processChapterReadActionQueue`.
  TrackedMangaChapterReadAction toAction() => TrackedMangaChapterReadAction(
    id: id,
    sourceManga: trackedManga,
    readChapter: readChapter,
    chapterId: chapterId,
    chapterSourceId: series.chapterSourceId,
    chapterMangaId: series.chapterMangaId,
    chapterNum: chapterNum,
    chapterVolume: chapterVolume,
    creationDate: creationDate,
    errorCount: errorCount,
    lastErrorDate: lastErrorDate,
  );
}

/// Persistence for [TrackerQueueItem]s. Policy (when to process, how to treat
/// a tracker-wide failure) belongs to the queue coordinator.
class TrackerQueueStore {
  TrackerQueueStore(this._box);

  final Box<String> _box;

  /// Per-item failures after which an item stops being retried automatically.
  static const maxErrors = 10;

  /// Exponential backoff after the [errorCount]th failure, capped at 6 hours.
  static Duration backoffFor(int errorCount) {
    const base = Duration(minutes: 1);
    const cap = Duration(hours: 6);
    final factor = pow(2, max(0, errorCount - 1)).toInt();
    final delay = base * factor;
    return delay > cap ? cap : delay;
  }

  /// Every readable item. Entries that no longer decode are dropped.
  List<TrackerQueueItem> get items {
    final result = <TrackerQueueItem>[];
    final corrupt = <dynamic>[];
    for (final key in _box.keys) {
      final value = _box.get(key);
      try {
        result.add(
          TrackerQueueItem.fromJson(
            json.decode(value!) as Map<String, dynamic>,
          ),
        );
      } catch (error) {
        logger.w('Dropping unreadable tracker queue entry $key: $error');
        corrupt.add(key);
      }
    }
    if (corrupt.isNotEmpty) {
      unawaited(_box.deleteAll(corrupt));
    }
    return result;
  }

  List<TrackerQueueItem> itemsFor(String trackerId) =>
      items.where((e) => e.trackerId == trackerId).toList();

  /// Pending items for [trackerId] that are due at [now], oldest first.
  List<TrackerQueueItem> due(String trackerId, DateTime now, {int limit = 50}) {
    final due =
        itemsFor(trackerId)
            .where(
              (e) =>
                  e.state == TrackerQueueState.pending &&
                  (e.nextAttempt == null || !e.nextAttempt!.isAfter(now)),
            )
            .toList()
          ..sort((a, b) => a.creationDate.compareTo(b.creationDate));
    return due.take(limit).toList();
  }

  /// Adds [item], keeping one item per link: an existing item with an equal or
  /// lower chapter number is replaced, and [item] is dropped if a queued item
  /// already reports a higher chapter. Trackers only move progress forward, so
  /// this does not change what they end up recording.
  Future<void> enqueue(TrackerQueueItem item) async {
    final sameLink = items.where(
      (e) => e.trackerId == item.trackerId && e.linkKey == item.linkKey,
    );
    if (sameLink.any((e) => e.chapterNum > item.chapterNum)) {
      return;
    }

    await _box.deleteAll(sameLink.map((e) => e.id));
    await _put(item);
  }

  Future<void> markSucceeded(Iterable<String> ids) => _box.deleteAll(ids);

  /// Counts a failure for each item and schedules a backoff; items reaching
  /// [maxErrors] become [TrackerQueueState.dead].
  Future<void> markFailed(Iterable<String> ids, DateTime now) =>
      _update(ids, (item) {
        final errorCount = item.errorCount + 1;
        return item.copyWith(
          errorCount: errorCount,
          lastErrorDate: now,
          nextAttempt: now.add(backoffFor(errorCount)),
          state: errorCount >= maxErrors
              ? TrackerQueueState.dead
              : TrackerQueueState.pending,
        );
      });

  /// Postpones items without counting a failure: actions a tracker did not
  /// attempt, or a tracker-wide failure.
  Future<void> defer(Iterable<String> ids, DateTime until) =>
      _update(ids, (item) => item.copyWith(nextAttempt: until));

  Future<void> discard(Iterable<String> ids) => _box.deleteAll(ids);

  /// Returns [trackerId]'s dead items to the queue with a fresh error count.
  Future<void> retryDead(String trackerId) => _update(
    itemsFor(trackerId)
        .where((e) => e.state == TrackerQueueState.dead)
        .map((e) => e.id),
    (item) => item.copyWith(
      state: TrackerQueueState.pending,
      errorCount: 0,
      nextAttempt: null,
    ),
  );

  Future<void> removeForLink(String linkKey) =>
      _box.deleteAll(items.where((e) => e.linkKey == linkKey).map((e) => e.id));

  Future<void> removeForTracker(String trackerId) =>
      _box.deleteAll(itemsFor(trackerId).map((e) => e.id));

  /// Fires after any change to the queue.
  Stream<void> watch() => _box.watch().map((_) {});

  Future<void> _put(TrackerQueueItem item) =>
      _box.put(item.id, json.encode(item.toJson()));

  Future<void> _update(
    Iterable<String> ids,
    TrackerQueueItem Function(TrackerQueueItem item) change,
  ) async {
    final wanted = ids.toSet();
    for (final item in items.where((e) => wanted.contains(e.id))) {
      await _put(change(item));
    }
  }
}
