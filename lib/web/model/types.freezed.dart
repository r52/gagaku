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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SourceHandler {
  SourceType get type => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String? get chapter => throw _privateConstructorUsedError;
  WebSourceInfo? get parser => throw _privateConstructorUsedError;

  /// Create a copy of SourceHandler
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SourceHandlerCopyWith<SourceHandler> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceHandlerCopyWith<$Res> {
  factory $SourceHandlerCopyWith(
    SourceHandler value,
    $Res Function(SourceHandler) then,
  ) = _$SourceHandlerCopyWithImpl<$Res, SourceHandler>;
  @useResult
  $Res call({
    SourceType type,
    String source,
    String location,
    String? chapter,
    WebSourceInfo? parser,
  });

  $WebSourceInfoCopyWith<$Res>? get parser;
}

/// @nodoc
class _$SourceHandlerCopyWithImpl<$Res, $Val extends SourceHandler>
    implements $SourceHandlerCopyWith<$Res> {
  _$SourceHandlerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SourceHandler
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
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as SourceType,
            source:
                null == source
                    ? _value.source
                    : source // ignore: cast_nullable_to_non_nullable
                        as String,
            location:
                null == location
                    ? _value.location
                    : location // ignore: cast_nullable_to_non_nullable
                        as String,
            chapter:
                freezed == chapter
                    ? _value.chapter
                    : chapter // ignore: cast_nullable_to_non_nullable
                        as String?,
            parser:
                freezed == parser
                    ? _value.parser
                    : parser // ignore: cast_nullable_to_non_nullable
                        as WebSourceInfo?,
          )
          as $Val,
    );
  }

  /// Create a copy of SourceHandler
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
abstract class _$$SourceHandlerImplCopyWith<$Res>
    implements $SourceHandlerCopyWith<$Res> {
  factory _$$SourceHandlerImplCopyWith(
    _$SourceHandlerImpl value,
    $Res Function(_$SourceHandlerImpl) then,
  ) = __$$SourceHandlerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    SourceType type,
    String source,
    String location,
    String? chapter,
    WebSourceInfo? parser,
  });

  @override
  $WebSourceInfoCopyWith<$Res>? get parser;
}

/// @nodoc
class __$$SourceHandlerImplCopyWithImpl<$Res>
    extends _$SourceHandlerCopyWithImpl<$Res, _$SourceHandlerImpl>
    implements _$$SourceHandlerImplCopyWith<$Res> {
  __$$SourceHandlerImplCopyWithImpl(
    _$SourceHandlerImpl _value,
    $Res Function(_$SourceHandlerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SourceHandler
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
    return _then(
      _$SourceHandlerImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as SourceType,
        source:
            null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                    as String,
        location:
            null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                    as String,
        chapter:
            freezed == chapter
                ? _value.chapter
                : chapter // ignore: cast_nullable_to_non_nullable
                    as String?,
        parser:
            freezed == parser
                ? _value.parser
                : parser // ignore: cast_nullable_to_non_nullable
                    as WebSourceInfo?,
      ),
    );
  }
}

/// @nodoc

class _$SourceHandlerImpl extends _SourceHandler {
  const _$SourceHandlerImpl({
    required this.type,
    required this.source,
    required this.location,
    this.chapter,
    this.parser,
  }) : super._();

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
    return 'SourceHandler(type: $type, source: $source, location: $location, chapter: $chapter, parser: $parser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceHandlerImpl &&
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

  /// Create a copy of SourceHandler
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceHandlerImplCopyWith<_$SourceHandlerImpl> get copyWith =>
      __$$SourceHandlerImplCopyWithImpl<_$SourceHandlerImpl>(this, _$identity);
}

abstract class _SourceHandler extends SourceHandler {
  const factory _SourceHandler({
    required final SourceType type,
    required final String source,
    required final String location,
    final String? chapter,
    final WebSourceInfo? parser,
  }) = _$SourceHandlerImpl;
  const _SourceHandler._() : super._();

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

  /// Create a copy of SourceHandler
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceHandlerImplCopyWith<_$SourceHandlerImpl> get copyWith =>
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
    HistoryLink value,
    $Res Function(HistoryLink) then,
  ) = _$HistoryLinkCopyWithImpl<$Res, HistoryLink>;
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
    return _then(
      _value.copyWith(
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            url:
                null == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String,
            cover:
                freezed == cover
                    ? _value.cover
                    : cover // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HistoryLinkImplCopyWith<$Res>
    implements $HistoryLinkCopyWith<$Res> {
  factory _$$HistoryLinkImplCopyWith(
    _$HistoryLinkImpl value,
    $Res Function(_$HistoryLinkImpl) then,
  ) = __$$HistoryLinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String url, String? cover});
}

