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
abstract class _$$MangaFiltersImplCopyWith<$Res>
    implements $MangaFiltersCopyWith<$Res> {
  factory _$$MangaFiltersImplCopyWith(
          _$MangaFiltersImpl value, $Res Function(_$MangaFiltersImpl) then) =
      __$$MangaFiltersImplCopyWithImpl<$Res>;
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
class __$$MangaFiltersImplCopyWithImpl<$Res>
    extends _$MangaFiltersCopyWithImpl<$Res, _$MangaFiltersImpl>
    implements _$$MangaFiltersImplCopyWith<$Res> {
  __$$MangaFiltersImplCopyWithImpl(
      _$MangaFiltersImpl _value, $Res Function(_$MangaFiltersImpl) _then)
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
    return _then(_$MangaFiltersImpl(
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
class _$MangaFiltersImpl extends _MangaFilters with DiagnosticableTreeMixin {
  const _$MangaFiltersImpl(
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

  factory _$MangaFiltersImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaFiltersImplFromJson(json);

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
            other is _$MangaFiltersImpl &&
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
  _$$MangaFiltersImplCopyWith<_$MangaFiltersImpl> get copyWith =>
      __$$MangaFiltersImplCopyWithImpl<_$MangaFiltersImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaFiltersImplToJson(
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
      final FilterOrder order}) = _$MangaFiltersImpl;
  const _MangaFilters._() : super._();

  factory _MangaFilters.fromJson(Map<String, dynamic> json) =
      _$MangaFiltersImpl.fromJson;

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
  _$$MangaFiltersImplCopyWith<_$MangaFiltersImpl> get copyWith =>
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
abstract class _$$MangaSearchParametersImplCopyWith<$Res>
    implements $MangaSearchParametersCopyWith<$Res> {
  factory _$$MangaSearchParametersImplCopyWith(
          _$MangaSearchParametersImpl value,
          $Res Function(_$MangaSearchParametersImpl) then) =
      __$$MangaSearchParametersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String query, MangaFilters filter});

  @override
  $MangaFiltersCopyWith<$Res> get filter;
}

/// @nodoc
class __$$MangaSearchParametersImplCopyWithImpl<$Res>
    extends _$MangaSearchParametersCopyWithImpl<$Res,
        _$MangaSearchParametersImpl>
    implements _$$MangaSearchParametersImplCopyWith<$Res> {
  __$$MangaSearchParametersImplCopyWithImpl(_$MangaSearchParametersImpl _value,
      $Res Function(_$MangaSearchParametersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? filter = null,
  }) {
    return _then(_$MangaSearchParametersImpl(
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

class _$MangaSearchParametersImpl
    with DiagnosticableTreeMixin
    implements _MangaSearchParameters {
  const _$MangaSearchParametersImpl(
      {required this.query, required this.filter});

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
            other is _$MangaSearchParametersImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, filter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaSearchParametersImplCopyWith<_$MangaSearchParametersImpl>
      get copyWith => __$$MangaSearchParametersImplCopyWithImpl<
          _$MangaSearchParametersImpl>(this, _$identity);
}

abstract class _MangaSearchParameters implements MangaSearchParameters {
  const factory _MangaSearchParameters(
      {required final String query,
      required final MangaFilters filter}) = _$MangaSearchParametersImpl;

  @override
  String get query;
  @override
  MangaFilters get filter;
  @override
  @JsonKey(ignore: true)
  _$$MangaSearchParametersImplCopyWith<_$MangaSearchParametersImpl>
      get copyWith => throw _privateConstructorUsedError;
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
abstract class _$$LanguageImplCopyWith<$Res>
    implements $LanguageCopyWith<$Res> {
  factory _$$LanguageImplCopyWith(
          _$LanguageImpl value, $Res Function(_$LanguageImpl) then) =
      __$$LanguageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String code, String flag});
}

/// @nodoc
class __$$LanguageImplCopyWithImpl<$Res>
    extends _$LanguageCopyWithImpl<$Res, _$LanguageImpl>
    implements _$$LanguageImplCopyWith<$Res> {
  __$$LanguageImplCopyWithImpl(
      _$LanguageImpl _value, $Res Function(_$LanguageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? flag = null,
  }) {
    return _then(_$LanguageImpl(
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

class _$LanguageImpl with DiagnosticableTreeMixin implements _Language {
  const _$LanguageImpl(
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
            other is _$LanguageImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.flag, flag) || other.flag == flag));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, code, flag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageImplCopyWith<_$LanguageImpl> get copyWith =>
      __$$LanguageImplCopyWithImpl<_$LanguageImpl>(this, _$identity);
}

abstract class _Language implements Language {
  const factory _Language(
      {required final String name,
      required final String code,
      required final String flag}) = _$LanguageImpl;

  @override
  String get name;
  @override
  String get code;
  @override
  String get flag;
  @override
  @JsonKey(ignore: true)
  _$$LanguageImplCopyWith<_$LanguageImpl> get copyWith =>
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
abstract class _$$ChapterListImplCopyWith<$Res>
    implements $ChapterListCopyWith<$Res> {
  factory _$$ChapterListImplCopyWith(
          _$ChapterListImpl value, $Res Function(_$ChapterListImpl) then) =
      __$$ChapterListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Chapter> data, int total});
}

/// @nodoc
class __$$ChapterListImplCopyWithImpl<$Res>
    extends _$ChapterListCopyWithImpl<$Res, _$ChapterListImpl>
    implements _$$ChapterListImplCopyWith<$Res> {
  __$$ChapterListImplCopyWithImpl(
      _$ChapterListImpl _value, $Res Function(_$ChapterListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$ChapterListImpl(
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
class _$ChapterListImpl with DiagnosticableTreeMixin implements _ChapterList {
  const _$ChapterListImpl(final List<Chapter> data, this.total) : _data = data;

  factory _$ChapterListImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterListImplFromJson(json);

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
            other is _$ChapterListImpl &&
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
  _$$ChapterListImplCopyWith<_$ChapterListImpl> get copyWith =>
      __$$ChapterListImplCopyWithImpl<_$ChapterListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterListImplToJson(
      this,
    );
  }
}

abstract class _ChapterList implements ChapterList {
  const factory _ChapterList(final List<Chapter> data, final int total) =
      _$ChapterListImpl;

  factory _ChapterList.fromJson(Map<String, dynamic> json) =
      _$ChapterListImpl.fromJson;

  @override
  List<Chapter> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$ChapterListImplCopyWith<_$ChapterListImpl> get copyWith =>
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
abstract class _$$ChapterImplCopyWith<$Res> implements $ChapterCopyWith<$Res> {
  factory _$$ChapterImplCopyWith(
          _$ChapterImpl value, $Res Function(_$ChapterImpl) then) =
      __$$ChapterImplCopyWithImpl<$Res>;
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
class __$$ChapterImplCopyWithImpl<$Res>
    extends _$ChapterCopyWithImpl<$Res, _$ChapterImpl>
    implements _$$ChapterImplCopyWith<$Res> {
  __$$ChapterImplCopyWithImpl(
      _$ChapterImpl _value, $Res Function(_$ChapterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
    Object? relationships = null,
  }) {
    return _then(_$ChapterImpl(
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
class _$ChapterImpl extends _Chapter with DiagnosticableTreeMixin {
  const _$ChapterImpl(
      {required this.id,
      required this.attributes,
      required final List<Relationship> relationships})
      : _relationships = relationships,
        super._();

  factory _$ChapterImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterImplFromJson(json);

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
            other is _$ChapterImpl &&
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
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
      __$$ChapterImplCopyWithImpl<_$ChapterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterImplToJson(
      this,
    );
  }
}

abstract class _Chapter extends Chapter {
  const factory _Chapter(
      {required final String id,
      required final ChapterAttributes attributes,
      required final List<Relationship> relationships}) = _$ChapterImpl;
  const _Chapter._() : super._();

  factory _Chapter.fromJson(Map<String, dynamic> json) = _$ChapterImpl.fromJson;

  @override
  String get id;
  @override
  ChapterAttributes get attributes;
  @override
  List<Relationship> get relationships;
  @override
  @JsonKey(ignore: true)
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
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
abstract class _$$ChapterAttributesImplCopyWith<$Res>
    implements $ChapterAttributesCopyWith<$Res> {
  factory _$$ChapterAttributesImplCopyWith(_$ChapterAttributesImpl value,
          $Res Function(_$ChapterAttributesImpl) then) =
      __$$ChapterAttributesImplCopyWithImpl<$Res>;
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
class __$$ChapterAttributesImplCopyWithImpl<$Res>
    extends _$ChapterAttributesCopyWithImpl<$Res, _$ChapterAttributesImpl>
    implements _$$ChapterAttributesImplCopyWith<$Res> {
  __$$ChapterAttributesImplCopyWithImpl(_$ChapterAttributesImpl _value,
      $Res Function(_$ChapterAttributesImpl) _then)
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
    return _then(_$ChapterAttributesImpl(
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
class _$ChapterAttributesImpl
    with DiagnosticableTreeMixin
    implements _ChapterAttributes {
  const _$ChapterAttributesImpl(
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

  factory _$ChapterAttributesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterAttributesImplFromJson(json);

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
            other is _$ChapterAttributesImpl &&
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
  _$$ChapterAttributesImplCopyWith<_$ChapterAttributesImpl> get copyWith =>
      __$$ChapterAttributesImplCopyWithImpl<_$ChapterAttributesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterAttributesImplToJson(
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
      _$ChapterAttributesImpl;

  factory _ChapterAttributes.fromJson(Map<String, dynamic> json) =
      _$ChapterAttributesImpl.fromJson;

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
  _$$ChapterAttributesImplCopyWith<_$ChapterAttributesImpl> get copyWith =>
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
abstract class _$$ScanlationGroupAttributesImplCopyWith<$Res>
    implements $ScanlationGroupAttributesCopyWith<$Res> {
  factory _$$ScanlationGroupAttributesImplCopyWith(
          _$ScanlationGroupAttributesImpl value,
          $Res Function(_$ScanlationGroupAttributesImpl) then) =
      __$$ScanlationGroupAttributesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String? website, String? discord, String? description});
}

/// @nodoc
class __$$ScanlationGroupAttributesImplCopyWithImpl<$Res>
    extends _$ScanlationGroupAttributesCopyWithImpl<$Res,
        _$ScanlationGroupAttributesImpl>
    implements _$$ScanlationGroupAttributesImplCopyWith<$Res> {
  __$$ScanlationGroupAttributesImplCopyWithImpl(
      _$ScanlationGroupAttributesImpl _value,
      $Res Function(_$ScanlationGroupAttributesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? website = freezed,
    Object? discord = freezed,
    Object? description = freezed,
  }) {
    return _then(_$ScanlationGroupAttributesImpl(
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
class _$ScanlationGroupAttributesImpl
    with DiagnosticableTreeMixin
    implements _ScanlationGroupAttributes {
  const _$ScanlationGroupAttributesImpl(
      {required this.name, this.website, this.discord, this.description});

  factory _$ScanlationGroupAttributesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanlationGroupAttributesImplFromJson(json);

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
            other is _$ScanlationGroupAttributesImpl &&
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
  _$$ScanlationGroupAttributesImplCopyWith<_$ScanlationGroupAttributesImpl>
      get copyWith => __$$ScanlationGroupAttributesImplCopyWithImpl<
          _$ScanlationGroupAttributesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScanlationGroupAttributesImplToJson(
      this,
    );
  }
}

abstract class _ScanlationGroupAttributes implements ScanlationGroupAttributes {
  const factory _ScanlationGroupAttributes(
      {required final String name,
      final String? website,
      final String? discord,
      final String? description}) = _$ScanlationGroupAttributesImpl;

  factory _ScanlationGroupAttributes.fromJson(Map<String, dynamic> json) =
      _$ScanlationGroupAttributesImpl.fromJson;

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
  _$$ScanlationGroupAttributesImplCopyWith<_$ScanlationGroupAttributesImpl>
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
abstract class _$$CoverArtAttributesImplCopyWith<$Res>
    implements $CoverArtAttributesCopyWith<$Res> {
  factory _$$CoverArtAttributesImplCopyWith(_$CoverArtAttributesImpl value,
          $Res Function(_$CoverArtAttributesImpl) then) =
      __$$CoverArtAttributesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? volume, String fileName, String? description, String? locale});
}

/// @nodoc
class __$$CoverArtAttributesImplCopyWithImpl<$Res>
    extends _$CoverArtAttributesCopyWithImpl<$Res, _$CoverArtAttributesImpl>
    implements _$$CoverArtAttributesImplCopyWith<$Res> {
  __$$CoverArtAttributesImplCopyWithImpl(_$CoverArtAttributesImpl _value,
      $Res Function(_$CoverArtAttributesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? volume = freezed,
    Object? fileName = null,
    Object? description = freezed,
    Object? locale = freezed,
  }) {
    return _then(_$CoverArtAttributesImpl(
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
class _$CoverArtAttributesImpl
    with DiagnosticableTreeMixin
    implements _CoverArtAttributes {
  const _$CoverArtAttributesImpl(
      {this.volume, required this.fileName, this.description, this.locale});

  factory _$CoverArtAttributesImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoverArtAttributesImplFromJson(json);

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
            other is _$CoverArtAttributesImpl &&
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
  _$$CoverArtAttributesImplCopyWith<_$CoverArtAttributesImpl> get copyWith =>
      __$$CoverArtAttributesImplCopyWithImpl<_$CoverArtAttributesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoverArtAttributesImplToJson(
      this,
    );
  }
}

abstract class _CoverArtAttributes implements CoverArtAttributes {
  const factory _CoverArtAttributes(
      {final String? volume,
      required final String fileName,
      final String? description,
      final String? locale}) = _$CoverArtAttributesImpl;

  factory _CoverArtAttributes.fromJson(Map<String, dynamic> json) =
      _$CoverArtAttributesImpl.fromJson;

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
  _$$CoverArtAttributesImplCopyWith<_$CoverArtAttributesImpl> get copyWith =>
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
abstract class _$$UserAttributesImplCopyWith<$Res>
    implements $UserAttributesCopyWith<$Res> {
  factory _$$UserAttributesImplCopyWith(_$UserAttributesImpl value,
          $Res Function(_$UserAttributesImpl) then) =
      __$$UserAttributesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username});
}

/// @nodoc
class __$$UserAttributesImplCopyWithImpl<$Res>
    extends _$UserAttributesCopyWithImpl<$Res, _$UserAttributesImpl>
    implements _$$UserAttributesImplCopyWith<$Res> {
  __$$UserAttributesImplCopyWithImpl(
      _$UserAttributesImpl _value, $Res Function(_$UserAttributesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
  }) {
    return _then(_$UserAttributesImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAttributesImpl
    with DiagnosticableTreeMixin
    implements _UserAttributes {
  const _$UserAttributesImpl({required this.username});

  factory _$UserAttributesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAttributesImplFromJson(json);

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
            other is _$UserAttributesImpl &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAttributesImplCopyWith<_$UserAttributesImpl> get copyWith =>
      __$$UserAttributesImplCopyWithImpl<_$UserAttributesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAttributesImplToJson(
      this,
    );
  }
}

abstract class _UserAttributes implements UserAttributes {
  const factory _UserAttributes({required final String username}) =
      _$UserAttributesImpl;

  factory _UserAttributes.fromJson(Map<String, dynamic> json) =
      _$UserAttributesImpl.fromJson;

  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$UserAttributesImplCopyWith<_$UserAttributesImpl> get copyWith =>
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
abstract class _$$AuthorAttributesImplCopyWith<$Res>
    implements $AuthorAttributesCopyWith<$Res> {
  factory _$$AuthorAttributesImplCopyWith(_$AuthorAttributesImpl value,
          $Res Function(_$AuthorAttributesImpl) then) =
      __$$AuthorAttributesImplCopyWithImpl<$Res>;
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
class __$$AuthorAttributesImplCopyWithImpl<$Res>
    extends _$AuthorAttributesCopyWithImpl<$Res, _$AuthorAttributesImpl>
    implements _$$AuthorAttributesImplCopyWith<$Res> {
  __$$AuthorAttributesImplCopyWithImpl(_$AuthorAttributesImpl _value,
      $Res Function(_$AuthorAttributesImpl) _then)
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
    return _then(_$AuthorAttributesImpl(
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
class _$AuthorAttributesImpl
    with DiagnosticableTreeMixin
    implements _AuthorAttributes {
  const _$AuthorAttributesImpl(
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

  factory _$AuthorAttributesImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthorAttributesImplFromJson(json);

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
            other is _$AuthorAttributesImpl &&
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
  _$$AuthorAttributesImplCopyWith<_$AuthorAttributesImpl> get copyWith =>
      __$$AuthorAttributesImplCopyWithImpl<_$AuthorAttributesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthorAttributesImplToJson(
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
      _$AuthorAttributesImpl;

  factory _AuthorAttributes.fromJson(Map<String, dynamic> json) =
      _$AuthorAttributesImpl.fromJson;

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
  _$$AuthorAttributesImplCopyWith<_$AuthorAttributesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Relationship _$RelationshipFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'manga':
      return MangaID.fromJson(json);
    case 'user':
      return User.fromJson(json);
    case 'artist':
      return Artist.fromJson(json);
    case 'author':
      return Author.fromJson(json);
    case 'creator':
      return CreatorID.fromJson(json);
    case 'cover_art':
      return CoverArt.fromJson(json);
    case 'scanlation_group':
      return Group.fromJson(json);

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
    required TResult Function(String id, UserAttributes? attributes) user,
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
    TResult? Function(String id, UserAttributes? attributes)? user,
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
    TResult Function(String id, UserAttributes? attributes)? user,
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
    required TResult Function(MangaID value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MangaID value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MangaID value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
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
abstract class _$$MangaIDImplCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$MangaIDImplCopyWith(
          _$MangaIDImpl value, $Res Function(_$MangaIDImpl) then) =
      __$$MangaIDImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$MangaIDImplCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$MangaIDImpl>
    implements _$$MangaIDImplCopyWith<$Res> {
  __$$MangaIDImplCopyWithImpl(
      _$MangaIDImpl _value, $Res Function(_$MangaIDImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$MangaIDImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaIDImpl with DiagnosticableTreeMixin implements MangaID {
  const _$MangaIDImpl({required this.id, final String? $type})
      : $type = $type ?? 'manga';

  factory _$MangaIDImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaIDImplFromJson(json);

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
            other is _$MangaIDImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaIDImplCopyWith<_$MangaIDImpl> get copyWith =>
      __$$MangaIDImplCopyWithImpl<_$MangaIDImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes? attributes) user,
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
    TResult? Function(String id, UserAttributes? attributes)? user,
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
    TResult Function(String id, UserAttributes? attributes)? user,
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
    required TResult Function(MangaID value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
  }) {
    return manga(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MangaID value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
  }) {
    return manga?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MangaID value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    required TResult orElse(),
  }) {
    if (manga != null) {
      return manga(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaIDImplToJson(
      this,
    );
  }
}

abstract class MangaID implements Relationship {
  const factory MangaID({required final String id}) = _$MangaIDImpl;

  factory MangaID.fromJson(Map<String, dynamic> json) = _$MangaIDImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$MangaIDImplCopyWith<_$MangaIDImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, UserAttributes? attributes});

  $UserAttributesCopyWith<$Res>? get attributes;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: freezed == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as UserAttributes?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserAttributesCopyWith<$Res>? get attributes {
    if (_value.attributes == null) {
      return null;
    }

    return $UserAttributesCopyWith<$Res>(_value.attributes!, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl with DiagnosticableTreeMixin implements User {
  const _$UserImpl(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'user';

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final UserAttributes? attributes;

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

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
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
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes? attributes) user,
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
    TResult? Function(String id, UserAttributes? attributes)? user,
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
    TResult Function(String id, UserAttributes? attributes)? user,
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
    required TResult Function(MangaID value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MangaID value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
  }) {
    return user?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MangaID value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class User implements Relationship {
  const factory User(
      {required final String id,
      required final UserAttributes? attributes}) = _$UserImpl;

  factory User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  UserAttributes? get attributes;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ArtistImplCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$ArtistImplCopyWith(
          _$ArtistImpl value, $Res Function(_$ArtistImpl) then) =
      __$$ArtistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, AuthorAttributes attributes});

  $AuthorAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$ArtistImplCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$ArtistImpl>
    implements _$$ArtistImplCopyWith<$Res> {
  __$$ArtistImplCopyWithImpl(
      _$ArtistImpl _value, $Res Function(_$ArtistImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_$ArtistImpl(
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
class _$ArtistImpl with DiagnosticableTreeMixin implements Artist {
  const _$ArtistImpl(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'artist';

  factory _$ArtistImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtistImplFromJson(json);

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

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtistImpl &&
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
  _$$ArtistImplCopyWith<_$ArtistImpl> get copyWith =>
      __$$ArtistImplCopyWithImpl<_$ArtistImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes? attributes) user,
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
    TResult? Function(String id, UserAttributes? attributes)? user,
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
    TResult Function(String id, UserAttributes? attributes)? user,
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
    required TResult Function(MangaID value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
  }) {
    return artist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MangaID value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
  }) {
    return artist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MangaID value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    required TResult orElse(),
  }) {
    if (artist != null) {
      return artist(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtistImplToJson(
      this,
    );
  }
}

abstract class Artist implements Relationship, CreatorType {
  const factory Artist(
      {required final String id,
      required final AuthorAttributes attributes}) = _$ArtistImpl;

  factory Artist.fromJson(Map<String, dynamic> json) = _$ArtistImpl.fromJson;

  @override
  String get id;
  AuthorAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$ArtistImplCopyWith<_$ArtistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthorImplCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$AuthorImplCopyWith(
          _$AuthorImpl value, $Res Function(_$AuthorImpl) then) =
      __$$AuthorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, AuthorAttributes attributes});

  $AuthorAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$AuthorImplCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$AuthorImpl>
    implements _$$AuthorImplCopyWith<$Res> {
  __$$AuthorImplCopyWithImpl(
      _$AuthorImpl _value, $Res Function(_$AuthorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_$AuthorImpl(
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
class _$AuthorImpl with DiagnosticableTreeMixin implements Author {
  const _$AuthorImpl(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'author';

  factory _$AuthorImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthorImplFromJson(json);

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

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorImpl &&
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
  _$$AuthorImplCopyWith<_$AuthorImpl> get copyWith =>
      __$$AuthorImplCopyWithImpl<_$AuthorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes? attributes) user,
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
    TResult? Function(String id, UserAttributes? attributes)? user,
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
    TResult Function(String id, UserAttributes? attributes)? user,
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
    required TResult Function(MangaID value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
  }) {
    return author(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MangaID value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
  }) {
    return author?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MangaID value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    required TResult orElse(),
  }) {
    if (author != null) {
      return author(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthorImplToJson(
      this,
    );
  }
}

abstract class Author implements Relationship, CreatorType {
  const factory Author(
      {required final String id,
      required final AuthorAttributes attributes}) = _$AuthorImpl;

  factory Author.fromJson(Map<String, dynamic> json) = _$AuthorImpl.fromJson;

  @override
  String get id;
  AuthorAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$AuthorImplCopyWith<_$AuthorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreatorIDImplCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$CreatorIDImplCopyWith(
          _$CreatorIDImpl value, $Res Function(_$CreatorIDImpl) then) =
      __$$CreatorIDImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$CreatorIDImplCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$CreatorIDImpl>
    implements _$$CreatorIDImplCopyWith<$Res> {
  __$$CreatorIDImplCopyWithImpl(
      _$CreatorIDImpl _value, $Res Function(_$CreatorIDImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$CreatorIDImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatorIDImpl with DiagnosticableTreeMixin implements CreatorID {
  const _$CreatorIDImpl({required this.id, final String? $type})
      : $type = $type ?? 'creator';

  factory _$CreatorIDImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatorIDImplFromJson(json);

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

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatorIDImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatorIDImplCopyWith<_$CreatorIDImpl> get copyWith =>
      __$$CreatorIDImplCopyWithImpl<_$CreatorIDImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes? attributes) user,
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
    TResult? Function(String id, UserAttributes? attributes)? user,
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
    TResult Function(String id, UserAttributes? attributes)? user,
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
    required TResult Function(MangaID value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
  }) {
    return creator(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MangaID value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
  }) {
    return creator?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MangaID value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    required TResult orElse(),
  }) {
    if (creator != null) {
      return creator(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatorIDImplToJson(
      this,
    );
  }
}

abstract class CreatorID implements Relationship {
  const factory CreatorID({required final String id}) = _$CreatorIDImpl;

  factory CreatorID.fromJson(Map<String, dynamic> json) =
      _$CreatorIDImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$CreatorIDImplCopyWith<_$CreatorIDImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CoverArtImplCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$CoverArtImplCopyWith(
          _$CoverArtImpl value, $Res Function(_$CoverArtImpl) then) =
      __$$CoverArtImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, CoverArtAttributes? attributes});

  $CoverArtAttributesCopyWith<$Res>? get attributes;
}

/// @nodoc
class __$$CoverArtImplCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$CoverArtImpl>
    implements _$$CoverArtImplCopyWith<$Res> {
  __$$CoverArtImplCopyWithImpl(
      _$CoverArtImpl _value, $Res Function(_$CoverArtImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = freezed,
  }) {
    return _then(_$CoverArtImpl(
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
class _$CoverArtImpl with DiagnosticableTreeMixin implements CoverArt {
  const _$CoverArtImpl(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'cover_art';

  factory _$CoverArtImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoverArtImplFromJson(json);

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

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoverArtImpl &&
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
  _$$CoverArtImplCopyWith<_$CoverArtImpl> get copyWith =>
      __$$CoverArtImplCopyWithImpl<_$CoverArtImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes? attributes) user,
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
    TResult? Function(String id, UserAttributes? attributes)? user,
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
    TResult Function(String id, UserAttributes? attributes)? user,
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
    required TResult Function(MangaID value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
  }) {
    return cover(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MangaID value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
  }) {
    return cover?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MangaID value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    required TResult orElse(),
  }) {
    if (cover != null) {
      return cover(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CoverArtImplToJson(
      this,
    );
  }
}

abstract class CoverArt implements Relationship {
  const factory CoverArt(
      {required final String id,
      required final CoverArtAttributes? attributes}) = _$CoverArtImpl;

  factory CoverArt.fromJson(Map<String, dynamic> json) =
      _$CoverArtImpl.fromJson;

  @override
  String get id;
  CoverArtAttributes? get attributes;
  @override
  @JsonKey(ignore: true)
  _$$CoverArtImplCopyWith<_$CoverArtImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupImplCopyWith<$Res>
    implements $RelationshipCopyWith<$Res> {
  factory _$$GroupImplCopyWith(
          _$GroupImpl value, $Res Function(_$GroupImpl) then) =
      __$$GroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, ScanlationGroupAttributes attributes});

  $ScanlationGroupAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$GroupImplCopyWithImpl<$Res>
    extends _$RelationshipCopyWithImpl<$Res, _$GroupImpl>
    implements _$$GroupImplCopyWith<$Res> {
  __$$GroupImplCopyWithImpl(
      _$GroupImpl _value, $Res Function(_$GroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_$GroupImpl(
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
class _$GroupImpl with DiagnosticableTreeMixin implements Group {
  const _$GroupImpl(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'scanlation_group';

  factory _$GroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupImplFromJson(json);

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
            other is _$GroupImpl &&
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
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      __$$GroupImplCopyWithImpl<_$GroupImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) manga,
    required TResult Function(String id, UserAttributes? attributes) user,
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
    TResult? Function(String id, UserAttributes? attributes)? user,
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
    TResult Function(String id, UserAttributes? attributes)? user,
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
    required TResult Function(MangaID value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
  }) {
    return group(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MangaID value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
  }) {
    return group?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MangaID value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    required TResult orElse(),
  }) {
    if (group != null) {
      return group(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupImplToJson(
      this,
    );
  }
}

abstract class Group implements Relationship {
  const factory Group(
      {required final String id,
      required final ScanlationGroupAttributes attributes}) = _$GroupImpl;

  factory Group.fromJson(Map<String, dynamic> json) = _$GroupImpl.fromJson;

  @override
  String get id;
  ScanlationGroupAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
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
abstract class _$$ChapterAPIDataImplCopyWith<$Res>
    implements $ChapterAPIDataCopyWith<$Res> {
  factory _$$ChapterAPIDataImplCopyWith(_$ChapterAPIDataImpl value,
          $Res Function(_$ChapterAPIDataImpl) then) =
      __$$ChapterAPIDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String hash, List<String> data, List<String> dataSaver});
}

/// @nodoc
class __$$ChapterAPIDataImplCopyWithImpl<$Res>
    extends _$ChapterAPIDataCopyWithImpl<$Res, _$ChapterAPIDataImpl>
    implements _$$ChapterAPIDataImplCopyWith<$Res> {
  __$$ChapterAPIDataImplCopyWithImpl(
      _$ChapterAPIDataImpl _value, $Res Function(_$ChapterAPIDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
    Object? data = null,
    Object? dataSaver = null,
  }) {
    return _then(_$ChapterAPIDataImpl(
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
class _$ChapterAPIDataImpl
    with DiagnosticableTreeMixin
    implements _ChapterAPIData {
  const _$ChapterAPIDataImpl(
      {required this.hash,
      required final List<String> data,
      required final List<String> dataSaver})
      : _data = data,
        _dataSaver = dataSaver;

  factory _$ChapterAPIDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterAPIDataImplFromJson(json);

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
            other is _$ChapterAPIDataImpl &&
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
  _$$ChapterAPIDataImplCopyWith<_$ChapterAPIDataImpl> get copyWith =>
      __$$ChapterAPIDataImplCopyWithImpl<_$ChapterAPIDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterAPIDataImplToJson(
      this,
    );
  }
}

abstract class _ChapterAPIData implements ChapterAPIData {
  const factory _ChapterAPIData(
      {required final String hash,
      required final List<String> data,
      required final List<String> dataSaver}) = _$ChapterAPIDataImpl;

  factory _ChapterAPIData.fromJson(Map<String, dynamic> json) =
      _$ChapterAPIDataImpl.fromJson;

  @override
  String get hash;
  @override
  List<String> get data;
  @override
  List<String> get dataSaver;
  @override
  @JsonKey(ignore: true)
  _$$ChapterAPIDataImplCopyWith<_$ChapterAPIDataImpl> get copyWith =>
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
abstract class _$$ChapterAPIImplCopyWith<$Res>
    implements $ChapterAPICopyWith<$Res> {
  factory _$$ChapterAPIImplCopyWith(
          _$ChapterAPIImpl value, $Res Function(_$ChapterAPIImpl) then) =
      __$$ChapterAPIImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String baseUrl, ChapterAPIData chapter});

  @override
  $ChapterAPIDataCopyWith<$Res> get chapter;
}

/// @nodoc
class __$$ChapterAPIImplCopyWithImpl<$Res>
    extends _$ChapterAPICopyWithImpl<$Res, _$ChapterAPIImpl>
    implements _$$ChapterAPIImplCopyWith<$Res> {
  __$$ChapterAPIImplCopyWithImpl(
      _$ChapterAPIImpl _value, $Res Function(_$ChapterAPIImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseUrl = null,
    Object? chapter = null,
  }) {
    return _then(_$ChapterAPIImpl(
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
class _$ChapterAPIImpl extends _ChapterAPI with DiagnosticableTreeMixin {
  const _$ChapterAPIImpl({required this.baseUrl, required this.chapter})
      : super._();

  factory _$ChapterAPIImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterAPIImplFromJson(json);

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
            other is _$ChapterAPIImpl &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.chapter, chapter) || other.chapter == chapter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, baseUrl, chapter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterAPIImplCopyWith<_$ChapterAPIImpl> get copyWith =>
      __$$ChapterAPIImplCopyWithImpl<_$ChapterAPIImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterAPIImplToJson(
      this,
    );
  }
}

abstract class _ChapterAPI extends ChapterAPI {
  const factory _ChapterAPI(
      {required final String baseUrl,
      required final ChapterAPIData chapter}) = _$ChapterAPIImpl;
  const _ChapterAPI._() : super._();

  factory _ChapterAPI.fromJson(Map<String, dynamic> json) =
      _$ChapterAPIImpl.fromJson;

  @override
  String get baseUrl;
  @override
  ChapterAPIData get chapter;
  @override
  @JsonKey(ignore: true)
  _$$ChapterAPIImplCopyWith<_$ChapterAPIImpl> get copyWith =>
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
abstract class _$$CoverListImplCopyWith<$Res>
    implements $CoverListCopyWith<$Res> {
  factory _$$CoverListImplCopyWith(
          _$CoverListImpl value, $Res Function(_$CoverListImpl) then) =
      __$$CoverListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CoverArt> data, int total});
}

/// @nodoc
class __$$CoverListImplCopyWithImpl<$Res>
    extends _$CoverListCopyWithImpl<$Res, _$CoverListImpl>
    implements _$$CoverListImplCopyWith<$Res> {
  __$$CoverListImplCopyWithImpl(
      _$CoverListImpl _value, $Res Function(_$CoverListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$CoverListImpl(
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
class _$CoverListImpl with DiagnosticableTreeMixin implements _CoverList {
  const _$CoverListImpl(final List<CoverArt> data, this.total) : _data = data;

  factory _$CoverListImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoverListImplFromJson(json);

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
            other is _$CoverListImpl &&
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
  _$$CoverListImplCopyWith<_$CoverListImpl> get copyWith =>
      __$$CoverListImplCopyWithImpl<_$CoverListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoverListImplToJson(
      this,
    );
  }
}

abstract class _CoverList implements CoverList {
  const factory _CoverList(final List<CoverArt> data, final int total) =
      _$CoverListImpl;

  factory _CoverList.fromJson(Map<String, dynamic> json) =
      _$CoverListImpl.fromJson;

  @override
  List<CoverArt> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$CoverListImplCopyWith<_$CoverListImpl> get copyWith =>
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
abstract class _$$MangaListImplCopyWith<$Res>
    implements $MangaListCopyWith<$Res> {
  factory _$$MangaListImplCopyWith(
          _$MangaListImpl value, $Res Function(_$MangaListImpl) then) =
      __$$MangaListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Manga> data, int total});
}

/// @nodoc
class __$$MangaListImplCopyWithImpl<$Res>
    extends _$MangaListCopyWithImpl<$Res, _$MangaListImpl>
    implements _$$MangaListImplCopyWith<$Res> {
  __$$MangaListImplCopyWithImpl(
      _$MangaListImpl _value, $Res Function(_$MangaListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$MangaListImpl(
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
class _$MangaListImpl with DiagnosticableTreeMixin implements _MangaList {
  const _$MangaListImpl(final List<Manga> data, this.total) : _data = data;

  factory _$MangaListImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaListImplFromJson(json);

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
            other is _$MangaListImpl &&
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
  _$$MangaListImplCopyWith<_$MangaListImpl> get copyWith =>
      __$$MangaListImplCopyWithImpl<_$MangaListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaListImplToJson(
      this,
    );
  }
}

abstract class _MangaList implements MangaList {
  const factory _MangaList(final List<Manga> data, final int total) =
      _$MangaListImpl;

  factory _MangaList.fromJson(Map<String, dynamic> json) =
      _$MangaListImpl.fromJson;

  @override
  List<Manga> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$MangaListImplCopyWith<_$MangaListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupList _$GroupListFromJson(Map<String, dynamic> json) {
  return _GroupList.fromJson(json);
}

/// @nodoc
mixin _$GroupList {
  List<Group> get data => throw _privateConstructorUsedError;
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
  $Res call({List<Group> data, int total});
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
              as List<Group>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupListImplCopyWith<$Res>
    implements $GroupListCopyWith<$Res> {
  factory _$$GroupListImplCopyWith(
          _$GroupListImpl value, $Res Function(_$GroupListImpl) then) =
      __$$GroupListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Group> data, int total});
}

/// @nodoc
class __$$GroupListImplCopyWithImpl<$Res>
    extends _$GroupListCopyWithImpl<$Res, _$GroupListImpl>
    implements _$$GroupListImplCopyWith<$Res> {
  __$$GroupListImplCopyWithImpl(
      _$GroupListImpl _value, $Res Function(_$GroupListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$GroupListImpl(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Group>,
      null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupListImpl with DiagnosticableTreeMixin implements _GroupList {
  const _$GroupListImpl(final List<Group> data, this.total) : _data = data;

  factory _$GroupListImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupListImplFromJson(json);

  final List<Group> _data;
  @override
  List<Group> get data {
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
            other is _$GroupListImpl &&
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
  _$$GroupListImplCopyWith<_$GroupListImpl> get copyWith =>
      __$$GroupListImplCopyWithImpl<_$GroupListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupListImplToJson(
      this,
    );
  }
}

abstract class _GroupList implements GroupList {
  const factory _GroupList(final List<Group> data, final int total) =
      _$GroupListImpl;

  factory _GroupList.fromJson(Map<String, dynamic> json) =
      _$GroupListImpl.fromJson;

  @override
  List<Group> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$GroupListImplCopyWith<_$GroupListImpl> get copyWith =>
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
abstract class _$$CreatorListListImplCopyWith<$Res>
    implements $CreatorListCopyWith<$Res> {
  factory _$$CreatorListListImplCopyWith(_$CreatorListListImpl value,
          $Res Function(_$CreatorListListImpl) then) =
      __$$CreatorListListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Author> data, int total});
}

/// @nodoc
class __$$CreatorListListImplCopyWithImpl<$Res>
    extends _$CreatorListCopyWithImpl<$Res, _$CreatorListListImpl>
    implements _$$CreatorListListImplCopyWith<$Res> {
  __$$CreatorListListImplCopyWithImpl(
      _$CreatorListListImpl _value, $Res Function(_$CreatorListListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$CreatorListListImpl(
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
class _$CreatorListListImpl
    with DiagnosticableTreeMixin
    implements _CreatorListList {
  const _$CreatorListListImpl(final List<Author> data, this.total)
      : _data = data;

  factory _$CreatorListListImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatorListListImplFromJson(json);

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
            other is _$CreatorListListImpl &&
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
  _$$CreatorListListImplCopyWith<_$CreatorListListImpl> get copyWith =>
      __$$CreatorListListImplCopyWithImpl<_$CreatorListListImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatorListListImplToJson(
      this,
    );
  }
}

abstract class _CreatorListList implements CreatorList {
  const factory _CreatorListList(final List<Author> data, final int total) =
      _$CreatorListListImpl;

  factory _CreatorListList.fromJson(Map<String, dynamic> json) =
      _$CreatorListListImpl.fromJson;

  @override
  List<Author> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$CreatorListListImplCopyWith<_$CreatorListListImpl> get copyWith =>
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
abstract class _$$MangaImplCopyWith<$Res> implements $MangaCopyWith<$Res> {
  factory _$$MangaImplCopyWith(
          _$MangaImpl value, $Res Function(_$MangaImpl) then) =
      __$$MangaImplCopyWithImpl<$Res>;
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
class __$$MangaImplCopyWithImpl<$Res>
    extends _$MangaCopyWithImpl<$Res, _$MangaImpl>
    implements _$$MangaImplCopyWith<$Res> {
  __$$MangaImplCopyWithImpl(
      _$MangaImpl _value, $Res Function(_$MangaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
    Object? relationships = null,
  }) {
    return _then(_$MangaImpl(
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
class _$MangaImpl extends _Manga with DiagnosticableTreeMixin {
  _$MangaImpl(
      {required this.id,
      required this.attributes,
      required final List<Relationship> relationships})
      : _relationships = relationships,
        super._();

  factory _$MangaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaImplFromJson(json);

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
            other is _$MangaImpl &&
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
  _$$MangaImplCopyWith<_$MangaImpl> get copyWith =>
      __$$MangaImplCopyWithImpl<_$MangaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaImplToJson(
      this,
    );
  }
}

abstract class _Manga extends Manga {
  factory _Manga(
      {required final String id,
      required final MangaAttributes attributes,
      required final List<Relationship> relationships}) = _$MangaImpl;
  _Manga._() : super._();

  factory _Manga.fromJson(Map<String, dynamic> json) = _$MangaImpl.fromJson;

  @override
  String get id;
  @override
  MangaAttributes get attributes;
  @override
  List<Relationship> get relationships;
  @override
  @JsonKey(ignore: true)
  _$$MangaImplCopyWith<_$MangaImpl> get copyWith =>
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
abstract class _$$MangaLinksImplCopyWith<$Res>
    implements $MangaLinksCopyWith<$Res> {
  factory _$$MangaLinksImplCopyWith(
          _$MangaLinksImpl value, $Res Function(_$MangaLinksImpl) then) =
      __$$MangaLinksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? raw, String? al, String? mu, String? mal});
}

/// @nodoc
class __$$MangaLinksImplCopyWithImpl<$Res>
    extends _$MangaLinksCopyWithImpl<$Res, _$MangaLinksImpl>
    implements _$$MangaLinksImplCopyWith<$Res> {
  __$$MangaLinksImplCopyWithImpl(
      _$MangaLinksImpl _value, $Res Function(_$MangaLinksImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? raw = freezed,
    Object? al = freezed,
    Object? mu = freezed,
    Object? mal = freezed,
  }) {
    return _then(_$MangaLinksImpl(
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
class _$MangaLinksImpl with DiagnosticableTreeMixin implements _MangaLinks {
  const _$MangaLinksImpl({this.raw, this.al, this.mu, this.mal});

  factory _$MangaLinksImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaLinksImplFromJson(json);

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
            other is _$MangaLinksImpl &&
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
  _$$MangaLinksImplCopyWith<_$MangaLinksImpl> get copyWith =>
      __$$MangaLinksImplCopyWithImpl<_$MangaLinksImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaLinksImplToJson(
      this,
    );
  }
}

abstract class _MangaLinks implements MangaLinks {
  const factory _MangaLinks(
      {final String? raw,
      final String? al,
      final String? mu,
      final String? mal}) = _$MangaLinksImpl;

  factory _MangaLinks.fromJson(Map<String, dynamic> json) =
      _$MangaLinksImpl.fromJson;

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
  _$$MangaLinksImplCopyWith<_$MangaLinksImpl> get copyWith =>
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
abstract class _$$MangaAttributesImplCopyWith<$Res>
    implements $MangaAttributesCopyWith<$Res> {
  factory _$$MangaAttributesImplCopyWith(_$MangaAttributesImpl value,
          $Res Function(_$MangaAttributesImpl) then) =
      __$$MangaAttributesImplCopyWithImpl<$Res>;
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
class __$$MangaAttributesImplCopyWithImpl<$Res>
    extends _$MangaAttributesCopyWithImpl<$Res, _$MangaAttributesImpl>
    implements _$$MangaAttributesImplCopyWith<$Res> {
  __$$MangaAttributesImplCopyWithImpl(
      _$MangaAttributesImpl _value, $Res Function(_$MangaAttributesImpl) _then)
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
    return _then(_$MangaAttributesImpl(
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
class _$MangaAttributesImpl
    with DiagnosticableTreeMixin
    implements _MangaAttributes {
  const _$MangaAttributesImpl(
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

  factory _$MangaAttributesImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaAttributesImplFromJson(json);

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
            other is _$MangaAttributesImpl &&
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
  _$$MangaAttributesImplCopyWith<_$MangaAttributesImpl> get copyWith =>
      __$$MangaAttributesImplCopyWithImpl<_$MangaAttributesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaAttributesImplToJson(
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
      _$MangaAttributesImpl;

  factory _MangaAttributes.fromJson(Map<String, dynamic> json) =
      _$MangaAttributesImpl.fromJson;

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
  _$$MangaAttributesImplCopyWith<_$MangaAttributesImpl> get copyWith =>
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
abstract class _$$TagImplCopyWith<$Res> implements $TagCopyWith<$Res> {
  factory _$$TagImplCopyWith(_$TagImpl value, $Res Function(_$TagImpl) then) =
      __$$TagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, TagAttributes attributes});

  @override
  $TagAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$TagImplCopyWithImpl<$Res> extends _$TagCopyWithImpl<$Res, _$TagImpl>
    implements _$$TagImplCopyWith<$Res> {
  __$$TagImplCopyWithImpl(_$TagImpl _value, $Res Function(_$TagImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
  }) {
    return _then(_$TagImpl(
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
class _$TagImpl with DiagnosticableTreeMixin implements _Tag {
  const _$TagImpl({required this.id, required this.attributes});

  factory _$TagImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagImplFromJson(json);

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
            other is _$TagImpl &&
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
  const factory _Tag(
      {required final String id,
      required final TagAttributes attributes}) = _$TagImpl;

  factory _Tag.fromJson(Map<String, dynamic> json) = _$TagImpl.fromJson;

  @override
  String get id;
  @override
  TagAttributes get attributes;
  @override
  @JsonKey(ignore: true)
  _$$TagImplCopyWith<_$TagImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
abstract class _$$TagAttributesImplCopyWith<$Res>
    implements $TagAttributesCopyWith<$Res> {
  factory _$$TagAttributesImplCopyWith(
          _$TagAttributesImpl value, $Res Function(_$TagAttributesImpl) then) =
      __$$TagAttributesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, String> name,
      Map<String, String> description,
      TagGroup group});
}

/// @nodoc
class __$$TagAttributesImplCopyWithImpl<$Res>
    extends _$TagAttributesCopyWithImpl<$Res, _$TagAttributesImpl>
    implements _$$TagAttributesImplCopyWith<$Res> {
  __$$TagAttributesImplCopyWithImpl(
      _$TagAttributesImpl _value, $Res Function(_$TagAttributesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? group = null,
  }) {
    return _then(_$TagAttributesImpl(
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
class _$TagAttributesImpl
    with DiagnosticableTreeMixin
    implements _TagAttributes {
  const _$TagAttributesImpl(
      {required final Map<String, String> name,
      required final Map<String, String> description,
      required this.group})
      : _name = name,
        _description = description;

  factory _$TagAttributesImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagAttributesImplFromJson(json);

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
            other is _$TagAttributesImpl &&
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
  _$$TagAttributesImplCopyWith<_$TagAttributesImpl> get copyWith =>
      __$$TagAttributesImplCopyWithImpl<_$TagAttributesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagAttributesImplToJson(
      this,
    );
  }
}

abstract class _TagAttributes implements TagAttributes {
  const factory _TagAttributes(
      {required final Map<String, String> name,
      required final Map<String, String> description,
      required final TagGroup group}) = _$TagAttributesImpl;

  factory _TagAttributes.fromJson(Map<String, dynamic> json) =
      _$TagAttributesImpl.fromJson;

  @override
  Map<String, String> get name;
  @override
  Map<String, String> get description;
  @override
  TagGroup get group;
  @override
  @JsonKey(ignore: true)
  _$$TagAttributesImplCopyWith<_$TagAttributesImpl> get copyWith =>
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
abstract class _$$TagResponseImplCopyWith<$Res>
    implements $TagResponseCopyWith<$Res> {
  factory _$$TagResponseImplCopyWith(
          _$TagResponseImpl value, $Res Function(_$TagResponseImpl) then) =
      __$$TagResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Tag> data, int total});
}

/// @nodoc
class __$$TagResponseImplCopyWithImpl<$Res>
    extends _$TagResponseCopyWithImpl<$Res, _$TagResponseImpl>
    implements _$$TagResponseImplCopyWith<$Res> {
  __$$TagResponseImplCopyWithImpl(
      _$TagResponseImpl _value, $Res Function(_$TagResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$TagResponseImpl(
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
class _$TagResponseImpl with DiagnosticableTreeMixin implements _TagResponse {
  const _$TagResponseImpl(final List<Tag> data, this.total) : _data = data;

  factory _$TagResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagResponseImplFromJson(json);

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
            other is _$TagResponseImpl &&
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
  _$$TagResponseImplCopyWith<_$TagResponseImpl> get copyWith =>
      __$$TagResponseImplCopyWithImpl<_$TagResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagResponseImplToJson(
      this,
    );
  }
}

abstract class _TagResponse implements TagResponse {
  const factory _TagResponse(final List<Tag> data, final int total) =
      _$TagResponseImpl;

  factory _TagResponse.fromJson(Map<String, dynamic> json) =
      _$TagResponseImpl.fromJson;

  @override
  List<Tag> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$TagResponseImplCopyWith<_$TagResponseImpl> get copyWith =>
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
abstract class _$$MangaStatisticsResponseImplCopyWith<$Res>
    implements $MangaStatisticsResponseCopyWith<$Res> {
  factory _$$MangaStatisticsResponseImplCopyWith(
          _$MangaStatisticsResponseImpl value,
          $Res Function(_$MangaStatisticsResponseImpl) then) =
      __$$MangaStatisticsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, MangaStatistics> statistics});
}

/// @nodoc
class __$$MangaStatisticsResponseImplCopyWithImpl<$Res>
    extends _$MangaStatisticsResponseCopyWithImpl<$Res,
        _$MangaStatisticsResponseImpl>
    implements _$$MangaStatisticsResponseImplCopyWith<$Res> {
  __$$MangaStatisticsResponseImplCopyWithImpl(
      _$MangaStatisticsResponseImpl _value,
      $Res Function(_$MangaStatisticsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statistics = null,
  }) {
    return _then(_$MangaStatisticsResponseImpl(
      null == statistics
          ? _value._statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Map<String, MangaStatistics>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaStatisticsResponseImpl
    with DiagnosticableTreeMixin
    implements _MangaStatisticsResponse {
  const _$MangaStatisticsResponseImpl(
      final Map<String, MangaStatistics> statistics)
      : _statistics = statistics;

  factory _$MangaStatisticsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaStatisticsResponseImplFromJson(json);

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
            other is _$MangaStatisticsResponseImpl &&
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
  _$$MangaStatisticsResponseImplCopyWith<_$MangaStatisticsResponseImpl>
      get copyWith => __$$MangaStatisticsResponseImplCopyWithImpl<
          _$MangaStatisticsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaStatisticsResponseImplToJson(
      this,
    );
  }
}

abstract class _MangaStatisticsResponse implements MangaStatisticsResponse {
  const factory _MangaStatisticsResponse(
          final Map<String, MangaStatistics> statistics) =
      _$MangaStatisticsResponseImpl;

  factory _MangaStatisticsResponse.fromJson(Map<String, dynamic> json) =
      _$MangaStatisticsResponseImpl.fromJson;

  @override
  Map<String, MangaStatistics> get statistics;
  @override
  @JsonKey(ignore: true)
  _$$MangaStatisticsResponseImplCopyWith<_$MangaStatisticsResponseImpl>
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
abstract class _$$MangaStatisticsImplCopyWith<$Res>
    implements $MangaStatisticsCopyWith<$Res> {
  factory _$$MangaStatisticsImplCopyWith(_$MangaStatisticsImpl value,
          $Res Function(_$MangaStatisticsImpl) then) =
      __$$MangaStatisticsImplCopyWithImpl<$Res>;
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
class __$$MangaStatisticsImplCopyWithImpl<$Res>
    extends _$MangaStatisticsCopyWithImpl<$Res, _$MangaStatisticsImpl>
    implements _$$MangaStatisticsImplCopyWith<$Res> {
  __$$MangaStatisticsImplCopyWithImpl(
      _$MangaStatisticsImpl _value, $Res Function(_$MangaStatisticsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = freezed,
    Object? rating = null,
    Object? follows = null,
  }) {
    return _then(_$MangaStatisticsImpl(
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
class _$MangaStatisticsImpl
    with DiagnosticableTreeMixin
    implements _MangaStatistics {
  const _$MangaStatisticsImpl(
      {this.comments, required this.rating, required this.follows});

  factory _$MangaStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaStatisticsImplFromJson(json);

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
            other is _$MangaStatisticsImpl &&
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
  _$$MangaStatisticsImplCopyWith<_$MangaStatisticsImpl> get copyWith =>
      __$$MangaStatisticsImplCopyWithImpl<_$MangaStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaStatisticsImplToJson(
      this,
    );
  }
}

abstract class _MangaStatistics implements MangaStatistics {
  const factory _MangaStatistics(
      {final StatisticsDetailsComments? comments,
      required final StatisticsDetailsRating rating,
      required final int follows}) = _$MangaStatisticsImpl;

  factory _MangaStatistics.fromJson(Map<String, dynamic> json) =
      _$MangaStatisticsImpl.fromJson;

  @override
  StatisticsDetailsComments? get comments;
  @override
  StatisticsDetailsRating get rating;
  @override
  int get follows;
  @override
  @JsonKey(ignore: true)
  _$$MangaStatisticsImplCopyWith<_$MangaStatisticsImpl> get copyWith =>
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
abstract class _$$StatisticsDetailsCommentsImplCopyWith<$Res>
    implements $StatisticsDetailsCommentsCopyWith<$Res> {
  factory _$$StatisticsDetailsCommentsImplCopyWith(
          _$StatisticsDetailsCommentsImpl value,
          $Res Function(_$StatisticsDetailsCommentsImpl) then) =
      __$$StatisticsDetailsCommentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int threadId, int repliesCount});
}

/// @nodoc
class __$$StatisticsDetailsCommentsImplCopyWithImpl<$Res>
    extends _$StatisticsDetailsCommentsCopyWithImpl<$Res,
        _$StatisticsDetailsCommentsImpl>
    implements _$$StatisticsDetailsCommentsImplCopyWith<$Res> {
  __$$StatisticsDetailsCommentsImplCopyWithImpl(
      _$StatisticsDetailsCommentsImpl _value,
      $Res Function(_$StatisticsDetailsCommentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadId = null,
    Object? repliesCount = null,
  }) {
    return _then(_$StatisticsDetailsCommentsImpl(
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
class _$StatisticsDetailsCommentsImpl
    with DiagnosticableTreeMixin
    implements _StatisticsDetailsComments {
  const _$StatisticsDetailsCommentsImpl(
      {required this.threadId, required this.repliesCount});

  factory _$StatisticsDetailsCommentsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatisticsDetailsCommentsImplFromJson(json);

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
            other is _$StatisticsDetailsCommentsImpl &&
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
  _$$StatisticsDetailsCommentsImplCopyWith<_$StatisticsDetailsCommentsImpl>
      get copyWith => __$$StatisticsDetailsCommentsImplCopyWithImpl<
          _$StatisticsDetailsCommentsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatisticsDetailsCommentsImplToJson(
      this,
    );
  }
}

abstract class _StatisticsDetailsComments implements StatisticsDetailsComments {
  const factory _StatisticsDetailsComments(
      {required final int threadId,
      required final int repliesCount}) = _$StatisticsDetailsCommentsImpl;

  factory _StatisticsDetailsComments.fromJson(Map<String, dynamic> json) =
      _$StatisticsDetailsCommentsImpl.fromJson;

  @override
  int get threadId;
  @override
  int get repliesCount;
  @override
  @JsonKey(ignore: true)
  _$$StatisticsDetailsCommentsImplCopyWith<_$StatisticsDetailsCommentsImpl>
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
abstract class _$$StatisticsDetailsRatingImplCopyWith<$Res>
    implements $StatisticsDetailsRatingCopyWith<$Res> {
  factory _$$StatisticsDetailsRatingImplCopyWith(
          _$StatisticsDetailsRatingImpl value,
          $Res Function(_$StatisticsDetailsRatingImpl) then) =
      __$$StatisticsDetailsRatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? average, double bayesian});
}

/// @nodoc
class __$$StatisticsDetailsRatingImplCopyWithImpl<$Res>
    extends _$StatisticsDetailsRatingCopyWithImpl<$Res,
        _$StatisticsDetailsRatingImpl>
    implements _$$StatisticsDetailsRatingImplCopyWith<$Res> {
  __$$StatisticsDetailsRatingImplCopyWithImpl(
      _$StatisticsDetailsRatingImpl _value,
      $Res Function(_$StatisticsDetailsRatingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? average = freezed,
    Object? bayesian = null,
  }) {
    return _then(_$StatisticsDetailsRatingImpl(
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
class _$StatisticsDetailsRatingImpl
    with DiagnosticableTreeMixin
    implements _StatisticsDetailsRating {
  const _$StatisticsDetailsRatingImpl({this.average, required this.bayesian});

  factory _$StatisticsDetailsRatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatisticsDetailsRatingImplFromJson(json);

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
            other is _$StatisticsDetailsRatingImpl &&
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
  _$$StatisticsDetailsRatingImplCopyWith<_$StatisticsDetailsRatingImpl>
      get copyWith => __$$StatisticsDetailsRatingImplCopyWithImpl<
          _$StatisticsDetailsRatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatisticsDetailsRatingImplToJson(
      this,
    );
  }
}

abstract class _StatisticsDetailsRating implements StatisticsDetailsRating {
  const factory _StatisticsDetailsRating(
      {final double? average,
      required final double bayesian}) = _$StatisticsDetailsRatingImpl;

  factory _StatisticsDetailsRating.fromJson(Map<String, dynamic> json) =
      _$StatisticsDetailsRatingImpl.fromJson;

  @override
  double? get average;
  @override
  double get bayesian;
  @override
  @JsonKey(ignore: true)
  _$$StatisticsDetailsRatingImplCopyWith<_$StatisticsDetailsRatingImpl>
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
abstract class _$$SelfRatingResponseImplCopyWith<$Res>
    implements $SelfRatingResponseCopyWith<$Res> {
  factory _$$SelfRatingResponseImplCopyWith(_$SelfRatingResponseImpl value,
          $Res Function(_$SelfRatingResponseImpl) then) =
      __$$SelfRatingResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, SelfRating> ratings});
}

/// @nodoc
class __$$SelfRatingResponseImplCopyWithImpl<$Res>
    extends _$SelfRatingResponseCopyWithImpl<$Res, _$SelfRatingResponseImpl>
    implements _$$SelfRatingResponseImplCopyWith<$Res> {
  __$$SelfRatingResponseImplCopyWithImpl(_$SelfRatingResponseImpl _value,
      $Res Function(_$SelfRatingResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ratings = null,
  }) {
    return _then(_$SelfRatingResponseImpl(
      null == ratings
          ? _value._ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as Map<String, SelfRating>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SelfRatingResponseImpl
    with DiagnosticableTreeMixin
    implements _SelfRatingResponse {
  const _$SelfRatingResponseImpl(final Map<String, SelfRating> ratings)
      : _ratings = ratings;

  factory _$SelfRatingResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelfRatingResponseImplFromJson(json);

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
            other is _$SelfRatingResponseImpl &&
            const DeepCollectionEquality().equals(other._ratings, _ratings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_ratings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelfRatingResponseImplCopyWith<_$SelfRatingResponseImpl> get copyWith =>
      __$$SelfRatingResponseImplCopyWithImpl<_$SelfRatingResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SelfRatingResponseImplToJson(
      this,
    );
  }
}

abstract class _SelfRatingResponse implements SelfRatingResponse {
  const factory _SelfRatingResponse(final Map<String, SelfRating> ratings) =
      _$SelfRatingResponseImpl;

  factory _SelfRatingResponse.fromJson(Map<String, dynamic> json) =
      _$SelfRatingResponseImpl.fromJson;

  @override
  Map<String, SelfRating> get ratings;
  @override
  @JsonKey(ignore: true)
  _$$SelfRatingResponseImplCopyWith<_$SelfRatingResponseImpl> get copyWith =>
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
abstract class _$$SelfRatingImplCopyWith<$Res>
    implements $SelfRatingCopyWith<$Res> {
  factory _$$SelfRatingImplCopyWith(
          _$SelfRatingImpl value, $Res Function(_$SelfRatingImpl) then) =
      __$$SelfRatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int rating, @TimestampSerializer() DateTime createdAt});
}

/// @nodoc
class __$$SelfRatingImplCopyWithImpl<$Res>
    extends _$SelfRatingCopyWithImpl<$Res, _$SelfRatingImpl>
    implements _$$SelfRatingImplCopyWith<$Res> {
  __$$SelfRatingImplCopyWithImpl(
      _$SelfRatingImpl _value, $Res Function(_$SelfRatingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
    Object? createdAt = null,
  }) {
    return _then(_$SelfRatingImpl(
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
class _$SelfRatingImpl extends _SelfRating with DiagnosticableTreeMixin {
  _$SelfRatingImpl(
      {required this.rating, @TimestampSerializer() required this.createdAt})
      : super._();

  factory _$SelfRatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelfRatingImplFromJson(json);

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
            other is _$SelfRatingImpl &&
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
  _$$SelfRatingImplCopyWith<_$SelfRatingImpl> get copyWith =>
      __$$SelfRatingImplCopyWithImpl<_$SelfRatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SelfRatingImplToJson(
      this,
    );
  }
}

abstract class _SelfRating extends SelfRating {
  factory _SelfRating(
          {required final int rating,
          @TimestampSerializer() required final DateTime createdAt}) =
      _$SelfRatingImpl;
  _SelfRating._() : super._();

  factory _SelfRating.fromJson(Map<String, dynamic> json) =
      _$SelfRatingImpl.fromJson;

  @override
  int get rating;
  @override
  @TimestampSerializer()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$SelfRatingImplCopyWith<_$SelfRatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomListList _$CustomListListFromJson(Map<String, dynamic> json) {
  return _CustomListList.fromJson(json);
}

/// @nodoc
mixin _$CustomListList {
  List<CustomList> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomListListCopyWith<CustomListList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomListListCopyWith<$Res> {
  factory $CustomListListCopyWith(
          CustomListList value, $Res Function(CustomListList) then) =
      _$CustomListListCopyWithImpl<$Res, CustomListList>;
  @useResult
  $Res call({List<CustomList> data, int total});
}

/// @nodoc
class _$CustomListListCopyWithImpl<$Res, $Val extends CustomListList>
    implements $CustomListListCopyWith<$Res> {
  _$CustomListListCopyWithImpl(this._value, this._then);

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
              as List<CustomList>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomListListImplCopyWith<$Res>
    implements $CustomListListCopyWith<$Res> {
  factory _$$CustomListListImplCopyWith(_$CustomListListImpl value,
          $Res Function(_$CustomListListImpl) then) =
      __$$CustomListListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CustomList> data, int total});
}

/// @nodoc
class __$$CustomListListImplCopyWithImpl<$Res>
    extends _$CustomListListCopyWithImpl<$Res, _$CustomListListImpl>
    implements _$$CustomListListImplCopyWith<$Res> {
  __$$CustomListListImplCopyWithImpl(
      _$CustomListListImpl _value, $Res Function(_$CustomListListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? total = null,
  }) {
    return _then(_$CustomListListImpl(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CustomList>,
      null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomListListImpl
    with DiagnosticableTreeMixin
    implements _CustomListList {
  const _$CustomListListImpl(final List<CustomList> data, this.total)
      : _data = data;

  factory _$CustomListListImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomListListImplFromJson(json);

  final List<CustomList> _data;
  @override
  List<CustomList> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int total;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomListList(data: $data, total: $total)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomListList'))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('total', total));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomListListImpl &&
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
  _$$CustomListListImplCopyWith<_$CustomListListImpl> get copyWith =>
      __$$CustomListListImplCopyWithImpl<_$CustomListListImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomListListImplToJson(
      this,
    );
  }
}

abstract class _CustomListList implements CustomListList {
  const factory _CustomListList(final List<CustomList> data, final int total) =
      _$CustomListListImpl;

  factory _CustomListList.fromJson(Map<String, dynamic> json) =
      _$CustomListListImpl.fromJson;

  @override
  List<CustomList> get data;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$CustomListListImplCopyWith<_$CustomListListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomList _$CustomListFromJson(Map<String, dynamic> json) {
  return _CustomList.fromJson(json);
}

/// @nodoc
mixin _$CustomList {
  String get id => throw _privateConstructorUsedError;
  CustomListAttributes get attributes => throw _privateConstructorUsedError;
  List<Relationship> get relationships => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomListCopyWith<CustomList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomListCopyWith<$Res> {
  factory $CustomListCopyWith(
          CustomList value, $Res Function(CustomList) then) =
      _$CustomListCopyWithImpl<$Res, CustomList>;
  @useResult
  $Res call(
      {String id,
      CustomListAttributes attributes,
      List<Relationship> relationships});

  $CustomListAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class _$CustomListCopyWithImpl<$Res, $Val extends CustomList>
    implements $CustomListCopyWith<$Res> {
  _$CustomListCopyWithImpl(this._value, this._then);

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
              as CustomListAttributes,
      relationships: null == relationships
          ? _value.relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as List<Relationship>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomListAttributesCopyWith<$Res> get attributes {
    return $CustomListAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomListImplCopyWith<$Res>
    implements $CustomListCopyWith<$Res> {
  factory _$$CustomListImplCopyWith(
          _$CustomListImpl value, $Res Function(_$CustomListImpl) then) =
      __$$CustomListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      CustomListAttributes attributes,
      List<Relationship> relationships});

  @override
  $CustomListAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$CustomListImplCopyWithImpl<$Res>
    extends _$CustomListCopyWithImpl<$Res, _$CustomListImpl>
    implements _$$CustomListImplCopyWith<$Res> {
  __$$CustomListImplCopyWithImpl(
      _$CustomListImpl _value, $Res Function(_$CustomListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = null,
    Object? relationships = null,
  }) {
    return _then(_$CustomListImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as CustomListAttributes,
      relationships: null == relationships
          ? _value._relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as List<Relationship>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomListImpl extends _CustomList with DiagnosticableTreeMixin {
  _$CustomListImpl(
      {required this.id,
      required this.attributes,
      required final List<Relationship> relationships})
      : _relationships = relationships,
        super._();

  factory _$CustomListImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomListImplFromJson(json);

  @override
  final String id;
  @override
  final CustomListAttributes attributes;
  final List<Relationship> _relationships;
  @override
  List<Relationship> get relationships {
    if (_relationships is EqualUnmodifiableListView) return _relationships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relationships);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomList(id: $id, attributes: $attributes, relationships: $relationships)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomList'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes))
      ..add(DiagnosticsProperty('relationships', relationships));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomListImpl &&
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
  _$$CustomListImplCopyWith<_$CustomListImpl> get copyWith =>
      __$$CustomListImplCopyWithImpl<_$CustomListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomListImplToJson(
      this,
    );
  }
}

abstract class _CustomList extends CustomList {
  factory _CustomList(
      {required final String id,
      required final CustomListAttributes attributes,
      required final List<Relationship> relationships}) = _$CustomListImpl;
  _CustomList._() : super._();

  factory _CustomList.fromJson(Map<String, dynamic> json) =
      _$CustomListImpl.fromJson;

  @override
  String get id;
  @override
  CustomListAttributes get attributes;
  @override
  List<Relationship> get relationships;
  @override
  @JsonKey(ignore: true)
  _$$CustomListImplCopyWith<_$CustomListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomListAttributes _$CustomListAttributesFromJson(Map<String, dynamic> json) {
  return _CustomListAttributes.fromJson(json);
}

/// @nodoc
mixin _$CustomListAttributes {
  String get name => throw _privateConstructorUsedError;
  CustomListVisibility get visibility => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomListAttributesCopyWith<CustomListAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomListAttributesCopyWith<$Res> {
  factory $CustomListAttributesCopyWith(CustomListAttributes value,
          $Res Function(CustomListAttributes) then) =
      _$CustomListAttributesCopyWithImpl<$Res, CustomListAttributes>;
  @useResult
  $Res call({String name, CustomListVisibility visibility, int version});
}

/// @nodoc
class _$CustomListAttributesCopyWithImpl<$Res,
        $Val extends CustomListAttributes>
    implements $CustomListAttributesCopyWith<$Res> {
  _$CustomListAttributesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? visibility = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as CustomListVisibility,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomListAttributesImplCopyWith<$Res>
    implements $CustomListAttributesCopyWith<$Res> {
  factory _$$CustomListAttributesImplCopyWith(_$CustomListAttributesImpl value,
          $Res Function(_$CustomListAttributesImpl) then) =
      __$$CustomListAttributesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, CustomListVisibility visibility, int version});
}

/// @nodoc
class __$$CustomListAttributesImplCopyWithImpl<$Res>
    extends _$CustomListAttributesCopyWithImpl<$Res, _$CustomListAttributesImpl>
    implements _$$CustomListAttributesImplCopyWith<$Res> {
  __$$CustomListAttributesImplCopyWithImpl(_$CustomListAttributesImpl _value,
      $Res Function(_$CustomListAttributesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? visibility = null,
    Object? version = null,
  }) {
    return _then(_$CustomListAttributesImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as CustomListVisibility,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomListAttributesImpl
    with DiagnosticableTreeMixin
    implements _CustomListAttributes {
  const _$CustomListAttributesImpl(
      {required this.name, required this.visibility, required this.version});

  factory _$CustomListAttributesImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomListAttributesImplFromJson(json);

  @override
  final String name;
  @override
  final CustomListVisibility visibility;
  @override
  final int version;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomListAttributes(name: $name, visibility: $visibility, version: $version)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomListAttributes'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('visibility', visibility))
      ..add(DiagnosticsProperty('version', version));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomListAttributesImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, visibility, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomListAttributesImplCopyWith<_$CustomListAttributesImpl>
      get copyWith =>
          __$$CustomListAttributesImplCopyWithImpl<_$CustomListAttributesImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomListAttributesImplToJson(
      this,
    );
  }
}

abstract class _CustomListAttributes implements CustomListAttributes {
  const factory _CustomListAttributes(
      {required final String name,
      required final CustomListVisibility visibility,
      required final int version}) = _$CustomListAttributesImpl;

  factory _CustomListAttributes.fromJson(Map<String, dynamic> json) =
      _$CustomListAttributesImpl.fromJson;

  @override
  String get name;
  @override
  CustomListVisibility get visibility;
  @override
  int get version;
  @override
  @JsonKey(ignore: true)
  _$$CustomListAttributesImplCopyWith<_$CustomListAttributesImpl>
      get copyWith => throw _privateConstructorUsedError;
}
