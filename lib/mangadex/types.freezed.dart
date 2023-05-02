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

MangaFilters _$MangaFiltersFromJson(Map<String, dynamic> json) {
  return _MangaFilters.fromJson(json);
}

/// @nodoc
mixin _$MangaFilters {
  Set<Tag> get includedTags => throw _privateConstructorUsedError;
  Set<Tag> get excludedTags => throw _privateConstructorUsedError;
  Set<MangaStatus> get status => throw _privateConstructorUsedError;
  Set<MangaDemographic> get publicationDemographic =>
      throw _privateConstructorUsedError;
  Set<ContentRating> get contentRating => throw _privateConstructorUsedError;
  FilterOrder get order => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaFiltersCopyWith<MangaFilters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaFiltersCopyWith<$Res> {
  factory $MangaFiltersCopyWith(
          MangaFilters value, $Res Function(MangaFilters) then) =
      _$MangaFiltersCopyWithImpl<$Res, MangaFilters>;
  @useResult
  $Res call(
      {Set<Tag> includedTags,
      Set<Tag> excludedTags,
      Set<MangaStatus> status,
      Set<MangaDemographic> publicationDemographic,
      Set<ContentRating> contentRating,
      FilterOrder order});
}

/// @nodoc
class _$MangaFiltersCopyWithImpl<$Res, $Val extends MangaFilters>
    implements $MangaFiltersCopyWith<$Res> {
  _$MangaFiltersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? includedTags = null,
    Object? excludedTags = null,
    Object? status = null,
    Object? publicationDemographic = null,
    Object? contentRating = null,
    Object? order = null,
  }) {
    return _then(_value.copyWith(
      includedTags: null == includedTags
          ? _value.includedTags
          : includedTags // ignore: cast_nullable_to_non_nullable
              as Set<Tag>,
      excludedTags: null == excludedTags
          ? _value.excludedTags
          : excludedTags // ignore: cast_nullable_to_non_nullable
              as Set<Tag>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Set<MangaStatus>,
      publicationDemographic: null == publicationDemographic
          ? _value.publicationDemographic
          : publicationDemographic // ignore: cast_nullable_to_non_nullable
              as Set<MangaDemographic>,
      contentRating: null == contentRating
          ? _value.contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as Set<ContentRating>,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as FilterOrder,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MangaFiltersCopyWith<$Res>
    implements $MangaFiltersCopyWith<$Res> {
  factory _$$_MangaFiltersCopyWith(
          _$_MangaFilters value, $Res Function(_$_MangaFilters) then) =
      __$$_MangaFiltersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Set<Tag> includedTags,
      Set<Tag> excludedTags,
      Set<MangaStatus> status,
      Set<MangaDemographic> publicationDemographic,
      Set<ContentRating> contentRating,
      FilterOrder order});
}

/// @nodoc
class __$$_MangaFiltersCopyWithImpl<$Res>
    extends _$MangaFiltersCopyWithImpl<$Res, _$_MangaFilters>
    implements _$$_MangaFiltersCopyWith<$Res> {
  __$$_MangaFiltersCopyWithImpl(
      _$_MangaFilters _value, $Res Function(_$_MangaFilters) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? includedTags = null,
    Object? excludedTags = null,
    Object? status = null,
    Object? publicationDemographic = null,
    Object? contentRating = null,
    Object? order = null,
  }) {
    return _then(_$_MangaFilters(
      includedTags: null == includedTags
          ? _value._includedTags
          : includedTags // ignore: cast_nullable_to_non_nullable
              as Set<Tag>,
      excludedTags: null == excludedTags
          ? _value._excludedTags
          : excludedTags // ignore: cast_nullable_to_non_nullable
              as Set<Tag>,
      status: null == status
          ? _value._status
          : status // ignore: cast_nullable_to_non_nullable
              as Set<MangaStatus>,
      publicationDemographic: null == publicationDemographic
          ? _value._publicationDemographic
          : publicationDemographic // ignore: cast_nullable_to_non_nullable
              as Set<MangaDemographic>,
      contentRating: null == contentRating
          ? _value._contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as Set<ContentRating>,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as FilterOrder,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MangaFilters extends _MangaFilters with DiagnosticableTreeMixin {
  const _$_MangaFilters(
      {final Set<Tag> includedTags = const {},
      final Set<Tag> excludedTags = const {},
      final Set<MangaStatus> status = const {},
      final Set<MangaDemographic> publicationDemographic = const {},
      final Set<ContentRating> contentRating = const {},
      this.order = FilterOrder.relevance_desc})
      : _includedTags = includedTags,
        _excludedTags = excludedTags,
        _status = status,
        _publicationDemographic = publicationDemographic,
        _contentRating = contentRating,
        super._();

  factory _$_MangaFilters.fromJson(Map<String, dynamic> json) =>
      _$$_MangaFiltersFromJson(json);

  final Set<Tag> _includedTags;
  @override
  @JsonKey()
  Set<Tag> get includedTags {
    if (_includedTags is EqualUnmodifiableSetView) return _includedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_includedTags);
  }

  final Set<Tag> _excludedTags;
  @override
  @JsonKey()
  Set<Tag> get excludedTags {
    if (_excludedTags is EqualUnmodifiableSetView) return _excludedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_excludedTags);
  }

  final Set<MangaStatus> _status;
  @override
  @JsonKey()
  Set<MangaStatus> get status {
    if (_status is EqualUnmodifiableSetView) return _status;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_status);
  }

  final Set<MangaDemographic> _publicationDemographic;
  @override
  @JsonKey()
  Set<MangaDemographic> get publicationDemographic {
    if (_publicationDemographic is EqualUnmodifiableSetView)
      return _publicationDemographic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_publicationDemographic);
  }

  final Set<ContentRating> _contentRating;
  @override
  @JsonKey()
  Set<ContentRating> get contentRating {
    if (_contentRating is EqualUnmodifiableSetView) return _contentRating;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_contentRating);
  }

  @override
  @JsonKey()
  final FilterOrder order;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaFilters(includedTags: $includedTags, excludedTags: $excludedTags, status: $status, publicationDemographic: $publicationDemographic, contentRating: $contentRating, order: $order)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaFilters'))
      ..add(DiagnosticsProperty('includedTags', includedTags))
      ..add(DiagnosticsProperty('excludedTags', excludedTags))
      ..add(DiagnosticsProperty('status', status))
      ..add(
          DiagnosticsProperty('publicationDemographic', publicationDemographic))
      ..add(DiagnosticsProperty('contentRating', contentRating))
      ..add(DiagnosticsProperty('order', order));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MangaFilters &&
            const DeepCollectionEquality()
                .equals(other._includedTags, _includedTags) &&
            const DeepCollectionEquality()
                .equals(other._excludedTags, _excludedTags) &&
            const DeepCollectionEquality().equals(other._status, _status) &&
            const DeepCollectionEquality().equals(
                other._publicationDemographic, _publicationDemographic) &&
            const DeepCollectionEquality()
                .equals(other._contentRating, _contentRating) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_includedTags),
      const DeepCollectionEquality().hash(_excludedTags),
      const DeepCollectionEquality().hash(_status),
      const DeepCollectionEquality().hash(_publicationDemographic),
      const DeepCollectionEquality().hash(_contentRating),
      order);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MangaFiltersCopyWith<_$_MangaFilters> get copyWith =>
      __$$_MangaFiltersCopyWithImpl<_$_MangaFilters>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MangaFiltersToJson(
      this,
    );
  }
}

abstract class _MangaFilters extends MangaFilters {
  const factory _MangaFilters(
      {final Set<Tag> includedTags,
      final Set<Tag> excludedTags,
      final Set<MangaStatus> status,
      final Set<MangaDemographic> publicationDemographic,
      final Set<ContentRating> contentRating,
      final FilterOrder order}) = _$_MangaFilters;
  const _MangaFilters._() : super._();

  factory _MangaFilters.fromJson(Map<String, dynamic> json) =
      _$_MangaFilters.fromJson;

