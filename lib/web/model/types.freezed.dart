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

 SourceType get type; String get source; String get location; String? get chapter; WebSourceInfo? get parser;
/// Create a copy of SourceHandler
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceHandlerCopyWith<SourceHandler> get copyWith => _$SourceHandlerCopyWithImpl<SourceHandler>(this as SourceHandler, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceHandler&&(identical(other.type, type) || other.type == type)&&(identical(other.source, source) || other.source == source)&&(identical(other.location, location) || other.location == location)&&(identical(other.chapter, chapter) || other.chapter == chapter)&&(identical(other.parser, parser) || other.parser == parser));
}


@override
int get hashCode => Object.hash(runtimeType,type,source,location,chapter,parser);

@override
String toString() {
  return 'SourceHandler(type: $type, source: $source, location: $location, chapter: $chapter, parser: $parser)';
}


}

/// @nodoc
abstract mixin class $SourceHandlerCopyWith<$Res>  {
  factory $SourceHandlerCopyWith(SourceHandler value, $Res Function(SourceHandler) _then) = _$SourceHandlerCopyWithImpl;
@useResult
$Res call({
 SourceType type, String source, String location, String? chapter, WebSourceInfo? parser
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
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? source = null,Object? location = null,Object? chapter = freezed,Object? parser = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SourceType,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
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


class _SourceHandler extends SourceHandler {
  const _SourceHandler({required this.type, required this.source, required this.location, this.chapter, this.parser}): super._();
  

@override final  SourceType type;
@override final  String source;
@override final  String location;
@override final  String? chapter;
@override final  WebSourceInfo? parser;

/// Create a copy of SourceHandler
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceHandlerCopyWith<_SourceHandler> get copyWith => __$SourceHandlerCopyWithImpl<_SourceHandler>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceHandler&&(identical(other.type, type) || other.type == type)&&(identical(other.source, source) || other.source == source)&&(identical(other.location, location) || other.location == location)&&(identical(other.chapter, chapter) || other.chapter == chapter)&&(identical(other.parser, parser) || other.parser == parser));
}


@override
int get hashCode => Object.hash(runtimeType,type,source,location,chapter,parser);

@override
String toString() {
  return 'SourceHandler(type: $type, source: $source, location: $location, chapter: $chapter, parser: $parser)';
}


}

/// @nodoc
abstract mixin class _$SourceHandlerCopyWith<$Res> implements $SourceHandlerCopyWith<$Res> {
  factory _$SourceHandlerCopyWith(_SourceHandler value, $Res Function(_SourceHandler) _then) = __$SourceHandlerCopyWithImpl;
@override @useResult
$Res call({
 SourceType type, String source, String location, String? chapter, WebSourceInfo? parser
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
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? source = null,Object? location = null,Object? chapter = freezed,Object? parser = freezed,}) {
  return _then(_SourceHandler(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SourceType,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
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
mixin _$HistoryLink {

 String get title; String get url; String? get cover;
/// Create a copy of HistoryLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryLinkCopyWith<HistoryLink> get copyWith => _$HistoryLinkCopyWithImpl<HistoryLink>(this as HistoryLink, _$identity);

  /// Serializes this HistoryLink to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'HistoryLink(title: $title, url: $url, cover: $cover)';
}


}

/// @nodoc
abstract mixin class $HistoryLinkCopyWith<$Res>  {
  factory $HistoryLinkCopyWith(HistoryLink value, $Res Function(HistoryLink) _then) = _$HistoryLinkCopyWithImpl;
@useResult
$Res call({
 String title, String url, String? cover
});




}
/// @nodoc
class _$HistoryLinkCopyWithImpl<$Res>
    implements $HistoryLinkCopyWith<$Res> {
  _$HistoryLinkCopyWithImpl(this._self, this._then);

  final HistoryLink _self;
  final $Res Function(HistoryLink) _then;

/// Create a copy of HistoryLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? url = null,Object? cover = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _HistoryLink extends HistoryLink {
  const _HistoryLink({required this.title, required this.url, this.cover}): super._();
  factory _HistoryLink.fromJson(Map<String, dynamic> json) => _$HistoryLinkFromJson(json);

@override final  String title;
@override final  String url;
@override final  String? cover;

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
  return 'HistoryLink(title: $title, url: $url, cover: $cover)';
}


}

/// @nodoc
abstract mixin class _$HistoryLinkCopyWith<$Res> implements $HistoryLinkCopyWith<$Res> {
  factory _$HistoryLinkCopyWith(_HistoryLink value, $Res Function(_HistoryLink) _then) = __$HistoryLinkCopyWithImpl;
@override @useResult
$Res call({
 String title, String url, String? cover
});




}
/// @nodoc
class __$HistoryLinkCopyWithImpl<$Res>
    implements _$HistoryLinkCopyWith<$Res> {
  __$HistoryLinkCopyWithImpl(this._self, this._then);

  final _HistoryLink _self;
  final $Res Function(_HistoryLink) _then;

/// Create a copy of HistoryLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? url = null,Object? cover = freezed,}) {
  return _then(_HistoryLink(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WebManga {

 String get title; String get description; String get artist; String get author; String get cover; Map<String, String>? get groups; Map<String, WebChapter> get chapters;
/// Create a copy of WebManga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebMangaCopyWith<WebManga> get copyWith => _$WebMangaCopyWithImpl<WebManga>(this as WebManga, _$identity);

  /// Serializes this WebManga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebManga&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.author, author) || other.author == author)&&(identical(other.cover, cover) || other.cover == cover)&&const DeepCollectionEquality().equals(other.groups, groups)&&const DeepCollectionEquality().equals(other.chapters, chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,artist,author,cover,const DeepCollectionEquality().hash(groups),const DeepCollectionEquality().hash(chapters));

@override
String toString() {
  return 'WebManga(title: $title, description: $description, artist: $artist, author: $author, cover: $cover, groups: $groups, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class $WebMangaCopyWith<$Res>  {
  factory $WebMangaCopyWith(WebManga value, $Res Function(WebManga) _then) = _$WebMangaCopyWithImpl;
@useResult
$Res call({
 String title, String description, String artist, String author, String cover, Map<String, String>? groups, Map<String, WebChapter> chapters
});




}
/// @nodoc
class _$WebMangaCopyWithImpl<$Res>
    implements $WebMangaCopyWith<$Res> {
  _$WebMangaCopyWithImpl(this._self, this._then);

  final WebManga _self;
  final $Res Function(WebManga) _then;

/// Create a copy of WebManga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? artist = null,Object? author = null,Object? cover = null,Object? groups = freezed,Object? chapters = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,groups: freezed == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as Map<String, WebChapter>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _WebManga extends WebManga {
  const _WebManga({required this.title, required this.description, required this.artist, required this.author, required this.cover, final  Map<String, String>? groups, required final  Map<String, WebChapter> chapters}): _groups = groups,_chapters = chapters,super._();
  factory _WebManga.fromJson(Map<String, dynamic> json) => _$WebMangaFromJson(json);

@override final  String title;
@override final  String description;
@override final  String artist;
@override final  String author;
@override final  String cover;
 final  Map<String, String>? _groups;
@override Map<String, String>? get groups {
  final value = _groups;
  if (value == null) return null;
  if (_groups is EqualUnmodifiableMapView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, WebChapter> _chapters;
@override Map<String, WebChapter> get chapters {
  if (_chapters is EqualUnmodifiableMapView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_chapters);
}


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
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebManga&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.author, author) || other.author == author)&&(identical(other.cover, cover) || other.cover == cover)&&const DeepCollectionEquality().equals(other._groups, _groups)&&const DeepCollectionEquality().equals(other._chapters, _chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,artist,author,cover,const DeepCollectionEquality().hash(_groups),const DeepCollectionEquality().hash(_chapters));

@override
String toString() {
  return 'WebManga(title: $title, description: $description, artist: $artist, author: $author, cover: $cover, groups: $groups, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class _$WebMangaCopyWith<$Res> implements $WebMangaCopyWith<$Res> {
  factory _$WebMangaCopyWith(_WebManga value, $Res Function(_WebManga) _then) = __$WebMangaCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String artist, String author, String cover, Map<String, String>? groups, Map<String, WebChapter> chapters
});




}
/// @nodoc
class __$WebMangaCopyWithImpl<$Res>
    implements _$WebMangaCopyWith<$Res> {
  __$WebMangaCopyWithImpl(this._self, this._then);

  final _WebManga _self;
  final $Res Function(_WebManga) _then;

/// Create a copy of WebManga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? artist = null,Object? author = null,Object? cover = null,Object? groups = freezed,Object? chapters = null,}) {
  return _then(_WebManga(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,groups: freezed == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as Map<String, WebChapter>,
  ));
}


}


/// @nodoc
mixin _$WebChapter {

 String? get title; String? get volume;@EpochTimestampSerializer() DateTime? get lastUpdated;@MappedEpochTimestampSerializer() DateTime? get releaseDate; Map<String, dynamic> get groups;
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
 String? title, String? volume,@EpochTimestampSerializer() DateTime? lastUpdated,@MappedEpochTimestampSerializer() DateTime? releaseDate, Map<String, dynamic> groups
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
  const _WebChapter({this.title, this.volume, @EpochTimestampSerializer() this.lastUpdated, @MappedEpochTimestampSerializer() this.releaseDate, required final  Map<String, dynamic> groups}): _groups = groups,super._();
  factory _WebChapter.fromJson(Map<String, dynamic> json) => _$WebChapterFromJson(json);

@override final  String? title;
@override final  String? volume;
@override@EpochTimestampSerializer() final  DateTime? lastUpdated;
@override@MappedEpochTimestampSerializer() final  DateTime? releaseDate;
 final  Map<String, dynamic> _groups;
@override Map<String, dynamic> get groups {
  if (_groups is EqualUnmodifiableMapView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_groups);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebChapter&&(identical(other.title, title) || other.title == title)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&const DeepCollectionEquality().equals(other._groups, _groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,volume,lastUpdated,releaseDate,const DeepCollectionEquality().hash(_groups));

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
 String? title, String? volume,@EpochTimestampSerializer() DateTime? lastUpdated,@MappedEpochTimestampSerializer() DateTime? releaseDate, Map<String, dynamic> groups
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
as DateTime?,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
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

 String get id; String get name; String get repo; String? get icon;
/// Create a copy of WebSourceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebSourceInfoCopyWith<WebSourceInfo> get copyWith => _$WebSourceInfoCopyWithImpl<WebSourceInfo>(this as WebSourceInfo, _$identity);

  /// Serializes this WebSourceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebSourceInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.repo, repo) || other.repo == repo)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,repo,icon);

@override
String toString() {
  return 'WebSourceInfo(id: $id, name: $name, repo: $repo, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $WebSourceInfoCopyWith<$Res>  {
  factory $WebSourceInfoCopyWith(WebSourceInfo value, $Res Function(WebSourceInfo) _then) = _$WebSourceInfoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String repo, String? icon
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? repo = null,Object? icon = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _WebSourceInfo implements WebSourceInfo {
  const _WebSourceInfo({required this.id, required this.name, required this.repo, this.icon});
  factory _WebSourceInfo.fromJson(Map<String, dynamic> json) => _$WebSourceInfoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String repo;
@override final  String? icon;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebSourceInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.repo, repo) || other.repo == repo)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,repo,icon);

@override
String toString() {
  return 'WebSourceInfo(id: $id, name: $name, repo: $repo, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$WebSourceInfoCopyWith<$Res> implements $WebSourceInfoCopyWith<$Res> {
  factory _$WebSourceInfoCopyWith(_WebSourceInfo value, $Res Function(_WebSourceInfo) _then) = __$WebSourceInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String repo, String? icon
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? repo = null,Object? icon = freezed,}) {
  return _then(_WebSourceInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SourceIdentifier {

 WebSourceInfo get internal; SourceInfo get external;
/// Create a copy of SourceIdentifier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceIdentifierCopyWith<SourceIdentifier> get copyWith => _$SourceIdentifierCopyWithImpl<SourceIdentifier>(this as SourceIdentifier, _$identity);

  /// Serializes this SourceIdentifier to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceIdentifier&&(identical(other.internal, internal) || other.internal == internal)&&(identical(other.external, external) || other.external == external));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,internal,external);

@override
String toString() {
  return 'SourceIdentifier(internal: $internal, external: $external)';
}


}

/// @nodoc
abstract mixin class $SourceIdentifierCopyWith<$Res>  {
  factory $SourceIdentifierCopyWith(SourceIdentifier value, $Res Function(SourceIdentifier) _then) = _$SourceIdentifierCopyWithImpl;
@useResult
$Res call({
 WebSourceInfo internal, SourceInfo external
});


$WebSourceInfoCopyWith<$Res> get internal;$SourceInfoCopyWith<$Res> get external;

}
/// @nodoc
class _$SourceIdentifierCopyWithImpl<$Res>
    implements $SourceIdentifierCopyWith<$Res> {
  _$SourceIdentifierCopyWithImpl(this._self, this._then);

  final SourceIdentifier _self;
  final $Res Function(SourceIdentifier) _then;

/// Create a copy of SourceIdentifier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? internal = null,Object? external = null,}) {
  return _then(_self.copyWith(
internal: null == internal ? _self.internal : internal // ignore: cast_nullable_to_non_nullable
as WebSourceInfo,external: null == external ? _self.external : external // ignore: cast_nullable_to_non_nullable
as SourceInfo,
  ));
}
/// Create a copy of SourceIdentifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WebSourceInfoCopyWith<$Res> get internal {
  
  return $WebSourceInfoCopyWith<$Res>(_self.internal, (value) {
    return _then(_self.copyWith(internal: value));
  });
}/// Create a copy of SourceIdentifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourceInfoCopyWith<$Res> get external {
  
  return $SourceInfoCopyWith<$Res>(_self.external, (value) {
    return _then(_self.copyWith(external: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _SourceIdentifier implements SourceIdentifier {
  const _SourceIdentifier({required this.internal, required this.external});
  factory _SourceIdentifier.fromJson(Map<String, dynamic> json) => _$SourceIdentifierFromJson(json);

@override final  WebSourceInfo internal;
@override final  SourceInfo external;

/// Create a copy of SourceIdentifier
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceIdentifierCopyWith<_SourceIdentifier> get copyWith => __$SourceIdentifierCopyWithImpl<_SourceIdentifier>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourceIdentifierToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceIdentifier&&(identical(other.internal, internal) || other.internal == internal)&&(identical(other.external, external) || other.external == external));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,internal,external);

@override
String toString() {
  return 'SourceIdentifier(internal: $internal, external: $external)';
}


}

/// @nodoc
abstract mixin class _$SourceIdentifierCopyWith<$Res> implements $SourceIdentifierCopyWith<$Res> {
  factory _$SourceIdentifierCopyWith(_SourceIdentifier value, $Res Function(_SourceIdentifier) _then) = __$SourceIdentifierCopyWithImpl;
@override @useResult
$Res call({
 WebSourceInfo internal, SourceInfo external
});


@override $WebSourceInfoCopyWith<$Res> get internal;@override $SourceInfoCopyWith<$Res> get external;

}
/// @nodoc
class __$SourceIdentifierCopyWithImpl<$Res>
    implements _$SourceIdentifierCopyWith<$Res> {
  __$SourceIdentifierCopyWithImpl(this._self, this._then);

  final _SourceIdentifier _self;
  final $Res Function(_SourceIdentifier) _then;

/// Create a copy of SourceIdentifier
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? internal = null,Object? external = null,}) {
  return _then(_SourceIdentifier(
internal: null == internal ? _self.internal : internal // ignore: cast_nullable_to_non_nullable
as WebSourceInfo,external: null == external ? _self.external : external // ignore: cast_nullable_to_non_nullable
as SourceInfo,
  ));
}

/// Create a copy of SourceIdentifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WebSourceInfoCopyWith<$Res> get internal {
  
  return $WebSourceInfoCopyWith<$Res>(_self.internal, (value) {
    return _then(_self.copyWith(internal: value));
  });
}/// Create a copy of SourceIdentifier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourceInfoCopyWith<$Res> get external {
  
  return $SourceInfoCopyWith<$Res>(_self.external, (value) {
    return _then(_self.copyWith(external: value));
  });
}
}


/// @nodoc
mixin _$Badge {

 String get text;@BadgeColorParser() BadgeColor get type;
/// Create a copy of Badge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BadgeCopyWith<Badge> get copyWith => _$BadgeCopyWithImpl<Badge>(this as Badge, _$identity);

  /// Serializes this Badge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Badge&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,type);

@override
String toString() {
  return 'Badge(text: $text, type: $type)';
}


}

/// @nodoc
abstract mixin class $BadgeCopyWith<$Res>  {
  factory $BadgeCopyWith(Badge value, $Res Function(Badge) _then) = _$BadgeCopyWithImpl;
@useResult
$Res call({
 String text,@BadgeColorParser() BadgeColor type
});




}
/// @nodoc
class _$BadgeCopyWithImpl<$Res>
    implements $BadgeCopyWith<$Res> {
  _$BadgeCopyWithImpl(this._self, this._then);

  final Badge _self;
  final $Res Function(Badge) _then;

/// Create a copy of Badge
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

class _Badge implements Badge {
  const _Badge({required this.text, @BadgeColorParser() required this.type});
  factory _Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);

@override final  String text;
@override@BadgeColorParser() final  BadgeColor type;

/// Create a copy of Badge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BadgeCopyWith<_Badge> get copyWith => __$BadgeCopyWithImpl<_Badge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BadgeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Badge&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,type);

@override
String toString() {
  return 'Badge(text: $text, type: $type)';
}


}

/// @nodoc
abstract mixin class _$BadgeCopyWith<$Res> implements $BadgeCopyWith<$Res> {
  factory _$BadgeCopyWith(_Badge value, $Res Function(_Badge) _then) = __$BadgeCopyWithImpl;
@override @useResult
$Res call({
 String text,@BadgeColorParser() BadgeColor type
});




}
/// @nodoc
class __$BadgeCopyWithImpl<$Res>
    implements _$BadgeCopyWith<$Res> {
  __$BadgeCopyWithImpl(this._self, this._then);

  final _Badge _self;
  final $Res Function(_Badge) _then;

/// Create a copy of Badge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? type = null,}) {
  return _then(_Badge(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BadgeColor,
  ));
}


}


/// @nodoc
mixin _$SourceVersion {

 String get id; String get name; String get author; String get desc; String? get website; ContentRating get contentRating; String get version; String get icon; List<Badge>? get tags; String get websiteBaseURL; int? get intents;
/// Create a copy of SourceVersion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceVersionCopyWith<SourceVersion> get copyWith => _$SourceVersionCopyWithImpl<SourceVersion>(this as SourceVersion, _$identity);

  /// Serializes this SourceVersion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceVersion&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.author, author) || other.author == author)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.website, website) || other.website == website)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&(identical(other.version, version) || other.version == version)&&(identical(other.icon, icon) || other.icon == icon)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.websiteBaseURL, websiteBaseURL) || other.websiteBaseURL == websiteBaseURL)&&(identical(other.intents, intents) || other.intents == intents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,author,desc,website,contentRating,version,icon,const DeepCollectionEquality().hash(tags),websiteBaseURL,intents);

@override
String toString() {
  return 'SourceVersion(id: $id, name: $name, author: $author, desc: $desc, website: $website, contentRating: $contentRating, version: $version, icon: $icon, tags: $tags, websiteBaseURL: $websiteBaseURL, intents: $intents)';
}


}

/// @nodoc
abstract mixin class $SourceVersionCopyWith<$Res>  {
  factory $SourceVersionCopyWith(SourceVersion value, $Res Function(SourceVersion) _then) = _$SourceVersionCopyWithImpl;
@useResult
$Res call({
 String id, String name, String author, String desc, String? website, ContentRating contentRating, String version, String icon, List<Badge>? tags, String websiteBaseURL, int? intents
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? author = null,Object? desc = null,Object? website = freezed,Object? contentRating = null,Object? version = null,Object? icon = null,Object? tags = freezed,Object? websiteBaseURL = null,Object? intents = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<Badge>?,websiteBaseURL: null == websiteBaseURL ? _self.websiteBaseURL : websiteBaseURL // ignore: cast_nullable_to_non_nullable
as String,intents: freezed == intents ? _self.intents : intents // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SourceVersion implements SourceVersion {
  const _SourceVersion({required this.id, required this.name, required this.author, required this.desc, this.website, required this.contentRating, required this.version, required this.icon, final  List<Badge>? tags, required this.websiteBaseURL, this.intents}): _tags = tags;
  factory _SourceVersion.fromJson(Map<String, dynamic> json) => _$SourceVersionFromJson(json);

@override final  String id;
@override final  String name;
@override final  String author;
@override final  String desc;
@override final  String? website;
@override final  ContentRating contentRating;
@override final  String version;
@override final  String icon;
 final  List<Badge>? _tags;
@override List<Badge>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String websiteBaseURL;
@override final  int? intents;

/// Create a copy of SourceVersion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceVersionCopyWith<_SourceVersion> get copyWith => __$SourceVersionCopyWithImpl<_SourceVersion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourceVersionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceVersion&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.author, author) || other.author == author)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.website, website) || other.website == website)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&(identical(other.version, version) || other.version == version)&&(identical(other.icon, icon) || other.icon == icon)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.websiteBaseURL, websiteBaseURL) || other.websiteBaseURL == websiteBaseURL)&&(identical(other.intents, intents) || other.intents == intents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,author,desc,website,contentRating,version,icon,const DeepCollectionEquality().hash(_tags),websiteBaseURL,intents);

@override
String toString() {
  return 'SourceVersion(id: $id, name: $name, author: $author, desc: $desc, website: $website, contentRating: $contentRating, version: $version, icon: $icon, tags: $tags, websiteBaseURL: $websiteBaseURL, intents: $intents)';
}


}

/// @nodoc
abstract mixin class _$SourceVersionCopyWith<$Res> implements $SourceVersionCopyWith<$Res> {
  factory _$SourceVersionCopyWith(_SourceVersion value, $Res Function(_SourceVersion) _then) = __$SourceVersionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String author, String desc, String? website, ContentRating contentRating, String version, String icon, List<Badge>? tags, String websiteBaseURL, int? intents
});




}
/// @nodoc
class __$SourceVersionCopyWithImpl<$Res>
    implements _$SourceVersionCopyWith<$Res> {
  __$SourceVersionCopyWithImpl(this._self, this._then);

  final _SourceVersion _self;
  final $Res Function(_SourceVersion) _then;

/// Create a copy of SourceVersion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? author = null,Object? desc = null,Object? website = freezed,Object? contentRating = null,Object? version = null,Object? icon = null,Object? tags = freezed,Object? websiteBaseURL = null,Object? intents = freezed,}) {
  return _then(_SourceVersion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<Badge>?,websiteBaseURL: null == websiteBaseURL ? _self.websiteBaseURL : websiteBaseURL // ignore: cast_nullable_to_non_nullable
as String,intents: freezed == intents ? _self.intents : intents // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SourceInfo {

 String get name; String get author; String get description; ContentRating get contentRating; String get version; String get icon; String get websiteBaseURL; String? get authorWebsite; String? get language; List<Badge>? get sourceTags; int? get intents;
/// Create a copy of SourceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceInfoCopyWith<SourceInfo> get copyWith => _$SourceInfoCopyWithImpl<SourceInfo>(this as SourceInfo, _$identity);

  /// Serializes this SourceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.author, author) || other.author == author)&&(identical(other.description, description) || other.description == description)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&(identical(other.version, version) || other.version == version)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.websiteBaseURL, websiteBaseURL) || other.websiteBaseURL == websiteBaseURL)&&(identical(other.authorWebsite, authorWebsite) || other.authorWebsite == authorWebsite)&&(identical(other.language, language) || other.language == language)&&const DeepCollectionEquality().equals(other.sourceTags, sourceTags)&&(identical(other.intents, intents) || other.intents == intents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,author,description,contentRating,version,icon,websiteBaseURL,authorWebsite,language,const DeepCollectionEquality().hash(sourceTags),intents);

@override
String toString() {
  return 'SourceInfo(name: $name, author: $author, description: $description, contentRating: $contentRating, version: $version, icon: $icon, websiteBaseURL: $websiteBaseURL, authorWebsite: $authorWebsite, language: $language, sourceTags: $sourceTags, intents: $intents)';
}


}

/// @nodoc
abstract mixin class $SourceInfoCopyWith<$Res>  {
  factory $SourceInfoCopyWith(SourceInfo value, $Res Function(SourceInfo) _then) = _$SourceInfoCopyWithImpl;
@useResult
$Res call({
 String name, String author, String description, ContentRating contentRating, String version, String icon, String websiteBaseURL, String? authorWebsite, String? language, List<Badge>? sourceTags, int? intents
});




}
/// @nodoc
class _$SourceInfoCopyWithImpl<$Res>
    implements $SourceInfoCopyWith<$Res> {
  _$SourceInfoCopyWithImpl(this._self, this._then);

  final SourceInfo _self;
  final $Res Function(SourceInfo) _then;

/// Create a copy of SourceInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? author = null,Object? description = null,Object? contentRating = null,Object? version = null,Object? icon = null,Object? websiteBaseURL = null,Object? authorWebsite = freezed,Object? language = freezed,Object? sourceTags = freezed,Object? intents = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,websiteBaseURL: null == websiteBaseURL ? _self.websiteBaseURL : websiteBaseURL // ignore: cast_nullable_to_non_nullable
as String,authorWebsite: freezed == authorWebsite ? _self.authorWebsite : authorWebsite // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,sourceTags: freezed == sourceTags ? _self.sourceTags : sourceTags // ignore: cast_nullable_to_non_nullable
as List<Badge>?,intents: freezed == intents ? _self.intents : intents // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SourceInfo extends SourceInfo {
  const _SourceInfo({required this.name, required this.author, required this.description, required this.contentRating, required this.version, required this.icon, required this.websiteBaseURL, this.authorWebsite, this.language, final  List<Badge>? sourceTags, this.intents}): _sourceTags = sourceTags,super._();
  factory _SourceInfo.fromJson(Map<String, dynamic> json) => _$SourceInfoFromJson(json);

@override final  String name;
@override final  String author;
@override final  String description;
@override final  ContentRating contentRating;
@override final  String version;
@override final  String icon;
@override final  String websiteBaseURL;
@override final  String? authorWebsite;
@override final  String? language;
 final  List<Badge>? _sourceTags;
@override List<Badge>? get sourceTags {
  final value = _sourceTags;
  if (value == null) return null;
  if (_sourceTags is EqualUnmodifiableListView) return _sourceTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? intents;

/// Create a copy of SourceInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceInfoCopyWith<_SourceInfo> get copyWith => __$SourceInfoCopyWithImpl<_SourceInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourceInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.author, author) || other.author == author)&&(identical(other.description, description) || other.description == description)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&(identical(other.version, version) || other.version == version)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.websiteBaseURL, websiteBaseURL) || other.websiteBaseURL == websiteBaseURL)&&(identical(other.authorWebsite, authorWebsite) || other.authorWebsite == authorWebsite)&&(identical(other.language, language) || other.language == language)&&const DeepCollectionEquality().equals(other._sourceTags, _sourceTags)&&(identical(other.intents, intents) || other.intents == intents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,author,description,contentRating,version,icon,websiteBaseURL,authorWebsite,language,const DeepCollectionEquality().hash(_sourceTags),intents);

@override
String toString() {
  return 'SourceInfo(name: $name, author: $author, description: $description, contentRating: $contentRating, version: $version, icon: $icon, websiteBaseURL: $websiteBaseURL, authorWebsite: $authorWebsite, language: $language, sourceTags: $sourceTags, intents: $intents)';
}


}

/// @nodoc
abstract mixin class _$SourceInfoCopyWith<$Res> implements $SourceInfoCopyWith<$Res> {
  factory _$SourceInfoCopyWith(_SourceInfo value, $Res Function(_SourceInfo) _then) = __$SourceInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, String author, String description, ContentRating contentRating, String version, String icon, String websiteBaseURL, String? authorWebsite, String? language, List<Badge>? sourceTags, int? intents
});




}
/// @nodoc
class __$SourceInfoCopyWithImpl<$Res>
    implements _$SourceInfoCopyWith<$Res> {
  __$SourceInfoCopyWithImpl(this._self, this._then);

  final _SourceInfo _self;
  final $Res Function(_SourceInfo) _then;

/// Create a copy of SourceInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? author = null,Object? description = null,Object? contentRating = null,Object? version = null,Object? icon = null,Object? websiteBaseURL = null,Object? authorWebsite = freezed,Object? language = freezed,Object? sourceTags = freezed,Object? intents = freezed,}) {
  return _then(_SourceInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,websiteBaseURL: null == websiteBaseURL ? _self.websiteBaseURL : websiteBaseURL // ignore: cast_nullable_to_non_nullable
as String,authorWebsite: freezed == authorWebsite ? _self.authorWebsite : authorWebsite // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,sourceTags: freezed == sourceTags ? _self._sourceTags : sourceTags // ignore: cast_nullable_to_non_nullable
as List<Badge>?,intents: freezed == intents ? _self.intents : intents // ignore: cast_nullable_to_non_nullable
as int?,
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

 String get buildTime; List<SourceVersion> get sources; BuiltWith get builtWith;
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
 String buildTime, List<SourceVersion> sources, BuiltWith builtWith
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
as List<SourceVersion>,builtWith: null == builtWith ? _self.builtWith : builtWith // ignore: cast_nullable_to_non_nullable
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
  const _Versioning({required this.buildTime, required final  List<SourceVersion> sources, required this.builtWith}): _sources = sources;
  factory _Versioning.fromJson(Map<String, dynamic> json) => _$VersioningFromJson(json);

@override final  String buildTime;
 final  List<SourceVersion> _sources;
@override List<SourceVersion> get sources {
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
 String buildTime, List<SourceVersion> sources, BuiltWith builtWith
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
as List<SourceVersion>,builtWith: null == builtWith ? _self.builtWith : builtWith // ignore: cast_nullable_to_non_nullable
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

  /// Serializes this RepoInfo to a JSON map.
  Map<String, dynamic> toJson();


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
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RepoInfo implements RepoInfo {
  const _RepoInfo({required this.name, required this.url});
  factory _RepoInfo.fromJson(Map<String, dynamic> json) => _$RepoInfoFromJson(json);

@override final  String name;
@override final  String url;

/// Create a copy of RepoInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RepoInfoCopyWith<_RepoInfo> get copyWith => __$RepoInfoCopyWithImpl<_RepoInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RepoInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RepoInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
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
abstract mixin class _$RepoInfoCopyWith<$Res> implements $RepoInfoCopyWith<$Res> {
  factory _$RepoInfoCopyWith(_RepoInfo value, $Res Function(_RepoInfo) _then) = __$RepoInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, String url
});




}
/// @nodoc
class __$RepoInfoCopyWithImpl<$Res>
    implements _$RepoInfoCopyWith<$Res> {
  __$RepoInfoCopyWithImpl(this._self, this._then);

  final _RepoInfo _self;
  final $Res Function(_RepoInfo) _then;

/// Create a copy of RepoInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? url = null,}) {
  return _then(_RepoInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PartialSourceManga {

 String get mangaId; String get image; String get title; String? get subtitle;
/// Create a copy of PartialSourceManga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartialSourceMangaCopyWith<PartialSourceManga> get copyWith => _$PartialSourceMangaCopyWithImpl<PartialSourceManga>(this as PartialSourceManga, _$identity);

  /// Serializes this PartialSourceManga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartialSourceManga&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId)&&(identical(other.image, image) || other.image == image)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mangaId,image,title,subtitle);

@override
String toString() {
  return 'PartialSourceManga(mangaId: $mangaId, image: $image, title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class $PartialSourceMangaCopyWith<$Res>  {
  factory $PartialSourceMangaCopyWith(PartialSourceManga value, $Res Function(PartialSourceManga) _then) = _$PartialSourceMangaCopyWithImpl;
@useResult
$Res call({
 String mangaId, String image, String title, String? subtitle
});




}
/// @nodoc
class _$PartialSourceMangaCopyWithImpl<$Res>
    implements $PartialSourceMangaCopyWith<$Res> {
  _$PartialSourceMangaCopyWithImpl(this._self, this._then);

  final PartialSourceManga _self;
  final $Res Function(PartialSourceManga) _then;

/// Create a copy of PartialSourceManga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mangaId = null,Object? image = null,Object? title = null,Object? subtitle = freezed,}) {
  return _then(_self.copyWith(
mangaId: null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PartialSourceManga implements PartialSourceManga {
  const _PartialSourceManga({required this.mangaId, required this.image, required this.title, this.subtitle});
  factory _PartialSourceManga.fromJson(Map<String, dynamic> json) => _$PartialSourceMangaFromJson(json);

@override final  String mangaId;
@override final  String image;
@override final  String title;
@override final  String? subtitle;

/// Create a copy of PartialSourceManga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartialSourceMangaCopyWith<_PartialSourceManga> get copyWith => __$PartialSourceMangaCopyWithImpl<_PartialSourceManga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartialSourceMangaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartialSourceManga&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId)&&(identical(other.image, image) || other.image == image)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mangaId,image,title,subtitle);

@override
String toString() {
  return 'PartialSourceManga(mangaId: $mangaId, image: $image, title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class _$PartialSourceMangaCopyWith<$Res> implements $PartialSourceMangaCopyWith<$Res> {
  factory _$PartialSourceMangaCopyWith(_PartialSourceManga value, $Res Function(_PartialSourceManga) _then) = __$PartialSourceMangaCopyWithImpl;
@override @useResult
$Res call({
 String mangaId, String image, String title, String? subtitle
});




}
/// @nodoc
class __$PartialSourceMangaCopyWithImpl<$Res>
    implements _$PartialSourceMangaCopyWith<$Res> {
  __$PartialSourceMangaCopyWithImpl(this._self, this._then);

  final _PartialSourceManga _self;
  final $Res Function(_PartialSourceManga) _then;

/// Create a copy of PartialSourceManga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mangaId = null,Object? image = null,Object? title = null,Object? subtitle = freezed,}) {
  return _then(_PartialSourceManga(
mangaId: null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PagedResults {

 List<PartialSourceManga>? get results; dynamic get metadata;
/// Create a copy of PagedResults
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagedResultsCopyWith<PagedResults> get copyWith => _$PagedResultsCopyWithImpl<PagedResults>(this as PagedResults, _$identity);

  /// Serializes this PagedResults to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagedResults&&const DeepCollectionEquality().equals(other.results, results)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(results),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'PagedResults(results: $results, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $PagedResultsCopyWith<$Res>  {
  factory $PagedResultsCopyWith(PagedResults value, $Res Function(PagedResults) _then) = _$PagedResultsCopyWithImpl;
@useResult
$Res call({
 List<PartialSourceManga>? results, dynamic metadata
});




}
/// @nodoc
class _$PagedResultsCopyWithImpl<$Res>
    implements $PagedResultsCopyWith<$Res> {
  _$PagedResultsCopyWithImpl(this._self, this._then);

  final PagedResults _self;
  final $Res Function(PagedResults) _then;

/// Create a copy of PagedResults
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? results = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
results: freezed == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<PartialSourceManga>?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PagedResults implements PagedResults {
  const _PagedResults({final  List<PartialSourceManga>? results, this.metadata}): _results = results;
  factory _PagedResults.fromJson(Map<String, dynamic> json) => _$PagedResultsFromJson(json);

 final  List<PartialSourceManga>? _results;
@override List<PartialSourceManga>? get results {
  final value = _results;
  if (value == null) return null;
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  dynamic metadata;

/// Create a copy of PagedResults
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagedResultsCopyWith<_PagedResults> get copyWith => __$PagedResultsCopyWithImpl<_PagedResults>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PagedResultsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PagedResults&&const DeepCollectionEquality().equals(other._results, _results)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'PagedResults(results: $results, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$PagedResultsCopyWith<$Res> implements $PagedResultsCopyWith<$Res> {
  factory _$PagedResultsCopyWith(_PagedResults value, $Res Function(_PagedResults) _then) = __$PagedResultsCopyWithImpl;
@override @useResult
$Res call({
 List<PartialSourceManga>? results, dynamic metadata
});




}
/// @nodoc
class __$PagedResultsCopyWithImpl<$Res>
    implements _$PagedResultsCopyWith<$Res> {
  __$PagedResultsCopyWithImpl(this._self, this._then);

  final _PagedResults _self;
  final $Res Function(_PagedResults) _then;

/// Create a copy of PagedResults
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? results = freezed,Object? metadata = freezed,}) {
  return _then(_PagedResults(
results: freezed == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<PartialSourceManga>?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$MangaInfo {

 String get image; String? get artist; String? get author; String get desc; String get status; bool? get hentai; List<String> get titles; String? get banner; num? get rating; List<TagSection>? get tags; List<String>? get covers;
/// Create a copy of MangaInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaInfoCopyWith<MangaInfo> get copyWith => _$MangaInfoCopyWithImpl<MangaInfo>(this as MangaInfo, _$identity);

  /// Serializes this MangaInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MangaInfo&&(identical(other.image, image) || other.image == image)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.author, author) || other.author == author)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.status, status) || other.status == status)&&(identical(other.hentai, hentai) || other.hentai == hentai)&&const DeepCollectionEquality().equals(other.titles, titles)&&(identical(other.banner, banner) || other.banner == banner)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.covers, covers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,image,artist,author,desc,status,hentai,const DeepCollectionEquality().hash(titles),banner,rating,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(covers));

@override
String toString() {
  return 'MangaInfo(image: $image, artist: $artist, author: $author, desc: $desc, status: $status, hentai: $hentai, titles: $titles, banner: $banner, rating: $rating, tags: $tags, covers: $covers)';
}


}

/// @nodoc
abstract mixin class $MangaInfoCopyWith<$Res>  {
  factory $MangaInfoCopyWith(MangaInfo value, $Res Function(MangaInfo) _then) = _$MangaInfoCopyWithImpl;
@useResult
$Res call({
 String image, String? artist, String? author, String desc, String status, bool? hentai, List<String> titles, String? banner, num? rating, List<TagSection>? tags, List<String>? covers
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
@pragma('vm:prefer-inline') @override $Res call({Object? image = null,Object? artist = freezed,Object? author = freezed,Object? desc = null,Object? status = null,Object? hentai = freezed,Object? titles = null,Object? banner = freezed,Object? rating = freezed,Object? tags = freezed,Object? covers = freezed,}) {
  return _then(_self.copyWith(
image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,artist: freezed == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,hentai: freezed == hentai ? _self.hentai : hentai // ignore: cast_nullable_to_non_nullable
as bool?,titles: null == titles ? _self.titles : titles // ignore: cast_nullable_to_non_nullable
as List<String>,banner: freezed == banner ? _self.banner : banner // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as num?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagSection>?,covers: freezed == covers ? _self.covers : covers // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MangaInfo implements MangaInfo {
  const _MangaInfo({required this.image, this.artist, this.author, required this.desc, required this.status, this.hentai, required final  List<String> titles, this.banner, this.rating, final  List<TagSection>? tags, final  List<String>? covers}): _titles = titles,_tags = tags,_covers = covers;
  factory _MangaInfo.fromJson(Map<String, dynamic> json) => _$MangaInfoFromJson(json);

@override final  String image;
@override final  String? artist;
@override final  String? author;
@override final  String desc;
@override final  String status;
@override final  bool? hentai;
 final  List<String> _titles;
@override List<String> get titles {
  if (_titles is EqualUnmodifiableListView) return _titles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_titles);
}

@override final  String? banner;
@override final  num? rating;
 final  List<TagSection>? _tags;
@override List<TagSection>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _covers;
@override List<String>? get covers {
  final value = _covers;
  if (value == null) return null;
  if (_covers is EqualUnmodifiableListView) return _covers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MangaInfo&&(identical(other.image, image) || other.image == image)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.author, author) || other.author == author)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.status, status) || other.status == status)&&(identical(other.hentai, hentai) || other.hentai == hentai)&&const DeepCollectionEquality().equals(other._titles, _titles)&&(identical(other.banner, banner) || other.banner == banner)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._covers, _covers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,image,artist,author,desc,status,hentai,const DeepCollectionEquality().hash(_titles),banner,rating,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_covers));

@override
String toString() {
  return 'MangaInfo(image: $image, artist: $artist, author: $author, desc: $desc, status: $status, hentai: $hentai, titles: $titles, banner: $banner, rating: $rating, tags: $tags, covers: $covers)';
}


}

/// @nodoc
abstract mixin class _$MangaInfoCopyWith<$Res> implements $MangaInfoCopyWith<$Res> {
  factory _$MangaInfoCopyWith(_MangaInfo value, $Res Function(_MangaInfo) _then) = __$MangaInfoCopyWithImpl;
@override @useResult
$Res call({
 String image, String? artist, String? author, String desc, String status, bool? hentai, List<String> titles, String? banner, num? rating, List<TagSection>? tags, List<String>? covers
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
@override @pragma('vm:prefer-inline') $Res call({Object? image = null,Object? artist = freezed,Object? author = freezed,Object? desc = null,Object? status = null,Object? hentai = freezed,Object? titles = null,Object? banner = freezed,Object? rating = freezed,Object? tags = freezed,Object? covers = freezed,}) {
  return _then(_MangaInfo(
image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,artist: freezed == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,hentai: freezed == hentai ? _self.hentai : hentai // ignore: cast_nullable_to_non_nullable
as bool?,titles: null == titles ? _self._titles : titles // ignore: cast_nullable_to_non_nullable
as List<String>,banner: freezed == banner ? _self.banner : banner // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as num?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagSection>?,covers: freezed == covers ? _self._covers : covers // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$Tag {

 String get id; String get label;
/// Create a copy of Tag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagCopyWith<Tag> get copyWith => _$TagCopyWithImpl<Tag>(this as Tag, _$identity);

  /// Serializes this Tag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tag&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'Tag(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class $TagCopyWith<$Res>  {
  factory $TagCopyWith(Tag value, $Res Function(Tag) _then) = _$TagCopyWithImpl;
@useResult
$Res call({
 String id, String label
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Tag implements Tag {
  const _Tag({required this.id, required this.label});
  factory _Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

@override final  String id;
@override final  String label;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tag&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'Tag(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class _$TagCopyWith<$Res> implements $TagCopyWith<$Res> {
  factory _$TagCopyWith(_Tag value, $Res Function(_Tag) _then) = __$TagCopyWithImpl;
@override @useResult
$Res call({
 String id, String label
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(_Tag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TagSection {

 String get id; String get label; List<Tag> get tags;
/// Create a copy of TagSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagSectionCopyWith<TagSection> get copyWith => _$TagSectionCopyWithImpl<TagSection>(this as TagSection, _$identity);

  /// Serializes this TagSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagSection&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'TagSection(id: $id, label: $label, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $TagSectionCopyWith<$Res>  {
  factory $TagSectionCopyWith(TagSection value, $Res Function(TagSection) _then) = _$TagSectionCopyWithImpl;
@useResult
$Res call({
 String id, String label, List<Tag> tags
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TagSection implements TagSection {
  const _TagSection({required this.id, required this.label, required final  List<Tag> tags}): _tags = tags;
  factory _TagSection.fromJson(Map<String, dynamic> json) => _$TagSectionFromJson(json);

@override final  String id;
@override final  String label;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagSection&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'TagSection(id: $id, label: $label, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$TagSectionCopyWith<$Res> implements $TagSectionCopyWith<$Res> {
  factory _$TagSectionCopyWith(_TagSection value, $Res Function(_TagSection) _then) = __$TagSectionCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, List<Tag> tags
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? tags = null,}) {
  return _then(_TagSection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>,
  ));
}


}


/// @nodoc
mixin _$SourceManga {

 String get id; MangaInfo get mangaInfo;
/// Create a copy of SourceManga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceMangaCopyWith<SourceManga> get copyWith => _$SourceMangaCopyWithImpl<SourceManga>(this as SourceManga, _$identity);

  /// Serializes this SourceManga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceManga&&(identical(other.id, id) || other.id == id)&&(identical(other.mangaInfo, mangaInfo) || other.mangaInfo == mangaInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mangaInfo);

@override
String toString() {
  return 'SourceManga(id: $id, mangaInfo: $mangaInfo)';
}


}

/// @nodoc
abstract mixin class $SourceMangaCopyWith<$Res>  {
  factory $SourceMangaCopyWith(SourceManga value, $Res Function(SourceManga) _then) = _$SourceMangaCopyWithImpl;
@useResult
$Res call({
 String id, MangaInfo mangaInfo
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mangaInfo = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
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
  const _SourceManga({required this.id, required this.mangaInfo});
  factory _SourceManga.fromJson(Map<String, dynamic> json) => _$SourceMangaFromJson(json);

@override final  String id;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceManga&&(identical(other.id, id) || other.id == id)&&(identical(other.mangaInfo, mangaInfo) || other.mangaInfo == mangaInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mangaInfo);

@override
String toString() {
  return 'SourceManga(id: $id, mangaInfo: $mangaInfo)';
}


}

/// @nodoc
abstract mixin class _$SourceMangaCopyWith<$Res> implements $SourceMangaCopyWith<$Res> {
  factory _$SourceMangaCopyWith(_SourceManga value, $Res Function(_SourceManga) _then) = __$SourceMangaCopyWithImpl;
@override @useResult
$Res call({
 String id, MangaInfo mangaInfo
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mangaInfo = null,}) {
  return _then(_SourceManga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
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
mixin _$Chapter {

 String get id; num get chapNum; String? get langCode; String? get name; num? get volume; String? get group;@TimestampSerializer() DateTime? get time; num? get sortingIndex;
/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterCopyWith<Chapter> get copyWith => _$ChapterCopyWithImpl<Chapter>(this as Chapter, _$identity);

  /// Serializes this Chapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Chapter&&(identical(other.id, id) || other.id == id)&&(identical(other.chapNum, chapNum) || other.chapNum == chapNum)&&(identical(other.langCode, langCode) || other.langCode == langCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.group, group) || other.group == group)&&(identical(other.time, time) || other.time == time)&&(identical(other.sortingIndex, sortingIndex) || other.sortingIndex == sortingIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chapNum,langCode,name,volume,group,time,sortingIndex);

@override
String toString() {
  return 'Chapter(id: $id, chapNum: $chapNum, langCode: $langCode, name: $name, volume: $volume, group: $group, time: $time, sortingIndex: $sortingIndex)';
}


}

/// @nodoc
abstract mixin class $ChapterCopyWith<$Res>  {
  factory $ChapterCopyWith(Chapter value, $Res Function(Chapter) _then) = _$ChapterCopyWithImpl;
@useResult
$Res call({
 String id, num chapNum, String? langCode, String? name, num? volume, String? group,@TimestampSerializer() DateTime? time, num? sortingIndex
});




}
/// @nodoc
class _$ChapterCopyWithImpl<$Res>
    implements $ChapterCopyWith<$Res> {
  _$ChapterCopyWithImpl(this._self, this._then);

  final Chapter _self;
  final $Res Function(Chapter) _then;

/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? chapNum = null,Object? langCode = freezed,Object? name = freezed,Object? volume = freezed,Object? group = freezed,Object? time = freezed,Object? sortingIndex = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chapNum: null == chapNum ? _self.chapNum : chapNum // ignore: cast_nullable_to_non_nullable
as num,langCode: freezed == langCode ? _self.langCode : langCode // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as num?,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime?,sortingIndex: freezed == sortingIndex ? _self.sortingIndex : sortingIndex // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Chapter implements Chapter {
  const _Chapter({required this.id, required this.chapNum, this.langCode, this.name, this.volume, this.group, @TimestampSerializer() this.time, this.sortingIndex});
  factory _Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);

@override final  String id;
@override final  num chapNum;
@override final  String? langCode;
@override final  String? name;
@override final  num? volume;
@override final  String? group;
@override@TimestampSerializer() final  DateTime? time;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Chapter&&(identical(other.id, id) || other.id == id)&&(identical(other.chapNum, chapNum) || other.chapNum == chapNum)&&(identical(other.langCode, langCode) || other.langCode == langCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.group, group) || other.group == group)&&(identical(other.time, time) || other.time == time)&&(identical(other.sortingIndex, sortingIndex) || other.sortingIndex == sortingIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chapNum,langCode,name,volume,group,time,sortingIndex);

@override
String toString() {
  return 'Chapter(id: $id, chapNum: $chapNum, langCode: $langCode, name: $name, volume: $volume, group: $group, time: $time, sortingIndex: $sortingIndex)';
}


}

/// @nodoc
abstract mixin class _$ChapterCopyWith<$Res> implements $ChapterCopyWith<$Res> {
  factory _$ChapterCopyWith(_Chapter value, $Res Function(_Chapter) _then) = __$ChapterCopyWithImpl;
@override @useResult
$Res call({
 String id, num chapNum, String? langCode, String? name, num? volume, String? group,@TimestampSerializer() DateTime? time, num? sortingIndex
});




}
/// @nodoc
class __$ChapterCopyWithImpl<$Res>
    implements _$ChapterCopyWith<$Res> {
  __$ChapterCopyWithImpl(this._self, this._then);

  final _Chapter _self;
  final $Res Function(_Chapter) _then;

/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? chapNum = null,Object? langCode = freezed,Object? name = freezed,Object? volume = freezed,Object? group = freezed,Object? time = freezed,Object? sortingIndex = freezed,}) {
  return _then(_Chapter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chapNum: null == chapNum ? _self.chapNum : chapNum // ignore: cast_nullable_to_non_nullable
as num,langCode: freezed == langCode ? _self.langCode : langCode // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as num?,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime?,sortingIndex: freezed == sortingIndex ? _self.sortingIndex : sortingIndex // ignore: cast_nullable_to_non_nullable
as num?,
  ));
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
mixin _$SearchRequest {

 String? get title; List<Tag>? get includedTags; List<Tag>? get excludedTags;
/// Create a copy of SearchRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchRequestCopyWith<SearchRequest> get copyWith => _$SearchRequestCopyWithImpl<SearchRequest>(this as SearchRequest, _$identity);

  /// Serializes this SearchRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchRequest&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.includedTags, includedTags)&&const DeepCollectionEquality().equals(other.excludedTags, excludedTags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(includedTags),const DeepCollectionEquality().hash(excludedTags));

@override
String toString() {
  return 'SearchRequest(title: $title, includedTags: $includedTags, excludedTags: $excludedTags)';
}


}

/// @nodoc
abstract mixin class $SearchRequestCopyWith<$Res>  {
  factory $SearchRequestCopyWith(SearchRequest value, $Res Function(SearchRequest) _then) = _$SearchRequestCopyWithImpl;
@useResult
$Res call({
 String? title, List<Tag>? includedTags, List<Tag>? excludedTags
});




}
/// @nodoc
class _$SearchRequestCopyWithImpl<$Res>
    implements $SearchRequestCopyWith<$Res> {
  _$SearchRequestCopyWithImpl(this._self, this._then);

  final SearchRequest _self;
  final $Res Function(SearchRequest) _then;

/// Create a copy of SearchRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? includedTags = freezed,Object? excludedTags = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,includedTags: freezed == includedTags ? _self.includedTags : includedTags // ignore: cast_nullable_to_non_nullable
as List<Tag>?,excludedTags: freezed == excludedTags ? _self.excludedTags : excludedTags // ignore: cast_nullable_to_non_nullable
as List<Tag>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SearchRequest implements SearchRequest {
  const _SearchRequest({this.title, final  List<Tag>? includedTags, final  List<Tag>? excludedTags}): _includedTags = includedTags,_excludedTags = excludedTags;
  factory _SearchRequest.fromJson(Map<String, dynamic> json) => _$SearchRequestFromJson(json);

@override final  String? title;
 final  List<Tag>? _includedTags;
@override List<Tag>? get includedTags {
  final value = _includedTags;
  if (value == null) return null;
  if (_includedTags is EqualUnmodifiableListView) return _includedTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Tag>? _excludedTags;
@override List<Tag>? get excludedTags {
  final value = _excludedTags;
  if (value == null) return null;
  if (_excludedTags is EqualUnmodifiableListView) return _excludedTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SearchRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchRequestCopyWith<_SearchRequest> get copyWith => __$SearchRequestCopyWithImpl<_SearchRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchRequest&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._includedTags, _includedTags)&&const DeepCollectionEquality().equals(other._excludedTags, _excludedTags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_includedTags),const DeepCollectionEquality().hash(_excludedTags));

@override
String toString() {
  return 'SearchRequest(title: $title, includedTags: $includedTags, excludedTags: $excludedTags)';
}


}

/// @nodoc
abstract mixin class _$SearchRequestCopyWith<$Res> implements $SearchRequestCopyWith<$Res> {
  factory _$SearchRequestCopyWith(_SearchRequest value, $Res Function(_SearchRequest) _then) = __$SearchRequestCopyWithImpl;
@override @useResult
$Res call({
 String? title, List<Tag>? includedTags, List<Tag>? excludedTags
});




}
/// @nodoc
class __$SearchRequestCopyWithImpl<$Res>
    implements _$SearchRequestCopyWith<$Res> {
  __$SearchRequestCopyWithImpl(this._self, this._then);

  final _SearchRequest _self;
  final $Res Function(_SearchRequest) _then;

/// Create a copy of SearchRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? includedTags = freezed,Object? excludedTags = freezed,}) {
  return _then(_SearchRequest(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,includedTags: freezed == includedTags ? _self._includedTags : includedTags // ignore: cast_nullable_to_non_nullable
as List<Tag>?,excludedTags: freezed == excludedTags ? _self._excludedTags : excludedTags // ignore: cast_nullable_to_non_nullable
as List<Tag>?,
  ));
}


}


/// @nodoc
mixin _$HomeSection {

 String get id; String get title; List<PartialSourceManga> get items; bool get containsMoreItems;
/// Create a copy of HomeSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSectionCopyWith<HomeSection> get copyWith => _$HomeSectionCopyWithImpl<HomeSection>(this as HomeSection, _$identity);

  /// Serializes this HomeSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.containsMoreItems, containsMoreItems) || other.containsMoreItems == containsMoreItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(items),containsMoreItems);

@override
String toString() {
  return 'HomeSection(id: $id, title: $title, items: $items, containsMoreItems: $containsMoreItems)';
}


}

/// @nodoc
abstract mixin class $HomeSectionCopyWith<$Res>  {
  factory $HomeSectionCopyWith(HomeSection value, $Res Function(HomeSection) _then) = _$HomeSectionCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<PartialSourceManga> items, bool containsMoreItems
});




}
/// @nodoc
class _$HomeSectionCopyWithImpl<$Res>
    implements $HomeSectionCopyWith<$Res> {
  _$HomeSectionCopyWithImpl(this._self, this._then);

  final HomeSection _self;
  final $Res Function(HomeSection) _then;

/// Create a copy of HomeSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? items = null,Object? containsMoreItems = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PartialSourceManga>,containsMoreItems: null == containsMoreItems ? _self.containsMoreItems : containsMoreItems // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _HomeSection implements HomeSection {
  const _HomeSection({required this.id, required this.title, required final  List<PartialSourceManga> items, required this.containsMoreItems}): _items = items;
  factory _HomeSection.fromJson(Map<String, dynamic> json) => _$HomeSectionFromJson(json);

@override final  String id;
@override final  String title;
 final  List<PartialSourceManga> _items;
@override List<PartialSourceManga> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  bool containsMoreItems;

/// Create a copy of HomeSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSectionCopyWith<_HomeSection> get copyWith => __$HomeSectionCopyWithImpl<_HomeSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.containsMoreItems, containsMoreItems) || other.containsMoreItems == containsMoreItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_items),containsMoreItems);

@override
String toString() {
  return 'HomeSection(id: $id, title: $title, items: $items, containsMoreItems: $containsMoreItems)';
}


}

/// @nodoc
abstract mixin class _$HomeSectionCopyWith<$Res> implements $HomeSectionCopyWith<$Res> {
  factory _$HomeSectionCopyWith(_HomeSection value, $Res Function(_HomeSection) _then) = __$HomeSectionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<PartialSourceManga> items, bool containsMoreItems
});




}
/// @nodoc
class __$HomeSectionCopyWithImpl<$Res>
    implements _$HomeSectionCopyWith<$Res> {
  __$HomeSectionCopyWithImpl(this._self, this._then);

  final _HomeSection _self;
  final $Res Function(_HomeSection) _then;

/// Create a copy of HomeSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? items = null,Object? containsMoreItems = null,}) {
  return _then(_HomeSection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PartialSourceManga>,containsMoreItems: null == containsMoreItems ? _self.containsMoreItems : containsMoreItems // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

DUIOAuthResponseType _$DUIOAuthResponseTypeFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'token':
          return DUIOAuthTokenResponse.fromJson(
            json
          );
                case 'code':
          return DUIOAuthCodeResponse.fromJson(
            json
          );
                case 'pkce':
          return DUIOAuthPKCEResponse.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'DUIOAuthResponseType',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$DUIOAuthResponseType {



  /// Serializes this DUIOAuthResponseType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUIOAuthResponseType);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DUIOAuthResponseType()';
}


}

/// @nodoc
class $DUIOAuthResponseTypeCopyWith<$Res>  {
$DUIOAuthResponseTypeCopyWith(DUIOAuthResponseType _, $Res Function(DUIOAuthResponseType) __);
}


/// @nodoc
@JsonSerializable()

class DUIOAuthTokenResponse implements DUIOAuthResponseType {
  const DUIOAuthTokenResponse({final  String? $type}): $type = $type ?? 'token';
  factory DUIOAuthTokenResponse.fromJson(Map<String, dynamic> json) => _$DUIOAuthTokenResponseFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DUIOAuthTokenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUIOAuthTokenResponse);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DUIOAuthResponseType.token()';
}


}




/// @nodoc
@JsonSerializable()

class DUIOAuthCodeResponse implements DUIOAuthResponseType {
  const DUIOAuthCodeResponse({required this.tokenEndpoint, final  String? $type}): $type = $type ?? 'code';
  factory DUIOAuthCodeResponse.fromJson(Map<String, dynamic> json) => _$DUIOAuthCodeResponseFromJson(json);

 final  String tokenEndpoint;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIOAuthResponseType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUIOAuthCodeResponseCopyWith<DUIOAuthCodeResponse> get copyWith => _$DUIOAuthCodeResponseCopyWithImpl<DUIOAuthCodeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUIOAuthCodeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUIOAuthCodeResponse&&(identical(other.tokenEndpoint, tokenEndpoint) || other.tokenEndpoint == tokenEndpoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tokenEndpoint);

@override
String toString() {
  return 'DUIOAuthResponseType.code(tokenEndpoint: $tokenEndpoint)';
}


}

/// @nodoc
abstract mixin class $DUIOAuthCodeResponseCopyWith<$Res> implements $DUIOAuthResponseTypeCopyWith<$Res> {
  factory $DUIOAuthCodeResponseCopyWith(DUIOAuthCodeResponse value, $Res Function(DUIOAuthCodeResponse) _then) = _$DUIOAuthCodeResponseCopyWithImpl;
@useResult
$Res call({
 String tokenEndpoint
});




}
/// @nodoc
class _$DUIOAuthCodeResponseCopyWithImpl<$Res>
    implements $DUIOAuthCodeResponseCopyWith<$Res> {
  _$DUIOAuthCodeResponseCopyWithImpl(this._self, this._then);

  final DUIOAuthCodeResponse _self;
  final $Res Function(DUIOAuthCodeResponse) _then;

/// Create a copy of DUIOAuthResponseType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tokenEndpoint = null,}) {
  return _then(DUIOAuthCodeResponse(
tokenEndpoint: null == tokenEndpoint ? _self.tokenEndpoint : tokenEndpoint // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DUIOAuthPKCEResponse implements DUIOAuthResponseType {
  const DUIOAuthPKCEResponse({required this.tokenEndpoint, required this.pkceCodeLength, required this.pkceCodeMethod, required this.formEncodeGrant, final  String? $type}): $type = $type ?? 'pkce';
  factory DUIOAuthPKCEResponse.fromJson(Map<String, dynamic> json) => _$DUIOAuthPKCEResponseFromJson(json);

 final  String tokenEndpoint;
 final  num pkceCodeLength;
 final  String pkceCodeMethod;
 final  bool formEncodeGrant;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIOAuthResponseType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUIOAuthPKCEResponseCopyWith<DUIOAuthPKCEResponse> get copyWith => _$DUIOAuthPKCEResponseCopyWithImpl<DUIOAuthPKCEResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUIOAuthPKCEResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUIOAuthPKCEResponse&&(identical(other.tokenEndpoint, tokenEndpoint) || other.tokenEndpoint == tokenEndpoint)&&(identical(other.pkceCodeLength, pkceCodeLength) || other.pkceCodeLength == pkceCodeLength)&&(identical(other.pkceCodeMethod, pkceCodeMethod) || other.pkceCodeMethod == pkceCodeMethod)&&(identical(other.formEncodeGrant, formEncodeGrant) || other.formEncodeGrant == formEncodeGrant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tokenEndpoint,pkceCodeLength,pkceCodeMethod,formEncodeGrant);

@override
String toString() {
  return 'DUIOAuthResponseType.pkce(tokenEndpoint: $tokenEndpoint, pkceCodeLength: $pkceCodeLength, pkceCodeMethod: $pkceCodeMethod, formEncodeGrant: $formEncodeGrant)';
}


}

/// @nodoc
abstract mixin class $DUIOAuthPKCEResponseCopyWith<$Res> implements $DUIOAuthResponseTypeCopyWith<$Res> {
  factory $DUIOAuthPKCEResponseCopyWith(DUIOAuthPKCEResponse value, $Res Function(DUIOAuthPKCEResponse) _then) = _$DUIOAuthPKCEResponseCopyWithImpl;
@useResult
$Res call({
 String tokenEndpoint, num pkceCodeLength, String pkceCodeMethod, bool formEncodeGrant
});




}
/// @nodoc
class _$DUIOAuthPKCEResponseCopyWithImpl<$Res>
    implements $DUIOAuthPKCEResponseCopyWith<$Res> {
  _$DUIOAuthPKCEResponseCopyWithImpl(this._self, this._then);

  final DUIOAuthPKCEResponse _self;
  final $Res Function(DUIOAuthPKCEResponse) _then;

/// Create a copy of DUIOAuthResponseType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tokenEndpoint = null,Object? pkceCodeLength = null,Object? pkceCodeMethod = null,Object? formEncodeGrant = null,}) {
  return _then(DUIOAuthPKCEResponse(
tokenEndpoint: null == tokenEndpoint ? _self.tokenEndpoint : tokenEndpoint // ignore: cast_nullable_to_non_nullable
as String,pkceCodeLength: null == pkceCodeLength ? _self.pkceCodeLength : pkceCodeLength // ignore: cast_nullable_to_non_nullable
as num,pkceCodeMethod: null == pkceCodeMethod ? _self.pkceCodeMethod : pkceCodeMethod // ignore: cast_nullable_to_non_nullable
as String,formEncodeGrant: null == formEncodeGrant ? _self.formEncodeGrant : formEncodeGrant // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

DUIType _$DUITypeFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'DUISection':
          return DUISection.fromJson(
            json
          );
                case 'DUISelect':
          return DUISelect.fromJson(
            json
          );
                case 'DUIInputField':
          return DUIInputField.fromJson(
            json
          );
                case 'DUISecureInputField':
          return DUISecureInputField.fromJson(
            json
          );
                case 'DUIStepper':
          return DUIStepper.fromJson(
            json
          );
                case 'DUILabel':
          return DUILabel.fromJson(
            json
          );
                case 'DUIMultilineLabel':
          return DUIMultilineLabel.fromJson(
            json
          );
                case 'DUIHeader':
          return DUIHeader.fromJson(
            json
          );
                case 'DUIButton':
          return DUIButton.fromJson(
            json
          );
                case 'DUINavigationButton':
          return DUINavigationButton.fromJson(
            json
          );
                case 'DUISwitch':
          return DUISwitch.fromJson(
            json
          );
                case 'DUIOAuthButton':
          return DUIOAuthButton.fromJson(
            json
          );
                case 'DUIForm':
          return DUIForm.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'DUIType',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$DUIType {



  /// Serializes this DUIType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUIType);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DUIType()';
}


}

/// @nodoc
class $DUITypeCopyWith<$Res>  {
$DUITypeCopyWith(DUIType _, $Res Function(DUIType) __);
}


/// @nodoc
@JsonSerializable()

class DUISection implements DUIType, DUIFormRow {
  const DUISection({required this.id, this.header, this.footer, required this.isHidden, required final  List<DUIType> rows, final  String? $type}): _rows = rows,$type = $type ?? 'DUISection';
  factory DUISection.fromJson(Map<String, dynamic> json) => _$DUISectionFromJson(json);

 final  String id;
 final  String? header;
 final  String? footer;
 final  bool isHidden;
 final  List<DUIType> _rows;
 List<DUIType> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUISectionCopyWith<DUISection> get copyWith => _$DUISectionCopyWithImpl<DUISection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUISectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUISection&&(identical(other.id, id) || other.id == id)&&(identical(other.header, header) || other.header == header)&&(identical(other.footer, footer) || other.footer == footer)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&const DeepCollectionEquality().equals(other._rows, _rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,header,footer,isHidden,const DeepCollectionEquality().hash(_rows));

@override
String toString() {
  return 'DUIType.DUISection(id: $id, header: $header, footer: $footer, isHidden: $isHidden, rows: $rows)';
}


}

/// @nodoc
abstract mixin class $DUISectionCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUISectionCopyWith(DUISection value, $Res Function(DUISection) _then) = _$DUISectionCopyWithImpl;
@useResult
$Res call({
 String id, String? header, String? footer, bool isHidden, List<DUIType> rows
});




}
/// @nodoc
class _$DUISectionCopyWithImpl<$Res>
    implements $DUISectionCopyWith<$Res> {
  _$DUISectionCopyWithImpl(this._self, this._then);

  final DUISection _self;
  final $Res Function(DUISection) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? header = freezed,Object? footer = freezed,Object? isHidden = null,Object? rows = null,}) {
  return _then(DUISection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,header: freezed == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as String?,footer: freezed == footer ? _self.footer : footer // ignore: cast_nullable_to_non_nullable
as String?,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<DUIType>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DUISelect implements DUIType, DUIFormRow {
  const DUISelect({required this.id, required this.label, required final  List<String> options, required this.allowsMultiselect, required final  Map<String, String> labels, final  String? $type}): _options = options,_labels = labels,$type = $type ?? 'DUISelect';
  factory DUISelect.fromJson(Map<String, dynamic> json) => _$DUISelectFromJson(json);

 final  String id;
 final  String label;
 final  List<String> _options;
 List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

 final  bool allowsMultiselect;
 final  Map<String, String> _labels;
 Map<String, String> get labels {
  if (_labels is EqualUnmodifiableMapView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_labels);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUISelectCopyWith<DUISelect> get copyWith => _$DUISelectCopyWithImpl<DUISelect>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUISelectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUISelect&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.allowsMultiselect, allowsMultiselect) || other.allowsMultiselect == allowsMultiselect)&&const DeepCollectionEquality().equals(other._labels, _labels));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,const DeepCollectionEquality().hash(_options),allowsMultiselect,const DeepCollectionEquality().hash(_labels));

@override
String toString() {
  return 'DUIType.DUISelect(id: $id, label: $label, options: $options, allowsMultiselect: $allowsMultiselect, labels: $labels)';
}


}

/// @nodoc
abstract mixin class $DUISelectCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUISelectCopyWith(DUISelect value, $Res Function(DUISelect) _then) = _$DUISelectCopyWithImpl;
@useResult
$Res call({
 String id, String label, List<String> options, bool allowsMultiselect, Map<String, String> labels
});




}
/// @nodoc
class _$DUISelectCopyWithImpl<$Res>
    implements $DUISelectCopyWith<$Res> {
  _$DUISelectCopyWithImpl(this._self, this._then);

  final DUISelect _self;
  final $Res Function(DUISelect) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? options = null,Object? allowsMultiselect = null,Object? labels = null,}) {
  return _then(DUISelect(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,allowsMultiselect: null == allowsMultiselect ? _self.allowsMultiselect : allowsMultiselect // ignore: cast_nullable_to_non_nullable
as bool,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DUIInputField implements DUIType, DUIInputType {
  const DUIInputField({required this.id, required this.label, final  String? $type}): $type = $type ?? 'DUIInputField';
  factory DUIInputField.fromJson(Map<String, dynamic> json) => _$DUIInputFieldFromJson(json);

 final  String id;
 final  String label;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUIInputFieldCopyWith<DUIInputField> get copyWith => _$DUIInputFieldCopyWithImpl<DUIInputField>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUIInputFieldToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUIInputField&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'DUIType.DUIInputField(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class $DUIInputFieldCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUIInputFieldCopyWith(DUIInputField value, $Res Function(DUIInputField) _then) = _$DUIInputFieldCopyWithImpl;
@useResult
$Res call({
 String id, String label
});




}
/// @nodoc
class _$DUIInputFieldCopyWithImpl<$Res>
    implements $DUIInputFieldCopyWith<$Res> {
  _$DUIInputFieldCopyWithImpl(this._self, this._then);

  final DUIInputField _self;
  final $Res Function(DUIInputField) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(DUIInputField(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DUISecureInputField implements DUIType, DUIInputType {
  const DUISecureInputField({required this.id, required this.label, final  String? $type}): $type = $type ?? 'DUISecureInputField';
  factory DUISecureInputField.fromJson(Map<String, dynamic> json) => _$DUISecureInputFieldFromJson(json);

 final  String id;
 final  String label;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUISecureInputFieldCopyWith<DUISecureInputField> get copyWith => _$DUISecureInputFieldCopyWithImpl<DUISecureInputField>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUISecureInputFieldToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUISecureInputField&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'DUIType.DUISecureInputField(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class $DUISecureInputFieldCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUISecureInputFieldCopyWith(DUISecureInputField value, $Res Function(DUISecureInputField) _then) = _$DUISecureInputFieldCopyWithImpl;
@useResult
$Res call({
 String id, String label
});




}
/// @nodoc
class _$DUISecureInputFieldCopyWithImpl<$Res>
    implements $DUISecureInputFieldCopyWith<$Res> {
  _$DUISecureInputFieldCopyWithImpl(this._self, this._then);

  final DUISecureInputField _self;
  final $Res Function(DUISecureInputField) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(DUISecureInputField(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DUIStepper implements DUIType, DUIFormRow {
  const DUIStepper({required this.id, required this.label, this.min, this.max, this.step, final  String? $type}): $type = $type ?? 'DUIStepper';
  factory DUIStepper.fromJson(Map<String, dynamic> json) => _$DUIStepperFromJson(json);

 final  String id;
 final  String label;
 final  num? min;
 final  num? max;
 final  num? step;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUIStepperCopyWith<DUIStepper> get copyWith => _$DUIStepperCopyWithImpl<DUIStepper>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUIStepperToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUIStepper&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.min, min) || other.min == min)&&(identical(other.max, max) || other.max == max)&&(identical(other.step, step) || other.step == step));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,min,max,step);

@override
String toString() {
  return 'DUIType.DUIStepper(id: $id, label: $label, min: $min, max: $max, step: $step)';
}


}

/// @nodoc
abstract mixin class $DUIStepperCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUIStepperCopyWith(DUIStepper value, $Res Function(DUIStepper) _then) = _$DUIStepperCopyWithImpl;
@useResult
$Res call({
 String id, String label, num? min, num? max, num? step
});




}
/// @nodoc
class _$DUIStepperCopyWithImpl<$Res>
    implements $DUIStepperCopyWith<$Res> {
  _$DUIStepperCopyWithImpl(this._self, this._then);

  final DUIStepper _self;
  final $Res Function(DUIStepper) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? min = freezed,Object? max = freezed,Object? step = freezed,}) {
  return _then(DUIStepper(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,min: freezed == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as num?,max: freezed == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as num?,step: freezed == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DUILabel implements DUIType, DUILabelType {
  const DUILabel({required this.id, required this.label, this.value, final  String? $type}): $type = $type ?? 'DUILabel';
  factory DUILabel.fromJson(Map<String, dynamic> json) => _$DUILabelFromJson(json);

 final  String id;
 final  String label;
 final  String? value;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUILabelCopyWith<DUILabel> get copyWith => _$DUILabelCopyWithImpl<DUILabel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUILabelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUILabel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,value);

@override
String toString() {
  return 'DUIType.DUILabel(id: $id, label: $label, value: $value)';
}


}

/// @nodoc
abstract mixin class $DUILabelCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUILabelCopyWith(DUILabel value, $Res Function(DUILabel) _then) = _$DUILabelCopyWithImpl;
@useResult
$Res call({
 String id, String label, String? value
});




}
/// @nodoc
class _$DUILabelCopyWithImpl<$Res>
    implements $DUILabelCopyWith<$Res> {
  _$DUILabelCopyWithImpl(this._self, this._then);

  final DUILabel _self;
  final $Res Function(DUILabel) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? value = freezed,}) {
  return _then(DUILabel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DUIMultilineLabel implements DUIType, DUILabelType {
  const DUIMultilineLabel({required this.id, required this.label, required this.value, final  String? $type}): $type = $type ?? 'DUIMultilineLabel';
  factory DUIMultilineLabel.fromJson(Map<String, dynamic> json) => _$DUIMultilineLabelFromJson(json);

 final  String id;
 final  String label;
 final  String value;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUIMultilineLabelCopyWith<DUIMultilineLabel> get copyWith => _$DUIMultilineLabelCopyWithImpl<DUIMultilineLabel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUIMultilineLabelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUIMultilineLabel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,value);

@override
String toString() {
  return 'DUIType.DUIMultilineLabel(id: $id, label: $label, value: $value)';
}


}

/// @nodoc
abstract mixin class $DUIMultilineLabelCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUIMultilineLabelCopyWith(DUIMultilineLabel value, $Res Function(DUIMultilineLabel) _then) = _$DUIMultilineLabelCopyWithImpl;
@useResult
$Res call({
 String id, String label, String value
});




}
/// @nodoc
class _$DUIMultilineLabelCopyWithImpl<$Res>
    implements $DUIMultilineLabelCopyWith<$Res> {
  _$DUIMultilineLabelCopyWithImpl(this._self, this._then);

  final DUIMultilineLabel _self;
  final $Res Function(DUIMultilineLabel) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? value = null,}) {
  return _then(DUIMultilineLabel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DUIHeader implements DUIType, DUIFormRow {
  const DUIHeader({required this.id, required this.imageUrl, required this.title, this.subtitle, final  String? $type}): $type = $type ?? 'DUIHeader';
  factory DUIHeader.fromJson(Map<String, dynamic> json) => _$DUIHeaderFromJson(json);

 final  String id;
 final  String imageUrl;
 final  String title;
 final  String? subtitle;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUIHeaderCopyWith<DUIHeader> get copyWith => _$DUIHeaderCopyWithImpl<DUIHeader>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUIHeaderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUIHeader&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageUrl,title,subtitle);

@override
String toString() {
  return 'DUIType.DUIHeader(id: $id, imageUrl: $imageUrl, title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class $DUIHeaderCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUIHeaderCopyWith(DUIHeader value, $Res Function(DUIHeader) _then) = _$DUIHeaderCopyWithImpl;
@useResult
$Res call({
 String id, String imageUrl, String title, String? subtitle
});




}
/// @nodoc
class _$DUIHeaderCopyWithImpl<$Res>
    implements $DUIHeaderCopyWith<$Res> {
  _$DUIHeaderCopyWithImpl(this._self, this._then);

  final DUIHeader _self;
  final $Res Function(DUIHeader) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageUrl = null,Object? title = null,Object? subtitle = freezed,}) {
  return _then(DUIHeader(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DUIButton implements DUIType, DUIFormRow {
  const DUIButton({required this.id, required this.label, final  String? $type}): $type = $type ?? 'DUIButton';
  factory DUIButton.fromJson(Map<String, dynamic> json) => _$DUIButtonFromJson(json);

 final  String id;
 final  String label;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUIButtonCopyWith<DUIButton> get copyWith => _$DUIButtonCopyWithImpl<DUIButton>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUIButtonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUIButton&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'DUIType.DUIButton(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class $DUIButtonCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUIButtonCopyWith(DUIButton value, $Res Function(DUIButton) _then) = _$DUIButtonCopyWithImpl;
@useResult
$Res call({
 String id, String label
});




}
/// @nodoc
class _$DUIButtonCopyWithImpl<$Res>
    implements $DUIButtonCopyWith<$Res> {
  _$DUIButtonCopyWithImpl(this._self, this._then);

  final DUIButton _self;
  final $Res Function(DUIButton) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(DUIButton(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DUINavigationButton implements DUIType, DUIFormRow {
  const DUINavigationButton({required this.id, required this.label, required this.form, final  String? $type}): $type = $type ?? 'DUINavigationButton';
  factory DUINavigationButton.fromJson(Map<String, dynamic> json) => _$DUINavigationButtonFromJson(json);

 final  String id;
 final  String label;
 final  DUIForm form;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUINavigationButtonCopyWith<DUINavigationButton> get copyWith => _$DUINavigationButtonCopyWithImpl<DUINavigationButton>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUINavigationButtonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUINavigationButton&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.form, form));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,const DeepCollectionEquality().hash(form));

@override
String toString() {
  return 'DUIType.DUINavigationButton(id: $id, label: $label, form: $form)';
}


}

/// @nodoc
abstract mixin class $DUINavigationButtonCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUINavigationButtonCopyWith(DUINavigationButton value, $Res Function(DUINavigationButton) _then) = _$DUINavigationButtonCopyWithImpl;
@useResult
$Res call({
 String id, String label, DUIForm form
});




}
/// @nodoc
class _$DUINavigationButtonCopyWithImpl<$Res>
    implements $DUINavigationButtonCopyWith<$Res> {
  _$DUINavigationButtonCopyWithImpl(this._self, this._then);

  final DUINavigationButton _self;
  final $Res Function(DUINavigationButton) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? form = freezed,}) {
  return _then(DUINavigationButton(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,form: freezed == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as DUIForm,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DUISwitch implements DUIType, DUIFormRow {
  const DUISwitch({required this.id, required this.label, final  String? $type}): $type = $type ?? 'DUISwitch';
  factory DUISwitch.fromJson(Map<String, dynamic> json) => _$DUISwitchFromJson(json);

 final  String id;
 final  String label;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUISwitchCopyWith<DUISwitch> get copyWith => _$DUISwitchCopyWithImpl<DUISwitch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUISwitchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUISwitch&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'DUIType.DUISwitch(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class $DUISwitchCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUISwitchCopyWith(DUISwitch value, $Res Function(DUISwitch) _then) = _$DUISwitchCopyWithImpl;
@useResult
$Res call({
 String id, String label
});




}
/// @nodoc
class _$DUISwitchCopyWithImpl<$Res>
    implements $DUISwitchCopyWith<$Res> {
  _$DUISwitchCopyWithImpl(this._self, this._then);

  final DUISwitch _self;
  final $Res Function(DUISwitch) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(DUISwitch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DUIOAuthButton implements DUIType, DUIFormRow {
  const DUIOAuthButton({required this.id, required this.label, required this.authorizeEndpoint, required this.clientId, required this.responseType, this.redirectUri, final  List<String>? scopes, final  String? $type}): _scopes = scopes,$type = $type ?? 'DUIOAuthButton';
  factory DUIOAuthButton.fromJson(Map<String, dynamic> json) => _$DUIOAuthButtonFromJson(json);

 final  String id;
 final  String label;
 final  String authorizeEndpoint;
 final  String clientId;
 final  DUIOAuthResponseType responseType;
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


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUIOAuthButtonCopyWith<DUIOAuthButton> get copyWith => _$DUIOAuthButtonCopyWithImpl<DUIOAuthButton>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUIOAuthButtonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUIOAuthButton&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.authorizeEndpoint, authorizeEndpoint) || other.authorizeEndpoint == authorizeEndpoint)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.responseType, responseType) || other.responseType == responseType)&&(identical(other.redirectUri, redirectUri) || other.redirectUri == redirectUri)&&const DeepCollectionEquality().equals(other._scopes, _scopes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,authorizeEndpoint,clientId,responseType,redirectUri,const DeepCollectionEquality().hash(_scopes));

@override
String toString() {
  return 'DUIType.DUIOAuthButton(id: $id, label: $label, authorizeEndpoint: $authorizeEndpoint, clientId: $clientId, responseType: $responseType, redirectUri: $redirectUri, scopes: $scopes)';
}


}

/// @nodoc
abstract mixin class $DUIOAuthButtonCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUIOAuthButtonCopyWith(DUIOAuthButton value, $Res Function(DUIOAuthButton) _then) = _$DUIOAuthButtonCopyWithImpl;
@useResult
$Res call({
 String id, String label, String authorizeEndpoint, String clientId, DUIOAuthResponseType responseType, String? redirectUri, List<String>? scopes
});


$DUIOAuthResponseTypeCopyWith<$Res> get responseType;

}
/// @nodoc
class _$DUIOAuthButtonCopyWithImpl<$Res>
    implements $DUIOAuthButtonCopyWith<$Res> {
  _$DUIOAuthButtonCopyWithImpl(this._self, this._then);

  final DUIOAuthButton _self;
  final $Res Function(DUIOAuthButton) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? authorizeEndpoint = null,Object? clientId = null,Object? responseType = null,Object? redirectUri = freezed,Object? scopes = freezed,}) {
  return _then(DUIOAuthButton(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,authorizeEndpoint: null == authorizeEndpoint ? _self.authorizeEndpoint : authorizeEndpoint // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,responseType: null == responseType ? _self.responseType : responseType // ignore: cast_nullable_to_non_nullable
as DUIOAuthResponseType,redirectUri: freezed == redirectUri ? _self.redirectUri : redirectUri // ignore: cast_nullable_to_non_nullable
as String?,scopes: freezed == scopes ? _self._scopes : scopes // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DUIOAuthResponseTypeCopyWith<$Res> get responseType {
  
  return $DUIOAuthResponseTypeCopyWith<$Res>(_self.responseType, (value) {
    return _then(_self.copyWith(responseType: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class DUIForm implements DUIType {
  const DUIForm({required final  List<DUISection> sections, required this.hasSubmit, final  String? $type}): _sections = sections,$type = $type ?? 'DUIForm';
  factory DUIForm.fromJson(Map<String, dynamic> json) => _$DUIFormFromJson(json);

 final  List<DUISection> _sections;
 List<DUISection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

 final  bool hasSubmit;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DUIFormCopyWith<DUIForm> get copyWith => _$DUIFormCopyWithImpl<DUIForm>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DUIFormToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DUIForm&&const DeepCollectionEquality().equals(other._sections, _sections)&&(identical(other.hasSubmit, hasSubmit) || other.hasSubmit == hasSubmit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sections),hasSubmit);

@override
String toString() {
  return 'DUIType.DUIForm(sections: $sections, hasSubmit: $hasSubmit)';
}


}

/// @nodoc
abstract mixin class $DUIFormCopyWith<$Res> implements $DUITypeCopyWith<$Res> {
  factory $DUIFormCopyWith(DUIForm value, $Res Function(DUIForm) _then) = _$DUIFormCopyWithImpl;
@useResult
$Res call({
 List<DUISection> sections, bool hasSubmit
});




}
/// @nodoc
class _$DUIFormCopyWithImpl<$Res>
    implements $DUIFormCopyWith<$Res> {
  _$DUIFormCopyWithImpl(this._self, this._then);

  final DUIForm _self;
  final $Res Function(DUIForm) _then;

/// Create a copy of DUIType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sections = null,Object? hasSubmit = null,}) {
  return _then(DUIForm(
sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<DUISection>,hasSubmit: null == hasSubmit ? _self.hasSubmit : hasSubmit // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
