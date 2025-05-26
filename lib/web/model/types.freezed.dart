// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SourceHandler {

 SourceType get type; set type(SourceType value); String get sourceId; set sourceId(String value); String get location; set location(String value); String? get chapter; set chapter(String? value);@JsonKey(includeFromJson: false, includeToJson: false) WebSourceInfo? get parser;@JsonKey(includeFromJson: false, includeToJson: false) set parser(WebSourceInfo? value);
/// Create a copy of SourceHandler
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceHandlerCopyWith<SourceHandler> get copyWith => _$SourceHandlerCopyWithImpl<SourceHandler>(this as SourceHandler, _$identity);

  /// Serializes this SourceHandler to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'SourceHandler(type: $type, sourceId: $sourceId, location: $location, chapter: $chapter, parser: $parser)';
}


}

/// @nodoc
abstract mixin class $SourceHandlerCopyWith<$Res>  {
  factory $SourceHandlerCopyWith(SourceHandler value, $Res Function(SourceHandler) _then) = _$SourceHandlerCopyWithImpl;
@useResult
$Res call({
 SourceType type, String sourceId, String location, String? chapter,@JsonKey(includeFromJson: false, includeToJson: false) WebSourceInfo? parser
});


$WebSourceInfoCopyWith<$Res>? get parser;

}
/// @nodoc
class _$SourceHandlerCopyWithImpl<$Res>
    implements $SourceHandlerCopyWith<$Res> {
  _$SourceHandlerCopyWithImpl(this._self, this._then);

  final SourceHandler _self;
  final $Res Function(SourceHandler) _then;

/// Create a copy of SourceHandler
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? sourceId = null,Object? location = null,Object? chapter = freezed,Object? parser = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SourceType,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,chapter: freezed == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as String?,parser: freezed == parser ? _self.parser : parser // ignore: cast_nullable_to_non_nullable
as WebSourceInfo?,
  ));
}
/// Create a copy of SourceHandler
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WebSourceInfoCopyWith<$Res>? get parser {
    if (_self.parser == null) {
    return null;
  }

  return $WebSourceInfoCopyWith<$Res>(_self.parser!, (value) {
    return _then(_self.copyWith(parser: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _SourceHandler extends SourceHandler {
   _SourceHandler({required this.type, required this.sourceId, required this.location, this.chapter, @JsonKey(includeFromJson: false, includeToJson: false) this.parser}): super._();
  factory _SourceHandler.fromJson(Map<String, dynamic> json) => _$SourceHandlerFromJson(json);

@override  SourceType type;
@override  String sourceId;
@override  String location;
@override  String? chapter;
@override@JsonKey(includeFromJson: false, includeToJson: false)  WebSourceInfo? parser;

/// Create a copy of SourceHandler
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceHandlerCopyWith<_SourceHandler> get copyWith => __$SourceHandlerCopyWithImpl<_SourceHandler>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourceHandlerToJson(this, );
}



@override
String toString() {
  return 'SourceHandler(type: $type, sourceId: $sourceId, location: $location, chapter: $chapter, parser: $parser)';
}


}

/// @nodoc
abstract mixin class _$SourceHandlerCopyWith<$Res> implements $SourceHandlerCopyWith<$Res> {
  factory _$SourceHandlerCopyWith(_SourceHandler value, $Res Function(_SourceHandler) _then) = __$SourceHandlerCopyWithImpl;
@override @useResult
$Res call({
 SourceType type, String sourceId, String location, String? chapter,@JsonKey(includeFromJson: false, includeToJson: false) WebSourceInfo? parser
});


@override $WebSourceInfoCopyWith<$Res>? get parser;

}
/// @nodoc
class __$SourceHandlerCopyWithImpl<$Res>
    implements _$SourceHandlerCopyWith<$Res> {
  __$SourceHandlerCopyWithImpl(this._self, this._then);

  final _SourceHandler _self;
  final $Res Function(_SourceHandler) _then;

/// Create a copy of SourceHandler
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? sourceId = null,Object? location = null,Object? chapter = freezed,Object? parser = freezed,}) {
  return _then(_SourceHandler(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SourceType,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,chapter: freezed == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as String?,parser: freezed == parser ? _self.parser : parser // ignore: cast_nullable_to_non_nullable
as WebSourceInfo?,
  ));
}

/// Create a copy of SourceHandler
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WebSourceInfoCopyWith<$Res>? get parser {
    if (_self.parser == null) {
    return null;
  }

  return $WebSourceInfoCopyWith<$Res>(_self.parser!, (value) {
    return _then(_self.copyWith(parser: value));
  });
}
}


/// @nodoc
mixin _$UpdateFeedItem {

 HistoryLink get link; WebManga get manga;
/// Create a copy of UpdateFeedItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateFeedItemCopyWith<UpdateFeedItem> get copyWith => _$UpdateFeedItemCopyWithImpl<UpdateFeedItem>(this as UpdateFeedItem, _$identity);

  /// Serializes this UpdateFeedItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateFeedItem&&(identical(other.link, link) || other.link == link)&&(identical(other.manga, manga) || other.manga == manga));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,link,manga);

@override
String toString() {
  return 'UpdateFeedItem(link: $link, manga: $manga)';
}


}

/// @nodoc
abstract mixin class $UpdateFeedItemCopyWith<$Res>  {
  factory $UpdateFeedItemCopyWith(UpdateFeedItem value, $Res Function(UpdateFeedItem) _then) = _$UpdateFeedItemCopyWithImpl;
@useResult
$Res call({
 HistoryLink link, WebManga manga
});


$HistoryLinkCopyWith<$Res> get link;$WebMangaCopyWith<$Res> get manga;

}
/// @nodoc
class _$UpdateFeedItemCopyWithImpl<$Res>
    implements $UpdateFeedItemCopyWith<$Res> {
  _$UpdateFeedItemCopyWithImpl(this._self, this._then);

  final UpdateFeedItem _self;
  final $Res Function(UpdateFeedItem) _then;

/// Create a copy of UpdateFeedItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? link = null,Object? manga = null,}) {
  return _then(_self.copyWith(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as HistoryLink,manga: null == manga ? _self.manga : manga // ignore: cast_nullable_to_non_nullable
as WebManga,
  ));
}
/// Create a copy of UpdateFeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoryLinkCopyWith<$Res> get link {
  
  return $HistoryLinkCopyWith<$Res>(_self.link, (value) {
    return _then(_self.copyWith(link: value));
  });
}/// Create a copy of UpdateFeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WebMangaCopyWith<$Res> get manga {
  
  return $WebMangaCopyWith<$Res>(_self.manga, (value) {
    return _then(_self.copyWith(manga: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _UpdateFeedItem implements UpdateFeedItem {
  const _UpdateFeedItem({required this.link, required this.manga});
  factory _UpdateFeedItem.fromJson(Map<String, dynamic> json) => _$UpdateFeedItemFromJson(json);

@override final  HistoryLink link;
@override final  WebManga manga;

/// Create a copy of UpdateFeedItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateFeedItemCopyWith<_UpdateFeedItem> get copyWith => __$UpdateFeedItemCopyWithImpl<_UpdateFeedItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateFeedItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateFeedItem&&(identical(other.link, link) || other.link == link)&&(identical(other.manga, manga) || other.manga == manga));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,link,manga);

@override
String toString() {
  return 'UpdateFeedItem(link: $link, manga: $manga)';
}


}

/// @nodoc
abstract mixin class _$UpdateFeedItemCopyWith<$Res> implements $UpdateFeedItemCopyWith<$Res> {
  factory _$UpdateFeedItemCopyWith(_UpdateFeedItem value, $Res Function(_UpdateFeedItem) _then) = __$UpdateFeedItemCopyWithImpl;
@override @useResult
$Res call({
 HistoryLink link, WebManga manga
});


@override $HistoryLinkCopyWith<$Res> get link;@override $WebMangaCopyWith<$Res> get manga;

}
/// @nodoc
class __$UpdateFeedItemCopyWithImpl<$Res>
    implements _$UpdateFeedItemCopyWith<$Res> {
  __$UpdateFeedItemCopyWithImpl(this._self, this._then);

  final _UpdateFeedItem _self;
  final $Res Function(_UpdateFeedItem) _then;

/// Create a copy of UpdateFeedItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? link = null,Object? manga = null,}) {
  return _then(_UpdateFeedItem(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as HistoryLink,manga: null == manga ? _self.manga : manga // ignore: cast_nullable_to_non_nullable
as WebManga,
  ));
}

/// Create a copy of UpdateFeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoryLinkCopyWith<$Res> get link {
  
  return $HistoryLinkCopyWith<$Res>(_self.link, (value) {
    return _then(_self.copyWith(link: value));
  });
}/// Create a copy of UpdateFeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WebMangaCopyWith<$Res> get manga {
  
  return $WebMangaCopyWith<$Res>(_self.manga, (value) {
    return _then(_self.copyWith(manga: value));
  });
}
}


/// @nodoc
mixin _$HistoryLink {

 String get title; String get url; String? get cover; SourceHandler? get handle;
/// Create a copy of HistoryLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryLinkCopyWith<HistoryLink> get copyWith => _$HistoryLinkCopyWithImpl<HistoryLink>(this as HistoryLink, _$identity);

  /// Serializes this HistoryLink to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'HistoryLink(title: $title, url: $url, cover: $cover, handle: $handle)';
}


}

/// @nodoc
abstract mixin class $HistoryLinkCopyWith<$Res>  {
  factory $HistoryLinkCopyWith(HistoryLink value, $Res Function(HistoryLink) _then) = _$HistoryLinkCopyWithImpl;
@useResult
$Res call({
 String title, String url, String? cover, SourceHandler? handle
});


$SourceHandlerCopyWith<$Res>? get handle;

}
/// @nodoc
class _$HistoryLinkCopyWithImpl<$Res>
    implements $HistoryLinkCopyWith<$Res> {
  _$HistoryLinkCopyWithImpl(this._self, this._then);

  final HistoryLink _self;
  final $Res Function(HistoryLink) _then;

/// Create a copy of HistoryLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? url = null,Object? cover = freezed,Object? handle = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as SourceHandler?,
  ));
}
/// Create a copy of HistoryLink
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourceHandlerCopyWith<$Res>? get handle {
    if (_self.handle == null) {
    return null;
  }

  return $SourceHandlerCopyWith<$Res>(_self.handle!, (value) {
    return _then(_self.copyWith(handle: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _HistoryLink extends HistoryLink {
  const _HistoryLink({required this.title, required this.url, this.cover, this.handle}): super._();
  factory _HistoryLink.fromJson(Map<String, dynamic> json) => _$HistoryLinkFromJson(json);

@override final  String title;
@override final  String url;
@override final  String? cover;
@override final  SourceHandler? handle;

/// Create a copy of HistoryLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryLinkCopyWith<_HistoryLink> get copyWith => __$HistoryLinkCopyWithImpl<_HistoryLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryLinkToJson(this, );
}



@override
String toString() {
  return 'HistoryLink(title: $title, url: $url, cover: $cover, handle: $handle)';
}


}

/// @nodoc
abstract mixin class _$HistoryLinkCopyWith<$Res> implements $HistoryLinkCopyWith<$Res> {
  factory _$HistoryLinkCopyWith(_HistoryLink value, $Res Function(_HistoryLink) _then) = __$HistoryLinkCopyWithImpl;
@override @useResult
$Res call({
 String title, String url, String? cover, SourceHandler? handle
});


@override $SourceHandlerCopyWith<$Res>? get handle;

}
/// @nodoc
class __$HistoryLinkCopyWithImpl<$Res>
    implements _$HistoryLinkCopyWith<$Res> {
  __$HistoryLinkCopyWithImpl(this._self, this._then);

  final _HistoryLink _self;
  final $Res Function(_HistoryLink) _then;

/// Create a copy of HistoryLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? url = null,Object? cover = freezed,Object? handle = freezed,}) {
  return _then(_HistoryLink(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as SourceHandler?,
  ));
}

/// Create a copy of HistoryLink
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourceHandlerCopyWith<$Res>? get handle {
    if (_self.handle == null) {
    return null;
  }

  return $SourceHandlerCopyWith<$Res>(_self.handle!, (value) {
    return _then(_self.copyWith(handle: value));
  });
}
}


/// @nodoc
mixin _$WebManga {

 String get title; set title(String value); String get description; set description(String value); String get artist; set artist(String value); String get author; set author(String value); String get cover; set cover(String value); Map<String, String>? get groups; set groups(Map<String, String>? value);@WebChapterSerializer() List<ChapterEntry> get chapters;@WebChapterSerializer() set chapters(List<ChapterEntry> value); SourceManga? get data; set data(SourceManga? value);
/// Create a copy of WebManga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebMangaCopyWith<WebManga> get copyWith => _$WebMangaCopyWithImpl<WebManga>(this as WebManga, _$identity);

  /// Serializes this WebManga to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'WebManga(title: $title, description: $description, artist: $artist, author: $author, cover: $cover, groups: $groups, chapters: $chapters, data: $data)';
}


}

/// @nodoc
abstract mixin class $WebMangaCopyWith<$Res>  {
  factory $WebMangaCopyWith(WebManga value, $Res Function(WebManga) _then) = _$WebMangaCopyWithImpl;
@useResult
$Res call({
 String title, String description, String artist, String author, String cover, Map<String, String>? groups,@WebChapterSerializer() List<ChapterEntry> chapters, SourceManga? data
});


$SourceMangaCopyWith<$Res>? get data;

}
/// @nodoc
class _$WebMangaCopyWithImpl<$Res>
    implements $WebMangaCopyWith<$Res> {
  _$WebMangaCopyWithImpl(this._self, this._then);

  final WebManga _self;
  final $Res Function(WebManga) _then;

/// Create a copy of WebManga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? artist = null,Object? author = null,Object? cover = null,Object? groups = freezed,Object? chapters = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,groups: freezed == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterEntry>,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SourceManga?,
  ));
}
/// Create a copy of WebManga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourceMangaCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SourceMangaCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _WebManga extends WebManga {
   _WebManga({required this.title, required this.description, required this.artist, required this.author, required this.cover, this.groups, @WebChapterSerializer() required this.chapters, this.data}): super._();
  factory _WebManga.fromJson(Map<String, dynamic> json) => _$WebMangaFromJson(json);

@override  String title;
@override  String description;
@override  String artist;
@override  String author;
@override  String cover;
@override  Map<String, String>? groups;
@override@WebChapterSerializer()  List<ChapterEntry> chapters;
@override  SourceManga? data;

/// Create a copy of WebManga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebMangaCopyWith<_WebManga> get copyWith => __$WebMangaCopyWithImpl<_WebManga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebMangaToJson(this, );
}



@override
String toString() {
  return 'WebManga(title: $title, description: $description, artist: $artist, author: $author, cover: $cover, groups: $groups, chapters: $chapters, data: $data)';
}


}

/// @nodoc
abstract mixin class _$WebMangaCopyWith<$Res> implements $WebMangaCopyWith<$Res> {
  factory _$WebMangaCopyWith(_WebManga value, $Res Function(_WebManga) _then) = __$WebMangaCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String artist, String author, String cover, Map<String, String>? groups,@WebChapterSerializer() List<ChapterEntry> chapters, SourceManga? data
});


@override $SourceMangaCopyWith<$Res>? get data;

}
/// @nodoc
class __$WebMangaCopyWithImpl<$Res>
    implements _$WebMangaCopyWith<$Res> {
  __$WebMangaCopyWithImpl(this._self, this._then);

  final _WebManga _self;
  final $Res Function(_WebManga) _then;

/// Create a copy of WebManga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? artist = null,Object? author = null,Object? cover = null,Object? groups = freezed,Object? chapters = null,Object? data = freezed,}) {
  return _then(_WebManga(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,groups: freezed == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterEntry>,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SourceManga?,
  ));
}

/// Create a copy of WebManga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourceMangaCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SourceMangaCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$WebChapter {

 String? get title; String? get volume;@EpochTimestampSerializer() DateTime? get lastUpdated;@MappedEpochTimestampSerializer() DateTime? get releaseDate;@ChapterGroupSerializer() Map<String, dynamic> get groups;
/// Create a copy of WebChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebChapterCopyWith<WebChapter> get copyWith => _$WebChapterCopyWithImpl<WebChapter>(this as WebChapter, _$identity);

  /// Serializes this WebChapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebChapter&&(identical(other.title, title) || other.title == title)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&const DeepCollectionEquality().equals(other.groups, groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,volume,lastUpdated,releaseDate,const DeepCollectionEquality().hash(groups));

@override
String toString() {
  return 'WebChapter(title: $title, volume: $volume, lastUpdated: $lastUpdated, releaseDate: $releaseDate, groups: $groups)';
}


}

/// @nodoc
abstract mixin class $WebChapterCopyWith<$Res>  {
  factory $WebChapterCopyWith(WebChapter value, $Res Function(WebChapter) _then) = _$WebChapterCopyWithImpl;
@useResult
$Res call({
 String? title, String? volume,@EpochTimestampSerializer() DateTime? lastUpdated,@MappedEpochTimestampSerializer() DateTime? releaseDate,@ChapterGroupSerializer() Map<String, dynamic> groups
});




}
/// @nodoc
class _$WebChapterCopyWithImpl<$Res>
    implements $WebChapterCopyWith<$Res> {
  _$WebChapterCopyWithImpl(this._self, this._then);

  final WebChapter _self;
  final $Res Function(WebChapter) _then;

/// Create a copy of WebChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? volume = freezed,Object? lastUpdated = freezed,Object? releaseDate = freezed,Object? groups = null,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _WebChapter extends WebChapter {
  const _WebChapter({this.title, this.volume, @EpochTimestampSerializer() this.lastUpdated, @MappedEpochTimestampSerializer() this.releaseDate, @ChapterGroupSerializer() required this.groups}): super._();
  factory _WebChapter.fromJson(Map<String, dynamic> json) => _$WebChapterFromJson(json);

@override final  String? title;
@override final  String? volume;
@override@EpochTimestampSerializer() final  DateTime? lastUpdated;
@override@MappedEpochTimestampSerializer() final  DateTime? releaseDate;
@override@ChapterGroupSerializer() final  Map<String, dynamic> groups;

/// Create a copy of WebChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebChapterCopyWith<_WebChapter> get copyWith => __$WebChapterCopyWithImpl<_WebChapter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebChapterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebChapter&&(identical(other.title, title) || other.title == title)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&const DeepCollectionEquality().equals(other.groups, groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,volume,lastUpdated,releaseDate,const DeepCollectionEquality().hash(groups));

@override
String toString() {
  return 'WebChapter(title: $title, volume: $volume, lastUpdated: $lastUpdated, releaseDate: $releaseDate, groups: $groups)';
}


}