/// @nodoc
class __$$HistoryLinkImplCopyWithImpl<$Res>
    extends _$HistoryLinkCopyWithImpl<$Res, _$HistoryLinkImpl>
    implements _$$HistoryLinkImplCopyWith<$Res> {
  __$$HistoryLinkImplCopyWithImpl(
    _$HistoryLinkImpl _value,
    $Res Function(_$HistoryLinkImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HistoryLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? cover = freezed,
  }) {
    return _then(
      _$HistoryLinkImpl(
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        url:
            null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String,
        cover:
            freezed == cover
                ? _value.cover
                : cover // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
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
    return _$$HistoryLinkImplToJson(this);
  }
}

abstract class _HistoryLink extends HistoryLink {
  const factory _HistoryLink({
    required final String title,
    required final String url,
    final String? cover,
  }) = _$HistoryLinkImpl;
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
  $Res call({
    String title,
    String description,
    String artist,
    String author,
    String cover,
    Map<String, String>? groups,
    Map<String, WebChapter> chapters,
  });
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
    return _then(
      _value.copyWith(
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            artist:
                null == artist
                    ? _value.artist
                    : artist // ignore: cast_nullable_to_non_nullable
                        as String,
            author:
                null == author
                    ? _value.author
                    : author // ignore: cast_nullable_to_non_nullable
                        as String,
            cover:
                null == cover
                    ? _value.cover
                    : cover // ignore: cast_nullable_to_non_nullable
                        as String,
            groups:
                freezed == groups
                    ? _value.groups
                    : groups // ignore: cast_nullable_to_non_nullable
                        as Map<String, String>?,
            chapters:
                null == chapters
                    ? _value.chapters
                    : chapters // ignore: cast_nullable_to_non_nullable
                        as Map<String, WebChapter>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WebMangaImplCopyWith<$Res>
    implements $WebMangaCopyWith<$Res> {
  factory _$$WebMangaImplCopyWith(
    _$WebMangaImpl value,
    $Res Function(_$WebMangaImpl) then,
  ) = __$$WebMangaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String description,
    String artist,
    String author,
    String cover,
    Map<String, String>? groups,
    Map<String, WebChapter> chapters,
  });
}

/// @nodoc
class __$$WebMangaImplCopyWithImpl<$Res>
    extends _$WebMangaCopyWithImpl<$Res, _$WebMangaImpl>
    implements _$$WebMangaImplCopyWith<$Res> {
  __$$WebMangaImplCopyWithImpl(
    _$WebMangaImpl _value,
    $Res Function(_$WebMangaImpl) _then,
  ) : super(_value, _then);

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
    return _then(
      _$WebMangaImpl(
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        artist:
            null == artist
                ? _value.artist
                : artist // ignore: cast_nullable_to_non_nullable
                    as String,
        author:
            null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                    as String,
        cover:
            null == cover
                ? _value.cover
                : cover // ignore: cast_nullable_to_non_nullable
                    as String,
        groups:
            freezed == groups
                ? _value._groups
                : groups // ignore: cast_nullable_to_non_nullable
                    as Map<String, String>?,
        chapters:
            null == chapters
                ? _value._chapters
                : chapters // ignore: cast_nullable_to_non_nullable
                    as Map<String, WebChapter>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WebMangaImpl extends _WebManga {
  const _$WebMangaImpl({
    required this.title,
    required this.description,
    required this.artist,
    required this.author,
    required this.cover,
    final Map<String, String>? groups,
    required final Map<String, WebChapter> chapters,
  }) : _groups = groups,
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
    const DeepCollectionEquality().hash(_chapters),
  );

  /// Create a copy of WebManga
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebMangaImplCopyWith<_$WebMangaImpl> get copyWith =>
      __$$WebMangaImplCopyWithImpl<_$WebMangaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebMangaImplToJson(this);
  }
}

abstract class _WebManga extends WebManga {
  const factory _WebManga({
    required final String title,
    required final String description,
    required final String artist,
    required final String author,
    required final String cover,
    final Map<String, String>? groups,
    required final Map<String, WebChapter> chapters,
  }) = _$WebMangaImpl;
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
    WebChapter value,
    $Res Function(WebChapter) then,
  ) = _$WebChapterCopyWithImpl<$Res, WebChapter>;
  @useResult
  $Res call({
    String? title,
    String? volume,
    @EpochTimestampSerializer() DateTime? lastUpdated,
    @MappedEpochTimestampSerializer() DateTime? releaseDate,
    Map<String, dynamic> groups,
  });
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
    return _then(
      _value.copyWith(
            title:
                freezed == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String?,
            volume:
                freezed == volume
                    ? _value.volume
                    : volume // ignore: cast_nullable_to_non_nullable
                        as String?,
            lastUpdated:
                freezed == lastUpdated
                    ? _value.lastUpdated
                    : lastUpdated // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            releaseDate:
                freezed == releaseDate
                    ? _value.releaseDate
                    : releaseDate // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            groups:
                null == groups
                    ? _value.groups
                    : groups // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WebChapterImplCopyWith<$Res>
    implements $WebChapterCopyWith<$Res> {
  factory _$$WebChapterImplCopyWith(
    _$WebChapterImpl value,
    $Res Function(_$WebChapterImpl) then,
  ) = __$$WebChapterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? title,
    String? volume,
    @EpochTimestampSerializer() DateTime? lastUpdated,
    @MappedEpochTimestampSerializer() DateTime? releaseDate,
    Map<String, dynamic> groups,
  });
}

/// @nodoc
class __$$WebChapterImplCopyWithImpl<$Res>
    extends _$WebChapterCopyWithImpl<$Res, _$WebChapterImpl>
    implements _$$WebChapterImplCopyWith<$Res> {
  __$$WebChapterImplCopyWithImpl(
    _$WebChapterImpl _value,
    $Res Function(_$WebChapterImpl) _then,
  ) : super(_value, _then);

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
    return _then(
      _$WebChapterImpl(
        title:
            freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String?,
        volume:
            freezed == volume
                ? _value.volume
                : volume // ignore: cast_nullable_to_non_nullable
                    as String?,
        lastUpdated:
            freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        releaseDate:
            freezed == releaseDate
                ? _value.releaseDate
                : releaseDate // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        groups:
            null == groups
                ? _value._groups
                : groups // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$WebChapterImpl extends _WebChapter {
  const _$WebChapterImpl({
    this.title,
    this.volume,
    @EpochTimestampSerializer() this.lastUpdated,
    @MappedEpochTimestampSerializer() this.releaseDate,
    required final Map<String, dynamic> groups,
  }) : _groups = groups,
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
  int get hashCode => Object.hash(
    runtimeType,
    title,
    volume,
    lastUpdated,
    releaseDate,
    const DeepCollectionEquality().hash(_groups),
  );

  /// Create a copy of WebChapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebChapterImplCopyWith<_$WebChapterImpl> get copyWith =>
      __$$WebChapterImplCopyWithImpl<_$WebChapterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebChapterImplToJson(this);
  }
}

abstract class _WebChapter extends WebChapter {
  const factory _WebChapter({
    final String? title,
    final String? volume,
    @EpochTimestampSerializer() final DateTime? lastUpdated,
    @MappedEpochTimestampSerializer() final DateTime? releaseDate,
    required final Map<String, dynamic> groups,
  }) = _$WebChapterImpl;
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
  $Res call({Object? description = null, Object? src = null}) {
    return _then(
      _value.copyWith(
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            src:
                null == src
                    ? _value.src
                    : src // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ImgurPageImplCopyWith<$Res>
    implements $ImgurPageCopyWith<$Res> {
  factory _$$ImgurPageImplCopyWith(
    _$ImgurPageImpl value,
    $Res Function(_$ImgurPageImpl) then,
  ) = __$$ImgurPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, String src});
}

/// @nodoc
class __$$ImgurPageImplCopyWithImpl<$Res>
    extends _$ImgurPageCopyWithImpl<$Res, _$ImgurPageImpl>
    implements _$$ImgurPageImplCopyWith<$Res> {
  __$$ImgurPageImplCopyWithImpl(
    _$ImgurPageImpl _value,
    $Res Function(_$ImgurPageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImgurPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? description = null, Object? src = null}) {
    return _then(
      _$ImgurPageImpl(
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        src:
            null == src
                ? _value.src
                : src // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
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
    return _$$ImgurPageImplToJson(this);
  }
}

abstract class _ImgurPage implements ImgurPage {
  const factory _ImgurPage({
    required final String description,
    required final String src,
  }) = _$ImgurPageImpl;

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
    WebSourceInfo value,
    $Res Function(WebSourceInfo) then,
  ) = _$WebSourceInfoCopyWithImpl<$Res, WebSourceInfo>;
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
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            repo:
                null == repo
                    ? _value.repo
                    : repo // ignore: cast_nullable_to_non_nullable
                        as String,
            icon:
                freezed == icon
                    ? _value.icon
                    : icon // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WebSourceInfoImplCopyWith<$Res>
    implements $WebSourceInfoCopyWith<$Res> {
  factory _$$WebSourceInfoImplCopyWith(
    _$WebSourceInfoImpl value,
    $Res Function(_$WebSourceInfoImpl) then,
  ) = __$$WebSourceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String repo, String? icon});
}

/// @nodoc
class __$$WebSourceInfoImplCopyWithImpl<$Res>
    extends _$WebSourceInfoCopyWithImpl<$Res, _$WebSourceInfoImpl>
    implements _$$WebSourceInfoImplCopyWith<$Res> {
  __$$WebSourceInfoImplCopyWithImpl(
    _$WebSourceInfoImpl _value,
    $Res Function(_$WebSourceInfoImpl) _then,
  ) : super(_value, _then);

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
    return _then(
      _$WebSourceInfoImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        repo:
            null == repo
                ? _value.repo
                : repo // ignore: cast_nullable_to_non_nullable
                    as String,
        icon:
            freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSourceInfoImpl implements _WebSourceInfo {
  const _$WebSourceInfoImpl({
    required this.id,
    required this.name,
    required this.repo,
    this.icon,
  });

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
    return _$$WebSourceInfoImplToJson(this);
  }
}

abstract class _WebSourceInfo implements WebSourceInfo {
  const factory _WebSourceInfo({
    required final String id,
    required final String name,
    required final String repo,
    final String? icon,
  }) = _$WebSourceInfoImpl;

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

SourceIdentifier _$SourceIdentifierFromJson(Map<String, dynamic> json) {
  return _SourceIdentifier.fromJson(json);
}

/// @nodoc
mixin _$SourceIdentifier {
  WebSourceInfo get internal => throw _privateConstructorUsedError;
  SourceInfo get external => throw _privateConstructorUsedError;

  /// Serializes this SourceIdentifier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SourceIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SourceIdentifierCopyWith<SourceIdentifier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceIdentifierCopyWith<$Res> {
  factory $SourceIdentifierCopyWith(
    SourceIdentifier value,
    $Res Function(SourceIdentifier) then,
  ) = _$SourceIdentifierCopyWithImpl<$Res, SourceIdentifier>;
  @useResult
  $Res call({WebSourceInfo internal, SourceInfo external});

  $WebSourceInfoCopyWith<$Res> get internal;
  $SourceInfoCopyWith<$Res> get external;
}

/// @nodoc
class _$SourceIdentifierCopyWithImpl<$Res, $Val extends SourceIdentifier>
    implements $SourceIdentifierCopyWith<$Res> {
  _$SourceIdentifierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SourceIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? internal = null, Object? external = null}) {
    return _then(
      _value.copyWith(
            internal:
                null == internal
                    ? _value.internal
                    : internal // ignore: cast_nullable_to_non_nullable
                        as WebSourceInfo,
            external:
                null == external
                    ? _value.external
                    : external // ignore: cast_nullable_to_non_nullable
                        as SourceInfo,
          )
          as $Val,
    );
  }

  /// Create a copy of SourceIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WebSourceInfoCopyWith<$Res> get internal {
    return $WebSourceInfoCopyWith<$Res>(_value.internal, (value) {
      return _then(_value.copyWith(internal: value) as $Val);
    });
  }

  /// Create a copy of SourceIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SourceInfoCopyWith<$Res> get external {
    return $SourceInfoCopyWith<$Res>(_value.external, (value) {
      return _then(_value.copyWith(external: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SourceIdentifierImplCopyWith<$Res>
    implements $SourceIdentifierCopyWith<$Res> {
  factory _$$SourceIdentifierImplCopyWith(
    _$SourceIdentifierImpl value,
    $Res Function(_$SourceIdentifierImpl) then,
  ) = __$$SourceIdentifierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WebSourceInfo internal, SourceInfo external});

  @override
  $WebSourceInfoCopyWith<$Res> get internal;
  @override
  $SourceInfoCopyWith<$Res> get external;
}

/// @nodoc
class __$$SourceIdentifierImplCopyWithImpl<$Res>
    extends _$SourceIdentifierCopyWithImpl<$Res, _$SourceIdentifierImpl>
    implements _$$SourceIdentifierImplCopyWith<$Res> {
  __$$SourceIdentifierImplCopyWithImpl(
    _$SourceIdentifierImpl _value,
    $Res Function(_$SourceIdentifierImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SourceIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? internal = null, Object? external = null}) {
    return _then(
      _$SourceIdentifierImpl(
        internal:
            null == internal
                ? _value.internal
                : internal // ignore: cast_nullable_to_non_nullable
                    as WebSourceInfo,
        external:
            null == external
                ? _value.external
                : external // ignore: cast_nullable_to_non_nullable
                    as SourceInfo,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceIdentifierImpl implements _SourceIdentifier {
  const _$SourceIdentifierImpl({
    required this.internal,
    required this.external,
  });

  factory _$SourceIdentifierImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceIdentifierImplFromJson(json);

  @override
  final WebSourceInfo internal;
  @override
  final SourceInfo external;

  @override
  String toString() {
    return 'SourceIdentifier(internal: $internal, external: $external)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceIdentifierImpl &&
            (identical(other.internal, internal) ||
                other.internal == internal) &&
            (identical(other.external, external) ||
                other.external == external));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, internal, external);

  /// Create a copy of SourceIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceIdentifierImplCopyWith<_$SourceIdentifierImpl> get copyWith =>
      __$$SourceIdentifierImplCopyWithImpl<_$SourceIdentifierImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceIdentifierImplToJson(this);
  }
}

abstract class _SourceIdentifier implements SourceIdentifier {
  const factory _SourceIdentifier({
    required final WebSourceInfo internal,
    required final SourceInfo external,
  }) = _$SourceIdentifierImpl;

  factory _SourceIdentifier.fromJson(Map<String, dynamic> json) =
      _$SourceIdentifierImpl.fromJson;

  @override
  WebSourceInfo get internal;
  @override
  SourceInfo get external;

  /// Create a copy of SourceIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceIdentifierImplCopyWith<_$SourceIdentifierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Badge _$BadgeFromJson(Map<String, dynamic> json) {
  return _Badge.fromJson(json);
}

/// @nodoc
mixin _$Badge {
  String get text => throw _privateConstructorUsedError;
  @BadgeColorParser()
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
  $Res call({String text, @BadgeColorParser() BadgeColor type});
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
  $Res call({Object? text = null, Object? type = null}) {
    return _then(
      _value.copyWith(
            text:
                null == text
                    ? _value.text
                    : text // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as BadgeColor,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BadgeImplCopyWith<$Res> implements $BadgeCopyWith<$Res> {
  factory _$$BadgeImplCopyWith(
    _$BadgeImpl value,
    $Res Function(_$BadgeImpl) then,
  ) = __$$BadgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, @BadgeColorParser() BadgeColor type});
}

/// @nodoc
class __$$BadgeImplCopyWithImpl<$Res>
    extends _$BadgeCopyWithImpl<$Res, _$BadgeImpl>
    implements _$$BadgeImplCopyWith<$Res> {
  __$$BadgeImplCopyWithImpl(
    _$BadgeImpl _value,
    $Res Function(_$BadgeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Badge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null, Object? type = null}) {
    return _then(
      _$BadgeImpl(
        text:
            null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as BadgeColor,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BadgeImpl implements _Badge {
  const _$BadgeImpl({
    required this.text,
    @BadgeColorParser() required this.type,
  });

  factory _$BadgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$BadgeImplFromJson(json);

  @override
  final String text;
  @override
  @BadgeColorParser()
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
    return _$$BadgeImplToJson(this);
  }
}

abstract class _Badge implements Badge {
  const factory _Badge({
    required final String text,
    @BadgeColorParser() required final BadgeColor type,
  }) = _$BadgeImpl;

  factory _Badge.fromJson(Map<String, dynamic> json) = _$BadgeImpl.fromJson;

  @override
  String get text;
  @override
  @BadgeColorParser()
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
  List<Badge>? get tags => throw _privateConstructorUsedError;
  String get websiteBaseURL => throw _privateConstructorUsedError;
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
    SourceVersion value,
    $Res Function(SourceVersion) then,
  ) = _$SourceVersionCopyWithImpl<$Res, SourceVersion>;
  @useResult
  $Res call({
    String id,
    String name,
    String author,
    String desc,
    String? website,
    ContentRating contentRating,
    String version,
    String icon,
    List<Badge>? tags,
    String websiteBaseURL,
    int? intents,
  });
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
    Object? tags = freezed,
    Object? websiteBaseURL = null,
    Object? intents = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            author:
                null == author
                    ? _value.author
                    : author // ignore: cast_nullable_to_non_nullable
                        as String,
            desc:
                null == desc
                    ? _value.desc
                    : desc // ignore: cast_nullable_to_non_nullable
                        as String,
            website:
                freezed == website
                    ? _value.website
                    : website // ignore: cast_nullable_to_non_nullable
                        as String?,
            contentRating:
                null == contentRating
                    ? _value.contentRating
                    : contentRating // ignore: cast_nullable_to_non_nullable
                        as ContentRating,
            version:
                null == version
                    ? _value.version
                    : version // ignore: cast_nullable_to_non_nullable
                        as String,
            icon:
                null == icon
                    ? _value.icon
                    : icon // ignore: cast_nullable_to_non_nullable
                        as String,
            tags:
                freezed == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<Badge>?,
            websiteBaseURL:
                null == websiteBaseURL
                    ? _value.websiteBaseURL
                    : websiteBaseURL // ignore: cast_nullable_to_non_nullable
                        as String,
            intents:
                freezed == intents
                    ? _value.intents
                    : intents // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SourceVersionImplCopyWith<$Res>
    implements $SourceVersionCopyWith<$Res> {
  factory _$$SourceVersionImplCopyWith(
    _$SourceVersionImpl value,
    $Res Function(_$SourceVersionImpl) then,
  ) = __$$SourceVersionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String author,
    String desc,
    String? website,
    ContentRating contentRating,
    String version,
    String icon,
    List<Badge>? tags,
    String websiteBaseURL,
    int? intents,
  });
}

/// @nodoc
class __$$SourceVersionImplCopyWithImpl<$Res>
    extends _$SourceVersionCopyWithImpl<$Res, _$SourceVersionImpl>
    implements _$$SourceVersionImplCopyWith<$Res> {
  __$$SourceVersionImplCopyWithImpl(
    _$SourceVersionImpl _value,
    $Res Function(_$SourceVersionImpl) _then,
  ) : super(_value, _then);

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
    Object? tags = freezed,
    Object? websiteBaseURL = null,
    Object? intents = freezed,
  }) {
    return _then(
      _$SourceVersionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        author:
            null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                    as String,
        desc:
            null == desc
                ? _value.desc
                : desc // ignore: cast_nullable_to_non_nullable
                    as String,
        website:
            freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                    as String?,
        contentRating:
            null == contentRating
                ? _value.contentRating
                : contentRating // ignore: cast_nullable_to_non_nullable
                    as ContentRating,
        version:
            null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                    as String,
        icon:
            null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                    as String,
        tags:
            freezed == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<Badge>?,
        websiteBaseURL:
            null == websiteBaseURL
                ? _value.websiteBaseURL
                : websiteBaseURL // ignore: cast_nullable_to_non_nullable
                    as String,
        intents:
            freezed == intents
                ? _value.intents
                : intents // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceVersionImpl implements _SourceVersion {
  const _$SourceVersionImpl({
    required this.id,
    required this.name,
    required this.author,
    required this.desc,
    this.website,
    required this.contentRating,
    required this.version,
    required this.icon,
    final List<Badge>? tags,
    required this.websiteBaseURL,
    this.intents,
  }) : _tags = tags;

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
  final String websiteBaseURL;
  @override
  final int? intents;

  @override
  String toString() {
    return 'SourceVersion(id: $id, name: $name, author: $author, desc: $desc, website: $website, contentRating: $contentRating, version: $version, icon: $icon, tags: $tags, websiteBaseURL: $websiteBaseURL, intents: $intents)';
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
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.websiteBaseURL, websiteBaseURL) ||
                other.websiteBaseURL == websiteBaseURL) &&
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
    const DeepCollectionEquality().hash(_tags),
    websiteBaseURL,
    intents,
  );

  /// Create a copy of SourceVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceVersionImplCopyWith<_$SourceVersionImpl> get copyWith =>
      __$$SourceVersionImplCopyWithImpl<_$SourceVersionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceVersionImplToJson(this);
  }
}

abstract class _SourceVersion implements SourceVersion {
  const factory _SourceVersion({
    required final String id,
    required final String name,
    required final String author,
    required final String desc,
    final String? website,
    required final ContentRating contentRating,
    required final String version,
    required final String icon,
    final List<Badge>? tags,
    required final String websiteBaseURL,
    final int? intents,
  }) = _$SourceVersionImpl;

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
  List<Badge>? get tags;
  @override
  String get websiteBaseURL;
  @override
  int? get intents;

  /// Create a copy of SourceVersion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceVersionImplCopyWith<_$SourceVersionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SourceInfo _$SourceInfoFromJson(Map<String, dynamic> json) {
  return _SourceInfo.fromJson(json);
}

/// @nodoc
mixin _$SourceInfo {
  String get name => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ContentRating get contentRating => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get websiteBaseURL => throw _privateConstructorUsedError;
  String? get authorWebsite => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  List<Badge>? get sourceTags => throw _privateConstructorUsedError;
  int? get intents => throw _privateConstructorUsedError;

  /// Serializes this SourceInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SourceInfoCopyWith<SourceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceInfoCopyWith<$Res> {
  factory $SourceInfoCopyWith(
    SourceInfo value,
    $Res Function(SourceInfo) then,
  ) = _$SourceInfoCopyWithImpl<$Res, SourceInfo>;
  @useResult
  $Res call({
    String name,
    String author,
    String description,
    ContentRating contentRating,
    String version,
    String icon,
    String websiteBaseURL,
    String? authorWebsite,
    String? language,
    List<Badge>? sourceTags,
    int? intents,
  });
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
    Object? name = null,
    Object? author = null,
    Object? description = null,
    Object? contentRating = null,
    Object? version = null,
    Object? icon = null,
    Object? websiteBaseURL = null,
    Object? authorWebsite = freezed,
    Object? language = freezed,
    Object? sourceTags = freezed,
    Object? intents = freezed,
  }) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            author:
                null == author
                    ? _value.author
                    : author // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            contentRating:
                null == contentRating
                    ? _value.contentRating
                    : contentRating // ignore: cast_nullable_to_non_nullable
                        as ContentRating,
            version:
                null == version
                    ? _value.version
                    : version // ignore: cast_nullable_to_non_nullable
                        as String,
            icon:
                null == icon
                    ? _value.icon
                    : icon // ignore: cast_nullable_to_non_nullable
                        as String,
            websiteBaseURL:
                null == websiteBaseURL
                    ? _value.websiteBaseURL
                    : websiteBaseURL // ignore: cast_nullable_to_non_nullable
                        as String,
            authorWebsite:
                freezed == authorWebsite
                    ? _value.authorWebsite
                    : authorWebsite // ignore: cast_nullable_to_non_nullable
                        as String?,
            language:
                freezed == language
                    ? _value.language
                    : language // ignore: cast_nullable_to_non_nullable
                        as String?,
            sourceTags:
                freezed == sourceTags
                    ? _value.sourceTags
                    : sourceTags // ignore: cast_nullable_to_non_nullable
                        as List<Badge>?,
            intents:
                freezed == intents
                    ? _value.intents
                    : intents // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SourceInfoImplCopyWith<$Res>
    implements $SourceInfoCopyWith<$Res> {
  factory _$$SourceInfoImplCopyWith(
    _$SourceInfoImpl value,
    $Res Function(_$SourceInfoImpl) then,
  ) = __$$SourceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String author,
    String description,
    ContentRating contentRating,
    String version,
    String icon,
    String websiteBaseURL,
    String? authorWebsite,
    String? language,
    List<Badge>? sourceTags,
    int? intents,
  });
}

/// @nodoc
class __$$SourceInfoImplCopyWithImpl<$Res>
    extends _$SourceInfoCopyWithImpl<$Res, _$SourceInfoImpl>
    implements _$$SourceInfoImplCopyWith<$Res> {
  __$$SourceInfoImplCopyWithImpl(
    _$SourceInfoImpl _value,
    $Res Function(_$SourceInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? author = null,
    Object? description = null,
    Object? contentRating = null,
    Object? version = null,
    Object? icon = null,
    Object? websiteBaseURL = null,
    Object? authorWebsite = freezed,
    Object? language = freezed,
    Object? sourceTags = freezed,
    Object? intents = freezed,
  }) {
    return _then(
      _$SourceInfoImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        author:
            null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        contentRating:
            null == contentRating
                ? _value.contentRating
                : contentRating // ignore: cast_nullable_to_non_nullable
                    as ContentRating,
        version:
            null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                    as String,
        icon:
            null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                    as String,
        websiteBaseURL:
            null == websiteBaseURL
                ? _value.websiteBaseURL
                : websiteBaseURL // ignore: cast_nullable_to_non_nullable
                    as String,
        authorWebsite:
            freezed == authorWebsite
                ? _value.authorWebsite
                : authorWebsite // ignore: cast_nullable_to_non_nullable
                    as String?,
        language:
            freezed == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                    as String?,
        sourceTags:
            freezed == sourceTags
                ? _value._sourceTags
                : sourceTags // ignore: cast_nullable_to_non_nullable
                    as List<Badge>?,
        intents:
            freezed == intents
                ? _value.intents
                : intents // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceInfoImpl extends _SourceInfo {
  const _$SourceInfoImpl({
    required this.name,
    required this.author,
    required this.description,
    required this.contentRating,
    required this.version,
    required this.icon,
    required this.websiteBaseURL,
    this.authorWebsite,
    this.language,
    final List<Badge>? sourceTags,
    this.intents,
  }) : _sourceTags = sourceTags,
       super._();

  factory _$SourceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String author;
  @override
  final String description;
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
  final List<Badge>? _sourceTags;
  @override
  List<Badge>? get sourceTags {
    final value = _sourceTags;
    if (value == null) return null;
    if (_sourceTags is EqualUnmodifiableListView) return _sourceTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? intents;

  @override
  String toString() {
    return 'SourceInfo(name: $name, author: $author, description: $description, contentRating: $contentRating, version: $version, icon: $icon, websiteBaseURL: $websiteBaseURL, authorWebsite: $authorWebsite, language: $language, sourceTags: $sourceTags, intents: $intents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.description, description) ||
                other.description == description) &&
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
            const DeepCollectionEquality().equals(
              other._sourceTags,
              _sourceTags,
            ) &&
            (identical(other.intents, intents) || other.intents == intents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    author,
    description,
    contentRating,
    version,
    icon,
    websiteBaseURL,
    authorWebsite,
    language,
    const DeepCollectionEquality().hash(_sourceTags),
    intents,
  );

  /// Create a copy of SourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceInfoImplCopyWith<_$SourceInfoImpl> get copyWith =>
      __$$SourceInfoImplCopyWithImpl<_$SourceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceInfoImplToJson(this);
  }
}

abstract class _SourceInfo extends SourceInfo {
  const factory _SourceInfo({
    required final String name,
    required final String author,
    required final String description,
    required final ContentRating contentRating,
    required final String version,
    required final String icon,
    required final String websiteBaseURL,
    final String? authorWebsite,
    final String? language,
    final List<Badge>? sourceTags,
    final int? intents,
  }) = _$SourceInfoImpl;
  const _SourceInfo._() : super._();

  factory _SourceInfo.fromJson(Map<String, dynamic> json) =
      _$SourceInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get author;
  @override
  String get description;
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
  List<Badge>? get sourceTags;
  @override
  int? get intents;

  /// Create a copy of SourceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceInfoImplCopyWith<_$SourceInfoImpl> get copyWith =>
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
  $Res call({Object? toolchain = null, Object? types = null}) {
    return _then(
      _value.copyWith(
            toolchain:
                null == toolchain
                    ? _value.toolchain
                    : toolchain // ignore: cast_nullable_to_non_nullable
                        as String,
            types:
                null == types
                    ? _value.types
                    : types // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BuiltWithImplCopyWith<$Res>
    implements $BuiltWithCopyWith<$Res> {
  factory _$$BuiltWithImplCopyWith(
    _$BuiltWithImpl value,
    $Res Function(_$BuiltWithImpl) then,
  ) = __$$BuiltWithImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String toolchain, String types});
}

/// @nodoc
class __$$BuiltWithImplCopyWithImpl<$Res>
    extends _$BuiltWithCopyWithImpl<$Res, _$BuiltWithImpl>
    implements _$$BuiltWithImplCopyWith<$Res> {
  __$$BuiltWithImplCopyWithImpl(
    _$BuiltWithImpl _value,
    $Res Function(_$BuiltWithImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BuiltWith
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? toolchain = null, Object? types = null}) {
    return _then(
      _$BuiltWithImpl(
        toolchain:
            null == toolchain
                ? _value.toolchain
                : toolchain // ignore: cast_nullable_to_non_nullable
                    as String,
        types:
            null == types
                ? _value.types
                : types // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
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
    return _$$BuiltWithImplToJson(this);
  }
}

abstract class _BuiltWith implements BuiltWith {
  const factory _BuiltWith({
    required final String toolchain,
    required final String types,
  }) = _$BuiltWithImpl;

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
    Versioning value,
    $Res Function(Versioning) then,
  ) = _$VersioningCopyWithImpl<$Res, Versioning>;
  @useResult
  $Res call({
    String buildTime,
    List<SourceVersion> sources,
    BuiltWith builtWith,
  });

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
    return _then(
      _value.copyWith(
            buildTime:
                null == buildTime
                    ? _value.buildTime
                    : buildTime // ignore: cast_nullable_to_non_nullable
                        as String,
            sources:
                null == sources
                    ? _value.sources
                    : sources // ignore: cast_nullable_to_non_nullable
                        as List<SourceVersion>,
            builtWith:
                null == builtWith
                    ? _value.builtWith
                    : builtWith // ignore: cast_nullable_to_non_nullable
                        as BuiltWith,
          )
          as $Val,
    );
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
    _$VersioningImpl value,
    $Res Function(_$VersioningImpl) then,
  ) = __$$VersioningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String buildTime,
    List<SourceVersion> sources,
    BuiltWith builtWith,
  });

  @override
  $BuiltWithCopyWith<$Res> get builtWith;
}

/// @nodoc
class __$$VersioningImplCopyWithImpl<$Res>
    extends _$VersioningCopyWithImpl<$Res, _$VersioningImpl>
    implements _$$VersioningImplCopyWith<$Res> {
  __$$VersioningImplCopyWithImpl(
    _$VersioningImpl _value,
    $Res Function(_$VersioningImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Versioning
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildTime = null,
    Object? sources = null,
    Object? builtWith = null,
  }) {
    return _then(
      _$VersioningImpl(
        buildTime:
            null == buildTime
                ? _value.buildTime
                : buildTime // ignore: cast_nullable_to_non_nullable
                    as String,
        sources:
            null == sources
                ? _value._sources
                : sources // ignore: cast_nullable_to_non_nullable
                    as List<SourceVersion>,
        builtWith:
            null == builtWith
                ? _value.builtWith
                : builtWith // ignore: cast_nullable_to_non_nullable
                    as BuiltWith,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VersioningImpl implements _Versioning {
  const _$VersioningImpl({
    required this.buildTime,
    required final List<SourceVersion> sources,
    required this.builtWith,
  }) : _sources = sources;

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
  int get hashCode => Object.hash(
    runtimeType,
    buildTime,
    const DeepCollectionEquality().hash(_sources),
    builtWith,
  );

  /// Create a copy of Versioning
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VersioningImplCopyWith<_$VersioningImpl> get copyWith =>
      __$$VersioningImplCopyWithImpl<_$VersioningImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VersioningImplToJson(this);
  }
}

abstract class _Versioning implements Versioning {
  const factory _Versioning({
    required final String buildTime,
    required final List<SourceVersion> sources,
    required final BuiltWith builtWith,
  }) = _$VersioningImpl;

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
  $Res call({Object? name = null, Object? url = null}) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            url:
                null == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RepoInfoImplCopyWith<$Res>
    implements $RepoInfoCopyWith<$Res> {
  factory _$$RepoInfoImplCopyWith(
    _$RepoInfoImpl value,
    $Res Function(_$RepoInfoImpl) then,
  ) = __$$RepoInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class __$$RepoInfoImplCopyWithImpl<$Res>
    extends _$RepoInfoCopyWithImpl<$Res, _$RepoInfoImpl>
    implements _$$RepoInfoImplCopyWith<$Res> {
  __$$RepoInfoImplCopyWithImpl(
    _$RepoInfoImpl _value,
    $Res Function(_$RepoInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RepoInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? url = null}) {
    return _then(
      _$RepoInfoImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        url:
            null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
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
    return _$$RepoInfoImplToJson(this);
  }
}

abstract class _RepoInfo implements RepoInfo {
  const factory _RepoInfo({
    required final String name,
    required final String url,
  }) = _$RepoInfoImpl;

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
    PartialSourceManga value,
    $Res Function(PartialSourceManga) then,
  ) = _$PartialSourceMangaCopyWithImpl<$Res, PartialSourceManga>;
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
    return _then(
      _value.copyWith(
            mangaId:
                null == mangaId
                    ? _value.mangaId
                    : mangaId // ignore: cast_nullable_to_non_nullable
                        as String,
            image:
                null == image
                    ? _value.image
                    : image // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            subtitle:
                freezed == subtitle
                    ? _value.subtitle
                    : subtitle // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PartialSourceMangaImplCopyWith<$Res>
    implements $PartialSourceMangaCopyWith<$Res> {
  factory _$$PartialSourceMangaImplCopyWith(
    _$PartialSourceMangaImpl value,
    $Res Function(_$PartialSourceMangaImpl) then,
  ) = __$$PartialSourceMangaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String mangaId, String image, String title, String? subtitle});
}

/// @nodoc
class __$$PartialSourceMangaImplCopyWithImpl<$Res>
    extends _$PartialSourceMangaCopyWithImpl<$Res, _$PartialSourceMangaImpl>
    implements _$$PartialSourceMangaImplCopyWith<$Res> {
  __$$PartialSourceMangaImplCopyWithImpl(
    _$PartialSourceMangaImpl _value,
    $Res Function(_$PartialSourceMangaImpl) _then,
  ) : super(_value, _then);

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
    return _then(
      _$PartialSourceMangaImpl(
        mangaId:
            null == mangaId
                ? _value.mangaId
                : mangaId // ignore: cast_nullable_to_non_nullable
                    as String,
        image:
            null == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        subtitle:
            freezed == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PartialSourceMangaImpl implements _PartialSourceManga {
  const _$PartialSourceMangaImpl({
    required this.mangaId,
    required this.image,
    required this.title,
    this.subtitle,
  });

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
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PartialSourceMangaImplToJson(this);
  }
}

abstract class _PartialSourceManga implements PartialSourceManga {
  const factory _PartialSourceManga({
    required final String mangaId,
    required final String image,
    required final String title,
    final String? subtitle,
  }) = _$PartialSourceMangaImpl;

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
    PagedResults value,
    $Res Function(PagedResults) then,
  ) = _$PagedResultsCopyWithImpl<$Res, PagedResults>;
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
  $Res call({Object? results = freezed, Object? metadata = freezed}) {
    return _then(
      _value.copyWith(
            results:
                freezed == results
                    ? _value.results
                    : results // ignore: cast_nullable_to_non_nullable
                        as List<PartialSourceManga>?,
            metadata:
                freezed == metadata
                    ? _value.metadata
                    : metadata // ignore: cast_nullable_to_non_nullable
                        as dynamic,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PagedResultsImplCopyWith<$Res>
    implements $PagedResultsCopyWith<$Res> {
  factory _$$PagedResultsImplCopyWith(
    _$PagedResultsImpl value,
    $Res Function(_$PagedResultsImpl) then,
  ) = __$$PagedResultsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PartialSourceManga>? results, dynamic metadata});
}

/// @nodoc
class __$$PagedResultsImplCopyWithImpl<$Res>
    extends _$PagedResultsCopyWithImpl<$Res, _$PagedResultsImpl>
    implements _$$PagedResultsImplCopyWith<$Res> {
  __$$PagedResultsImplCopyWithImpl(
    _$PagedResultsImpl _value,
    $Res Function(_$PagedResultsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PagedResults
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? results = freezed, Object? metadata = freezed}) {
    return _then(
      _$PagedResultsImpl(
        results:
            freezed == results
                ? _value._results
                : results // ignore: cast_nullable_to_non_nullable
                    as List<PartialSourceManga>?,
        metadata:
            freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                    as dynamic,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PagedResultsImpl implements _PagedResults {
  const _$PagedResultsImpl({
    final List<PartialSourceManga>? results,
    this.metadata,
  }) : _results = results;

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
    const DeepCollectionEquality().hash(metadata),
  );

  /// Create a copy of PagedResults
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PagedResultsImplCopyWith<_$PagedResultsImpl> get copyWith =>
      __$$PagedResultsImplCopyWithImpl<_$PagedResultsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PagedResultsImplToJson(this);
  }
}

abstract class _PagedResults implements PagedResults {
  const factory _PagedResults({
    final List<PartialSourceManga>? results,
    final dynamic metadata,
  }) = _$PagedResultsImpl;

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
  $Res call({
    String image,
    String? artist,
    String? author,
    String desc,
    String status,
    bool? hentai,
    List<String> titles,
    String? banner,
    num? rating,
    List<TagSection>? tags,
    List<String>? covers,
  });
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
    return _then(
      _value.copyWith(
            image:
                null == image
                    ? _value.image
                    : image // ignore: cast_nullable_to_non_nullable
                        as String,
            artist:
                freezed == artist
                    ? _value.artist
                    : artist // ignore: cast_nullable_to_non_nullable
                        as String?,
            author:
                freezed == author
                    ? _value.author
                    : author // ignore: cast_nullable_to_non_nullable
                        as String?,
            desc:
                null == desc
                    ? _value.desc
                    : desc // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            hentai:
                freezed == hentai
                    ? _value.hentai
                    : hentai // ignore: cast_nullable_to_non_nullable
                        as bool?,
            titles:
                null == titles
                    ? _value.titles
                    : titles // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            banner:
                freezed == banner
                    ? _value.banner
                    : banner // ignore: cast_nullable_to_non_nullable
                        as String?,
            rating:
                freezed == rating
                    ? _value.rating
                    : rating // ignore: cast_nullable_to_non_nullable
                        as num?,
            tags:
                freezed == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<TagSection>?,
            covers:
                freezed == covers
                    ? _value.covers
                    : covers // ignore: cast_nullable_to_non_nullable
                        as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MangaInfoImplCopyWith<$Res>
    implements $MangaInfoCopyWith<$Res> {
  factory _$$MangaInfoImplCopyWith(
    _$MangaInfoImpl value,
    $Res Function(_$MangaInfoImpl) then,
  ) = __$$MangaInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String image,
    String? artist,
    String? author,
    String desc,
    String status,
    bool? hentai,
    List<String> titles,
    String? banner,
    num? rating,
    List<TagSection>? tags,
    List<String>? covers,
  });
}

/// @nodoc
class __$$MangaInfoImplCopyWithImpl<$Res>
    extends _$MangaInfoCopyWithImpl<$Res, _$MangaInfoImpl>
    implements _$$MangaInfoImplCopyWith<$Res> {
  __$$MangaInfoImplCopyWithImpl(
    _$MangaInfoImpl _value,
    $Res Function(_$MangaInfoImpl) _then,
  ) : super(_value, _then);

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
    return _then(
      _$MangaInfoImpl(
        image:
            null == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                    as String,
        artist:
            freezed == artist
                ? _value.artist
                : artist // ignore: cast_nullable_to_non_nullable
                    as String?,
        author:
            freezed == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                    as String?,
        desc:
            null == desc
                ? _value.desc
                : desc // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        hentai:
            freezed == hentai
                ? _value.hentai
                : hentai // ignore: cast_nullable_to_non_nullable
                    as bool?,
        titles:
            null == titles
                ? _value._titles
                : titles // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        banner:
            freezed == banner
                ? _value.banner
                : banner // ignore: cast_nullable_to_non_nullable
                    as String?,
        rating:
            freezed == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                    as num?,
        tags:
            freezed == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<TagSection>?,
        covers:
            freezed == covers
                ? _value._covers
                : covers // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaInfoImpl implements _MangaInfo {
  const _$MangaInfoImpl({
    required this.image,
    this.artist,
    this.author,
    required this.desc,
    required this.status,
    this.hentai,
    required final List<String> titles,
    this.banner,
    this.rating,
    final List<TagSection>? tags,
    final List<String>? covers,
  }) : _titles = titles,
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
    const DeepCollectionEquality().hash(_covers),
  );

  /// Create a copy of MangaInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaInfoImplCopyWith<_$MangaInfoImpl> get copyWith =>
      __$$MangaInfoImplCopyWithImpl<_$MangaInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaInfoImplToJson(this);
  }
}

abstract class _MangaInfo implements MangaInfo {
  const factory _MangaInfo({
    required final String image,
    final String? artist,
    final String? author,
    required final String desc,
    required final String status,
    final bool? hentai,
    required final List<String> titles,
    final String? banner,
    final num? rating,
    final List<TagSection>? tags,
    final List<String>? covers,
  }) = _$MangaInfoImpl;

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
  $Res call({Object? id = null, Object? label = null}) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            label:
                null == label
                    ? _value.label
                    : label // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
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
  $Res call({Object? id = null, Object? label = null}) {
    return _then(
      _$TagImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
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
    return _$$TagImplToJson(this);
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
    TagSection value,
    $Res Function(TagSection) then,
  ) = _$TagSectionCopyWithImpl<$Res, TagSection>;
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
  $Res call({Object? id = null, Object? label = null, Object? tags = null}) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            label:
                null == label
                    ? _value.label
                    : label // ignore: cast_nullable_to_non_nullable
                        as String,
            tags:
                null == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<Tag>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TagSectionImplCopyWith<$Res>
    implements $TagSectionCopyWith<$Res> {
  factory _$$TagSectionImplCopyWith(
    _$TagSectionImpl value,
    $Res Function(_$TagSectionImpl) then,
  ) = __$$TagSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String label, List<Tag> tags});
}

/// @nodoc
class __$$TagSectionImplCopyWithImpl<$Res>
    extends _$TagSectionCopyWithImpl<$Res, _$TagSectionImpl>
    implements _$$TagSectionImplCopyWith<$Res> {
  __$$TagSectionImplCopyWithImpl(
    _$TagSectionImpl _value,
    $Res Function(_$TagSectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TagSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? label = null, Object? tags = null}) {
    return _then(
      _$TagSectionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
        tags:
            null == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<Tag>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TagSectionImpl implements _TagSection {
  const _$TagSectionImpl({
    required this.id,
    required this.label,
    required final List<Tag> tags,
  }) : _tags = tags;

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
    runtimeType,
    id,
    label,
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of TagSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagSectionImplCopyWith<_$TagSectionImpl> get copyWith =>
      __$$TagSectionImplCopyWithImpl<_$TagSectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagSectionImplToJson(this);
  }
}

abstract class _TagSection implements TagSection {
  const factory _TagSection({
    required final String id,
    required final String label,
    required final List<Tag> tags,
  }) = _$TagSectionImpl;

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
    SourceManga value,
    $Res Function(SourceManga) then,
  ) = _$SourceMangaCopyWithImpl<$Res, SourceManga>;
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
  $Res call({Object? id = null, Object? mangaInfo = null}) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            mangaInfo:
                null == mangaInfo
                    ? _value.mangaInfo
                    : mangaInfo // ignore: cast_nullable_to_non_nullable
                        as MangaInfo,
          )
          as $Val,
    );
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
    _$SourceMangaImpl value,
    $Res Function(_$SourceMangaImpl) then,
  ) = __$$SourceMangaImplCopyWithImpl<$Res>;
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
    _$SourceMangaImpl _value,
    $Res Function(_$SourceMangaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SourceManga
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? mangaInfo = null}) {
    return _then(
      _$SourceMangaImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        mangaInfo:
            null == mangaInfo
                ? _value.mangaInfo
                : mangaInfo // ignore: cast_nullable_to_non_nullable
                    as MangaInfo,
      ),
    );
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
    return _$$SourceMangaImplToJson(this);
  }
}

abstract class _SourceManga implements SourceManga {
  const factory _SourceManga({
    required final String id,
    required final MangaInfo mangaInfo,
  }) = _$SourceMangaImpl;

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
  $Res call({
    String id,
    num chapNum,
    String? langCode,
    String? name,
    num? volume,
    String? group,
    @TimestampSerializer() DateTime? time,
    num? sortingIndex,
  });
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
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            chapNum:
                null == chapNum
                    ? _value.chapNum
                    : chapNum // ignore: cast_nullable_to_non_nullable
                        as num,
            langCode:
                freezed == langCode
                    ? _value.langCode
                    : langCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            volume:
                freezed == volume
                    ? _value.volume
                    : volume // ignore: cast_nullable_to_non_nullable
                        as num?,
            group:
                freezed == group
                    ? _value.group
                    : group // ignore: cast_nullable_to_non_nullable
                        as String?,
            time:
                freezed == time
                    ? _value.time
                    : time // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            sortingIndex:
                freezed == sortingIndex
                    ? _value.sortingIndex
                    : sortingIndex // ignore: cast_nullable_to_non_nullable
                        as num?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChapterImplCopyWith<$Res> implements $ChapterCopyWith<$Res> {
  factory _$$ChapterImplCopyWith(
    _$ChapterImpl value,
    $Res Function(_$ChapterImpl) then,
  ) = __$$ChapterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    num chapNum,
    String? langCode,
    String? name,
    num? volume,
    String? group,
    @TimestampSerializer() DateTime? time,
    num? sortingIndex,
  });
}

/// @nodoc
class __$$ChapterImplCopyWithImpl<$Res>
    extends _$ChapterCopyWithImpl<$Res, _$ChapterImpl>
    implements _$$ChapterImplCopyWith<$Res> {
  __$$ChapterImplCopyWithImpl(
    _$ChapterImpl _value,
    $Res Function(_$ChapterImpl) _then,
  ) : super(_value, _then);

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
    return _then(
      _$ChapterImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        chapNum:
            null == chapNum
                ? _value.chapNum
                : chapNum // ignore: cast_nullable_to_non_nullable
                    as num,
        langCode:
            freezed == langCode
                ? _value.langCode
                : langCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        volume:
            freezed == volume
                ? _value.volume
                : volume // ignore: cast_nullable_to_non_nullable
                    as num?,
        group:
            freezed == group
                ? _value.group
                : group // ignore: cast_nullable_to_non_nullable
                    as String?,
        time:
            freezed == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        sortingIndex:
            freezed == sortingIndex
                ? _value.sortingIndex
                : sortingIndex // ignore: cast_nullable_to_non_nullable
                    as num?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChapterImpl implements _Chapter {
  const _$ChapterImpl({
    required this.id,
    required this.chapNum,
    this.langCode,
    this.name,
    this.volume,
    this.group,
    @TimestampSerializer() this.time,
    this.sortingIndex,
  });

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
  int get hashCode => Object.hash(
    runtimeType,
    id,
    chapNum,
    langCode,
    name,
    volume,
    group,
    time,
    sortingIndex,
  );

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
      __$$ChapterImplCopyWithImpl<_$ChapterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterImplToJson(this);
  }
}

abstract class _Chapter implements Chapter {
  const factory _Chapter({
    required final String id,
    required final num chapNum,
    final String? langCode,
    final String? name,
    final num? volume,
    final String? group,
    @TimestampSerializer() final DateTime? time,
    final num? sortingIndex,
  }) = _$ChapterImpl;

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
    ChapterDetails value,
    $Res Function(ChapterDetails) then,
  ) = _$ChapterDetailsCopyWithImpl<$Res, ChapterDetails>;
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
  $Res call({Object? id = null, Object? mangaId = null, Object? pages = null}) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            mangaId:
                null == mangaId
                    ? _value.mangaId
                    : mangaId // ignore: cast_nullable_to_non_nullable
                        as String,
            pages:
                null == pages
                    ? _value.pages
                    : pages // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChapterDetailsImplCopyWith<$Res>
    implements $ChapterDetailsCopyWith<$Res> {
  factory _$$ChapterDetailsImplCopyWith(
    _$ChapterDetailsImpl value,
    $Res Function(_$ChapterDetailsImpl) then,
  ) = __$$ChapterDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String mangaId, List<String> pages});
}

/// @nodoc
class __$$ChapterDetailsImplCopyWithImpl<$Res>
    extends _$ChapterDetailsCopyWithImpl<$Res, _$ChapterDetailsImpl>
    implements _$$ChapterDetailsImplCopyWith<$Res> {
  __$$ChapterDetailsImplCopyWithImpl(
    _$ChapterDetailsImpl _value,
    $Res Function(_$ChapterDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChapterDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? mangaId = null, Object? pages = null}) {
    return _then(
      _$ChapterDetailsImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        mangaId:
            null == mangaId
                ? _value.mangaId
                : mangaId // ignore: cast_nullable_to_non_nullable
                    as String,
        pages:
            null == pages
                ? _value._pages
                : pages // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChapterDetailsImpl implements _ChapterDetails {
  const _$ChapterDetailsImpl({
    required this.id,
    required this.mangaId,
    required final List<String> pages,
  }) : _pages = pages;

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
    runtimeType,
    id,
    mangaId,
    const DeepCollectionEquality().hash(_pages),
  );

  /// Create a copy of ChapterDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterDetailsImplCopyWith<_$ChapterDetailsImpl> get copyWith =>
      __$$ChapterDetailsImplCopyWithImpl<_$ChapterDetailsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterDetailsImplToJson(this);
  }
}

abstract class _ChapterDetails implements ChapterDetails {
  const factory _ChapterDetails({
    required final String id,
    required final String mangaId,
    required final List<String> pages,
  }) = _$ChapterDetailsImpl;

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
    SearchRequest value,
    $Res Function(SearchRequest) then,
  ) = _$SearchRequestCopyWithImpl<$Res, SearchRequest>;
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
    return _then(
      _value.copyWith(
            title:
                freezed == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String?,
            includedTags:
                freezed == includedTags
                    ? _value.includedTags
                    : includedTags // ignore: cast_nullable_to_non_nullable
                        as List<Tag>?,
            excludedTags:
                freezed == excludedTags
                    ? _value.excludedTags
                    : excludedTags // ignore: cast_nullable_to_non_nullable
                        as List<Tag>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SearchRequestImplCopyWith<$Res>
    implements $SearchRequestCopyWith<$Res> {
  factory _$$SearchRequestImplCopyWith(
    _$SearchRequestImpl value,
    $Res Function(_$SearchRequestImpl) then,
  ) = __$$SearchRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, List<Tag>? includedTags, List<Tag>? excludedTags});
}

/// @nodoc
class __$$SearchRequestImplCopyWithImpl<$Res>
    extends _$SearchRequestCopyWithImpl<$Res, _$SearchRequestImpl>
    implements _$$SearchRequestImplCopyWith<$Res> {
  __$$SearchRequestImplCopyWithImpl(
    _$SearchRequestImpl _value,
    $Res Function(_$SearchRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? includedTags = freezed,
    Object? excludedTags = freezed,
  }) {
    return _then(
      _$SearchRequestImpl(
        title:
            freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String?,
        includedTags:
            freezed == includedTags
                ? _value._includedTags
                : includedTags // ignore: cast_nullable_to_non_nullable
                    as List<Tag>?,
        excludedTags:
            freezed == excludedTags
                ? _value._excludedTags
                : excludedTags // ignore: cast_nullable_to_non_nullable
                    as List<Tag>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchRequestImpl implements _SearchRequest {
  const _$SearchRequestImpl({
    this.title,
    final List<Tag>? includedTags,
    final List<Tag>? excludedTags,
  }) : _includedTags = includedTags,
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
            const DeepCollectionEquality().equals(
              other._includedTags,
              _includedTags,
            ) &&
            const DeepCollectionEquality().equals(
              other._excludedTags,
              _excludedTags,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    const DeepCollectionEquality().hash(_includedTags),
    const DeepCollectionEquality().hash(_excludedTags),
  );

  /// Create a copy of SearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchRequestImplCopyWith<_$SearchRequestImpl> get copyWith =>
      __$$SearchRequestImplCopyWithImpl<_$SearchRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchRequestImplToJson(this);
  }
}

abstract class _SearchRequest implements SearchRequest {
  const factory _SearchRequest({
    final String? title,
    final List<Tag>? includedTags,
    final List<Tag>? excludedTags,
  }) = _$SearchRequestImpl;

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

HomeSection _$HomeSectionFromJson(Map<String, dynamic> json) {
  return _HomeSection.fromJson(json);
}

/// @nodoc
mixin _$HomeSection {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<PartialSourceManga> get items => throw _privateConstructorUsedError;
  bool get containsMoreItems => throw _privateConstructorUsedError;

  /// Serializes this HomeSection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeSectionCopyWith<HomeSection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeSectionCopyWith<$Res> {
  factory $HomeSectionCopyWith(
    HomeSection value,
    $Res Function(HomeSection) then,
  ) = _$HomeSectionCopyWithImpl<$Res, HomeSection>;
  @useResult
  $Res call({
    String id,
    String title,
    List<PartialSourceManga> items,
    bool containsMoreItems,
  });
}

/// @nodoc
class _$HomeSectionCopyWithImpl<$Res, $Val extends HomeSection>
    implements $HomeSectionCopyWith<$Res> {
  _$HomeSectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? items = null,
    Object? containsMoreItems = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            items:
                null == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<PartialSourceManga>,
            containsMoreItems:
                null == containsMoreItems
                    ? _value.containsMoreItems
                    : containsMoreItems // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeSectionImplCopyWith<$Res>
    implements $HomeSectionCopyWith<$Res> {
  factory _$$HomeSectionImplCopyWith(
    _$HomeSectionImpl value,
    $Res Function(_$HomeSectionImpl) then,
  ) = __$$HomeSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    List<PartialSourceManga> items,
    bool containsMoreItems,
  });
}

/// @nodoc
class __$$HomeSectionImplCopyWithImpl<$Res>
    extends _$HomeSectionCopyWithImpl<$Res, _$HomeSectionImpl>
    implements _$$HomeSectionImplCopyWith<$Res> {
  __$$HomeSectionImplCopyWithImpl(
    _$HomeSectionImpl _value,
    $Res Function(_$HomeSectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? items = null,
    Object? containsMoreItems = null,
  }) {
    return _then(
      _$HomeSectionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        items:
            null == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<PartialSourceManga>,
        containsMoreItems:
            null == containsMoreItems
                ? _value.containsMoreItems
                : containsMoreItems // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeSectionImpl implements _HomeSection {
  const _$HomeSectionImpl({
    required this.id,
    required this.title,
    required final List<PartialSourceManga> items,
    required this.containsMoreItems,
  }) : _items = items;

  factory _$HomeSectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeSectionImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  final List<PartialSourceManga> _items;
  @override
  List<PartialSourceManga> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool containsMoreItems;

  @override
  String toString() {
    return 'HomeSection(id: $id, title: $title, items: $items, containsMoreItems: $containsMoreItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeSectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.containsMoreItems, containsMoreItems) ||
                other.containsMoreItems == containsMoreItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    const DeepCollectionEquality().hash(_items),
    containsMoreItems,
  );

  /// Create a copy of HomeSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeSectionImplCopyWith<_$HomeSectionImpl> get copyWith =>
      __$$HomeSectionImplCopyWithImpl<_$HomeSectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeSectionImplToJson(this);
  }
}

abstract class _HomeSection implements HomeSection {
  const factory _HomeSection({
    required final String id,
    required final String title,
    required final List<PartialSourceManga> items,
    required final bool containsMoreItems,
  }) = _$HomeSectionImpl;

  factory _HomeSection.fromJson(Map<String, dynamic> json) =
      _$HomeSectionImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  List<PartialSourceManga> get items;
  @override
  bool get containsMoreItems;

  /// Create a copy of HomeSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeSectionImplCopyWith<_$HomeSectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DUIOAuthResponseType _$DUIOAuthResponseTypeFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'token':
      return DUIOAuthTokenResponse.fromJson(json);
    case 'code':
      return DUIOAuthCodeResponse.fromJson(json);
    case 'pkce':
      return DUIOAuthPKCEResponse.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'type',
        'DUIOAuthResponseType',
        'Invalid union type "${json['type']}"!',
      );
  }
}

/// @nodoc
mixin _$DUIOAuthResponseType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() token,
    required TResult Function(String tokenEndpoint) code,
    required TResult Function(
      String tokenEndpoint,
      num pkceCodeLength,
      String pkceCodeMethod,
      bool formEncodeGrant,
    )
    pkce,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? token,
    TResult? Function(String tokenEndpoint)? code,
    TResult? Function(
      String tokenEndpoint,
      num pkceCodeLength,
      String pkceCodeMethod,
      bool formEncodeGrant,
    )?
    pkce,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? token,
    TResult Function(String tokenEndpoint)? code,
    TResult Function(
      String tokenEndpoint,
      num pkceCodeLength,
      String pkceCodeMethod,
      bool formEncodeGrant,
    )?
    pkce,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUIOAuthTokenResponse value) token,
    required TResult Function(DUIOAuthCodeResponse value) code,
    required TResult Function(DUIOAuthPKCEResponse value) pkce,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUIOAuthTokenResponse value)? token,
    TResult? Function(DUIOAuthCodeResponse value)? code,
    TResult? Function(DUIOAuthPKCEResponse value)? pkce,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUIOAuthTokenResponse value)? token,
    TResult Function(DUIOAuthCodeResponse value)? code,
    TResult Function(DUIOAuthPKCEResponse value)? pkce,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this DUIOAuthResponseType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DUIOAuthResponseTypeCopyWith<$Res> {
  factory $DUIOAuthResponseTypeCopyWith(
    DUIOAuthResponseType value,
    $Res Function(DUIOAuthResponseType) then,
  ) = _$DUIOAuthResponseTypeCopyWithImpl<$Res, DUIOAuthResponseType>;
}

/// @nodoc
class _$DUIOAuthResponseTypeCopyWithImpl<
  $Res,
  $Val extends DUIOAuthResponseType
>
    implements $DUIOAuthResponseTypeCopyWith<$Res> {
  _$DUIOAuthResponseTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DUIOAuthResponseType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DUIOAuthTokenResponseImplCopyWith<$Res> {
  factory _$$DUIOAuthTokenResponseImplCopyWith(
    _$DUIOAuthTokenResponseImpl value,
    $Res Function(_$DUIOAuthTokenResponseImpl) then,
  ) = __$$DUIOAuthTokenResponseImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DUIOAuthTokenResponseImplCopyWithImpl<$Res>
    extends
        _$DUIOAuthResponseTypeCopyWithImpl<$Res, _$DUIOAuthTokenResponseImpl>
    implements _$$DUIOAuthTokenResponseImplCopyWith<$Res> {
  __$$DUIOAuthTokenResponseImplCopyWithImpl(
    _$DUIOAuthTokenResponseImpl _value,
    $Res Function(_$DUIOAuthTokenResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIOAuthResponseType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$DUIOAuthTokenResponseImpl implements DUIOAuthTokenResponse {
  const _$DUIOAuthTokenResponseImpl({final String? $type})
    : $type = $type ?? 'token';

  factory _$DUIOAuthTokenResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUIOAuthTokenResponseImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIOAuthResponseType.token()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUIOAuthTokenResponseImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() token,
    required TResult Function(String tokenEndpoint) code,
    required TResult Function(
      String tokenEndpoint,
      num pkceCodeLength,
      String pkceCodeMethod,
      bool formEncodeGrant,
    )
    pkce,
  }) {
    return token();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? token,
    TResult? Function(String tokenEndpoint)? code,
    TResult? Function(
      String tokenEndpoint,
      num pkceCodeLength,
      String pkceCodeMethod,
      bool formEncodeGrant,
    )?
    pkce,
  }) {
    return token?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? token,
    TResult Function(String tokenEndpoint)? code,
    TResult Function(
      String tokenEndpoint,
      num pkceCodeLength,
      String pkceCodeMethod,
      bool formEncodeGrant,
    )?
    pkce,
    required TResult orElse(),
  }) {
    if (token != null) {
      return token();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUIOAuthTokenResponse value) token,
    required TResult Function(DUIOAuthCodeResponse value) code,
    required TResult Function(DUIOAuthPKCEResponse value) pkce,
  }) {
    return token(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUIOAuthTokenResponse value)? token,
    TResult? Function(DUIOAuthCodeResponse value)? code,
    TResult? Function(DUIOAuthPKCEResponse value)? pkce,
  }) {
    return token?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUIOAuthTokenResponse value)? token,
    TResult Function(DUIOAuthCodeResponse value)? code,
    TResult Function(DUIOAuthPKCEResponse value)? pkce,
    required TResult orElse(),
  }) {
    if (token != null) {
      return token(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUIOAuthTokenResponseImplToJson(this);
  }
}

abstract class DUIOAuthTokenResponse implements DUIOAuthResponseType {
  const factory DUIOAuthTokenResponse() = _$DUIOAuthTokenResponseImpl;

  factory DUIOAuthTokenResponse.fromJson(Map<String, dynamic> json) =
      _$DUIOAuthTokenResponseImpl.fromJson;
}

/// @nodoc
abstract class _$$DUIOAuthCodeResponseImplCopyWith<$Res> {
  factory _$$DUIOAuthCodeResponseImplCopyWith(
    _$DUIOAuthCodeResponseImpl value,
    $Res Function(_$DUIOAuthCodeResponseImpl) then,
  ) = __$$DUIOAuthCodeResponseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String tokenEndpoint});
}

/// @nodoc
class __$$DUIOAuthCodeResponseImplCopyWithImpl<$Res>
    extends _$DUIOAuthResponseTypeCopyWithImpl<$Res, _$DUIOAuthCodeResponseImpl>
    implements _$$DUIOAuthCodeResponseImplCopyWith<$Res> {
  __$$DUIOAuthCodeResponseImplCopyWithImpl(
    _$DUIOAuthCodeResponseImpl _value,
    $Res Function(_$DUIOAuthCodeResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIOAuthResponseType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tokenEndpoint = null}) {
    return _then(
      _$DUIOAuthCodeResponseImpl(
        tokenEndpoint:
            null == tokenEndpoint
                ? _value.tokenEndpoint
                : tokenEndpoint // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUIOAuthCodeResponseImpl implements DUIOAuthCodeResponse {
  const _$DUIOAuthCodeResponseImpl({
    required this.tokenEndpoint,
    final String? $type,
  }) : $type = $type ?? 'code';

  factory _$DUIOAuthCodeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUIOAuthCodeResponseImplFromJson(json);

  @override
  final String tokenEndpoint;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIOAuthResponseType.code(tokenEndpoint: $tokenEndpoint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUIOAuthCodeResponseImpl &&
            (identical(other.tokenEndpoint, tokenEndpoint) ||
                other.tokenEndpoint == tokenEndpoint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tokenEndpoint);

  /// Create a copy of DUIOAuthResponseType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUIOAuthCodeResponseImplCopyWith<_$DUIOAuthCodeResponseImpl>
  get copyWith =>
      __$$DUIOAuthCodeResponseImplCopyWithImpl<_$DUIOAuthCodeResponseImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() token,
    required TResult Function(String tokenEndpoint) code,
    required TResult Function(
      String tokenEndpoint,
      num pkceCodeLength,
      String pkceCodeMethod,
      bool formEncodeGrant,
    )
    pkce,
  }) {
    return code(tokenEndpoint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? token,
    TResult? Function(String tokenEndpoint)? code,
    TResult? Function(
      String tokenEndpoint,
      num pkceCodeLength,
      String pkceCodeMethod,
      bool formEncodeGrant,
    )?
    pkce,
  }) {
    return code?.call(tokenEndpoint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? token,
    TResult Function(String tokenEndpoint)? code,
    TResult Function(
      String tokenEndpoint,
      num pkceCodeLength,
      String pkceCodeMethod,
      bool formEncodeGrant,
    )?
    pkce,
    required TResult orElse(),
  }) {
    if (code != null) {
      return code(tokenEndpoint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUIOAuthTokenResponse value) token,
    required TResult Function(DUIOAuthCodeResponse value) code,
    required TResult Function(DUIOAuthPKCEResponse value) pkce,
  }) {
    return code(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUIOAuthTokenResponse value)? token,
    TResult? Function(DUIOAuthCodeResponse value)? code,
    TResult? Function(DUIOAuthPKCEResponse value)? pkce,
  }) {
    return code?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUIOAuthTokenResponse value)? token,
    TResult Function(DUIOAuthCodeResponse value)? code,
    TResult Function(DUIOAuthPKCEResponse value)? pkce,
    required TResult orElse(),
  }) {
    if (code != null) {
      return code(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUIOAuthCodeResponseImplToJson(this);
  }
}

abstract class DUIOAuthCodeResponse implements DUIOAuthResponseType {
  const factory DUIOAuthCodeResponse({required final String tokenEndpoint}) =
      _$DUIOAuthCodeResponseImpl;

  factory DUIOAuthCodeResponse.fromJson(Map<String, dynamic> json) =
      _$DUIOAuthCodeResponseImpl.fromJson;

  String get tokenEndpoint;

  /// Create a copy of DUIOAuthResponseType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUIOAuthCodeResponseImplCopyWith<_$DUIOAuthCodeResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUIOAuthPKCEResponseImplCopyWith<$Res> {
  factory _$$DUIOAuthPKCEResponseImplCopyWith(
    _$DUIOAuthPKCEResponseImpl value,
    $Res Function(_$DUIOAuthPKCEResponseImpl) then,
  ) = __$$DUIOAuthPKCEResponseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String tokenEndpoint,
    num pkceCodeLength,
    String pkceCodeMethod,
    bool formEncodeGrant,
  });
}

/// @nodoc
class __$$DUIOAuthPKCEResponseImplCopyWithImpl<$Res>
    extends _$DUIOAuthResponseTypeCopyWithImpl<$Res, _$DUIOAuthPKCEResponseImpl>
    implements _$$DUIOAuthPKCEResponseImplCopyWith<$Res> {
  __$$DUIOAuthPKCEResponseImplCopyWithImpl(
    _$DUIOAuthPKCEResponseImpl _value,
    $Res Function(_$DUIOAuthPKCEResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIOAuthResponseType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenEndpoint = null,
    Object? pkceCodeLength = null,
    Object? pkceCodeMethod = null,
    Object? formEncodeGrant = null,
  }) {
    return _then(
      _$DUIOAuthPKCEResponseImpl(
        tokenEndpoint:
            null == tokenEndpoint
                ? _value.tokenEndpoint
                : tokenEndpoint // ignore: cast_nullable_to_non_nullable
                    as String,
        pkceCodeLength:
            null == pkceCodeLength
                ? _value.pkceCodeLength
                : pkceCodeLength // ignore: cast_nullable_to_non_nullable
                    as num,
        pkceCodeMethod:
            null == pkceCodeMethod
                ? _value.pkceCodeMethod
                : pkceCodeMethod // ignore: cast_nullable_to_non_nullable
                    as String,
        formEncodeGrant:
            null == formEncodeGrant
                ? _value.formEncodeGrant
                : formEncodeGrant // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUIOAuthPKCEResponseImpl implements DUIOAuthPKCEResponse {
  const _$DUIOAuthPKCEResponseImpl({
    required this.tokenEndpoint,
    required this.pkceCodeLength,
    required this.pkceCodeMethod,
    required this.formEncodeGrant,
    final String? $type,
  }) : $type = $type ?? 'pkce';

  factory _$DUIOAuthPKCEResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUIOAuthPKCEResponseImplFromJson(json);

  @override
  final String tokenEndpoint;
  @override
  final num pkceCodeLength;
  @override
  final String pkceCodeMethod;
  @override
  final bool formEncodeGrant;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIOAuthResponseType.pkce(tokenEndpoint: $tokenEndpoint, pkceCodeLength: $pkceCodeLength, pkceCodeMethod: $pkceCodeMethod, formEncodeGrant: $formEncodeGrant)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUIOAuthPKCEResponseImpl &&
            (identical(other.tokenEndpoint, tokenEndpoint) ||
                other.tokenEndpoint == tokenEndpoint) &&
            (identical(other.pkceCodeLength, pkceCodeLength) ||
                other.pkceCodeLength == pkceCodeLength) &&
            (identical(other.pkceCodeMethod, pkceCodeMethod) ||
                other.pkceCodeMethod == pkceCodeMethod) &&
            (identical(other.formEncodeGrant, formEncodeGrant) ||
                other.formEncodeGrant == formEncodeGrant));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tokenEndpoint,
    pkceCodeLength,
    pkceCodeMethod,
    formEncodeGrant,
  );

  /// Create a copy of DUIOAuthResponseType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUIOAuthPKCEResponseImplCopyWith<_$DUIOAuthPKCEResponseImpl>
  get copyWith =>
      __$$DUIOAuthPKCEResponseImplCopyWithImpl<_$DUIOAuthPKCEResponseImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() token,
    required TResult Function(String tokenEndpoint) code,
    required TResult Function(
      String tokenEndpoint,
      num pkceCodeLength,
      String pkceCodeMethod,
      bool formEncodeGrant,
    )
    pkce,
  }) {
    return pkce(tokenEndpoint, pkceCodeLength, pkceCodeMethod, formEncodeGrant);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? token,
    TResult? Function(String tokenEndpoint)? code,
    TResult? Function(
      String tokenEndpoint,
      num pkceCodeLength,
      String pkceCodeMethod,
      bool formEncodeGrant,
    )?
    pkce,
  }) {
    return pkce?.call(
      tokenEndpoint,
      pkceCodeLength,
      pkceCodeMethod,
      formEncodeGrant,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? token,
    TResult Function(String tokenEndpoint)? code,
    TResult Function(
      String tokenEndpoint,
      num pkceCodeLength,
      String pkceCodeMethod,
      bool formEncodeGrant,
    )?
    pkce,
    required TResult orElse(),
  }) {
    if (pkce != null) {
      return pkce(
        tokenEndpoint,
        pkceCodeLength,
        pkceCodeMethod,
        formEncodeGrant,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUIOAuthTokenResponse value) token,
    required TResult Function(DUIOAuthCodeResponse value) code,
    required TResult Function(DUIOAuthPKCEResponse value) pkce,
  }) {
    return pkce(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUIOAuthTokenResponse value)? token,
    TResult? Function(DUIOAuthCodeResponse value)? code,
    TResult? Function(DUIOAuthPKCEResponse value)? pkce,
  }) {
    return pkce?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUIOAuthTokenResponse value)? token,
    TResult Function(DUIOAuthCodeResponse value)? code,
    TResult Function(DUIOAuthPKCEResponse value)? pkce,
    required TResult orElse(),
  }) {
    if (pkce != null) {
      return pkce(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUIOAuthPKCEResponseImplToJson(this);
  }
}

abstract class DUIOAuthPKCEResponse implements DUIOAuthResponseType {
  const factory DUIOAuthPKCEResponse({
    required final String tokenEndpoint,
    required final num pkceCodeLength,
    required final String pkceCodeMethod,
    required final bool formEncodeGrant,
  }) = _$DUIOAuthPKCEResponseImpl;

  factory DUIOAuthPKCEResponse.fromJson(Map<String, dynamic> json) =
      _$DUIOAuthPKCEResponseImpl.fromJson;

  String get tokenEndpoint;
  num get pkceCodeLength;
  String get pkceCodeMethod;
  bool get formEncodeGrant;

  /// Create a copy of DUIOAuthResponseType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUIOAuthPKCEResponseImplCopyWith<_$DUIOAuthPKCEResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DUIType _$DUITypeFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'DUISection':
      return DUISection.fromJson(json);
    case 'DUISelect':
      return DUISelect.fromJson(json);
    case 'DUIInputField':
      return DUIInputField.fromJson(json);
    case 'DUISecureInputField':
      return DUISecureInputField.fromJson(json);
    case 'DUIStepper':
      return DUIStepper.fromJson(json);
    case 'DUILabel':
      return DUILabel.fromJson(json);
    case 'DUIMultilineLabel':
      return DUIMultilineLabel.fromJson(json);
    case 'DUIHeader':
      return DUIHeader.fromJson(json);
    case 'DUIButton':
      return DUIButton.fromJson(json);
    case 'DUINavigationButton':
      return DUINavigationButton.fromJson(json);
    case 'DUISwitch':
      return DUISwitch.fromJson(json);
    case 'DUIOAuthButton':
      return DUIOAuthButton.fromJson(json);
    case 'DUIForm':
      return DUIForm.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'type',
        'DUIType',
        'Invalid union type "${json['type']}"!',
      );
  }
}

/// @nodoc
mixin _$DUIType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this DUIType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DUITypeCopyWith<$Res> {
  factory $DUITypeCopyWith(DUIType value, $Res Function(DUIType) then) =
      _$DUITypeCopyWithImpl<$Res, DUIType>;
}

/// @nodoc
class _$DUITypeCopyWithImpl<$Res, $Val extends DUIType>
    implements $DUITypeCopyWith<$Res> {
  _$DUITypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DUISectionImplCopyWith<$Res> {
  factory _$$DUISectionImplCopyWith(
    _$DUISectionImpl value,
    $Res Function(_$DUISectionImpl) then,
  ) = __$$DUISectionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String id,
    String? header,
    String? footer,
    bool isHidden,
    List<DUIType> rows,
  });
}

/// @nodoc
class __$$DUISectionImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUISectionImpl>
    implements _$$DUISectionImplCopyWith<$Res> {
  __$$DUISectionImplCopyWithImpl(
    _$DUISectionImpl _value,
    $Res Function(_$DUISectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? header = freezed,
    Object? footer = freezed,
    Object? isHidden = null,
    Object? rows = null,
  }) {
    return _then(
      _$DUISectionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        header:
            freezed == header
                ? _value.header
                : header // ignore: cast_nullable_to_non_nullable
                    as String?,
        footer:
            freezed == footer
                ? _value.footer
                : footer // ignore: cast_nullable_to_non_nullable
                    as String?,
        isHidden:
            null == isHidden
                ? _value.isHidden
                : isHidden // ignore: cast_nullable_to_non_nullable
                    as bool,
        rows:
            null == rows
                ? _value._rows
                : rows // ignore: cast_nullable_to_non_nullable
                    as List<DUIType>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUISectionImpl implements DUISection {
  const _$DUISectionImpl({
    required this.id,
    this.header,
    this.footer,
    required this.isHidden,
    required final List<DUIType> rows,
    final String? $type,
  }) : _rows = rows,
       $type = $type ?? 'DUISection';

  factory _$DUISectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUISectionImplFromJson(json);

  @override
  final String id;
  @override
  final String? header;
  @override
  final String? footer;
  @override
  final bool isHidden;
  final List<DUIType> _rows;
  @override
  List<DUIType> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUISection(id: $id, header: $header, footer: $footer, isHidden: $isHidden, rows: $rows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUISectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.header, header) || other.header == header) &&
            (identical(other.footer, footer) || other.footer == footer) &&
            (identical(other.isHidden, isHidden) ||
                other.isHidden == isHidden) &&
            const DeepCollectionEquality().equals(other._rows, _rows));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    header,
    footer,
    isHidden,
    const DeepCollectionEquality().hash(_rows),
  );

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUISectionImplCopyWith<_$DUISectionImpl> get copyWith =>
      __$$DUISectionImplCopyWithImpl<_$DUISectionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUISection(id, header, footer, isHidden, rows);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUISection?.call(id, header, footer, isHidden, rows);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUISection != null) {
      return DUISection(id, header, footer, isHidden, rows);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUISection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUISection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUISection != null) {
      return DUISection(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUISectionImplToJson(this);
  }
}

abstract class DUISection implements DUIType, DUIFormRow {
  const factory DUISection({
    required final String id,
    final String? header,
    final String? footer,
    required final bool isHidden,
    required final List<DUIType> rows,
  }) = _$DUISectionImpl;

  factory DUISection.fromJson(Map<String, dynamic> json) =
      _$DUISectionImpl.fromJson;

  String get id;
  String? get header;
  String? get footer;
  bool get isHidden;
  List<DUIType> get rows;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUISectionImplCopyWith<_$DUISectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUISelectImplCopyWith<$Res> {
  factory _$$DUISelectImplCopyWith(
    _$DUISelectImpl value,
    $Res Function(_$DUISelectImpl) then,
  ) = __$$DUISelectImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String id,
    String label,
    List<String> options,
    bool allowsMultiselect,
    Map<String, String> labels,
  });
}

/// @nodoc
class __$$DUISelectImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUISelectImpl>
    implements _$$DUISelectImplCopyWith<$Res> {
  __$$DUISelectImplCopyWithImpl(
    _$DUISelectImpl _value,
    $Res Function(_$DUISelectImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? options = null,
    Object? allowsMultiselect = null,
    Object? labels = null,
  }) {
    return _then(
      _$DUISelectImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
        options:
            null == options
                ? _value._options
                : options // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        allowsMultiselect:
            null == allowsMultiselect
                ? _value.allowsMultiselect
                : allowsMultiselect // ignore: cast_nullable_to_non_nullable
                    as bool,
        labels:
            null == labels
                ? _value._labels
                : labels // ignore: cast_nullable_to_non_nullable
                    as Map<String, String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUISelectImpl implements DUISelect {
  const _$DUISelectImpl({
    required this.id,
    required this.label,
    required final List<String> options,
    required this.allowsMultiselect,
    required final Map<String, String> labels,
    final String? $type,
  }) : _options = options,
       _labels = labels,
       $type = $type ?? 'DUISelect';

  factory _$DUISelectImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUISelectImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final bool allowsMultiselect;
  final Map<String, String> _labels;
  @override
  Map<String, String> get labels {
    if (_labels is EqualUnmodifiableMapView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_labels);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUISelect(id: $id, label: $label, options: $options, allowsMultiselect: $allowsMultiselect, labels: $labels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUISelectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.allowsMultiselect, allowsMultiselect) ||
                other.allowsMultiselect == allowsMultiselect) &&
            const DeepCollectionEquality().equals(other._labels, _labels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    label,
    const DeepCollectionEquality().hash(_options),
    allowsMultiselect,
    const DeepCollectionEquality().hash(_labels),
  );

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUISelectImplCopyWith<_$DUISelectImpl> get copyWith =>
      __$$DUISelectImplCopyWithImpl<_$DUISelectImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUISelect(id, label, options, allowsMultiselect, labels);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUISelect?.call(id, label, options, allowsMultiselect, labels);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUISelect != null) {
      return DUISelect(id, label, options, allowsMultiselect, labels);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUISelect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUISelect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUISelect != null) {
      return DUISelect(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUISelectImplToJson(this);
  }
}

abstract class DUISelect implements DUIType, DUIFormRow {
  const factory DUISelect({
    required final String id,
    required final String label,
    required final List<String> options,
    required final bool allowsMultiselect,
    required final Map<String, String> labels,
  }) = _$DUISelectImpl;

  factory DUISelect.fromJson(Map<String, dynamic> json) =
      _$DUISelectImpl.fromJson;

  String get id;
  String get label;
  List<String> get options;
  bool get allowsMultiselect;
  Map<String, String> get labels;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUISelectImplCopyWith<_$DUISelectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUIInputFieldImplCopyWith<$Res> {
  factory _$$DUIInputFieldImplCopyWith(
    _$DUIInputFieldImpl value,
    $Res Function(_$DUIInputFieldImpl) then,
  ) = __$$DUIInputFieldImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String label});
}

/// @nodoc
class __$$DUIInputFieldImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUIInputFieldImpl>
    implements _$$DUIInputFieldImplCopyWith<$Res> {
  __$$DUIInputFieldImplCopyWithImpl(
    _$DUIInputFieldImpl _value,
    $Res Function(_$DUIInputFieldImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? label = null}) {
    return _then(
      _$DUIInputFieldImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUIInputFieldImpl implements DUIInputField {
  const _$DUIInputFieldImpl({
    required this.id,
    required this.label,
    final String? $type,
  }) : $type = $type ?? 'DUIInputField';

  factory _$DUIInputFieldImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUIInputFieldImplFromJson(json);

  @override
  final String id;
  @override
  final String label;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUIInputField(id: $id, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUIInputFieldImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUIInputFieldImplCopyWith<_$DUIInputFieldImpl> get copyWith =>
      __$$DUIInputFieldImplCopyWithImpl<_$DUIInputFieldImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUIInputField(id, label);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUIInputField?.call(id, label);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIInputField != null) {
      return DUIInputField(id, label);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUIInputField(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUIInputField?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIInputField != null) {
      return DUIInputField(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUIInputFieldImplToJson(this);
  }
}

abstract class DUIInputField implements DUIType, DUIInputType {
  const factory DUIInputField({
    required final String id,
    required final String label,
  }) = _$DUIInputFieldImpl;

  factory DUIInputField.fromJson(Map<String, dynamic> json) =
      _$DUIInputFieldImpl.fromJson;

  String get id;
  String get label;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUIInputFieldImplCopyWith<_$DUIInputFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUISecureInputFieldImplCopyWith<$Res> {
  factory _$$DUISecureInputFieldImplCopyWith(
    _$DUISecureInputFieldImpl value,
    $Res Function(_$DUISecureInputFieldImpl) then,
  ) = __$$DUISecureInputFieldImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String label});
}

/// @nodoc
class __$$DUISecureInputFieldImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUISecureInputFieldImpl>
    implements _$$DUISecureInputFieldImplCopyWith<$Res> {
  __$$DUISecureInputFieldImplCopyWithImpl(
    _$DUISecureInputFieldImpl _value,
    $Res Function(_$DUISecureInputFieldImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? label = null}) {
    return _then(
      _$DUISecureInputFieldImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUISecureInputFieldImpl implements DUISecureInputField {
  const _$DUISecureInputFieldImpl({
    required this.id,
    required this.label,
    final String? $type,
  }) : $type = $type ?? 'DUISecureInputField';

  factory _$DUISecureInputFieldImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUISecureInputFieldImplFromJson(json);

  @override
  final String id;
  @override
  final String label;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUISecureInputField(id: $id, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUISecureInputFieldImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUISecureInputFieldImplCopyWith<_$DUISecureInputFieldImpl> get copyWith =>
      __$$DUISecureInputFieldImplCopyWithImpl<_$DUISecureInputFieldImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUISecureInputField(id, label);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUISecureInputField?.call(id, label);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUISecureInputField != null) {
      return DUISecureInputField(id, label);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUISecureInputField(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUISecureInputField?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUISecureInputField != null) {
      return DUISecureInputField(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUISecureInputFieldImplToJson(this);
  }
}

abstract class DUISecureInputField implements DUIType, DUIInputType {
  const factory DUISecureInputField({
    required final String id,
    required final String label,
  }) = _$DUISecureInputFieldImpl;

  factory DUISecureInputField.fromJson(Map<String, dynamic> json) =
      _$DUISecureInputFieldImpl.fromJson;

  String get id;
  String get label;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUISecureInputFieldImplCopyWith<_$DUISecureInputFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUIStepperImplCopyWith<$Res> {
  factory _$$DUIStepperImplCopyWith(
    _$DUIStepperImpl value,
    $Res Function(_$DUIStepperImpl) then,
  ) = __$$DUIStepperImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String label, num? min, num? max, num? step});
}

/// @nodoc
class __$$DUIStepperImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUIStepperImpl>
    implements _$$DUIStepperImplCopyWith<$Res> {
  __$$DUIStepperImplCopyWithImpl(
    _$DUIStepperImpl _value,
    $Res Function(_$DUIStepperImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? min = freezed,
    Object? max = freezed,
    Object? step = freezed,
  }) {
    return _then(
      _$DUIStepperImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
        min:
            freezed == min
                ? _value.min
                : min // ignore: cast_nullable_to_non_nullable
                    as num?,
        max:
            freezed == max
                ? _value.max
                : max // ignore: cast_nullable_to_non_nullable
                    as num?,
        step:
            freezed == step
                ? _value.step
                : step // ignore: cast_nullable_to_non_nullable
                    as num?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUIStepperImpl implements DUIStepper {
  const _$DUIStepperImpl({
    required this.id,
    required this.label,
    this.min,
    this.max,
    this.step,
    final String? $type,
  }) : $type = $type ?? 'DUIStepper';

  factory _$DUIStepperImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUIStepperImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final num? min;
  @override
  final num? max;
  @override
  final num? step;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUIStepper(id: $id, label: $label, min: $min, max: $max, step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUIStepperImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.step, step) || other.step == step));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, min, max, step);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUIStepperImplCopyWith<_$DUIStepperImpl> get copyWith =>
      __$$DUIStepperImplCopyWithImpl<_$DUIStepperImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUIStepper(id, label, min, max, step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUIStepper?.call(id, label, min, max, step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIStepper != null) {
      return DUIStepper(id, label, min, max, step);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUIStepper(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUIStepper?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIStepper != null) {
      return DUIStepper(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUIStepperImplToJson(this);
  }
}

abstract class DUIStepper implements DUIType, DUIFormRow {
  const factory DUIStepper({
    required final String id,
    required final String label,
    final num? min,
    final num? max,
    final num? step,
  }) = _$DUIStepperImpl;

  factory DUIStepper.fromJson(Map<String, dynamic> json) =
      _$DUIStepperImpl.fromJson;

  String get id;
  String get label;
  num? get min;
  num? get max;
  num? get step;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUIStepperImplCopyWith<_$DUIStepperImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUILabelImplCopyWith<$Res> {
  factory _$$DUILabelImplCopyWith(
    _$DUILabelImpl value,
    $Res Function(_$DUILabelImpl) then,
  ) = __$$DUILabelImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String label, String? value});
}

/// @nodoc
class __$$DUILabelImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUILabelImpl>
    implements _$$DUILabelImplCopyWith<$Res> {
  __$$DUILabelImplCopyWithImpl(
    _$DUILabelImpl _value,
    $Res Function(_$DUILabelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? value = freezed,
  }) {
    return _then(
      _$DUILabelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
        value:
            freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUILabelImpl implements DUILabel {
  const _$DUILabelImpl({
    required this.id,
    required this.label,
    this.value,
    final String? $type,
  }) : $type = $type ?? 'DUILabel';

  factory _$DUILabelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUILabelImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String? value;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUILabel(id: $id, label: $label, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUILabelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, value);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUILabelImplCopyWith<_$DUILabelImpl> get copyWith =>
      __$$DUILabelImplCopyWithImpl<_$DUILabelImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUILabel(id, label, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUILabel?.call(id, label, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUILabel != null) {
      return DUILabel(id, label, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUILabel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUILabel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUILabel != null) {
      return DUILabel(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUILabelImplToJson(this);
  }
}

abstract class DUILabel implements DUIType, DUILabelType {
  const factory DUILabel({
    required final String id,
    required final String label,
    final String? value,
  }) = _$DUILabelImpl;

  factory DUILabel.fromJson(Map<String, dynamic> json) =
      _$DUILabelImpl.fromJson;

  String get id;
  String get label;
  String? get value;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUILabelImplCopyWith<_$DUILabelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUIMultilineLabelImplCopyWith<$Res> {
  factory _$$DUIMultilineLabelImplCopyWith(
    _$DUIMultilineLabelImpl value,
    $Res Function(_$DUIMultilineLabelImpl) then,
  ) = __$$DUIMultilineLabelImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String label, String value});
}

/// @nodoc
class __$$DUIMultilineLabelImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUIMultilineLabelImpl>
    implements _$$DUIMultilineLabelImplCopyWith<$Res> {
  __$$DUIMultilineLabelImplCopyWithImpl(
    _$DUIMultilineLabelImpl _value,
    $Res Function(_$DUIMultilineLabelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? label = null, Object? value = null}) {
    return _then(
      _$DUIMultilineLabelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
        value:
            null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUIMultilineLabelImpl implements DUIMultilineLabel {
  const _$DUIMultilineLabelImpl({
    required this.id,
    required this.label,
    required this.value,
    final String? $type,
  }) : $type = $type ?? 'DUIMultilineLabel';

  factory _$DUIMultilineLabelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUIMultilineLabelImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String value;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUIMultilineLabel(id: $id, label: $label, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUIMultilineLabelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, value);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUIMultilineLabelImplCopyWith<_$DUIMultilineLabelImpl> get copyWith =>
      __$$DUIMultilineLabelImplCopyWithImpl<_$DUIMultilineLabelImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUIMultilineLabel(id, label, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUIMultilineLabel?.call(id, label, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIMultilineLabel != null) {
      return DUIMultilineLabel(id, label, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUIMultilineLabel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUIMultilineLabel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIMultilineLabel != null) {
      return DUIMultilineLabel(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUIMultilineLabelImplToJson(this);
  }
}

abstract class DUIMultilineLabel implements DUIType, DUILabelType {
  const factory DUIMultilineLabel({
    required final String id,
    required final String label,
    required final String value,
  }) = _$DUIMultilineLabelImpl;

  factory DUIMultilineLabel.fromJson(Map<String, dynamic> json) =
      _$DUIMultilineLabelImpl.fromJson;

  String get id;
  String get label;
  String get value;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUIMultilineLabelImplCopyWith<_$DUIMultilineLabelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUIHeaderImplCopyWith<$Res> {
  factory _$$DUIHeaderImplCopyWith(
    _$DUIHeaderImpl value,
    $Res Function(_$DUIHeaderImpl) then,
  ) = __$$DUIHeaderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String imageUrl, String title, String? subtitle});
}

/// @nodoc
class __$$DUIHeaderImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUIHeaderImpl>
    implements _$$DUIHeaderImplCopyWith<$Res> {
  __$$DUIHeaderImplCopyWithImpl(
    _$DUIHeaderImpl _value,
    $Res Function(_$DUIHeaderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? title = null,
    Object? subtitle = freezed,
  }) {
    return _then(
      _$DUIHeaderImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        imageUrl:
            null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        subtitle:
            freezed == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUIHeaderImpl implements DUIHeader {
  const _$DUIHeaderImpl({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.subtitle,
    final String? $type,
  }) : $type = $type ?? 'DUIHeader';

  factory _$DUIHeaderImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUIHeaderImplFromJson(json);

  @override
  final String id;
  @override
  final String imageUrl;
  @override
  final String title;
  @override
  final String? subtitle;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUIHeader(id: $id, imageUrl: $imageUrl, title: $title, subtitle: $subtitle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUIHeaderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, imageUrl, title, subtitle);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUIHeaderImplCopyWith<_$DUIHeaderImpl> get copyWith =>
      __$$DUIHeaderImplCopyWithImpl<_$DUIHeaderImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUIHeader(id, imageUrl, title, subtitle);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUIHeader?.call(id, imageUrl, title, subtitle);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIHeader != null) {
      return DUIHeader(id, imageUrl, title, subtitle);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUIHeader(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUIHeader?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIHeader != null) {
      return DUIHeader(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUIHeaderImplToJson(this);
  }
}

abstract class DUIHeader implements DUIType, DUIFormRow {
  const factory DUIHeader({
    required final String id,
    required final String imageUrl,
    required final String title,
    final String? subtitle,
  }) = _$DUIHeaderImpl;

  factory DUIHeader.fromJson(Map<String, dynamic> json) =
      _$DUIHeaderImpl.fromJson;

  String get id;
  String get imageUrl;
  String get title;
  String? get subtitle;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUIHeaderImplCopyWith<_$DUIHeaderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUIButtonImplCopyWith<$Res> {
  factory _$$DUIButtonImplCopyWith(
    _$DUIButtonImpl value,
    $Res Function(_$DUIButtonImpl) then,
  ) = __$$DUIButtonImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String label});
}

/// @nodoc
class __$$DUIButtonImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUIButtonImpl>
    implements _$$DUIButtonImplCopyWith<$Res> {
  __$$DUIButtonImplCopyWithImpl(
    _$DUIButtonImpl _value,
    $Res Function(_$DUIButtonImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? label = null}) {
    return _then(
      _$DUIButtonImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUIButtonImpl implements DUIButton {
  const _$DUIButtonImpl({
    required this.id,
    required this.label,
    final String? $type,
  }) : $type = $type ?? 'DUIButton';

  factory _$DUIButtonImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUIButtonImplFromJson(json);

  @override
  final String id;
  @override
  final String label;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUIButton(id: $id, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUIButtonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUIButtonImplCopyWith<_$DUIButtonImpl> get copyWith =>
      __$$DUIButtonImplCopyWithImpl<_$DUIButtonImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUIButton(id, label);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUIButton?.call(id, label);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIButton != null) {
      return DUIButton(id, label);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUIButton(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUIButton?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIButton != null) {
      return DUIButton(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUIButtonImplToJson(this);
  }
}

abstract class DUIButton implements DUIType, DUIFormRow {
  const factory DUIButton({
    required final String id,
    required final String label,
  }) = _$DUIButtonImpl;

  factory DUIButton.fromJson(Map<String, dynamic> json) =
      _$DUIButtonImpl.fromJson;

  String get id;
  String get label;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUIButtonImplCopyWith<_$DUIButtonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUINavigationButtonImplCopyWith<$Res> {
  factory _$$DUINavigationButtonImplCopyWith(
    _$DUINavigationButtonImpl value,
    $Res Function(_$DUINavigationButtonImpl) then,
  ) = __$$DUINavigationButtonImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String label, DUIForm form});
}

/// @nodoc
class __$$DUINavigationButtonImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUINavigationButtonImpl>
    implements _$$DUINavigationButtonImplCopyWith<$Res> {
  __$$DUINavigationButtonImplCopyWithImpl(
    _$DUINavigationButtonImpl _value,
    $Res Function(_$DUINavigationButtonImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? label = null, Object? form = freezed}) {
    return _then(
      _$DUINavigationButtonImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
        form:
            freezed == form
                ? _value.form
                : form // ignore: cast_nullable_to_non_nullable
                    as DUIForm,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUINavigationButtonImpl implements DUINavigationButton {
  const _$DUINavigationButtonImpl({
    required this.id,
    required this.label,
    required this.form,
    final String? $type,
  }) : $type = $type ?? 'DUINavigationButton';

  factory _$DUINavigationButtonImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUINavigationButtonImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final DUIForm form;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUINavigationButton(id: $id, label: $label, form: $form)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUINavigationButtonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality().equals(other.form, form));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    label,
    const DeepCollectionEquality().hash(form),
  );

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUINavigationButtonImplCopyWith<_$DUINavigationButtonImpl> get copyWith =>
      __$$DUINavigationButtonImplCopyWithImpl<_$DUINavigationButtonImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUINavigationButton(id, label, form);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUINavigationButton?.call(id, label, form);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUINavigationButton != null) {
      return DUINavigationButton(id, label, form);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUINavigationButton(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUINavigationButton?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUINavigationButton != null) {
      return DUINavigationButton(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUINavigationButtonImplToJson(this);
  }
}

abstract class DUINavigationButton implements DUIType, DUIFormRow {
  const factory DUINavigationButton({
    required final String id,
    required final String label,
    required final DUIForm form,
  }) = _$DUINavigationButtonImpl;

  factory DUINavigationButton.fromJson(Map<String, dynamic> json) =
      _$DUINavigationButtonImpl.fromJson;

  String get id;
  String get label;
  DUIForm get form;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUINavigationButtonImplCopyWith<_$DUINavigationButtonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUISwitchImplCopyWith<$Res> {
  factory _$$DUISwitchImplCopyWith(
    _$DUISwitchImpl value,
    $Res Function(_$DUISwitchImpl) then,
  ) = __$$DUISwitchImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String label});
}

/// @nodoc
class __$$DUISwitchImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUISwitchImpl>
    implements _$$DUISwitchImplCopyWith<$Res> {
  __$$DUISwitchImplCopyWithImpl(
    _$DUISwitchImpl _value,
    $Res Function(_$DUISwitchImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? label = null}) {
    return _then(
      _$DUISwitchImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUISwitchImpl implements DUISwitch {
  const _$DUISwitchImpl({
    required this.id,
    required this.label,
    final String? $type,
  }) : $type = $type ?? 'DUISwitch';

  factory _$DUISwitchImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUISwitchImplFromJson(json);

  @override
  final String id;
  @override
  final String label;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUISwitch(id: $id, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUISwitchImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUISwitchImplCopyWith<_$DUISwitchImpl> get copyWith =>
      __$$DUISwitchImplCopyWithImpl<_$DUISwitchImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUISwitch(id, label);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUISwitch?.call(id, label);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUISwitch != null) {
      return DUISwitch(id, label);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUISwitch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUISwitch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUISwitch != null) {
      return DUISwitch(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUISwitchImplToJson(this);
  }
}

abstract class DUISwitch implements DUIType, DUIFormRow {
  const factory DUISwitch({
    required final String id,
    required final String label,
  }) = _$DUISwitchImpl;

  factory DUISwitch.fromJson(Map<String, dynamic> json) =
      _$DUISwitchImpl.fromJson;

  String get id;
  String get label;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUISwitchImplCopyWith<_$DUISwitchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUIOAuthButtonImplCopyWith<$Res> {
  factory _$$DUIOAuthButtonImplCopyWith(
    _$DUIOAuthButtonImpl value,
    $Res Function(_$DUIOAuthButtonImpl) then,
  ) = __$$DUIOAuthButtonImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String id,
    String label,
    String authorizeEndpoint,
    String clientId,
    DUIOAuthResponseType responseType,
    String? redirectUri,
    List<String>? scopes,
  });

  $DUIOAuthResponseTypeCopyWith<$Res> get responseType;
}

/// @nodoc
class __$$DUIOAuthButtonImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUIOAuthButtonImpl>
    implements _$$DUIOAuthButtonImplCopyWith<$Res> {
  __$$DUIOAuthButtonImplCopyWithImpl(
    _$DUIOAuthButtonImpl _value,
    $Res Function(_$DUIOAuthButtonImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? authorizeEndpoint = null,
    Object? clientId = null,
    Object? responseType = null,
    Object? redirectUri = freezed,
    Object? scopes = freezed,
  }) {
    return _then(
      _$DUIOAuthButtonImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
        authorizeEndpoint:
            null == authorizeEndpoint
                ? _value.authorizeEndpoint
                : authorizeEndpoint // ignore: cast_nullable_to_non_nullable
                    as String,
        clientId:
            null == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                    as String,
        responseType:
            null == responseType
                ? _value.responseType
                : responseType // ignore: cast_nullable_to_non_nullable
                    as DUIOAuthResponseType,
        redirectUri:
            freezed == redirectUri
                ? _value.redirectUri
                : redirectUri // ignore: cast_nullable_to_non_nullable
                    as String?,
        scopes:
            freezed == scopes
                ? _value._scopes
                : scopes // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
      ),
    );
  }

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DUIOAuthResponseTypeCopyWith<$Res> get responseType {
    return $DUIOAuthResponseTypeCopyWith<$Res>(_value.responseType, (value) {
      return _then(_value.copyWith(responseType: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$DUIOAuthButtonImpl implements DUIOAuthButton {
  const _$DUIOAuthButtonImpl({
    required this.id,
    required this.label,
    required this.authorizeEndpoint,
    required this.clientId,
    required this.responseType,
    this.redirectUri,
    final List<String>? scopes,
    final String? $type,
  }) : _scopes = scopes,
       $type = $type ?? 'DUIOAuthButton';

  factory _$DUIOAuthButtonImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUIOAuthButtonImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String authorizeEndpoint;
  @override
  final String clientId;
  @override
  final DUIOAuthResponseType responseType;
  @override
  final String? redirectUri;
  final List<String>? _scopes;
  @override
  List<String>? get scopes {
    final value = _scopes;
    if (value == null) return null;
    if (_scopes is EqualUnmodifiableListView) return _scopes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUIOAuthButton(id: $id, label: $label, authorizeEndpoint: $authorizeEndpoint, clientId: $clientId, responseType: $responseType, redirectUri: $redirectUri, scopes: $scopes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUIOAuthButtonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.authorizeEndpoint, authorizeEndpoint) ||
                other.authorizeEndpoint == authorizeEndpoint) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.responseType, responseType) ||
                other.responseType == responseType) &&
            (identical(other.redirectUri, redirectUri) ||
                other.redirectUri == redirectUri) &&
            const DeepCollectionEquality().equals(other._scopes, _scopes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    label,
    authorizeEndpoint,
    clientId,
    responseType,
    redirectUri,
    const DeepCollectionEquality().hash(_scopes),
  );

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUIOAuthButtonImplCopyWith<_$DUIOAuthButtonImpl> get copyWith =>
      __$$DUIOAuthButtonImplCopyWithImpl<_$DUIOAuthButtonImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUIOAuthButton(
      id,
      label,
      authorizeEndpoint,
      clientId,
      responseType,
      redirectUri,
      scopes,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUIOAuthButton?.call(
      id,
      label,
      authorizeEndpoint,
      clientId,
      responseType,
      redirectUri,
      scopes,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIOAuthButton != null) {
      return DUIOAuthButton(
        id,
        label,
        authorizeEndpoint,
        clientId,
        responseType,
        redirectUri,
        scopes,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUIOAuthButton(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUIOAuthButton?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIOAuthButton != null) {
      return DUIOAuthButton(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUIOAuthButtonImplToJson(this);
  }
}

abstract class DUIOAuthButton implements DUIType, DUIFormRow {
  const factory DUIOAuthButton({
    required final String id,
    required final String label,
    required final String authorizeEndpoint,
    required final String clientId,
    required final DUIOAuthResponseType responseType,
    final String? redirectUri,
    final List<String>? scopes,
  }) = _$DUIOAuthButtonImpl;

  factory DUIOAuthButton.fromJson(Map<String, dynamic> json) =
      _$DUIOAuthButtonImpl.fromJson;

  String get id;
  String get label;
  String get authorizeEndpoint;
  String get clientId;
  DUIOAuthResponseType get responseType;
  String? get redirectUri;
  List<String>? get scopes;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUIOAuthButtonImplCopyWith<_$DUIOAuthButtonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DUIFormImplCopyWith<$Res> {
  factory _$$DUIFormImplCopyWith(
    _$DUIFormImpl value,
    $Res Function(_$DUIFormImpl) then,
  ) = __$$DUIFormImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<DUISection> sections, bool hasSubmit});
}

/// @nodoc
class __$$DUIFormImplCopyWithImpl<$Res>
    extends _$DUITypeCopyWithImpl<$Res, _$DUIFormImpl>
    implements _$$DUIFormImplCopyWith<$Res> {
  __$$DUIFormImplCopyWithImpl(
    _$DUIFormImpl _value,
    $Res Function(_$DUIFormImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sections = null, Object? hasSubmit = null}) {
    return _then(
      _$DUIFormImpl(
        sections:
            null == sections
                ? _value._sections
                : sections // ignore: cast_nullable_to_non_nullable
                    as List<DUISection>,
        hasSubmit:
            null == hasSubmit
                ? _value.hasSubmit
                : hasSubmit // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DUIFormImpl implements DUIForm {
  const _$DUIFormImpl({
    required final List<DUISection> sections,
    required this.hasSubmit,
    final String? $type,
  }) : _sections = sections,
       $type = $type ?? 'DUIForm';

  factory _$DUIFormImpl.fromJson(Map<String, dynamic> json) =>
      _$$DUIFormImplFromJson(json);

  final List<DUISection> _sections;
  @override
  List<DUISection> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  final bool hasSubmit;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DUIType.DUIForm(sections: $sections, hasSubmit: $hasSubmit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DUIFormImpl &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            (identical(other.hasSubmit, hasSubmit) ||
                other.hasSubmit == hasSubmit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_sections),
    hasSubmit,
  );

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DUIFormImplCopyWith<_$DUIFormImpl> get copyWith =>
      __$$DUIFormImplCopyWithImpl<_$DUIFormImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )
    DUISection,
    required TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )
    DUISelect,
    required TResult Function(String id, String label) DUIInputField,
    required TResult Function(String id, String label) DUISecureInputField,
    required TResult Function(
      String id,
      String label,
      num? min,
      num? max,
      num? step,
    )
    DUIStepper,
    required TResult Function(String id, String label, String? value) DUILabel,
    required TResult Function(String id, String label, String value)
    DUIMultilineLabel,
    required TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )
    DUIHeader,
    required TResult Function(String id, String label) DUIButton,
    required TResult Function(String id, String label, DUIForm form)
    DUINavigationButton,
    required TResult Function(String id, String label) DUISwitch,
    required TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )
    DUIOAuthButton,
    required TResult Function(List<DUISection> sections, bool hasSubmit)
    DUIForm,
  }) {
    return DUIForm(sections, hasSubmit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult? Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult? Function(String id, String label)? DUIInputField,
    TResult? Function(String id, String label)? DUISecureInputField,
    TResult? Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult? Function(String id, String label, String? value)? DUILabel,
    TResult? Function(String id, String label, String value)? DUIMultilineLabel,
    TResult? Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult? Function(String id, String label)? DUIButton,
    TResult? Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult? Function(String id, String label)? DUISwitch,
    TResult? Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult? Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
  }) {
    return DUIForm?.call(sections, hasSubmit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String id,
      String? header,
      String? footer,
      bool isHidden,
      List<DUIType> rows,
    )?
    DUISection,
    TResult Function(
      String id,
      String label,
      List<String> options,
      bool allowsMultiselect,
      Map<String, String> labels,
    )?
    DUISelect,
    TResult Function(String id, String label)? DUIInputField,
    TResult Function(String id, String label)? DUISecureInputField,
    TResult Function(String id, String label, num? min, num? max, num? step)?
    DUIStepper,
    TResult Function(String id, String label, String? value)? DUILabel,
    TResult Function(String id, String label, String value)? DUIMultilineLabel,
    TResult Function(
      String id,
      String imageUrl,
      String title,
      String? subtitle,
    )?
    DUIHeader,
    TResult Function(String id, String label)? DUIButton,
    TResult Function(String id, String label, DUIForm form)?
    DUINavigationButton,
    TResult Function(String id, String label)? DUISwitch,
    TResult Function(
      String id,
      String label,
      String authorizeEndpoint,
      String clientId,
      DUIOAuthResponseType responseType,
      String? redirectUri,
      List<String>? scopes,
    )?
    DUIOAuthButton,
    TResult Function(List<DUISection> sections, bool hasSubmit)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIForm != null) {
      return DUIForm(sections, hasSubmit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DUISection value) DUISection,
    required TResult Function(DUISelect value) DUISelect,
    required TResult Function(DUIInputField value) DUIInputField,
    required TResult Function(DUISecureInputField value) DUISecureInputField,
    required TResult Function(DUIStepper value) DUIStepper,
    required TResult Function(DUILabel value) DUILabel,
    required TResult Function(DUIMultilineLabel value) DUIMultilineLabel,
    required TResult Function(DUIHeader value) DUIHeader,
    required TResult Function(DUIButton value) DUIButton,
    required TResult Function(DUINavigationButton value) DUINavigationButton,
    required TResult Function(DUISwitch value) DUISwitch,
    required TResult Function(DUIOAuthButton value) DUIOAuthButton,
    required TResult Function(DUIForm value) DUIForm,
  }) {
    return DUIForm(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DUISection value)? DUISection,
    TResult? Function(DUISelect value)? DUISelect,
    TResult? Function(DUIInputField value)? DUIInputField,
    TResult? Function(DUISecureInputField value)? DUISecureInputField,
    TResult? Function(DUIStepper value)? DUIStepper,
    TResult? Function(DUILabel value)? DUILabel,
    TResult? Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult? Function(DUIHeader value)? DUIHeader,
    TResult? Function(DUIButton value)? DUIButton,
    TResult? Function(DUINavigationButton value)? DUINavigationButton,
    TResult? Function(DUISwitch value)? DUISwitch,
    TResult? Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult? Function(DUIForm value)? DUIForm,
  }) {
    return DUIForm?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DUISection value)? DUISection,
    TResult Function(DUISelect value)? DUISelect,
    TResult Function(DUIInputField value)? DUIInputField,
    TResult Function(DUISecureInputField value)? DUISecureInputField,
    TResult Function(DUIStepper value)? DUIStepper,
    TResult Function(DUILabel value)? DUILabel,
    TResult Function(DUIMultilineLabel value)? DUIMultilineLabel,
    TResult Function(DUIHeader value)? DUIHeader,
    TResult Function(DUIButton value)? DUIButton,
    TResult Function(DUINavigationButton value)? DUINavigationButton,
    TResult Function(DUISwitch value)? DUISwitch,
    TResult Function(DUIOAuthButton value)? DUIOAuthButton,
    TResult Function(DUIForm value)? DUIForm,
    required TResult orElse(),
  }) {
    if (DUIForm != null) {
      return DUIForm(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DUIFormImplToJson(this);
  }
}

abstract class DUIForm implements DUIType {
  const factory DUIForm({
    required final List<DUISection> sections,
    required final bool hasSubmit,
  }) = _$DUIFormImpl;

  factory DUIForm.fromJson(Map<String, dynamic> json) = _$DUIFormImpl.fromJson;

  List<DUISection> get sections;
  bool get hasSubmit;

  /// Create a copy of DUIType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DUIFormImplCopyWith<_$DUIFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
