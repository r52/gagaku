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
abstract class _$$_ProxyInfoCopyWith<$Res> implements $ProxyInfoCopyWith<$Res> {
  factory _$$_ProxyInfoCopyWith(
          _$_ProxyInfo value, $Res Function(_$_ProxyInfo) then) =
      __$$_ProxyInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String proxy, String code, String? chapter});
}

/// @nodoc
class __$$_ProxyInfoCopyWithImpl<$Res>
    extends _$ProxyInfoCopyWithImpl<$Res, _$_ProxyInfo>
    implements _$$_ProxyInfoCopyWith<$Res> {
  __$$_ProxyInfoCopyWithImpl(
      _$_ProxyInfo _value, $Res Function(_$_ProxyInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? proxy = null,
    Object? code = null,
    Object? chapter = freezed,
  }) {
    return _then(_$_ProxyInfo(
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

class _$_ProxyInfo extends _ProxyInfo {
  const _$_ProxyInfo({required this.proxy, required this.code, this.chapter})
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProxyInfo &&
            (identical(other.proxy, proxy) || other.proxy == proxy) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.chapter, chapter) || other.chapter == chapter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, proxy, code, chapter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProxyInfoCopyWith<_$_ProxyInfo> get copyWith =>
      __$$_ProxyInfoCopyWithImpl<_$_ProxyInfo>(this, _$identity);
}

abstract class _ProxyInfo extends ProxyInfo {
  const factory _ProxyInfo(
      {required final String proxy,
      required final String code,
      final String? chapter}) = _$_ProxyInfo;
  const _ProxyInfo._() : super._();

  @override
  String get proxy;
  @override
  String get code;
  @override
  String? get chapter;
  @override
  @JsonKey(ignore: true)
  _$$_ProxyInfoCopyWith<_$_ProxyInfo> get copyWith =>
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
abstract class _$$_HistoryLinkCopyWith<$Res>
    implements $HistoryLinkCopyWith<$Res> {
  factory _$$_HistoryLinkCopyWith(
          _$_HistoryLink value, $Res Function(_$_HistoryLink) then) =
      __$$_HistoryLinkCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String url});
}

/// @nodoc
class __$$_HistoryLinkCopyWithImpl<$Res>
    extends _$HistoryLinkCopyWithImpl<$Res, _$_HistoryLink>
    implements _$$_HistoryLinkCopyWith<$Res> {
  __$$_HistoryLinkCopyWithImpl(
      _$_HistoryLink _value, $Res Function(_$_HistoryLink) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
  }) {
    return _then(_$_HistoryLink(
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
class _$_HistoryLink extends _HistoryLink {
  const _$_HistoryLink({required this.title, required this.url}) : super._();

  factory _$_HistoryLink.fromJson(Map<String, dynamic> json) =>
      _$$_HistoryLinkFromJson(json);

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
  _$$_HistoryLinkCopyWith<_$_HistoryLink> get copyWith =>
      __$$_HistoryLinkCopyWithImpl<_$_HistoryLink>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HistoryLinkToJson(
      this,
    );
  }
}

abstract class _HistoryLink extends HistoryLink {
  const factory _HistoryLink(
      {required final String title,
      required final String url}) = _$_HistoryLink;
  const _HistoryLink._() : super._();

  factory _HistoryLink.fromJson(Map<String, dynamic> json) =
      _$_HistoryLink.fromJson;

  @override
  String get title;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$_HistoryLinkCopyWith<_$_HistoryLink> get copyWith =>
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
      chapters: null == chapters
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as Map<String, WebChapter>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WebMangaCopyWith<$Res> implements $WebMangaCopyWith<$Res> {
  factory _$$_WebMangaCopyWith(
          _$_WebManga value, $Res Function(_$_WebManga) then) =
      __$$_WebMangaCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      String artist,
      String author,
      String cover,
      Map<String, WebChapter> chapters});
}

/// @nodoc
class __$$_WebMangaCopyWithImpl<$Res>
    extends _$WebMangaCopyWithImpl<$Res, _$_WebManga>
    implements _$$_WebMangaCopyWith<$Res> {
  __$$_WebMangaCopyWithImpl(
      _$_WebManga _value, $Res Function(_$_WebManga) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? artist = null,
    Object? author = null,
    Object? cover = null,
    Object? chapters = null,
  }) {
    return _then(_$_WebManga(
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
      chapters: null == chapters
          ? _value._chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as Map<String, WebChapter>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WebManga extends _WebManga {
  const _$_WebManga(
      {required this.title,
      required this.description,
      required this.artist,
      required this.author,
      required this.cover,
      required final Map<String, WebChapter> chapters})
      : _chapters = chapters,
        super._();

  factory _$_WebManga.fromJson(Map<String, dynamic> json) =>
      _$$_WebMangaFromJson(json);

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
  final Map<String, WebChapter> _chapters;
  @override
  Map<String, WebChapter> get chapters {
    if (_chapters is EqualUnmodifiableMapView) return _chapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_chapters);
  }

  @override
  String toString() {
    return 'WebManga(title: $title, description: $description, artist: $artist, author: $author, cover: $cover, chapters: $chapters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WebManga &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            const DeepCollectionEquality().equals(other._chapters, _chapters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, artist,
      author, cover, const DeepCollectionEquality().hash(_chapters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WebMangaCopyWith<_$_WebManga> get copyWith =>
      __$$_WebMangaCopyWithImpl<_$_WebManga>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WebMangaToJson(
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
      required final Map<String, WebChapter> chapters}) = _$_WebManga;
  const _WebManga._() : super._();

  factory _WebManga.fromJson(Map<String, dynamic> json) = _$_WebManga.fromJson;

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
  Map<String, WebChapter> get chapters;
  @override
  @JsonKey(ignore: true)
  _$$_WebMangaCopyWith<_$_WebManga> get copyWith =>
      throw _privateConstructorUsedError;
}

WebChapter _$WebChapterFromJson(Map<String, dynamic> json) {
  return _WebChapter.fromJson(json);
}

/// @nodoc
mixin _$WebChapter {
  String get title => throw _privateConstructorUsedError;
  String get volume => throw _privateConstructorUsedError;
  @EpochTimestampSerializer()
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  Map<String, String> get groups => throw _privateConstructorUsedError;

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
      {String title,
      String volume,
      @EpochTimestampSerializer() DateTime? lastUpdated,
      Map<String, String> groups});
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
    Object? title = null,
    Object? volume = null,
    Object? lastUpdated = freezed,
    Object? groups = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      groups: null == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WebChapterCopyWith<$Res>
    implements $WebChapterCopyWith<$Res> {
  factory _$$_WebChapterCopyWith(
          _$_WebChapter value, $Res Function(_$_WebChapter) then) =
      __$$_WebChapterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String volume,
      @EpochTimestampSerializer() DateTime? lastUpdated,
      Map<String, String> groups});
}

/// @nodoc
class __$$_WebChapterCopyWithImpl<$Res>
    extends _$WebChapterCopyWithImpl<$Res, _$_WebChapter>
    implements _$$_WebChapterCopyWith<$Res> {
  __$$_WebChapterCopyWithImpl(
      _$_WebChapter _value, $Res Function(_$_WebChapter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? volume = null,
    Object? lastUpdated = freezed,
    Object? groups = null,
  }) {
    return _then(_$_WebChapter(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      groups: null == groups
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_WebChapter extends _WebChapter {
  const _$_WebChapter(
      {required this.title,
      required this.volume,
      @EpochTimestampSerializer() this.lastUpdated,
      required final Map<String, String> groups})
      : _groups = groups,
        super._();

  factory _$_WebChapter.fromJson(Map<String, dynamic> json) =>
      _$$_WebChapterFromJson(json);

  @override
  final String title;
  @override
  final String volume;
  @override
  @EpochTimestampSerializer()
  final DateTime? lastUpdated;
  final Map<String, String> _groups;
  @override
  Map<String, String> get groups {
    if (_groups is EqualUnmodifiableMapView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_groups);
  }

  @override
  String toString() {
    return 'WebChapter(title: $title, volume: $volume, lastUpdated: $lastUpdated, groups: $groups)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WebChapter &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality().equals(other._groups, _groups));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, volume, lastUpdated,
      const DeepCollectionEquality().hash(_groups));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WebChapterCopyWith<_$_WebChapter> get copyWith =>
      __$$_WebChapterCopyWithImpl<_$_WebChapter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WebChapterToJson(
      this,
    );
  }
}

abstract class _WebChapter extends WebChapter {
  const factory _WebChapter(
      {required final String title,
      required final String volume,
      @EpochTimestampSerializer() final DateTime? lastUpdated,
      required final Map<String, String> groups}) = _$_WebChapter;
  const _WebChapter._() : super._();

  factory _WebChapter.fromJson(Map<String, dynamic> json) =
      _$_WebChapter.fromJson;

  @override
  String get title;
  @override
  String get volume;
  @override
  @EpochTimestampSerializer()
  DateTime? get lastUpdated;
  @override
  Map<String, String> get groups;
  @override
  @JsonKey(ignore: true)
  _$$_WebChapterCopyWith<_$_WebChapter> get copyWith =>
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
abstract class _$$_ImgurPageCopyWith<$Res> implements $ImgurPageCopyWith<$Res> {
  factory _$$_ImgurPageCopyWith(
          _$_ImgurPage value, $Res Function(_$_ImgurPage) then) =
      __$$_ImgurPageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, String src});
}

/// @nodoc
class __$$_ImgurPageCopyWithImpl<$Res>
    extends _$ImgurPageCopyWithImpl<$Res, _$_ImgurPage>
    implements _$$_ImgurPageCopyWith<$Res> {
  __$$_ImgurPageCopyWithImpl(
      _$_ImgurPage _value, $Res Function(_$_ImgurPage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? src = null,
  }) {
    return _then(_$_ImgurPage(
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
class _$_ImgurPage implements _ImgurPage {
  const _$_ImgurPage({required this.description, required this.src});

  factory _$_ImgurPage.fromJson(Map<String, dynamic> json) =>
      _$$_ImgurPageFromJson(json);

  @override
  final String description;
  @override
  final String src;

  @override
  String toString() {
    return 'ImgurPage(description: $description, src: $src)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImgurPage &&
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
  _$$_ImgurPageCopyWith<_$_ImgurPage> get copyWith =>
      __$$_ImgurPageCopyWithImpl<_$_ImgurPage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ImgurPageToJson(
      this,
    );
  }
}

abstract class _ImgurPage implements ImgurPage {
  const factory _ImgurPage(
      {required final String description,
      required final String src}) = _$_ImgurPage;

  factory _ImgurPage.fromJson(Map<String, dynamic> json) =
      _$_ImgurPage.fromJson;

  @override
  String get description;
  @override
  String get src;
  @override
  @JsonKey(ignore: true)
  _$$_ImgurPageCopyWith<_$_ImgurPage> get copyWith =>
      throw _privateConstructorUsedError;
}