/// @nodoc
abstract mixin class _$WebChapterCopyWith<$Res> implements $WebChapterCopyWith<$Res> {
  factory _$WebChapterCopyWith(_WebChapter value, $Res Function(_WebChapter) _then) = __$WebChapterCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? volume,@EpochTimestampSerializer() DateTime? lastUpdated,@MappedEpochTimestampSerializer() DateTime? releaseDate,@ChapterGroupSerializer() Map<String, dynamic> groups
});




}
/// @nodoc
class __$WebChapterCopyWithImpl<$Res>
    implements _$WebChapterCopyWith<$Res> {
  __$WebChapterCopyWithImpl(this._self, this._then);

  final _WebChapter _self;
  final $Res Function(_WebChapter) _then;

/// Create a copy of WebChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? volume = freezed,Object? lastUpdated = freezed,Object? releaseDate = freezed,Object? groups = null,}) {
  return _then(_WebChapter(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$ImgurPage {

 String get description; String get src;
/// Create a copy of ImgurPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImgurPageCopyWith<ImgurPage> get copyWith => _$ImgurPageCopyWithImpl<ImgurPage>(this as ImgurPage, _$identity);

  /// Serializes this ImgurPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImgurPage&&(identical(other.description, description) || other.description == description)&&(identical(other.src, src) || other.src == src));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,src);

@override
String toString() {
  return 'ImgurPage(description: $description, src: $src)';
}


}

/// @nodoc
abstract mixin class $ImgurPageCopyWith<$Res>  {
  factory $ImgurPageCopyWith(ImgurPage value, $Res Function(ImgurPage) _then) = _$ImgurPageCopyWithImpl;
@useResult
$Res call({
 String description, String src
});




}
/// @nodoc
class _$ImgurPageCopyWithImpl<$Res>
    implements $ImgurPageCopyWith<$Res> {
  _$ImgurPageCopyWithImpl(this._self, this._then);

  final ImgurPage _self;
  final $Res Function(ImgurPage) _then;

/// Create a copy of ImgurPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,Object? src = null,}) {
  return _then(_self.copyWith(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,src: null == src ? _self.src : src // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ImgurPage implements ImgurPage {
  const _ImgurPage({required this.description, required this.src});
  factory _ImgurPage.fromJson(Map<String, dynamic> json) => _$ImgurPageFromJson(json);

@override final  String description;
@override final  String src;

/// Create a copy of ImgurPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImgurPageCopyWith<_ImgurPage> get copyWith => __$ImgurPageCopyWithImpl<_ImgurPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImgurPageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImgurPage&&(identical(other.description, description) || other.description == description)&&(identical(other.src, src) || other.src == src));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,src);

@override
String toString() {
  return 'ImgurPage(description: $description, src: $src)';
}


}

/// @nodoc
abstract mixin class _$ImgurPageCopyWith<$Res> implements $ImgurPageCopyWith<$Res> {
  factory _$ImgurPageCopyWith(_ImgurPage value, $Res Function(_ImgurPage) _then) = __$ImgurPageCopyWithImpl;
@override @useResult
$Res call({
 String description, String src
});




}
/// @nodoc
class __$ImgurPageCopyWithImpl<$Res>
    implements _$ImgurPageCopyWith<$Res> {
  __$ImgurPageCopyWithImpl(this._self, this._then);

  final _ImgurPage _self;
  final $Res Function(_ImgurPage) _then;

/// Create a copy of ImgurPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,Object? src = null,}) {
  return _then(_ImgurPage(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,src: null == src ? _self.src : src // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WebSourceInfo {

 String get id; String get name; String get repo; String? get baseUrl; SupportedVersion get version; String get icon;@SourceIntentParser() List<SourceIntents> get capabilities;
/// Create a copy of WebSourceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebSourceInfoCopyWith<WebSourceInfo> get copyWith => _$WebSourceInfoCopyWithImpl<WebSourceInfo>(this as WebSourceInfo, _$identity);

  /// Serializes this WebSourceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebSourceInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.repo, repo) || other.repo == repo)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.version, version) || other.version == version)&&(identical(other.icon, icon) || other.icon == icon)&&const DeepCollectionEquality().equals(other.capabilities, capabilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,repo,baseUrl,version,icon,const DeepCollectionEquality().hash(capabilities));

@override
String toString() {
  return 'WebSourceInfo(id: $id, name: $name, repo: $repo, baseUrl: $baseUrl, version: $version, icon: $icon, capabilities: $capabilities)';
}


}

/// @nodoc
abstract mixin class $WebSourceInfoCopyWith<$Res>  {
  factory $WebSourceInfoCopyWith(WebSourceInfo value, $Res Function(WebSourceInfo) _then) = _$WebSourceInfoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String repo, String? baseUrl, SupportedVersion version, String icon,@SourceIntentParser() List<SourceIntents> capabilities
});




}
/// @nodoc
class _$WebSourceInfoCopyWithImpl<$Res>
    implements $WebSourceInfoCopyWith<$Res> {
  _$WebSourceInfoCopyWithImpl(this._self, this._then);

  final WebSourceInfo _self;
  final $Res Function(WebSourceInfo) _then;

/// Create a copy of WebSourceInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? repo = null,Object? baseUrl = freezed,Object? version = null,Object? icon = null,Object? capabilities = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,baseUrl: freezed == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as SupportedVersion,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,capabilities: null == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as List<SourceIntents>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _WebSourceInfo extends WebSourceInfo {
  const _WebSourceInfo({required this.id, required this.name, required this.repo, this.baseUrl, this.version = SupportedVersion.v0_8, required this.icon, @SourceIntentParser() final  List<SourceIntents> capabilities = const [SourceIntents.mangaChapters]}): _capabilities = capabilities,super._();
  factory _WebSourceInfo.fromJson(Map<String, dynamic> json) => _$WebSourceInfoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String repo;
@override final  String? baseUrl;
@override@JsonKey() final  SupportedVersion version;
@override final  String icon;
 final  List<SourceIntents> _capabilities;
@override@JsonKey()@SourceIntentParser() List<SourceIntents> get capabilities {
  if (_capabilities is EqualUnmodifiableListView) return _capabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_capabilities);
}


/// Create a copy of WebSourceInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebSourceInfoCopyWith<_WebSourceInfo> get copyWith => __$WebSourceInfoCopyWithImpl<_WebSourceInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebSourceInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebSourceInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.repo, repo) || other.repo == repo)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.version, version) || other.version == version)&&(identical(other.icon, icon) || other.icon == icon)&&const DeepCollectionEquality().equals(other._capabilities, _capabilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,repo,baseUrl,version,icon,const DeepCollectionEquality().hash(_capabilities));

@override
String toString() {
  return 'WebSourceInfo(id: $id, name: $name, repo: $repo, baseUrl: $baseUrl, version: $version, icon: $icon, capabilities: $capabilities)';
}


}

/// @nodoc
abstract mixin class _$WebSourceInfoCopyWith<$Res> implements $WebSourceInfoCopyWith<$Res> {
  factory _$WebSourceInfoCopyWith(_WebSourceInfo value, $Res Function(_WebSourceInfo) _then) = __$WebSourceInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String repo, String? baseUrl, SupportedVersion version, String icon,@SourceIntentParser() List<SourceIntents> capabilities
});




}
/// @nodoc
class __$WebSourceInfoCopyWithImpl<$Res>
    implements _$WebSourceInfoCopyWith<$Res> {
  __$WebSourceInfoCopyWithImpl(this._self, this._then);

  final _WebSourceInfo _self;
  final $Res Function(_WebSourceInfo) _then;

/// Create a copy of WebSourceInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? repo = null,Object? baseUrl = freezed,Object? version = null,Object? icon = null,Object? capabilities = null,}) {
  return _then(_WebSourceInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,baseUrl: freezed == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as SupportedVersion,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,capabilities: null == capabilities ? _self._capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as List<SourceIntents>,
  ));
}


}


/// @nodoc
mixin _$Badge08 {

 String get text;@BadgeColorParser() BadgeColor get type;
/// Create a copy of Badge08
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Badge08CopyWith<Badge08> get copyWith => _$Badge08CopyWithImpl<Badge08>(this as Badge08, _$identity);

  /// Serializes this Badge08 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Badge08&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,type);

@override
String toString() {
  return 'Badge08(text: $text, type: $type)';
}


}

/// @nodoc
abstract mixin class $Badge08CopyWith<$Res>  {
  factory $Badge08CopyWith(Badge08 value, $Res Function(Badge08) _then) = _$Badge08CopyWithImpl;
@useResult
$Res call({
 String text,@BadgeColorParser() BadgeColor type
});




}
/// @nodoc
class _$Badge08CopyWithImpl<$Res>
    implements $Badge08CopyWith<$Res> {
  _$Badge08CopyWithImpl(this._self, this._then);

  final Badge08 _self;
  final $Res Function(Badge08) _then;

/// Create a copy of Badge08
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? type = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BadgeColor,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Badge08 implements Badge08 {
  const _Badge08({required this.text, @BadgeColorParser() required this.type});
  factory _Badge08.fromJson(Map<String, dynamic> json) => _$Badge08FromJson(json);

@override final  String text;
@override@BadgeColorParser() final  BadgeColor type;

/// Create a copy of Badge08
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Badge08CopyWith<_Badge08> get copyWith => __$Badge08CopyWithImpl<_Badge08>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Badge08ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Badge08&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,type);

@override
String toString() {
  return 'Badge08(text: $text, type: $type)';
}


}

/// @nodoc
abstract mixin class _$Badge08CopyWith<$Res> implements $Badge08CopyWith<$Res> {
  factory _$Badge08CopyWith(_Badge08 value, $Res Function(_Badge08) _then) = __$Badge08CopyWithImpl;
@override @useResult
$Res call({
 String text,@BadgeColorParser() BadgeColor type
});




}
/// @nodoc
class __$Badge08CopyWithImpl<$Res>
    implements _$Badge08CopyWith<$Res> {
  __$Badge08CopyWithImpl(this._self, this._then);

  final _Badge08 _self;
  final $Res Function(_Badge08) _then;

/// Create a copy of Badge08
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? type = null,}) {
  return _then(_Badge08(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BadgeColor,
  ));
}


}


/// @nodoc
mixin _$SourceBadge {

 String get label; String get textColor; String get backgroundColor;
/// Create a copy of SourceBadge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceBadgeCopyWith<SourceBadge> get copyWith => _$SourceBadgeCopyWithImpl<SourceBadge>(this as SourceBadge, _$identity);

  /// Serializes this SourceBadge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceBadge&&(identical(other.label, label) || other.label == label)&&(identical(other.textColor, textColor) || other.textColor == textColor)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,textColor,backgroundColor);

@override
String toString() {
  return 'SourceBadge(label: $label, textColor: $textColor, backgroundColor: $backgroundColor)';
}


}

/// @nodoc
abstract mixin class $SourceBadgeCopyWith<$Res>  {
  factory $SourceBadgeCopyWith(SourceBadge value, $Res Function(SourceBadge) _then) = _$SourceBadgeCopyWithImpl;
@useResult
$Res call({
 String label, String textColor, String backgroundColor
});




}
/// @nodoc
class _$SourceBadgeCopyWithImpl<$Res>
    implements $SourceBadgeCopyWith<$Res> {
  _$SourceBadgeCopyWithImpl(this._self, this._then);

  final SourceBadge _self;
  final $Res Function(SourceBadge) _then;

/// Create a copy of SourceBadge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? textColor = null,Object? backgroundColor = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,textColor: null == textColor ? _self.textColor : textColor // ignore: cast_nullable_to_non_nullable
as String,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SourceBadge implements SourceBadge {
  const _SourceBadge({required this.label, required this.textColor, required this.backgroundColor});
  factory _SourceBadge.fromJson(Map<String, dynamic> json) => _$SourceBadgeFromJson(json);

@override final  String label;
@override final  String textColor;
@override final  String backgroundColor;

/// Create a copy of SourceBadge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceBadgeCopyWith<_SourceBadge> get copyWith => __$SourceBadgeCopyWithImpl<_SourceBadge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourceBadgeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceBadge&&(identical(other.label, label) || other.label == label)&&(identical(other.textColor, textColor) || other.textColor == textColor)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,textColor,backgroundColor);

@override
String toString() {
  return 'SourceBadge(label: $label, textColor: $textColor, backgroundColor: $backgroundColor)';
}


}

/// @nodoc
abstract mixin class _$SourceBadgeCopyWith<$Res> implements $SourceBadgeCopyWith<$Res> {
  factory _$SourceBadgeCopyWith(_SourceBadge value, $Res Function(_SourceBadge) _then) = __$SourceBadgeCopyWithImpl;
@override @useResult
$Res call({
 String label, String textColor, String backgroundColor
});




}
/// @nodoc
class __$SourceBadgeCopyWithImpl<$Res>
    implements _$SourceBadgeCopyWith<$Res> {
  __$SourceBadgeCopyWithImpl(this._self, this._then);

  final _SourceBadge _self;
  final $Res Function(_SourceBadge) _then;

/// Create a copy of SourceBadge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? textColor = null,Object? backgroundColor = null,}) {
  return _then(_SourceBadge(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,textColor: null == textColor ? _self.textColor : textColor // ignore: cast_nullable_to_non_nullable
as String,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SourceDeveloper {

 String get name; String? get website; String? get github;
/// Create a copy of SourceDeveloper
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceDeveloperCopyWith<SourceDeveloper> get copyWith => _$SourceDeveloperCopyWithImpl<SourceDeveloper>(this as SourceDeveloper, _$identity);

  /// Serializes this SourceDeveloper to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceDeveloper&&(identical(other.name, name) || other.name == name)&&(identical(other.website, website) || other.website == website)&&(identical(other.github, github) || other.github == github));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,website,github);

@override
String toString() {
  return 'SourceDeveloper(name: $name, website: $website, github: $github)';
}


}

/// @nodoc
abstract mixin class $SourceDeveloperCopyWith<$Res>  {
  factory $SourceDeveloperCopyWith(SourceDeveloper value, $Res Function(SourceDeveloper) _then) = _$SourceDeveloperCopyWithImpl;
@useResult
$Res call({
 String name, String? website, String? github
});




}
/// @nodoc
class _$SourceDeveloperCopyWithImpl<$Res>
    implements $SourceDeveloperCopyWith<$Res> {
  _$SourceDeveloperCopyWithImpl(this._self, this._then);

  final SourceDeveloper _self;
  final $Res Function(SourceDeveloper) _then;

/// Create a copy of SourceDeveloper
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? website = freezed,Object? github = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,github: freezed == github ? _self.github : github // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SourceDeveloper implements SourceDeveloper {
  const _SourceDeveloper({required this.name, this.website, this.github});
  factory _SourceDeveloper.fromJson(Map<String, dynamic> json) => _$SourceDeveloperFromJson(json);

@override final  String name;
@override final  String? website;
@override final  String? github;

/// Create a copy of SourceDeveloper
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceDeveloperCopyWith<_SourceDeveloper> get copyWith => __$SourceDeveloperCopyWithImpl<_SourceDeveloper>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourceDeveloperToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceDeveloper&&(identical(other.name, name) || other.name == name)&&(identical(other.website, website) || other.website == website)&&(identical(other.github, github) || other.github == github));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,website,github);

@override
String toString() {
  return 'SourceDeveloper(name: $name, website: $website, github: $github)';
}


}

/// @nodoc
abstract mixin class _$SourceDeveloperCopyWith<$Res> implements $SourceDeveloperCopyWith<$Res> {
  factory _$SourceDeveloperCopyWith(_SourceDeveloper value, $Res Function(_SourceDeveloper) _then) = __$SourceDeveloperCopyWithImpl;
@override @useResult
$Res call({
 String name, String? website, String? github
});




}
/// @nodoc
class __$SourceDeveloperCopyWithImpl<$Res>
    implements _$SourceDeveloperCopyWith<$Res> {
  __$SourceDeveloperCopyWithImpl(this._self, this._then);

  final _SourceDeveloper _self;
  final $Res Function(_SourceDeveloper) _then;

/// Create a copy of SourceDeveloper
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? website = freezed,Object? github = freezed,}) {
  return _then(_SourceDeveloper(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,github: freezed == github ? _self.github : github // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

SourceVersion _$SourceVersionFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'zero_eight':
          return SourceVersion08.fromJson(
            json
          );
                case 'zero_nine':
          return SourceVersion09.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'SourceVersion',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$SourceVersion {

 String get id; String get name;@ContentRatingParser() ContentRating get contentRating; String get version; String get icon;
/// Create a copy of SourceVersion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceVersionCopyWith<SourceVersion> get copyWith => _$SourceVersionCopyWithImpl<SourceVersion>(this as SourceVersion, _$identity);

  /// Serializes this SourceVersion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceVersion&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&(identical(other.version, version) || other.version == version)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,contentRating,version,icon);

@override
String toString() {
  return 'SourceVersion(id: $id, name: $name, contentRating: $contentRating, version: $version, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $SourceVersionCopyWith<$Res>  {
  factory $SourceVersionCopyWith(SourceVersion value, $Res Function(SourceVersion) _then) = _$SourceVersionCopyWithImpl;
@useResult
$Res call({
 String id, String name, ContentRating contentRating, String version, String icon
});




}
/// @nodoc
class _$SourceVersionCopyWithImpl<$Res>
    implements $SourceVersionCopyWith<$Res> {
  _$SourceVersionCopyWithImpl(this._self, this._then);

  final SourceVersion _self;
  final $Res Function(SourceVersion) _then;

/// Create a copy of SourceVersion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? contentRating = null,Object? version = null,Object? icon = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class SourceVersion08 extends SourceVersion {
  const SourceVersion08({required this.id, required this.name, required this.author, required this.desc, this.website, required this.contentRating, required this.version, required this.icon, final  List<Badge08>? tags, required this.websiteBaseURL, this.intents, final  String? $type}): _tags = tags,$type = $type ?? 'zero_eight',super._();
  factory SourceVersion08.fromJson(Map<String, dynamic> json) => _$SourceVersion08FromJson(json);

@override final  String id;
@override final  String name;
 final  String author;
 final  String desc;
 final  String? website;
@override final  ContentRating contentRating;
@override final  String version;
@override final  String icon;
 final  List<Badge08>? _tags;
 List<Badge08>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  String websiteBaseURL;
 final  int? intents;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SourceVersion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceVersion08CopyWith<SourceVersion08> get copyWith => _$SourceVersion08CopyWithImpl<SourceVersion08>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourceVersion08ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceVersion08&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.author, author) || other.author == author)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.website, website) || other.website == website)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&(identical(other.version, version) || other.version == version)&&(identical(other.icon, icon) || other.icon == icon)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.websiteBaseURL, websiteBaseURL) || other.websiteBaseURL == websiteBaseURL)&&(identical(other.intents, intents) || other.intents == intents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,author,desc,website,contentRating,version,icon,const DeepCollectionEquality().hash(_tags),websiteBaseURL,intents);

