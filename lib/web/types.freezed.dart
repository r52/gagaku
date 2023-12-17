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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProxyInfo {
  String get proxy => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String? get chapter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryLinkCopyWith<HistoryLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryLinkCopyWith<$Res> {
  factory $HistoryLinkCopyWith(
          HistoryLink value, $Res Function(HistoryLink) then) =
      _$HistoryLinkCopyWithImpl<$Res, HistoryLink>;
  @useResult
  $Res call({String title, String url});
}

/// @nodoc
class _$HistoryLinkCopyWithImpl<$Res, $Val extends HistoryLink>
    implements $HistoryLinkCopyWith<$Res> {
  _$HistoryLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
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
  $Res call({String title, String url});
}

/// @nodoc
class __$$HistoryLinkImplCopyWithImpl<$Res>
    extends _$HistoryLinkCopyWithImpl<$Res, _$HistoryLinkImpl>
    implements _$$HistoryLinkImplCopyWith<$Res> {
  __$$HistoryLinkImplCopyWithImpl(
      _$HistoryLinkImpl _value, $Res Function(_$HistoryLinkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryLinkImpl extends _HistoryLink {
  const _$HistoryLinkImpl({required this.title, required this.url}) : super._();

  factory _$HistoryLinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryLinkImplFromJson(json);

  @override
  final String title;
  @override
  final String url;

  @override
  String toString() {
    return 'HistoryLink(title: $title, url: $url)';
  }

  @JsonKey(ignore: true)
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
      required final String url}) = _$HistoryLinkImpl;
  const _HistoryLink._() : super._();

  factory _HistoryLink.fromJson(Map<String, dynamic> json) =
      _$HistoryLinkImpl.fromJson;

  @override
  String get title;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, volume, lastUpdated,
      releaseDate, const DeepCollectionEquality().hash(_groups));

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description, src);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$ImgurPageImplCopyWith<_$ImgurPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
