// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracker_queue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrackerQueueItem {

 String get id; String get trackerId;/// [TrackerLink.linkKey] of the link this read was reported through.
 String get linkKey;/// The reading series. Identity comes from here, never from the
/// `chapterSourceId`/`chapterMangaId` values reported to the tracker.
@TrackedSeriesRefConverter() TrackedSeriesRef get series;/// Snapshot of the tracker's entry, passed to the tracker as `sourceManga`.
 SourceManga get trackedManga; String get chapterId; num get chapterNum; num? get chapterVolume; Chapter? get readChapter;@EpochMillisTimestampSerializer() DateTime get creationDate; int get errorCount;@NullableEpochMillisTimestampSerializer() DateTime? get lastErrorDate;/// Not retried before this time; `null` means due now.
@NullableEpochMillisTimestampSerializer() DateTime? get nextAttempt; TrackerQueueState get state;
/// Create a copy of TrackerQueueItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackerQueueItemCopyWith<TrackerQueueItem> get copyWith => _$TrackerQueueItemCopyWithImpl<TrackerQueueItem>(this as TrackerQueueItem, _$identity);

  /// Serializes this TrackerQueueItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TrackerQueueItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackerQueueItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.trackerId, _this.trackerId) || other.trackerId == _this.trackerId)&&(identical(other.linkKey, _this.linkKey) || other.linkKey == _this.linkKey)&&(identical(other.series, _this.series) || other.series == _this.series)&&(identical(other.trackedManga, _this.trackedManga) || other.trackedManga == _this.trackedManga)&&(identical(other.chapterId, _this.chapterId) || other.chapterId == _this.chapterId)&&(identical(other.chapterNum, _this.chapterNum) || other.chapterNum == _this.chapterNum)&&(identical(other.chapterVolume, _this.chapterVolume) || other.chapterVolume == _this.chapterVolume)&&(identical(other.readChapter, _this.readChapter) || other.readChapter == _this.readChapter)&&(identical(other.creationDate, _this.creationDate) || other.creationDate == _this.creationDate)&&(identical(other.errorCount, _this.errorCount) || other.errorCount == _this.errorCount)&&(identical(other.lastErrorDate, _this.lastErrorDate) || other.lastErrorDate == _this.lastErrorDate)&&(identical(other.nextAttempt, _this.nextAttempt) || other.nextAttempt == _this.nextAttempt)&&(identical(other.state, _this.state) || other.state == _this.state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TrackerQueueItem;
  return Object.hash(runtimeType,_this.id,_this.trackerId,_this.linkKey,_this.series,_this.trackedManga,_this.chapterId,_this.chapterNum,_this.chapterVolume,_this.readChapter,_this.creationDate,_this.errorCount,_this.lastErrorDate,_this.nextAttempt,_this.state);
}

@override
String toString() {
  final _this = this as TrackerQueueItem;
  return 'TrackerQueueItem(id: ${_this.id}, trackerId: ${_this.trackerId}, linkKey: ${_this.linkKey}, series: ${_this.series}, trackedManga: ${_this.trackedManga}, chapterId: ${_this.chapterId}, chapterNum: ${_this.chapterNum}, chapterVolume: ${_this.chapterVolume}, readChapter: ${_this.readChapter}, creationDate: ${_this.creationDate}, errorCount: ${_this.errorCount}, lastErrorDate: ${_this.lastErrorDate}, nextAttempt: ${_this.nextAttempt}, state: ${_this.state})';
}


}