@override
String toString() {
  return 'SourceVersion.zero_eight(id: $id, name: $name, author: $author, desc: $desc, website: $website, contentRating: $contentRating, version: $version, icon: $icon, tags: $tags, websiteBaseURL: $websiteBaseURL, intents: $intents)';
}


}

/// @nodoc
abstract mixin class $SourceVersion08CopyWith<$Res> implements $SourceVersionCopyWith<$Res> {
  factory $SourceVersion08CopyWith(SourceVersion08 value, $Res Function(SourceVersion08) _then) = _$SourceVersion08CopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String author, String desc, String? website, ContentRating contentRating, String version, String icon, List<Badge08>? tags, String websiteBaseURL, int? intents
});




}
/// @nodoc
class _$SourceVersion08CopyWithImpl<$Res>
    implements $SourceVersion08CopyWith<$Res> {
  _$SourceVersion08CopyWithImpl(this._self, this._then);

  final SourceVersion08 _self;
  final $Res Function(SourceVersion08) _then;

/// Create a copy of SourceVersion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? author = null,Object? desc = null,Object? website = freezed,Object? contentRating = null,Object? version = null,Object? icon = null,Object? tags = freezed,Object? websiteBaseURL = null,Object? intents = freezed,}) {
  return _then(SourceVersion08(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<Badge08>?,websiteBaseURL: null == websiteBaseURL ? _self.websiteBaseURL : websiteBaseURL // ignore: cast_nullable_to_non_nullable
as String,intents: freezed == intents ? _self.intents : intents // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SourceVersion09 extends SourceVersion {
  const SourceVersion09({required this.id, required this.name, required this.description, required this.version, required this.icon, this.language, @ContentRatingParser() required this.contentRating, required final  List<SourceBadge> badges, required final  List<SourceDeveloper> developers, @SourceIntentOrListParser() required final  List<SourceIntents> capabilities, final  String? $type}): _badges = badges,_developers = developers,_capabilities = capabilities,$type = $type ?? 'zero_nine',super._();
  factory SourceVersion09.fromJson(Map<String, dynamic> json) => _$SourceVersion09FromJson(json);

@override final  String id;
@override final  String name;
 final  String description;
@override final  String version;
@override final  String icon;
 final  String? language;
@override@ContentRatingParser() final  ContentRating contentRating;
 final  List<SourceBadge> _badges;
 List<SourceBadge> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}

 final  List<SourceDeveloper> _developers;
 List<SourceDeveloper> get developers {
  if (_developers is EqualUnmodifiableListView) return _developers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_developers);
}

 final  List<SourceIntents> _capabilities;
@SourceIntentOrListParser() List<SourceIntents> get capabilities {
  if (_capabilities is EqualUnmodifiableListView) return _capabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_capabilities);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SourceVersion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceVersion09CopyWith<SourceVersion09> get copyWith => _$SourceVersion09CopyWithImpl<SourceVersion09>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourceVersion09ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceVersion09&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.version, version) || other.version == version)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.language, language) || other.language == language)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&const DeepCollectionEquality().equals(other._badges, _badges)&&const DeepCollectionEquality().equals(other._developers, _developers)&&const DeepCollectionEquality().equals(other._capabilities, _capabilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,version,icon,language,contentRating,const DeepCollectionEquality().hash(_badges),const DeepCollectionEquality().hash(_developers),const DeepCollectionEquality().hash(_capabilities));

@override
String toString() {
  return 'SourceVersion.zero_nine(id: $id, name: $name, description: $description, version: $version, icon: $icon, language: $language, contentRating: $contentRating, badges: $badges, developers: $developers, capabilities: $capabilities)';
}


}

/// @nodoc
abstract mixin class $SourceVersion09CopyWith<$Res> implements $SourceVersionCopyWith<$Res> {
  factory $SourceVersion09CopyWith(SourceVersion09 value, $Res Function(SourceVersion09) _then) = _$SourceVersion09CopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String version, String icon, String? language,@ContentRatingParser() ContentRating contentRating, List<SourceBadge> badges, List<SourceDeveloper> developers,@SourceIntentOrListParser() List<SourceIntents> capabilities
});




}
/// @nodoc
class _$SourceVersion09CopyWithImpl<$Res>
    implements $SourceVersion09CopyWith<$Res> {
  _$SourceVersion09CopyWithImpl(this._self, this._then);

  final SourceVersion09 _self;
  final $Res Function(SourceVersion09) _then;

/// Create a copy of SourceVersion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? version = null,Object? icon = null,Object? language = freezed,Object? contentRating = null,Object? badges = null,Object? developers = null,Object? capabilities = null,}) {
  return _then(SourceVersion09(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<SourceBadge>,developers: null == developers ? _self._developers : developers // ignore: cast_nullable_to_non_nullable
as List<SourceDeveloper>,capabilities: null == capabilities ? _self._capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as List<SourceIntents>,
  ));
}


}


/// @nodoc
mixin _$BuiltWith {

 String get toolchain; String get types;
/// Create a copy of BuiltWith
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuiltWithCopyWith<BuiltWith> get copyWith => _$BuiltWithCopyWithImpl<BuiltWith>(this as BuiltWith, _$identity);

  /// Serializes this BuiltWith to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuiltWith&&(identical(other.toolchain, toolchain) || other.toolchain == toolchain)&&(identical(other.types, types) || other.types == types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,toolchain,types);

@override
String toString() {
  return 'BuiltWith(toolchain: $toolchain, types: $types)';
}


}

