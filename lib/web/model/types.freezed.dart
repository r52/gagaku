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
  String? get parser => throw _privateConstructorUsedError;

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
      String? parser});
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
              as String?,
    ) as $Val);
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
      String? parser});
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
              as String?,
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
  final String? parser;

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
      final String? parser}) = _$SourceInfoImpl;
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
  String? get parser;

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
  String get name => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get baseUrl => throw _privateConstructorUsedError;
  String get mangaPath => throw _privateConstructorUsedError;
  String get search => throw _privateConstructorUsedError;
  String get manga => throw _privateConstructorUsedError;
  String get pages => throw _privateConstructorUsedError;

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
  $Res call(
      {String name,
      String version,
      String baseUrl,
      String mangaPath,
      String search,
      String manga,
      String pages});
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
    Object? name = null,
    Object? version = null,
    Object? baseUrl = null,
    Object? mangaPath = null,
    Object? search = null,
    Object? manga = null,
    Object? pages = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      baseUrl: null == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      mangaPath: null == mangaPath
          ? _value.mangaPath
          : mangaPath // ignore: cast_nullable_to_non_nullable
              as String,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      manga: null == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as String,
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call(
      {String name,
      String version,
      String baseUrl,
      String mangaPath,
      String search,
      String manga,
      String pages});
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
    Object? name = null,
    Object? version = null,
    Object? baseUrl = null,
    Object? mangaPath = null,
    Object? search = null,
    Object? manga = null,
    Object? pages = null,
  }) {
    return _then(_$WebSourceInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      baseUrl: null == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      mangaPath: null == mangaPath
          ? _value.mangaPath
          : mangaPath // ignore: cast_nullable_to_non_nullable
              as String,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      manga: null == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as String,
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSourceInfoImpl implements _WebSourceInfo {
  const _$WebSourceInfoImpl(
      {required this.name,
      required this.version,
      required this.baseUrl,
      required this.mangaPath,
      required this.search,
      required this.manga,
      required this.pages});

  factory _$WebSourceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSourceInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String version;
  @override
  final String baseUrl;
  @override
  final String mangaPath;
  @override
  final String search;
  @override
  final String manga;
  @override
  final String pages;

  @override
  String toString() {
    return 'WebSourceInfo(name: $name, version: $version, baseUrl: $baseUrl, mangaPath: $mangaPath, search: $search, manga: $manga, pages: $pages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSourceInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.mangaPath, mangaPath) ||
                other.mangaPath == mangaPath) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.manga, manga) || other.manga == manga) &&
            (identical(other.pages, pages) || other.pages == pages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, version, baseUrl, mangaPath, search, manga, pages);

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
      {required final String name,
      required final String version,
      required final String baseUrl,
      required final String mangaPath,
      required final String search,
      required final String manga,
      required final String pages}) = _$WebSourceInfoImpl;

  factory _WebSourceInfo.fromJson(Map<String, dynamic> json) =
      _$WebSourceInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get version;
  @override
  String get baseUrl;
  @override
  String get mangaPath;
  @override
  String get search;
  @override
  String get manga;
  @override
  String get pages;

  /// Create a copy of WebSourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSourceInfoImplCopyWith<_$WebSourceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RepoInfo _$RepoInfoFromJson(Map<String, dynamic> json) {
  return _RepoInfo.fromJson(json);
}

/// @nodoc
mixin _$RepoInfo {
  String get name => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
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
  $Res call({String name, String version, String url});
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
    Object? version = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
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
  $Res call({String name, String version, String url});
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
    Object? version = null,
    Object? url = null,
  }) {
    return _then(_$RepoInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
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
  const _$RepoInfoImpl(
      {required this.name, required this.version, required this.url});

  factory _$RepoInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepoInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String version;
  @override
  final String url;

  @override
  String toString() {
    return 'RepoInfo(name: $name, version: $version, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepoInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, version, url);

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
      {required final String name,
      required final String version,
      required final String url}) = _$RepoInfoImpl;

  factory _RepoInfo.fromJson(Map<String, dynamic> json) =
      _$RepoInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get version;
  @override
  String get url;

  /// Create a copy of RepoInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepoInfoImplCopyWith<_$RepoInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
