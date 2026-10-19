// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracker_queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrackerQueueItem _$TrackerQueueItemFromJson(Map<String, dynamic> json) =>
    _TrackerQueueItem(
      id: json['id'] as String,
      trackerId: json['trackerId'] as String,
      linkKey: json['linkKey'] as String,
      series: const TrackedSeriesRefConverter().fromJson(json['series']),
      trackedManga: SourceManga.fromJson(
        json['trackedManga'] as Map<String, dynamic>,
      ),
      chapterId: json['chapterId'] as String,
      chapterNum: json['chapterNum'] as num,
      chapterVolume: json['chapterVolume'] as num?,
      readChapter: json['readChapter'] == null
          ? null
          : Chapter.fromJson(json['readChapter'] as Map<String, dynamic>),
      creationDate: const EpochMillisTimestampSerializer().fromJson(
        (json['creationDate'] as num).toInt(),
      ),
      errorCount: (json['errorCount'] as num?)?.toInt() ?? 0,
      lastErrorDate: const NullableEpochMillisTimestampSerializer().fromJson(
        (json['lastErrorDate'] as num?)?.toInt(),
      ),
      nextAttempt: const NullableEpochMillisTimestampSerializer().fromJson(
        (json['nextAttempt'] as num?)?.toInt(),
      ),
      state:
          $enumDecodeNullable(_$TrackerQueueStateEnumMap, json['state']) ??
          TrackerQueueState.pending,
    );

Map<String, dynamic> _$TrackerQueueItemToJson(_TrackerQueueItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trackerId': instance.trackerId,
      'linkKey': instance.linkKey,
      'series': const TrackedSeriesRefConverter().toJson(instance.series),
      'trackedManga': instance.trackedManga.toJson(),
      'chapterId': instance.chapterId,
      'chapterNum': instance.chapterNum,
      'chapterVolume': instance.chapterVolume,
      'readChapter': instance.readChapter?.toJson(),
      'creationDate': const EpochMillisTimestampSerializer().toJson(
        instance.creationDate,
      ),
      'errorCount': instance.errorCount,
      'lastErrorDate': const NullableEpochMillisTimestampSerializer().toJson(
        instance.lastErrorDate,
      ),
      'nextAttempt': const NullableEpochMillisTimestampSerializer().toJson(
        instance.nextAttempt,
      ),
      'state': _$TrackerQueueStateEnumMap[instance.state]!,
    };

const _$TrackerQueueStateEnumMap = {
  TrackerQueueState.pending: 'pending',
  TrackerQueueState.dead: 'dead',
};