/// @nodoc
abstract mixin class $BuiltWithCopyWith<$Res>  {
  factory $BuiltWithCopyWith(BuiltWith value, $Res Function(BuiltWith) _then) = _$BuiltWithCopyWithImpl;
@useResult
$Res call({
 String toolchain, String types
});




}
/// @nodoc
class _$BuiltWithCopyWithImpl<$Res>
    implements $BuiltWithCopyWith<$Res> {
  _$BuiltWithCopyWithImpl(this._self, this._then);

  final BuiltWith _self;
  final $Res Function(BuiltWith) _then;

/// Create a copy of BuiltWith
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? toolchain = null,Object? types = null,}) {
  return _then(_self.copyWith(
toolchain: null == toolchain ? _self.toolchain : toolchain // ignore: cast_nullable_to_non_nullable
as String,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BuiltWith implements BuiltWith {
  const _BuiltWith({required this.toolchain, required this.types});
  factory _BuiltWith.fromJson(Map<String, dynamic> json) => _$BuiltWithFromJson(json);

@override final  String toolchain;
@override final  String types;

/// Create a copy of BuiltWith
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuiltWithCopyWith<_BuiltWith> get copyWith => __$BuiltWithCopyWithImpl<_BuiltWith>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BuiltWithToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuiltWith&&(identical(other.toolchain, toolchain) || other.toolchain == toolchain)&&(identical(other.types, types) || other.types == types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,toolchain,types);

@override
String toString() {
  return 'BuiltWith(toolchain: $toolchain, types: $types)';
}


}

/// @nodoc
abstract mixin class _$BuiltWithCopyWith<$Res> implements $BuiltWithCopyWith<$Res> {
  factory _$BuiltWithCopyWith(_BuiltWith value, $Res Function(_BuiltWith) _then) = __$BuiltWithCopyWithImpl;
@override @useResult
$Res call({
 String toolchain, String types
});




}
/// @nodoc
class __$BuiltWithCopyWithImpl<$Res>
    implements _$BuiltWithCopyWith<$Res> {
  __$BuiltWithCopyWithImpl(this._self, this._then);

  final _BuiltWith _self;
  final $Res Function(_BuiltWith) _then;

/// Create a copy of BuiltWith
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? toolchain = null,Object? types = null,}) {
  return _then(_BuiltWith(
toolchain: null == toolchain ? _self.toolchain : toolchain // ignore: cast_nullable_to_non_nullable
as String,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Versioning {

 String get buildTime; List<dynamic> get sources; BuiltWith get builtWith;
/// Create a copy of Versioning
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VersioningCopyWith<Versioning> get copyWith => _$VersioningCopyWithImpl<Versioning>(this as Versioning, _$identity);

  /// Serializes this Versioning to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Versioning&&(identical(other.buildTime, buildTime) || other.buildTime == buildTime)&&const DeepCollectionEquality().equals(other.sources, sources)&&(identical(other.builtWith, builtWith) || other.builtWith == builtWith));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,buildTime,const DeepCollectionEquality().hash(sources),builtWith);

@override
String toString() {
  return 'Versioning(buildTime: $buildTime, sources: $sources, builtWith: $builtWith)';
}


}

/// @nodoc
abstract mixin class $VersioningCopyWith<$Res>  {
  factory $VersioningCopyWith(Versioning value, $Res Function(Versioning) _then) = _$VersioningCopyWithImpl;
@useResult
$Res call({
 String buildTime, List<dynamic> sources, BuiltWith builtWith
});


$BuiltWithCopyWith<$Res> get builtWith;

}
/// @nodoc
class _$VersioningCopyWithImpl<$Res>
    implements $VersioningCopyWith<$Res> {
  _$VersioningCopyWithImpl(this._self, this._then);

  final Versioning _self;
  final $Res Function(Versioning) _then;

/// Create a copy of Versioning
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buildTime = null,Object? sources = null,Object? builtWith = null,}) {
  return _then(_self.copyWith(
buildTime: null == buildTime ? _self.buildTime : buildTime // ignore: cast_nullable_to_non_nullable
as String,sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as List<dynamic>,builtWith: null == builtWith ? _self.builtWith : builtWith // ignore: cast_nullable_to_non_nullable
as BuiltWith,
  ));
}
/// Create a copy of Versioning
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BuiltWithCopyWith<$Res> get builtWith {
  
  return $BuiltWithCopyWith<$Res>(_self.builtWith, (value) {
    return _then(_self.copyWith(builtWith: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _Versioning implements Versioning {
  const _Versioning({required this.buildTime, required final  List<dynamic> sources, required this.builtWith}): _sources = sources;
  factory _Versioning.fromJson(Map<String, dynamic> json) => _$VersioningFromJson(json);

@override final  String buildTime;
 final  List<dynamic> _sources;
@override List<dynamic> get sources {
  if (_sources is EqualUnmodifiableListView) return _sources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sources);
}

@override final  BuiltWith builtWith;

/// Create a copy of Versioning
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VersioningCopyWith<_Versioning> get copyWith => __$VersioningCopyWithImpl<_Versioning>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VersioningToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Versioning&&(identical(other.buildTime, buildTime) || other.buildTime == buildTime)&&const DeepCollectionEquality().equals(other._sources, _sources)&&(identical(other.builtWith, builtWith) || other.builtWith == builtWith));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,buildTime,const DeepCollectionEquality().hash(_sources),builtWith);

@override
String toString() {
  return 'Versioning(buildTime: $buildTime, sources: $sources, builtWith: $builtWith)';
}


}

/// @nodoc
abstract mixin class _$VersioningCopyWith<$Res> implements $VersioningCopyWith<$Res> {
  factory _$VersioningCopyWith(_Versioning value, $Res Function(_Versioning) _then) = __$VersioningCopyWithImpl;
@override @useResult
$Res call({
 String buildTime, List<dynamic> sources, BuiltWith builtWith
});


@override $BuiltWithCopyWith<$Res> get builtWith;

}
/// @nodoc
class __$VersioningCopyWithImpl<$Res>
    implements _$VersioningCopyWith<$Res> {
  __$VersioningCopyWithImpl(this._self, this._then);

  final _Versioning _self;
  final $Res Function(_Versioning) _then;

/// Create a copy of Versioning
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? buildTime = null,Object? sources = null,Object? builtWith = null,}) {
  return _then(_Versioning(
buildTime: null == buildTime ? _self.buildTime : buildTime // ignore: cast_nullable_to_non_nullable
as String,sources: null == sources ? _self._sources : sources // ignore: cast_nullable_to_non_nullable
as List<dynamic>,builtWith: null == builtWith ? _self.builtWith : builtWith // ignore: cast_nullable_to_non_nullable
as BuiltWith,
  ));
}

/// Create a copy of Versioning
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BuiltWithCopyWith<$Res> get builtWith {
  
  return $BuiltWithCopyWith<$Res>(_self.builtWith, (value) {
    return _then(_self.copyWith(builtWith: value));
  });
}
}


/// @nodoc
mixin _$RepoInfo {

 String get name; String get url;
/// Create a copy of RepoInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepoInfoCopyWith<RepoInfo> get copyWith => _$RepoInfoCopyWithImpl<RepoInfo>(this as RepoInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepoInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url);

@override
String toString() {
  return 'RepoInfo(name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class $RepoInfoCopyWith<$Res>  {
  factory $RepoInfoCopyWith(RepoInfo value, $Res Function(RepoInfo) _then) = _$RepoInfoCopyWithImpl;
@useResult
$Res call({
 String name, String url
});




}
/// @nodoc
class _$RepoInfoCopyWithImpl<$Res>
    implements $RepoInfoCopyWith<$Res> {
  _$RepoInfoCopyWithImpl(this._self, this._then);

  final RepoInfo _self;
  final $Res Function(RepoInfo) _then;

/// Create a copy of RepoInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? url = null,}) {
  return _then(RepoInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
mixin _$RepoData {

 String get name; String get url; SupportedVersion get version;
/// Create a copy of RepoData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepoDataCopyWith<RepoData> get copyWith => _$RepoDataCopyWithImpl<RepoData>(this as RepoData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepoData&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url,version);

@override
String toString() {
  return 'RepoData(name: $name, url: $url, version: $version)';
}


}

/// @nodoc
abstract mixin class $RepoDataCopyWith<$Res> implements $RepoInfoCopyWith<$Res> {
  factory $RepoDataCopyWith(RepoData value, $Res Function(RepoData) _then) = _$RepoDataCopyWithImpl;
@useResult
$Res call({
 String name, String url, SupportedVersion version
});




}
/// @nodoc
class _$RepoDataCopyWithImpl<$Res>
    implements $RepoDataCopyWith<$Res> {
  _$RepoDataCopyWithImpl(this._self, this._then);

  final RepoData _self;
  final $Res Function(RepoData) _then;

/// Create a copy of RepoData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? url = null,Object? version = null,}) {
  return _then(RepoData(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as SupportedVersion,
  ));
}

}


OAuthResponseType _$OAuthResponseTypeFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'token':
          return OAuthTokenResponse.fromJson(
            json
          );
                case 'code':
          return OAuthCodeResponse.fromJson(
            json
          );
                case 'pkce':
          return OAuthPKCEResponse.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'OAuthResponseType',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$OAuthResponseType {



  /// Serializes this OAuthResponseType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthResponseType);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OAuthResponseType()';
}


}

/// @nodoc
class $OAuthResponseTypeCopyWith<$Res>  {
$OAuthResponseTypeCopyWith(OAuthResponseType _, $Res Function(OAuthResponseType) __);
}


/// @nodoc
@JsonSerializable()

class OAuthTokenResponse implements OAuthResponseType {
  const OAuthTokenResponse({final  String? $type}): $type = $type ?? 'token';
  factory OAuthTokenResponse.fromJson(Map<String, dynamic> json) => _$OAuthTokenResponseFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$OAuthTokenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthTokenResponse);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OAuthResponseType.token()';
}


}




/// @nodoc
@JsonSerializable()

class OAuthCodeResponse implements OAuthResponseType {
  const OAuthCodeResponse({required this.tokenEndpoint, final  String? $type}): $type = $type ?? 'code';
  factory OAuthCodeResponse.fromJson(Map<String, dynamic> json) => _$OAuthCodeResponseFromJson(json);

 final  String tokenEndpoint;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of OAuthResponseType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthCodeResponseCopyWith<OAuthCodeResponse> get copyWith => _$OAuthCodeResponseCopyWithImpl<OAuthCodeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthCodeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthCodeResponse&&(identical(other.tokenEndpoint, tokenEndpoint) || other.tokenEndpoint == tokenEndpoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tokenEndpoint);

@override
String toString() {
  return 'OAuthResponseType.code(tokenEndpoint: $tokenEndpoint)';
}


}

/// @nodoc
abstract mixin class $OAuthCodeResponseCopyWith<$Res> implements $OAuthResponseTypeCopyWith<$Res> {
  factory $OAuthCodeResponseCopyWith(OAuthCodeResponse value, $Res Function(OAuthCodeResponse) _then) = _$OAuthCodeResponseCopyWithImpl;
@useResult
$Res call({
 String tokenEndpoint
});




}
/// @nodoc
class _$OAuthCodeResponseCopyWithImpl<$Res>
    implements $OAuthCodeResponseCopyWith<$Res> {
  _$OAuthCodeResponseCopyWithImpl(this._self, this._then);

  final OAuthCodeResponse _self;
  final $Res Function(OAuthCodeResponse) _then;

/// Create a copy of OAuthResponseType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tokenEndpoint = null,}) {
  return _then(OAuthCodeResponse(
tokenEndpoint: null == tokenEndpoint ? _self.tokenEndpoint : tokenEndpoint // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OAuthPKCEResponse implements OAuthResponseType {
  const OAuthPKCEResponse({required this.tokenEndpoint, required this.pkceCodeLength, required this.pkceCodeMethod, required this.formEncodeGrant, final  String? $type}): $type = $type ?? 'pkce';
  factory OAuthPKCEResponse.fromJson(Map<String, dynamic> json) => _$OAuthPKCEResponseFromJson(json);

 final  String tokenEndpoint;
 final  num pkceCodeLength;
 final  String pkceCodeMethod;
 final  bool formEncodeGrant;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of OAuthResponseType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthPKCEResponseCopyWith<OAuthPKCEResponse> get copyWith => _$OAuthPKCEResponseCopyWithImpl<OAuthPKCEResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthPKCEResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthPKCEResponse&&(identical(other.tokenEndpoint, tokenEndpoint) || other.tokenEndpoint == tokenEndpoint)&&(identical(other.pkceCodeLength, pkceCodeLength) || other.pkceCodeLength == pkceCodeLength)&&(identical(other.pkceCodeMethod, pkceCodeMethod) || other.pkceCodeMethod == pkceCodeMethod)&&(identical(other.formEncodeGrant, formEncodeGrant) || other.formEncodeGrant == formEncodeGrant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tokenEndpoint,pkceCodeLength,pkceCodeMethod,formEncodeGrant);

@override
String toString() {
  return 'OAuthResponseType.pkce(tokenEndpoint: $tokenEndpoint, pkceCodeLength: $pkceCodeLength, pkceCodeMethod: $pkceCodeMethod, formEncodeGrant: $formEncodeGrant)';
}


}

/// @nodoc
abstract mixin class $OAuthPKCEResponseCopyWith<$Res> implements $OAuthResponseTypeCopyWith<$Res> {
  factory $OAuthPKCEResponseCopyWith(OAuthPKCEResponse value, $Res Function(OAuthPKCEResponse) _then) = _$OAuthPKCEResponseCopyWithImpl;
@useResult
$Res call({
 String tokenEndpoint, num pkceCodeLength, String pkceCodeMethod, bool formEncodeGrant
});




}
/// @nodoc
class _$OAuthPKCEResponseCopyWithImpl<$Res>
    implements $OAuthPKCEResponseCopyWith<$Res> {
  _$OAuthPKCEResponseCopyWithImpl(this._self, this._then);

  final OAuthPKCEResponse _self;
  final $Res Function(OAuthPKCEResponse) _then;

/// Create a copy of OAuthResponseType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tokenEndpoint = null,Object? pkceCodeLength = null,Object? pkceCodeMethod = null,Object? formEncodeGrant = null,}) {
  return _then(OAuthPKCEResponse(
tokenEndpoint: null == tokenEndpoint ? _self.tokenEndpoint : tokenEndpoint // ignore: cast_nullable_to_non_nullable
as String,pkceCodeLength: null == pkceCodeLength ? _self.pkceCodeLength : pkceCodeLength // ignore: cast_nullable_to_non_nullable
as num,pkceCodeMethod: null == pkceCodeMethod ? _self.pkceCodeMethod : pkceCodeMethod // ignore: cast_nullable_to_non_nullable
as String,formEncodeGrant: null == formEncodeGrant ? _self.formEncodeGrant : formEncodeGrant // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SearchQuery {

 String get title; List<SearchFilterValue> get filters;
/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchQueryCopyWith<SearchQuery> get copyWith => _$SearchQueryCopyWithImpl<SearchQuery>(this as SearchQuery, _$identity);

  /// Serializes this SearchQuery to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchQuery&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.filters, filters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(filters));

@override
String toString() {
  return 'SearchQuery(title: $title, filters: $filters)';
}


}

/// @nodoc
abstract mixin class $SearchQueryCopyWith<$Res>  {
  factory $SearchQueryCopyWith(SearchQuery value, $Res Function(SearchQuery) _then) = _$SearchQueryCopyWithImpl;
@useResult
$Res call({
 String title, List<SearchFilterValue> filters
});




}
/// @nodoc
class _$SearchQueryCopyWithImpl<$Res>
    implements $SearchQueryCopyWith<$Res> {
  _$SearchQueryCopyWithImpl(this._self, this._then);

  final SearchQuery _self;
  final $Res Function(SearchQuery) _then;

/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? filters = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as List<SearchFilterValue>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SearchQuery extends SearchQuery {
  const _SearchQuery({required this.title, final  List<SearchFilterValue> filters = const []}): _filters = filters,super._();
  factory _SearchQuery.fromJson(Map<String, dynamic> json) => _$SearchQueryFromJson(json);

@override final  String title;
 final  List<SearchFilterValue> _filters;
@override@JsonKey() List<SearchFilterValue> get filters {
  if (_filters is EqualUnmodifiableListView) return _filters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filters);
}


/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchQueryCopyWith<_SearchQuery> get copyWith => __$SearchQueryCopyWithImpl<_SearchQuery>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchQueryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchQuery&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._filters, _filters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_filters));

@override
String toString() {
  return 'SearchQuery(title: $title, filters: $filters)';
}


}

/// @nodoc
abstract mixin class _$SearchQueryCopyWith<$Res> implements $SearchQueryCopyWith<$Res> {
  factory _$SearchQueryCopyWith(_SearchQuery value, $Res Function(_SearchQuery) _then) = __$SearchQueryCopyWithImpl;
@override @useResult
$Res call({
 String title, List<SearchFilterValue> filters
});




}
/// @nodoc
class __$SearchQueryCopyWithImpl<$Res>
    implements _$SearchQueryCopyWith<$Res> {
  __$SearchQueryCopyWithImpl(this._self, this._then);

  final _SearchQuery _self;
  final $Res Function(_SearchQuery) _then;

/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? filters = null,}) {
  return _then(_SearchQuery(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,filters: null == filters ? _self._filters : filters // ignore: cast_nullable_to_non_nullable
as List<SearchFilterValue>,
  ));
}


}


/// @nodoc
mixin _$SearchResultItem {

 String get mangaId; String get title; String? get subtitle; String get imageUrl; dynamic get metadata;
/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultItemCopyWith<SearchResultItem> get copyWith => _$SearchResultItemCopyWithImpl<SearchResultItem>(this as SearchResultItem, _$identity);

  /// Serializes this SearchResultItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultItem&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mangaId,title,subtitle,imageUrl,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'SearchResultItem(mangaId: $mangaId, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $SearchResultItemCopyWith<$Res>  {
  factory $SearchResultItemCopyWith(SearchResultItem value, $Res Function(SearchResultItem) _then) = _$SearchResultItemCopyWithImpl;
@useResult
$Res call({
 String mangaId, String title, String? subtitle, String imageUrl, dynamic metadata
});




}
/// @nodoc
class _$SearchResultItemCopyWithImpl<$Res>
    implements $SearchResultItemCopyWith<$Res> {
  _$SearchResultItemCopyWithImpl(this._self, this._then);

  final SearchResultItem _self;
  final $Res Function(SearchResultItem) _then;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mangaId = null,Object? title = null,Object? subtitle = freezed,Object? imageUrl = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
mangaId: null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SearchResultItem implements SearchResultItem {
  const _SearchResultItem({required this.mangaId, required this.title, this.subtitle, required this.imageUrl, this.metadata});
  factory _SearchResultItem.fromJson(Map<String, dynamic> json) => _$SearchResultItemFromJson(json);

@override final  String mangaId;
@override final  String title;
@override final  String? subtitle;
@override final  String imageUrl;
@override final  dynamic metadata;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultItemCopyWith<_SearchResultItem> get copyWith => __$SearchResultItemCopyWithImpl<_SearchResultItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchResultItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResultItem&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mangaId,title,subtitle,imageUrl,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'SearchResultItem(mangaId: $mangaId, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$SearchResultItemCopyWith<$Res> implements $SearchResultItemCopyWith<$Res> {
  factory _$SearchResultItemCopyWith(_SearchResultItem value, $Res Function(_SearchResultItem) _then) = __$SearchResultItemCopyWithImpl;
@override @useResult
$Res call({
 String mangaId, String title, String? subtitle, String imageUrl, dynamic metadata
});




}
/// @nodoc
class __$SearchResultItemCopyWithImpl<$Res>
    implements _$SearchResultItemCopyWith<$Res> {
  __$SearchResultItemCopyWithImpl(this._self, this._then);

  final _SearchResultItem _self;
  final $Res Function(_SearchResultItem) _then;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mangaId = null,Object? title = null,Object? subtitle = freezed,Object? imageUrl = null,Object? metadata = freezed,}) {
  return _then(_SearchResultItem(
mangaId: null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$PagedResults<T> {

 List<T> get items; dynamic get metadata;
/// Create a copy of PagedResults
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagedResultsCopyWith<T, PagedResults<T>> get copyWith => _$PagedResultsCopyWithImpl<T, PagedResults<T>>(this as PagedResults<T>, _$identity);

  /// Serializes this PagedResults to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagedResults<T>&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'PagedResults<$T>(items: $items, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $PagedResultsCopyWith<T,$Res>  {
  factory $PagedResultsCopyWith(PagedResults<T> value, $Res Function(PagedResults<T>) _then) = _$PagedResultsCopyWithImpl;
@useResult
$Res call({
 List<T> items, dynamic metadata
});




}
/// @nodoc
class _$PagedResultsCopyWithImpl<T,$Res>
    implements $PagedResultsCopyWith<T, $Res> {
  _$PagedResultsCopyWithImpl(this._self, this._then);

  final PagedResults<T> _self;
  final $Res Function(PagedResults<T>) _then;

/// Create a copy of PagedResults
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<T>,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _PagedResults<T> implements PagedResults<T> {
   _PagedResults({required final  List<T> items, this.metadata}): _items = items;
  factory _PagedResults.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$PagedResultsFromJson(json,fromJsonT);

 final  List<T> _items;
@override List<T> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  dynamic metadata;

/// Create a copy of PagedResults
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagedResultsCopyWith<T, _PagedResults<T>> get copyWith => __$PagedResultsCopyWithImpl<T, _PagedResults<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$PagedResultsToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PagedResults<T>&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'PagedResults<$T>(items: $items, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$PagedResultsCopyWith<T,$Res> implements $PagedResultsCopyWith<T, $Res> {
  factory _$PagedResultsCopyWith(_PagedResults<T> value, $Res Function(_PagedResults<T>) _then) = __$PagedResultsCopyWithImpl;
@override @useResult
$Res call({
 List<T> items, dynamic metadata
});




}
/// @nodoc
class __$PagedResultsCopyWithImpl<T,$Res>
    implements _$PagedResultsCopyWith<T, $Res> {
  __$PagedResultsCopyWithImpl(this._self, this._then);

  final _PagedResults<T> _self;
  final $Res Function(_PagedResults<T>) _then;

/// Create a copy of PagedResults
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? metadata = freezed,}) {
  return _then(_PagedResults<T>(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<T>,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$SourceManga {

 String get mangaId; MangaInfo get mangaInfo;
/// Create a copy of SourceManga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceMangaCopyWith<SourceManga> get copyWith => _$SourceMangaCopyWithImpl<SourceManga>(this as SourceManga, _$identity);

  /// Serializes this SourceManga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceManga&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId)&&(identical(other.mangaInfo, mangaInfo) || other.mangaInfo == mangaInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mangaId,mangaInfo);

@override
String toString() {
  return 'SourceManga(mangaId: $mangaId, mangaInfo: $mangaInfo)';
}


}

/// @nodoc
abstract mixin class $SourceMangaCopyWith<$Res>  {
  factory $SourceMangaCopyWith(SourceManga value, $Res Function(SourceManga) _then) = _$SourceMangaCopyWithImpl;
@useResult
$Res call({
 String mangaId, MangaInfo mangaInfo
});


$MangaInfoCopyWith<$Res> get mangaInfo;

}
/// @nodoc
class _$SourceMangaCopyWithImpl<$Res>
    implements $SourceMangaCopyWith<$Res> {
  _$SourceMangaCopyWithImpl(this._self, this._then);

  final SourceManga _self;
  final $Res Function(SourceManga) _then;

/// Create a copy of SourceManga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mangaId = null,Object? mangaInfo = null,}) {
  return _then(_self.copyWith(
mangaId: null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,mangaInfo: null == mangaInfo ? _self.mangaInfo : mangaInfo // ignore: cast_nullable_to_non_nullable
as MangaInfo,
  ));
}
/// Create a copy of SourceManga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MangaInfoCopyWith<$Res> get mangaInfo {
  
  return $MangaInfoCopyWith<$Res>(_self.mangaInfo, (value) {
    return _then(_self.copyWith(mangaInfo: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _SourceManga implements SourceManga {
  const _SourceManga({required this.mangaId, required this.mangaInfo});
  factory _SourceManga.fromJson(Map<String, dynamic> json) => _$SourceMangaFromJson(json);

@override final  String mangaId;
@override final  MangaInfo mangaInfo;

/// Create a copy of SourceManga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceMangaCopyWith<_SourceManga> get copyWith => __$SourceMangaCopyWithImpl<_SourceManga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourceMangaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceManga&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId)&&(identical(other.mangaInfo, mangaInfo) || other.mangaInfo == mangaInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mangaId,mangaInfo);

@override
String toString() {
  return 'SourceManga(mangaId: $mangaId, mangaInfo: $mangaInfo)';
}


}

/// @nodoc
abstract mixin class _$SourceMangaCopyWith<$Res> implements $SourceMangaCopyWith<$Res> {
  factory _$SourceMangaCopyWith(_SourceManga value, $Res Function(_SourceManga) _then) = __$SourceMangaCopyWithImpl;
@override @useResult
$Res call({
 String mangaId, MangaInfo mangaInfo
});


@override $MangaInfoCopyWith<$Res> get mangaInfo;

}
/// @nodoc
class __$SourceMangaCopyWithImpl<$Res>
    implements _$SourceMangaCopyWith<$Res> {
  __$SourceMangaCopyWithImpl(this._self, this._then);

  final _SourceManga _self;
  final $Res Function(_SourceManga) _then;

/// Create a copy of SourceManga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mangaId = null,Object? mangaInfo = null,}) {
  return _then(_SourceManga(
mangaId: null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,mangaInfo: null == mangaInfo ? _self.mangaInfo : mangaInfo // ignore: cast_nullable_to_non_nullable
as MangaInfo,
  ));
}

/// Create a copy of SourceManga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MangaInfoCopyWith<$Res> get mangaInfo {
  
  return $MangaInfoCopyWith<$Res>(_self.mangaInfo, (value) {
    return _then(_self.copyWith(mangaInfo: value));
  });
}
}


/// @nodoc
mixin _$MangaInfo {

 String get thumbnailUrl; String get synopsis; String get primaryTitle; List<String> get secondaryTitles;@ContentRatingParser() ContentRating get contentRating; String? get status; String? get artist; String? get author; String? get bannerUrl; num? get rating; List<TagSection>? get tagGroups; List<String>? get artworkUrls; Map<String, String>? get additionalInfo; String? get shareUrl;
/// Create a copy of MangaInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaInfoCopyWith<MangaInfo> get copyWith => _$MangaInfoCopyWithImpl<MangaInfo>(this as MangaInfo, _$identity);

  /// Serializes this MangaInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MangaInfo&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.primaryTitle, primaryTitle) || other.primaryTitle == primaryTitle)&&const DeepCollectionEquality().equals(other.secondaryTitles, secondaryTitles)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&(identical(other.status, status) || other.status == status)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.author, author) || other.author == author)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other.tagGroups, tagGroups)&&const DeepCollectionEquality().equals(other.artworkUrls, artworkUrls)&&const DeepCollectionEquality().equals(other.additionalInfo, additionalInfo)&&(identical(other.shareUrl, shareUrl) || other.shareUrl == shareUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,thumbnailUrl,synopsis,primaryTitle,const DeepCollectionEquality().hash(secondaryTitles),contentRating,status,artist,author,bannerUrl,rating,const DeepCollectionEquality().hash(tagGroups),const DeepCollectionEquality().hash(artworkUrls),const DeepCollectionEquality().hash(additionalInfo),shareUrl);

@override
String toString() {
  return 'MangaInfo(thumbnailUrl: $thumbnailUrl, synopsis: $synopsis, primaryTitle: $primaryTitle, secondaryTitles: $secondaryTitles, contentRating: $contentRating, status: $status, artist: $artist, author: $author, bannerUrl: $bannerUrl, rating: $rating, tagGroups: $tagGroups, artworkUrls: $artworkUrls, additionalInfo: $additionalInfo, shareUrl: $shareUrl)';
}


}

/// @nodoc
abstract mixin class $MangaInfoCopyWith<$Res>  {
  factory $MangaInfoCopyWith(MangaInfo value, $Res Function(MangaInfo) _then) = _$MangaInfoCopyWithImpl;
@useResult
$Res call({
 String thumbnailUrl, String synopsis, String primaryTitle, List<String> secondaryTitles,@ContentRatingParser() ContentRating contentRating, String? status, String? artist, String? author, String? bannerUrl, num? rating, List<TagSection>? tagGroups, List<String>? artworkUrls, Map<String, String>? additionalInfo, String? shareUrl
});




}
/// @nodoc
class _$MangaInfoCopyWithImpl<$Res>
    implements $MangaInfoCopyWith<$Res> {
  _$MangaInfoCopyWithImpl(this._self, this._then);

  final MangaInfo _self;
  final $Res Function(MangaInfo) _then;

/// Create a copy of MangaInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? thumbnailUrl = null,Object? synopsis = null,Object? primaryTitle = null,Object? secondaryTitles = null,Object? contentRating = null,Object? status = freezed,Object? artist = freezed,Object? author = freezed,Object? bannerUrl = freezed,Object? rating = freezed,Object? tagGroups = freezed,Object? artworkUrls = freezed,Object? additionalInfo = freezed,Object? shareUrl = freezed,}) {
  return _then(_self.copyWith(
thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String,primaryTitle: null == primaryTitle ? _self.primaryTitle : primaryTitle // ignore: cast_nullable_to_non_nullable
as String,secondaryTitles: null == secondaryTitles ? _self.secondaryTitles : secondaryTitles // ignore: cast_nullable_to_non_nullable
as List<String>,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,artist: freezed == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as num?,tagGroups: freezed == tagGroups ? _self.tagGroups : tagGroups // ignore: cast_nullable_to_non_nullable
as List<TagSection>?,artworkUrls: freezed == artworkUrls ? _self.artworkUrls : artworkUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,additionalInfo: freezed == additionalInfo ? _self.additionalInfo : additionalInfo // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,shareUrl: freezed == shareUrl ? _self.shareUrl : shareUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MangaInfo implements MangaInfo {
  const _MangaInfo({required this.thumbnailUrl, required this.synopsis, required this.primaryTitle, required final  List<String> secondaryTitles, @ContentRatingParser() required this.contentRating, this.status, this.artist, this.author, this.bannerUrl, this.rating, final  List<TagSection>? tagGroups, final  List<String>? artworkUrls, final  Map<String, String>? additionalInfo, this.shareUrl}): _secondaryTitles = secondaryTitles,_tagGroups = tagGroups,_artworkUrls = artworkUrls,_additionalInfo = additionalInfo;
  factory _MangaInfo.fromJson(Map<String, dynamic> json) => _$MangaInfoFromJson(json);

@override final  String thumbnailUrl;
@override final  String synopsis;
@override final  String primaryTitle;
 final  List<String> _secondaryTitles;
@override List<String> get secondaryTitles {
  if (_secondaryTitles is EqualUnmodifiableListView) return _secondaryTitles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_secondaryTitles);
}

@override@ContentRatingParser() final  ContentRating contentRating;
@override final  String? status;
@override final  String? artist;
@override final  String? author;
@override final  String? bannerUrl;
@override final  num? rating;
 final  List<TagSection>? _tagGroups;
@override List<TagSection>? get tagGroups {
  final value = _tagGroups;
  if (value == null) return null;
  if (_tagGroups is EqualUnmodifiableListView) return _tagGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _artworkUrls;
@override List<String>? get artworkUrls {
  final value = _artworkUrls;
  if (value == null) return null;
  if (_artworkUrls is EqualUnmodifiableListView) return _artworkUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, String>? _additionalInfo;
@override Map<String, String>? get additionalInfo {
  final value = _additionalInfo;
  if (value == null) return null;
  if (_additionalInfo is EqualUnmodifiableMapView) return _additionalInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? shareUrl;

/// Create a copy of MangaInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MangaInfoCopyWith<_MangaInfo> get copyWith => __$MangaInfoCopyWithImpl<_MangaInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MangaInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MangaInfo&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.primaryTitle, primaryTitle) || other.primaryTitle == primaryTitle)&&const DeepCollectionEquality().equals(other._secondaryTitles, _secondaryTitles)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&(identical(other.status, status) || other.status == status)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.author, author) || other.author == author)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other._tagGroups, _tagGroups)&&const DeepCollectionEquality().equals(other._artworkUrls, _artworkUrls)&&const DeepCollectionEquality().equals(other._additionalInfo, _additionalInfo)&&(identical(other.shareUrl, shareUrl) || other.shareUrl == shareUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,thumbnailUrl,synopsis,primaryTitle,const DeepCollectionEquality().hash(_secondaryTitles),contentRating,status,artist,author,bannerUrl,rating,const DeepCollectionEquality().hash(_tagGroups),const DeepCollectionEquality().hash(_artworkUrls),const DeepCollectionEquality().hash(_additionalInfo),shareUrl);

@override
String toString() {
  return 'MangaInfo(thumbnailUrl: $thumbnailUrl, synopsis: $synopsis, primaryTitle: $primaryTitle, secondaryTitles: $secondaryTitles, contentRating: $contentRating, status: $status, artist: $artist, author: $author, bannerUrl: $bannerUrl, rating: $rating, tagGroups: $tagGroups, artworkUrls: $artworkUrls, additionalInfo: $additionalInfo, shareUrl: $shareUrl)';
}


}

/// @nodoc
abstract mixin class _$MangaInfoCopyWith<$Res> implements $MangaInfoCopyWith<$Res> {
  factory _$MangaInfoCopyWith(_MangaInfo value, $Res Function(_MangaInfo) _then) = __$MangaInfoCopyWithImpl;
@override @useResult
$Res call({
 String thumbnailUrl, String synopsis, String primaryTitle, List<String> secondaryTitles,@ContentRatingParser() ContentRating contentRating, String? status, String? artist, String? author, String? bannerUrl, num? rating, List<TagSection>? tagGroups, List<String>? artworkUrls, Map<String, String>? additionalInfo, String? shareUrl
});




}
/// @nodoc
class __$MangaInfoCopyWithImpl<$Res>
    implements _$MangaInfoCopyWith<$Res> {
  __$MangaInfoCopyWithImpl(this._self, this._then);

  final _MangaInfo _self;
  final $Res Function(_MangaInfo) _then;

/// Create a copy of MangaInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? thumbnailUrl = null,Object? synopsis = null,Object? primaryTitle = null,Object? secondaryTitles = null,Object? contentRating = null,Object? status = freezed,Object? artist = freezed,Object? author = freezed,Object? bannerUrl = freezed,Object? rating = freezed,Object? tagGroups = freezed,Object? artworkUrls = freezed,Object? additionalInfo = freezed,Object? shareUrl = freezed,}) {
  return _then(_MangaInfo(
thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String,primaryTitle: null == primaryTitle ? _self.primaryTitle : primaryTitle // ignore: cast_nullable_to_non_nullable
as String,secondaryTitles: null == secondaryTitles ? _self._secondaryTitles : secondaryTitles // ignore: cast_nullable_to_non_nullable
as List<String>,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,artist: freezed == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as num?,tagGroups: freezed == tagGroups ? _self._tagGroups : tagGroups // ignore: cast_nullable_to_non_nullable
as List<TagSection>?,artworkUrls: freezed == artworkUrls ? _self._artworkUrls : artworkUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,additionalInfo: freezed == additionalInfo ? _self._additionalInfo : additionalInfo // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,shareUrl: freezed == shareUrl ? _self.shareUrl : shareUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TagSection {

 String get id; String get title; List<Tag> get tags;
/// Create a copy of TagSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagSectionCopyWith<TagSection> get copyWith => _$TagSectionCopyWithImpl<TagSection>(this as TagSection, _$identity);

  /// Serializes this TagSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'TagSection(id: $id, title: $title, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $TagSectionCopyWith<$Res>  {
  factory $TagSectionCopyWith(TagSection value, $Res Function(TagSection) _then) = _$TagSectionCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<Tag> tags
});




}
/// @nodoc
class _$TagSectionCopyWithImpl<$Res>
    implements $TagSectionCopyWith<$Res> {
  _$TagSectionCopyWithImpl(this._self, this._then);

  final TagSection _self;
  final $Res Function(TagSection) _then;

/// Create a copy of TagSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TagSection implements TagSection {
  const _TagSection({required this.id, required this.title, required final  List<Tag> tags}): _tags = tags;
  factory _TagSection.fromJson(Map<String, dynamic> json) => _$TagSectionFromJson(json);

@override final  String id;
@override final  String title;
 final  List<Tag> _tags;
@override List<Tag> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of TagSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagSectionCopyWith<_TagSection> get copyWith => __$TagSectionCopyWithImpl<_TagSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TagSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'TagSection(id: $id, title: $title, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$TagSectionCopyWith<$Res> implements $TagSectionCopyWith<$Res> {
  factory _$TagSectionCopyWith(_TagSection value, $Res Function(_TagSection) _then) = __$TagSectionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<Tag> tags
});




}
/// @nodoc
class __$TagSectionCopyWithImpl<$Res>
    implements _$TagSectionCopyWith<$Res> {
  __$TagSectionCopyWithImpl(this._self, this._then);

  final _TagSection _self;
  final $Res Function(_TagSection) _then;

/// Create a copy of TagSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? tags = null,}) {
  return _then(_TagSection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>,
  ));
}


}


/// @nodoc
mixin _$Tag {

 String get id; String get title;
/// Create a copy of Tag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagCopyWith<Tag> get copyWith => _$TagCopyWithImpl<Tag>(this as Tag, _$identity);

  /// Serializes this Tag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tag&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'Tag(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class $TagCopyWith<$Res>  {
  factory $TagCopyWith(Tag value, $Res Function(Tag) _then) = _$TagCopyWithImpl;
@useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class _$TagCopyWithImpl<$Res>
    implements $TagCopyWith<$Res> {
  _$TagCopyWithImpl(this._self, this._then);

  final Tag _self;
  final $Res Function(Tag) _then;

/// Create a copy of Tag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Tag implements Tag {
  const _Tag({required this.id, required this.title});
  factory _Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

@override final  String id;
@override final  String title;

/// Create a copy of Tag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagCopyWith<_Tag> get copyWith => __$TagCopyWithImpl<_Tag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TagToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tag&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'Tag(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class _$TagCopyWith<$Res> implements $TagCopyWith<$Res> {
  factory _$TagCopyWith(_Tag value, $Res Function(_Tag) _then) = __$TagCopyWithImpl;
@override @useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class __$TagCopyWithImpl<$Res>
    implements _$TagCopyWith<$Res> {
  __$TagCopyWithImpl(this._self, this._then);

  final _Tag _self;
  final $Res Function(_Tag) _then;

/// Create a copy of Tag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,}) {
  return _then(_Tag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Chapter {

 String get chapterId; SourceManga get sourceManga; String get langCode; num get chapNum; String? get title; String? get version; num? get volume; Map<String, String>? get additionalInfo;@NullableTimestampSerializer() DateTime? get publishDate;@NullableTimestampSerializer() DateTime? get creationDate; num? get sortingIndex;
/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterCopyWith<Chapter> get copyWith => _$ChapterCopyWithImpl<Chapter>(this as Chapter, _$identity);

  /// Serializes this Chapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Chapter&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId)&&(identical(other.sourceManga, sourceManga) || other.sourceManga == sourceManga)&&(identical(other.langCode, langCode) || other.langCode == langCode)&&(identical(other.chapNum, chapNum) || other.chapNum == chapNum)&&(identical(other.title, title) || other.title == title)&&(identical(other.version, version) || other.version == version)&&(identical(other.volume, volume) || other.volume == volume)&&const DeepCollectionEquality().equals(other.additionalInfo, additionalInfo)&&(identical(other.publishDate, publishDate) || other.publishDate == publishDate)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate)&&(identical(other.sortingIndex, sortingIndex) || other.sortingIndex == sortingIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chapterId,sourceManga,langCode,chapNum,title,version,volume,const DeepCollectionEquality().hash(additionalInfo),publishDate,creationDate,sortingIndex);

@override
String toString() {
  return 'Chapter(chapterId: $chapterId, sourceManga: $sourceManga, langCode: $langCode, chapNum: $chapNum, title: $title, version: $version, volume: $volume, additionalInfo: $additionalInfo, publishDate: $publishDate, creationDate: $creationDate, sortingIndex: $sortingIndex)';
}


}

/// @nodoc
abstract mixin class $ChapterCopyWith<$Res>  {
  factory $ChapterCopyWith(Chapter value, $Res Function(Chapter) _then) = _$ChapterCopyWithImpl;
@useResult
$Res call({
 String chapterId, SourceManga sourceManga, String langCode, num chapNum, String? title, String? version, num? volume, Map<String, String>? additionalInfo,@NullableTimestampSerializer() DateTime? publishDate,@NullableTimestampSerializer() DateTime? creationDate, num? sortingIndex
});


$SourceMangaCopyWith<$Res> get sourceManga;

}
/// @nodoc
class _$ChapterCopyWithImpl<$Res>
    implements $ChapterCopyWith<$Res> {
  _$ChapterCopyWithImpl(this._self, this._then);

  final Chapter _self;
  final $Res Function(Chapter) _then;

/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chapterId = null,Object? sourceManga = null,Object? langCode = null,Object? chapNum = null,Object? title = freezed,Object? version = freezed,Object? volume = freezed,Object? additionalInfo = freezed,Object? publishDate = freezed,Object? creationDate = freezed,Object? sortingIndex = freezed,}) {
  return _then(_self.copyWith(
chapterId: null == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String,sourceManga: null == sourceManga ? _self.sourceManga : sourceManga // ignore: cast_nullable_to_non_nullable
as SourceManga,langCode: null == langCode ? _self.langCode : langCode // ignore: cast_nullable_to_non_nullable
as String,chapNum: null == chapNum ? _self.chapNum : chapNum // ignore: cast_nullable_to_non_nullable
as num,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as num?,additionalInfo: freezed == additionalInfo ? _self.additionalInfo : additionalInfo // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,publishDate: freezed == publishDate ? _self.publishDate : publishDate // ignore: cast_nullable_to_non_nullable
as DateTime?,creationDate: freezed == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sortingIndex: freezed == sortingIndex ? _self.sortingIndex : sortingIndex // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}
/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourceMangaCopyWith<$Res> get sourceManga {
  
  return $SourceMangaCopyWith<$Res>(_self.sourceManga, (value) {
    return _then(_self.copyWith(sourceManga: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _Chapter implements Chapter {
  const _Chapter({required this.chapterId, required this.sourceManga, required this.langCode, required this.chapNum, this.title, this.version, this.volume, final  Map<String, String>? additionalInfo, @NullableTimestampSerializer() this.publishDate, @NullableTimestampSerializer() this.creationDate, this.sortingIndex}): _additionalInfo = additionalInfo;
  factory _Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);

@override final  String chapterId;
@override final  SourceManga sourceManga;
@override final  String langCode;
@override final  num chapNum;
@override final  String? title;
@override final  String? version;
@override final  num? volume;
 final  Map<String, String>? _additionalInfo;
@override Map<String, String>? get additionalInfo {
  final value = _additionalInfo;
  if (value == null) return null;
  if (_additionalInfo is EqualUnmodifiableMapView) return _additionalInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@NullableTimestampSerializer() final  DateTime? publishDate;
@override@NullableTimestampSerializer() final  DateTime? creationDate;
@override final  num? sortingIndex;

/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterCopyWith<_Chapter> get copyWith => __$ChapterCopyWithImpl<_Chapter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Chapter&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId)&&(identical(other.sourceManga, sourceManga) || other.sourceManga == sourceManga)&&(identical(other.langCode, langCode) || other.langCode == langCode)&&(identical(other.chapNum, chapNum) || other.chapNum == chapNum)&&(identical(other.title, title) || other.title == title)&&(identical(other.version, version) || other.version == version)&&(identical(other.volume, volume) || other.volume == volume)&&const DeepCollectionEquality().equals(other._additionalInfo, _additionalInfo)&&(identical(other.publishDate, publishDate) || other.publishDate == publishDate)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate)&&(identical(other.sortingIndex, sortingIndex) || other.sortingIndex == sortingIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chapterId,sourceManga,langCode,chapNum,title,version,volume,const DeepCollectionEquality().hash(_additionalInfo),publishDate,creationDate,sortingIndex);

@override
String toString() {
  return 'Chapter(chapterId: $chapterId, sourceManga: $sourceManga, langCode: $langCode, chapNum: $chapNum, title: $title, version: $version, volume: $volume, additionalInfo: $additionalInfo, publishDate: $publishDate, creationDate: $creationDate, sortingIndex: $sortingIndex)';
}


}

/// @nodoc
abstract mixin class _$ChapterCopyWith<$Res> implements $ChapterCopyWith<$Res> {
  factory _$ChapterCopyWith(_Chapter value, $Res Function(_Chapter) _then) = __$ChapterCopyWithImpl;
@override @useResult
$Res call({
 String chapterId, SourceManga sourceManga, String langCode, num chapNum, String? title, String? version, num? volume, Map<String, String>? additionalInfo,@NullableTimestampSerializer() DateTime? publishDate,@NullableTimestampSerializer() DateTime? creationDate, num? sortingIndex
});


@override $SourceMangaCopyWith<$Res> get sourceManga;

}
/// @nodoc
class __$ChapterCopyWithImpl<$Res>
    implements _$ChapterCopyWith<$Res> {
  __$ChapterCopyWithImpl(this._self, this._then);

  final _Chapter _self;
  final $Res Function(_Chapter) _then;

/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chapterId = null,Object? sourceManga = null,Object? langCode = null,Object? chapNum = null,Object? title = freezed,Object? version = freezed,Object? volume = freezed,Object? additionalInfo = freezed,Object? publishDate = freezed,Object? creationDate = freezed,Object? sortingIndex = freezed,}) {
  return _then(_Chapter(
chapterId: null == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String,sourceManga: null == sourceManga ? _self.sourceManga : sourceManga // ignore: cast_nullable_to_non_nullable
as SourceManga,langCode: null == langCode ? _self.langCode : langCode // ignore: cast_nullable_to_non_nullable
as String,chapNum: null == chapNum ? _self.chapNum : chapNum // ignore: cast_nullable_to_non_nullable
as num,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as num?,additionalInfo: freezed == additionalInfo ? _self._additionalInfo : additionalInfo // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,publishDate: freezed == publishDate ? _self.publishDate : publishDate // ignore: cast_nullable_to_non_nullable
as DateTime?,creationDate: freezed == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sortingIndex: freezed == sortingIndex ? _self.sortingIndex : sortingIndex // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourceMangaCopyWith<$Res> get sourceManga {
  
  return $SourceMangaCopyWith<$Res>(_self.sourceManga, (value) {
    return _then(_self.copyWith(sourceManga: value));
  });
}
}


/// @nodoc
mixin _$ChapterDetails {

 String get id; String get mangaId; List<String> get pages;
/// Create a copy of ChapterDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterDetailsCopyWith<ChapterDetails> get copyWith => _$ChapterDetailsCopyWithImpl<ChapterDetails>(this as ChapterDetails, _$identity);

  /// Serializes this ChapterDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId)&&const DeepCollectionEquality().equals(other.pages, pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mangaId,const DeepCollectionEquality().hash(pages));

@override
String toString() {
  return 'ChapterDetails(id: $id, mangaId: $mangaId, pages: $pages)';
}


}

/// @nodoc
abstract mixin class $ChapterDetailsCopyWith<$Res>  {
  factory $ChapterDetailsCopyWith(ChapterDetails value, $Res Function(ChapterDetails) _then) = _$ChapterDetailsCopyWithImpl;
@useResult
$Res call({
 String id, String mangaId, List<String> pages
});




}
/// @nodoc
class _$ChapterDetailsCopyWithImpl<$Res>
    implements $ChapterDetailsCopyWith<$Res> {
  _$ChapterDetailsCopyWithImpl(this._self, this._then);

  final ChapterDetails _self;
  final $Res Function(ChapterDetails) _then;

/// Create a copy of ChapterDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mangaId = null,Object? pages = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mangaId: null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ChapterDetails implements ChapterDetails {
  const _ChapterDetails({required this.id, required this.mangaId, required final  List<String> pages}): _pages = pages;
  factory _ChapterDetails.fromJson(Map<String, dynamic> json) => _$ChapterDetailsFromJson(json);

@override final  String id;
@override final  String mangaId;
 final  List<String> _pages;
@override List<String> get pages {
  if (_pages is EqualUnmodifiableListView) return _pages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pages);
}


/// Create a copy of ChapterDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterDetailsCopyWith<_ChapterDetails> get copyWith => __$ChapterDetailsCopyWithImpl<_ChapterDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId)&&const DeepCollectionEquality().equals(other._pages, _pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mangaId,const DeepCollectionEquality().hash(_pages));

@override
String toString() {
  return 'ChapterDetails(id: $id, mangaId: $mangaId, pages: $pages)';
}


}

/// @nodoc
abstract mixin class _$ChapterDetailsCopyWith<$Res> implements $ChapterDetailsCopyWith<$Res> {
  factory _$ChapterDetailsCopyWith(_ChapterDetails value, $Res Function(_ChapterDetails) _then) = __$ChapterDetailsCopyWithImpl;
@override @useResult
$Res call({
 String id, String mangaId, List<String> pages
});




}
/// @nodoc
class __$ChapterDetailsCopyWithImpl<$Res>
    implements _$ChapterDetailsCopyWith<$Res> {
  __$ChapterDetailsCopyWithImpl(this._self, this._then);

  final _ChapterDetails _self;
  final $Res Function(_ChapterDetails) _then;

/// Create a copy of ChapterDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mangaId = null,Object? pages = null,}) {
  return _then(_ChapterDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mangaId: null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,pages: null == pages ? _self._pages : pages // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$DiscoverSection {

 String get id; String get title; String? get subtitle;@DiscoverSectionTypeParser() DiscoverSectionType get type;
/// Create a copy of DiscoverSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverSectionCopyWith<DiscoverSection> get copyWith => _$DiscoverSectionCopyWithImpl<DiscoverSection>(this as DiscoverSection, _$identity);

  /// Serializes this DiscoverSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,type);

@override
String toString() {
  return 'DiscoverSection(id: $id, title: $title, subtitle: $subtitle, type: $type)';
}


}

/// @nodoc
abstract mixin class $DiscoverSectionCopyWith<$Res>  {
  factory $DiscoverSectionCopyWith(DiscoverSection value, $Res Function(DiscoverSection) _then) = _$DiscoverSectionCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? subtitle,@DiscoverSectionTypeParser() DiscoverSectionType type
});




}
/// @nodoc
class _$DiscoverSectionCopyWithImpl<$Res>
    implements $DiscoverSectionCopyWith<$Res> {
  _$DiscoverSectionCopyWithImpl(this._self, this._then);

  final DiscoverSection _self;
  final $Res Function(DiscoverSection) _then;

/// Create a copy of DiscoverSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subtitle = freezed,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DiscoverSectionType,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DiscoverSection implements DiscoverSection {
  const _DiscoverSection({required this.id, required this.title, this.subtitle, @DiscoverSectionTypeParser() required this.type});
  factory _DiscoverSection.fromJson(Map<String, dynamic> json) => _$DiscoverSectionFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? subtitle;
@override@DiscoverSectionTypeParser() final  DiscoverSectionType type;

/// Create a copy of DiscoverSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscoverSectionCopyWith<_DiscoverSection> get copyWith => __$DiscoverSectionCopyWithImpl<_DiscoverSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiscoverSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscoverSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,type);

@override
String toString() {
  return 'DiscoverSection(id: $id, title: $title, subtitle: $subtitle, type: $type)';
}


}

/// @nodoc
abstract mixin class _$DiscoverSectionCopyWith<$Res> implements $DiscoverSectionCopyWith<$Res> {
  factory _$DiscoverSectionCopyWith(_DiscoverSection value, $Res Function(_DiscoverSection) _then) = __$DiscoverSectionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? subtitle,@DiscoverSectionTypeParser() DiscoverSectionType type
});




}
/// @nodoc
class __$DiscoverSectionCopyWithImpl<$Res>
    implements _$DiscoverSectionCopyWith<$Res> {
  __$DiscoverSectionCopyWithImpl(this._self, this._then);

  final _DiscoverSection _self;
  final $Res Function(_DiscoverSection) _then;

/// Create a copy of DiscoverSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subtitle = freezed,Object? type = null,}) {
  return _then(_DiscoverSection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DiscoverSectionType,
  ));
}


}

DiscoverSectionItem _$DiscoverSectionItemFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'genresCarouselItem':
          return GenresCarouselItem.fromJson(
            json
          );
                case 'chapterUpdatesCarouselItem':
          return ChapterUpdatesCarouselItem.fromJson(
            json
          );
                case 'prominentCarouselItem':
          return ProminentCarouselItem.fromJson(
            json
          );
                case 'simpleCarouselItem':
          return SimpleCarouselItem.fromJson(
            json
          );
                case 'featuredCarouselItem':
          return FeaturedCarouselItem.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'DiscoverSectionItem',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$DiscoverSectionItem {

 dynamic get metadata;@NullableContentRatingParser() ContentRating? get contentRating;
/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverSectionItemCopyWith<DiscoverSectionItem> get copyWith => _$DiscoverSectionItemCopyWithImpl<DiscoverSectionItem>(this as DiscoverSectionItem, _$identity);

  /// Serializes this DiscoverSectionItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverSectionItem&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(metadata),contentRating);

@override
String toString() {
  return 'DiscoverSectionItem(metadata: $metadata, contentRating: $contentRating)';
}


}

/// @nodoc
abstract mixin class $DiscoverSectionItemCopyWith<$Res>  {
  factory $DiscoverSectionItemCopyWith(DiscoverSectionItem value, $Res Function(DiscoverSectionItem) _then) = _$DiscoverSectionItemCopyWithImpl;
@useResult
$Res call({
 dynamic metadata,@NullableContentRatingParser() ContentRating? contentRating
});




}
/// @nodoc
class _$DiscoverSectionItemCopyWithImpl<$Res>
    implements $DiscoverSectionItemCopyWith<$Res> {
  _$DiscoverSectionItemCopyWithImpl(this._self, this._then);

  final DiscoverSectionItem _self;
  final $Res Function(DiscoverSectionItem) _then;

/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = freezed,Object? contentRating = freezed,}) {
  return _then(_self.copyWith(
metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,contentRating: freezed == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class GenresCarouselItem implements DiscoverSectionItem {
  const GenresCarouselItem({required this.searchQuery, required this.name, this.metadata, @NullableContentRatingParser() this.contentRating, final  String? $type}): $type = $type ?? 'genresCarouselItem';
  factory GenresCarouselItem.fromJson(Map<String, dynamic> json) => _$GenresCarouselItemFromJson(json);

 final  SearchQuery searchQuery;
 final  String name;
@override final  dynamic metadata;
@override@NullableContentRatingParser() final  ContentRating? contentRating;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenresCarouselItemCopyWith<GenresCarouselItem> get copyWith => _$GenresCarouselItemCopyWithImpl<GenresCarouselItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenresCarouselItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenresCarouselItem&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,searchQuery,name,const DeepCollectionEquality().hash(metadata),contentRating);

@override
String toString() {
  return 'DiscoverSectionItem.genresCarouselItem(searchQuery: $searchQuery, name: $name, metadata: $metadata, contentRating: $contentRating)';
}


}

/// @nodoc
abstract mixin class $GenresCarouselItemCopyWith<$Res> implements $DiscoverSectionItemCopyWith<$Res> {
  factory $GenresCarouselItemCopyWith(GenresCarouselItem value, $Res Function(GenresCarouselItem) _then) = _$GenresCarouselItemCopyWithImpl;
@override @useResult
$Res call({
 SearchQuery searchQuery, String name, dynamic metadata,@NullableContentRatingParser() ContentRating? contentRating
});


$SearchQueryCopyWith<$Res> get searchQuery;

}
/// @nodoc
class _$GenresCarouselItemCopyWithImpl<$Res>
    implements $GenresCarouselItemCopyWith<$Res> {
  _$GenresCarouselItemCopyWithImpl(this._self, this._then);

  final GenresCarouselItem _self;
  final $Res Function(GenresCarouselItem) _then;

/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQuery = null,Object? name = null,Object? metadata = freezed,Object? contentRating = freezed,}) {
  return _then(GenresCarouselItem(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as SearchQuery,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,contentRating: freezed == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating?,
  ));
}

/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchQueryCopyWith<$Res> get searchQuery {
  
  return $SearchQueryCopyWith<$Res>(_self.searchQuery, (value) {
    return _then(_self.copyWith(searchQuery: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ChapterUpdatesCarouselItem implements DiscoverSectionItem {
  const ChapterUpdatesCarouselItem({required this.mangaId, required this.chapterId, required this.imageUrl, required this.title, this.subtitle, @NullableTimestampSerializer() this.publishDate, this.metadata, @NullableContentRatingParser() this.contentRating, final  String? $type}): $type = $type ?? 'chapterUpdatesCarouselItem';
  factory ChapterUpdatesCarouselItem.fromJson(Map<String, dynamic> json) => _$ChapterUpdatesCarouselItemFromJson(json);

 final  String mangaId;
 final  String chapterId;
 final  String imageUrl;
 final  String title;
 final  String? subtitle;
@NullableTimestampSerializer() final  DateTime? publishDate;
@override final  dynamic metadata;
@override@NullableContentRatingParser() final  ContentRating? contentRating;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterUpdatesCarouselItemCopyWith<ChapterUpdatesCarouselItem> get copyWith => _$ChapterUpdatesCarouselItemCopyWithImpl<ChapterUpdatesCarouselItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterUpdatesCarouselItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterUpdatesCarouselItem&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId)&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.publishDate, publishDate) || other.publishDate == publishDate)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mangaId,chapterId,imageUrl,title,subtitle,publishDate,const DeepCollectionEquality().hash(metadata),contentRating);

@override
String toString() {
  return 'DiscoverSectionItem.chapterUpdatesCarouselItem(mangaId: $mangaId, chapterId: $chapterId, imageUrl: $imageUrl, title: $title, subtitle: $subtitle, publishDate: $publishDate, metadata: $metadata, contentRating: $contentRating)';
}


}

/// @nodoc
abstract mixin class $ChapterUpdatesCarouselItemCopyWith<$Res> implements $DiscoverSectionItemCopyWith<$Res> {
  factory $ChapterUpdatesCarouselItemCopyWith(ChapterUpdatesCarouselItem value, $Res Function(ChapterUpdatesCarouselItem) _then) = _$ChapterUpdatesCarouselItemCopyWithImpl;
@override @useResult
$Res call({
 String mangaId, String chapterId, String imageUrl, String title, String? subtitle,@NullableTimestampSerializer() DateTime? publishDate, dynamic metadata,@NullableContentRatingParser() ContentRating? contentRating
});




}
/// @nodoc
class _$ChapterUpdatesCarouselItemCopyWithImpl<$Res>
    implements $ChapterUpdatesCarouselItemCopyWith<$Res> {
  _$ChapterUpdatesCarouselItemCopyWithImpl(this._self, this._then);

  final ChapterUpdatesCarouselItem _self;
  final $Res Function(ChapterUpdatesCarouselItem) _then;

/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mangaId = null,Object? chapterId = null,Object? imageUrl = null,Object? title = null,Object? subtitle = freezed,Object? publishDate = freezed,Object? metadata = freezed,Object? contentRating = freezed,}) {
  return _then(ChapterUpdatesCarouselItem(
mangaId: null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,chapterId: null == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,publishDate: freezed == publishDate ? _self.publishDate : publishDate // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,contentRating: freezed == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ProminentCarouselItem implements DiscoverSectionItem {
  const ProminentCarouselItem({required this.mangaId, required this.imageUrl, required this.title, this.subtitle, this.metadata, @NullableContentRatingParser() this.contentRating, final  String? $type}): $type = $type ?? 'prominentCarouselItem';
  factory ProminentCarouselItem.fromJson(Map<String, dynamic> json) => _$ProminentCarouselItemFromJson(json);

 final  String mangaId;
 final  String imageUrl;
 final  String title;
 final  String? subtitle;
@override final  dynamic metadata;
@override@NullableContentRatingParser() final  ContentRating? contentRating;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProminentCarouselItemCopyWith<ProminentCarouselItem> get copyWith => _$ProminentCarouselItemCopyWithImpl<ProminentCarouselItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProminentCarouselItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProminentCarouselItem&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mangaId,imageUrl,title,subtitle,const DeepCollectionEquality().hash(metadata),contentRating);

@override
String toString() {
  return 'DiscoverSectionItem.prominentCarouselItem(mangaId: $mangaId, imageUrl: $imageUrl, title: $title, subtitle: $subtitle, metadata: $metadata, contentRating: $contentRating)';
}


}

/// @nodoc
abstract mixin class $ProminentCarouselItemCopyWith<$Res> implements $DiscoverSectionItemCopyWith<$Res> {
  factory $ProminentCarouselItemCopyWith(ProminentCarouselItem value, $Res Function(ProminentCarouselItem) _then) = _$ProminentCarouselItemCopyWithImpl;
@override @useResult
$Res call({
 String mangaId, String imageUrl, String title, String? subtitle, dynamic metadata,@NullableContentRatingParser() ContentRating? contentRating
});




}
/// @nodoc
class _$ProminentCarouselItemCopyWithImpl<$Res>
    implements $ProminentCarouselItemCopyWith<$Res> {
  _$ProminentCarouselItemCopyWithImpl(this._self, this._then);

  final ProminentCarouselItem _self;
  final $Res Function(ProminentCarouselItem) _then;

/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mangaId = null,Object? imageUrl = null,Object? title = null,Object? subtitle = freezed,Object? metadata = freezed,Object? contentRating = freezed,}) {
  return _then(ProminentCarouselItem(
mangaId: null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,contentRating: freezed == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SimpleCarouselItem implements DiscoverSectionItem {
  const SimpleCarouselItem({required this.mangaId, required this.imageUrl, required this.title, this.subtitle, this.metadata, @NullableContentRatingParser() this.contentRating, final  String? $type}): $type = $type ?? 'simpleCarouselItem';
  factory SimpleCarouselItem.fromJson(Map<String, dynamic> json) => _$SimpleCarouselItemFromJson(json);

 final  String mangaId;
 final  String imageUrl;
 final  String title;
 final  String? subtitle;
@override final  dynamic metadata;
@override@NullableContentRatingParser() final  ContentRating? contentRating;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimpleCarouselItemCopyWith<SimpleCarouselItem> get copyWith => _$SimpleCarouselItemCopyWithImpl<SimpleCarouselItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SimpleCarouselItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleCarouselItem&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mangaId,imageUrl,title,subtitle,const DeepCollectionEquality().hash(metadata),contentRating);

@override
String toString() {
  return 'DiscoverSectionItem.simpleCarouselItem(mangaId: $mangaId, imageUrl: $imageUrl, title: $title, subtitle: $subtitle, metadata: $metadata, contentRating: $contentRating)';
}


}

/// @nodoc
abstract mixin class $SimpleCarouselItemCopyWith<$Res> implements $DiscoverSectionItemCopyWith<$Res> {
  factory $SimpleCarouselItemCopyWith(SimpleCarouselItem value, $Res Function(SimpleCarouselItem) _then) = _$SimpleCarouselItemCopyWithImpl;
@override @useResult
$Res call({
 String mangaId, String imageUrl, String title, String? subtitle, dynamic metadata,@NullableContentRatingParser() ContentRating? contentRating
});




}
/// @nodoc
class _$SimpleCarouselItemCopyWithImpl<$Res>
    implements $SimpleCarouselItemCopyWith<$Res> {
  _$SimpleCarouselItemCopyWithImpl(this._self, this._then);

  final SimpleCarouselItem _self;
  final $Res Function(SimpleCarouselItem) _then;

/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mangaId = null,Object? imageUrl = null,Object? title = null,Object? subtitle = freezed,Object? metadata = freezed,Object? contentRating = freezed,}) {
  return _then(SimpleCarouselItem(
mangaId: null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,contentRating: freezed == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FeaturedCarouselItem implements DiscoverSectionItem {
  const FeaturedCarouselItem({required this.mangaId, required this.imageUrl, required this.title, this.supertitle, this.metadata, @NullableContentRatingParser() this.contentRating, final  String? $type}): $type = $type ?? 'featuredCarouselItem';
  factory FeaturedCarouselItem.fromJson(Map<String, dynamic> json) => _$FeaturedCarouselItemFromJson(json);

 final  String mangaId;
 final  String imageUrl;
 final  String title;
 final  String? supertitle;
@override final  dynamic metadata;
@override@NullableContentRatingParser() final  ContentRating? contentRating;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeaturedCarouselItemCopyWith<FeaturedCarouselItem> get copyWith => _$FeaturedCarouselItemCopyWithImpl<FeaturedCarouselItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeaturedCarouselItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeaturedCarouselItem&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.supertitle, supertitle) || other.supertitle == supertitle)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mangaId,imageUrl,title,supertitle,const DeepCollectionEquality().hash(metadata),contentRating);

@override
String toString() {
  return 'DiscoverSectionItem.featuredCarouselItem(mangaId: $mangaId, imageUrl: $imageUrl, title: $title, supertitle: $supertitle, metadata: $metadata, contentRating: $contentRating)';
}


}

/// @nodoc
abstract mixin class $FeaturedCarouselItemCopyWith<$Res> implements $DiscoverSectionItemCopyWith<$Res> {
  factory $FeaturedCarouselItemCopyWith(FeaturedCarouselItem value, $Res Function(FeaturedCarouselItem) _then) = _$FeaturedCarouselItemCopyWithImpl;
@override @useResult
$Res call({
 String mangaId, String imageUrl, String title, String? supertitle, dynamic metadata,@NullableContentRatingParser() ContentRating? contentRating
});




}
/// @nodoc
class _$FeaturedCarouselItemCopyWithImpl<$Res>
    implements $FeaturedCarouselItemCopyWith<$Res> {
  _$FeaturedCarouselItemCopyWithImpl(this._self, this._then);

  final FeaturedCarouselItem _self;
  final $Res Function(FeaturedCarouselItem) _then;

/// Create a copy of DiscoverSectionItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mangaId = null,Object? imageUrl = null,Object? title = null,Object? supertitle = freezed,Object? metadata = freezed,Object? contentRating = freezed,}) {
  return _then(FeaturedCarouselItem(
mangaId: null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,supertitle: freezed == supertitle ? _self.supertitle : supertitle // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,contentRating: freezed == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating?,
  ));
}


}


/// @nodoc
mixin _$SelectRowOption {

 String get id; String get title;
/// Create a copy of SelectRowOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectRowOptionCopyWith<SelectRowOption> get copyWith => _$SelectRowOptionCopyWithImpl<SelectRowOption>(this as SelectRowOption, _$identity);

  /// Serializes this SelectRowOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectRowOption&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'SelectRowOption(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class $SelectRowOptionCopyWith<$Res>  {
  factory $SelectRowOptionCopyWith(SelectRowOption value, $Res Function(SelectRowOption) _then) = _$SelectRowOptionCopyWithImpl;
@useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class _$SelectRowOptionCopyWithImpl<$Res>
    implements $SelectRowOptionCopyWith<$Res> {
  _$SelectRowOptionCopyWithImpl(this._self, this._then);

  final SelectRowOption _self;
  final $Res Function(SelectRowOption) _then;

/// Create a copy of SelectRowOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SelectRowOption implements SelectRowOption {
  const _SelectRowOption({required this.id, required this.title});
  factory _SelectRowOption.fromJson(Map<String, dynamic> json) => _$SelectRowOptionFromJson(json);

@override final  String id;
@override final  String title;

/// Create a copy of SelectRowOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectRowOptionCopyWith<_SelectRowOption> get copyWith => __$SelectRowOptionCopyWithImpl<_SelectRowOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectRowOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectRowOption&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'SelectRowOption(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class _$SelectRowOptionCopyWith<$Res> implements $SelectRowOptionCopyWith<$Res> {
  factory _$SelectRowOptionCopyWith(_SelectRowOption value, $Res Function(_SelectRowOption) _then) = __$SelectRowOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class __$SelectRowOptionCopyWithImpl<$Res>
    implements _$SelectRowOptionCopyWith<$Res> {
  __$SelectRowOptionCopyWithImpl(this._self, this._then);

  final _SelectRowOption _self;
  final $Res Function(_SelectRowOption) _then;

/// Create a copy of SelectRowOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,}) {
  return _then(_SelectRowOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

FormItemElement _$FormItemElementFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'labelRow':
          return LabelRowElement.fromJson(
            json
          );
                case 'inputRow':
          return InputRowElement.fromJson(
            json
          );
                case 'toggleRow':
          return ToggleRowElement.fromJson(
            json
          );
                case 'selectRow':
          return SelectRowElement.fromJson(
            json
          );
                case 'buttonRow':
          return ButtonRowElement.fromJson(
            json
          );
                case 'navigationRow':
          return NavigationRowElement.fromJson(
            json
          );
                case 'oauthButtonRow':
          return OAuthButtonRowElement.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'FormItemElement',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$FormItemElement {

 String get id; bool get isHidden; String get title;
/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormItemElementCopyWith<FormItemElement> get copyWith => _$FormItemElementCopyWithImpl<FormItemElement>(this as FormItemElement, _$identity);

  /// Serializes this FormItemElement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormItemElement&&(identical(other.id, id) || other.id == id)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isHidden,title);

@override
String toString() {
  return 'FormItemElement(id: $id, isHidden: $isHidden, title: $title)';
}


}

/// @nodoc
abstract mixin class $FormItemElementCopyWith<$Res>  {
  factory $FormItemElementCopyWith(FormItemElement value, $Res Function(FormItemElement) _then) = _$FormItemElementCopyWithImpl;
@useResult
$Res call({
 String id, bool isHidden, String title
});




}
/// @nodoc
class _$FormItemElementCopyWithImpl<$Res>
    implements $FormItemElementCopyWith<$Res> {
  _$FormItemElementCopyWithImpl(this._self, this._then);

  final FormItemElement _self;
  final $Res Function(FormItemElement) _then;

/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? isHidden = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class LabelRowElement implements FormItemElement {
  const LabelRowElement({required this.id, required this.isHidden, required this.title, this.subtitle, this.value, final  String? $type}): $type = $type ?? 'labelRow';
  factory LabelRowElement.fromJson(Map<String, dynamic> json) => _$LabelRowElementFromJson(json);

@override final  String id;
@override final  bool isHidden;
@override final  String title;
 final  String? subtitle;
 final  String? value;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelRowElementCopyWith<LabelRowElement> get copyWith => _$LabelRowElementCopyWithImpl<LabelRowElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LabelRowElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelRowElement&&(identical(other.id, id) || other.id == id)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isHidden,title,subtitle,value);

@override
String toString() {
  return 'FormItemElement.labelRow(id: $id, isHidden: $isHidden, title: $title, subtitle: $subtitle, value: $value)';
}


}

/// @nodoc
abstract mixin class $LabelRowElementCopyWith<$Res> implements $FormItemElementCopyWith<$Res> {
  factory $LabelRowElementCopyWith(LabelRowElement value, $Res Function(LabelRowElement) _then) = _$LabelRowElementCopyWithImpl;
@override @useResult
$Res call({
 String id, bool isHidden, String title, String? subtitle, String? value
});




}
/// @nodoc
class _$LabelRowElementCopyWithImpl<$Res>
    implements $LabelRowElementCopyWith<$Res> {
  _$LabelRowElementCopyWithImpl(this._self, this._then);

  final LabelRowElement _self;
  final $Res Function(LabelRowElement) _then;

/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isHidden = null,Object? title = null,Object? subtitle = freezed,Object? value = freezed,}) {
  return _then(LabelRowElement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class InputRowElement implements FormItemElement {
  const InputRowElement({required this.id, required this.isHidden, required this.title, required this.value, required this.onValueChange, final  String? $type}): $type = $type ?? 'inputRow';
  factory InputRowElement.fromJson(Map<String, dynamic> json) => _$InputRowElementFromJson(json);

@override final  String id;
@override final  bool isHidden;
@override final  String title;
 final  String value;
 final  SelectorID onValueChange;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputRowElementCopyWith<InputRowElement> get copyWith => _$InputRowElementCopyWithImpl<InputRowElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InputRowElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputRowElement&&(identical(other.id, id) || other.id == id)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.title, title) || other.title == title)&&(identical(other.value, value) || other.value == value)&&(identical(other.onValueChange, onValueChange) || other.onValueChange == onValueChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isHidden,title,value,onValueChange);

@override
String toString() {
  return 'FormItemElement.inputRow(id: $id, isHidden: $isHidden, title: $title, value: $value, onValueChange: $onValueChange)';
}


}

/// @nodoc
abstract mixin class $InputRowElementCopyWith<$Res> implements $FormItemElementCopyWith<$Res> {
  factory $InputRowElementCopyWith(InputRowElement value, $Res Function(InputRowElement) _then) = _$InputRowElementCopyWithImpl;
@override @useResult
$Res call({
 String id, bool isHidden, String title, String value, SelectorID onValueChange
});




}
/// @nodoc
class _$InputRowElementCopyWithImpl<$Res>
    implements $InputRowElementCopyWith<$Res> {
  _$InputRowElementCopyWithImpl(this._self, this._then);

  final InputRowElement _self;
  final $Res Function(InputRowElement) _then;

/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isHidden = null,Object? title = null,Object? value = null,Object? onValueChange = null,}) {
  return _then(InputRowElement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,onValueChange: null == onValueChange ? _self.onValueChange : onValueChange // ignore: cast_nullable_to_non_nullable
as SelectorID,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ToggleRowElement implements FormItemElement {
  const ToggleRowElement({required this.id, required this.isHidden, required this.title, required this.value, required this.onValueChange, final  String? $type}): $type = $type ?? 'toggleRow';
  factory ToggleRowElement.fromJson(Map<String, dynamic> json) => _$ToggleRowElementFromJson(json);

@override final  String id;
@override final  bool isHidden;
@override final  String title;
 final  bool value;
 final  SelectorID onValueChange;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleRowElementCopyWith<ToggleRowElement> get copyWith => _$ToggleRowElementCopyWithImpl<ToggleRowElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToggleRowElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleRowElement&&(identical(other.id, id) || other.id == id)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.title, title) || other.title == title)&&(identical(other.value, value) || other.value == value)&&(identical(other.onValueChange, onValueChange) || other.onValueChange == onValueChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isHidden,title,value,onValueChange);

@override
String toString() {
  return 'FormItemElement.toggleRow(id: $id, isHidden: $isHidden, title: $title, value: $value, onValueChange: $onValueChange)';
}


}

/// @nodoc
abstract mixin class $ToggleRowElementCopyWith<$Res> implements $FormItemElementCopyWith<$Res> {
  factory $ToggleRowElementCopyWith(ToggleRowElement value, $Res Function(ToggleRowElement) _then) = _$ToggleRowElementCopyWithImpl;
@override @useResult
$Res call({
 String id, bool isHidden, String title, bool value, SelectorID onValueChange
});




}
/// @nodoc
class _$ToggleRowElementCopyWithImpl<$Res>
    implements $ToggleRowElementCopyWith<$Res> {
  _$ToggleRowElementCopyWithImpl(this._self, this._then);

  final ToggleRowElement _self;
  final $Res Function(ToggleRowElement) _then;

/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isHidden = null,Object? title = null,Object? value = null,Object? onValueChange = null,}) {
  return _then(ToggleRowElement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,onValueChange: null == onValueChange ? _self.onValueChange : onValueChange // ignore: cast_nullable_to_non_nullable
as SelectorID,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SelectRowElement implements FormItemElement {
  const SelectRowElement({required this.id, required this.isHidden, required this.title, this.subtitle, required final  List<String> value, required this.minItemCount, this.maxItemCount, required final  List<SelectRowOption> options, required this.onValueChange, final  String? $type}): _value = value,_options = options,$type = $type ?? 'selectRow';
  factory SelectRowElement.fromJson(Map<String, dynamic> json) => _$SelectRowElementFromJson(json);

@override final  String id;
@override final  bool isHidden;
@override final  String title;
 final  String? subtitle;
 final  List<String> _value;
 List<String> get value {
  if (_value is EqualUnmodifiableListView) return _value;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_value);
}

 final  int minItemCount;
 final  int? maxItemCount;
 final  List<SelectRowOption> _options;
 List<SelectRowOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

 final  SelectorID onValueChange;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectRowElementCopyWith<SelectRowElement> get copyWith => _$SelectRowElementCopyWithImpl<SelectRowElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectRowElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectRowElement&&(identical(other.id, id) || other.id == id)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other._value, _value)&&(identical(other.minItemCount, minItemCount) || other.minItemCount == minItemCount)&&(identical(other.maxItemCount, maxItemCount) || other.maxItemCount == maxItemCount)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.onValueChange, onValueChange) || other.onValueChange == onValueChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isHidden,title,subtitle,const DeepCollectionEquality().hash(_value),minItemCount,maxItemCount,const DeepCollectionEquality().hash(_options),onValueChange);

@override
String toString() {
  return 'FormItemElement.selectRow(id: $id, isHidden: $isHidden, title: $title, subtitle: $subtitle, value: $value, minItemCount: $minItemCount, maxItemCount: $maxItemCount, options: $options, onValueChange: $onValueChange)';
}


}

/// @nodoc
abstract mixin class $SelectRowElementCopyWith<$Res> implements $FormItemElementCopyWith<$Res> {
  factory $SelectRowElementCopyWith(SelectRowElement value, $Res Function(SelectRowElement) _then) = _$SelectRowElementCopyWithImpl;
@override @useResult
$Res call({
 String id, bool isHidden, String title, String? subtitle, List<String> value, int minItemCount, int? maxItemCount, List<SelectRowOption> options, SelectorID onValueChange
});




}
/// @nodoc
class _$SelectRowElementCopyWithImpl<$Res>
    implements $SelectRowElementCopyWith<$Res> {
  _$SelectRowElementCopyWithImpl(this._self, this._then);

  final SelectRowElement _self;
  final $Res Function(SelectRowElement) _then;

/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isHidden = null,Object? title = null,Object? subtitle = freezed,Object? value = null,Object? minItemCount = null,Object? maxItemCount = freezed,Object? options = null,Object? onValueChange = null,}) {
  return _then(SelectRowElement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,value: null == value ? _self._value : value // ignore: cast_nullable_to_non_nullable
as List<String>,minItemCount: null == minItemCount ? _self.minItemCount : minItemCount // ignore: cast_nullable_to_non_nullable
as int,maxItemCount: freezed == maxItemCount ? _self.maxItemCount : maxItemCount // ignore: cast_nullable_to_non_nullable
as int?,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<SelectRowOption>,onValueChange: null == onValueChange ? _self.onValueChange : onValueChange // ignore: cast_nullable_to_non_nullable
as SelectorID,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ButtonRowElement implements FormItemElement {
  const ButtonRowElement({required this.id, required this.isHidden, required this.title, required this.onSelect, final  String? $type}): $type = $type ?? 'buttonRow';
  factory ButtonRowElement.fromJson(Map<String, dynamic> json) => _$ButtonRowElementFromJson(json);

@override final  String id;
@override final  bool isHidden;
@override final  String title;
 final  SelectorID onSelect;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonRowElementCopyWith<ButtonRowElement> get copyWith => _$ButtonRowElementCopyWithImpl<ButtonRowElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ButtonRowElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonRowElement&&(identical(other.id, id) || other.id == id)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.title, title) || other.title == title)&&(identical(other.onSelect, onSelect) || other.onSelect == onSelect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isHidden,title,onSelect);

@override
String toString() {
  return 'FormItemElement.buttonRow(id: $id, isHidden: $isHidden, title: $title, onSelect: $onSelect)';
}


}

/// @nodoc
abstract mixin class $ButtonRowElementCopyWith<$Res> implements $FormItemElementCopyWith<$Res> {
  factory $ButtonRowElementCopyWith(ButtonRowElement value, $Res Function(ButtonRowElement) _then) = _$ButtonRowElementCopyWithImpl;
@override @useResult
$Res call({
 String id, bool isHidden, String title, SelectorID onSelect
});




}
/// @nodoc
class _$ButtonRowElementCopyWithImpl<$Res>
    implements $ButtonRowElementCopyWith<$Res> {
  _$ButtonRowElementCopyWithImpl(this._self, this._then);

  final ButtonRowElement _self;
  final $Res Function(ButtonRowElement) _then;

/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isHidden = null,Object? title = null,Object? onSelect = null,}) {
  return _then(ButtonRowElement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,onSelect: null == onSelect ? _self.onSelect : onSelect // ignore: cast_nullable_to_non_nullable
as SelectorID,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NavigationRowElement implements FormItemElement {
  const NavigationRowElement({required this.id, required this.isHidden, required this.title, this.subtitle, this.value, required this.form, final  String? $type}): $type = $type ?? 'navigationRow';
  factory NavigationRowElement.fromJson(Map<String, dynamic> json) => _$NavigationRowElementFromJson(json);

@override final  String id;
@override final  bool isHidden;
@override final  String title;
 final  String? subtitle;
 final  String? value;
 final  FormID form;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationRowElementCopyWith<NavigationRowElement> get copyWith => _$NavigationRowElementCopyWithImpl<NavigationRowElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NavigationRowElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationRowElement&&(identical(other.id, id) || other.id == id)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.value, value) || other.value == value)&&(identical(other.form, form) || other.form == form));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isHidden,title,subtitle,value,form);

@override
String toString() {
  return 'FormItemElement.navigationRow(id: $id, isHidden: $isHidden, title: $title, subtitle: $subtitle, value: $value, form: $form)';
}


}

/// @nodoc
abstract mixin class $NavigationRowElementCopyWith<$Res> implements $FormItemElementCopyWith<$Res> {
  factory $NavigationRowElementCopyWith(NavigationRowElement value, $Res Function(NavigationRowElement) _then) = _$NavigationRowElementCopyWithImpl;
@override @useResult
$Res call({
 String id, bool isHidden, String title, String? subtitle, String? value, FormID form
});




}
/// @nodoc
class _$NavigationRowElementCopyWithImpl<$Res>
    implements $NavigationRowElementCopyWith<$Res> {
  _$NavigationRowElementCopyWithImpl(this._self, this._then);

  final NavigationRowElement _self;
  final $Res Function(NavigationRowElement) _then;

/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isHidden = null,Object? title = null,Object? subtitle = freezed,Object? value = freezed,Object? form = null,}) {
  return _then(NavigationRowElement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,form: null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as FormID,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OAuthButtonRowElement implements FormItemElement {
  const OAuthButtonRowElement({required this.id, required this.isHidden, required this.title, this.subtitle, required this.onSuccess, required this.authorizeEndpoint, required this.responseType, this.clientId, this.redirectUri, final  List<String>? scopes, final  String? $type}): _scopes = scopes,$type = $type ?? 'oauthButtonRow';
  factory OAuthButtonRowElement.fromJson(Map<String, dynamic> json) => _$OAuthButtonRowElementFromJson(json);

@override final  String id;
@override final  bool isHidden;
@override final  String title;
 final  String? subtitle;
 final  SelectorID onSuccess;
// (refreshToken: string, accessToken: string) => Promise<void>
 final  String authorizeEndpoint;
 final  OAuthResponseType responseType;
 final  String? clientId;
 final  String? redirectUri;
 final  List<String>? _scopes;
 List<String>? get scopes {
  final value = _scopes;
  if (value == null) return null;
  if (_scopes is EqualUnmodifiableListView) return _scopes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthButtonRowElementCopyWith<OAuthButtonRowElement> get copyWith => _$OAuthButtonRowElementCopyWithImpl<OAuthButtonRowElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthButtonRowElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthButtonRowElement&&(identical(other.id, id) || other.id == id)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.authorizeEndpoint, authorizeEndpoint) || other.authorizeEndpoint == authorizeEndpoint)&&(identical(other.responseType, responseType) || other.responseType == responseType)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.redirectUri, redirectUri) || other.redirectUri == redirectUri)&&const DeepCollectionEquality().equals(other._scopes, _scopes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isHidden,title,subtitle,onSuccess,authorizeEndpoint,responseType,clientId,redirectUri,const DeepCollectionEquality().hash(_scopes));

@override
String toString() {
  return 'FormItemElement.oauthButtonRow(id: $id, isHidden: $isHidden, title: $title, subtitle: $subtitle, onSuccess: $onSuccess, authorizeEndpoint: $authorizeEndpoint, responseType: $responseType, clientId: $clientId, redirectUri: $redirectUri, scopes: $scopes)';
}


}

/// @nodoc
abstract mixin class $OAuthButtonRowElementCopyWith<$Res> implements $FormItemElementCopyWith<$Res> {
  factory $OAuthButtonRowElementCopyWith(OAuthButtonRowElement value, $Res Function(OAuthButtonRowElement) _then) = _$OAuthButtonRowElementCopyWithImpl;
@override @useResult
$Res call({
 String id, bool isHidden, String title, String? subtitle, SelectorID onSuccess, String authorizeEndpoint, OAuthResponseType responseType, String? clientId, String? redirectUri, List<String>? scopes
});


$OAuthResponseTypeCopyWith<$Res> get responseType;

}
/// @nodoc
class _$OAuthButtonRowElementCopyWithImpl<$Res>
    implements $OAuthButtonRowElementCopyWith<$Res> {
  _$OAuthButtonRowElementCopyWithImpl(this._self, this._then);

  final OAuthButtonRowElement _self;
  final $Res Function(OAuthButtonRowElement) _then;

/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isHidden = null,Object? title = null,Object? subtitle = freezed,Object? onSuccess = null,Object? authorizeEndpoint = null,Object? responseType = null,Object? clientId = freezed,Object? redirectUri = freezed,Object? scopes = freezed,}) {
  return _then(OAuthButtonRowElement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as SelectorID,authorizeEndpoint: null == authorizeEndpoint ? _self.authorizeEndpoint : authorizeEndpoint // ignore: cast_nullable_to_non_nullable
as String,responseType: null == responseType ? _self.responseType : responseType // ignore: cast_nullable_to_non_nullable
as OAuthResponseType,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,redirectUri: freezed == redirectUri ? _self.redirectUri : redirectUri // ignore: cast_nullable_to_non_nullable
as String?,scopes: freezed == scopes ? _self._scopes : scopes // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

/// Create a copy of FormItemElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OAuthResponseTypeCopyWith<$Res> get responseType {
  
  return $OAuthResponseTypeCopyWith<$Res>(_self.responseType, (value) {
    return _then(_self.copyWith(responseType: value));
  });
}
}


/// @nodoc
mixin _$FormSectionElement {

 String get id; String? get header; String? get footer; List<FormItemElement> get items;
/// Create a copy of FormSectionElement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormSectionElementCopyWith<FormSectionElement> get copyWith => _$FormSectionElementCopyWithImpl<FormSectionElement>(this as FormSectionElement, _$identity);

  /// Serializes this FormSectionElement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormSectionElement&&(identical(other.id, id) || other.id == id)&&(identical(other.header, header) || other.header == header)&&(identical(other.footer, footer) || other.footer == footer)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,header,footer,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'FormSectionElement(id: $id, header: $header, footer: $footer, items: $items)';
}


}

/// @nodoc
abstract mixin class $FormSectionElementCopyWith<$Res>  {
  factory $FormSectionElementCopyWith(FormSectionElement value, $Res Function(FormSectionElement) _then) = _$FormSectionElementCopyWithImpl;
@useResult
$Res call({
 String id, String? header, String? footer, List<FormItemElement> items
});




}
/// @nodoc
class _$FormSectionElementCopyWithImpl<$Res>
    implements $FormSectionElementCopyWith<$Res> {
  _$FormSectionElementCopyWithImpl(this._self, this._then);

  final FormSectionElement _self;
  final $Res Function(FormSectionElement) _then;

/// Create a copy of FormSectionElement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? header = freezed,Object? footer = freezed,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,header: freezed == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as String?,footer: freezed == footer ? _self.footer : footer // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<FormItemElement>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FormSectionElement implements FormSectionElement {
  const _FormSectionElement({required this.id, this.header, this.footer, required final  List<FormItemElement> items}): _items = items;
  factory _FormSectionElement.fromJson(Map<String, dynamic> json) => _$FormSectionElementFromJson(json);

@override final  String id;
@override final  String? header;
@override final  String? footer;
 final  List<FormItemElement> _items;
@override List<FormItemElement> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of FormSectionElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormSectionElementCopyWith<_FormSectionElement> get copyWith => __$FormSectionElementCopyWithImpl<_FormSectionElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormSectionElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormSectionElement&&(identical(other.id, id) || other.id == id)&&(identical(other.header, header) || other.header == header)&&(identical(other.footer, footer) || other.footer == footer)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,header,footer,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'FormSectionElement(id: $id, header: $header, footer: $footer, items: $items)';
}


}

/// @nodoc
abstract mixin class _$FormSectionElementCopyWith<$Res> implements $FormSectionElementCopyWith<$Res> {
  factory _$FormSectionElementCopyWith(_FormSectionElement value, $Res Function(_FormSectionElement) _then) = __$FormSectionElementCopyWithImpl;
@override @useResult
$Res call({
 String id, String? header, String? footer, List<FormItemElement> items
});




}
/// @nodoc
class __$FormSectionElementCopyWithImpl<$Res>
    implements _$FormSectionElementCopyWith<$Res> {
  __$FormSectionElementCopyWithImpl(this._self, this._then);

  final _FormSectionElement _self;
  final $Res Function(_FormSectionElement) _then;

/// Create a copy of FormSectionElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? header = freezed,Object? footer = freezed,Object? items = null,}) {
  return _then(_FormSectionElement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,header: freezed == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as String?,footer: freezed == footer ? _self.footer : footer // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<FormItemElement>,
  ));
}


}


/// @nodoc
mixin _$FilterOption {

 String get id; String get value;
/// Create a copy of FilterOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterOptionCopyWith<FilterOption> get copyWith => _$FilterOptionCopyWithImpl<FilterOption>(this as FilterOption, _$identity);

  /// Serializes this FilterOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterOption&&(identical(other.id, id) || other.id == id)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,value);

@override
String toString() {
  return 'FilterOption(id: $id, value: $value)';
}


}

/// @nodoc
abstract mixin class $FilterOptionCopyWith<$Res>  {
  factory $FilterOptionCopyWith(FilterOption value, $Res Function(FilterOption) _then) = _$FilterOptionCopyWithImpl;
@useResult
$Res call({
 String id, String value
});




}
/// @nodoc
class _$FilterOptionCopyWithImpl<$Res>
    implements $FilterOptionCopyWith<$Res> {
  _$FilterOptionCopyWithImpl(this._self, this._then);

  final FilterOption _self;
  final $Res Function(FilterOption) _then;

/// Create a copy of FilterOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? value = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FilterOption implements FilterOption {
  const _FilterOption({required this.id, required this.value});
  factory _FilterOption.fromJson(Map<String, dynamic> json) => _$FilterOptionFromJson(json);

@override final  String id;
@override final  String value;

/// Create a copy of FilterOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterOptionCopyWith<_FilterOption> get copyWith => __$FilterOptionCopyWithImpl<_FilterOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FilterOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterOption&&(identical(other.id, id) || other.id == id)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,value);

@override
String toString() {
  return 'FilterOption(id: $id, value: $value)';
}


}

/// @nodoc
abstract mixin class _$FilterOptionCopyWith<$Res> implements $FilterOptionCopyWith<$Res> {
  factory _$FilterOptionCopyWith(_FilterOption value, $Res Function(_FilterOption) _then) = __$FilterOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String value
});




}
/// @nodoc
class __$FilterOptionCopyWithImpl<$Res>
    implements _$FilterOptionCopyWith<$Res> {
  __$FilterOptionCopyWithImpl(this._self, this._then);

  final _FilterOption _self;
  final $Res Function(_FilterOption) _then;

/// Create a copy of FilterOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? value = null,}) {
  return _then(_FilterOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

SearchFilter _$SearchFilterFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'dropdown':
          return DropdownSearchFilter.fromJson(
            json
          );
                case 'multiselect':
          return SelectSearchFilter.fromJson(
            json
          );
                case 'tags':
          return TagSearchFilter.fromJson(
            json
          );
                case 'input':
          return InputSearchFilter.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'SearchFilter',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$SearchFilter {

 String get id; String get title; Object get value;
/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFilterCopyWith<SearchFilter> get copyWith => _$SearchFilterCopyWithImpl<SearchFilter>(this as SearchFilter, _$identity);

  /// Serializes this SearchFilter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFilter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'SearchFilter(id: $id, title: $title, value: $value)';
}


}

/// @nodoc
abstract mixin class $SearchFilterCopyWith<$Res>  {
  factory $SearchFilterCopyWith(SearchFilter value, $Res Function(SearchFilter) _then) = _$SearchFilterCopyWithImpl;
@useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class _$SearchFilterCopyWithImpl<$Res>
    implements $SearchFilterCopyWith<$Res> {
  _$SearchFilterCopyWithImpl(this._self, this._then);

  final SearchFilter _self;
  final $Res Function(SearchFilter) _then;

/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class DropdownSearchFilter implements SearchFilter {
  const DropdownSearchFilter({required this.id, required this.title, required final  List<FilterOption> options, required this.value, final  String? $type}): _options = options,$type = $type ?? 'dropdown';
  factory DropdownSearchFilter.fromJson(Map<String, dynamic> json) => _$DropdownSearchFilterFromJson(json);

@override final  String id;
@override final  String title;
 final  List<FilterOption> _options;
 List<FilterOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  String value;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DropdownSearchFilterCopyWith<DropdownSearchFilter> get copyWith => _$DropdownSearchFilterCopyWithImpl<DropdownSearchFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DropdownSearchFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DropdownSearchFilter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_options),value);

@override
String toString() {
  return 'SearchFilter.dropdown(id: $id, title: $title, options: $options, value: $value)';
}


}

/// @nodoc
abstract mixin class $DropdownSearchFilterCopyWith<$Res> implements $SearchFilterCopyWith<$Res> {
  factory $DropdownSearchFilterCopyWith(DropdownSearchFilter value, $Res Function(DropdownSearchFilter) _then) = _$DropdownSearchFilterCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<FilterOption> options, String value
});




}
/// @nodoc
class _$DropdownSearchFilterCopyWithImpl<$Res>
    implements $DropdownSearchFilterCopyWith<$Res> {
  _$DropdownSearchFilterCopyWithImpl(this._self, this._then);

  final DropdownSearchFilter _self;
  final $Res Function(DropdownSearchFilter) _then;

/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? options = null,Object? value = null,}) {
  return _then(DropdownSearchFilter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<FilterOption>,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SelectSearchFilter implements SearchFilter {
  const SelectSearchFilter({required this.id, required this.title, required final  List<FilterOption> options, required final  Map<String, String> value, required this.allowExclusion, required this.allowEmptySelection, this.maximum, final  String? $type}): _options = options,_value = value,$type = $type ?? 'multiselect';
  factory SelectSearchFilter.fromJson(Map<String, dynamic> json) => _$SelectSearchFilterFromJson(json);

@override final  String id;
@override final  String title;
 final  List<FilterOption> _options;
 List<FilterOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

 final  Map<String, String> _value;
@override Map<String, String> get value {
  if (_value is EqualUnmodifiableMapView) return _value;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_value);
}

 final  bool allowExclusion;
 final  bool allowEmptySelection;
 final  num? maximum;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectSearchFilterCopyWith<SelectSearchFilter> get copyWith => _$SelectSearchFilterCopyWithImpl<SelectSearchFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectSearchFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectSearchFilter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._value, _value)&&(identical(other.allowExclusion, allowExclusion) || other.allowExclusion == allowExclusion)&&(identical(other.allowEmptySelection, allowEmptySelection) || other.allowEmptySelection == allowEmptySelection)&&(identical(other.maximum, maximum) || other.maximum == maximum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_value),allowExclusion,allowEmptySelection,maximum);

