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
mixin _$ProxyInfo {
  String get proxy => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String? get chapter => throw _privateConstructorUsedError;

  /// Create a copy of ProxyInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProxyInfoCopyWith<ProxyInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProxyInfoCopyWith<$Res> {
  factory $ProxyInfoCopyWith(ProxyInfo value, $Res Function(ProxyInfo) then) =
      _$ProxyInfoCopyWithImpl<$Res, ProxyInfo>;
  @useResult
  $Res call({String proxy, String code, String? chapter});
}

/// @nodoc
class _$ProxyInfoCopyWithImpl<$Res, $Val extends ProxyInfo>
    implements $ProxyInfoCopyWith<$Res> {
  _$ProxyInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProxyInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? proxy = null,
    Object? code = null,
    Object? chapter = freezed,
  }) {
    return _then(_value.copyWith(
      proxy: null == proxy
          ? _value.proxy
          : proxy // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      chapter: freezed == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProxyInfoImplCopyWith<$Res>
    implements $ProxyInfoCopyWith<$Res> {
  factory _$$ProxyInfoImplCopyWith(
          _$ProxyInfoImpl value, $Res Function(_$ProxyInfoImpl) then) =
      __$$ProxyInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String proxy, String code, String? chapter});
}

/// @nodoc
class __$$ProxyInfoImplCopyWithImpl<$Res>
    extends _$ProxyInfoCopyWithImpl<$Res, _$ProxyInfoImpl>
    implements _$$ProxyInfoImplCopyWith<$Res> {
  __$$ProxyInfoImplCopyWithImpl(
      _$ProxyInfoImpl _value, $Res Function(_$ProxyInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProxyInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? proxy = null,
    Object? code = null,
    Object? chapter = freezed,
  }) {
    return _then(_$ProxyInfoImpl(
      proxy: null == proxy
          ? _value.proxy
          : proxy // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      chapter: freezed == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ProxyInfoImpl extends _ProxyInfo {
  const _$ProxyInfoImpl({required this.proxy, required this.code, this.chapter})
      : super._();

  @override
  final String proxy;
  @override
  final String code;
  @override
  final String? chapter;

  @override
  String toString() {
    return 'ProxyInfo(proxy: $proxy, code: $code, chapter: $chapter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProxyInfoImpl &&
            (identical(other.proxy, proxy) || other.proxy == proxy) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.chapter, chapter) || other.chapter == chapter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, proxy, code, chapter);

  /// Create a copy of ProxyInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProxyInfoImplCopyWith<_$ProxyInfoImpl> get copyWith =>
      __$$ProxyInfoImplCopyWithImpl<_$ProxyInfoImpl>(this, _$identity);
}

abstract class _ProxyInfo extends ProxyInfo {
  const factory _ProxyInfo(
      {required final String proxy,
      required final String code,
      final String? chapter}) = _$ProxyInfoImpl;
  const _ProxyInfo._() : super._();

  @override
  String get proxy;
  @override
  String get code;
  @override
  String? get chapter;

  /// Create a copy of ProxyInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProxyInfoImplCopyWith<_$ProxyInfoImpl> get copyWith =>
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

TagParser _$TagParserFromJson(Map<String, dynamic> json) {
  return _TagParser.fromJson(json);
}

/// @nodoc
mixin _$TagParser {
  String get pattern => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get format => throw _privateConstructorUsedError;

  /// Serializes this TagParser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TagParser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TagParserCopyWith<TagParser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagParserCopyWith<$Res> {
  factory $TagParserCopyWith(TagParser value, $Res Function(TagParser) then) =
      _$TagParserCopyWithImpl<$Res, TagParser>;
  @useResult
  $Res call({String pattern, String? content, String? format});
}

/// @nodoc
class _$TagParserCopyWithImpl<$Res, $Val extends TagParser>
    implements $TagParserCopyWith<$Res> {
  _$TagParserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TagParser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pattern = null,
    Object? content = freezed,
    Object? format = freezed,
  }) {
    return _then(_value.copyWith(
      pattern: null == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagParserImplCopyWith<$Res>
    implements $TagParserCopyWith<$Res> {
  factory _$$TagParserImplCopyWith(
          _$TagParserImpl value, $Res Function(_$TagParserImpl) then) =
      __$$TagParserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pattern, String? content, String? format});
}

/// @nodoc
class __$$TagParserImplCopyWithImpl<$Res>
    extends _$TagParserCopyWithImpl<$Res, _$TagParserImpl>
    implements _$$TagParserImplCopyWith<$Res> {
  __$$TagParserImplCopyWithImpl(
      _$TagParserImpl _value, $Res Function(_$TagParserImpl) _then)
      : super(_value, _then);

  /// Create a copy of TagParser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pattern = null,
    Object? content = freezed,
    Object? format = freezed,
  }) {
    return _then(_$TagParserImpl(
      pattern: null == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TagParserImpl extends _TagParser {
  const _$TagParserImpl({required this.pattern, this.content, this.format})
      : super._();

  factory _$TagParserImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagParserImplFromJson(json);

  @override
  final String pattern;
  @override
  final String? content;
  @override
  final String? format;

  @override
  String toString() {
    return 'TagParser(pattern: $pattern, content: $content, format: $format)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagParserImpl &&
            (identical(other.pattern, pattern) || other.pattern == pattern) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.format, format) || other.format == format));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pattern, content, format);

  /// Create a copy of TagParser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagParserImplCopyWith<_$TagParserImpl> get copyWith =>
      __$$TagParserImplCopyWithImpl<_$TagParserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagParserImplToJson(
      this,
    );
  }
}

abstract class _TagParser extends TagParser {
  const factory _TagParser(
      {required final String pattern,
      final String? content,
      final String? format}) = _$TagParserImpl;
  const _TagParser._() : super._();

  factory _TagParser.fromJson(Map<String, dynamic> json) =
      _$TagParserImpl.fromJson;

  @override
  String get pattern;
  @override
  String? get content;
  @override
  String? get format;

  /// Create a copy of TagParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagParserImplCopyWith<_$TagParserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WebSource _$WebSourceFromJson(Map<String, dynamic> json) {
  return _WebSource.fromJson(json);
}

/// @nodoc
mixin _$WebSource {
  String get name => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  WebSourceParseType get type => throw _privateConstructorUsedError;
  String get baseUrl => throw _privateConstructorUsedError;
  WebSourceSearchParser get search => throw _privateConstructorUsedError;
  WebSourceMangaParser? get manga => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;

  /// Serializes this WebSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebSourceCopyWith<WebSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSourceCopyWith<$Res> {
  factory $WebSourceCopyWith(WebSource value, $Res Function(WebSource) then) =
      _$WebSourceCopyWithImpl<$Res, WebSource>;
  @useResult
  $Res call(
      {String name,
      String version,
      WebSourceParseType type,
      String baseUrl,
      WebSourceSearchParser search,
      WebSourceMangaParser? manga,
      String slug});

  $WebSourceSearchParserCopyWith<$Res> get search;
  $WebSourceMangaParserCopyWith<$Res>? get manga;
}

/// @nodoc
class _$WebSourceCopyWithImpl<$Res, $Val extends WebSource>
    implements $WebSourceCopyWith<$Res> {
  _$WebSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? version = null,
    Object? type = null,
    Object? baseUrl = null,
    Object? search = null,
    Object? manga = freezed,
    Object? slug = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WebSourceParseType,
      baseUrl: null == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as WebSourceSearchParser,
      manga: freezed == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as WebSourceMangaParser?,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of WebSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WebSourceSearchParserCopyWith<$Res> get search {
    return $WebSourceSearchParserCopyWith<$Res>(_value.search, (value) {
      return _then(_value.copyWith(search: value) as $Val);
    });
  }

  /// Create a copy of WebSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WebSourceMangaParserCopyWith<$Res>? get manga {
    if (_value.manga == null) {
      return null;
    }

    return $WebSourceMangaParserCopyWith<$Res>(_value.manga!, (value) {
      return _then(_value.copyWith(manga: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WebSourceImplCopyWith<$Res>
    implements $WebSourceCopyWith<$Res> {
  factory _$$WebSourceImplCopyWith(
          _$WebSourceImpl value, $Res Function(_$WebSourceImpl) then) =
      __$$WebSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String version,
      WebSourceParseType type,
      String baseUrl,
      WebSourceSearchParser search,
      WebSourceMangaParser? manga,
      String slug});

  @override
  $WebSourceSearchParserCopyWith<$Res> get search;
  @override
  $WebSourceMangaParserCopyWith<$Res>? get manga;
}

/// @nodoc
class __$$WebSourceImplCopyWithImpl<$Res>
    extends _$WebSourceCopyWithImpl<$Res, _$WebSourceImpl>
    implements _$$WebSourceImplCopyWith<$Res> {
  __$$WebSourceImplCopyWithImpl(
      _$WebSourceImpl _value, $Res Function(_$WebSourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? version = null,
    Object? type = null,
    Object? baseUrl = null,
    Object? search = null,
    Object? manga = freezed,
    Object? slug = null,
  }) {
    return _then(_$WebSourceImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WebSourceParseType,
      baseUrl: null == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as WebSourceSearchParser,
      manga: freezed == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as WebSourceMangaParser?,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSourceImpl extends _WebSource {
  const _$WebSourceImpl(
      {required this.name,
      required this.version,
      required this.type,
      required this.baseUrl,
      required this.search,
      this.manga,
      required this.slug})
      : super._();

  factory _$WebSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSourceImplFromJson(json);

  @override
  final String name;
  @override
  final String version;
  @override
  final WebSourceParseType type;
  @override
  final String baseUrl;
  @override
  final WebSourceSearchParser search;
  @override
  final WebSourceMangaParser? manga;
  @override
  final String slug;

  @override
  String toString() {
    return 'WebSource(name: $name, version: $version, type: $type, baseUrl: $baseUrl, search: $search, manga: $manga, slug: $slug)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSourceImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.manga, manga) || other.manga == manga) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, version, type, baseUrl, search, manga, slug);

  /// Create a copy of WebSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSourceImplCopyWith<_$WebSourceImpl> get copyWith =>
      __$$WebSourceImplCopyWithImpl<_$WebSourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSourceImplToJson(
      this,
    );
  }
}

abstract class _WebSource extends WebSource {
  const factory _WebSource(
      {required final String name,
      required final String version,
      required final WebSourceParseType type,
      required final String baseUrl,
      required final WebSourceSearchParser search,
      final WebSourceMangaParser? manga,
      required final String slug}) = _$WebSourceImpl;
  const _WebSource._() : super._();

  factory _WebSource.fromJson(Map<String, dynamic> json) =
      _$WebSourceImpl.fromJson;

  @override
  String get name;
  @override
  String get version;
  @override
  WebSourceParseType get type;
  @override
  String get baseUrl;
  @override
  WebSourceSearchParser get search;
  @override
  WebSourceMangaParser? get manga;
  @override
  String get slug;

  /// Create a copy of WebSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSourceImplCopyWith<_$WebSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WebSourceSearchParser _$WebSourceSearchParserFromJson(
    Map<String, dynamic> json) {
  return _WebSourceSearchParser.fromJson(json);
}

/// @nodoc
mixin _$WebSourceSearchParser {
  String get searchPath => throw _privateConstructorUsedError;
  TagParser get items => throw _privateConstructorUsedError;
  TagParser get url => throw _privateConstructorUsedError;
  TagParser get cover => throw _privateConstructorUsedError;
  TagParser get title => throw _privateConstructorUsedError;
  TagParser? get altTitles => throw _privateConstructorUsedError;
  TagParser? get urlTrim => throw _privateConstructorUsedError;

  /// Serializes this WebSourceSearchParser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebSourceSearchParser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebSourceSearchParserCopyWith<WebSourceSearchParser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSourceSearchParserCopyWith<$Res> {
  factory $WebSourceSearchParserCopyWith(WebSourceSearchParser value,
          $Res Function(WebSourceSearchParser) then) =
      _$WebSourceSearchParserCopyWithImpl<$Res, WebSourceSearchParser>;
  @useResult
  $Res call(
      {String searchPath,
      TagParser items,
      TagParser url,
      TagParser cover,
      TagParser title,
      TagParser? altTitles,
      TagParser? urlTrim});

  $TagParserCopyWith<$Res> get items;
  $TagParserCopyWith<$Res> get url;
  $TagParserCopyWith<$Res> get cover;
  $TagParserCopyWith<$Res> get title;
  $TagParserCopyWith<$Res>? get altTitles;
  $TagParserCopyWith<$Res>? get urlTrim;
}

/// @nodoc
class _$WebSourceSearchParserCopyWithImpl<$Res,
        $Val extends WebSourceSearchParser>
    implements $WebSourceSearchParserCopyWith<$Res> {
  _$WebSourceSearchParserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSourceSearchParser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchPath = null,
    Object? items = null,
    Object? url = null,
    Object? cover = null,
    Object? title = null,
    Object? altTitles = freezed,
    Object? urlTrim = freezed,
  }) {
    return _then(_value.copyWith(
      searchPath: null == searchPath
          ? _value.searchPath
          : searchPath // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as TagParser,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as TagParser,
      cover: null == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as TagParser,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as TagParser,
      altTitles: freezed == altTitles
          ? _value.altTitles
          : altTitles // ignore: cast_nullable_to_non_nullable
              as TagParser?,
      urlTrim: freezed == urlTrim
          ? _value.urlTrim
          : urlTrim // ignore: cast_nullable_to_non_nullable
              as TagParser?,
    ) as $Val);
  }

  /// Create a copy of WebSourceSearchParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get items {
    return $TagParserCopyWith<$Res>(_value.items, (value) {
      return _then(_value.copyWith(items: value) as $Val);
    });
  }

  /// Create a copy of WebSourceSearchParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get url {
    return $TagParserCopyWith<$Res>(_value.url, (value) {
      return _then(_value.copyWith(url: value) as $Val);
    });
  }

  /// Create a copy of WebSourceSearchParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get cover {
    return $TagParserCopyWith<$Res>(_value.cover, (value) {
      return _then(_value.copyWith(cover: value) as $Val);
    });
  }

  /// Create a copy of WebSourceSearchParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get title {
    return $TagParserCopyWith<$Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  /// Create a copy of WebSourceSearchParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res>? get altTitles {
    if (_value.altTitles == null) {
      return null;
    }

    return $TagParserCopyWith<$Res>(_value.altTitles!, (value) {
      return _then(_value.copyWith(altTitles: value) as $Val);
    });
  }

  /// Create a copy of WebSourceSearchParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res>? get urlTrim {
    if (_value.urlTrim == null) {
      return null;
    }

    return $TagParserCopyWith<$Res>(_value.urlTrim!, (value) {
      return _then(_value.copyWith(urlTrim: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WebSourceSearchParserImplCopyWith<$Res>
    implements $WebSourceSearchParserCopyWith<$Res> {
  factory _$$WebSourceSearchParserImplCopyWith(
          _$WebSourceSearchParserImpl value,
          $Res Function(_$WebSourceSearchParserImpl) then) =
      __$$WebSourceSearchParserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String searchPath,
      TagParser items,
      TagParser url,
      TagParser cover,
      TagParser title,
      TagParser? altTitles,
      TagParser? urlTrim});

  @override
  $TagParserCopyWith<$Res> get items;
  @override
  $TagParserCopyWith<$Res> get url;
  @override
  $TagParserCopyWith<$Res> get cover;
  @override
  $TagParserCopyWith<$Res> get title;
  @override
  $TagParserCopyWith<$Res>? get altTitles;
  @override
  $TagParserCopyWith<$Res>? get urlTrim;
}

/// @nodoc
class __$$WebSourceSearchParserImplCopyWithImpl<$Res>
    extends _$WebSourceSearchParserCopyWithImpl<$Res,
        _$WebSourceSearchParserImpl>
    implements _$$WebSourceSearchParserImplCopyWith<$Res> {
  __$$WebSourceSearchParserImplCopyWithImpl(_$WebSourceSearchParserImpl _value,
      $Res Function(_$WebSourceSearchParserImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSourceSearchParser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchPath = null,
    Object? items = null,
    Object? url = null,
    Object? cover = null,
    Object? title = null,
    Object? altTitles = freezed,
    Object? urlTrim = freezed,
  }) {
    return _then(_$WebSourceSearchParserImpl(
      searchPath: null == searchPath
          ? _value.searchPath
          : searchPath // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as TagParser,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as TagParser,
      cover: null == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as TagParser,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as TagParser,
      altTitles: freezed == altTitles
          ? _value.altTitles
          : altTitles // ignore: cast_nullable_to_non_nullable
              as TagParser?,
      urlTrim: freezed == urlTrim
          ? _value.urlTrim
          : urlTrim // ignore: cast_nullable_to_non_nullable
              as TagParser?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSourceSearchParserImpl implements _WebSourceSearchParser {
  const _$WebSourceSearchParserImpl(
      {required this.searchPath,
      required this.items,
      required this.url,
      required this.cover,
      required this.title,
      this.altTitles,
      this.urlTrim});

  factory _$WebSourceSearchParserImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSourceSearchParserImplFromJson(json);

  @override
  final String searchPath;
  @override
  final TagParser items;
  @override
  final TagParser url;
  @override
  final TagParser cover;
  @override
  final TagParser title;
  @override
  final TagParser? altTitles;
  @override
  final TagParser? urlTrim;

  @override
  String toString() {
    return 'WebSourceSearchParser(searchPath: $searchPath, items: $items, url: $url, cover: $cover, title: $title, altTitles: $altTitles, urlTrim: $urlTrim)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSourceSearchParserImpl &&
            (identical(other.searchPath, searchPath) ||
                other.searchPath == searchPath) &&
            (identical(other.items, items) || other.items == items) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.altTitles, altTitles) ||
                other.altTitles == altTitles) &&
            (identical(other.urlTrim, urlTrim) || other.urlTrim == urlTrim));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, searchPath, items, url, cover, title, altTitles, urlTrim);

  /// Create a copy of WebSourceSearchParser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSourceSearchParserImplCopyWith<_$WebSourceSearchParserImpl>
      get copyWith => __$$WebSourceSearchParserImplCopyWithImpl<
          _$WebSourceSearchParserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSourceSearchParserImplToJson(
      this,
    );
  }
}

abstract class _WebSourceSearchParser implements WebSourceSearchParser {
  const factory _WebSourceSearchParser(
      {required final String searchPath,
      required final TagParser items,
      required final TagParser url,
      required final TagParser cover,
      required final TagParser title,
      final TagParser? altTitles,
      final TagParser? urlTrim}) = _$WebSourceSearchParserImpl;

  factory _WebSourceSearchParser.fromJson(Map<String, dynamic> json) =
      _$WebSourceSearchParserImpl.fromJson;

  @override
  String get searchPath;
  @override
  TagParser get items;
  @override
  TagParser get url;
  @override
  TagParser get cover;
  @override
  TagParser get title;
  @override
  TagParser? get altTitles;
  @override
  TagParser? get urlTrim;

  /// Create a copy of WebSourceSearchParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSourceSearchParserImplCopyWith<_$WebSourceSearchParserImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WebSourceMangaParser _$WebSourceMangaParserFromJson(Map<String, dynamic> json) {
  return _WebSourceMangaParser.fromJson(json);
}

/// @nodoc
mixin _$WebSourceMangaParser {
  String get mangaPath => throw _privateConstructorUsedError;
  TagParser get title => throw _privateConstructorUsedError;
  TagParser get description => throw _privateConstructorUsedError;
  TagParser get artist => throw _privateConstructorUsedError;
  TagParser get author => throw _privateConstructorUsedError;
  TagParser get cover => throw _privateConstructorUsedError;
  WebSourceChapterParser get chapters => throw _privateConstructorUsedError;

  /// Serializes this WebSourceMangaParser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebSourceMangaParser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebSourceMangaParserCopyWith<WebSourceMangaParser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSourceMangaParserCopyWith<$Res> {
  factory $WebSourceMangaParserCopyWith(WebSourceMangaParser value,
          $Res Function(WebSourceMangaParser) then) =
      _$WebSourceMangaParserCopyWithImpl<$Res, WebSourceMangaParser>;
  @useResult
  $Res call(
      {String mangaPath,
      TagParser title,
      TagParser description,
      TagParser artist,
      TagParser author,
      TagParser cover,
      WebSourceChapterParser chapters});

  $TagParserCopyWith<$Res> get title;
  $TagParserCopyWith<$Res> get description;
  $TagParserCopyWith<$Res> get artist;
  $TagParserCopyWith<$Res> get author;
  $TagParserCopyWith<$Res> get cover;
  $WebSourceChapterParserCopyWith<$Res> get chapters;
}

/// @nodoc
class _$WebSourceMangaParserCopyWithImpl<$Res,
        $Val extends WebSourceMangaParser>
    implements $WebSourceMangaParserCopyWith<$Res> {
  _$WebSourceMangaParserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSourceMangaParser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mangaPath = null,
    Object? title = null,
    Object? description = null,
    Object? artist = null,
    Object? author = null,
    Object? cover = null,
    Object? chapters = null,
  }) {
    return _then(_value.copyWith(
      mangaPath: null == mangaPath
          ? _value.mangaPath
          : mangaPath // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as TagParser,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as TagParser,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as TagParser,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as TagParser,
      cover: null == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as TagParser,
      chapters: null == chapters
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as WebSourceChapterParser,
    ) as $Val);
  }

  /// Create a copy of WebSourceMangaParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get title {
    return $TagParserCopyWith<$Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  /// Create a copy of WebSourceMangaParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get description {
    return $TagParserCopyWith<$Res>(_value.description, (value) {
      return _then(_value.copyWith(description: value) as $Val);
    });
  }

  /// Create a copy of WebSourceMangaParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get artist {
    return $TagParserCopyWith<$Res>(_value.artist, (value) {
      return _then(_value.copyWith(artist: value) as $Val);
    });
  }

  /// Create a copy of WebSourceMangaParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get author {
    return $TagParserCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }

  /// Create a copy of WebSourceMangaParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get cover {
    return $TagParserCopyWith<$Res>(_value.cover, (value) {
      return _then(_value.copyWith(cover: value) as $Val);
    });
  }

  /// Create a copy of WebSourceMangaParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WebSourceChapterParserCopyWith<$Res> get chapters {
    return $WebSourceChapterParserCopyWith<$Res>(_value.chapters, (value) {
      return _then(_value.copyWith(chapters: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WebSourceMangaParserImplCopyWith<$Res>
    implements $WebSourceMangaParserCopyWith<$Res> {
  factory _$$WebSourceMangaParserImplCopyWith(_$WebSourceMangaParserImpl value,
          $Res Function(_$WebSourceMangaParserImpl) then) =
      __$$WebSourceMangaParserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String mangaPath,
      TagParser title,
      TagParser description,
      TagParser artist,
      TagParser author,
      TagParser cover,
      WebSourceChapterParser chapters});

  @override
  $TagParserCopyWith<$Res> get title;
  @override
  $TagParserCopyWith<$Res> get description;
  @override
  $TagParserCopyWith<$Res> get artist;
  @override
  $TagParserCopyWith<$Res> get author;
  @override
  $TagParserCopyWith<$Res> get cover;
  @override
  $WebSourceChapterParserCopyWith<$Res> get chapters;
}

/// @nodoc
class __$$WebSourceMangaParserImplCopyWithImpl<$Res>
    extends _$WebSourceMangaParserCopyWithImpl<$Res, _$WebSourceMangaParserImpl>
    implements _$$WebSourceMangaParserImplCopyWith<$Res> {
  __$$WebSourceMangaParserImplCopyWithImpl(_$WebSourceMangaParserImpl _value,
      $Res Function(_$WebSourceMangaParserImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSourceMangaParser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mangaPath = null,
    Object? title = null,
    Object? description = null,
    Object? artist = null,
    Object? author = null,
    Object? cover = null,
    Object? chapters = null,
  }) {
    return _then(_$WebSourceMangaParserImpl(
      mangaPath: null == mangaPath
          ? _value.mangaPath
          : mangaPath // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as TagParser,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as TagParser,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as TagParser,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as TagParser,
      cover: null == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as TagParser,
      chapters: null == chapters
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as WebSourceChapterParser,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSourceMangaParserImpl implements _WebSourceMangaParser {
  const _$WebSourceMangaParserImpl(
      {required this.mangaPath,
      required this.title,
      required this.description,
      required this.artist,
      required this.author,
      required this.cover,
      required this.chapters});

  factory _$WebSourceMangaParserImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSourceMangaParserImplFromJson(json);

  @override
  final String mangaPath;
  @override
  final TagParser title;
  @override
  final TagParser description;
  @override
  final TagParser artist;
  @override
  final TagParser author;
  @override
  final TagParser cover;
  @override
  final WebSourceChapterParser chapters;

  @override
  String toString() {
    return 'WebSourceMangaParser(mangaPath: $mangaPath, title: $title, description: $description, artist: $artist, author: $author, cover: $cover, chapters: $chapters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSourceMangaParserImpl &&
            (identical(other.mangaPath, mangaPath) ||
                other.mangaPath == mangaPath) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.chapters, chapters) ||
                other.chapters == chapters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mangaPath, title, description,
      artist, author, cover, chapters);

  /// Create a copy of WebSourceMangaParser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSourceMangaParserImplCopyWith<_$WebSourceMangaParserImpl>
      get copyWith =>
          __$$WebSourceMangaParserImplCopyWithImpl<_$WebSourceMangaParserImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSourceMangaParserImplToJson(
      this,
    );
  }
}

abstract class _WebSourceMangaParser implements WebSourceMangaParser {
  const factory _WebSourceMangaParser(
          {required final String mangaPath,
          required final TagParser title,
          required final TagParser description,
          required final TagParser artist,
          required final TagParser author,
          required final TagParser cover,
          required final WebSourceChapterParser chapters}) =
      _$WebSourceMangaParserImpl;

  factory _WebSourceMangaParser.fromJson(Map<String, dynamic> json) =
      _$WebSourceMangaParserImpl.fromJson;

  @override
  String get mangaPath;
  @override
  TagParser get title;
  @override
  TagParser get description;
  @override
  TagParser get artist;
  @override
  TagParser get author;
  @override
  TagParser get cover;
  @override
  WebSourceChapterParser get chapters;

  /// Create a copy of WebSourceMangaParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSourceMangaParserImplCopyWith<_$WebSourceMangaParserImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WebSourceChapterParser _$WebSourceChapterParserFromJson(
    Map<String, dynamic> json) {
  return _WebSourceChapterParser.fromJson(json);
}

/// @nodoc
mixin _$WebSourceChapterParser {
  TagParser get items => throw _privateConstructorUsedError;
  TagParser get url => throw _privateConstructorUsedError;
  TagParser get title => throw _privateConstructorUsedError;
  TagParser get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this WebSourceChapterParser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebSourceChapterParser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebSourceChapterParserCopyWith<WebSourceChapterParser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSourceChapterParserCopyWith<$Res> {
  factory $WebSourceChapterParserCopyWith(WebSourceChapterParser value,
          $Res Function(WebSourceChapterParser) then) =
      _$WebSourceChapterParserCopyWithImpl<$Res, WebSourceChapterParser>;
  @useResult
  $Res call(
      {TagParser items, TagParser url, TagParser title, TagParser lastUpdated});

  $TagParserCopyWith<$Res> get items;
  $TagParserCopyWith<$Res> get url;
  $TagParserCopyWith<$Res> get title;
  $TagParserCopyWith<$Res> get lastUpdated;
}

/// @nodoc
class _$WebSourceChapterParserCopyWithImpl<$Res,
        $Val extends WebSourceChapterParser>
    implements $WebSourceChapterParserCopyWith<$Res> {
  _$WebSourceChapterParserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSourceChapterParser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? url = null,
    Object? title = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as TagParser,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as TagParser,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as TagParser,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as TagParser,
    ) as $Val);
  }

  /// Create a copy of WebSourceChapterParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get items {
    return $TagParserCopyWith<$Res>(_value.items, (value) {
      return _then(_value.copyWith(items: value) as $Val);
    });
  }

  /// Create a copy of WebSourceChapterParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get url {
    return $TagParserCopyWith<$Res>(_value.url, (value) {
      return _then(_value.copyWith(url: value) as $Val);
    });
  }

  /// Create a copy of WebSourceChapterParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get title {
    return $TagParserCopyWith<$Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  /// Create a copy of WebSourceChapterParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagParserCopyWith<$Res> get lastUpdated {
    return $TagParserCopyWith<$Res>(_value.lastUpdated, (value) {
      return _then(_value.copyWith(lastUpdated: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WebSourceChapterParserImplCopyWith<$Res>
    implements $WebSourceChapterParserCopyWith<$Res> {
  factory _$$WebSourceChapterParserImplCopyWith(
          _$WebSourceChapterParserImpl value,
          $Res Function(_$WebSourceChapterParserImpl) then) =
      __$$WebSourceChapterParserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TagParser items, TagParser url, TagParser title, TagParser lastUpdated});

  @override
  $TagParserCopyWith<$Res> get items;
  @override
  $TagParserCopyWith<$Res> get url;
  @override
  $TagParserCopyWith<$Res> get title;
  @override
  $TagParserCopyWith<$Res> get lastUpdated;
}

/// @nodoc
class __$$WebSourceChapterParserImplCopyWithImpl<$Res>
    extends _$WebSourceChapterParserCopyWithImpl<$Res,
        _$WebSourceChapterParserImpl>
    implements _$$WebSourceChapterParserImplCopyWith<$Res> {
  __$$WebSourceChapterParserImplCopyWithImpl(
      _$WebSourceChapterParserImpl _value,
      $Res Function(_$WebSourceChapterParserImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSourceChapterParser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? url = null,
    Object? title = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$WebSourceChapterParserImpl(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as TagParser,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as TagParser,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as TagParser,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as TagParser,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSourceChapterParserImpl implements _WebSourceChapterParser {
  const _$WebSourceChapterParserImpl(
      {required this.items,
      required this.url,
      required this.title,
      required this.lastUpdated});

  factory _$WebSourceChapterParserImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSourceChapterParserImplFromJson(json);

  @override
  final TagParser items;
  @override
  final TagParser url;
  @override
  final TagParser title;
  @override
  final TagParser lastUpdated;

  @override
  String toString() {
    return 'WebSourceChapterParser(items: $items, url: $url, title: $title, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSourceChapterParserImpl &&
            (identical(other.items, items) || other.items == items) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, items, url, title, lastUpdated);

  /// Create a copy of WebSourceChapterParser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSourceChapterParserImplCopyWith<_$WebSourceChapterParserImpl>
      get copyWith => __$$WebSourceChapterParserImplCopyWithImpl<
          _$WebSourceChapterParserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSourceChapterParserImplToJson(
      this,
    );
  }
}

abstract class _WebSourceChapterParser implements WebSourceChapterParser {
  const factory _WebSourceChapterParser(
      {required final TagParser items,
      required final TagParser url,
      required final TagParser title,
      required final TagParser lastUpdated}) = _$WebSourceChapterParserImpl;

  factory _WebSourceChapterParser.fromJson(Map<String, dynamic> json) =
      _$WebSourceChapterParserImpl.fromJson;

  @override
  TagParser get items;
  @override
  TagParser get url;
  @override
  TagParser get title;
  @override
  TagParser get lastUpdated;

  /// Create a copy of WebSourceChapterParser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSourceChapterParserImplCopyWith<_$WebSourceChapterParserImpl>
      get copyWith => throw _privateConstructorUsedError;
}
