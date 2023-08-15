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
  String? get volume => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get locale => throw _privateConstructorUsedError;

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
  $Res call(
      {String? volume, String fileName, String? description, String? locale});
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
    Object? volume = freezed,
    Object? fileName = null,
    Object? description = freezed,
    Object? locale = freezed,
  }) {
    return _then(_value.copyWith(
      volume: freezed == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $Res call(
      {String? volume, String fileName, String? description, String? locale});
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
    Object? volume = freezed,
    Object? fileName = null,
    Object? description = freezed,
    Object? locale = freezed,
  }) {
    return _then(_$_CoverArtAttributes(
      volume: freezed == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CoverArtAttributes
    with DiagnosticableTreeMixin
    implements _CoverArtAttributes {
  const _$_CoverArtAttributes(
      {this.volume, required this.fileName, this.description, this.locale});

  factory _$_CoverArtAttributes.fromJson(Map<String, dynamic> json) =>
      _$$_CoverArtAttributesFromJson(json);

  @override
  final String? volume;
  @override
  final String fileName;
  @override
  final String? description;
  @override
  final String? locale;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CoverArtAttributes(volume: $volume, fileName: $fileName, description: $description, locale: $locale)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CoverArtAttributes'))
      ..add(DiagnosticsProperty('volume', volume))
      ..add(DiagnosticsProperty('fileName', fileName))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('locale', locale));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CoverArtAttributes &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.locale, locale) || other.locale == locale));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, volume, fileName, description, locale);

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
  const factory _CoverArtAttributes(
      {final String? volume,
      required final String fileName,
      final String? description,
      final String? locale}) = _$_CoverArtAttributes;

  factory _CoverArtAttributes.fromJson(Map<String, dynamic> json) =
      _$_CoverArtAttributes.fromJson;

  @override
  String? get volume;
  @override
  String get fileName;
  @override
  String? get description;
  @override
  String? get locale;
  @override
  @JsonKey(ignore: true)
  _$$_CoverArtAttributesCopyWith<_$_CoverArtAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

UserAttributes _$UserAttributesFromJson(Map<String, dynamic> json) {
  return _UserAttributes.fromJson(json);
}

/// @nodoc
mixin _$UserAttributes {
  String get username => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserAttributesCopyWith<UserAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAttributesCopyWith<$Res> {
  factory $UserAttributesCopyWith(
          UserAttributes value, $Res Function(UserAttributes) then) =
      _$UserAttributesCopyWithImpl<$Res, UserAttributes>;
  @useResult
  $Res call({String username});
}

/// @nodoc
class _$UserAttributesCopyWithImpl<$Res, $Val extends UserAttributes>
    implements $UserAttributesCopyWith<$Res> {
  _$UserAttributesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserAttributesCopyWith<$Res>
    implements $UserAttributesCopyWith<$Res> {
  factory _$$_UserAttributesCopyWith(
          _$_UserAttributes value, $Res Function(_$_UserAttributes) then) =
      __$$_UserAttributesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username});
}