@override
String toString() {
  return 'SearchFilter.multiselect(id: $id, title: $title, options: $options, value: $value, allowExclusion: $allowExclusion, allowEmptySelection: $allowEmptySelection, maximum: $maximum)';
}


}

/// @nodoc
abstract mixin class $SelectSearchFilterCopyWith<$Res> implements $SearchFilterCopyWith<$Res> {
  factory $SelectSearchFilterCopyWith(SelectSearchFilter value, $Res Function(SelectSearchFilter) _then) = _$SelectSearchFilterCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<FilterOption> options, Map<String, String> value, bool allowExclusion, bool allowEmptySelection, num? maximum
});




}
/// @nodoc
class _$SelectSearchFilterCopyWithImpl<$Res>
    implements $SelectSearchFilterCopyWith<$Res> {
  _$SelectSearchFilterCopyWithImpl(this._self, this._then);

  final SelectSearchFilter _self;
  final $Res Function(SelectSearchFilter) _then;

/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? options = null,Object? value = null,Object? allowExclusion = null,Object? allowEmptySelection = null,Object? maximum = freezed,}) {
  return _then(SelectSearchFilter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<FilterOption>,value: null == value ? _self._value : value // ignore: cast_nullable_to_non_nullable
as Map<String, String>,allowExclusion: null == allowExclusion ? _self.allowExclusion : allowExclusion // ignore: cast_nullable_to_non_nullable
as bool,allowEmptySelection: null == allowEmptySelection ? _self.allowEmptySelection : allowEmptySelection // ignore: cast_nullable_to_non_nullable
as bool,maximum: freezed == maximum ? _self.maximum : maximum // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TagSearchFilter implements SearchFilter {
  const TagSearchFilter({required this.id, required this.title, required final  List<TagSection> sections, required final  Map<String, Map<String, String>> value, required this.allowExclusion, required this.allowEmptySelection, this.maximum, final  String? $type}): _sections = sections,_value = value,$type = $type ?? 'tags';
  factory TagSearchFilter.fromJson(Map<String, dynamic> json) => _$TagSearchFilterFromJson(json);

@override final  String id;
@override final  String title;
 final  List<TagSection> _sections;
 List<TagSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

 final  Map<String, Map<String, String>> _value;
@override Map<String, Map<String, String>> get value {
  if (_value is EqualUnmodifiableMapView) return _value;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_value);
}

 final  bool allowExclusion;
 final  bool allowEmptySelection;
 final  num? maximum;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagSearchFilterCopyWith<TagSearchFilter> get copyWith => _$TagSearchFilterCopyWithImpl<TagSearchFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TagSearchFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagSearchFilter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._sections, _sections)&&const DeepCollectionEquality().equals(other._value, _value)&&(identical(other.allowExclusion, allowExclusion) || other.allowExclusion == allowExclusion)&&(identical(other.allowEmptySelection, allowEmptySelection) || other.allowEmptySelection == allowEmptySelection)&&(identical(other.maximum, maximum) || other.maximum == maximum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_sections),const DeepCollectionEquality().hash(_value),allowExclusion,allowEmptySelection,maximum);

