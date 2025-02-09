// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SourceInfo {
  SourceType get type => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String? get chapter => throw _privateConstructorUsedError;
  WebSourceInfo? get parser => throw _privateConstructorUsedError;

  /// Create a copy of SourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SourceInfoCopyWith<SourceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceInfoCopyWith<$Res> {
  factory $SourceInfoCopyWith(
          SourceInfo value, $Res Function(SourceInfo) then) =
      _$SourceInfoCopyWithImpl<$Res, SourceInfo>;
  @useResult
  $Res call(
      {SourceType type,
      String source,
      String location,
      String? chapter,
      WebSourceInfo? parser});

  $WebSourceInfoCopyWith<$Res>? get parser;
}

/// @nodoc
class _$SourceInfoCopyWithImpl<$Res, $Val extends SourceInfo>
    implements $SourceInfoCopyWith<$Res> {
  _$SourceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? source = null,
    Object? location = null,
    Object? chapter = freezed,
    Object? parser = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SourceType,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      chapter: freezed == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as String?,
      parser: freezed == parser
          ? _value.parser
          : parser // ignore: cast_nullable_to_non_nullable
              as WebSourceInfo?,
    ) as $Val);
  }

  /// Create a copy of SourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WebSourceInfoCopyWith<$Res>? get parser {
    if (_value.parser == null) {
      return null;
    }

    return $WebSourceInfoCopyWith<$Res>(_value.parser!, (value) {
      return _then(_value.copyWith(parser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SourceInfoImplCopyWith<$Res>
    implements $SourceInfoCopyWith<$Res> {
  factory _$$SourceInfoImplCopyWith(
          _$SourceInfoImpl value, $Res Function(_$SourceInfoImpl) then) =
      __$$SourceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SourceType type,
      String source,
      String location,
      String? chapter,
      WebSourceInfo? parser});

  @override
  $WebSourceInfoCopyWith<$Res>? get parser;
}

/// @nodoc
class __$$SourceInfoImplCopyWithImpl<$Res>
    extends _$SourceInfoCopyWithImpl<$Res, _$SourceInfoImpl>
    implements _$$SourceInfoImplCopyWith<$Res> {
  __$$SourceInfoImplCopyWithImpl(
      _$SourceInfoImpl _value, $Res Function(_$SourceInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of SourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? source = null,
    Object? location = null,
    Object? chapter = freezed,
    Object? parser = freezed,
  }) {
    return _then(_$SourceInfoImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SourceType,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      chapter: freezed == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as String?,
      parser: freezed == parser
          ? _value.parser
          : parser // ignore: cast_nullable_to_non_nullable
              as WebSourceInfo?,
    ));
  }
}

/// @nodoc

class _$SourceInfoImpl extends _SourceInfo {
  const _$SourceInfoImpl(
      {required this.type,
      required this.source,
      required this.location,
      this.chapter,
      this.parser})
      : super._();

  @override
  final SourceType type;
  @override
  final String source;
  @override
  final String location;
  @override
  final String? chapter;
  @override
  final WebSourceInfo? parser;

  @override
  String toString() {
    return 'SourceInfo(type: $type, source: $source, location: $location, chapter: $chapter, parser: $parser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceInfoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.chapter, chapter) || other.chapter == chapter) &&
            (identical(other.parser, parser) || other.parser == parser));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, type, source, location, chapter, parser);

  /// Create a copy of SourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceInfoImplCopyWith<_$SourceInfoImpl> get copyWith =>
      __$$SourceInfoImplCopyWithImpl<_$SourceInfoImpl>(this, _$identity);
}

abstract class _SourceInfo extends SourceInfo {
  const factory _SourceInfo(
      {required final SourceType type,
      required final String source,
      required final String location,
      final String? chapter,
      final WebSourceInfo? parser}) = _$SourceInfoImpl;
  const _SourceInfo._() : super._();

  @override
  SourceType get type;
  @override
  String get source;
  @override
  String get location;
  @override
  String? get chapter;
  @override
  WebSourceInfo? get parser;

  /// Create a copy of SourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceInfoImplCopyWith<_$SourceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HistoryLink _$HistoryLinkFromJson(Map<String, dynamic> json) {
  return _HistoryLink.fromJson(json);
}

/// @nodoc
mixin _$HistoryLink {
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get cover => throw _privateConstructorUsedError;

  /// Serializes this HistoryLink to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HistoryLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryLinkCopyWith<HistoryLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryLinkCopyWith<$Res> {
  factory $HistoryLinkCopyWith(
          HistoryLink value, $Res Function(HistoryLink) then) =
      _$HistoryLinkCopyWithImpl<$Res, HistoryLink>;
  @useResult
  $Res call({String title, String url, String? cover});
}

/// @nodoc
class _$HistoryLinkCopyWithImpl<$Res, $Val extends HistoryLink>
    implements $HistoryLinkCopyWith<$Res> {
  _$HistoryLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? cover = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryLinkImplCopyWith<$Res>
    implements $HistoryLinkCopyWith<$Res> {
  factory _$$HistoryLinkImplCopyWith(
          _$HistoryLinkImpl value, $Res Function(_$HistoryLinkImpl) then) =
      __$$HistoryLinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String url, String? cover});
}