/// @nodoc
class __$$_UserAttributesCopyWithImpl<$Res>
    extends _$UserAttributesCopyWithImpl<$Res, _$_UserAttributes>
    implements _$$_UserAttributesCopyWith<$Res> {
  __$$_UserAttributesCopyWithImpl(
      _$_UserAttributes _value, $Res Function(_$_UserAttributes) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
  }) {
    return _then(_$_UserAttributes(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserAttributes
    with DiagnosticableTreeMixin
    implements _UserAttributes {
  const _$_UserAttributes({required this.username});

  factory _$_UserAttributes.fromJson(Map<String, dynamic> json) =>
      _$$_UserAttributesFromJson(json);

  @override
  final String username;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserAttributes(username: $username)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserAttributes'))
      ..add(DiagnosticsProperty('username', username));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserAttributes &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserAttributesCopyWith<_$_UserAttributes> get copyWith =>
      __$$_UserAttributesCopyWithImpl<_$_UserAttributes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserAttributesToJson(
      this,
    );
  }
}

abstract class _UserAttributes implements UserAttributes {
  const factory _UserAttributes({required final String username}) =
      _$_UserAttributes;

  factory _UserAttributes.fromJson(Map<String, dynamic> json) =
      _$_UserAttributes.fromJson;

  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$_UserAttributesCopyWith<_$_UserAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthorAttributes _$AuthorAttributesFromJson(Map<String, dynamic> json) {
  return _AuthorAttributes.fromJson(json);
}

/// @nodoc
mixin _$AuthorAttributes {
  String get name => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  Map<String, String> get biography => throw _privateConstructorUsedError;
  String? get twitter => throw _privateConstructorUsedError;
  String? get pixiv => throw _privateConstructorUsedError;
  String? get youtube => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthorAttributesCopyWith<AuthorAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorAttributesCopyWith<$Res> {
  factory $AuthorAttributesCopyWith(
          AuthorAttributes value, $Res Function(AuthorAttributes) then) =
      _$AuthorAttributesCopyWithImpl<$Res, AuthorAttributes>;
  @useResult
  $Res call(
      {String name,
      String? imageUrl,
      Map<String, String> biography,
      String? twitter,
      String? pixiv,
      String? youtube,
      String? website,
      @TimestampSerializer() DateTime createdAt,
      @TimestampSerializer() DateTime updatedAt});
}

/// @nodoc
class _$AuthorAttributesCopyWithImpl<$Res, $Val extends AuthorAttributes>
    implements $AuthorAttributesCopyWith<$Res> {
  _$AuthorAttributesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? imageUrl = freezed,
    Object? biography = null,
    Object? twitter = freezed,
    Object? pixiv = freezed,
    Object? youtube = freezed,
    Object? website = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      biography: null == biography
          ? _value.biography
          : biography // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      twitter: freezed == twitter
          ? _value.twitter
          : twitter // ignore: cast_nullable_to_non_nullable
              as String?,
      pixiv: freezed == pixiv
          ? _value.pixiv
          : pixiv // ignore: cast_nullable_to_non_nullable
              as String?,
      youtube: freezed == youtube
          ? _value.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
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
}

/// @nodoc
abstract class _$$_AuthorAttributesCopyWith<$Res>
    implements $AuthorAttributesCopyWith<$Res> {
  factory _$$_AuthorAttributesCopyWith(
          _$_AuthorAttributes value, $Res Function(_$_AuthorAttributes) then) =
      __$$_AuthorAttributesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? imageUrl,
      Map<String, String> biography,
      String? twitter,
      String? pixiv,
      String? youtube,
      String? website,
      @TimestampSerializer() DateTime createdAt,
      @TimestampSerializer() DateTime updatedAt});
}

/// @nodoc
class __$$_AuthorAttributesCopyWithImpl<$Res>
    extends _$AuthorAttributesCopyWithImpl<$Res, _$_AuthorAttributes>
    implements _$$_AuthorAttributesCopyWith<$Res> {
  __$$_AuthorAttributesCopyWithImpl(
      _$_AuthorAttributes _value, $Res Function(_$_AuthorAttributes) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? imageUrl = freezed,
    Object? biography = null,
    Object? twitter = freezed,
    Object? pixiv = freezed,
    Object? youtube = freezed,
    Object? website = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_AuthorAttributes(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      biography: null == biography
          ? _value._biography
          : biography // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      twitter: freezed == twitter
          ? _value.twitter
          : twitter // ignore: cast_nullable_to_non_nullable
              as String?,
      pixiv: freezed == pixiv
          ? _value.pixiv
          : pixiv // ignore: cast_nullable_to_non_nullable
              as String?,
      youtube: freezed == youtube
          ? _value.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$_AuthorAttributes
    with DiagnosticableTreeMixin
    implements _AuthorAttributes {
  const _$_AuthorAttributes(
      {required this.name,
      this.imageUrl,
      required final Map<String, String> biography,
      this.twitter,
      this.pixiv,
      this.youtube,
      this.website,
      @TimestampSerializer() required this.createdAt,
      @TimestampSerializer() required this.updatedAt})
      : _biography = biography;

  factory _$_AuthorAttributes.fromJson(Map<String, dynamic> json) =>
      _$$_AuthorAttributesFromJson(json);

  @override
  final String name;
  @override
  final String? imageUrl;
  final Map<String, String> _biography;
  @override
  Map<String, String> get biography {
    if (_biography is EqualUnmodifiableMapView) return _biography;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_biography);
  }

  @override
  final String? twitter;
  @override
  final String? pixiv;
  @override
  final String? youtube;
  @override
  final String? website;
  @override
  @TimestampSerializer()
  final DateTime createdAt;
  @override
  @TimestampSerializer()
  final DateTime updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthorAttributes(name: $name, imageUrl: $imageUrl, biography: $biography, twitter: $twitter, pixiv: $pixiv, youtube: $youtube, website: $website, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthorAttributes'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('biography', biography))
      ..add(DiagnosticsProperty('twitter', twitter))
      ..add(DiagnosticsProperty('pixiv', pixiv))
      ..add(DiagnosticsProperty('youtube', youtube))
      ..add(DiagnosticsProperty('website', website))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthorAttributes &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality()
                .equals(other._biography, _biography) &&
            (identical(other.twitter, twitter) || other.twitter == twitter) &&
            (identical(other.pixiv, pixiv) || other.pixiv == pixiv) &&
            (identical(other.youtube, youtube) || other.youtube == youtube) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      imageUrl,
      const DeepCollectionEquality().hash(_biography),
      twitter,
      pixiv,
      youtube,
      website,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthorAttributesCopyWith<_$_AuthorAttributes> get copyWith =>
      __$$_AuthorAttributesCopyWithImpl<_$_AuthorAttributes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthorAttributesToJson(
      this,
    );
  }
}

abstract class _AuthorAttributes implements AuthorAttributes {
  const factory _AuthorAttributes(
          {required final String name,
          final String? imageUrl,
          required final Map<String, String> biography,
          final String? twitter,
          final String? pixiv,
          final String? youtube,
          final String? website,
          @TimestampSerializer() required final DateTime createdAt,
          @TimestampSerializer() required final DateTime updatedAt}) =
      _$_AuthorAttributes;

  factory _AuthorAttributes.fromJson(Map<String, dynamic> json) =
      _$_AuthorAttributes.fromJson;

  @override
  String get name;
  @override
  String? get imageUrl;
  @override
  Map<String, String> get biography;
  @override
  String? get twitter;
  @override
  String? get pixiv;
  @override
  String? get youtube;
  @override
  String? get website;
  @override
  @TimestampSerializer()
  DateTime get createdAt;
  @override
  @TimestampSerializer()
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_AuthorAttributesCopyWith<_$_AuthorAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

Relationship _$RelationshipFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'manga':
      return RelationshipManga.fromJson(json);
    case 'user':
      return RelationshipUser.fromJson(json);
    case 'artist':
      return Artist.fromJson(json);
    case 'author':
      return Author.fromJson(json);
    case 'creator':
      return RelationshipCreator.fromJson(json);
    case 'cover_art':
      return CoverArt.fromJson(json);
    case 'scanlation_group':
      return ScanlationGroup.fromJson(json);

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
    required TResult Function(String id, UserAttributes attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id, UserAttributes attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id, UserAttributes attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RelationshipManga value) manga,
    required TResult Function(RelationshipUser value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(RelationshipCreator value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(ScanlationGroup value) group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(RelationshipCreator value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(ScanlationGroup value)? group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(RelationshipCreator value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(ScanlationGroup value)? group,
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationshipMangaCopyWith<_$RelationshipManga> get copyWith =>
      __$$RelationshipMangaCopyWithImpl<_$RelationshipManga>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return manga(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id, UserAttributes attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return manga?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id, UserAttributes attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
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
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(RelationshipCreator value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(ScanlationGroup value) group,
  }) {
    return manga(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(RelationshipCreator value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(ScanlationGroup value)? group,
  }) {
    return manga?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(RelationshipCreator value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(ScanlationGroup value)? group,
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
  $Res call({String id, UserAttributes attributes});

  $UserAttributesCopyWith<$Res> get attributes;
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
    Object? attributes = null,
  }) {
    return _then(_$RelationshipUser(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as UserAttributes,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserAttributesCopyWith<$Res> get attributes {
    return $UserAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationshipUser
    with DiagnosticableTreeMixin
    implements RelationshipUser {
  const _$RelationshipUser(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'user';

  factory _$RelationshipUser.fromJson(Map<String, dynamic> json) =>
      _$$RelationshipUserFromJson(json);

  @override
  final String id;
  @override
  final UserAttributes attributes;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Relationship.user(id: $id, attributes: $attributes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Relationship.user'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationshipUserCopyWith<_$RelationshipUser> get copyWith =>
      __$$RelationshipUserCopyWithImpl<_$RelationshipUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return user(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id, UserAttributes attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return user?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id, UserAttributes attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(id, attributes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RelationshipManga value) manga,
    required TResult Function(RelationshipUser value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(RelationshipCreator value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(ScanlationGroup value) group,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(RelationshipCreator value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(ScanlationGroup value)? group,
  }) {
    return user?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(RelationshipCreator value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(ScanlationGroup value)? group,
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
  const factory RelationshipUser(
      {required final String id,
      required final UserAttributes attributes}) = _$RelationshipUser;

  factory RelationshipUser.fromJson(Map<String, dynamic> json) =
      _$RelationshipUser.fromJson;

  @override
  String get id;
  UserAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$RelationshipUserCopyWith<_$RelationshipUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ArtistCopyWith<$Res> implements $RelationshipCopyWith<$Res> {
  factory _$$ArtistCopyWith(_$Artist value, $Res Function(_$Artist) then) =
      __$$ArtistCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, AuthorAttributes attributes});

  $AuthorAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$ArtistCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$Artist>
    implements _$$ArtistCopyWith<$Res> {
  __$$ArtistCopyWithImpl(_$Artist _value, $Res Function(_$Artist) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_$Artist(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as AuthorAttributes,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthorAttributesCopyWith<$Res> get attributes {
    return $AuthorAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$Artist with DiagnosticableTreeMixin implements Artist {
  const _$Artist(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'artist';

  factory _$Artist.fromJson(Map<String, dynamic> json) =>
      _$$ArtistFromJson(json);

  @override
  final String id;
  @override
  final AuthorAttributes attributes;

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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtistCopyWith<_$Artist> get copyWith =>
      __$$ArtistCopyWithImpl<_$Artist>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return artist(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id, UserAttributes attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return artist?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id, UserAttributes attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
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
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(RelationshipCreator value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(ScanlationGroup value) group,
  }) {
    return artist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(RelationshipCreator value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(ScanlationGroup value)? group,
  }) {
    return artist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(RelationshipCreator value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(ScanlationGroup value)? group,
    required TResult orElse(),
  }) {
    if (artist != null) {
      return artist(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtistToJson(
      this,
    );
  }
}

abstract class Artist implements Relationship, CreatorType {
  const factory Artist(
      {required final String id,
      required final AuthorAttributes attributes}) = _$Artist;

  factory Artist.fromJson(Map<String, dynamic> json) = _$Artist.fromJson;

  @override
  String get id;
  AuthorAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$ArtistCopyWith<_$Artist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthorCopyWith<$Res> implements $RelationshipCopyWith<$Res> {
  factory _$$AuthorCopyWith(_$Author value, $Res Function(_$Author) then) =
      __$$AuthorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, AuthorAttributes attributes});

  $AuthorAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$AuthorCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$Author>
    implements _$$AuthorCopyWith<$Res> {
  __$$AuthorCopyWithImpl(_$Author _value, $Res Function(_$Author) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_$Author(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as AuthorAttributes,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthorAttributesCopyWith<$Res> get attributes {
    return $AuthorAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$Author with DiagnosticableTreeMixin implements Author {
  const _$Author(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'author';

  factory _$Author.fromJson(Map<String, dynamic> json) =>
      _$$AuthorFromJson(json);

  @override
  final String id;
  @override
  final AuthorAttributes attributes;

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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthorCopyWith<_$Author> get copyWith =>
      __$$AuthorCopyWithImpl<_$Author>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return author(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id, UserAttributes attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return author?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id, UserAttributes attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
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
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(RelationshipCreator value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(ScanlationGroup value) group,
  }) {
    return author(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(RelationshipCreator value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(ScanlationGroup value)? group,
  }) {
    return author?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(RelationshipCreator value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(ScanlationGroup value)? group,
    required TResult orElse(),
  }) {
    if (author != null) {
      return author(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthorToJson(
      this,
    );
  }
}

abstract class Author implements Relationship, CreatorType {
  const factory Author(
      {required final String id,
      required final AuthorAttributes attributes}) = _$Author;

  factory Author.fromJson(Map<String, dynamic> json) = _$Author.fromJson;

  @override
  String get id;
  AuthorAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$AuthorCopyWith<_$Author> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RelationshipCreatorCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$RelationshipCreatorCopyWith(_$RelationshipCreator value,
          $Res Function(_$RelationshipCreator) then) =
      __$$RelationshipCreatorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$RelationshipCreatorCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$RelationshipCreator>
    implements _$$RelationshipCreatorCopyWith<$Res> {
  __$$RelationshipCreatorCopyWithImpl(
      _$RelationshipCreator _value, $Res Function(_$RelationshipCreator) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$RelationshipCreator(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationshipCreator
    with DiagnosticableTreeMixin
    implements RelationshipCreator {
  const _$RelationshipCreator({required this.id, final String? $type})
      : $type = $type ?? 'creator';

  factory _$RelationshipCreator.fromJson(Map<String, dynamic> json) =>
      _$$RelationshipCreatorFromJson(json);

  @override
  final String id;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Relationship.creator(id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Relationship.creator'))
      ..add(DiagnosticsProperty('id', id));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationshipCreatorCopyWith<_$RelationshipCreator> get copyWith =>
      __$$RelationshipCreatorCopyWithImpl<_$RelationshipCreator>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return creator(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id, UserAttributes attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return creator?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id, UserAttributes attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    required TResult orElse(),
  }) {
    if (creator != null) {
      return creator(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RelationshipManga value) manga,
    required TResult Function(RelationshipUser value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(RelationshipCreator value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(ScanlationGroup value) group,
  }) {
    return creator(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(RelationshipCreator value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(ScanlationGroup value)? group,
  }) {
    return creator?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(RelationshipCreator value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(ScanlationGroup value)? group,
    required TResult orElse(),
  }) {
    if (creator != null) {
      return creator(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RelationshipCreatorToJson(
      this,
    );
  }
}

abstract class RelationshipCreator implements Relationship {
  const factory RelationshipCreator({required final String id}) =
      _$RelationshipCreator;

  factory RelationshipCreator.fromJson(Map<String, dynamic> json) =
      _$RelationshipCreator.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$RelationshipCreatorCopyWith<_$RelationshipCreator> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CoverArtCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$CoverArtCopyWith(
          _$CoverArt value, $Res Function(_$CoverArt) then) =
      __$$CoverArtCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, CoverArtAttributes? attributes});

  $CoverArtAttributesCopyWith<$Res>? get attributes;
}

/// @nodoc
class __$$CoverArtCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$CoverArt>
    implements _$$CoverArtCopyWith<$Res> {
  __$$CoverArtCopyWithImpl(_$CoverArt _value, $Res Function(_$CoverArt) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = freezed,
  }) {
    return _then(_$CoverArt(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: freezed == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as CoverArtAttributes?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $CoverArtAttributesCopyWith<$Res>? get attributes {
    if (_value.attributes == null) {
      return null;
    }

    return $CoverArtAttributesCopyWith<$Res>(_value.attributes!, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$CoverArt with DiagnosticableTreeMixin implements CoverArt {
  const _$CoverArt(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'cover_art';

  factory _$CoverArt.fromJson(Map<String, dynamic> json) =>
      _$$CoverArtFromJson(json);

  @override
  final String id;
  @override
  final CoverArtAttributes? attributes;

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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CoverArtCopyWith<_$CoverArt> get copyWith =>
      __$$CoverArtCopyWithImpl<_$CoverArt>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return cover(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id, UserAttributes attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return cover?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id, UserAttributes attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
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
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(RelationshipCreator value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(ScanlationGroup value) group,
  }) {
    return cover(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(RelationshipCreator value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(ScanlationGroup value)? group,
  }) {
    return cover?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(RelationshipCreator value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(ScanlationGroup value)? group,
    required TResult orElse(),
  }) {
    if (cover != null) {
      return cover(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CoverArtToJson(
      this,
    );
  }
}

abstract class CoverArt implements Relationship, Cover {
  const factory CoverArt(
      {required final String id,
      required final CoverArtAttributes? attributes}) = _$CoverArt;

  factory CoverArt.fromJson(Map<String, dynamic> json) = _$CoverArt.fromJson;

  @override
  String get id;
  CoverArtAttributes? get attributes;
  @override
  @JsonKey(ignore: true)
  _$$CoverArtCopyWith<_$CoverArt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ScanlationGroupCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$ScanlationGroupCopyWith(
          _$ScanlationGroup value, $Res Function(_$ScanlationGroup) then) =
      __$$ScanlationGroupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, ScanlationGroupAttributes attributes});

  $ScanlationGroupAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$ScanlationGroupCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$ScanlationGroup>
    implements _$$ScanlationGroupCopyWith<$Res> {
  __$$ScanlationGroupCopyWithImpl(
      _$ScanlationGroup _value, $Res Function(_$ScanlationGroup) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_$ScanlationGroup(
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
class _$ScanlationGroup
    with DiagnosticableTreeMixin
    implements ScanlationGroup {
  const _$ScanlationGroup(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'scanlation_group';

  factory _$ScanlationGroup.fromJson(Map<String, dynamic> json) =>
      _$$ScanlationGroupFromJson(json);

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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanlationGroupCopyWith<_$ScanlationGroup> get copyWith =>
      __$$ScanlationGroupCopyWithImpl<_$ScanlationGroup>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
  }) {
    return group(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? manga,
    TResult? Function(String id, UserAttributes attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
  }) {
    return group?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? manga,
    TResult Function(String id, UserAttributes attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
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
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(RelationshipCreator value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(ScanlationGroup value) group,
  }) {
    return group(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RelationshipManga value)? manga,
    TResult? Function(RelationshipUser value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(RelationshipCreator value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(ScanlationGroup value)? group,
  }) {
    return group?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RelationshipManga value)? manga,
    TResult Function(RelationshipUser value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(RelationshipCreator value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(ScanlationGroup value)? group,
    required TResult orElse(),
  }) {
    if (group != null) {
      return group(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ScanlationGroupToJson(
      this,
    );
  }
}

abstract class ScanlationGroup implements Relationship, Group {
  const factory ScanlationGroup(
      {required final String id,
      required final ScanlationGroupAttributes attributes}) = _$ScanlationGroup;

  factory ScanlationGroup.fromJson(Map<String, dynamic> json) =
      _$ScanlationGroup.fromJson;

  @override
  String get id;
  ScanlationGroupAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$ScanlationGroupCopyWith<_$ScanlationGroup> get copyWith =>
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

CoverList _$CoverListFromJson(Map<String, dynamic> json) {
  return _CoverList.fromJson(json);
}

/// @nodoc
mixin _$CoverList {
  List<CoverArt> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoverListCopyWith<CoverList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoverListCopyWith<$Res> {
  factory $CoverListCopyWith(CoverList value, $Res Function(CoverList) then) =
      _$CoverListCopyWithImpl<$Res, CoverList>;
  @useResult
  $Res call({List<CoverArt> data, int total});
}

/// @nodoc
class _$CoverListCopyWithImpl<$Res, $Val extends CoverList>
    implements $CoverListCopyWith<$Res> {
  _$CoverListCopyWithImpl(this._value, this._then);

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
              as List<CoverArt>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CoverListCopyWith<$Res> implements $CoverListCopyWith<$Res> {
  factory _$$_CoverListCopyWith(
          _$_CoverList value, $Res Function(_$_CoverList) then) =
      __$$_CoverListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CoverArt> data, int total});
}

/// @nodoc
class __$$_CoverListCopyWithImpl<$Res>
    extends _$CoverListCopyWithImpl<$Res, _$_CoverList>
    implements _$$_CoverListCopyWith<$Res> {
  __$$_CoverListCopyWithImpl(
      _$_CoverList _value, $Res Function(_$_CoverList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$_CoverList(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CoverArt>,
      null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CoverList with DiagnosticableTreeMixin implements _CoverList {
  const _$_CoverList(final List<CoverArt> data, this.total) : _data = data;

  factory _$_CoverList.fromJson(Map<String, dynamic> json) =>
      _$$_CoverListFromJson(json);

  final List<CoverArt> _data;
  @override
  List<CoverArt> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int total;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CoverList(data: $data, total: $total)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CoverList'))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('total', total));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CoverList &&
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
  _$$_CoverListCopyWith<_$_CoverList> get copyWith =>
      __$$_CoverListCopyWithImpl<_$_CoverList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CoverListToJson(
      this,
    );
  }
}

abstract class _CoverList implements CoverList {
  const factory _CoverList(final List<CoverArt> data, final int total) =
      _$_CoverList;

  factory _CoverList.fromJson(Map<String, dynamic> json) =
      _$_CoverList.fromJson;

  @override
  List<CoverArt> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$_CoverListCopyWith<_$_CoverList> get copyWith =>
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

GroupList _$GroupListFromJson(Map<String, dynamic> json) {
  return _GroupList.fromJson(json);
}

/// @nodoc
mixin _$GroupList {
  List<ScanlationGroup> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupListCopyWith<GroupList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupListCopyWith<$Res> {
  factory $GroupListCopyWith(GroupList value, $Res Function(GroupList) then) =
      _$GroupListCopyWithImpl<$Res, GroupList>;
  @useResult
  $Res call({List<ScanlationGroup> data, int total});
}

/// @nodoc
class _$GroupListCopyWithImpl<$Res, $Val extends GroupList>
    implements $GroupListCopyWith<$Res> {
  _$GroupListCopyWithImpl(this._value, this._then);

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
              as List<ScanlationGroup>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupListCopyWith<$Res> implements $GroupListCopyWith<$Res> {
  factory _$$_GroupListCopyWith(
          _$_GroupList value, $Res Function(_$_GroupList) then) =
      __$$_GroupListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ScanlationGroup> data, int total});
}

/// @nodoc
class __$$_GroupListCopyWithImpl<$Res>
    extends _$GroupListCopyWithImpl<$Res, _$_GroupList>
    implements _$$_GroupListCopyWith<$Res> {
  __$$_GroupListCopyWithImpl(
      _$_GroupList _value, $Res Function(_$_GroupList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$_GroupList(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ScanlationGroup>,
      null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupList with DiagnosticableTreeMixin implements _GroupList {
  const _$_GroupList(final List<ScanlationGroup> data, this.total)
      : _data = data;

  factory _$_GroupList.fromJson(Map<String, dynamic> json) =>
      _$$_GroupListFromJson(json);

  final List<ScanlationGroup> _data;
  @override
  List<ScanlationGroup> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int total;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GroupList(data: $data, total: $total)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GroupList'))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('total', total));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupList &&
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
  _$$_GroupListCopyWith<_$_GroupList> get copyWith =>
      __$$_GroupListCopyWithImpl<_$_GroupList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupListToJson(
      this,
    );
  }
}

abstract class _GroupList implements GroupList {
  const factory _GroupList(final List<ScanlationGroup> data, final int total) =
      _$_GroupList;

  factory _GroupList.fromJson(Map<String, dynamic> json) =
      _$_GroupList.fromJson;

  @override
  List<ScanlationGroup> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$_GroupListCopyWith<_$_GroupList> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatorList _$CreatorListFromJson(Map<String, dynamic> json) {
  return _CreatorListList.fromJson(json);
}

/// @nodoc
mixin _$CreatorList {
  List<Author> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatorListCopyWith<CreatorList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatorListCopyWith<$Res> {
  factory $CreatorListCopyWith(
          CreatorList value, $Res Function(CreatorList) then) =
      _$CreatorListCopyWithImpl<$Res, CreatorList>;
  @useResult
  $Res call({List<Author> data, int total});
}

/// @nodoc
class _$CreatorListCopyWithImpl<$Res, $Val extends CreatorList>
    implements $CreatorListCopyWith<$Res> {
  _$CreatorListCopyWithImpl(this._value, this._then);

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
              as List<Author>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreatorListListCopyWith<$Res>
    implements $CreatorListCopyWith<$Res> {
  factory _$$_CreatorListListCopyWith(
          _$_CreatorListList value, $Res Function(_$_CreatorListList) then) =
      __$$_CreatorListListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Author> data, int total});
}

/// @nodoc
class __$$_CreatorListListCopyWithImpl<$Res>
    extends _$CreatorListCopyWithImpl<$Res, _$_CreatorListList>
    implements _$$_CreatorListListCopyWith<$Res> {
  __$$_CreatorListListCopyWithImpl(
      _$_CreatorListList _value, $Res Function(_$_CreatorListList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$_CreatorListList(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Author>,
      null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreatorListList
    with DiagnosticableTreeMixin
    implements _CreatorListList {
  const _$_CreatorListList(final List<Author> data, this.total) : _data = data;

  factory _$_CreatorListList.fromJson(Map<String, dynamic> json) =>
      _$$_CreatorListListFromJson(json);

  final List<Author> _data;
  @override
  List<Author> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int total;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreatorList(data: $data, total: $total)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreatorList'))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('total', total));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreatorListList &&
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
  _$$_CreatorListListCopyWith<_$_CreatorListList> get copyWith =>
      __$$_CreatorListListCopyWithImpl<_$_CreatorListList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreatorListListToJson(
      this,
    );
  }
}

abstract class _CreatorListList implements CreatorList {
  const factory _CreatorListList(final List<Author> data, final int total) =
      _$_CreatorListList;

  factory _CreatorListList.fromJson(Map<String, dynamic> json) =
      _$_CreatorListList.fromJson;

  @override
  List<Author> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$_CreatorListListCopyWith<_$_CreatorListList> get copyWith =>
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

MangaLinks _$MangaLinksFromJson(Map<String, dynamic> json) {
  return _MangaLinks.fromJson(json);
}

/// @nodoc
mixin _$MangaLinks {
  String? get raw => throw _privateConstructorUsedError;
  String? get al => throw _privateConstructorUsedError;
  String? get mu => throw _privateConstructorUsedError;
  String? get mal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaLinksCopyWith<MangaLinks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaLinksCopyWith<$Res> {
  factory $MangaLinksCopyWith(
          MangaLinks value, $Res Function(MangaLinks) then) =
      _$MangaLinksCopyWithImpl<$Res, MangaLinks>;
  @useResult
  $Res call({String? raw, String? al, String? mu, String? mal});
}

/// @nodoc
class _$MangaLinksCopyWithImpl<$Res, $Val extends MangaLinks>
    implements $MangaLinksCopyWith<$Res> {
  _$MangaLinksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? raw = freezed,
    Object? al = freezed,
    Object? mu = freezed,
    Object? mal = freezed,
  }) {
    return _then(_value.copyWith(
      raw: freezed == raw
          ? _value.raw
          : raw // ignore: cast_nullable_to_non_nullable
              as String?,
      al: freezed == al
          ? _value.al
          : al // ignore: cast_nullable_to_non_nullable
              as String?,
      mu: freezed == mu
          ? _value.mu
          : mu // ignore: cast_nullable_to_non_nullable
              as String?,
      mal: freezed == mal
          ? _value.mal
          : mal // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MangaLinksCopyWith<$Res>
    implements $MangaLinksCopyWith<$Res> {
  factory _$$_MangaLinksCopyWith(
          _$_MangaLinks value, $Res Function(_$_MangaLinks) then) =
      __$$_MangaLinksCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? raw, String? al, String? mu, String? mal});
}

/// @nodoc
class __$$_MangaLinksCopyWithImpl<$Res>
    extends _$MangaLinksCopyWithImpl<$Res, _$_MangaLinks>
    implements _$$_MangaLinksCopyWith<$Res> {
  __$$_MangaLinksCopyWithImpl(
      _$_MangaLinks _value, $Res Function(_$_MangaLinks) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? raw = freezed,
    Object? al = freezed,
    Object? mu = freezed,
    Object? mal = freezed,
  }) {
    return _then(_$_MangaLinks(
      raw: freezed == raw
          ? _value.raw
          : raw // ignore: cast_nullable_to_non_nullable
              as String?,
      al: freezed == al
          ? _value.al
          : al // ignore: cast_nullable_to_non_nullable
              as String?,
      mu: freezed == mu
          ? _value.mu
          : mu // ignore: cast_nullable_to_non_nullable
              as String?,
      mal: freezed == mal
          ? _value.mal
          : mal // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MangaLinks with DiagnosticableTreeMixin implements _MangaLinks {
  const _$_MangaLinks({this.raw, this.al, this.mu, this.mal});

  factory _$_MangaLinks.fromJson(Map<String, dynamic> json) =>
      _$$_MangaLinksFromJson(json);

  @override
  final String? raw;
  @override
  final String? al;
  @override
  final String? mu;
  @override
  final String? mal;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaLinks(raw: $raw, al: $al, mu: $mu, mal: $mal)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaLinks'))
      ..add(DiagnosticsProperty('raw', raw))
      ..add(DiagnosticsProperty('al', al))
      ..add(DiagnosticsProperty('mu', mu))
      ..add(DiagnosticsProperty('mal', mal));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MangaLinks &&
            (identical(other.raw, raw) || other.raw == raw) &&
            (identical(other.al, al) || other.al == al) &&
            (identical(other.mu, mu) || other.mu == mu) &&
            (identical(other.mal, mal) || other.mal == mal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, raw, al, mu, mal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MangaLinksCopyWith<_$_MangaLinks> get copyWith =>
      __$$_MangaLinksCopyWithImpl<_$_MangaLinks>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MangaLinksToJson(
      this,
    );
  }
}

abstract class _MangaLinks implements MangaLinks {
  const factory _MangaLinks(
      {final String? raw,
      final String? al,
      final String? mu,
      final String? mal}) = _$_MangaLinks;

  factory _MangaLinks.fromJson(Map<String, dynamic> json) =
      _$_MangaLinks.fromJson;

  @override
  String? get raw;
  @override
  String? get al;
  @override
  String? get mu;
  @override
  String? get mal;
  @override
  @JsonKey(ignore: true)
  _$$_MangaLinksCopyWith<_$_MangaLinks> get copyWith =>
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
  MangaLinks? get links => throw _privateConstructorUsedError;
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
      MangaLinks? links,
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

  $MangaLinksCopyWith<$Res>? get links;
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
              as MangaLinks?,
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
  $MangaLinksCopyWith<$Res>? get links {
    if (_value.links == null) {
      return null;
    }

    return $MangaLinksCopyWith<$Res>(_value.links!, (value) {
      return _then(_value.copyWith(links: value) as $Val);
    });
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
      MangaLinks? links,
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
  $MangaLinksCopyWith<$Res>? get links;
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
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as MangaLinks?,
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
      this.links,
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

  @override
  final MangaLinks? links;
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
            (identical(other.links, links) || other.links == links) &&
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
      links,
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
          final MangaLinks? links,
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
  MangaLinks? get links;
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

MangaStatisticsResponse _$MangaStatisticsResponseFromJson(
    Map<String, dynamic> json) {
  return _MangaStatisticsResponse.fromJson(json);
}

/// @nodoc
mixin _$MangaStatisticsResponse {
  Map<String, MangaStatistics> get statistics =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaStatisticsResponseCopyWith<MangaStatisticsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaStatisticsResponseCopyWith<$Res> {
  factory $MangaStatisticsResponseCopyWith(MangaStatisticsResponse value,
          $Res Function(MangaStatisticsResponse) then) =
      _$MangaStatisticsResponseCopyWithImpl<$Res, MangaStatisticsResponse>;
  @useResult
  $Res call({Map<String, MangaStatistics> statistics});
}

/// @nodoc
class _$MangaStatisticsResponseCopyWithImpl<$Res,
        $Val extends MangaStatisticsResponse>
    implements $MangaStatisticsResponseCopyWith<$Res> {
  _$MangaStatisticsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statistics = null,
  }) {
    return _then(_value.copyWith(
      statistics: null == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Map<String, MangaStatistics>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MangaStatisticsResponseCopyWith<$Res>
    implements $MangaStatisticsResponseCopyWith<$Res> {
  factory _$$_MangaStatisticsResponseCopyWith(_$_MangaStatisticsResponse value,
          $Res Function(_$_MangaStatisticsResponse) then) =
      __$$_MangaStatisticsResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, MangaStatistics> statistics});
}

/// @nodoc
class __$$_MangaStatisticsResponseCopyWithImpl<$Res>
    extends _$MangaStatisticsResponseCopyWithImpl<$Res,
        _$_MangaStatisticsResponse>
    implements _$$_MangaStatisticsResponseCopyWith<$Res> {
  __$$_MangaStatisticsResponseCopyWithImpl(_$_MangaStatisticsResponse _value,
      $Res Function(_$_MangaStatisticsResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statistics = null,
  }) {
    return _then(_$_MangaStatisticsResponse(
      null == statistics
          ? _value._statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Map<String, MangaStatistics>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MangaStatisticsResponse
    with DiagnosticableTreeMixin
    implements _MangaStatisticsResponse {
  const _$_MangaStatisticsResponse(
      final Map<String, MangaStatistics> statistics)
      : _statistics = statistics;

  factory _$_MangaStatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$$_MangaStatisticsResponseFromJson(json);

  final Map<String, MangaStatistics> _statistics;
  @override
  Map<String, MangaStatistics> get statistics {
    if (_statistics is EqualUnmodifiableMapView) return _statistics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statistics);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaStatisticsResponse(statistics: $statistics)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaStatisticsResponse'))
      ..add(DiagnosticsProperty('statistics', statistics));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MangaStatisticsResponse &&
            const DeepCollectionEquality()
                .equals(other._statistics, _statistics));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_statistics));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MangaStatisticsResponseCopyWith<_$_MangaStatisticsResponse>
      get copyWith =>
          __$$_MangaStatisticsResponseCopyWithImpl<_$_MangaStatisticsResponse>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MangaStatisticsResponseToJson(
      this,
    );
  }
}

abstract class _MangaStatisticsResponse implements MangaStatisticsResponse {
  const factory _MangaStatisticsResponse(
          final Map<String, MangaStatistics> statistics) =
      _$_MangaStatisticsResponse;

  factory _MangaStatisticsResponse.fromJson(Map<String, dynamic> json) =
      _$_MangaStatisticsResponse.fromJson;

  @override
  Map<String, MangaStatistics> get statistics;
  @override
  @JsonKey(ignore: true)
  _$$_MangaStatisticsResponseCopyWith<_$_MangaStatisticsResponse>
      get copyWith => throw _privateConstructorUsedError;
}

MangaStatistics _$MangaStatisticsFromJson(Map<String, dynamic> json) {
  return _MangaStatistics.fromJson(json);
}

/// @nodoc
mixin _$MangaStatistics {
  StatisticsDetailsComments? get comments => throw _privateConstructorUsedError;
  StatisticsDetailsRating get rating => throw _privateConstructorUsedError;
  int get follows => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaStatisticsCopyWith<MangaStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaStatisticsCopyWith<$Res> {
  factory $MangaStatisticsCopyWith(
          MangaStatistics value, $Res Function(MangaStatistics) then) =
      _$MangaStatisticsCopyWithImpl<$Res, MangaStatistics>;
  @useResult
  $Res call(
      {StatisticsDetailsComments? comments,
      StatisticsDetailsRating rating,
      int follows});

  $StatisticsDetailsCommentsCopyWith<$Res>? get comments;
  $StatisticsDetailsRatingCopyWith<$Res> get rating;
}

/// @nodoc
class _$MangaStatisticsCopyWithImpl<$Res, $Val extends MangaStatistics>
    implements $MangaStatisticsCopyWith<$Res> {
  _$MangaStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = freezed,
    Object? rating = null,
    Object? follows = null,
  }) {
    return _then(_value.copyWith(
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as StatisticsDetailsComments?,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as StatisticsDetailsRating,
      follows: null == follows
          ? _value.follows
          : follows // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StatisticsDetailsCommentsCopyWith<$Res>? get comments {
    if (_value.comments == null) {
      return null;
    }

    return $StatisticsDetailsCommentsCopyWith<$Res>(_value.comments!, (value) {
      return _then(_value.copyWith(comments: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StatisticsDetailsRatingCopyWith<$Res> get rating {
    return $StatisticsDetailsRatingCopyWith<$Res>(_value.rating, (value) {
      return _then(_value.copyWith(rating: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MangaStatisticsCopyWith<$Res>
    implements $MangaStatisticsCopyWith<$Res> {
  factory _$$_MangaStatisticsCopyWith(
          _$_MangaStatistics value, $Res Function(_$_MangaStatistics) then) =
      __$$_MangaStatisticsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StatisticsDetailsComments? comments,
      StatisticsDetailsRating rating,
      int follows});

  @override
  $StatisticsDetailsCommentsCopyWith<$Res>? get comments;
  @override
  $StatisticsDetailsRatingCopyWith<$Res> get rating;
}

/// @nodoc
class __$$_MangaStatisticsCopyWithImpl<$Res>
    extends _$MangaStatisticsCopyWithImpl<$Res, _$_MangaStatistics>
    implements _$$_MangaStatisticsCopyWith<$Res> {
  __$$_MangaStatisticsCopyWithImpl(
      _$_MangaStatistics _value, $Res Function(_$_MangaStatistics) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = freezed,
    Object? rating = null,
    Object? follows = null,
  }) {
    return _then(_$_MangaStatistics(
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as StatisticsDetailsComments?,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as StatisticsDetailsRating,
      follows: null == follows
          ? _value.follows
          : follows // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MangaStatistics
    with DiagnosticableTreeMixin
    implements _MangaStatistics {
  const _$_MangaStatistics(
      {this.comments, required this.rating, required this.follows});

  factory _$_MangaStatistics.fromJson(Map<String, dynamic> json) =>
      _$$_MangaStatisticsFromJson(json);

  @override
  final StatisticsDetailsComments? comments;
  @override
  final StatisticsDetailsRating rating;
  @override
  final int follows;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaStatistics(comments: $comments, rating: $rating, follows: $follows)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaStatistics'))
      ..add(DiagnosticsProperty('comments', comments))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('follows', follows));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MangaStatistics &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.follows, follows) || other.follows == follows));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, comments, rating, follows);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MangaStatisticsCopyWith<_$_MangaStatistics> get copyWith =>
      __$$_MangaStatisticsCopyWithImpl<_$_MangaStatistics>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MangaStatisticsToJson(
      this,
    );
  }
}

abstract class _MangaStatistics implements MangaStatistics {
  const factory _MangaStatistics(
      {final StatisticsDetailsComments? comments,
      required final StatisticsDetailsRating rating,
      required final int follows}) = _$_MangaStatistics;

  factory _MangaStatistics.fromJson(Map<String, dynamic> json) =
      _$_MangaStatistics.fromJson;

  @override
  StatisticsDetailsComments? get comments;
  @override
  StatisticsDetailsRating get rating;
  @override
  int get follows;
  @override
  @JsonKey(ignore: true)
  _$$_MangaStatisticsCopyWith<_$_MangaStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

StatisticsDetailsComments _$StatisticsDetailsCommentsFromJson(
    Map<String, dynamic> json) {
  return _StatisticsDetailsComments.fromJson(json);
}

/// @nodoc
mixin _$StatisticsDetailsComments {
  int get threadId => throw _privateConstructorUsedError;
  int get repliesCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatisticsDetailsCommentsCopyWith<StatisticsDetailsComments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticsDetailsCommentsCopyWith<$Res> {
  factory $StatisticsDetailsCommentsCopyWith(StatisticsDetailsComments value,
          $Res Function(StatisticsDetailsComments) then) =
      _$StatisticsDetailsCommentsCopyWithImpl<$Res, StatisticsDetailsComments>;
  @useResult
  $Res call({int threadId, int repliesCount});
}

/// @nodoc
class _$StatisticsDetailsCommentsCopyWithImpl<$Res,
        $Val extends StatisticsDetailsComments>
    implements $StatisticsDetailsCommentsCopyWith<$Res> {
  _$StatisticsDetailsCommentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadId = null,
    Object? repliesCount = null,
  }) {
    return _then(_value.copyWith(
      threadId: null == threadId
          ? _value.threadId
          : threadId // ignore: cast_nullable_to_non_nullable
              as int,
      repliesCount: null == repliesCount
          ? _value.repliesCount
          : repliesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StatisticsDetailsCommentsCopyWith<$Res>
    implements $StatisticsDetailsCommentsCopyWith<$Res> {
  factory _$$_StatisticsDetailsCommentsCopyWith(
          _$_StatisticsDetailsComments value,
          $Res Function(_$_StatisticsDetailsComments) then) =
      __$$_StatisticsDetailsCommentsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int threadId, int repliesCount});
}

/// @nodoc
class __$$_StatisticsDetailsCommentsCopyWithImpl<$Res>
    extends _$StatisticsDetailsCommentsCopyWithImpl<$Res,
        _$_StatisticsDetailsComments>
    implements _$$_StatisticsDetailsCommentsCopyWith<$Res> {
  __$$_StatisticsDetailsCommentsCopyWithImpl(
      _$_StatisticsDetailsComments _value,
      $Res Function(_$_StatisticsDetailsComments) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadId = null,
    Object? repliesCount = null,
  }) {
    return _then(_$_StatisticsDetailsComments(
      threadId: null == threadId
          ? _value.threadId
          : threadId // ignore: cast_nullable_to_non_nullable
              as int,
      repliesCount: null == repliesCount
          ? _value.repliesCount
          : repliesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StatisticsDetailsComments
    with DiagnosticableTreeMixin
    implements _StatisticsDetailsComments {
  const _$_StatisticsDetailsComments(
      {required this.threadId, required this.repliesCount});

  factory _$_StatisticsDetailsComments.fromJson(Map<String, dynamic> json) =>
      _$$_StatisticsDetailsCommentsFromJson(json);

  @override
  final int threadId;
  @override
  final int repliesCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StatisticsDetailsComments(threadId: $threadId, repliesCount: $repliesCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StatisticsDetailsComments'))
      ..add(DiagnosticsProperty('threadId', threadId))
      ..add(DiagnosticsProperty('repliesCount', repliesCount));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StatisticsDetailsComments &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.repliesCount, repliesCount) ||
                other.repliesCount == repliesCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, threadId, repliesCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StatisticsDetailsCommentsCopyWith<_$_StatisticsDetailsComments>
      get copyWith => __$$_StatisticsDetailsCommentsCopyWithImpl<
          _$_StatisticsDetailsComments>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StatisticsDetailsCommentsToJson(
      this,
    );
  }
}

abstract class _StatisticsDetailsComments implements StatisticsDetailsComments {
  const factory _StatisticsDetailsComments(
      {required final int threadId,
      required final int repliesCount}) = _$_StatisticsDetailsComments;

  factory _StatisticsDetailsComments.fromJson(Map<String, dynamic> json) =
      _$_StatisticsDetailsComments.fromJson;

  @override
  int get threadId;
  @override
  int get repliesCount;
  @override
  @JsonKey(ignore: true)
  _$$_StatisticsDetailsCommentsCopyWith<_$_StatisticsDetailsComments>
      get copyWith => throw _privateConstructorUsedError;
}

StatisticsDetailsRating _$StatisticsDetailsRatingFromJson(
    Map<String, dynamic> json) {
  return _StatisticsDetailsRating.fromJson(json);
}

/// @nodoc
mixin _$StatisticsDetailsRating {
  double? get average => throw _privateConstructorUsedError;
  double get bayesian => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatisticsDetailsRatingCopyWith<StatisticsDetailsRating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticsDetailsRatingCopyWith<$Res> {
  factory $StatisticsDetailsRatingCopyWith(StatisticsDetailsRating value,
          $Res Function(StatisticsDetailsRating) then) =
      _$StatisticsDetailsRatingCopyWithImpl<$Res, StatisticsDetailsRating>;
  @useResult
  $Res call({double? average, double bayesian});
}

/// @nodoc
class _$StatisticsDetailsRatingCopyWithImpl<$Res,
        $Val extends StatisticsDetailsRating>
    implements $StatisticsDetailsRatingCopyWith<$Res> {
  _$StatisticsDetailsRatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? average = freezed,
    Object? bayesian = null,
  }) {
    return _then(_value.copyWith(
      average: freezed == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double?,
      bayesian: null == bayesian
          ? _value.bayesian
          : bayesian // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StatisticsDetailsRatingCopyWith<$Res>
    implements $StatisticsDetailsRatingCopyWith<$Res> {
  factory _$$_StatisticsDetailsRatingCopyWith(_$_StatisticsDetailsRating value,
          $Res Function(_$_StatisticsDetailsRating) then) =
      __$$_StatisticsDetailsRatingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? average, double bayesian});
}

/// @nodoc
class __$$_StatisticsDetailsRatingCopyWithImpl<$Res>
    extends _$StatisticsDetailsRatingCopyWithImpl<$Res,
        _$_StatisticsDetailsRating>
    implements _$$_StatisticsDetailsRatingCopyWith<$Res> {
  __$$_StatisticsDetailsRatingCopyWithImpl(_$_StatisticsDetailsRating _value,
      $Res Function(_$_StatisticsDetailsRating) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? average = freezed,
    Object? bayesian = null,
  }) {
    return _then(_$_StatisticsDetailsRating(
      average: freezed == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double?,
      bayesian: null == bayesian
          ? _value.bayesian
          : bayesian // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StatisticsDetailsRating
    with DiagnosticableTreeMixin
    implements _StatisticsDetailsRating {
  const _$_StatisticsDetailsRating({this.average, required this.bayesian});

  factory _$_StatisticsDetailsRating.fromJson(Map<String, dynamic> json) =>
      _$$_StatisticsDetailsRatingFromJson(json);

  @override
  final double? average;
  @override
  final double bayesian;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StatisticsDetailsRating(average: $average, bayesian: $bayesian)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StatisticsDetailsRating'))
      ..add(DiagnosticsProperty('average', average))
      ..add(DiagnosticsProperty('bayesian', bayesian));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StatisticsDetailsRating &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.bayesian, bayesian) ||
                other.bayesian == bayesian));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, average, bayesian);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StatisticsDetailsRatingCopyWith<_$_StatisticsDetailsRating>
      get copyWith =>
          __$$_StatisticsDetailsRatingCopyWithImpl<_$_StatisticsDetailsRating>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StatisticsDetailsRatingToJson(
      this,
    );
  }
}

abstract class _StatisticsDetailsRating implements StatisticsDetailsRating {
  const factory _StatisticsDetailsRating(
      {final double? average,
      required final double bayesian}) = _$_StatisticsDetailsRating;

  factory _StatisticsDetailsRating.fromJson(Map<String, dynamic> json) =
      _$_StatisticsDetailsRating.fromJson;

  @override
  double? get average;
  @override
  double get bayesian;
  @override
  @JsonKey(ignore: true)
  _$$_StatisticsDetailsRatingCopyWith<_$_StatisticsDetailsRating>
      get copyWith => throw _privateConstructorUsedError;
}

SelfRatingResponse _$SelfRatingResponseFromJson(Map<String, dynamic> json) {
  return _SelfRatingResponse.fromJson(json);
}

/// @nodoc
mixin _$SelfRatingResponse {
  Map<String, SelfRating> get ratings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SelfRatingResponseCopyWith<SelfRatingResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelfRatingResponseCopyWith<$Res> {
  factory $SelfRatingResponseCopyWith(
          SelfRatingResponse value, $Res Function(SelfRatingResponse) then) =
      _$SelfRatingResponseCopyWithImpl<$Res, SelfRatingResponse>;
  @useResult
  $Res call({Map<String, SelfRating> ratings});
}

/// @nodoc
class _$SelfRatingResponseCopyWithImpl<$Res, $Val extends SelfRatingResponse>
    implements $SelfRatingResponseCopyWith<$Res> {
  _$SelfRatingResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ratings = null,
  }) {
    return _then(_value.copyWith(
      ratings: null == ratings
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as Map<String, SelfRating>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SelfRatingResponseCopyWith<$Res>
    implements $SelfRatingResponseCopyWith<$Res> {
  factory _$$_SelfRatingResponseCopyWith(_$_SelfRatingResponse value,
          $Res Function(_$_SelfRatingResponse) then) =
      __$$_SelfRatingResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, SelfRating> ratings});
}

/// @nodoc
class __$$_SelfRatingResponseCopyWithImpl<$Res>
    extends _$SelfRatingResponseCopyWithImpl<$Res, _$_SelfRatingResponse>
    implements _$$_SelfRatingResponseCopyWith<$Res> {
  __$$_SelfRatingResponseCopyWithImpl(
      _$_SelfRatingResponse _value, $Res Function(_$_SelfRatingResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ratings = null,
  }) {
    return _then(_$_SelfRatingResponse(
      null == ratings
          ? _value._ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as Map<String, SelfRating>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SelfRatingResponse
    with DiagnosticableTreeMixin
    implements _SelfRatingResponse {
  const _$_SelfRatingResponse(final Map<String, SelfRating> ratings)
      : _ratings = ratings;

  factory _$_SelfRatingResponse.fromJson(Map<String, dynamic> json) =>
      _$$_SelfRatingResponseFromJson(json);

  final Map<String, SelfRating> _ratings;
  @override
  Map<String, SelfRating> get ratings {
    if (_ratings is EqualUnmodifiableMapView) return _ratings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ratings);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelfRatingResponse(ratings: $ratings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelfRatingResponse'))
      ..add(DiagnosticsProperty('ratings', ratings));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelfRatingResponse &&
            const DeepCollectionEquality().equals(other._ratings, _ratings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_ratings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelfRatingResponseCopyWith<_$_SelfRatingResponse> get copyWith =>
      __$$_SelfRatingResponseCopyWithImpl<_$_SelfRatingResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SelfRatingResponseToJson(
      this,
    );
  }
}

abstract class _SelfRatingResponse implements SelfRatingResponse {
  const factory _SelfRatingResponse(final Map<String, SelfRating> ratings) =
      _$_SelfRatingResponse;

  factory _SelfRatingResponse.fromJson(Map<String, dynamic> json) =
      _$_SelfRatingResponse.fromJson;

  @override
  Map<String, SelfRating> get ratings;
  @override
  @JsonKey(ignore: true)
  _$$_SelfRatingResponseCopyWith<_$_SelfRatingResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

SelfRating _$SelfRatingFromJson(Map<String, dynamic> json) {
  return _SelfRating.fromJson(json);
}

/// @nodoc
mixin _$SelfRating {
  int get rating => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SelfRatingCopyWith<SelfRating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelfRatingCopyWith<$Res> {
  factory $SelfRatingCopyWith(
          SelfRating value, $Res Function(SelfRating) then) =
      _$SelfRatingCopyWithImpl<$Res, SelfRating>;
  @useResult
  $Res call({int rating, @TimestampSerializer() DateTime createdAt});
}

/// @nodoc
class _$SelfRatingCopyWithImpl<$Res, $Val extends SelfRating>
    implements $SelfRatingCopyWith<$Res> {
  _$SelfRatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SelfRatingCopyWith<$Res>
    implements $SelfRatingCopyWith<$Res> {
  factory _$$_SelfRatingCopyWith(
          _$_SelfRating value, $Res Function(_$_SelfRating) then) =
      __$$_SelfRatingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int rating, @TimestampSerializer() DateTime createdAt});
}

/// @nodoc
class __$$_SelfRatingCopyWithImpl<$Res>
    extends _$SelfRatingCopyWithImpl<$Res, _$_SelfRating>
    implements _$$_SelfRatingCopyWith<$Res> {
  __$$_SelfRatingCopyWithImpl(
      _$_SelfRating _value, $Res Function(_$_SelfRating) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
    Object? createdAt = null,
  }) {
    return _then(_$_SelfRating(
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SelfRating extends _SelfRating with DiagnosticableTreeMixin {
  _$_SelfRating(
      {required this.rating, @TimestampSerializer() required this.createdAt})
      : super._();

  factory _$_SelfRating.fromJson(Map<String, dynamic> json) =>
      _$$_SelfRatingFromJson(json);

  @override
  final int rating;
  @override
  @TimestampSerializer()
  final DateTime createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelfRating(rating: $rating, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelfRating'))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelfRating &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, rating, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelfRatingCopyWith<_$_SelfRating> get copyWith =>
      __$$_SelfRatingCopyWithImpl<_$_SelfRating>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SelfRatingToJson(
      this,
    );
  }
}

abstract class _SelfRating extends SelfRating {
  factory _SelfRating(
          {required final int rating,
          @TimestampSerializer() required final DateTime createdAt}) =
      _$_SelfRating;
  _SelfRating._() : super._();

  factory _SelfRating.fromJson(Map<String, dynamic> json) =
      _$_SelfRating.fromJson;

  @override
  int get rating;
  @override
  @TimestampSerializer()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_SelfRatingCopyWith<_$_SelfRating> get copyWith =>
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