@override
String toString() {
  return 'SearchFilter.tags(id: $id, title: $title, sections: $sections, value: $value, allowExclusion: $allowExclusion, allowEmptySelection: $allowEmptySelection, maximum: $maximum)';
}


}

/// @nodoc
abstract mixin class $TagSearchFilterCopyWith<$Res> implements $SearchFilterCopyWith<$Res> {
  factory $TagSearchFilterCopyWith(TagSearchFilter value, $Res Function(TagSearchFilter) _then) = _$TagSearchFilterCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<TagSection> sections, Map<String, Map<String, String>> value, bool allowExclusion, bool allowEmptySelection, num? maximum
});




}
/// @nodoc
class _$TagSearchFilterCopyWithImpl<$Res>
    implements $TagSearchFilterCopyWith<$Res> {
  _$TagSearchFilterCopyWithImpl(this._self, this._then);

  final TagSearchFilter _self;
  final $Res Function(TagSearchFilter) _then;

/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? sections = null,Object? value = null,Object? allowExclusion = null,Object? allowEmptySelection = null,Object? maximum = freezed,}) {
  return _then(TagSearchFilter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<TagSection>,value: null == value ? _self._value : value // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, String>>,allowExclusion: null == allowExclusion ? _self.allowExclusion : allowExclusion // ignore: cast_nullable_to_non_nullable
as bool,allowEmptySelection: null == allowEmptySelection ? _self.allowEmptySelection : allowEmptySelection // ignore: cast_nullable_to_non_nullable
as bool,maximum: freezed == maximum ? _self.maximum : maximum // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class InputSearchFilter implements SearchFilter {
  const InputSearchFilter({required this.id, required this.title, required this.placeholder, required this.value, final  String? $type}): $type = $type ?? 'input';
  factory InputSearchFilter.fromJson(Map<String, dynamic> json) => _$InputSearchFilterFromJson(json);

@override final  String id;
@override final  String title;
 final  String placeholder;
@override final  String value;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputSearchFilterCopyWith<InputSearchFilter> get copyWith => _$InputSearchFilterCopyWithImpl<InputSearchFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InputSearchFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputSearchFilter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.placeholder, placeholder) || other.placeholder == placeholder)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,placeholder,value);