/// @nodoc
class __$$HistoryLinkImplCopyWithImpl<$Res>
    extends _$HistoryLinkCopyWithImpl<$Res, _$HistoryLinkImpl>
    implements _$$HistoryLinkImplCopyWith<$Res> {
  __$$HistoryLinkImplCopyWithImpl(
      _$HistoryLinkImpl _value, $Res Function(_$HistoryLinkImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? cover = freezed,
  }) {
    return _then(_$HistoryLinkImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryLinkImpl extends _HistoryLink {
  const _$HistoryLinkImpl({required this.title, required this.url, this.cover})
      : super._();

  factory _$HistoryLinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryLinkImplFromJson(json);

  @override
  final String title;
  @override
  final String url;
  @override
  final String? cover;

  @override
  String toString() {
    return 'HistoryLink(title: $title, url: $url, cover: $cover)';
  }

  /// Create a copy of HistoryLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryLinkImplCopyWith<_$HistoryLinkImpl> get copyWith =>
      __$$HistoryLinkImplCopyWithImpl<_$HistoryLinkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryLinkImplToJson(
      this,
    );
  }
}

abstract class _HistoryLink extends HistoryLink {
  const factory _HistoryLink(
      {required final String title,
      required final String url,
      final String? cover}) = _$HistoryLinkImpl;
  const _HistoryLink._() : super._();

  factory _HistoryLink.fromJson(Map<String, dynamic> json) =
      _$HistoryLinkImpl.fromJson;

  @override
  String get title;
  @override
  String get url;
  @override
  String? get cover;

  /// Create a copy of HistoryLink
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryLinkImplCopyWith<_$HistoryLinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WebManga _$WebMangaFromJson(Map<String, dynamic> json) {
  return _WebManga.fromJson(json);
}

/// @nodoc
mixin _$WebManga {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get artist => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get cover => throw _privateConstructorUsedError;
  Map<String, String>? get groups => throw _privateConstructorUsedError;
  Map<String, WebChapter> get chapters => throw _privateConstructorUsedError;

  /// Serializes this WebManga to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebManga
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebMangaCopyWith<WebManga> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebMangaCopyWith<$Res> {
  factory $WebMangaCopyWith(WebManga value, $Res Function(WebManga) then) =
      _$WebMangaCopyWithImpl<$Res, WebManga>;
  @useResult
  $Res call(
      {String title,
      String description,
      String artist,
      String author,
      String cover,
      Map<String, String>? groups,
      Map<String, WebChapter> chapters});
}

/// @nodoc
class _$WebMangaCopyWithImpl<$Res, $Val extends WebManga>
    implements $WebMangaCopyWith<$Res> {
  _$WebMangaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebManga
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? artist = null,
    Object? author = null,
    Object? cover = null,
    Object? groups = freezed,
    Object? chapters = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      cover: null == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String,
      groups: freezed == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      chapters: null == chapters
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as Map<String, WebChapter>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebMangaImplCopyWith<$Res>
    implements $WebMangaCopyWith<$Res> {
  factory _$$WebMangaImplCopyWith(
          _$WebMangaImpl value, $Res Function(_$WebMangaImpl) then) =
      __$$WebMangaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      String artist,
      String author,
      String cover,
      Map<String, String>? groups,
      Map<String, WebChapter> chapters});
}

/// @nodoc
class __$$WebMangaImplCopyWithImpl<$Res>
    extends _$WebMangaCopyWithImpl<$Res, _$WebMangaImpl>
    implements _$$WebMangaImplCopyWith<$Res> {
  __$$WebMangaImplCopyWithImpl(
      _$WebMangaImpl _value, $Res Function(_$WebMangaImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebManga
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? artist = null,
    Object? author = null,
    Object? cover = null,
    Object? groups = freezed,
    Object? chapters = null,
  }) {
    return _then(_$WebMangaImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      cover: null == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String,
      groups: freezed == groups
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      chapters: null == chapters
          ? _value._chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as Map<String, WebChapter>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebMangaImpl extends _WebManga {
  const _$WebMangaImpl(
      {required this.title,
      required this.description,
      required this.artist,
      required this.author,
      required this.cover,
      final Map<String, String>? groups,
      required final Map<String, WebChapter> chapters})
      : _groups = groups,
        _chapters = chapters,
        super._();

  factory _$WebMangaImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebMangaImplFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final String artist;
  @override
  final String author;
  @override
  final String cover;
  final Map<String, String>? _groups;
  @override
  Map<String, String>? get groups {
    final value = _groups;
    if (value == null) return null;
    if (_groups is EqualUnmodifiableMapView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, WebChapter> _chapters;
  @override
  Map<String, WebChapter> get chapters {
    if (_chapters is EqualUnmodifiableMapView) return _chapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_chapters);
  }

  @override
  String toString() {
    return 'WebManga(title: $title, description: $description, artist: $artist, author: $author, cover: $cover, groups: $groups, chapters: $chapters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebMangaImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            const DeepCollectionEquality().equals(other._groups, _groups) &&
            const DeepCollectionEquality().equals(other._chapters, _chapters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      description,
      artist,
      author,
      cover,
      const DeepCollectionEquality().hash(_groups),
      const DeepCollectionEquality().hash(_chapters));

  /// Create a copy of WebManga
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebMangaImplCopyWith<_$WebMangaImpl> get copyWith =>
      __$$WebMangaImplCopyWithImpl<_$WebMangaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebMangaImplToJson(
      this,
    );
  }
}

abstract class _WebManga extends WebManga {
  const factory _WebManga(
      {required final String title,
      required final String description,
      required final String artist,
      required final String author,
      required final String cover,
      final Map<String, String>? groups,
      required final Map<String, WebChapter> chapters}) = _$WebMangaImpl;
  const _WebManga._() : super._();

  factory _WebManga.fromJson(Map<String, dynamic> json) =
      _$WebMangaImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  String get artist;
  @override
  String get author;
  @override
  String get cover;
  @override
  Map<String, String>? get groups;
  @override
  Map<String, WebChapter> get chapters;

  /// Create a copy of WebManga
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebMangaImplCopyWith<_$WebMangaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WebChapter _$WebChapterFromJson(Map<String, dynamic> json) {
  return _WebChapter.fromJson(json);
}

/// @nodoc
mixin _$WebChapter {
  String? get title => throw _privateConstructorUsedError;
  String? get volume => throw _privateConstructorUsedError;
  @EpochTimestampSerializer()
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  @MappedEpochTimestampSerializer()
  DateTime? get releaseDate => throw _privateConstructorUsedError;
  Map<String, dynamic> get groups => throw _privateConstructorUsedError;

  /// Serializes this WebChapter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebChapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebChapterCopyWith<WebChapter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebChapterCopyWith<$Res> {
  factory $WebChapterCopyWith(
          WebChapter value, $Res Function(WebChapter) then) =
      _$WebChapterCopyWithImpl<$Res, WebChapter>;
  @useResult
  $Res call(
      {String? title,
      String? volume,
      @EpochTimestampSerializer() DateTime? lastUpdated,
      @MappedEpochTimestampSerializer() DateTime? releaseDate,
      Map<String, dynamic> groups});
}

/// @nodoc
class _$WebChapterCopyWithImpl<$Res, $Val extends WebChapter>
    implements $WebChapterCopyWith<$Res> {
  _$WebChapterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebChapter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? volume = freezed,
    Object? lastUpdated = freezed,
    Object? releaseDate = freezed,
    Object? groups = null,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      volume: freezed == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      groups: null == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebChapterImplCopyWith<$Res>
    implements $WebChapterCopyWith<$Res> {
  factory _$$WebChapterImplCopyWith(
          _$WebChapterImpl value, $Res Function(_$WebChapterImpl) then) =
      __$$WebChapterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? volume,
      @EpochTimestampSerializer() DateTime? lastUpdated,
      @MappedEpochTimestampSerializer() DateTime? releaseDate,
      Map<String, dynamic> groups});
}

/// @nodoc
class __$$WebChapterImplCopyWithImpl<$Res>
    extends _$WebChapterCopyWithImpl<$Res, _$WebChapterImpl>
    implements _$$WebChapterImplCopyWith<$Res> {
  __$$WebChapterImplCopyWithImpl(
      _$WebChapterImpl _value, $Res Function(_$WebChapterImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebChapter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? volume = freezed,
    Object? lastUpdated = freezed,
    Object? releaseDate = freezed,
    Object? groups = null,
  }) {
    return _then(_$WebChapterImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      volume: freezed == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      groups: null == groups
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$WebChapterImpl extends _WebChapter {
  const _$WebChapterImpl(
      {this.title,
      this.volume,
      @EpochTimestampSerializer() this.lastUpdated,
      @MappedEpochTimestampSerializer() this.releaseDate,
      required final Map<String, dynamic> groups})
      : _groups = groups,
        super._();

  factory _$WebChapterImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebChapterImplFromJson(json);

  @override
  final String? title;
  @override
  final String? volume;
  @override
  @EpochTimestampSerializer()
  final DateTime? lastUpdated;
  @override
  @MappedEpochTimestampSerializer()
  final DateTime? releaseDate;
  final Map<String, dynamic> _groups;
  @override
  Map<String, dynamic> get groups {
    if (_groups is EqualUnmodifiableMapView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_groups);
  }

  @override
  String toString() {
    return 'WebChapter(title: $title, volume: $volume, lastUpdated: $lastUpdated, releaseDate: $releaseDate, groups: $groups)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebChapterImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            const DeepCollectionEquality().equals(other._groups, _groups));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, volume, lastUpdated,
      releaseDate, const DeepCollectionEquality().hash(_groups));

  /// Create a copy of WebChapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebChapterImplCopyWith<_$WebChapterImpl> get copyWith =>
      __$$WebChapterImplCopyWithImpl<_$WebChapterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebChapterImplToJson(
      this,
    );
  }
}

abstract class _WebChapter extends WebChapter {
  const factory _WebChapter(
      {final String? title,
      final String? volume,
      @EpochTimestampSerializer() final DateTime? lastUpdated,
      @MappedEpochTimestampSerializer() final DateTime? releaseDate,
      required final Map<String, dynamic> groups}) = _$WebChapterImpl;
  const _WebChapter._() : super._();

  factory _WebChapter.fromJson(Map<String, dynamic> json) =
      _$WebChapterImpl.fromJson;

  @override
  String? get title;
  @override
  String? get volume;
  @override
  @EpochTimestampSerializer()
  DateTime? get lastUpdated;
  @override
  @MappedEpochTimestampSerializer()
  DateTime? get releaseDate;
  @override
  Map<String, dynamic> get groups;

  /// Create a copy of WebChapter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebChapterImplCopyWith<_$WebChapterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ImgurPage _$ImgurPageFromJson(Map<String, dynamic> json) {
  return _ImgurPage.fromJson(json);
}

/// @nodoc
mixin _$ImgurPage {
  String get description => throw _privateConstructorUsedError;
  String get src => throw _privateConstructorUsedError;

  /// Serializes this ImgurPage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImgurPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImgurPageCopyWith<ImgurPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImgurPageCopyWith<$Res> {
  factory $ImgurPageCopyWith(ImgurPage value, $Res Function(ImgurPage) then) =
      _$ImgurPageCopyWithImpl<$Res, ImgurPage>;
  @useResult
  $Res call({String description, String src});
}

/// @nodoc
class _$ImgurPageCopyWithImpl<$Res, $Val extends ImgurPage>
    implements $ImgurPageCopyWith<$Res> {
  _$ImgurPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImgurPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? src = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      src: null == src
          ? _value.src
          : src // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImgurPageImplCopyWith<$Res>
    implements $ImgurPageCopyWith<$Res> {
  factory _$$ImgurPageImplCopyWith(
          _$ImgurPageImpl value, $Res Function(_$ImgurPageImpl) then) =
      __$$ImgurPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, String src});
}

/// @nodoc
class __$$ImgurPageImplCopyWithImpl<$Res>
    extends _$ImgurPageCopyWithImpl<$Res, _$ImgurPageImpl>
    implements _$$ImgurPageImplCopyWith<$Res> {
  __$$ImgurPageImplCopyWithImpl(
      _$ImgurPageImpl _value, $Res Function(_$ImgurPageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImgurPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? src = null,
  }) {
    return _then(_$ImgurPageImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      src: null == src
          ? _value.src
          : src // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImgurPageImpl implements _ImgurPage {
  const _$ImgurPageImpl({required this.description, required this.src});

  factory _$ImgurPageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImgurPageImplFromJson(json);

  @override
  final String description;
  @override
  final String src;

  @override
  String toString() {
    return 'ImgurPage(description: $description, src: $src)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImgurPageImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.src, src) || other.src == src));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, src);

  /// Create a copy of ImgurPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImgurPageImplCopyWith<_$ImgurPageImpl> get copyWith =>
      __$$ImgurPageImplCopyWithImpl<_$ImgurPageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImgurPageImplToJson(
      this,
    );
  }
}

abstract class _ImgurPage implements ImgurPage {
  const factory _ImgurPage(
      {required final String description,
      required final String src}) = _$ImgurPageImpl;

  factory _ImgurPage.fromJson(Map<String, dynamic> json) =
      _$ImgurPageImpl.fromJson;

  @override
  String get description;
  @override
  String get src;

  /// Create a copy of ImgurPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImgurPageImplCopyWith<_$ImgurPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WebSourceInfo _$WebSourceInfoFromJson(Map<String, dynamic> json) {
  return _WebSourceInfo.fromJson(json);
}

/// @nodoc
mixin _$WebSourceInfo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get repo => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;

  /// Serializes this WebSourceInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebSourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebSourceInfoCopyWith<WebSourceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSourceInfoCopyWith<$Res> {
  factory $WebSourceInfoCopyWith(
          WebSourceInfo value, $Res Function(WebSourceInfo) then) =
      _$WebSourceInfoCopyWithImpl<$Res, WebSourceInfo>;
  @useResult
  $Res call({String id, String name, String repo, String? icon});
}

/// @nodoc
class _$WebSourceInfoCopyWithImpl<$Res, $Val extends WebSourceInfo>
    implements $WebSourceInfoCopyWith<$Res> {
  _$WebSourceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? repo = null,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      repo: null == repo
          ? _value.repo
          : repo // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebSourceInfoImplCopyWith<$Res>
    implements $WebSourceInfoCopyWith<$Res> {
  factory _$$WebSourceInfoImplCopyWith(
          _$WebSourceInfoImpl value, $Res Function(_$WebSourceInfoImpl) then) =
      __$$WebSourceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String repo, String? icon});
}

/// @nodoc
class __$$WebSourceInfoImplCopyWithImpl<$Res>
    extends _$WebSourceInfoCopyWithImpl<$Res, _$WebSourceInfoImpl>
    implements _$$WebSourceInfoImplCopyWith<$Res> {
  __$$WebSourceInfoImplCopyWithImpl(
      _$WebSourceInfoImpl _value, $Res Function(_$WebSourceInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? repo = null,
    Object? icon = freezed,
  }) {
    return _then(_$WebSourceInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      repo: null == repo
          ? _value.repo
          : repo // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSourceInfoImpl implements _WebSourceInfo {
  const _$WebSourceInfoImpl(
      {required this.id, required this.name, required this.repo, this.icon});

  factory _$WebSourceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSourceInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String repo;
  @override
  final String? icon;

  @override
  String toString() {
    return 'WebSourceInfo(id: $id, name: $name, repo: $repo, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSourceInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.repo, repo) || other.repo == repo) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, repo, icon);

  /// Create a copy of WebSourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSourceInfoImplCopyWith<_$WebSourceInfoImpl> get copyWith =>
      __$$WebSourceInfoImplCopyWithImpl<_$WebSourceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSourceInfoImplToJson(
      this,
    );
  }
}

abstract class _WebSourceInfo implements WebSourceInfo {
  const factory _WebSourceInfo(
      {required final String id,
      required final String name,
      required final String repo,
      final String? icon}) = _$WebSourceInfoImpl;

  factory _WebSourceInfo.fromJson(Map<String, dynamic> json) =
      _$WebSourceInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get repo;
  @override
  String? get icon;

  /// Create a copy of WebSourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSourceInfoImplCopyWith<_$WebSourceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Badge _$BadgeFromJson(Map<String, dynamic> json) {
  return _Badge.fromJson(json);
}

/// @nodoc
mixin _$Badge {
  String get text => throw _privateConstructorUsedError;
  BadgeColor get type => throw _privateConstructorUsedError;

  /// Serializes this Badge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Badge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BadgeCopyWith<Badge> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeCopyWith<$Res> {
  factory $BadgeCopyWith(Badge value, $Res Function(Badge) then) =
      _$BadgeCopyWithImpl<$Res, Badge>;
  @useResult
  $Res call({String text, BadgeColor type});
}

/// @nodoc
class _$BadgeCopyWithImpl<$Res, $Val extends Badge>
    implements $BadgeCopyWith<$Res> {
  _$BadgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Badge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BadgeColor,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BadgeImplCopyWith<$Res> implements $BadgeCopyWith<$Res> {
  factory _$$BadgeImplCopyWith(
          _$BadgeImpl value, $Res Function(_$BadgeImpl) then) =
      __$$BadgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, BadgeColor type});
}

/// @nodoc
class __$$BadgeImplCopyWithImpl<$Res>
    extends _$BadgeCopyWithImpl<$Res, _$BadgeImpl>
    implements _$$BadgeImplCopyWith<$Res> {
  __$$BadgeImplCopyWithImpl(
      _$BadgeImpl _value, $Res Function(_$BadgeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Badge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? type = null,
  }) {
    return _then(_$BadgeImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BadgeColor,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BadgeImpl implements _Badge {
  const _$BadgeImpl({required this.text, required this.type});

  factory _$BadgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$BadgeImplFromJson(json);

  @override
  final String text;
  @override
  final BadgeColor type;

  @override
  String toString() {
    return 'Badge(text: $text, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, type);

  /// Create a copy of Badge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeImplCopyWith<_$BadgeImpl> get copyWith =>
      __$$BadgeImplCopyWithImpl<_$BadgeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BadgeImplToJson(
      this,
    );
  }
}

abstract class _Badge implements Badge {
  const factory _Badge(
      {required final String text,
      required final BadgeColor type}) = _$BadgeImpl;

  factory _Badge.fromJson(Map<String, dynamic> json) = _$BadgeImpl.fromJson;

  @override
  String get text;
  @override
  BadgeColor get type;

  /// Create a copy of Badge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BadgeImplCopyWith<_$BadgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SourceVersion _$SourceVersionFromJson(Map<String, dynamic> json) {
  return _SourceVersion.fromJson(json);
}

/// @nodoc
mixin _$SourceVersion {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  ContentRating get contentRating => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get websiteBaseURL => throw _privateConstructorUsedError;
  String? get authorWebsite => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  List<Badge>? get tags => throw _privateConstructorUsedError;
  int? get intents => throw _privateConstructorUsedError;

  /// Serializes this SourceVersion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SourceVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SourceVersionCopyWith<SourceVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceVersionCopyWith<$Res> {
  factory $SourceVersionCopyWith(
          SourceVersion value, $Res Function(SourceVersion) then) =
      _$SourceVersionCopyWithImpl<$Res, SourceVersion>;
  @useResult
  $Res call(
      {String id,
      String name,
      String author,
      String desc,
      String? website,
      ContentRating contentRating,
      String version,
      String icon,
      String websiteBaseURL,
      String? authorWebsite,
      String? language,
      List<Badge>? tags,
      int? intents});
}

/// @nodoc
class _$SourceVersionCopyWithImpl<$Res, $Val extends SourceVersion>
    implements $SourceVersionCopyWith<$Res> {
  _$SourceVersionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SourceVersion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? author = null,
    Object? desc = null,
    Object? website = freezed,
    Object? contentRating = null,
    Object? version = null,
    Object? icon = null,
    Object? websiteBaseURL = null,
    Object? authorWebsite = freezed,
    Object? language = freezed,
    Object? tags = freezed,
    Object? intents = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      contentRating: null == contentRating
          ? _value.contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as ContentRating,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      websiteBaseURL: null == websiteBaseURL
          ? _value.websiteBaseURL
          : websiteBaseURL // ignore: cast_nullable_to_non_nullable
              as String,
      authorWebsite: freezed == authorWebsite
          ? _value.authorWebsite
          : authorWebsite // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Badge>?,
      intents: freezed == intents
          ? _value.intents
          : intents // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SourceVersionImplCopyWith<$Res>
    implements $SourceVersionCopyWith<$Res> {
  factory _$$SourceVersionImplCopyWith(
          _$SourceVersionImpl value, $Res Function(_$SourceVersionImpl) then) =
      __$$SourceVersionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String author,
      String desc,
      String? website,
      ContentRating contentRating,
      String version,
      String icon,
      String websiteBaseURL,
      String? authorWebsite,
      String? language,
      List<Badge>? tags,
      int? intents});
}

/// @nodoc
class __$$SourceVersionImplCopyWithImpl<$Res>
    extends _$SourceVersionCopyWithImpl<$Res, _$SourceVersionImpl>
    implements _$$SourceVersionImplCopyWith<$Res> {
  __$$SourceVersionImplCopyWithImpl(
      _$SourceVersionImpl _value, $Res Function(_$SourceVersionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SourceVersion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? author = null,
    Object? desc = null,
    Object? website = freezed,
    Object? contentRating = null,
    Object? version = null,
    Object? icon = null,
    Object? websiteBaseURL = null,
    Object? authorWebsite = freezed,
    Object? language = freezed,
    Object? tags = freezed,
    Object? intents = freezed,
  }) {
    return _then(_$SourceVersionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      contentRating: null == contentRating
          ? _value.contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as ContentRating,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      websiteBaseURL: null == websiteBaseURL
          ? _value.websiteBaseURL
          : websiteBaseURL // ignore: cast_nullable_to_non_nullable
              as String,
      authorWebsite: freezed == authorWebsite
          ? _value.authorWebsite
          : authorWebsite // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Badge>?,
      intents: freezed == intents
          ? _value.intents
          : intents // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceVersionImpl implements _SourceVersion {
  const _$SourceVersionImpl(
      {required this.id,
      required this.name,
      required this.author,
      required this.desc,
      this.website,
      required this.contentRating,
      required this.version,
      required this.icon,
      required this.websiteBaseURL,
      this.authorWebsite,
      this.language,
      final List<Badge>? tags,
      this.intents})
      : _tags = tags;

  factory _$SourceVersionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceVersionImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String author;
  @override
  final String desc;
  @override
  final String? website;
  @override
  final ContentRating contentRating;
  @override
  final String version;
  @override
  final String icon;
  @override
  final String websiteBaseURL;
  @override
  final String? authorWebsite;
  @override
  final String? language;
  final List<Badge>? _tags;
  @override
  List<Badge>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? intents;

  @override
  String toString() {
    return 'SourceVersion(id: $id, name: $name, author: $author, desc: $desc, website: $website, contentRating: $contentRating, version: $version, icon: $icon, websiteBaseURL: $websiteBaseURL, authorWebsite: $authorWebsite, language: $language, tags: $tags, intents: $intents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceVersionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.contentRating, contentRating) ||
                other.contentRating == contentRating) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.websiteBaseURL, websiteBaseURL) ||
                other.websiteBaseURL == websiteBaseURL) &&
            (identical(other.authorWebsite, authorWebsite) ||
                other.authorWebsite == authorWebsite) &&
            (identical(other.language, language) ||
                other.language == language) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.intents, intents) || other.intents == intents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      author,
      desc,
      website,
      contentRating,
      version,
      icon,
      websiteBaseURL,
      authorWebsite,
      language,
      const DeepCollectionEquality().hash(_tags),
      intents);

  /// Create a copy of SourceVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceVersionImplCopyWith<_$SourceVersionImpl> get copyWith =>
      __$$SourceVersionImplCopyWithImpl<_$SourceVersionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceVersionImplToJson(
      this,
    );
  }
}

abstract class _SourceVersion implements SourceVersion {
  const factory _SourceVersion(
      {required final String id,
      required final String name,
      required final String author,
      required final String desc,
      final String? website,
      required final ContentRating contentRating,
      required final String version,
      required final String icon,
      required final String websiteBaseURL,
      final String? authorWebsite,
      final String? language,
      final List<Badge>? tags,
      final int? intents}) = _$SourceVersionImpl;

  factory _SourceVersion.fromJson(Map<String, dynamic> json) =
      _$SourceVersionImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get author;
  @override
  String get desc;
  @override
  String? get website;
  @override
  ContentRating get contentRating;
  @override
  String get version;
  @override
  String get icon;
  @override
  String get websiteBaseURL;
  @override
  String? get authorWebsite;
  @override
  String? get language;
  @override
  List<Badge>? get tags;
  @override
  int? get intents;

  /// Create a copy of SourceVersion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceVersionImplCopyWith<_$SourceVersionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BuiltWith _$BuiltWithFromJson(Map<String, dynamic> json) {
  return _BuiltWith.fromJson(json);
}

/// @nodoc
mixin _$BuiltWith {
  String get toolchain => throw _privateConstructorUsedError;
  String get types => throw _privateConstructorUsedError;

  /// Serializes this BuiltWith to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BuiltWith
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BuiltWithCopyWith<BuiltWith> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuiltWithCopyWith<$Res> {
  factory $BuiltWithCopyWith(BuiltWith value, $Res Function(BuiltWith) then) =
      _$BuiltWithCopyWithImpl<$Res, BuiltWith>;
  @useResult
  $Res call({String toolchain, String types});
}

/// @nodoc
class _$BuiltWithCopyWithImpl<$Res, $Val extends BuiltWith>
    implements $BuiltWithCopyWith<$Res> {
  _$BuiltWithCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BuiltWith
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toolchain = null,
    Object? types = null,
  }) {
    return _then(_value.copyWith(
      toolchain: null == toolchain
          ? _value.toolchain
          : toolchain // ignore: cast_nullable_to_non_nullable
              as String,
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BuiltWithImplCopyWith<$Res>
    implements $BuiltWithCopyWith<$Res> {
  factory _$$BuiltWithImplCopyWith(
          _$BuiltWithImpl value, $Res Function(_$BuiltWithImpl) then) =
      __$$BuiltWithImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String toolchain, String types});
}

/// @nodoc
class __$$BuiltWithImplCopyWithImpl<$Res>
    extends _$BuiltWithCopyWithImpl<$Res, _$BuiltWithImpl>
    implements _$$BuiltWithImplCopyWith<$Res> {
  __$$BuiltWithImplCopyWithImpl(
      _$BuiltWithImpl _value, $Res Function(_$BuiltWithImpl) _then)
      : super(_value, _then);

  /// Create a copy of BuiltWith
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toolchain = null,
    Object? types = null,
  }) {
    return _then(_$BuiltWithImpl(
      toolchain: null == toolchain
          ? _value.toolchain
          : toolchain // ignore: cast_nullable_to_non_nullable
              as String,
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BuiltWithImpl implements _BuiltWith {
  const _$BuiltWithImpl({required this.toolchain, required this.types});

  factory _$BuiltWithImpl.fromJson(Map<String, dynamic> json) =>
      _$$BuiltWithImplFromJson(json);

  @override
  final String toolchain;
  @override
  final String types;

  @override
  String toString() {
    return 'BuiltWith(toolchain: $toolchain, types: $types)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuiltWithImpl &&
            (identical(other.toolchain, toolchain) ||
                other.toolchain == toolchain) &&
            (identical(other.types, types) || other.types == types));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, toolchain, types);

  /// Create a copy of BuiltWith
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuiltWithImplCopyWith<_$BuiltWithImpl> get copyWith =>
      __$$BuiltWithImplCopyWithImpl<_$BuiltWithImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BuiltWithImplToJson(
      this,
    );
  }
}

abstract class _BuiltWith implements BuiltWith {
  const factory _BuiltWith(
      {required final String toolchain,
      required final String types}) = _$BuiltWithImpl;

  factory _BuiltWith.fromJson(Map<String, dynamic> json) =
      _$BuiltWithImpl.fromJson;

  @override
  String get toolchain;
  @override
  String get types;

  /// Create a copy of BuiltWith
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuiltWithImplCopyWith<_$BuiltWithImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Versioning _$VersioningFromJson(Map<String, dynamic> json) {
  return _Versioning.fromJson(json);
}

/// @nodoc
mixin _$Versioning {
  String get buildTime => throw _privateConstructorUsedError;
  List<SourceVersion> get sources => throw _privateConstructorUsedError;
  BuiltWith get builtWith => throw _privateConstructorUsedError;

  /// Serializes this Versioning to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Versioning
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VersioningCopyWith<Versioning> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VersioningCopyWith<$Res> {
  factory $VersioningCopyWith(
          Versioning value, $Res Function(Versioning) then) =
      _$VersioningCopyWithImpl<$Res, Versioning>;
  @useResult
  $Res call(
      {String buildTime, List<SourceVersion> sources, BuiltWith builtWith});

  $BuiltWithCopyWith<$Res> get builtWith;
}

/// @nodoc
class _$VersioningCopyWithImpl<$Res, $Val extends Versioning>
    implements $VersioningCopyWith<$Res> {
  _$VersioningCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Versioning
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildTime = null,
    Object? sources = null,
    Object? builtWith = null,
  }) {
    return _then(_value.copyWith(
      buildTime: null == buildTime
          ? _value.buildTime
          : buildTime // ignore: cast_nullable_to_non_nullable
              as String,
      sources: null == sources
          ? _value.sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<SourceVersion>,
      builtWith: null == builtWith
          ? _value.builtWith
          : builtWith // ignore: cast_nullable_to_non_nullable
              as BuiltWith,
    ) as $Val);
  }

  /// Create a copy of Versioning
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BuiltWithCopyWith<$Res> get builtWith {
    return $BuiltWithCopyWith<$Res>(_value.builtWith, (value) {
      return _then(_value.copyWith(builtWith: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VersioningImplCopyWith<$Res>
    implements $VersioningCopyWith<$Res> {
  factory _$$VersioningImplCopyWith(
          _$VersioningImpl value, $Res Function(_$VersioningImpl) then) =
      __$$VersioningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String buildTime, List<SourceVersion> sources, BuiltWith builtWith});

  @override
  $BuiltWithCopyWith<$Res> get builtWith;
}

/// @nodoc
class __$$VersioningImplCopyWithImpl<$Res>
    extends _$VersioningCopyWithImpl<$Res, _$VersioningImpl>
    implements _$$VersioningImplCopyWith<$Res> {
  __$$VersioningImplCopyWithImpl(
      _$VersioningImpl _value, $Res Function(_$VersioningImpl) _then)
      : super(_value, _then);

  /// Create a copy of Versioning
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildTime = null,
    Object? sources = null,
    Object? builtWith = null,
  }) {
    return _then(_$VersioningImpl(
      buildTime: null == buildTime
          ? _value.buildTime
          : buildTime // ignore: cast_nullable_to_non_nullable
              as String,
      sources: null == sources
          ? _value._sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<SourceVersion>,
      builtWith: null == builtWith
          ? _value.builtWith
          : builtWith // ignore: cast_nullable_to_non_nullable
              as BuiltWith,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VersioningImpl implements _Versioning {
  const _$VersioningImpl(
      {required this.buildTime,
      required final List<SourceVersion> sources,
      required this.builtWith})
      : _sources = sources;

  factory _$VersioningImpl.fromJson(Map<String, dynamic> json) =>
      _$$VersioningImplFromJson(json);

  @override
  final String buildTime;
  final List<SourceVersion> _sources;
  @override
  List<SourceVersion> get sources {
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sources);
  }

  @override
  final BuiltWith builtWith;

  @override
  String toString() {
    return 'Versioning(buildTime: $buildTime, sources: $sources, builtWith: $builtWith)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VersioningImpl &&
            (identical(other.buildTime, buildTime) ||
                other.buildTime == buildTime) &&
            const DeepCollectionEquality().equals(other._sources, _sources) &&
            (identical(other.builtWith, builtWith) ||
                other.builtWith == builtWith));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, buildTime,
      const DeepCollectionEquality().hash(_sources), builtWith);

  /// Create a copy of Versioning
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VersioningImplCopyWith<_$VersioningImpl> get copyWith =>
      __$$VersioningImplCopyWithImpl<_$VersioningImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VersioningImplToJson(
      this,
    );
  }
}

abstract class _Versioning implements Versioning {
  const factory _Versioning(
      {required final String buildTime,
      required final List<SourceVersion> sources,
      required final BuiltWith builtWith}) = _$VersioningImpl;

  factory _Versioning.fromJson(Map<String, dynamic> json) =
      _$VersioningImpl.fromJson;

  @override
  String get buildTime;
  @override
  List<SourceVersion> get sources;
  @override
  BuiltWith get builtWith;

  /// Create a copy of Versioning
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VersioningImplCopyWith<_$VersioningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RepoInfo _$RepoInfoFromJson(Map<String, dynamic> json) {
  return _RepoInfo.fromJson(json);
}

/// @nodoc
mixin _$RepoInfo {
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this RepoInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RepoInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepoInfoCopyWith<RepoInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoInfoCopyWith<$Res> {
  factory $RepoInfoCopyWith(RepoInfo value, $Res Function(RepoInfo) then) =
      _$RepoInfoCopyWithImpl<$Res, RepoInfo>;
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class _$RepoInfoCopyWithImpl<$Res, $Val extends RepoInfo>
    implements $RepoInfoCopyWith<$Res> {
  _$RepoInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepoInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RepoInfoImplCopyWith<$Res>
    implements $RepoInfoCopyWith<$Res> {
  factory _$$RepoInfoImplCopyWith(
          _$RepoInfoImpl value, $Res Function(_$RepoInfoImpl) then) =
      __$$RepoInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class __$$RepoInfoImplCopyWithImpl<$Res>
    extends _$RepoInfoCopyWithImpl<$Res, _$RepoInfoImpl>
    implements _$$RepoInfoImplCopyWith<$Res> {
  __$$RepoInfoImplCopyWithImpl(
      _$RepoInfoImpl _value, $Res Function(_$RepoInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of RepoInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
  }) {
    return _then(_$RepoInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RepoInfoImpl implements _RepoInfo {
  const _$RepoInfoImpl({required this.name, required this.url});

  factory _$RepoInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepoInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String url;

  @override
  String toString() {
    return 'RepoInfo(name: $name, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepoInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  /// Create a copy of RepoInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepoInfoImplCopyWith<_$RepoInfoImpl> get copyWith =>
      __$$RepoInfoImplCopyWithImpl<_$RepoInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RepoInfoImplToJson(
      this,
    );
  }
}

abstract class _RepoInfo implements RepoInfo {
  const factory _RepoInfo(
      {required final String name, required final String url}) = _$RepoInfoImpl;

  factory _RepoInfo.fromJson(Map<String, dynamic> json) =
      _$RepoInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get url;

  /// Create a copy of RepoInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepoInfoImplCopyWith<_$RepoInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PartialSourceManga _$PartialSourceMangaFromJson(Map<String, dynamic> json) {
  return _PartialSourceManga.fromJson(json);
}

/// @nodoc
mixin _$PartialSourceManga {
  String get mangaId => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;

  /// Serializes this PartialSourceManga to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartialSourceManga
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartialSourceMangaCopyWith<PartialSourceManga> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartialSourceMangaCopyWith<$Res> {
  factory $PartialSourceMangaCopyWith(
          PartialSourceManga value, $Res Function(PartialSourceManga) then) =
      _$PartialSourceMangaCopyWithImpl<$Res, PartialSourceManga>;
  @useResult
  $Res call({String mangaId, String image, String title, String? subtitle});
}

/// @nodoc
class _$PartialSourceMangaCopyWithImpl<$Res, $Val extends PartialSourceManga>
    implements $PartialSourceMangaCopyWith<$Res> {
  _$PartialSourceMangaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartialSourceManga
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mangaId = null,
    Object? image = null,
    Object? title = null,
    Object? subtitle = freezed,
  }) {
    return _then(_value.copyWith(
      mangaId: null == mangaId
          ? _value.mangaId
          : mangaId // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartialSourceMangaImplCopyWith<$Res>
    implements $PartialSourceMangaCopyWith<$Res> {
  factory _$$PartialSourceMangaImplCopyWith(_$PartialSourceMangaImpl value,
          $Res Function(_$PartialSourceMangaImpl) then) =
      __$$PartialSourceMangaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String mangaId, String image, String title, String? subtitle});
}

/// @nodoc
class __$$PartialSourceMangaImplCopyWithImpl<$Res>
    extends _$PartialSourceMangaCopyWithImpl<$Res, _$PartialSourceMangaImpl>
    implements _$$PartialSourceMangaImplCopyWith<$Res> {
  __$$PartialSourceMangaImplCopyWithImpl(_$PartialSourceMangaImpl _value,
      $Res Function(_$PartialSourceMangaImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartialSourceManga
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mangaId = null,
    Object? image = null,
    Object? title = null,
    Object? subtitle = freezed,
  }) {
    return _then(_$PartialSourceMangaImpl(
      mangaId: null == mangaId
          ? _value.mangaId
          : mangaId // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartialSourceMangaImpl implements _PartialSourceManga {
  const _$PartialSourceMangaImpl(
      {required this.mangaId,
      required this.image,
      required this.title,
      this.subtitle});

  factory _$PartialSourceMangaImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartialSourceMangaImplFromJson(json);

  @override
  final String mangaId;
  @override
  final String image;
  @override
  final String title;
  @override
  final String? subtitle;

  @override
  String toString() {
    return 'PartialSourceManga(mangaId: $mangaId, image: $image, title: $title, subtitle: $subtitle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartialSourceMangaImpl &&
            (identical(other.mangaId, mangaId) || other.mangaId == mangaId) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mangaId, image, title, subtitle);

  /// Create a copy of PartialSourceManga
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartialSourceMangaImplCopyWith<_$PartialSourceMangaImpl> get copyWith =>
      __$$PartialSourceMangaImplCopyWithImpl<_$PartialSourceMangaImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartialSourceMangaImplToJson(
      this,
    );
  }
}

abstract class _PartialSourceManga implements PartialSourceManga {
  const factory _PartialSourceManga(
      {required final String mangaId,
      required final String image,
      required final String title,
      final String? subtitle}) = _$PartialSourceMangaImpl;

  factory _PartialSourceManga.fromJson(Map<String, dynamic> json) =
      _$PartialSourceMangaImpl.fromJson;

  @override
  String get mangaId;
  @override
  String get image;
  @override
  String get title;
  @override
  String? get subtitle;

  /// Create a copy of PartialSourceManga
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartialSourceMangaImplCopyWith<_$PartialSourceMangaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PagedResults _$PagedResultsFromJson(Map<String, dynamic> json) {
  return _PagedResults.fromJson(json);
}

/// @nodoc
mixin _$PagedResults {
  List<PartialSourceManga>? get results => throw _privateConstructorUsedError;
  dynamic get metadata => throw _privateConstructorUsedError;

  /// Serializes this PagedResults to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PagedResults
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PagedResultsCopyWith<PagedResults> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagedResultsCopyWith<$Res> {
  factory $PagedResultsCopyWith(
          PagedResults value, $Res Function(PagedResults) then) =
      _$PagedResultsCopyWithImpl<$Res, PagedResults>;
  @useResult
  $Res call({List<PartialSourceManga>? results, dynamic metadata});
}

/// @nodoc
class _$PagedResultsCopyWithImpl<$Res, $Val extends PagedResults>
    implements $PagedResultsCopyWith<$Res> {
  _$PagedResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PagedResults
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      results: freezed == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<PartialSourceManga>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PagedResultsImplCopyWith<$Res>
    implements $PagedResultsCopyWith<$Res> {
  factory _$$PagedResultsImplCopyWith(
          _$PagedResultsImpl value, $Res Function(_$PagedResultsImpl) then) =
      __$$PagedResultsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PartialSourceManga>? results, dynamic metadata});
}

/// @nodoc
class __$$PagedResultsImplCopyWithImpl<$Res>
    extends _$PagedResultsCopyWithImpl<$Res, _$PagedResultsImpl>
    implements _$$PagedResultsImplCopyWith<$Res> {
  __$$PagedResultsImplCopyWithImpl(
      _$PagedResultsImpl _value, $Res Function(_$PagedResultsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PagedResults
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$PagedResultsImpl(
      results: freezed == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<PartialSourceManga>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PagedResultsImpl implements _PagedResults {
  const _$PagedResultsImpl(
      {final List<PartialSourceManga>? results, this.metadata})
      : _results = results;

  factory _$PagedResultsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PagedResultsImplFromJson(json);

  final List<PartialSourceManga>? _results;
  @override
  List<PartialSourceManga>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final dynamic metadata;

  @override
  String toString() {
    return 'PagedResults(results: $results, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagedResultsImpl &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_results),
      const DeepCollectionEquality().hash(metadata));

  /// Create a copy of PagedResults
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PagedResultsImplCopyWith<_$PagedResultsImpl> get copyWith =>
      __$$PagedResultsImplCopyWithImpl<_$PagedResultsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PagedResultsImplToJson(
      this,
    );
  }
}

abstract class _PagedResults implements PagedResults {
  const factory _PagedResults(
      {final List<PartialSourceManga>? results,
      final dynamic metadata}) = _$PagedResultsImpl;

  factory _PagedResults.fromJson(Map<String, dynamic> json) =
      _$PagedResultsImpl.fromJson;

  @override
  List<PartialSourceManga>? get results;
  @override
  dynamic get metadata;

  /// Create a copy of PagedResults
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PagedResultsImplCopyWith<_$PagedResultsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MangaInfo _$MangaInfoFromJson(Map<String, dynamic> json) {
  return _MangaInfo.fromJson(json);
}

/// @nodoc
mixin _$MangaInfo {
  String get image => throw _privateConstructorUsedError;
  String? get artist => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  bool? get hentai => throw _privateConstructorUsedError;
  List<String> get titles => throw _privateConstructorUsedError;
  String? get banner => throw _privateConstructorUsedError;
  num? get rating => throw _privateConstructorUsedError;
  List<TagSection>? get tags => throw _privateConstructorUsedError;
  List<String>? get covers => throw _privateConstructorUsedError;

  /// Serializes this MangaInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MangaInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MangaInfoCopyWith<MangaInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaInfoCopyWith<$Res> {
  factory $MangaInfoCopyWith(MangaInfo value, $Res Function(MangaInfo) then) =
      _$MangaInfoCopyWithImpl<$Res, MangaInfo>;
  @useResult
  $Res call(
      {String image,
      String? artist,
      String? author,
      String desc,
      String status,
      bool? hentai,
      List<String> titles,
      String? banner,
      num? rating,
      List<TagSection>? tags,
      List<String>? covers});
}

/// @nodoc
class _$MangaInfoCopyWithImpl<$Res, $Val extends MangaInfo>
    implements $MangaInfoCopyWith<$Res> {
  _$MangaInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MangaInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? artist = freezed,
    Object? author = freezed,
    Object? desc = null,
    Object? status = null,
    Object? hentai = freezed,
    Object? titles = null,
    Object? banner = freezed,
    Object? rating = freezed,
    Object? tags = freezed,
    Object? covers = freezed,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      artist: freezed == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      hentai: freezed == hentai
          ? _value.hentai
          : hentai // ignore: cast_nullable_to_non_nullable
              as bool?,
      titles: null == titles
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      banner: freezed == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagSection>?,
      covers: freezed == covers
          ? _value.covers
          : covers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MangaInfoImplCopyWith<$Res>
    implements $MangaInfoCopyWith<$Res> {
  factory _$$MangaInfoImplCopyWith(
          _$MangaInfoImpl value, $Res Function(_$MangaInfoImpl) then) =
      __$$MangaInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String image,
      String? artist,
      String? author,
      String desc,
      String status,
      bool? hentai,
      List<String> titles,
      String? banner,
      num? rating,
      List<TagSection>? tags,
      List<String>? covers});
}

/// @nodoc
class __$$MangaInfoImplCopyWithImpl<$Res>
    extends _$MangaInfoCopyWithImpl<$Res, _$MangaInfoImpl>
    implements _$$MangaInfoImplCopyWith<$Res> {
  __$$MangaInfoImplCopyWithImpl(
      _$MangaInfoImpl _value, $Res Function(_$MangaInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? artist = freezed,
    Object? author = freezed,
    Object? desc = null,
    Object? status = null,
    Object? hentai = freezed,
    Object? titles = null,
    Object? banner = freezed,
    Object? rating = freezed,
    Object? tags = freezed,
    Object? covers = freezed,
  }) {
    return _then(_$MangaInfoImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      artist: freezed == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      hentai: freezed == hentai
          ? _value.hentai
          : hentai // ignore: cast_nullable_to_non_nullable
              as bool?,
      titles: null == titles
          ? _value._titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      banner: freezed == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagSection>?,
      covers: freezed == covers
          ? _value._covers
          : covers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaInfoImpl implements _MangaInfo {
  const _$MangaInfoImpl(
      {required this.image,
      this.artist,
      this.author,
      required this.desc,
      required this.status,
      this.hentai,
      required final List<String> titles,
      this.banner,
      this.rating,
      final List<TagSection>? tags,
      final List<String>? covers})
      : _titles = titles,
        _tags = tags,
        _covers = covers;

  factory _$MangaInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaInfoImplFromJson(json);

  @override
  final String image;
  @override
  final String? artist;
  @override
  final String? author;
  @override
  final String desc;
  @override
  final String status;
  @override
  final bool? hentai;
  final List<String> _titles;
  @override
  List<String> get titles {
    if (_titles is EqualUnmodifiableListView) return _titles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_titles);
  }

  @override
  final String? banner;
  @override
  final num? rating;
  final List<TagSection>? _tags;
  @override
  List<TagSection>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _covers;
  @override
  List<String>? get covers {
    final value = _covers;
    if (value == null) return null;
    if (_covers is EqualUnmodifiableListView) return _covers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MangaInfo(image: $image, artist: $artist, author: $author, desc: $desc, status: $status, hentai: $hentai, titles: $titles, banner: $banner, rating: $rating, tags: $tags, covers: $covers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaInfoImpl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.hentai, hentai) || other.hentai == hentai) &&
            const DeepCollectionEquality().equals(other._titles, _titles) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._covers, _covers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      image,
      artist,
      author,
      desc,
      status,
      hentai,
      const DeepCollectionEquality().hash(_titles),
      banner,
      rating,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_covers));

  /// Create a copy of MangaInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaInfoImplCopyWith<_$MangaInfoImpl> get copyWith =>
      __$$MangaInfoImplCopyWithImpl<_$MangaInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaInfoImplToJson(
      this,
    );
  }
}

abstract class _MangaInfo implements MangaInfo {
  const factory _MangaInfo(
      {required final String image,
      final String? artist,
      final String? author,
      required final String desc,
      required final String status,
      final bool? hentai,
      required final List<String> titles,
      final String? banner,
      final num? rating,
      final List<TagSection>? tags,
      final List<String>? covers}) = _$MangaInfoImpl;

  factory _MangaInfo.fromJson(Map<String, dynamic> json) =
      _$MangaInfoImpl.fromJson;

  @override
  String get image;
  @override
  String? get artist;
  @override
  String? get author;
  @override
  String get desc;
  @override
  String get status;
  @override
  bool? get hentai;
  @override
  List<String> get titles;
  @override
  String? get banner;
  @override
  num? get rating;
  @override
  List<TagSection>? get tags;
  @override
  List<String>? get covers;

  /// Create a copy of MangaInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MangaInfoImplCopyWith<_$MangaInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Tag _$TagFromJson(Map<String, dynamic> json) {
  return _Tag.fromJson(json);
}

/// @nodoc
mixin _$Tag {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  /// Serializes this Tag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TagCopyWith<Tag> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagCopyWith<$Res> {
  factory $TagCopyWith(Tag value, $Res Function(Tag) then) =
      _$TagCopyWithImpl<$Res, Tag>;
  @useResult
  $Res call({String id, String label});
}

/// @nodoc
class _$TagCopyWithImpl<$Res, $Val extends Tag> implements $TagCopyWith<$Res> {
  _$TagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagImplCopyWith<$Res> implements $TagCopyWith<$Res> {
  factory _$$TagImplCopyWith(_$TagImpl value, $Res Function(_$TagImpl) then) =
      __$$TagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String label});
}

/// @nodoc
class __$$TagImplCopyWithImpl<$Res> extends _$TagCopyWithImpl<$Res, _$TagImpl>
    implements _$$TagImplCopyWith<$Res> {
  __$$TagImplCopyWithImpl(_$TagImpl _value, $Res Function(_$TagImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
  }) {
    return _then(_$TagImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TagImpl implements _Tag {
  const _$TagImpl({required this.id, required this.label});

  factory _$TagImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagImplFromJson(json);

  @override
  final String id;
  @override
  final String label;

  @override
  String toString() {
    return 'Tag(id: $id, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label);

  /// Create a copy of Tag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagImplCopyWith<_$TagImpl> get copyWith =>
      __$$TagImplCopyWithImpl<_$TagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagImplToJson(
      this,
    );
  }
}

abstract class _Tag implements Tag {
  const factory _Tag({required final String id, required final String label}) =
      _$TagImpl;

  factory _Tag.fromJson(Map<String, dynamic> json) = _$TagImpl.fromJson;

  @override
  String get id;
  @override
  String get label;

  /// Create a copy of Tag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagImplCopyWith<_$TagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TagSection _$TagSectionFromJson(Map<String, dynamic> json) {
  return _TagSection.fromJson(json);
}

/// @nodoc
mixin _$TagSection {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  List<Tag> get tags => throw _privateConstructorUsedError;

  /// Serializes this TagSection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TagSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TagSectionCopyWith<TagSection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagSectionCopyWith<$Res> {
  factory $TagSectionCopyWith(
          TagSection value, $Res Function(TagSection) then) =
      _$TagSectionCopyWithImpl<$Res, TagSection>;
  @useResult
  $Res call({String id, String label, List<Tag> tags});
}

/// @nodoc
class _$TagSectionCopyWithImpl<$Res, $Val extends TagSection>
    implements $TagSectionCopyWith<$Res> {
  _$TagSectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TagSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagSectionImplCopyWith<$Res>
    implements $TagSectionCopyWith<$Res> {
  factory _$$TagSectionImplCopyWith(
          _$TagSectionImpl value, $Res Function(_$TagSectionImpl) then) =
      __$$TagSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String label, List<Tag> tags});
}

/// @nodoc
class __$$TagSectionImplCopyWithImpl<$Res>
    extends _$TagSectionCopyWithImpl<$Res, _$TagSectionImpl>
    implements _$$TagSectionImplCopyWith<$Res> {
  __$$TagSectionImplCopyWithImpl(
      _$TagSectionImpl _value, $Res Function(_$TagSectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TagSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? tags = null,
  }) {
    return _then(_$TagSectionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TagSectionImpl implements _TagSection {
  const _$TagSectionImpl(
      {required this.id, required this.label, required final List<Tag> tags})
      : _tags = tags;

  factory _$TagSectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagSectionImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  final List<Tag> _tags;
  @override
  List<Tag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'TagSection(id: $id, label: $label, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagSectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, label, const DeepCollectionEquality().hash(_tags));

  /// Create a copy of TagSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagSectionImplCopyWith<_$TagSectionImpl> get copyWith =>
      __$$TagSectionImplCopyWithImpl<_$TagSectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagSectionImplToJson(
      this,
    );
  }
}

abstract class _TagSection implements TagSection {
  const factory _TagSection(
      {required final String id,
      required final String label,
      required final List<Tag> tags}) = _$TagSectionImpl;

  factory _TagSection.fromJson(Map<String, dynamic> json) =
      _$TagSectionImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  List<Tag> get tags;

  /// Create a copy of TagSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagSectionImplCopyWith<_$TagSectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SourceManga _$SourceMangaFromJson(Map<String, dynamic> json) {
  return _SourceManga.fromJson(json);
}

/// @nodoc
mixin _$SourceManga {
  String get id => throw _privateConstructorUsedError;
  MangaInfo get mangaInfo => throw _privateConstructorUsedError;

  /// Serializes this SourceManga to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SourceManga
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SourceMangaCopyWith<SourceManga> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceMangaCopyWith<$Res> {
  factory $SourceMangaCopyWith(
          SourceManga value, $Res Function(SourceManga) then) =
      _$SourceMangaCopyWithImpl<$Res, SourceManga>;
  @useResult
  $Res call({String id, MangaInfo mangaInfo});

  $MangaInfoCopyWith<$Res> get mangaInfo;
}

/// @nodoc
class _$SourceMangaCopyWithImpl<$Res, $Val extends SourceManga>
    implements $SourceMangaCopyWith<$Res> {
  _$SourceMangaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SourceManga
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mangaInfo = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mangaInfo: null == mangaInfo
          ? _value.mangaInfo
          : mangaInfo // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
    ) as $Val);
  }

  /// Create a copy of SourceManga
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MangaInfoCopyWith<$Res> get mangaInfo {
    return $MangaInfoCopyWith<$Res>(_value.mangaInfo, (value) {
      return _then(_value.copyWith(mangaInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SourceMangaImplCopyWith<$Res>
    implements $SourceMangaCopyWith<$Res> {
  factory _$$SourceMangaImplCopyWith(
          _$SourceMangaImpl value, $Res Function(_$SourceMangaImpl) then) =
      __$$SourceMangaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, MangaInfo mangaInfo});

  @override
  $MangaInfoCopyWith<$Res> get mangaInfo;
}

/// @nodoc
class __$$SourceMangaImplCopyWithImpl<$Res>
    extends _$SourceMangaCopyWithImpl<$Res, _$SourceMangaImpl>
    implements _$$SourceMangaImplCopyWith<$Res> {
  __$$SourceMangaImplCopyWithImpl(
      _$SourceMangaImpl _value, $Res Function(_$SourceMangaImpl) _then)
      : super(_value, _then);

  /// Create a copy of SourceManga
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mangaInfo = null,
  }) {
    return _then(_$SourceMangaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mangaInfo: null == mangaInfo
          ? _value.mangaInfo
          : mangaInfo // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceMangaImpl implements _SourceManga {
  const _$SourceMangaImpl({required this.id, required this.mangaInfo});

  factory _$SourceMangaImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceMangaImplFromJson(json);

  @override
  final String id;
  @override
  final MangaInfo mangaInfo;

  @override
  String toString() {
    return 'SourceManga(id: $id, mangaInfo: $mangaInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceMangaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mangaInfo, mangaInfo) ||
                other.mangaInfo == mangaInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, mangaInfo);

  /// Create a copy of SourceManga
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceMangaImplCopyWith<_$SourceMangaImpl> get copyWith =>
      __$$SourceMangaImplCopyWithImpl<_$SourceMangaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceMangaImplToJson(
      this,
    );
  }
}

abstract class _SourceManga implements SourceManga {
  const factory _SourceManga(
      {required final String id,
      required final MangaInfo mangaInfo}) = _$SourceMangaImpl;

  factory _SourceManga.fromJson(Map<String, dynamic> json) =
      _$SourceMangaImpl.fromJson;

  @override
  String get id;
  @override
  MangaInfo get mangaInfo;

  /// Create a copy of SourceManga
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceMangaImplCopyWith<_$SourceMangaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Chapter _$ChapterFromJson(Map<String, dynamic> json) {
  return _Chapter.fromJson(json);
}

/// @nodoc
mixin _$Chapter {
  String get id => throw _privateConstructorUsedError;
  num get chapNum => throw _privateConstructorUsedError;
  String? get langCode => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  num? get volume => throw _privateConstructorUsedError;
  String? get group => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime? get time => throw _privateConstructorUsedError;
  num? get sortingIndex => throw _privateConstructorUsedError;

  /// Serializes this Chapter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChapterCopyWith<Chapter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterCopyWith<$Res> {
  factory $ChapterCopyWith(Chapter value, $Res Function(Chapter) then) =
      _$ChapterCopyWithImpl<$Res, Chapter>;
  @useResult
  $Res call(
      {String id,
      num chapNum,
      String? langCode,
      String? name,
      num? volume,
      String? group,
      @TimestampSerializer() DateTime? time,
      num? sortingIndex});
}

/// @nodoc
class _$ChapterCopyWithImpl<$Res, $Val extends Chapter>
    implements $ChapterCopyWith<$Res> {
  _$ChapterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chapNum = null,
    Object? langCode = freezed,
    Object? name = freezed,
    Object? volume = freezed,
    Object? group = freezed,
    Object? time = freezed,
    Object? sortingIndex = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chapNum: null == chapNum
          ? _value.chapNum
          : chapNum // ignore: cast_nullable_to_non_nullable
              as num,
      langCode: freezed == langCode
          ? _value.langCode
          : langCode // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      volume: freezed == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as num?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sortingIndex: freezed == sortingIndex
          ? _value.sortingIndex
          : sortingIndex // ignore: cast_nullable_to_non_nullable
              as num?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChapterImplCopyWith<$Res> implements $ChapterCopyWith<$Res> {
  factory _$$ChapterImplCopyWith(
          _$ChapterImpl value, $Res Function(_$ChapterImpl) then) =
      __$$ChapterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      num chapNum,
      String? langCode,
      String? name,
      num? volume,
      String? group,
      @TimestampSerializer() DateTime? time,
      num? sortingIndex});
}

/// @nodoc
class __$$ChapterImplCopyWithImpl<$Res>
    extends _$ChapterCopyWithImpl<$Res, _$ChapterImpl>
    implements _$$ChapterImplCopyWith<$Res> {
  __$$ChapterImplCopyWithImpl(
      _$ChapterImpl _value, $Res Function(_$ChapterImpl) _then)
      : super(_value, _then);

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chapNum = null,
    Object? langCode = freezed,
    Object? name = freezed,
    Object? volume = freezed,
    Object? group = freezed,
    Object? time = freezed,
    Object? sortingIndex = freezed,
  }) {
    return _then(_$ChapterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chapNum: null == chapNum
          ? _value.chapNum
          : chapNum // ignore: cast_nullable_to_non_nullable
              as num,
      langCode: freezed == langCode
          ? _value.langCode
          : langCode // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      volume: freezed == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as num?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sortingIndex: freezed == sortingIndex
          ? _value.sortingIndex
          : sortingIndex // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChapterImpl implements _Chapter {
  const _$ChapterImpl(
      {required this.id,
      required this.chapNum,
      this.langCode,
      this.name,
      this.volume,
      this.group,
      @TimestampSerializer() this.time,
      this.sortingIndex});

  factory _$ChapterImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterImplFromJson(json);

  @override
  final String id;
  @override
  final num chapNum;
  @override
  final String? langCode;
  @override
  final String? name;
  @override
  final num? volume;
  @override
  final String? group;
  @override
  @TimestampSerializer()
  final DateTime? time;
  @override
  final num? sortingIndex;

  @override
  String toString() {
    return 'Chapter(id: $id, chapNum: $chapNum, langCode: $langCode, name: $name, volume: $volume, group: $group, time: $time, sortingIndex: $sortingIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chapNum, chapNum) || other.chapNum == chapNum) &&
            (identical(other.langCode, langCode) ||
                other.langCode == langCode) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.sortingIndex, sortingIndex) ||
                other.sortingIndex == sortingIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, chapNum, langCode, name,
      volume, group, time, sortingIndex);

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
      __$$ChapterImplCopyWithImpl<_$ChapterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterImplToJson(
      this,
    );
  }
}

abstract class _Chapter implements Chapter {
  const factory _Chapter(
      {required final String id,
      required final num chapNum,
      final String? langCode,
      final String? name,
      final num? volume,
      final String? group,
      @TimestampSerializer() final DateTime? time,
      final num? sortingIndex}) = _$ChapterImpl;

  factory _Chapter.fromJson(Map<String, dynamic> json) = _$ChapterImpl.fromJson;

  @override
  String get id;
  @override
  num get chapNum;
  @override
  String? get langCode;
  @override
  String? get name;
  @override
  num? get volume;
  @override
  String? get group;
  @override
  @TimestampSerializer()
  DateTime? get time;
  @override
  num? get sortingIndex;

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChapterDetails _$ChapterDetailsFromJson(Map<String, dynamic> json) {
  return _ChapterDetails.fromJson(json);
}

/// @nodoc
mixin _$ChapterDetails {
  String get id => throw _privateConstructorUsedError;
  String get mangaId => throw _privateConstructorUsedError;
  List<String> get pages => throw _privateConstructorUsedError;

  /// Serializes this ChapterDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChapterDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChapterDetailsCopyWith<ChapterDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterDetailsCopyWith<$Res> {
  factory $ChapterDetailsCopyWith(
          ChapterDetails value, $Res Function(ChapterDetails) then) =
      _$ChapterDetailsCopyWithImpl<$Res, ChapterDetails>;
  @useResult
  $Res call({String id, String mangaId, List<String> pages});
}

/// @nodoc
class _$ChapterDetailsCopyWithImpl<$Res, $Val extends ChapterDetails>
    implements $ChapterDetailsCopyWith<$Res> {
  _$ChapterDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChapterDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mangaId = null,
    Object? pages = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mangaId: null == mangaId
          ? _value.mangaId
          : mangaId // ignore: cast_nullable_to_non_nullable
              as String,
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChapterDetailsImplCopyWith<$Res>
    implements $ChapterDetailsCopyWith<$Res> {
  factory _$$ChapterDetailsImplCopyWith(_$ChapterDetailsImpl value,
          $Res Function(_$ChapterDetailsImpl) then) =
      __$$ChapterDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String mangaId, List<String> pages});
}

/// @nodoc
class __$$ChapterDetailsImplCopyWithImpl<$Res>
    extends _$ChapterDetailsCopyWithImpl<$Res, _$ChapterDetailsImpl>
    implements _$$ChapterDetailsImplCopyWith<$Res> {
  __$$ChapterDetailsImplCopyWithImpl(
      _$ChapterDetailsImpl _value, $Res Function(_$ChapterDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChapterDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mangaId = null,
    Object? pages = null,
  }) {
    return _then(_$ChapterDetailsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mangaId: null == mangaId
          ? _value.mangaId
          : mangaId // ignore: cast_nullable_to_non_nullable
              as String,
      pages: null == pages
          ? _value._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChapterDetailsImpl implements _ChapterDetails {
  const _$ChapterDetailsImpl(
      {required this.id,
      required this.mangaId,
      required final List<String> pages})
      : _pages = pages;

  factory _$ChapterDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterDetailsImplFromJson(json);

  @override
  final String id;
  @override
  final String mangaId;
  final List<String> _pages;
  @override
  List<String> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  @override
  String toString() {
    return 'ChapterDetails(id: $id, mangaId: $mangaId, pages: $pages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterDetailsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mangaId, mangaId) || other.mangaId == mangaId) &&
            const DeepCollectionEquality().equals(other._pages, _pages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, mangaId, const DeepCollectionEquality().hash(_pages));

  /// Create a copy of ChapterDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterDetailsImplCopyWith<_$ChapterDetailsImpl> get copyWith =>
      __$$ChapterDetailsImplCopyWithImpl<_$ChapterDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterDetailsImplToJson(
      this,
    );
  }
}

abstract class _ChapterDetails implements ChapterDetails {
  const factory _ChapterDetails(
      {required final String id,
      required final String mangaId,
      required final List<String> pages}) = _$ChapterDetailsImpl;

  factory _ChapterDetails.fromJson(Map<String, dynamic> json) =
      _$ChapterDetailsImpl.fromJson;

  @override
  String get id;
  @override
  String get mangaId;
  @override
  List<String> get pages;

  /// Create a copy of ChapterDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChapterDetailsImplCopyWith<_$ChapterDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SearchRequest _$SearchRequestFromJson(Map<String, dynamic> json) {
  return _SearchRequest.fromJson(json);
}

/// @nodoc
mixin _$SearchRequest {
  String? get title => throw _privateConstructorUsedError;
  List<Tag>? get includedTags => throw _privateConstructorUsedError;
  List<Tag>? get excludedTags => throw _privateConstructorUsedError;

  /// Serializes this SearchRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchRequestCopyWith<SearchRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchRequestCopyWith<$Res> {
  factory $SearchRequestCopyWith(
          SearchRequest value, $Res Function(SearchRequest) then) =
      _$SearchRequestCopyWithImpl<$Res, SearchRequest>;
  @useResult
  $Res call({String? title, List<Tag>? includedTags, List<Tag>? excludedTags});
}

/// @nodoc
class _$SearchRequestCopyWithImpl<$Res, $Val extends SearchRequest>
    implements $SearchRequestCopyWith<$Res> {
  _$SearchRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? includedTags = freezed,
    Object? excludedTags = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      includedTags: freezed == includedTags
          ? _value.includedTags
          : includedTags // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
      excludedTags: freezed == excludedTags
          ? _value.excludedTags
          : excludedTags // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchRequestImplCopyWith<$Res>
    implements $SearchRequestCopyWith<$Res> {
  factory _$$SearchRequestImplCopyWith(
          _$SearchRequestImpl value, $Res Function(_$SearchRequestImpl) then) =
      __$$SearchRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, List<Tag>? includedTags, List<Tag>? excludedTags});
}

/// @nodoc
class __$$SearchRequestImplCopyWithImpl<$Res>
    extends _$SearchRequestCopyWithImpl<$Res, _$SearchRequestImpl>
    implements _$$SearchRequestImplCopyWith<$Res> {
  __$$SearchRequestImplCopyWithImpl(
      _$SearchRequestImpl _value, $Res Function(_$SearchRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? includedTags = freezed,
    Object? excludedTags = freezed,
  }) {
    return _then(_$SearchRequestImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      includedTags: freezed == includedTags
          ? _value._includedTags
          : includedTags // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
      excludedTags: freezed == excludedTags
          ? _value._excludedTags
          : excludedTags // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchRequestImpl implements _SearchRequest {
  const _$SearchRequestImpl(
      {this.title,
      final List<Tag>? includedTags,
      final List<Tag>? excludedTags})
      : _includedTags = includedTags,
        _excludedTags = excludedTags;

  factory _$SearchRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchRequestImplFromJson(json);

  @override
  final String? title;
  final List<Tag>? _includedTags;
  @override
  List<Tag>? get includedTags {
    final value = _includedTags;
    if (value == null) return null;
    if (_includedTags is EqualUnmodifiableListView) return _includedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Tag>? _excludedTags;
  @override
  List<Tag>? get excludedTags {
    final value = _excludedTags;
    if (value == null) return null;
    if (_excludedTags is EqualUnmodifiableListView) return _excludedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SearchRequest(title: $title, includedTags: $includedTags, excludedTags: $excludedTags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._includedTags, _includedTags) &&
            const DeepCollectionEquality()
                .equals(other._excludedTags, _excludedTags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_includedTags),
      const DeepCollectionEquality().hash(_excludedTags));

  /// Create a copy of SearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchRequestImplCopyWith<_$SearchRequestImpl> get copyWith =>
      __$$SearchRequestImplCopyWithImpl<_$SearchRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchRequestImplToJson(
      this,
    );
  }
}

abstract class _SearchRequest implements SearchRequest {
  const factory _SearchRequest(
      {final String? title,
      final List<Tag>? includedTags,
      final List<Tag>? excludedTags}) = _$SearchRequestImpl;

  factory _SearchRequest.fromJson(Map<String, dynamic> json) =
      _$SearchRequestImpl.fromJson;

  @override
  String? get title;
  @override
  List<Tag>? get includedTags;
  @override
  List<Tag>? get excludedTags;

  /// Create a copy of SearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchRequestImplCopyWith<_$SearchRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
