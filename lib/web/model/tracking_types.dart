import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/web/model/types.dart';

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