@override
String toString() {
  return 'SearchFilter.input(id: $id, title: $title, placeholder: $placeholder, value: $value)';
}


}

/// @nodoc
abstract mixin class $InputSearchFilterCopyWith<$Res> implements $SearchFilterCopyWith<$Res> {
  factory $InputSearchFilterCopyWith(InputSearchFilter value, $Res Function(InputSearchFilter) _then) = _$InputSearchFilterCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String placeholder, String value
});




}
/// @nodoc
class _$InputSearchFilterCopyWithImpl<$Res>
    implements $InputSearchFilterCopyWith<$Res> {
  _$InputSearchFilterCopyWithImpl(this._self, this._then);

  final InputSearchFilter _self;
  final $Res Function(InputSearchFilter) _then;

/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? placeholder = null,Object? value = null,}) {
  return _then(InputSearchFilter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,placeholder: null == placeholder ? _self.placeholder : placeholder // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SearchFilterValue {

 String get id; Object get value;
/// Create a copy of SearchFilterValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFilterValueCopyWith<SearchFilterValue> get copyWith => _$SearchFilterValueCopyWithImpl<SearchFilterValue>(this as SearchFilterValue, _$identity);

  /// Serializes this SearchFilterValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFilterValue&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'SearchFilterValue(id: $id, value: $value)';
}


}

