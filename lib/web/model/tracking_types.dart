import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:objectbox/objectbox.dart';

part 'tracking_types.freezed.dart';

/// `chapterSourceId` reported to trackers for native MangaDex client titles.
///
/// Runtime evals address extensions as `globalThis.<id>`, so every working
/// extension id is a valid JS identifier; this value never can be. A Paperback
/// MangaDex extension (likely id `mangadex`) therefore cannot collide with it.
const nativeMangaDexSourceId = 'gagaku:mangadex';

/// Durable identity of a series that tracker links attach to.
///
/// The variant, never a source id string, decides the frontend: a Paperback
/// MangaDex extension title is [WebTrackedSeries] and a native client title is
/// [NativeMangaDexTrackedSeries], even when both share a MangaDex UUID.
@freezed
sealed class TrackedSeriesRef with _$TrackedSeriesRef {
  const TrackedSeriesRef._();

  const factory TrackedSeriesRef.web(WebSeriesRef series) = WebTrackedSeries;

  const factory TrackedSeriesRef.nativeMangaDex(String mangaId) =
      NativeMangaDexTrackedSeries;

  /// Persistent key. Frontend prefixes never overlap.
  String get key => switch (this) {
    WebTrackedSeries(:final series) => 'web:${series.key}',
    NativeMangaDexTrackedSeries(:final mangaId) => 'native-mangadex:$mangaId',
  };

  /// Reported to trackers only. Never parse an identity back out of this.
  String get chapterSourceId => switch (this) {
    WebTrackedSeries(:final series) => series.sourceId,
    NativeMangaDexTrackedSeries() => nativeMangaDexSourceId,
  };

  /// Reported to trackers only. Never parse an identity back out of this.
  String get chapterMangaId => switch (this) {
    WebTrackedSeries(:final series) => series.location,
    NativeMangaDexTrackedSeries(:final mangaId) => mangaId,
  };
}

/// Versioned persisted form of [TrackedSeriesRef].
abstract final class TrackedSeriesRefCodec {
  static const version = 1;

  static const _webKind = 'web';
  static const _nativeMangaDexKind = 'native-mangadex';

  static Map<String, Object?> encode(TrackedSeriesRef ref) => switch (ref) {
    WebTrackedSeries(:final series) => {
      'version': version,
      'kind': _webKind,
      'series': series.toJson(),
    },
    NativeMangaDexTrackedSeries(:final mangaId) => {
      'version': version,
      'kind': _nativeMangaDexKind,
      'mangaId': mangaId,
    },
  };

  static TrackedSeriesRef decode(Object? value) {
    if (value is! Map) {
      throw const FormatException('Invalid persisted tracked series reference');
    }

    final data = Map<String, dynamic>.from(value);
    if (data['version'] != version) {
      throw FormatException(
        'Unsupported tracked series reference version: ${data['version']}',
      );
    }

    switch (data['kind']) {
      case _webKind:
        final series = data['series'];
        if (series is! Map) {
          throw const FormatException('Missing tracked web series reference');
        }
        return TrackedSeriesRef.web(
          WebSeriesRef.fromJson(Map<String, dynamic>.from(series)),
        );
      case _nativeMangaDexKind:
        final mangaId = data['mangaId'];
        if (mangaId is! String || mangaId.isEmpty) {
          throw const FormatException('Missing tracked MangaDex manga id');
        }
        return TrackedSeriesRef.nativeMangaDex(mangaId);
      case final kind:
        throw FormatException('Unknown tracked series kind: $kind');
    }
  }
}

class TrackedSeriesRefConverter
    implements JsonConverter<TrackedSeriesRef, Object?> {
  const TrackedSeriesRefConverter();

  @override
  TrackedSeriesRef fromJson(Object? json) => TrackedSeriesRefCodec.decode(json);

  @override
  Object? toJson(TrackedSeriesRef object) =>
      TrackedSeriesRefCodec.encode(object);
}

/// A link between a reading series and a tracker extension's entry.
///
/// Synchronized user data: covered by `GagakuDataCodec`. One link per
/// (tracker, series); a series may link to several trackers.
@Entity()
class TrackerLink {
  TrackerLink({
    this.dbid = 0,
    required this.linkKey,
    required this.trackerId,
    required this.seriesKey,
    required this.dbSeries,
    required this.trackedMangaId,
    required this.dbTrackedManga,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TrackerLink.create({
    required String trackerId,
    required TrackedSeriesRef series,
    required SourceManga trackedManga,
    DateTime? now,
  }) {
    final timestamp = (now ?? DateTime.now()).toUtc();
    return TrackerLink(
      linkKey: keyFor(trackerId, series),
      trackerId: trackerId,
      seriesKey: series.key,
      dbSeries: json.encode(TrackedSeriesRefCodec.encode(series)),
      trackedMangaId: trackedManga.mangaId,
      dbTrackedManga: json.encode(trackedManga.toJson()),
      createdAt: timestamp,
      updatedAt: timestamp,
    );
  }

  /// Decodes a backup/sync entry. Keys are recomputed from the decoded series
  /// rather than trusted from the payload.
  factory TrackerLink.fromJson(Map<String, dynamic> data) {
    final trackerId = data['trackerId'];
    final trackedManga = data['trackedManga'];
    if (trackerId is! String || trackerId.isEmpty || trackedManga is! Map) {
      throw const FormatException('Invalid tracker link');
    }

    final link = TrackerLink.create(
      trackerId: trackerId,
      series: TrackedSeriesRefCodec.decode(data['series']),
      trackedManga: SourceManga.fromJson(
        Map<String, dynamic>.from(trackedManga),
      ),
    );
    link.createdAt = DateTime.parse(data['createdAt'] as String).toUtc();
    link.updatedAt = DateTime.parse(data['updatedAt'] as String).toUtc();
    return link;
  }

  static String keyFor(String trackerId, TrackedSeriesRef series) =>
      '$trackerId|${series.key}';

  @Id()
  int dbid;

  @Unique(onConflict: ConflictStrategy.replace)
  String linkKey;

  @Index()
  String trackerId;

  /// [TrackedSeriesRef.key], indexed for per-series lookups.
  @Index()
  String seriesKey;

  /// Versioned [TrackedSeriesRef] JSON ([TrackedSeriesRefCodec]).
  String dbSeries;

  /// The tracker's own `SourceManga.mangaId`.
  String trackedMangaId;

  /// Snapshot of the tracker's `SourceManga`, passed back to the tracker.
  String dbTrackedManga;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  @Property(type: PropertyType.date)
  DateTime updatedAt;

  TrackedSeriesRef get series =>
      TrackedSeriesRefCodec.decode(json.decode(dbSeries));

  SourceManga get trackedManga =>
      SourceManga.fromJson(json.decode(dbTrackedManga) as Map<String, dynamic>);

  /// Refreshes the stored tracker entry (for example after `getMangaDetails`).
  void updateTrackedManga(SourceManga manga, {DateTime? now}) {
    if (manga.mangaId != trackedMangaId) {
      throw ArgumentError.value(
        manga.mangaId,
        'manga',
        'does not match the linked entry $trackedMangaId',
      );
    }
    dbTrackedManga = json.encode(manga.toJson());
    updatedAt = (now ?? DateTime.now()).toUtc();
  }

  Map<String, dynamic> toJson() => {
    'trackerId': trackerId,
    'series': TrackedSeriesRefCodec.encode(series),
    'trackedManga': trackedManga.toJson(),
    'createdAt': createdAt.toUtc().toIso8601String(),
    'updatedAt': updatedAt.toUtc().toIso8601String(),
  };
}