  @override
  Set<Tag> get includedTags;
  @override
  Set<Tag> get excludedTags;
  @override
  Set<MangaStatus> get status;
  @override
  Set<MangaDemographic> get publicationDemographic;
  @override
  Set<ContentRating> get contentRating;
  @override
  FilterOrder get order;
  @override
  @JsonKey(ignore: true)
  _$$_MangaFiltersCopyWith<_$_MangaFilters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MangaSearchParameters {
  String get query => throw _privateConstructorUsedError;
  MangaFilters get filter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MangaSearchParametersCopyWith<MangaSearchParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaSearchParametersCopyWith<$Res> {
  factory $MangaSearchParametersCopyWith(MangaSearchParameters value,
          $Res Function(MangaSearchParameters) then) =
      _$MangaSearchParametersCopyWithImpl<$Res, MangaSearchParameters>;
  @useResult
  $Res call({String query, MangaFilters filter});

  $MangaFiltersCopyWith<$Res> get filter;
}

/// @nodoc
class _$MangaSearchParametersCopyWithImpl<$Res,
        $Val extends MangaSearchParameters>
    implements $MangaSearchParametersCopyWith<$Res> {
  _$MangaSearchParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? filter = null,
  }) {
    return _then(_value.copyWith(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as MangaFilters,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MangaFiltersCopyWith<$Res> get filter {
    return $MangaFiltersCopyWith<$Res>(_value.filter, (value) {
      return _then(_value.copyWith(filter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MangaSearchParametersCopyWith<$Res>
    implements $MangaSearchParametersCopyWith<$Res> {
  factory _$$_MangaSearchParametersCopyWith(_$_MangaSearchParameters value,
          $Res Function(_$_MangaSearchParameters) then) =
      __$$_MangaSearchParametersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String query, MangaFilters filter});

  @override
  $MangaFiltersCopyWith<$Res> get filter;
}

/// @nodoc
class __$$_MangaSearchParametersCopyWithImpl<$Res>
    extends _$MangaSearchParametersCopyWithImpl<$Res, _$_MangaSearchParameters>
    implements _$$_MangaSearchParametersCopyWith<$Res> {
  __$$_MangaSearchParametersCopyWithImpl(_$_MangaSearchParameters _value,
      $Res Function(_$_MangaSearchParameters) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? filter = null,
  }) {
    return _then(_$_MangaSearchParameters(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as MangaFilters,
    ));
  }
}

/// @nodoc

class _$_MangaSearchParameters
    with DiagnosticableTreeMixin
    implements _MangaSearchParameters {
  const _$_MangaSearchParameters({required this.query, required this.filter});

  @override
  final String query;
  @override
  final MangaFilters filter;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaSearchParameters(query: $query, filter: $filter)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaSearchParameters'))
      ..add(DiagnosticsProperty('query', query))
      ..add(DiagnosticsProperty('filter', filter));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MangaSearchParameters &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, filter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MangaSearchParametersCopyWith<_$_MangaSearchParameters> get copyWith =>
      __$$_MangaSearchParametersCopyWithImpl<_$_MangaSearchParameters>(
          this, _$identity);
}

abstract class _MangaSearchParameters implements MangaSearchParameters {
  const factory _MangaSearchParameters(
      {required final String query,
      required final MangaFilters filter}) = _$_MangaSearchParameters;

  @override
  String get query;
  @override
  MangaFilters get filter;
  @override
  @JsonKey(ignore: true)
  _$$_MangaSearchParametersCopyWith<_$_MangaSearchParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Language {
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get flag => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LanguageCopyWith<Language> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageCopyWith<$Res> {
  factory $LanguageCopyWith(Language value, $Res Function(Language) then) =
      _$LanguageCopyWithImpl<$Res, Language>;
  @useResult
  $Res call({String name, String code, String flag});
}

/// @nodoc
class _$LanguageCopyWithImpl<$Res, $Val extends Language>
    implements $LanguageCopyWith<$Res> {
  _$LanguageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? flag = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LanguageCopyWith<$Res> implements $LanguageCopyWith<$Res> {
  factory _$$_LanguageCopyWith(
          _$_Language value, $Res Function(_$_Language) then) =
      __$$_LanguageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String code, String flag});
}

/// @nodoc
class __$$_LanguageCopyWithImpl<$Res>
    extends _$LanguageCopyWithImpl<$Res, _$_Language>
    implements _$$_LanguageCopyWith<$Res> {
  __$$_LanguageCopyWithImpl(
      _$_Language _value, $Res Function(_$_Language) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? flag = null,
  }) {
    return _then(_$_Language(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Language with DiagnosticableTreeMixin implements _Language {
  const _$_Language(
      {required this.name, required this.code, required this.flag});

  @override
  final String name;
  @override
  final String code;
  @override
  final String flag;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Language(name: $name, code: $code, flag: $flag)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Language'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('flag', flag));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Language &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.flag, flag) || other.flag == flag));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, code, flag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LanguageCopyWith<_$_Language> get copyWith =>
      __$$_LanguageCopyWithImpl<_$_Language>(this, _$identity);
}

abstract class _Language implements Language {
  const factory _Language(
      {required final String name,
      required final String code,
      required final String flag}) = _$_Language;

  @override
  String get name;
  @override
  String get code;
  @override
  String get flag;
  @override
  @JsonKey(ignore: true)
  _$$_LanguageCopyWith<_$_Language> get copyWith =>
      throw _privateConstructorUsedError;
}

ChapterList _$ChapterListFromJson(Map<String, dynamic> json) {
  return _ChapterList.fromJson(json);
}

/// @nodoc
mixin _$ChapterList {
  List<Chapter> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChapterListCopyWith<ChapterList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterListCopyWith<$Res> {
  factory $ChapterListCopyWith(
          ChapterList value, $Res Function(ChapterList) then) =
      _$ChapterListCopyWithImpl<$Res, ChapterList>;
  @useResult
  $Res call({List<Chapter> data, int total});
}

/// @nodoc
class _$ChapterListCopyWithImpl<$Res, $Val extends ChapterList>
    implements $ChapterListCopyWith<$Res> {
  _$ChapterListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Chapter>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChapterListCopyWith<$Res>
    implements $ChapterListCopyWith<$Res> {
  factory _$$_ChapterListCopyWith(
          _$_ChapterList value, $Res Function(_$_ChapterList) then) =
      __$$_ChapterListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Chapter> data, int total});
}

/// @nodoc
class __$$_ChapterListCopyWithImpl<$Res>
    extends _$ChapterListCopyWithImpl<$Res, _$_ChapterList>
    implements _$$_ChapterListCopyWith<$Res> {
  __$$_ChapterListCopyWithImpl(
      _$_ChapterList _value, $Res Function(_$_ChapterList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$_ChapterList(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Chapter>,
      null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChapterList with DiagnosticableTreeMixin implements _ChapterList {
  const _$_ChapterList(final List<Chapter> data, this.total) : _data = data;

  factory _$_ChapterList.fromJson(Map<String, dynamic> json) =>
      _$$_ChapterListFromJson(json);

  final List<Chapter> _data;
  @override
  List<Chapter> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int total;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChapterList(data: $data, total: $total)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChapterList'))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('total', total));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChapterList &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChapterListCopyWith<_$_ChapterList> get copyWith =>
      __$$_ChapterListCopyWithImpl<_$_ChapterList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChapterListToJson(
      this,
    );
  }
}

abstract class _ChapterList implements ChapterList {
  const factory _ChapterList(final List<Chapter> data, final int total) =
      _$_ChapterList;

  factory _ChapterList.fromJson(Map<String, dynamic> json) =
      _$_ChapterList.fromJson;

  @override
  List<Chapter> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$_ChapterListCopyWith<_$_ChapterList> get copyWith =>
      throw _privateConstructorUsedError;
}

Chapter _$ChapterFromJson(Map<String, dynamic> json) {
  return _Chapter.fromJson(json);
}

/// @nodoc
mixin _$Chapter {
  String get id => throw _privateConstructorUsedError;
  ChapterAttributes get attributes => throw _privateConstructorUsedError;
  List<Relationship> get relationships => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChapterCopyWith<Chapter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterCopyWith<$Res> {
  factory $ChapterCopyWith(Chapter value, $Res Function(Chapter) then) =
      _$ChapterCopyWithImpl<$Res, Chapter>;
  @useResult
  $Res call(
      {String id,
      ChapterAttributes attributes,
      List<Relationship> relationships});

  $ChapterAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class _$ChapterCopyWithImpl<$Res, $Val extends Chapter>
    implements $ChapterCopyWith<$Res> {
  _$ChapterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
    Object? relationships = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as ChapterAttributes,
      relationships: null == relationships
          ? _value.relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as List<Relationship>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChapterAttributesCopyWith<$Res> get attributes {
    return $ChapterAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChapterCopyWith<$Res> implements $ChapterCopyWith<$Res> {
  factory _$$_ChapterCopyWith(
          _$_Chapter value, $Res Function(_$_Chapter) then) =
      __$$_ChapterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ChapterAttributes attributes,
      List<Relationship> relationships});

  @override
  $ChapterAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$_ChapterCopyWithImpl<$Res>
    extends _$ChapterCopyWithImpl<$Res, _$_Chapter>
    implements _$$_ChapterCopyWith<$Res> {
  __$$_ChapterCopyWithImpl(_$_Chapter _value, $Res Function(_$_Chapter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
    Object? relationships = null,
  }) {
    return _then(_$_Chapter(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as ChapterAttributes,
      relationships: null == relationships
          ? _value._relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as List<Relationship>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Chapter extends _Chapter with DiagnosticableTreeMixin {
  const _$_Chapter(
      {required this.id,
      required this.attributes,
      required final List<Relationship> relationships})
      : _relationships = relationships,
        super._();

  factory _$_Chapter.fromJson(Map<String, dynamic> json) =>
      _$$_ChapterFromJson(json);

  @override
  final String id;
  @override
  final ChapterAttributes attributes;
  final List<Relationship> _relationships;
  @override
  List<Relationship> get relationships {
    if (_relationships is EqualUnmodifiableListView) return _relationships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relationships);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Chapter(id: $id, attributes: $attributes, relationships: $relationships)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Chapter'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes))
      ..add(DiagnosticsProperty('relationships', relationships));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Chapter &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes) &&
            const DeepCollectionEquality()
                .equals(other._relationships, _relationships));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes,
      const DeepCollectionEquality().hash(_relationships));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChapterCopyWith<_$_Chapter> get copyWith =>
      __$$_ChapterCopyWithImpl<_$_Chapter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChapterToJson(
      this,
    );
  }
}

abstract class _Chapter extends Chapter {
  const factory _Chapter(
      {required final String id,
      required final ChapterAttributes attributes,
      required final List<Relationship> relationships}) = _$_Chapter;
  const _Chapter._() : super._();

  factory _Chapter.fromJson(Map<String, dynamic> json) = _$_Chapter.fromJson;

  @override
  String get id;
  @override
  ChapterAttributes get attributes;
  @override
  List<Relationship> get relationships;
  @override
  @JsonKey(ignore: true)
  _$$_ChapterCopyWith<_$_Chapter> get copyWith =>
      throw _privateConstructorUsedError;
}

ChapterAttributes _$ChapterAttributesFromJson(Map<String, dynamic> json) {
  return _ChapterAttributes.fromJson(json);
}

/// @nodoc
mixin _$ChapterAttributes {
  String? get title => throw _privateConstructorUsedError;
  String? get volume => throw _privateConstructorUsedError;
  String? get chapter => throw _privateConstructorUsedError;
  @LanguageConverter()
  Language get translatedLanguage => throw _privateConstructorUsedError;
  String? get uploader => throw _privateConstructorUsedError;
  String? get externalUrl => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime get publishAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChapterAttributesCopyWith<ChapterAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterAttributesCopyWith<$Res> {
  factory $ChapterAttributesCopyWith(
          ChapterAttributes value, $Res Function(ChapterAttributes) then) =
      _$ChapterAttributesCopyWithImpl<$Res, ChapterAttributes>;
  @useResult
  $Res call(
      {String? title,
      String? volume,
      String? chapter,
      @LanguageConverter() Language translatedLanguage,
      String? uploader,
      String? externalUrl,
      int version,
      @TimestampSerializer() DateTime createdAt,
      @TimestampSerializer() DateTime updatedAt,
      @TimestampSerializer() DateTime publishAt});

  $LanguageCopyWith<$Res> get translatedLanguage;
}

/// @nodoc
class _$ChapterAttributesCopyWithImpl<$Res, $Val extends ChapterAttributes>
    implements $ChapterAttributesCopyWith<$Res> {
  _$ChapterAttributesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? volume = freezed,
    Object? chapter = freezed,
    Object? translatedLanguage = null,
    Object? uploader = freezed,
    Object? externalUrl = freezed,
    Object? version = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? publishAt = null,
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
      chapter: freezed == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as String?,
      translatedLanguage: null == translatedLanguage
          ? _value.translatedLanguage
          : translatedLanguage // ignore: cast_nullable_to_non_nullable
              as Language,
      uploader: freezed == uploader
          ? _value.uploader
          : uploader // ignore: cast_nullable_to_non_nullable
              as String?,
      externalUrl: freezed == externalUrl
          ? _value.externalUrl
          : externalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      publishAt: null == publishAt
          ? _value.publishAt
          : publishAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LanguageCopyWith<$Res> get translatedLanguage {
    return $LanguageCopyWith<$Res>(_value.translatedLanguage, (value) {
      return _then(_value.copyWith(translatedLanguage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChapterAttributesCopyWith<$Res>
    implements $ChapterAttributesCopyWith<$Res> {
  factory _$$_ChapterAttributesCopyWith(_$_ChapterAttributes value,
          $Res Function(_$_ChapterAttributes) then) =
      __$$_ChapterAttributesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? volume,
      String? chapter,
      @LanguageConverter() Language translatedLanguage,
      String? uploader,
      String? externalUrl,
      int version,
      @TimestampSerializer() DateTime createdAt,
      @TimestampSerializer() DateTime updatedAt,
      @TimestampSerializer() DateTime publishAt});

  @override
  $LanguageCopyWith<$Res> get translatedLanguage;
}

/// @nodoc
class __$$_ChapterAttributesCopyWithImpl<$Res>
    extends _$ChapterAttributesCopyWithImpl<$Res, _$_ChapterAttributes>
    implements _$$_ChapterAttributesCopyWith<$Res> {
  __$$_ChapterAttributesCopyWithImpl(
      _$_ChapterAttributes _value, $Res Function(_$_ChapterAttributes) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? volume = freezed,
    Object? chapter = freezed,
    Object? translatedLanguage = null,
    Object? uploader = freezed,
    Object? externalUrl = freezed,
    Object? version = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? publishAt = null,
  }) {
    return _then(_$_ChapterAttributes(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      volume: freezed == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String?,
      chapter: freezed == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as String?,
      translatedLanguage: null == translatedLanguage
          ? _value.translatedLanguage
          : translatedLanguage // ignore: cast_nullable_to_non_nullable
              as Language,
      uploader: freezed == uploader
          ? _value.uploader
          : uploader // ignore: cast_nullable_to_non_nullable
              as String?,
      externalUrl: freezed == externalUrl
          ? _value.externalUrl
          : externalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      publishAt: null == publishAt
          ? _value.publishAt
          : publishAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChapterAttributes
    with DiagnosticableTreeMixin
    implements _ChapterAttributes {
  const _$_ChapterAttributes(
      {this.title,
      this.volume,
      this.chapter,
      @LanguageConverter() required this.translatedLanguage,
      this.uploader,
      this.externalUrl,
      required this.version,
      @TimestampSerializer() required this.createdAt,
      @TimestampSerializer() required this.updatedAt,
      @TimestampSerializer() required this.publishAt});

  factory _$_ChapterAttributes.fromJson(Map<String, dynamic> json) =>
      _$$_ChapterAttributesFromJson(json);

  @override
  final String? title;
  @override
  final String? volume;
  @override
  final String? chapter;
  @override
  @LanguageConverter()
  final Language translatedLanguage;
  @override
  final String? uploader;
  @override
  final String? externalUrl;
  @override
  final int version;
  @override
  @TimestampSerializer()
  final DateTime createdAt;
  @override
  @TimestampSerializer()
  final DateTime updatedAt;
  @override
  @TimestampSerializer()
  final DateTime publishAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChapterAttributes(title: $title, volume: $volume, chapter: $chapter, translatedLanguage: $translatedLanguage, uploader: $uploader, externalUrl: $externalUrl, version: $version, createdAt: $createdAt, updatedAt: $updatedAt, publishAt: $publishAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChapterAttributes'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('volume', volume))
      ..add(DiagnosticsProperty('chapter', chapter))
      ..add(DiagnosticsProperty('translatedLanguage', translatedLanguage))
      ..add(DiagnosticsProperty('uploader', uploader))
      ..add(DiagnosticsProperty('externalUrl', externalUrl))
      ..add(DiagnosticsProperty('version', version))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('publishAt', publishAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChapterAttributes &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.chapter, chapter) || other.chapter == chapter) &&
            (identical(other.translatedLanguage, translatedLanguage) ||
                other.translatedLanguage == translatedLanguage) &&
            (identical(other.uploader, uploader) ||
                other.uploader == uploader) &&
            (identical(other.externalUrl, externalUrl) ||
                other.externalUrl == externalUrl) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.publishAt, publishAt) ||
                other.publishAt == publishAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      volume,
      chapter,
      translatedLanguage,
      uploader,
      externalUrl,
      version,
      createdAt,
      updatedAt,
      publishAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChapterAttributesCopyWith<_$_ChapterAttributes> get copyWith =>
      __$$_ChapterAttributesCopyWithImpl<_$_ChapterAttributes>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChapterAttributesToJson(
      this,
    );
  }
}

abstract class _ChapterAttributes implements ChapterAttributes {
  const factory _ChapterAttributes(
          {final String? title,
          final String? volume,
          final String? chapter,
          @LanguageConverter() required final Language translatedLanguage,
          final String? uploader,
          final String? externalUrl,
          required final int version,
          @TimestampSerializer() required final DateTime createdAt,
          @TimestampSerializer() required final DateTime updatedAt,
          @TimestampSerializer() required final DateTime publishAt}) =
      _$_ChapterAttributes;

  factory _ChapterAttributes.fromJson(Map<String, dynamic> json) =
      _$_ChapterAttributes.fromJson;

  @override
  String? get title;
  @override
  String? get volume;
  @override
  String? get chapter;
  @override
  @LanguageConverter()
  Language get translatedLanguage;
  @override
  String? get uploader;
  @override
  String? get externalUrl;
  @override
  int get version;
  @override
  @TimestampSerializer()
  DateTime get createdAt;
  @override
  @TimestampSerializer()
  DateTime get updatedAt;
  @override
  @TimestampSerializer()
  DateTime get publishAt;
  @override
  @JsonKey(ignore: true)
  _$$_ChapterAttributesCopyWith<_$_ChapterAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

ScanlationGroupAttributes _$ScanlationGroupAttributesFromJson(
    Map<String, dynamic> json) {
  return _ScanlationGroupAttributes.fromJson(json);
}

/// @nodoc
mixin _$ScanlationGroupAttributes {
  String get name => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get discord => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScanlationGroupAttributesCopyWith<ScanlationGroupAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanlationGroupAttributesCopyWith<$Res> {
  factory $ScanlationGroupAttributesCopyWith(ScanlationGroupAttributes value,
          $Res Function(ScanlationGroupAttributes) then) =
      _$ScanlationGroupAttributesCopyWithImpl<$Res, ScanlationGroupAttributes>;
  @useResult
  $Res call(
      {String name, String? website, String? discord, String? description});
}

/// @nodoc
class _$ScanlationGroupAttributesCopyWithImpl<$Res,
        $Val extends ScanlationGroupAttributes>
    implements $ScanlationGroupAttributesCopyWith<$Res> {
  _$ScanlationGroupAttributesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? website = freezed,
    Object? discord = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      discord: freezed == discord
          ? _value.discord
          : discord // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ScanlationGroupAttributesCopyWith<$Res>
    implements $ScanlationGroupAttributesCopyWith<$Res> {
  factory _$$_ScanlationGroupAttributesCopyWith(
          _$_ScanlationGroupAttributes value,
          $Res Function(_$_ScanlationGroupAttributes) then) =
      __$$_ScanlationGroupAttributesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String? website, String? discord, String? description});
}

/// @nodoc
class __$$_ScanlationGroupAttributesCopyWithImpl<$Res>
    extends _$ScanlationGroupAttributesCopyWithImpl<$Res,
        _$_ScanlationGroupAttributes>
    implements _$$_ScanlationGroupAttributesCopyWith<$Res> {
  __$$_ScanlationGroupAttributesCopyWithImpl(
      _$_ScanlationGroupAttributes _value,
      $Res Function(_$_ScanlationGroupAttributes) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? website = freezed,
    Object? discord = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_ScanlationGroupAttributes(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      discord: freezed == discord
          ? _value.discord
          : discord // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScanlationGroupAttributes
    with DiagnosticableTreeMixin
    implements _ScanlationGroupAttributes {
  const _$_ScanlationGroupAttributes(
      {required this.name, this.website, this.discord, this.description});

  factory _$_ScanlationGroupAttributes.fromJson(Map<String, dynamic> json) =>
      _$$_ScanlationGroupAttributesFromJson(json);

  @override
  final String name;
  @override
  final String? website;
  @override
  final String? discord;
  @override
  final String? description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ScanlationGroupAttributes(name: $name, website: $website, discord: $discord, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ScanlationGroupAttributes'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('website', website))
      ..add(DiagnosticsProperty('discord', discord))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScanlationGroupAttributes &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.discord, discord) || other.discord == discord) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, website, discord, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScanlationGroupAttributesCopyWith<_$_ScanlationGroupAttributes>
      get copyWith => __$$_ScanlationGroupAttributesCopyWithImpl<
          _$_ScanlationGroupAttributes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScanlationGroupAttributesToJson(
      this,
    );
  }
}

abstract class _ScanlationGroupAttributes implements ScanlationGroupAttributes {
  const factory _ScanlationGroupAttributes(
      {required final String name,
      final String? website,
      final String? discord,
      final String? description}) = _$_ScanlationGroupAttributes;

  factory _ScanlationGroupAttributes.fromJson(Map<String, dynamic> json) =
      _$_ScanlationGroupAttributes.fromJson;

  @override
  String get name;
  @override
  String? get website;
  @override
  String? get discord;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_ScanlationGroupAttributesCopyWith<_$_ScanlationGroupAttributes>
      get copyWith => throw _privateConstructorUsedError;
}

CoverArtAttributes _$CoverArtAttributesFromJson(Map<String, dynamic> json) {
  return _CoverArtAttributes.fromJson(json);
}

/// @nodoc
mixin _$CoverArtAttributes {
  String get fileName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoverArtAttributesCopyWith<CoverArtAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoverArtAttributesCopyWith<$Res> {
  factory $CoverArtAttributesCopyWith(
          CoverArtAttributes value, $Res Function(CoverArtAttributes) then) =
      _$CoverArtAttributesCopyWithImpl<$Res, CoverArtAttributes>;
  @useResult
  $Res call({String fileName});
}

/// @nodoc
class _$CoverArtAttributesCopyWithImpl<$Res, $Val extends CoverArtAttributes>
    implements $CoverArtAttributesCopyWith<$Res> {
  _$CoverArtAttributesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = null,
  }) {
    return _then(_value.copyWith(
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CoverArtAttributesCopyWith<$Res>
    implements $CoverArtAttributesCopyWith<$Res> {
  factory _$$_CoverArtAttributesCopyWith(_$_CoverArtAttributes value,
          $Res Function(_$_CoverArtAttributes) then) =
      __$$_CoverArtAttributesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fileName});
}

/// @nodoc
class __$$_CoverArtAttributesCopyWithImpl<$Res>
    extends _$CoverArtAttributesCopyWithImpl<$Res, _$_CoverArtAttributes>
    implements _$$_CoverArtAttributesCopyWith<$Res> {
  __$$_CoverArtAttributesCopyWithImpl(
      _$_CoverArtAttributes _value, $Res Function(_$_CoverArtAttributes) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = null,
  }) {
    return _then(_$_CoverArtAttributes(
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CoverArtAttributes
    with DiagnosticableTreeMixin
    implements _CoverArtAttributes {
  const _$_CoverArtAttributes({required this.fileName});

  factory _$_CoverArtAttributes.fromJson(Map<String, dynamic> json) =>
      _$$_CoverArtAttributesFromJson(json);

  @override
  final String fileName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CoverArtAttributes(fileName: $fileName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CoverArtAttributes'))
      ..add(DiagnosticsProperty('fileName', fileName));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CoverArtAttributes &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fileName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CoverArtAttributesCopyWith<_$_CoverArtAttributes> get copyWith =>
      __$$_CoverArtAttributesCopyWithImpl<_$_CoverArtAttributes>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CoverArtAttributesToJson(
      this,
    );
  }
}

abstract class _CoverArtAttributes implements CoverArtAttributes {
  const factory _CoverArtAttributes({required final String fileName}) =
      _$_CoverArtAttributes;

  factory _CoverArtAttributes.fromJson(Map<String, dynamic> json) =
      _$_CoverArtAttributes.fromJson;

  @override
  String get fileName;
  @override
  @JsonKey(ignore: true)
  _$$_CoverArtAttributesCopyWith<_$_CoverArtAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

NamedAttributes _$NamedAttributesFromJson(Map<String, dynamic> json) {
  return _NamedAttributes.fromJson(json);
}

/// @nodoc
mixin _$NamedAttributes {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NamedAttributesCopyWith<NamedAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NamedAttributesCopyWith<$Res> {
  factory $NamedAttributesCopyWith(
          NamedAttributes value, $Res Function(NamedAttributes) then) =
      _$NamedAttributesCopyWithImpl<$Res, NamedAttributes>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$NamedAttributesCopyWithImpl<$Res, $Val extends NamedAttributes>
    implements $NamedAttributesCopyWith<$Res> {
  _$NamedAttributesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NamedAttributesCopyWith<$Res>
    implements $NamedAttributesCopyWith<$Res> {
  factory _$$_NamedAttributesCopyWith(
          _$_NamedAttributes value, $Res Function(_$_NamedAttributes) then) =
      __$$_NamedAttributesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$_NamedAttributesCopyWithImpl<$Res>
    extends _$NamedAttributesCopyWithImpl<$Res, _$_NamedAttributes>
    implements _$$_NamedAttributesCopyWith<$Res> {
  __$$_NamedAttributesCopyWithImpl(
      _$_NamedAttributes _value, $Res Function(_$_NamedAttributes) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$_NamedAttributes(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NamedAttributes
    with DiagnosticableTreeMixin
    implements _NamedAttributes {
  const _$_NamedAttributes({required this.name});

  factory _$_NamedAttributes.fromJson(Map<String, dynamic> json) =>
      _$$_NamedAttributesFromJson(json);

  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NamedAttributes(name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NamedAttributes'))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NamedAttributes &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NamedAttributesCopyWith<_$_NamedAttributes> get copyWith =>
      __$$_NamedAttributesCopyWithImpl<_$_NamedAttributes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NamedAttributesToJson(
      this,
    );
  }
}

abstract class _NamedAttributes implements NamedAttributes {
  const factory _NamedAttributes({required final String name}) =
      _$_NamedAttributes;

  factory _NamedAttributes.fromJson(Map<String, dynamic> json) =
      _$_NamedAttributes.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_NamedAttributesCopyWith<_$_NamedAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

Relationship _$RelationshipFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'manga':
      return RelationshipManga.fromJson(json);
    case 'user':
      return RelationshipUser.fromJson(json);
    case 'artist':
      return RelationshipArtist.fromJson(json);
    case 'author':
      return RelationshipAuthor.fromJson(json);
    case 'cover_art':
      return RelationshipCoverArt.fromJson(json);
    case 'scanlation_group':
      return RelationshipGroup.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'Relationship',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$Relationship {
  String get id => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id) user,
    required TResult Function(String id, NamedAttributes attributes) artist,
    required TResult Function(String id, NamedAttributes attributes) author,
    required TResult Function(String id, CoverArtAttributes attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id)? user,
    TResult? Function(String id, NamedAttributes attributes)? artist,
    TResult? Function(String id, NamedAttributes attributes)? author,
    TResult? Function(String id, CoverArtAttributes attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id)? user,
    TResult Function(String id, NamedAttributes attributes)? artist,
    TResult Function(String id, NamedAttributes attributes)? author,
    TResult Function(String id, CoverArtAttributes attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RelationshipManga value) manga,
    required TResult Function(RelationshipUser value) user,
    required TResult Function(RelationshipArtist value) artist,
    required TResult Function(RelationshipAuthor value) author,
    required TResult Function(RelationshipCoverArt value) cover,
    required TResult Function(RelationshipGroup value) group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(RelationshipArtist value)? artist,
    TResult? Function(RelationshipAuthor value)? author,
    TResult? Function(RelationshipCoverArt value)? cover,
    TResult? Function(RelationshipGroup value)? group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(RelationshipArtist value)? artist,
    TResult Function(RelationshipAuthor value)? author,
    TResult Function(RelationshipCoverArt value)? cover,
    TResult Function(RelationshipGroup value)? group,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RelationshipCopyWith<Relationship> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RelationshipCopyWith<$Res> {
  factory $RelationshipCopyWith(
          Relationship value, $Res Function(Relationship) then) =
      _$RelationshipCopyWithImpl<$Res, Relationship>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$RelationshipCopyWithImpl<$Res, $Val extends Relationship>
    implements $RelationshipCopyWith<$Res> {
  _$RelationshipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RelationshipMangaCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$RelationshipMangaCopyWith(
          _$RelationshipManga value, $Res Function(_$RelationshipManga) then) =
      __$$RelationshipMangaCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$RelationshipMangaCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$RelationshipManga>
    implements _$$RelationshipMangaCopyWith<$Res> {
  __$$RelationshipMangaCopyWithImpl(
      _$RelationshipManga _value, $Res Function(_$RelationshipManga) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$RelationshipManga(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationshipManga
    with DiagnosticableTreeMixin
    implements RelationshipManga {
  const _$RelationshipManga({required this.id, final String? $type})
      : $type = $type ?? 'manga';

  factory _$RelationshipManga.fromJson(Map<String, dynamic> json) =>
      _$$RelationshipMangaFromJson(json);

  @override
  final String id;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Relationship.manga(id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Relationship.manga'))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationshipManga &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationshipMangaCopyWith<_$RelationshipManga> get copyWith =>
      __$$RelationshipMangaCopyWithImpl<_$RelationshipManga>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id) user,
    required TResult Function(String id, NamedAttributes attributes) artist,
    required TResult Function(String id, NamedAttributes attributes) author,
    required TResult Function(String id, CoverArtAttributes attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return manga(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id)? user,
    TResult? Function(String id, NamedAttributes attributes)? artist,
    TResult? Function(String id, NamedAttributes attributes)? author,
    TResult? Function(String id, CoverArtAttributes attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return manga?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id)? user,
    TResult Function(String id, NamedAttributes attributes)? artist,
    TResult Function(String id, NamedAttributes attributes)? author,
    TResult Function(String id, CoverArtAttributes attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    required TResult orElse(),
  }) {
    if (manga != null) {
      return manga(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RelationshipManga value) manga,
    required TResult Function(RelationshipUser value) user,
    required TResult Function(RelationshipArtist value) artist,
    required TResult Function(RelationshipAuthor value) author,
    required TResult Function(RelationshipCoverArt value) cover,
    required TResult Function(RelationshipGroup value) group,
  }) {
    return manga(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(RelationshipArtist value)? artist,
    TResult? Function(RelationshipAuthor value)? author,
    TResult? Function(RelationshipCoverArt value)? cover,
    TResult? Function(RelationshipGroup value)? group,
  }) {
    return manga?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(RelationshipArtist value)? artist,
    TResult Function(RelationshipAuthor value)? author,
    TResult Function(RelationshipCoverArt value)? cover,
    TResult Function(RelationshipGroup value)? group,
    required TResult orElse(),
  }) {
    if (manga != null) {
      return manga(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RelationshipMangaToJson(
      this,
    );
  }
}

abstract class RelationshipManga implements Relationship {
  const factory RelationshipManga({required final String id}) =
      _$RelationshipManga;

  factory RelationshipManga.fromJson(Map<String, dynamic> json) =
      _$RelationshipManga.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$RelationshipMangaCopyWith<_$RelationshipManga> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RelationshipUserCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$RelationshipUserCopyWith(
          _$RelationshipUser value, $Res Function(_$RelationshipUser) then) =
      __$$RelationshipUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$RelationshipUserCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$RelationshipUser>
    implements _$$RelationshipUserCopyWith<$Res> {
  __$$RelationshipUserCopyWithImpl(
      _$RelationshipUser _value, $Res Function(_$RelationshipUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$RelationshipUser(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationshipUser
    with DiagnosticableTreeMixin
    implements RelationshipUser {
  const _$RelationshipUser({required this.id, final String? $type})
      : $type = $type ?? 'user';

  factory _$RelationshipUser.fromJson(Map<String, dynamic> json) =>
      _$$RelationshipUserFromJson(json);

  @override
  final String id;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Relationship.user(id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Relationship.user'))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationshipUser &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationshipUserCopyWith<_$RelationshipUser> get copyWith =>
      __$$RelationshipUserCopyWithImpl<_$RelationshipUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id) user,
    required TResult Function(String id, NamedAttributes attributes) artist,
    required TResult Function(String id, NamedAttributes attributes) author,
    required TResult Function(String id, CoverArtAttributes attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return user(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id)? user,
    TResult? Function(String id, NamedAttributes attributes)? artist,
    TResult? Function(String id, NamedAttributes attributes)? author,
    TResult? Function(String id, CoverArtAttributes attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return user?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id)? user,
    TResult Function(String id, NamedAttributes attributes)? artist,
    TResult Function(String id, NamedAttributes attributes)? author,
    TResult Function(String id, CoverArtAttributes attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RelationshipManga value) manga,
    required TResult Function(RelationshipUser value) user,
    required TResult Function(RelationshipArtist value) artist,
    required TResult Function(RelationshipAuthor value) author,
    required TResult Function(RelationshipCoverArt value) cover,
    required TResult Function(RelationshipGroup value) group,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(RelationshipArtist value)? artist,
    TResult? Function(RelationshipAuthor value)? author,
    TResult? Function(RelationshipCoverArt value)? cover,
    TResult? Function(RelationshipGroup value)? group,
  }) {
    return user?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(RelationshipArtist value)? artist,
    TResult Function(RelationshipAuthor value)? author,
    TResult Function(RelationshipCoverArt value)? cover,
    TResult Function(RelationshipGroup value)? group,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RelationshipUserToJson(
      this,
    );
  }
}

abstract class RelationshipUser implements Relationship {
  const factory RelationshipUser({required final String id}) =
      _$RelationshipUser;

  factory RelationshipUser.fromJson(Map<String, dynamic> json) =
      _$RelationshipUser.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$RelationshipUserCopyWith<_$RelationshipUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RelationshipArtistCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$RelationshipArtistCopyWith(_$RelationshipArtist value,
          $Res Function(_$RelationshipArtist) then) =
      __$$RelationshipArtistCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, NamedAttributes attributes});

  $NamedAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$RelationshipArtistCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$RelationshipArtist>
    implements _$$RelationshipArtistCopyWith<$Res> {
  __$$RelationshipArtistCopyWithImpl(
      _$RelationshipArtist _value, $Res Function(_$RelationshipArtist) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_$RelationshipArtist(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as NamedAttributes,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $NamedAttributesCopyWith<$Res> get attributes {
    return $NamedAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationshipArtist
    with DiagnosticableTreeMixin
    implements RelationshipArtist {
  const _$RelationshipArtist(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'artist';

  factory _$RelationshipArtist.fromJson(Map<String, dynamic> json) =>
      _$$RelationshipArtistFromJson(json);

  @override
  final String id;
  @override
  final NamedAttributes attributes;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Relationship.artist(id: $id, attributes: $attributes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Relationship.artist'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationshipArtist &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationshipArtistCopyWith<_$RelationshipArtist> get copyWith =>
      __$$RelationshipArtistCopyWithImpl<_$RelationshipArtist>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id) user,
    required TResult Function(String id, NamedAttributes attributes) artist,
    required TResult Function(String id, NamedAttributes attributes) author,
    required TResult Function(String id, CoverArtAttributes attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return artist(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id)? user,
    TResult? Function(String id, NamedAttributes attributes)? artist,
    TResult? Function(String id, NamedAttributes attributes)? author,
    TResult? Function(String id, CoverArtAttributes attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return artist?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id)? user,
    TResult Function(String id, NamedAttributes attributes)? artist,
    TResult Function(String id, NamedAttributes attributes)? author,
    TResult Function(String id, CoverArtAttributes attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    required TResult orElse(),
  }) {
    if (artist != null) {
      return artist(id, attributes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RelationshipManga value) manga,
    required TResult Function(RelationshipUser value) user,
    required TResult Function(RelationshipArtist value) artist,
    required TResult Function(RelationshipAuthor value) author,
    required TResult Function(RelationshipCoverArt value) cover,
    required TResult Function(RelationshipGroup value) group,
  }) {
    return artist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(RelationshipArtist value)? artist,
    TResult? Function(RelationshipAuthor value)? author,
    TResult? Function(RelationshipCoverArt value)? cover,
    TResult? Function(RelationshipGroup value)? group,
  }) {
    return artist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(RelationshipArtist value)? artist,
    TResult Function(RelationshipAuthor value)? author,
    TResult Function(RelationshipCoverArt value)? cover,
    TResult Function(RelationshipGroup value)? group,
    required TResult orElse(),
  }) {
    if (artist != null) {
      return artist(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RelationshipArtistToJson(
      this,
    );
  }
}

abstract class RelationshipArtist implements Relationship {
  const factory RelationshipArtist(
      {required final String id,
      required final NamedAttributes attributes}) = _$RelationshipArtist;

  factory RelationshipArtist.fromJson(Map<String, dynamic> json) =
      _$RelationshipArtist.fromJson;

  @override
  String get id;
  NamedAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$RelationshipArtistCopyWith<_$RelationshipArtist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RelationshipAuthorCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$RelationshipAuthorCopyWith(_$RelationshipAuthor value,
          $Res Function(_$RelationshipAuthor) then) =
      __$$RelationshipAuthorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, NamedAttributes attributes});

  $NamedAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$RelationshipAuthorCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$RelationshipAuthor>
    implements _$$RelationshipAuthorCopyWith<$Res> {
  __$$RelationshipAuthorCopyWithImpl(
      _$RelationshipAuthor _value, $Res Function(_$RelationshipAuthor) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_$RelationshipAuthor(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as NamedAttributes,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $NamedAttributesCopyWith<$Res> get attributes {
    return $NamedAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationshipAuthor
    with DiagnosticableTreeMixin
    implements RelationshipAuthor {
  const _$RelationshipAuthor(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'author';

  factory _$RelationshipAuthor.fromJson(Map<String, dynamic> json) =>
      _$$RelationshipAuthorFromJson(json);

  @override
  final String id;
  @override
  final NamedAttributes attributes;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Relationship.author(id: $id, attributes: $attributes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Relationship.author'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationshipAuthor &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationshipAuthorCopyWith<_$RelationshipAuthor> get copyWith =>
      __$$RelationshipAuthorCopyWithImpl<_$RelationshipAuthor>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id) user,
    required TResult Function(String id, NamedAttributes attributes) artist,
    required TResult Function(String id, NamedAttributes attributes) author,
    required TResult Function(String id, CoverArtAttributes attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return author(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id)? user,
    TResult? Function(String id, NamedAttributes attributes)? artist,
    TResult? Function(String id, NamedAttributes attributes)? author,
    TResult? Function(String id, CoverArtAttributes attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return author?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id)? user,
    TResult Function(String id, NamedAttributes attributes)? artist,
    TResult Function(String id, NamedAttributes attributes)? author,
    TResult Function(String id, CoverArtAttributes attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    required TResult orElse(),
  }) {
    if (author != null) {
      return author(id, attributes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RelationshipManga value) manga,
    required TResult Function(RelationshipUser value) user,
    required TResult Function(RelationshipArtist value) artist,
    required TResult Function(RelationshipAuthor value) author,
    required TResult Function(RelationshipCoverArt value) cover,
    required TResult Function(RelationshipGroup value) group,
  }) {
    return author(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(RelationshipArtist value)? artist,
    TResult? Function(RelationshipAuthor value)? author,
    TResult? Function(RelationshipCoverArt value)? cover,
    TResult? Function(RelationshipGroup value)? group,
  }) {
    return author?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(RelationshipArtist value)? artist,
    TResult Function(RelationshipAuthor value)? author,
    TResult Function(RelationshipCoverArt value)? cover,
    TResult Function(RelationshipGroup value)? group,
    required TResult orElse(),
  }) {
    if (author != null) {
      return author(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RelationshipAuthorToJson(
      this,
    );
  }
}

abstract class RelationshipAuthor implements Relationship {
  const factory RelationshipAuthor(
      {required final String id,
      required final NamedAttributes attributes}) = _$RelationshipAuthor;

  factory RelationshipAuthor.fromJson(Map<String, dynamic> json) =
      _$RelationshipAuthor.fromJson;

  @override
  String get id;
  NamedAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$RelationshipAuthorCopyWith<_$RelationshipAuthor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RelationshipCoverArtCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$RelationshipCoverArtCopyWith(_$RelationshipCoverArt value,
          $Res Function(_$RelationshipCoverArt) then) =
      __$$RelationshipCoverArtCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, CoverArtAttributes attributes});

  $CoverArtAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$RelationshipCoverArtCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$RelationshipCoverArt>
    implements _$$RelationshipCoverArtCopyWith<$Res> {
  __$$RelationshipCoverArtCopyWithImpl(_$RelationshipCoverArt _value,
      $Res Function(_$RelationshipCoverArt) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_$RelationshipCoverArt(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as CoverArtAttributes,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $CoverArtAttributesCopyWith<$Res> get attributes {
    return $CoverArtAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationshipCoverArt
    with DiagnosticableTreeMixin
    implements RelationshipCoverArt {
  const _$RelationshipCoverArt(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'cover_art';

  factory _$RelationshipCoverArt.fromJson(Map<String, dynamic> json) =>
      _$$RelationshipCoverArtFromJson(json);

  @override
  final String id;
  @override
  final CoverArtAttributes attributes;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Relationship.cover(id: $id, attributes: $attributes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Relationship.cover'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationshipCoverArt &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationshipCoverArtCopyWith<_$RelationshipCoverArt> get copyWith =>
      __$$RelationshipCoverArtCopyWithImpl<_$RelationshipCoverArt>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id) user,
    required TResult Function(String id, NamedAttributes attributes) artist,
    required TResult Function(String id, NamedAttributes attributes) author,
    required TResult Function(String id, CoverArtAttributes attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return cover(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id)? user,
    TResult? Function(String id, NamedAttributes attributes)? artist,
    TResult? Function(String id, NamedAttributes attributes)? author,
    TResult? Function(String id, CoverArtAttributes attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return cover?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id)? user,
    TResult Function(String id, NamedAttributes attributes)? artist,
    TResult Function(String id, NamedAttributes attributes)? author,
    TResult Function(String id, CoverArtAttributes attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    required TResult orElse(),
  }) {
    if (cover != null) {
      return cover(id, attributes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RelationshipManga value) manga,
    required TResult Function(RelationshipUser value) user,
    required TResult Function(RelationshipArtist value) artist,
    required TResult Function(RelationshipAuthor value) author,
    required TResult Function(RelationshipCoverArt value) cover,
    required TResult Function(RelationshipGroup value) group,
  }) {
    return cover(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(RelationshipArtist value)? artist,
    TResult? Function(RelationshipAuthor value)? author,
    TResult? Function(RelationshipCoverArt value)? cover,
    TResult? Function(RelationshipGroup value)? group,
  }) {
    return cover?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(RelationshipArtist value)? artist,
    TResult Function(RelationshipAuthor value)? author,
    TResult Function(RelationshipCoverArt value)? cover,
    TResult Function(RelationshipGroup value)? group,
    required TResult orElse(),
  }) {
    if (cover != null) {
      return cover(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RelationshipCoverArtToJson(
      this,
    );
  }
}

abstract class RelationshipCoverArt implements Relationship {
  const factory RelationshipCoverArt(
      {required final String id,
      required final CoverArtAttributes attributes}) = _$RelationshipCoverArt;

  factory RelationshipCoverArt.fromJson(Map<String, dynamic> json) =
      _$RelationshipCoverArt.fromJson;

  @override
  String get id;
  CoverArtAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$RelationshipCoverArtCopyWith<_$RelationshipCoverArt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RelationshipGroupCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$RelationshipGroupCopyWith(
          _$RelationshipGroup value, $Res Function(_$RelationshipGroup) then) =
      __$$RelationshipGroupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, ScanlationGroupAttributes attributes});

  $ScanlationGroupAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$RelationshipGroupCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$RelationshipGroup>
    implements _$$RelationshipGroupCopyWith<$Res> {
  __$$RelationshipGroupCopyWithImpl(
      _$RelationshipGroup _value, $Res Function(_$RelationshipGroup) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_$RelationshipGroup(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as ScanlationGroupAttributes,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ScanlationGroupAttributesCopyWith<$Res> get attributes {
    return $ScanlationGroupAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationshipGroup
    with DiagnosticableTreeMixin
    implements RelationshipGroup {
  const _$RelationshipGroup(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'scanlation_group';

  factory _$RelationshipGroup.fromJson(Map<String, dynamic> json) =>
      _$$RelationshipGroupFromJson(json);

  @override
  final String id;
  @override
  final ScanlationGroupAttributes attributes;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Relationship.group(id: $id, attributes: $attributes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Relationship.group'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationshipGroup &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationshipGroupCopyWith<_$RelationshipGroup> get copyWith =>
      __$$RelationshipGroupCopyWithImpl<_$RelationshipGroup>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id) user,
    required TResult Function(String id, NamedAttributes attributes) artist,
    required TResult Function(String id, NamedAttributes attributes) author,
    required TResult Function(String id, CoverArtAttributes attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return group(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id)? user,
    TResult? Function(String id, NamedAttributes attributes)? artist,
    TResult? Function(String id, NamedAttributes attributes)? author,
    TResult? Function(String id, CoverArtAttributes attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return group?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id)? user,
    TResult Function(String id, NamedAttributes attributes)? artist,
    TResult Function(String id, NamedAttributes attributes)? author,
    TResult Function(String id, CoverArtAttributes attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    required TResult orElse(),
  }) {
    if (group != null) {
      return group(id, attributes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RelationshipManga value) manga,
    required TResult Function(RelationshipUser value) user,
    required TResult Function(RelationshipArtist value) artist,
    required TResult Function(RelationshipAuthor value) author,
    required TResult Function(RelationshipCoverArt value) cover,
    required TResult Function(RelationshipGroup value) group,
  }) {
    return group(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(RelationshipArtist value)? artist,
    TResult? Function(RelationshipAuthor value)? author,
    TResult? Function(RelationshipCoverArt value)? cover,
    TResult? Function(RelationshipGroup value)? group,
  }) {
    return group?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(RelationshipArtist value)? artist,
    TResult Function(RelationshipAuthor value)? author,
    TResult Function(RelationshipCoverArt value)? cover,
    TResult Function(RelationshipGroup value)? group,
    required TResult orElse(),
  }) {
    if (group != null) {
      return group(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RelationshipGroupToJson(
      this,
    );
  }
}

abstract class RelationshipGroup implements Relationship {
  const factory RelationshipGroup(
          {required final String id,
          required final ScanlationGroupAttributes attributes}) =
      _$RelationshipGroup;

  factory RelationshipGroup.fromJson(Map<String, dynamic> json) =
      _$RelationshipGroup.fromJson;

  @override
  String get id;
  ScanlationGroupAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$RelationshipGroupCopyWith<_$RelationshipGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

ChapterAPIData _$ChapterAPIDataFromJson(Map<String, dynamic> json) {
  return _ChapterAPIData.fromJson(json);
}

/// @nodoc
mixin _$ChapterAPIData {
  String get hash => throw _privateConstructorUsedError;
  List<String> get data => throw _privateConstructorUsedError;
  List<String> get dataSaver => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChapterAPIDataCopyWith<ChapterAPIData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterAPIDataCopyWith<$Res> {
  factory $ChapterAPIDataCopyWith(
          ChapterAPIData value, $Res Function(ChapterAPIData) then) =
      _$ChapterAPIDataCopyWithImpl<$Res, ChapterAPIData>;
  @useResult
  $Res call({String hash, List<String> data, List<String> dataSaver});
}

/// @nodoc
class _$ChapterAPIDataCopyWithImpl<$Res, $Val extends ChapterAPIData>
    implements $ChapterAPIDataCopyWith<$Res> {
  _$ChapterAPIDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
    Object? data = null,
    Object? dataSaver = null,
  }) {
    return _then(_value.copyWith(
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dataSaver: null == dataSaver
          ? _value.dataSaver
          : dataSaver // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChapterAPIDataCopyWith<$Res>
    implements $ChapterAPIDataCopyWith<$Res> {
  factory _$$_ChapterAPIDataCopyWith(
          _$_ChapterAPIData value, $Res Function(_$_ChapterAPIData) then) =
      __$$_ChapterAPIDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String hash, List<String> data, List<String> dataSaver});
}

/// @nodoc
class __$$_ChapterAPIDataCopyWithImpl<$Res>
    extends _$ChapterAPIDataCopyWithImpl<$Res, _$_ChapterAPIData>
    implements _$$_ChapterAPIDataCopyWith<$Res> {
  __$$_ChapterAPIDataCopyWithImpl(
      _$_ChapterAPIData _value, $Res Function(_$_ChapterAPIData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
    Object? data = null,
    Object? dataSaver = null,
  }) {
    return _then(_$_ChapterAPIData(
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dataSaver: null == dataSaver
          ? _value._dataSaver
          : dataSaver // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChapterAPIData
    with DiagnosticableTreeMixin
    implements _ChapterAPIData {
  const _$_ChapterAPIData(
      {required this.hash,
      required final List<String> data,
      required final List<String> dataSaver})
      : _data = data,
        _dataSaver = dataSaver;

  factory _$_ChapterAPIData.fromJson(Map<String, dynamic> json) =>
      _$$_ChapterAPIDataFromJson(json);

  @override
  final String hash;
  final List<String> _data;
  @override
  List<String> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  final List<String> _dataSaver;
  @override
  List<String> get dataSaver {
    if (_dataSaver is EqualUnmodifiableListView) return _dataSaver;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dataSaver);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChapterAPIData(hash: $hash, data: $data, dataSaver: $dataSaver)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChapterAPIData'))
      ..add(DiagnosticsProperty('hash', hash))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('dataSaver', dataSaver));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChapterAPIData &&
            (identical(other.hash, hash) || other.hash == hash) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality()
                .equals(other._dataSaver, _dataSaver));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      hash,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_dataSaver));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChapterAPIDataCopyWith<_$_ChapterAPIData> get copyWith =>
      __$$_ChapterAPIDataCopyWithImpl<_$_ChapterAPIData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChapterAPIDataToJson(
      this,
    );
  }
}

abstract class _ChapterAPIData implements ChapterAPIData {
  const factory _ChapterAPIData(
      {required final String hash,
      required final List<String> data,
      required final List<String> dataSaver}) = _$_ChapterAPIData;

  factory _ChapterAPIData.fromJson(Map<String, dynamic> json) =
      _$_ChapterAPIData.fromJson;

  @override
  String get hash;
  @override
  List<String> get data;
  @override
  List<String> get dataSaver;
  @override
  @JsonKey(ignore: true)
  _$$_ChapterAPIDataCopyWith<_$_ChapterAPIData> get copyWith =>
      throw _privateConstructorUsedError;
}

ChapterAPI _$ChapterAPIFromJson(Map<String, dynamic> json) {
  return _ChapterAPI.fromJson(json);
}

/// @nodoc
mixin _$ChapterAPI {
  String get baseUrl => throw _privateConstructorUsedError;
  ChapterAPIData get chapter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChapterAPICopyWith<ChapterAPI> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterAPICopyWith<$Res> {
  factory $ChapterAPICopyWith(
          ChapterAPI value, $Res Function(ChapterAPI) then) =
      _$ChapterAPICopyWithImpl<$Res, ChapterAPI>;
  @useResult
  $Res call({String baseUrl, ChapterAPIData chapter});

  $ChapterAPIDataCopyWith<$Res> get chapter;
}

/// @nodoc
class _$ChapterAPICopyWithImpl<$Res, $Val extends ChapterAPI>
    implements $ChapterAPICopyWith<$Res> {
  _$ChapterAPICopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseUrl = null,
    Object? chapter = null,
  }) {
    return _then(_value.copyWith(
      baseUrl: null == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      chapter: null == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as ChapterAPIData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChapterAPIDataCopyWith<$Res> get chapter {
    return $ChapterAPIDataCopyWith<$Res>(_value.chapter, (value) {
      return _then(_value.copyWith(chapter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChapterAPICopyWith<$Res>
    implements $ChapterAPICopyWith<$Res> {
  factory _$$_ChapterAPICopyWith(
          _$_ChapterAPI value, $Res Function(_$_ChapterAPI) then) =
      __$$_ChapterAPICopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String baseUrl, ChapterAPIData chapter});

  @override
  $ChapterAPIDataCopyWith<$Res> get chapter;
}

/// @nodoc
class __$$_ChapterAPICopyWithImpl<$Res>
    extends _$ChapterAPICopyWithImpl<$Res, _$_ChapterAPI>
    implements _$$_ChapterAPICopyWith<$Res> {
  __$$_ChapterAPICopyWithImpl(
      _$_ChapterAPI _value, $Res Function(_$_ChapterAPI) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseUrl = null,
    Object? chapter = null,
  }) {
    return _then(_$_ChapterAPI(
      baseUrl: null == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      chapter: null == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as ChapterAPIData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChapterAPI extends _ChapterAPI with DiagnosticableTreeMixin {
  const _$_ChapterAPI({required this.baseUrl, required this.chapter})
      : super._();

  factory _$_ChapterAPI.fromJson(Map<String, dynamic> json) =>
      _$$_ChapterAPIFromJson(json);

  @override
  final String baseUrl;
  @override
  final ChapterAPIData chapter;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChapterAPI(baseUrl: $baseUrl, chapter: $chapter)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChapterAPI'))
      ..add(DiagnosticsProperty('baseUrl', baseUrl))
      ..add(DiagnosticsProperty('chapter', chapter));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChapterAPI &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.chapter, chapter) || other.chapter == chapter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, baseUrl, chapter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChapterAPICopyWith<_$_ChapterAPI> get copyWith =>
      __$$_ChapterAPICopyWithImpl<_$_ChapterAPI>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChapterAPIToJson(
      this,
    );
  }
}

abstract class _ChapterAPI extends ChapterAPI {
  const factory _ChapterAPI(
      {required final String baseUrl,
      required final ChapterAPIData chapter}) = _$_ChapterAPI;
  const _ChapterAPI._() : super._();

  factory _ChapterAPI.fromJson(Map<String, dynamic> json) =
      _$_ChapterAPI.fromJson;

  @override
  String get baseUrl;
  @override
  ChapterAPIData get chapter;
  @override
  @JsonKey(ignore: true)
  _$$_ChapterAPICopyWith<_$_ChapterAPI> get copyWith =>
      throw _privateConstructorUsedError;
}

MangaList _$MangaListFromJson(Map<String, dynamic> json) {
  return _MangaList.fromJson(json);
}

/// @nodoc
mixin _$MangaList {
  List<Manga> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaListCopyWith<MangaList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaListCopyWith<$Res> {
  factory $MangaListCopyWith(MangaList value, $Res Function(MangaList) then) =
      _$MangaListCopyWithImpl<$Res, MangaList>;
  @useResult
  $Res call({List<Manga> data, int total});
}

/// @nodoc
class _$MangaListCopyWithImpl<$Res, $Val extends MangaList>
    implements $MangaListCopyWith<$Res> {
  _$MangaListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Manga>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MangaListCopyWith<$Res> implements $MangaListCopyWith<$Res> {
  factory _$$_MangaListCopyWith(
          _$_MangaList value, $Res Function(_$_MangaList) then) =
      __$$_MangaListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Manga> data, int total});
}

/// @nodoc
class __$$_MangaListCopyWithImpl<$Res>
    extends _$MangaListCopyWithImpl<$Res, _$_MangaList>
    implements _$$_MangaListCopyWith<$Res> {
  __$$_MangaListCopyWithImpl(
      _$_MangaList _value, $Res Function(_$_MangaList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$_MangaList(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Manga>,
      null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MangaList with DiagnosticableTreeMixin implements _MangaList {
  const _$_MangaList(final List<Manga> data, this.total) : _data = data;

  factory _$_MangaList.fromJson(Map<String, dynamic> json) =>
      _$$_MangaListFromJson(json);

  final List<Manga> _data;
  @override
  List<Manga> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int total;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaList(data: $data, total: $total)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaList'))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('total', total));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MangaList &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MangaListCopyWith<_$_MangaList> get copyWith =>
      __$$_MangaListCopyWithImpl<_$_MangaList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MangaListToJson(
      this,
    );
  }
}

abstract class _MangaList implements MangaList {
  const factory _MangaList(final List<Manga> data, final int total) =
      _$_MangaList;

  factory _MangaList.fromJson(Map<String, dynamic> json) =
      _$_MangaList.fromJson;

  @override
  List<Manga> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$_MangaListCopyWith<_$_MangaList> get copyWith =>
      throw _privateConstructorUsedError;
}

Manga _$MangaFromJson(Map<String, dynamic> json) {
  return _Manga.fromJson(json);
}

/// @nodoc
mixin _$Manga {
  String get id => throw _privateConstructorUsedError;
  MangaAttributes get attributes => throw _privateConstructorUsedError;
  List<Relationship> get relationships => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaCopyWith<Manga> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaCopyWith<$Res> {
  factory $MangaCopyWith(Manga value, $Res Function(Manga) then) =
      _$MangaCopyWithImpl<$Res, Manga>;
  @useResult
  $Res call(
      {String id,
      MangaAttributes attributes,
      List<Relationship> relationships});

  $MangaAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class _$MangaCopyWithImpl<$Res, $Val extends Manga>
    implements $MangaCopyWith<$Res> {
  _$MangaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
    Object? relationships = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as MangaAttributes,
      relationships: null == relationships
          ? _value.relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as List<Relationship>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MangaAttributesCopyWith<$Res> get attributes {
    return $MangaAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MangaCopyWith<$Res> implements $MangaCopyWith<$Res> {
  factory _$$_MangaCopyWith(_$_Manga value, $Res Function(_$_Manga) then) =
      __$$_MangaCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      MangaAttributes attributes,
      List<Relationship> relationships});

  @override
  $MangaAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$_MangaCopyWithImpl<$Res> extends _$MangaCopyWithImpl<$Res, _$_Manga>
    implements _$$_MangaCopyWith<$Res> {
  __$$_MangaCopyWithImpl(_$_Manga _value, $Res Function(_$_Manga) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
    Object? relationships = null,
  }) {
    return _then(_$_Manga(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as MangaAttributes,
      relationships: null == relationships
          ? _value._relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as List<Relationship>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Manga extends _Manga with DiagnosticableTreeMixin {
  _$_Manga(
      {required this.id,
      required this.attributes,
      required final List<Relationship> relationships})
      : _relationships = relationships,
        super._();

  factory _$_Manga.fromJson(Map<String, dynamic> json) =>
      _$$_MangaFromJson(json);

  @override
  final String id;
  @override
  final MangaAttributes attributes;
  final List<Relationship> _relationships;
  @override
  List<Relationship> get relationships {
    if (_relationships is EqualUnmodifiableListView) return _relationships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relationships);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Manga(id: $id, attributes: $attributes, relationships: $relationships)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Manga'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes))
      ..add(DiagnosticsProperty('relationships', relationships));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Manga &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes) &&
            const DeepCollectionEquality()
                .equals(other._relationships, _relationships));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes,
      const DeepCollectionEquality().hash(_relationships));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MangaCopyWith<_$_Manga> get copyWith =>
      __$$_MangaCopyWithImpl<_$_Manga>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MangaToJson(
      this,
    );
  }
}

abstract class _Manga extends Manga {
  factory _Manga(
      {required final String id,
      required final MangaAttributes attributes,
      required final List<Relationship> relationships}) = _$_Manga;
  _Manga._() : super._();

  factory _Manga.fromJson(Map<String, dynamic> json) = _$_Manga.fromJson;

  @override
  String get id;
  @override
  MangaAttributes get attributes;
  @override
  List<Relationship> get relationships;
  @override
  @JsonKey(ignore: true)
  _$$_MangaCopyWith<_$_Manga> get copyWith =>
      throw _privateConstructorUsedError;
}

MangaAttributes _$MangaAttributesFromJson(Map<String, dynamic> json) {
  return _MangaAttributes.fromJson(json);
}

/// @nodoc
mixin _$MangaAttributes {
  Map<String, String> get title => throw _privateConstructorUsedError;
  List<Map<String, String>> get altTitles => throw _privateConstructorUsedError;
  Map<String, String> get description => throw _privateConstructorUsedError;
  Map<String, String>? get links => throw _privateConstructorUsedError;
  @LanguageConverter()
  Language get originalLanguage => throw _privateConstructorUsedError;
  String? get lastVolume => throw _privateConstructorUsedError;
  String? get lastChapter => throw _privateConstructorUsedError;
  MangaDemographic? get publicationDemographic =>
      throw _privateConstructorUsedError;
  MangaStatus get status => throw _privateConstructorUsedError;
  int? get year => throw _privateConstructorUsedError;
  ContentRating get contentRating => throw _privateConstructorUsedError;
  List<Tag> get tags => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaAttributesCopyWith<MangaAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaAttributesCopyWith<$Res> {
  factory $MangaAttributesCopyWith(
          MangaAttributes value, $Res Function(MangaAttributes) then) =
      _$MangaAttributesCopyWithImpl<$Res, MangaAttributes>;
  @useResult
  $Res call(
      {Map<String, String> title,
      List<Map<String, String>> altTitles,
      Map<String, String> description,
      Map<String, String>? links,
      @LanguageConverter() Language originalLanguage,
      String? lastVolume,
      String? lastChapter,
      MangaDemographic? publicationDemographic,
      MangaStatus status,
      int? year,
      ContentRating contentRating,
      List<Tag> tags,
      int version,
      @TimestampSerializer() DateTime createdAt,
      @TimestampSerializer() DateTime updatedAt});

  $LanguageCopyWith<$Res> get originalLanguage;
}

/// @nodoc
class _$MangaAttributesCopyWithImpl<$Res, $Val extends MangaAttributes>
    implements $MangaAttributesCopyWith<$Res> {
  _$MangaAttributesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? altTitles = null,
    Object? description = null,
    Object? links = freezed,
    Object? originalLanguage = null,
    Object? lastVolume = freezed,
    Object? lastChapter = freezed,
    Object? publicationDemographic = freezed,
    Object? status = null,
    Object? year = freezed,
    Object? contentRating = null,
    Object? tags = null,
    Object? version = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      altTitles: null == altTitles
          ? _value.altTitles
          : altTitles // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      originalLanguage: null == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as Language,
      lastVolume: freezed == lastVolume
          ? _value.lastVolume
          : lastVolume // ignore: cast_nullable_to_non_nullable
              as String?,
      lastChapter: freezed == lastChapter
          ? _value.lastChapter
          : lastChapter // ignore: cast_nullable_to_non_nullable
              as String?,
      publicationDemographic: freezed == publicationDemographic
          ? _value.publicationDemographic
          : publicationDemographic // ignore: cast_nullable_to_non_nullable
              as MangaDemographic?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MangaStatus,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      contentRating: null == contentRating
          ? _value.contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as ContentRating,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LanguageCopyWith<$Res> get originalLanguage {
    return $LanguageCopyWith<$Res>(_value.originalLanguage, (value) {
      return _then(_value.copyWith(originalLanguage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MangaAttributesCopyWith<$Res>
    implements $MangaAttributesCopyWith<$Res> {
  factory _$$_MangaAttributesCopyWith(
          _$_MangaAttributes value, $Res Function(_$_MangaAttributes) then) =
      __$$_MangaAttributesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, String> title,
      List<Map<String, String>> altTitles,
      Map<String, String> description,
      Map<String, String>? links,
      @LanguageConverter() Language originalLanguage,
      String? lastVolume,
      String? lastChapter,
      MangaDemographic? publicationDemographic,
      MangaStatus status,
      int? year,
      ContentRating contentRating,
      List<Tag> tags,
      int version,
      @TimestampSerializer() DateTime createdAt,
      @TimestampSerializer() DateTime updatedAt});

  @override
  $LanguageCopyWith<$Res> get originalLanguage;
}

/// @nodoc
class __$$_MangaAttributesCopyWithImpl<$Res>
    extends _$MangaAttributesCopyWithImpl<$Res, _$_MangaAttributes>
    implements _$$_MangaAttributesCopyWith<$Res> {
  __$$_MangaAttributesCopyWithImpl(
      _$_MangaAttributes _value, $Res Function(_$_MangaAttributes) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? altTitles = null,
    Object? description = null,
    Object? links = freezed,
    Object? originalLanguage = null,
    Object? lastVolume = freezed,
    Object? lastChapter = freezed,
    Object? publicationDemographic = freezed,
    Object? status = null,
    Object? year = freezed,
    Object? contentRating = null,
    Object? tags = null,
    Object? version = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_MangaAttributes(
      title: null == title
          ? _value._title
          : title // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      altTitles: null == altTitles
          ? _value._altTitles
          : altTitles // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
      description: null == description
          ? _value._description
          : description // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      links: freezed == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      originalLanguage: null == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as Language,
      lastVolume: freezed == lastVolume
          ? _value.lastVolume
          : lastVolume // ignore: cast_nullable_to_non_nullable
              as String?,
      lastChapter: freezed == lastChapter
          ? _value.lastChapter
          : lastChapter // ignore: cast_nullable_to_non_nullable
              as String?,
      publicationDemographic: freezed == publicationDemographic
          ? _value.publicationDemographic
          : publicationDemographic // ignore: cast_nullable_to_non_nullable
              as MangaDemographic?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MangaStatus,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      contentRating: null == contentRating
          ? _value.contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as ContentRating,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MangaAttributes
    with DiagnosticableTreeMixin
    implements _MangaAttributes {
  const _$_MangaAttributes(
      {required final Map<String, String> title,
      required final List<Map<String, String>> altTitles,
      required final Map<String, String> description,
      final Map<String, String>? links,
      @LanguageConverter() required this.originalLanguage,
      this.lastVolume,
      this.lastChapter,
      this.publicationDemographic,
      required this.status,
      this.year,
      required this.contentRating,
      required final List<Tag> tags,
      required this.version,
      @TimestampSerializer() required this.createdAt,
      @TimestampSerializer() required this.updatedAt})
      : _title = title,
        _altTitles = altTitles,
        _description = description,
        _links = links,
        _tags = tags;

  factory _$_MangaAttributes.fromJson(Map<String, dynamic> json) =>
      _$$_MangaAttributesFromJson(json);

  final Map<String, String> _title;
  @override
  Map<String, String> get title {
    if (_title is EqualUnmodifiableMapView) return _title;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_title);
  }

  final List<Map<String, String>> _altTitles;
  @override
  List<Map<String, String>> get altTitles {
    if (_altTitles is EqualUnmodifiableListView) return _altTitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_altTitles);
  }

  final Map<String, String> _description;
  @override
  Map<String, String> get description {
    if (_description is EqualUnmodifiableMapView) return _description;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_description);
  }

  final Map<String, String>? _links;
  @override
  Map<String, String>? get links {
    final value = _links;
    if (value == null) return null;
    if (_links is EqualUnmodifiableMapView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @LanguageConverter()
  final Language originalLanguage;
  @override
  final String? lastVolume;
  @override
  final String? lastChapter;
  @override
  final MangaDemographic? publicationDemographic;
  @override
  final MangaStatus status;
  @override
  final int? year;
  @override
  final ContentRating contentRating;
  final List<Tag> _tags;
  @override
  List<Tag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final int version;
  @override
  @TimestampSerializer()
  final DateTime createdAt;
  @override
  @TimestampSerializer()
  final DateTime updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaAttributes(title: $title, altTitles: $altTitles, description: $description, links: $links, originalLanguage: $originalLanguage, lastVolume: $lastVolume, lastChapter: $lastChapter, publicationDemographic: $publicationDemographic, status: $status, year: $year, contentRating: $contentRating, tags: $tags, version: $version, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaAttributes'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('altTitles', altTitles))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('links', links))
      ..add(DiagnosticsProperty('originalLanguage', originalLanguage))
      ..add(DiagnosticsProperty('lastVolume', lastVolume))
      ..add(DiagnosticsProperty('lastChapter', lastChapter))
      ..add(
          DiagnosticsProperty('publicationDemographic', publicationDemographic))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('contentRating', contentRating))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('version', version))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MangaAttributes &&
            const DeepCollectionEquality().equals(other._title, _title) &&
            const DeepCollectionEquality()
                .equals(other._altTitles, _altTitles) &&
            const DeepCollectionEquality()
                .equals(other._description, _description) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            (identical(other.originalLanguage, originalLanguage) ||
                other.originalLanguage == originalLanguage) &&
            (identical(other.lastVolume, lastVolume) ||
                other.lastVolume == lastVolume) &&
            (identical(other.lastChapter, lastChapter) ||
                other.lastChapter == lastChapter) &&
            (identical(other.publicationDemographic, publicationDemographic) ||
                other.publicationDemographic == publicationDemographic) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.contentRating, contentRating) ||
                other.contentRating == contentRating) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_title),
      const DeepCollectionEquality().hash(_altTitles),
      const DeepCollectionEquality().hash(_description),
      const DeepCollectionEquality().hash(_links),
      originalLanguage,
      lastVolume,
      lastChapter,
      publicationDemographic,
      status,
      year,
      contentRating,
      const DeepCollectionEquality().hash(_tags),
      version,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MangaAttributesCopyWith<_$_MangaAttributes> get copyWith =>
      __$$_MangaAttributesCopyWithImpl<_$_MangaAttributes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MangaAttributesToJson(
      this,
    );
  }
}

abstract class _MangaAttributes implements MangaAttributes {
  const factory _MangaAttributes(
          {required final Map<String, String> title,
          required final List<Map<String, String>> altTitles,
          required final Map<String, String> description,
          final Map<String, String>? links,
          @LanguageConverter() required final Language originalLanguage,
          final String? lastVolume,
          final String? lastChapter,
          final MangaDemographic? publicationDemographic,
          required final MangaStatus status,
          final int? year,
          required final ContentRating contentRating,
          required final List<Tag> tags,
          required final int version,
          @TimestampSerializer() required final DateTime createdAt,
          @TimestampSerializer() required final DateTime updatedAt}) =
      _$_MangaAttributes;

  factory _MangaAttributes.fromJson(Map<String, dynamic> json) =
      _$_MangaAttributes.fromJson;

  @override
  Map<String, String> get title;
  @override
  List<Map<String, String>> get altTitles;
  @override
  Map<String, String> get description;
  @override
  Map<String, String>? get links;
  @override
  @LanguageConverter()
  Language get originalLanguage;
  @override
  String? get lastVolume;
  @override
  String? get lastChapter;
  @override
  MangaDemographic? get publicationDemographic;
  @override
  MangaStatus get status;
  @override
  int? get year;
  @override
  ContentRating get contentRating;
  @override
  List<Tag> get tags;
  @override
  int get version;
  @override
  @TimestampSerializer()
  DateTime get createdAt;
  @override
  @TimestampSerializer()
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_MangaAttributesCopyWith<_$_MangaAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

Tag _$TagFromJson(Map<String, dynamic> json) {
  return _Tag.fromJson(json);
}

/// @nodoc
mixin _$Tag {
  String get id => throw _privateConstructorUsedError;
  TagAttributes get attributes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagCopyWith<Tag> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagCopyWith<$Res> {
  factory $TagCopyWith(Tag value, $Res Function(Tag) then) =
      _$TagCopyWithImpl<$Res, Tag>;
  @useResult
  $Res call({String id, TagAttributes attributes});

  $TagAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class _$TagCopyWithImpl<$Res, $Val extends Tag> implements $TagCopyWith<$Res> {
  _$TagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as TagAttributes,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TagAttributesCopyWith<$Res> get attributes {
    return $TagAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TagCopyWith<$Res> implements $TagCopyWith<$Res> {
  factory _$$_TagCopyWith(_$_Tag value, $Res Function(_$_Tag) then) =
      __$$_TagCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, TagAttributes attributes});

  @override
  $TagAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$_TagCopyWithImpl<$Res> extends _$TagCopyWithImpl<$Res, _$_Tag>
    implements _$$_TagCopyWith<$Res> {
  __$$_TagCopyWithImpl(_$_Tag _value, $Res Function(_$_Tag) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_$_Tag(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as TagAttributes,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Tag with DiagnosticableTreeMixin implements _Tag {
  const _$_Tag({required this.id, required this.attributes});

  factory _$_Tag.fromJson(Map<String, dynamic> json) => _$$_TagFromJson(json);

  @override
  final String id;
  @override
  final TagAttributes attributes;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Tag(id: $id, attributes: $attributes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Tag'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Tag &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TagCopyWith<_$_Tag> get copyWith =>
      __$$_TagCopyWithImpl<_$_Tag>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TagToJson(
      this,
    );
  }
}

abstract class _Tag implements Tag {
  const factory _Tag(
      {required final String id,
      required final TagAttributes attributes}) = _$_Tag;

  factory _Tag.fromJson(Map<String, dynamic> json) = _$_Tag.fromJson;

  @override
  String get id;
  @override
  TagAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$_TagCopyWith<_$_Tag> get copyWith => throw _privateConstructorUsedError;
}

TagAttributes _$TagAttributesFromJson(Map<String, dynamic> json) {
  return _TagAttributes.fromJson(json);
}

/// @nodoc
mixin _$TagAttributes {
  Map<String, String> get name => throw _privateConstructorUsedError;
  Map<String, String> get description => throw _privateConstructorUsedError;
  TagGroup get group => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagAttributesCopyWith<TagAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagAttributesCopyWith<$Res> {
  factory $TagAttributesCopyWith(
          TagAttributes value, $Res Function(TagAttributes) then) =
      _$TagAttributesCopyWithImpl<$Res, TagAttributes>;
  @useResult
  $Res call(
      {Map<String, String> name,
      Map<String, String> description,
      TagGroup group});
}

/// @nodoc
class _$TagAttributesCopyWithImpl<$Res, $Val extends TagAttributes>
    implements $TagAttributesCopyWith<$Res> {
  _$TagAttributesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? group = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as TagGroup,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TagAttributesCopyWith<$Res>
    implements $TagAttributesCopyWith<$Res> {
  factory _$$_TagAttributesCopyWith(
          _$_TagAttributes value, $Res Function(_$_TagAttributes) then) =
      __$$_TagAttributesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, String> name,
      Map<String, String> description,
      TagGroup group});
}

/// @nodoc
class __$$_TagAttributesCopyWithImpl<$Res>
    extends _$TagAttributesCopyWithImpl<$Res, _$_TagAttributes>
    implements _$$_TagAttributesCopyWith<$Res> {
  __$$_TagAttributesCopyWithImpl(
      _$_TagAttributes _value, $Res Function(_$_TagAttributes) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? group = null,
  }) {
    return _then(_$_TagAttributes(
      name: null == name
          ? _value._name
          : name // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      description: null == description
          ? _value._description
          : description // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as TagGroup,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TagAttributes with DiagnosticableTreeMixin implements _TagAttributes {
  const _$_TagAttributes(
      {required final Map<String, String> name,
      required final Map<String, String> description,
      required this.group})
      : _name = name,
        _description = description;

  factory _$_TagAttributes.fromJson(Map<String, dynamic> json) =>
      _$$_TagAttributesFromJson(json);

  final Map<String, String> _name;
  @override
  Map<String, String> get name {
    if (_name is EqualUnmodifiableMapView) return _name;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_name);
  }

  final Map<String, String> _description;
  @override
  Map<String, String> get description {
    if (_description is EqualUnmodifiableMapView) return _description;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_description);
  }

  @override
  final TagGroup group;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TagAttributes(name: $name, description: $description, group: $group)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TagAttributes'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('group', group));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TagAttributes &&
            const DeepCollectionEquality().equals(other._name, _name) &&
            const DeepCollectionEquality()
                .equals(other._description, _description) &&
            (identical(other.group, group) || other.group == group));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_name),
      const DeepCollectionEquality().hash(_description),
      group);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TagAttributesCopyWith<_$_TagAttributes> get copyWith =>
      __$$_TagAttributesCopyWithImpl<_$_TagAttributes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TagAttributesToJson(
      this,
    );
  }
}

abstract class _TagAttributes implements TagAttributes {
  const factory _TagAttributes(
      {required final Map<String, String> name,
      required final Map<String, String> description,
      required final TagGroup group}) = _$_TagAttributes;

  factory _TagAttributes.fromJson(Map<String, dynamic> json) =
      _$_TagAttributes.fromJson;

  @override
  Map<String, String> get name;
  @override
  Map<String, String> get description;
  @override
  TagGroup get group;
  @override
  @JsonKey(ignore: true)
  _$$_TagAttributesCopyWith<_$_TagAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

TagResponse _$TagResponseFromJson(Map<String, dynamic> json) {
  return _TagResponse.fromJson(json);
}

/// @nodoc
mixin _$TagResponse {
  List<Tag> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagResponseCopyWith<TagResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagResponseCopyWith<$Res> {
  factory $TagResponseCopyWith(
          TagResponse value, $Res Function(TagResponse) then) =
      _$TagResponseCopyWithImpl<$Res, TagResponse>;
  @useResult
  $Res call({List<Tag> data, int total});
}

/// @nodoc
class _$TagResponseCopyWithImpl<$Res, $Val extends TagResponse>
    implements $TagResponseCopyWith<$Res> {
  _$TagResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TagResponseCopyWith<$Res>
    implements $TagResponseCopyWith<$Res> {
  factory _$$_TagResponseCopyWith(
          _$_TagResponse value, $Res Function(_$_TagResponse) then) =
      __$$_TagResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Tag> data, int total});
}

/// @nodoc
class __$$_TagResponseCopyWithImpl<$Res>
    extends _$TagResponseCopyWithImpl<$Res, _$_TagResponse>
    implements _$$_TagResponseCopyWith<$Res> {
  __$$_TagResponseCopyWithImpl(
      _$_TagResponse _value, $Res Function(_$_TagResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$_TagResponse(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TagResponse with DiagnosticableTreeMixin implements _TagResponse {
  const _$_TagResponse(final List<Tag> data, this.total) : _data = data;

  factory _$_TagResponse.fromJson(Map<String, dynamic> json) =>
      _$$_TagResponseFromJson(json);

  final List<Tag> _data;
  @override
  List<Tag> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int total;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TagResponse(data: $data, total: $total)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TagResponse'))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('total', total));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TagResponse &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TagResponseCopyWith<_$_TagResponse> get copyWith =>
      __$$_TagResponseCopyWithImpl<_$_TagResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TagResponseToJson(
      this,
    );
  }
}

abstract class _TagResponse implements TagResponse {
  const factory _TagResponse(final List<Tag> data, final int total) =
      _$_TagResponse;

  factory _TagResponse.fromJson(Map<String, dynamic> json) =
      _$_TagResponse.fromJson;

  @override
  List<Tag> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$_TagResponseCopyWith<_$_TagResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

OldToken _$OldTokenFromJson(Map<String, dynamic> json) {
  return _OldToken.fromJson(json);
}

/// @nodoc
mixin _$OldToken {
  String get session => throw _privateConstructorUsedError;
  String get refresh => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OldTokenCopyWith<OldToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OldTokenCopyWith<$Res> {
  factory $OldTokenCopyWith(OldToken value, $Res Function(OldToken) then) =
      _$OldTokenCopyWithImpl<$Res, OldToken>;
  @useResult
  $Res call({String session, String refresh});
}

/// @nodoc
class _$OldTokenCopyWithImpl<$Res, $Val extends OldToken>
    implements $OldTokenCopyWith<$Res> {
  _$OldTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? refresh = null,
  }) {
    return _then(_value.copyWith(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as String,
      refresh: null == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OldTokenCopyWith<$Res> implements $OldTokenCopyWith<$Res> {
  factory _$$_OldTokenCopyWith(
          _$_OldToken value, $Res Function(_$_OldToken) then) =
      __$$_OldTokenCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String session, String refresh});
}

/// @nodoc
class __$$_OldTokenCopyWithImpl<$Res>
    extends _$OldTokenCopyWithImpl<$Res, _$_OldToken>
    implements _$$_OldTokenCopyWith<$Res> {
  __$$_OldTokenCopyWithImpl(
      _$_OldToken _value, $Res Function(_$_OldToken) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? refresh = null,
  }) {
    return _then(_$_OldToken(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as String,
      refresh: null == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OldToken extends _OldToken with DiagnosticableTreeMixin {
  _$_OldToken({required this.session, required this.refresh}) : super._();

  factory _$_OldToken.fromJson(Map<String, dynamic> json) =>
      _$$_OldTokenFromJson(json);

  @override
  final String session;
  @override
  final String refresh;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OldToken(session: $session, refresh: $refresh)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OldToken'))
      ..add(DiagnosticsProperty('session', session))
      ..add(DiagnosticsProperty('refresh', refresh));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OldToken &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.refresh, refresh) || other.refresh == refresh));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, session, refresh);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OldTokenCopyWith<_$_OldToken> get copyWith =>
      __$$_OldTokenCopyWithImpl<_$_OldToken>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OldTokenToJson(
      this,
    );
  }
}

abstract class _OldToken extends OldToken {
  factory _OldToken(
      {required final String session,
      required final String refresh}) = _$_OldToken;
  _OldToken._() : super._();

  factory _OldToken.fromJson(Map<String, dynamic> json) = _$_OldToken.fromJson;

  @override
  String get session;
  @override
  String get refresh;
  @override
  @JsonKey(ignore: true)
  _$$_OldTokenCopyWith<_$_OldToken> get copyWith =>
      throw _privateConstructorUsedError;
}