/// @nodoc
abstract mixin class $SearchFilterValueCopyWith<$Res>  {
  factory $SearchFilterValueCopyWith(SearchFilterValue value, $Res Function(SearchFilterValue) _then) = _$SearchFilterValueCopyWithImpl;
@useResult
$Res call({
 String id, Object value
});




}
/// @nodoc
class _$SearchFilterValueCopyWithImpl<$Res>
    implements $SearchFilterValueCopyWith<$Res> {
  _$SearchFilterValueCopyWithImpl(this._self, this._then);

  final SearchFilterValue _self;
  final $Res Function(SearchFilterValue) _then;

/// Create a copy of SearchFilterValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? value = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value ,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SearchFilterValue extends SearchFilterValue {
  const _SearchFilterValue({required this.id, required this.value}): super._();
  factory _SearchFilterValue.fromJson(Map<String, dynamic> json) => _$SearchFilterValueFromJson(json);

@override final  String id;
@override final  Object value;

/// Create a copy of SearchFilterValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchFilterValueCopyWith<_SearchFilterValue> get copyWith => __$SearchFilterValueCopyWithImpl<_SearchFilterValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchFilterValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchFilterValue&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'SearchFilterValue(id: $id, value: $value)';
}


}

/// @nodoc
abstract mixin class _$SearchFilterValueCopyWith<$Res> implements $SearchFilterValueCopyWith<$Res> {
  factory _$SearchFilterValueCopyWith(_SearchFilterValue value, $Res Function(_SearchFilterValue) _then) = __$SearchFilterValueCopyWithImpl;
@override @useResult
$Res call({
 String id, Object value
});




}
/// @nodoc
class __$SearchFilterValueCopyWithImpl<$Res>
    implements _$SearchFilterValueCopyWith<$Res> {
  __$SearchFilterValueCopyWithImpl(this._self, this._then);

  final _SearchFilterValue _self;
  final $Res Function(_SearchFilterValue) _then;

/// Create a copy of SearchFilterValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? value = null,}) {
  return _then(_SearchFilterValue(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value ,
  ));
}


}

// dart format on