/// @nodoc
abstract mixin class $TrackerQueueItemCopyWith<$Res>  {
  factory $TrackerQueueItemCopyWith(TrackerQueueItem value, $Res Function(TrackerQueueItem) _then) = _$TrackerQueueItemCopyWithImpl;
@useResult
$Res call({
 String id, String trackerId, String linkKey,@TrackedSeriesRefConverter() TrackedSeriesRef series, SourceManga trackedManga, String chapterId, num chapterNum, num? chapterVolume, Chapter? readChapter,@EpochMillisTimestampSerializer() DateTime creationDate, int errorCount,@NullableEpochMillisTimestampSerializer() DateTime? lastErrorDate,@NullableEpochMillisTimestampSerializer() DateTime? nextAttempt, TrackerQueueState state
});


$TrackedSeriesRefCopyWith<$Res> get series;$SourceMangaCopyWith<$Res> get trackedManga;$ChapterCopyWith<$Res>? get readChapter;

}
/// @nodoc
class _$TrackerQueueItemCopyWithImpl<$Res>
    implements $TrackerQueueItemCopyWith<$Res> {
  _$TrackerQueueItemCopyWithImpl(this._self, this._then);

  final TrackerQueueItem _self;
  final $Res Function(TrackerQueueItem) _then;

/// Create a copy of TrackerQueueItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? trackerId = null,Object? linkKey = null,Object? series = null,Object? trackedManga = null,Object? chapterId = null,Object? chapterNum = null,Object? chapterVolume = freezed,Object? readChapter = freezed,Object? creationDate = null,Object? errorCount = null,Object? lastErrorDate = freezed,Object? nextAttempt = freezed,Object? state = null,}) {
  return _then(TrackerQueueItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,trackerId: null == trackerId ? _self.trackerId : trackerId // ignore: cast_nullable_to_non_nullable
as String,linkKey: null == linkKey ? _self.linkKey : linkKey // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as TrackedSeriesRef,trackedManga: null == trackedManga ? _self.trackedManga : trackedManga // ignore: cast_nullable_to_non_nullable
as SourceManga,chapterId: null == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String,chapterNum: null == chapterNum ? _self.chapterNum : chapterNum // ignore: cast_nullable_to_non_nullable
as num,chapterVolume: freezed == chapterVolume ? _self.chapterVolume : chapterVolume // ignore: cast_nullable_to_non_nullable
as num?,readChapter: freezed == readChapter ? _self.readChapter : readChapter // ignore: cast_nullable_to_non_nullable
as Chapter?,creationDate: null == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime,errorCount: null == errorCount ? _self.errorCount : errorCount // ignore: cast_nullable_to_non_nullable
as int,lastErrorDate: freezed == lastErrorDate ? _self.lastErrorDate : lastErrorDate // ignore: cast_nullable_to_non_nullable
as DateTime?,nextAttempt: freezed == nextAttempt ? _self.nextAttempt : nextAttempt // ignore: cast_nullable_to_non_nullable
as DateTime?,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as TrackerQueueState,
  ));
}
/// Create a copy of TrackerQueueItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrackedSeriesRefCopyWith<$Res> get series {
  
  return $TrackedSeriesRefCopyWith<$Res>(_self.series, (value) {
    return _then(_self.copyWith(series: value));
  });
}/// Create a copy of TrackerQueueItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourceMangaCopyWith<$Res> get trackedManga {
  
  return $SourceMangaCopyWith<$Res>(_self.trackedManga, (value) {
    return _then(_self.copyWith(trackedManga: value));
  });
}/// Create a copy of TrackerQueueItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChapterCopyWith<$Res>? get readChapter {
    if (_self.readChapter == null) {
    return null;
  }

  return $ChapterCopyWith<$Res>(_self.readChapter!, (value) {
    return _then(_self.copyWith(readChapter: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _TrackerQueueItem extends TrackerQueueItem {
  const _TrackerQueueItem({required this.id, required this.trackerId, required this.linkKey, @TrackedSeriesRefConverter() required this.series, required this.trackedManga, required this.chapterId, required this.chapterNum, this.chapterVolume, this.readChapter, @EpochMillisTimestampSerializer() required this.creationDate, this.errorCount = 0, @NullableEpochMillisTimestampSerializer() this.lastErrorDate, @NullableEpochMillisTimestampSerializer() this.nextAttempt, this.state = TrackerQueueState.pending}): super._();
  factory _TrackerQueueItem.fromJson(Map<String, dynamic> json) => _$TrackerQueueItemFromJson(json);

@override final  String id;
@override final  String trackerId;
/// [TrackerLink.linkKey] of the link this read was reported through.
@override final  String linkKey;
/// The reading series. Identity comes from here, never from the
/// `chapterSourceId`/`chapterMangaId` values reported to the tracker.
@override@TrackedSeriesRefConverter() final  TrackedSeriesRef series;
/// Snapshot of the tracker's entry, passed to the tracker as `sourceManga`.
@override final  SourceManga trackedManga;
@override final  String chapterId;
@override final  num chapterNum;
@override final  num? chapterVolume;
@override final  Chapter? readChapter;
@override@EpochMillisTimestampSerializer() final  DateTime creationDate;
@override@JsonKey() final  int errorCount;
@override@NullableEpochMillisTimestampSerializer() final  DateTime? lastErrorDate;
/// Not retried before this time; `null` means due now.
@override@NullableEpochMillisTimestampSerializer() final  DateTime? nextAttempt;
@override@JsonKey() final  TrackerQueueState state;

/// Create a copy of TrackerQueueItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackerQueueItemCopyWith<_TrackerQueueItem> get copyWith => __$TrackerQueueItemCopyWithImpl<_TrackerQueueItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrackerQueueItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackerQueueItem&&(identical(other.id, id) || other.id == id)&&(identical(other.trackerId, trackerId) || other.trackerId == trackerId)&&(identical(other.linkKey, linkKey) || other.linkKey == linkKey)&&(identical(other.series, series) || other.series == series)&&(identical(other.trackedManga, trackedManga) || other.trackedManga == trackedManga)&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId)&&(identical(other.chapterNum, chapterNum) || other.chapterNum == chapterNum)&&(identical(other.chapterVolume, chapterVolume) || other.chapterVolume == chapterVolume)&&(identical(other.readChapter, readChapter) || other.readChapter == readChapter)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate)&&(identical(other.errorCount, errorCount) || other.errorCount == errorCount)&&(identical(other.lastErrorDate, lastErrorDate) || other.lastErrorDate == lastErrorDate)&&(identical(other.nextAttempt, nextAttempt) || other.nextAttempt == nextAttempt)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,trackerId,linkKey,series,trackedManga,chapterId,chapterNum,chapterVolume,readChapter,creationDate,errorCount,lastErrorDate,nextAttempt,state);
}

@override
String toString() {
    return 'TrackerQueueItem(id: $id, trackerId: $trackerId, linkKey: $linkKey, series: $series, trackedManga: $trackedManga, chapterId: $chapterId, chapterNum: $chapterNum, chapterVolume: $chapterVolume, readChapter: $readChapter, creationDate: $creationDate, errorCount: $errorCount, lastErrorDate: $lastErrorDate, nextAttempt: $nextAttempt, state: $state)';
}


}

/// @nodoc
abstract mixin class _$TrackerQueueItemCopyWith<$Res> implements $TrackerQueueItemCopyWith<$Res> {
  factory _$TrackerQueueItemCopyWith(_TrackerQueueItem value, $Res Function(_TrackerQueueItem) _then) = __$TrackerQueueItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String trackerId, String linkKey,@TrackedSeriesRefConverter() TrackedSeriesRef series, SourceManga trackedManga, String chapterId, num chapterNum, num? chapterVolume, Chapter? readChapter,@EpochMillisTimestampSerializer() DateTime creationDate, int errorCount,@NullableEpochMillisTimestampSerializer() DateTime? lastErrorDate,@NullableEpochMillisTimestampSerializer() DateTime? nextAttempt, TrackerQueueState state
});


@override $TrackedSeriesRefCopyWith<$Res> get series;@override $SourceMangaCopyWith<$Res> get trackedManga;@override $ChapterCopyWith<$Res>? get readChapter;

}
/// @nodoc
class __$TrackerQueueItemCopyWithImpl<$Res>
    implements _$TrackerQueueItemCopyWith<$Res> {
  __$TrackerQueueItemCopyWithImpl(this._self, this._then);

  final _TrackerQueueItem _self;
  final $Res Function(_TrackerQueueItem) _then;

/// Create a copy of TrackerQueueItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? trackerId = null,Object? linkKey = null,Object? series = null,Object? trackedManga = null,Object? chapterId = null,Object? chapterNum = null,Object? chapterVolume = freezed,Object? readChapter = freezed,Object? creationDate = null,Object? errorCount = null,Object? lastErrorDate = freezed,Object? nextAttempt = freezed,Object? state = null,}) {
  return _then(_TrackerQueueItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,trackerId: null == trackerId ? _self.trackerId : trackerId // ignore: cast_nullable_to_non_nullable
as String,linkKey: null == linkKey ? _self.linkKey : linkKey // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as TrackedSeriesRef,trackedManga: null == trackedManga ? _self.trackedManga : trackedManga // ignore: cast_nullable_to_non_nullable
as SourceManga,chapterId: null == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String,chapterNum: null == chapterNum ? _self.chapterNum : chapterNum // ignore: cast_nullable_to_non_nullable
as num,chapterVolume: freezed == chapterVolume ? _self.chapterVolume : chapterVolume // ignore: cast_nullable_to_non_nullable
as num?,readChapter: freezed == readChapter ? _self.readChapter : readChapter // ignore: cast_nullable_to_non_nullable
as Chapter?,creationDate: null == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime,errorCount: null == errorCount ? _self.errorCount : errorCount // ignore: cast_nullable_to_non_nullable
as int,lastErrorDate: freezed == lastErrorDate ? _self.lastErrorDate : lastErrorDate // ignore: cast_nullable_to_non_nullable
as DateTime?,nextAttempt: freezed == nextAttempt ? _self.nextAttempt : nextAttempt // ignore: cast_nullable_to_non_nullable
as DateTime?,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as TrackerQueueState,
  ));
}

/// Create a copy of TrackerQueueItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrackedSeriesRefCopyWith<$Res> get series {
  
  return $TrackedSeriesRefCopyWith<$Res>(_self.series, (value) {
    return _then(_self.copyWith(series: value));
  });
}/// Create a copy of TrackerQueueItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourceMangaCopyWith<$Res> get trackedManga {
  
  return $SourceMangaCopyWith<$Res>(_self.trackedManga, (value) {
    return _then(_self.copyWith(trackedManga: value));
  });
}/// Create a copy of TrackerQueueItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChapterCopyWith<$Res>? get readChapter {
    if (_self.readChapter == null) {
    return null;
  }

  return $ChapterCopyWith<$Res>(_self.readChapter!, (value) {
    return _then(_self.copyWith(readChapter: value));
  });
}
}

// dart format on
