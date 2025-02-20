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

MangaFilters _$MangaFiltersFromJson(Map<String, dynamic> json) {
  return _MangaFilters.fromJson(json);
}

/// @nodoc
mixin _$MangaFilters {
  Set<Tag> get includedTags => throw _privateConstructorUsedError;
  TagMode get includedTagsMode => throw _privateConstructorUsedError;
  Set<Tag> get excludedTags => throw _privateConstructorUsedError;
  TagMode get excludedTagsMode => throw _privateConstructorUsedError;
  Set<MangaStatus> get status => throw _privateConstructorUsedError;
  Set<MangaDemographic> get publicationDemographic =>
      throw _privateConstructorUsedError;
  Set<ContentRating> get contentRating => throw _privateConstructorUsedError;
  FilterOrder get order => throw _privateConstructorUsedError;

  /// Serializes this MangaFilters to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MangaFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      TagMode includedTagsMode,
      Set<Tag> excludedTags,
      TagMode excludedTagsMode,
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

  /// Create a copy of MangaFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? includedTags = null,
    Object? includedTagsMode = null,
    Object? excludedTags = null,
    Object? excludedTagsMode = null,
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
      includedTagsMode: null == includedTagsMode
          ? _value.includedTagsMode
          : includedTagsMode // ignore: cast_nullable_to_non_nullable
              as TagMode,
      excludedTags: null == excludedTags
          ? _value.excludedTags
          : excludedTags // ignore: cast_nullable_to_non_nullable
              as Set<Tag>,
      excludedTagsMode: null == excludedTagsMode
          ? _value.excludedTagsMode
          : excludedTagsMode // ignore: cast_nullable_to_non_nullable
              as TagMode,
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
      TagMode includedTagsMode,
      Set<Tag> excludedTags,
      TagMode excludedTagsMode,
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

  /// Create a copy of MangaFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? includedTags = null,
    Object? includedTagsMode = null,
    Object? excludedTags = null,
    Object? excludedTagsMode = null,
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
      includedTagsMode: null == includedTagsMode
          ? _value.includedTagsMode
          : includedTagsMode // ignore: cast_nullable_to_non_nullable
              as TagMode,
      excludedTags: null == excludedTags
          ? _value._excludedTags
          : excludedTags // ignore: cast_nullable_to_non_nullable
              as Set<Tag>,
      excludedTagsMode: null == excludedTagsMode
          ? _value.excludedTagsMode
          : excludedTagsMode // ignore: cast_nullable_to_non_nullable
              as TagMode,
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
      this.includedTagsMode = TagMode.and,
      final Set<Tag> excludedTags = const {},
      this.excludedTagsMode = TagMode.or,
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

  @override
  @JsonKey()
  final TagMode includedTagsMode;
  final Set<Tag> _excludedTags;
  @override
  @JsonKey()
  Set<Tag> get excludedTags {
    if (_excludedTags is EqualUnmodifiableSetView) return _excludedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_excludedTags);
  }

  @override
  @JsonKey()
  final TagMode excludedTagsMode;
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
    return 'MangaFilters(includedTags: $includedTags, includedTagsMode: $includedTagsMode, excludedTags: $excludedTags, excludedTagsMode: $excludedTagsMode, status: $status, publicationDemographic: $publicationDemographic, contentRating: $contentRating, order: $order)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaFilters'))
      ..add(DiagnosticsProperty('includedTags', includedTags))
      ..add(DiagnosticsProperty('includedTagsMode', includedTagsMode))
      ..add(DiagnosticsProperty('excludedTags', excludedTags))
      ..add(DiagnosticsProperty('excludedTagsMode', excludedTagsMode))
      ..add(DiagnosticsProperty('status', status))
      ..add(
          DiagnosticsProperty('publicationDemographic', publicationDemographic))
      ..add(DiagnosticsProperty('contentRating', contentRating))
      ..add(DiagnosticsProperty('order', order));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaFiltersImpl &&
            const DeepCollectionEquality()
                .equals(other._includedTags, _includedTags) &&
            (identical(other.includedTagsMode, includedTagsMode) ||
                other.includedTagsMode == includedTagsMode) &&
            const DeepCollectionEquality()
                .equals(other._excludedTags, _excludedTags) &&
            (identical(other.excludedTagsMode, excludedTagsMode) ||
                other.excludedTagsMode == excludedTagsMode) &&
            const DeepCollectionEquality().equals(other._status, _status) &&
            const DeepCollectionEquality().equals(
                other._publicationDemographic, _publicationDemographic) &&
            const DeepCollectionEquality()
                .equals(other._contentRating, _contentRating) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_includedTags),
      includedTagsMode,
      const DeepCollectionEquality().hash(_excludedTags),
      excludedTagsMode,
      const DeepCollectionEquality().hash(_status),
      const DeepCollectionEquality().hash(_publicationDemographic),
      const DeepCollectionEquality().hash(_contentRating),
      order);

  /// Create a copy of MangaFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      final TagMode includedTagsMode,
      final Set<Tag> excludedTags,
      final TagMode excludedTagsMode,
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
  TagMode get includedTagsMode;
  @override
  Set<Tag> get excludedTags;
  @override
  TagMode get excludedTagsMode;
  @override
  Set<MangaStatus> get status;
  @override
  Set<MangaDemographic> get publicationDemographic;
  @override
  Set<ContentRating> get contentRating;
  @override
  FilterOrder get order;

  /// Create a copy of MangaFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MangaFiltersImplCopyWith<_$MangaFiltersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MangaSearchParameters {
  String get query => throw _privateConstructorUsedError;
  MangaFilters get filter => throw _privateConstructorUsedError;

  /// Create a copy of MangaSearchParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MangaSearchParameters
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaSearchParameters
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaSearchParameters
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaSearchParametersImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, filter);

  /// Create a copy of MangaSearchParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MangaSearchParameters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MangaSearchParametersImplCopyWith<_$MangaSearchParametersImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MangaDexEntity _$MangaDexEntityFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'chapter':
      return Chapter.fromJson(json);
    case 'manga':
      return Manga.fromJson(json);
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
    case 'custom_list':
      return CustomList.fromJson(json);
    case 'error':
      return MDError.fromJson(json);
    case 'tag':
      return Tag.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'MangaDexEntity',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$MangaDexEntity {
  String get id => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)
        chapter,
    required TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)
        manga,
    required TResult Function(String id, UserAttributes? attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
    required TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)
        customList,
    required TResult Function(String id, int status, String title,
            String? detail, String? context)
        error,
    required TResult Function(String id, TagAttributes attributes) tag,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult? Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult? Function(String id, UserAttributes? attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult? Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult? Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult? Function(String id, TagAttributes attributes)? tag,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult Function(String id, UserAttributes? attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult Function(String id, TagAttributes attributes)? tag,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Chapter value) chapter,
    required TResult Function(Manga value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
    required TResult Function(CustomList value) customList,
    required TResult Function(MDError value) error,
    required TResult Function(Tag value) tag,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Chapter value)? chapter,
    TResult? Function(Manga value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
    TResult? Function(CustomList value)? customList,
    TResult? Function(MDError value)? error,
    TResult? Function(Tag value)? tag,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Chapter value)? chapter,
    TResult Function(Manga value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    TResult Function(CustomList value)? customList,
    TResult Function(MDError value)? error,
    TResult Function(Tag value)? tag,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this MangaDexEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MangaDexEntityCopyWith<MangaDexEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaDexEntityCopyWith<$Res> {
  factory $MangaDexEntityCopyWith(
          MangaDexEntity value, $Res Function(MangaDexEntity) then) =
      _$MangaDexEntityCopyWithImpl<$Res, MangaDexEntity>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$MangaDexEntityCopyWithImpl<$Res, $Val extends MangaDexEntity>
    implements $MangaDexEntityCopyWith<$Res> {
  _$MangaDexEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$ChapterImplCopyWith<$Res>
    implements $MangaDexEntityCopyWith<$Res> {
  factory _$$ChapterImplCopyWith(
          _$ChapterImpl value, $Res Function(_$ChapterImpl) then) =
      __$$ChapterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ChapterAttributes attributes,
      List<MangaDexEntity> relationships});

  $ChapterAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$ChapterImplCopyWithImpl<$Res>
    extends _$MangaDexEntityCopyWithImpl<$Res, _$ChapterImpl>
    implements _$$ChapterImplCopyWith<$Res> {
  __$$ChapterImplCopyWithImpl(
      _$ChapterImpl _value, $Res Function(_$ChapterImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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
              as List<MangaDexEntity>,
    ));
  }

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChapterAttributesCopyWith<$Res> get attributes {
    return $ChapterAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ChapterImpl
    with DiagnosticableTreeMixin, ChapterOps
    implements Chapter {
  _$ChapterImpl(
      {required this.id,
      required this.attributes,
      required final List<MangaDexEntity> relationships,
      final String? $type})
      : _relationships = relationships,
        $type = $type ?? 'chapter';

  factory _$ChapterImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterImplFromJson(json);

  @override
  final String id;
  @override
  final ChapterAttributes attributes;
  final List<MangaDexEntity> _relationships;
  @override
  List<MangaDexEntity> get relationships {
    if (_relationships is EqualUnmodifiableListView) return _relationships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relationships);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaDexEntity.chapter(id: $id, attributes: $attributes, relationships: $relationships)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaDexEntity.chapter'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes))
      ..add(DiagnosticsProperty('relationships', relationships));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes) &&
            const DeepCollectionEquality()
                .equals(other._relationships, _relationships));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes,
      const DeepCollectionEquality().hash(_relationships));

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
      __$$ChapterImplCopyWithImpl<_$ChapterImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)
        chapter,
    required TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)
        manga,
    required TResult Function(String id, UserAttributes? attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
    required TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)
        customList,
    required TResult Function(String id, int status, String title,
            String? detail, String? context)
        error,
    required TResult Function(String id, TagAttributes attributes) tag,
  }) {
    return chapter(id, attributes, relationships);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult? Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult? Function(String id, UserAttributes? attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult? Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult? Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult? Function(String id, TagAttributes attributes)? tag,
  }) {
    return chapter?.call(id, attributes, relationships);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult Function(String id, UserAttributes? attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult Function(String id, TagAttributes attributes)? tag,
    required TResult orElse(),
  }) {
    if (chapter != null) {
      return chapter(id, attributes, relationships);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Chapter value) chapter,
    required TResult Function(Manga value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
    required TResult Function(CustomList value) customList,
    required TResult Function(MDError value) error,
    required TResult Function(Tag value) tag,
  }) {
    return chapter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Chapter value)? chapter,
    TResult? Function(Manga value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
    TResult? Function(CustomList value)? customList,
    TResult? Function(MDError value)? error,
    TResult? Function(Tag value)? tag,
  }) {
    return chapter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Chapter value)? chapter,
    TResult Function(Manga value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    TResult Function(CustomList value)? customList,
    TResult Function(MDError value)? error,
    TResult Function(Tag value)? tag,
    required TResult orElse(),
  }) {
    if (chapter != null) {
      return chapter(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterImplToJson(
      this,
    );
  }
}

abstract class Chapter implements MangaDexEntity, ChapterOps {
  factory Chapter(
      {required final String id,
      required final ChapterAttributes attributes,
      required final List<MangaDexEntity> relationships}) = _$ChapterImpl;

  factory Chapter.fromJson(Map<String, dynamic> json) = _$ChapterImpl.fromJson;

  @override
  String get id;
  ChapterAttributes get attributes;
  List<MangaDexEntity> get relationships;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MangaImplCopyWith<$Res>
    implements $MangaDexEntityCopyWith<$Res> {
  factory _$$MangaImplCopyWith(
          _$MangaImpl value, $Res Function(_$MangaImpl) then) =
      __$$MangaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      MangaAttributes? attributes,
      List<MangaDexEntity>? relationships,
      MangaRelations? related});

  $MangaAttributesCopyWith<$Res>? get attributes;
}

/// @nodoc
class __$$MangaImplCopyWithImpl<$Res>
    extends _$MangaDexEntityCopyWithImpl<$Res, _$MangaImpl>
    implements _$$MangaImplCopyWith<$Res> {
  __$$MangaImplCopyWithImpl(
      _$MangaImpl _value, $Res Function(_$MangaImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = freezed,
    Object? relationships = freezed,
    Object? related = freezed,
  }) {
    return _then(_$MangaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: freezed == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as MangaAttributes?,
      relationships: freezed == relationships
          ? _value._relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as List<MangaDexEntity>?,
      related: freezed == related
          ? _value.related
          : related // ignore: cast_nullable_to_non_nullable
              as MangaRelations?,
    ));
  }

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MangaAttributesCopyWith<$Res>? get attributes {
    if (_value.attributes == null) {
      return null;
    }

    return $MangaAttributesCopyWith<$Res>(_value.attributes!, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaImpl with DiagnosticableTreeMixin, MangaOps implements Manga {
  _$MangaImpl(
      {required this.id,
      this.attributes,
      final List<MangaDexEntity>? relationships,
      this.related,
      final String? $type})
      : _relationships = relationships,
        $type = $type ?? 'manga';

  factory _$MangaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaImplFromJson(json);

  @override
  final String id;
  @override
  final MangaAttributes? attributes;
  final List<MangaDexEntity>? _relationships;
  @override
  List<MangaDexEntity>? get relationships {
    final value = _relationships;
    if (value == null) return null;
    if (_relationships is EqualUnmodifiableListView) return _relationships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final MangaRelations? related;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaDexEntity.manga(id: $id, attributes: $attributes, relationships: $relationships, related: $related)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaDexEntity.manga'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes))
      ..add(DiagnosticsProperty('relationships', relationships))
      ..add(DiagnosticsProperty('related', related));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes) &&
            const DeepCollectionEquality()
                .equals(other._relationships, _relationships) &&
            (identical(other.related, related) || other.related == related));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes,
      const DeepCollectionEquality().hash(_relationships), related);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaImplCopyWith<_$MangaImpl> get copyWith =>
      __$$MangaImplCopyWithImpl<_$MangaImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)
        chapter,
    required TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)
        manga,
    required TResult Function(String id, UserAttributes? attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
    required TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)
        customList,
    required TResult Function(String id, int status, String title,
            String? detail, String? context)
        error,
    required TResult Function(String id, TagAttributes attributes) tag,
  }) {
    return manga(id, attributes, relationships, related);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult? Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult? Function(String id, UserAttributes? attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult? Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult? Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult? Function(String id, TagAttributes attributes)? tag,
  }) {
    return manga?.call(id, attributes, relationships, related);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult Function(String id, UserAttributes? attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult Function(String id, TagAttributes attributes)? tag,
    required TResult orElse(),
  }) {
    if (manga != null) {
      return manga(id, attributes, relationships, related);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Chapter value) chapter,
    required TResult Function(Manga value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
    required TResult Function(CustomList value) customList,
    required TResult Function(MDError value) error,
    required TResult Function(Tag value) tag,
  }) {
    return manga(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Chapter value)? chapter,
    TResult? Function(Manga value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
    TResult? Function(CustomList value)? customList,
    TResult? Function(MDError value)? error,
    TResult? Function(Tag value)? tag,
  }) {
    return manga?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Chapter value)? chapter,
    TResult Function(Manga value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    TResult Function(CustomList value)? customList,
    TResult Function(MDError value)? error,
    TResult Function(Tag value)? tag,
    required TResult orElse(),
  }) {
    if (manga != null) {
      return manga(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaImplToJson(
      this,
    );
  }
}

abstract class Manga implements MangaDexEntity, MangaOps {
  factory Manga(
      {required final String id,
      final MangaAttributes? attributes,
      final List<MangaDexEntity>? relationships,
      final MangaRelations? related}) = _$MangaImpl;

  factory Manga.fromJson(Map<String, dynamic> json) = _$MangaImpl.fromJson;

  @override
  String get id;
  MangaAttributes? get attributes;
  List<MangaDexEntity>? get relationships;
  MangaRelations? get related;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MangaImplCopyWith<_$MangaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res>
    implements $MangaDexEntityCopyWith<$Res> {
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
    extends _$MangaDexEntityCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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
  const _$UserImpl({required this.id, this.attributes, final String? $type})
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
    return 'MangaDexEntity.user(id: $id, attributes: $attributes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaDexEntity.user'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)
        chapter,
    required TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)
        manga,
    required TResult Function(String id, UserAttributes? attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
    required TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)
        customList,
    required TResult Function(String id, int status, String title,
            String? detail, String? context)
        error,
    required TResult Function(String id, TagAttributes attributes) tag,
  }) {
    return user(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult? Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult? Function(String id, UserAttributes? attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult? Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult? Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult? Function(String id, TagAttributes attributes)? tag,
  }) {
    return user?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult Function(String id, UserAttributes? attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult Function(String id, TagAttributes attributes)? tag,
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
    required TResult Function(Chapter value) chapter,
    required TResult Function(Manga value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
    required TResult Function(CustomList value) customList,
    required TResult Function(MDError value) error,
    required TResult Function(Tag value) tag,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Chapter value)? chapter,
    TResult? Function(Manga value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
    TResult? Function(CustomList value)? customList,
    TResult? Function(MDError value)? error,
    TResult? Function(Tag value)? tag,
  }) {
    return user?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Chapter value)? chapter,
    TResult Function(Manga value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    TResult Function(CustomList value)? customList,
    TResult Function(MDError value)? error,
    TResult Function(Tag value)? tag,
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

abstract class User implements MangaDexEntity {
  const factory User(
      {required final String id,
      final UserAttributes? attributes}) = _$UserImpl;

  factory User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  UserAttributes? get attributes;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ArtistImplCopyWith<$Res>
    implements $MangaDexEntityCopyWith<$Res> {
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
    extends _$MangaDexEntityCopyWithImpl<$Res, _$ArtistImpl>
    implements _$$ArtistImplCopyWith<$Res> {
  __$$ArtistImplCopyWithImpl(
      _$ArtistImpl _value, $Res Function(_$ArtistImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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
    return 'MangaDexEntity.artist(id: $id, attributes: $attributes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaDexEntity.artist'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtistImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtistImplCopyWith<_$ArtistImpl> get copyWith =>
      __$$ArtistImplCopyWithImpl<_$ArtistImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)
        chapter,
    required TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)
        manga,
    required TResult Function(String id, UserAttributes? attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
    required TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)
        customList,
    required TResult Function(String id, int status, String title,
            String? detail, String? context)
        error,
    required TResult Function(String id, TagAttributes attributes) tag,
  }) {
    return artist(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult? Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult? Function(String id, UserAttributes? attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult? Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult? Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult? Function(String id, TagAttributes attributes)? tag,
  }) {
    return artist?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult Function(String id, UserAttributes? attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult Function(String id, TagAttributes attributes)? tag,
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
    required TResult Function(Chapter value) chapter,
    required TResult Function(Manga value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
    required TResult Function(CustomList value) customList,
    required TResult Function(MDError value) error,
    required TResult Function(Tag value) tag,
  }) {
    return artist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Chapter value)? chapter,
    TResult? Function(Manga value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
    TResult? Function(CustomList value)? customList,
    TResult? Function(MDError value)? error,
    TResult? Function(Tag value)? tag,
  }) {
    return artist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Chapter value)? chapter,
    TResult Function(Manga value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    TResult Function(CustomList value)? customList,
    TResult Function(MDError value)? error,
    TResult Function(Tag value)? tag,
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

abstract class Artist implements MangaDexEntity, CreatorType {
  const factory Artist(
      {required final String id,
      required final AuthorAttributes attributes}) = _$ArtistImpl;

  factory Artist.fromJson(Map<String, dynamic> json) = _$ArtistImpl.fromJson;

  @override
  String get id;
  AuthorAttributes get attributes;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtistImplCopyWith<_$ArtistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthorImplCopyWith<$Res>
    implements $MangaDexEntityCopyWith<$Res> {
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
    extends _$MangaDexEntityCopyWithImpl<$Res, _$AuthorImpl>
    implements _$$AuthorImplCopyWith<$Res> {
  __$$AuthorImplCopyWithImpl(
      _$AuthorImpl _value, $Res Function(_$AuthorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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
    return 'MangaDexEntity.author(id: $id, attributes: $attributes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaDexEntity.author'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthorImplCopyWith<_$AuthorImpl> get copyWith =>
      __$$AuthorImplCopyWithImpl<_$AuthorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)
        chapter,
    required TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)
        manga,
    required TResult Function(String id, UserAttributes? attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
    required TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)
        customList,
    required TResult Function(String id, int status, String title,
            String? detail, String? context)
        error,
    required TResult Function(String id, TagAttributes attributes) tag,
  }) {
    return author(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult? Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult? Function(String id, UserAttributes? attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult? Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult? Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult? Function(String id, TagAttributes attributes)? tag,
  }) {
    return author?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult Function(String id, UserAttributes? attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult Function(String id, TagAttributes attributes)? tag,
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
    required TResult Function(Chapter value) chapter,
    required TResult Function(Manga value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
    required TResult Function(CustomList value) customList,
    required TResult Function(MDError value) error,
    required TResult Function(Tag value) tag,
  }) {
    return author(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Chapter value)? chapter,
    TResult? Function(Manga value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
    TResult? Function(CustomList value)? customList,
    TResult? Function(MDError value)? error,
    TResult? Function(Tag value)? tag,
  }) {
    return author?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Chapter value)? chapter,
    TResult Function(Manga value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    TResult Function(CustomList value)? customList,
    TResult Function(MDError value)? error,
    TResult Function(Tag value)? tag,
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

abstract class Author implements MangaDexEntity, CreatorType {
  const factory Author(
      {required final String id,
      required final AuthorAttributes attributes}) = _$AuthorImpl;

  factory Author.fromJson(Map<String, dynamic> json) = _$AuthorImpl.fromJson;

  @override
  String get id;
  AuthorAttributes get attributes;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthorImplCopyWith<_$AuthorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreatorIDImplCopyWith<$Res>
    implements $MangaDexEntityCopyWith<$Res> {
  factory _$$CreatorIDImplCopyWith(
          _$CreatorIDImpl value, $Res Function(_$CreatorIDImpl) then) =
      __$$CreatorIDImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$CreatorIDImplCopyWithImpl<$Res>
    extends _$MangaDexEntityCopyWithImpl<$Res, _$CreatorIDImpl>
    implements _$$CreatorIDImplCopyWith<$Res> {
  __$$CreatorIDImplCopyWithImpl(
      _$CreatorIDImpl _value, $Res Function(_$CreatorIDImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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
    return 'MangaDexEntity.creator(id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaDexEntity.creator'))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatorIDImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatorIDImplCopyWith<_$CreatorIDImpl> get copyWith =>
      __$$CreatorIDImplCopyWithImpl<_$CreatorIDImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)
        chapter,
    required TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)
        manga,
    required TResult Function(String id, UserAttributes? attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
    required TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)
        customList,
    required TResult Function(String id, int status, String title,
            String? detail, String? context)
        error,
    required TResult Function(String id, TagAttributes attributes) tag,
  }) {
    return creator(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult? Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult? Function(String id, UserAttributes? attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult? Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult? Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult? Function(String id, TagAttributes attributes)? tag,
  }) {
    return creator?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult Function(String id, UserAttributes? attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult Function(String id, TagAttributes attributes)? tag,
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
    required TResult Function(Chapter value) chapter,
    required TResult Function(Manga value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
    required TResult Function(CustomList value) customList,
    required TResult Function(MDError value) error,
    required TResult Function(Tag value) tag,
  }) {
    return creator(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Chapter value)? chapter,
    TResult? Function(Manga value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
    TResult? Function(CustomList value)? customList,
    TResult? Function(MDError value)? error,
    TResult? Function(Tag value)? tag,
  }) {
    return creator?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Chapter value)? chapter,
    TResult Function(Manga value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    TResult Function(CustomList value)? customList,
    TResult Function(MDError value)? error,
    TResult Function(Tag value)? tag,
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

abstract class CreatorID implements MangaDexEntity {
  const factory CreatorID({required final String id}) = _$CreatorIDImpl;

  factory CreatorID.fromJson(Map<String, dynamic> json) =
      _$CreatorIDImpl.fromJson;

  @override
  String get id;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatorIDImplCopyWith<_$CreatorIDImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CoverArtImplCopyWith<$Res>
    implements $MangaDexEntityCopyWith<$Res> {
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
    extends _$MangaDexEntityCopyWithImpl<$Res, _$CoverArtImpl>
    implements _$$CoverArtImplCopyWith<$Res> {
  __$$CoverArtImplCopyWithImpl(
      _$CoverArtImpl _value, $Res Function(_$CoverArtImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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
  const _$CoverArtImpl({required this.id, this.attributes, final String? $type})
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
    return 'MangaDexEntity.cover(id: $id, attributes: $attributes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaDexEntity.cover'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoverArtImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoverArtImplCopyWith<_$CoverArtImpl> get copyWith =>
      __$$CoverArtImplCopyWithImpl<_$CoverArtImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)
        chapter,
    required TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)
        manga,
    required TResult Function(String id, UserAttributes? attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
    required TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)
        customList,
    required TResult Function(String id, int status, String title,
            String? detail, String? context)
        error,
    required TResult Function(String id, TagAttributes attributes) tag,
  }) {
    return cover(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult? Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult? Function(String id, UserAttributes? attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult? Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult? Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult? Function(String id, TagAttributes attributes)? tag,
  }) {
    return cover?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult Function(String id, UserAttributes? attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult Function(String id, TagAttributes attributes)? tag,
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
    required TResult Function(Chapter value) chapter,
    required TResult Function(Manga value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
    required TResult Function(CustomList value) customList,
    required TResult Function(MDError value) error,
    required TResult Function(Tag value) tag,
  }) {
    return cover(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Chapter value)? chapter,
    TResult? Function(Manga value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
    TResult? Function(CustomList value)? customList,
    TResult? Function(MDError value)? error,
    TResult? Function(Tag value)? tag,
  }) {
    return cover?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Chapter value)? chapter,
    TResult Function(Manga value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    TResult Function(CustomList value)? customList,
    TResult Function(MDError value)? error,
    TResult Function(Tag value)? tag,
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

abstract class CoverArt implements MangaDexEntity {
  const factory CoverArt(
      {required final String id,
      final CoverArtAttributes? attributes}) = _$CoverArtImpl;

  factory CoverArt.fromJson(Map<String, dynamic> json) =
      _$CoverArtImpl.fromJson;

  @override
  String get id;
  CoverArtAttributes? get attributes;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoverArtImplCopyWith<_$CoverArtImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupImplCopyWith<$Res>
    implements $MangaDexEntityCopyWith<$Res> {
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
    extends _$MangaDexEntityCopyWithImpl<$Res, _$GroupImpl>
    implements _$$GroupImplCopyWith<$Res> {
  __$$GroupImplCopyWithImpl(
      _$GroupImpl _value, $Res Function(_$GroupImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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
    return 'MangaDexEntity.group(id: $id, attributes: $attributes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaDexEntity.group'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      __$$GroupImplCopyWithImpl<_$GroupImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)
        chapter,
    required TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)
        manga,
    required TResult Function(String id, UserAttributes? attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
    required TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)
        customList,
    required TResult Function(String id, int status, String title,
            String? detail, String? context)
        error,
    required TResult Function(String id, TagAttributes attributes) tag,
  }) {
    return group(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult? Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult? Function(String id, UserAttributes? attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult? Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult? Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult? Function(String id, TagAttributes attributes)? tag,
  }) {
    return group?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult Function(String id, UserAttributes? attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult Function(String id, TagAttributes attributes)? tag,
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
    required TResult Function(Chapter value) chapter,
    required TResult Function(Manga value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
    required TResult Function(CustomList value) customList,
    required TResult Function(MDError value) error,
    required TResult Function(Tag value) tag,
  }) {
    return group(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Chapter value)? chapter,
    TResult? Function(Manga value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
    TResult? Function(CustomList value)? customList,
    TResult? Function(MDError value)? error,
    TResult? Function(Tag value)? tag,
  }) {
    return group?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Chapter value)? chapter,
    TResult Function(Manga value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    TResult Function(CustomList value)? customList,
    TResult Function(MDError value)? error,
    TResult Function(Tag value)? tag,
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

abstract class Group implements MangaDexEntity {
  const factory Group(
      {required final String id,
      required final ScanlationGroupAttributes attributes}) = _$GroupImpl;

  factory Group.fromJson(Map<String, dynamic> json) = _$GroupImpl.fromJson;

  @override
  String get id;
  ScanlationGroupAttributes get attributes;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomListImplCopyWith<$Res>
    implements $MangaDexEntityCopyWith<$Res> {
  factory _$$CustomListImplCopyWith(
          _$CustomListImpl value, $Res Function(_$CustomListImpl) then) =
      __$$CustomListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      CustomListAttributes attributes,
      List<MangaDexEntity> relationships});

  $CustomListAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$CustomListImplCopyWithImpl<$Res>
    extends _$MangaDexEntityCopyWithImpl<$Res, _$CustomListImpl>
    implements _$$CustomListImplCopyWith<$Res> {
  __$$CustomListImplCopyWithImpl(
      _$CustomListImpl _value, $Res Function(_$CustomListImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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
              as List<MangaDexEntity>,
    ));
  }

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomListAttributesCopyWith<$Res> get attributes {
    return $CustomListAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomListImpl
    with DiagnosticableTreeMixin, CustomListOps
    implements CustomList {
  _$CustomListImpl(
      {required this.id,
      required this.attributes,
      required final List<MangaDexEntity> relationships,
      final String? $type})
      : _relationships = relationships,
        $type = $type ?? 'custom_list';

  factory _$CustomListImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomListImplFromJson(json);

  @override
  final String id;
  @override
  final CustomListAttributes attributes;
  final List<MangaDexEntity> _relationships;
  @override
  List<MangaDexEntity> get relationships {
    if (_relationships is EqualUnmodifiableListView) return _relationships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relationships);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaDexEntity.customList(id: $id, attributes: $attributes, relationships: $relationships)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaDexEntity.customList'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes))
      ..add(DiagnosticsProperty('relationships', relationships));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes) &&
            const DeepCollectionEquality()
                .equals(other._relationships, _relationships));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes,
      const DeepCollectionEquality().hash(_relationships));

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomListImplCopyWith<_$CustomListImpl> get copyWith =>
      __$$CustomListImplCopyWithImpl<_$CustomListImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)
        chapter,
    required TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)
        manga,
    required TResult Function(String id, UserAttributes? attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
    required TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)
        customList,
    required TResult Function(String id, int status, String title,
            String? detail, String? context)
        error,
    required TResult Function(String id, TagAttributes attributes) tag,
  }) {
    return customList(id, attributes, relationships);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult? Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult? Function(String id, UserAttributes? attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult? Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult? Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult? Function(String id, TagAttributes attributes)? tag,
  }) {
    return customList?.call(id, attributes, relationships);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult Function(String id, UserAttributes? attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult Function(String id, TagAttributes attributes)? tag,
    required TResult orElse(),
  }) {
    if (customList != null) {
      return customList(id, attributes, relationships);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Chapter value) chapter,
    required TResult Function(Manga value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
    required TResult Function(CustomList value) customList,
    required TResult Function(MDError value) error,
    required TResult Function(Tag value) tag,
  }) {
    return customList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Chapter value)? chapter,
    TResult? Function(Manga value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
    TResult? Function(CustomList value)? customList,
    TResult? Function(MDError value)? error,
    TResult? Function(Tag value)? tag,
  }) {
    return customList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Chapter value)? chapter,
    TResult Function(Manga value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    TResult Function(CustomList value)? customList,
    TResult Function(MDError value)? error,
    TResult Function(Tag value)? tag,
    required TResult orElse(),
  }) {
    if (customList != null) {
      return customList(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomListImplToJson(
      this,
    );
  }
}

abstract class CustomList implements MangaDexEntity, CustomListOps {
  factory CustomList(
      {required final String id,
      required final CustomListAttributes attributes,
      required final List<MangaDexEntity> relationships}) = _$CustomListImpl;

  factory CustomList.fromJson(Map<String, dynamic> json) =
      _$CustomListImpl.fromJson;

  @override
  String get id;
  CustomListAttributes get attributes;
  List<MangaDexEntity> get relationships;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomListImplCopyWith<_$CustomListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MDErrorImplCopyWith<$Res>
    implements $MangaDexEntityCopyWith<$Res> {
  factory _$$MDErrorImplCopyWith(
          _$MDErrorImpl value, $Res Function(_$MDErrorImpl) then) =
      __$$MDErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, int status, String title, String? detail, String? context});
}

/// @nodoc
class __$$MDErrorImplCopyWithImpl<$Res>
    extends _$MangaDexEntityCopyWithImpl<$Res, _$MDErrorImpl>
    implements _$$MDErrorImplCopyWith<$Res> {
  __$$MDErrorImplCopyWithImpl(
      _$MDErrorImpl _value, $Res Function(_$MDErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? title = null,
    Object? detail = freezed,
    Object? context = freezed,
  }) {
    return _then(_$MDErrorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MDErrorImpl with DiagnosticableTreeMixin implements MDError {
  const _$MDErrorImpl(
      {required this.id,
      required this.status,
      required this.title,
      this.detail,
      this.context,
      final String? $type})
      : $type = $type ?? 'error';

  factory _$MDErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$MDErrorImplFromJson(json);

  @override
  final String id;
  @override
  final int status;
  @override
  final String title;
  @override
  final String? detail;
  @override
  final String? context;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaDexEntity.error(id: $id, status: $status, title: $title, detail: $detail, context: $context)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaDexEntity.error'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('detail', detail))
      ..add(DiagnosticsProperty('context', context));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MDErrorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.context, context) || other.context == context));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, status, title, detail, context);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MDErrorImplCopyWith<_$MDErrorImpl> get copyWith =>
      __$$MDErrorImplCopyWithImpl<_$MDErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)
        chapter,
    required TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)
        manga,
    required TResult Function(String id, UserAttributes? attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
    required TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)
        customList,
    required TResult Function(String id, int status, String title,
            String? detail, String? context)
        error,
    required TResult Function(String id, TagAttributes attributes) tag,
  }) {
    return error(id, status, title, detail, context);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult? Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult? Function(String id, UserAttributes? attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult? Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult? Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult? Function(String id, TagAttributes attributes)? tag,
  }) {
    return error?.call(id, status, title, detail, context);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult Function(String id, UserAttributes? attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult Function(String id, TagAttributes attributes)? tag,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(id, status, title, detail, context);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Chapter value) chapter,
    required TResult Function(Manga value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
    required TResult Function(CustomList value) customList,
    required TResult Function(MDError value) error,
    required TResult Function(Tag value) tag,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Chapter value)? chapter,
    TResult? Function(Manga value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
    TResult? Function(CustomList value)? customList,
    TResult? Function(MDError value)? error,
    TResult? Function(Tag value)? tag,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Chapter value)? chapter,
    TResult Function(Manga value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    TResult Function(CustomList value)? customList,
    TResult Function(MDError value)? error,
    TResult Function(Tag value)? tag,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MDErrorImplToJson(
      this,
    );
  }
}

abstract class MDError implements MangaDexEntity {
  const factory MDError(
      {required final String id,
      required final int status,
      required final String title,
      final String? detail,
      final String? context}) = _$MDErrorImpl;

  factory MDError.fromJson(Map<String, dynamic> json) = _$MDErrorImpl.fromJson;

  @override
  String get id;
  int get status;
  String get title;
  String? get detail;
  String? get context;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MDErrorImplCopyWith<_$MDErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TagImplCopyWith<$Res>
    implements $MangaDexEntityCopyWith<$Res> {
  factory _$$TagImplCopyWith(_$TagImpl value, $Res Function(_$TagImpl) then) =
      __$$TagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, TagAttributes attributes});

  $TagAttributesCopyWith<$Res> get attributes;
}

/// @nodoc
class __$$TagImplCopyWithImpl<$Res>
    extends _$MangaDexEntityCopyWithImpl<$Res, _$TagImpl>
    implements _$$TagImplCopyWith<$Res> {
  __$$TagImplCopyWithImpl(_$TagImpl _value, $Res Function(_$TagImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TagAttributesCopyWith<$Res> get attributes {
    return $TagAttributesCopyWith<$Res>(_value.attributes, (value) {
      return _then(_value.copyWith(attributes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TagImpl with DiagnosticableTreeMixin implements Tag {
  const _$TagImpl(
      {required this.id, required this.attributes, final String? $type})
      : $type = $type ?? 'tag';

  factory _$TagImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagImplFromJson(json);

  @override
  final String id;
  @override
  final TagAttributes attributes;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MangaDexEntity.tag(id: $id, attributes: $attributes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MangaDexEntity.tag'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('attributes', attributes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, attributes);

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagImplCopyWith<_$TagImpl> get copyWith =>
      __$$TagImplCopyWithImpl<_$TagImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)
        chapter,
    required TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)
        manga,
    required TResult Function(String id, UserAttributes? attributes) user,
    required TResult Function(String id, AuthorAttributes attributes) artist,
    required TResult Function(String id, AuthorAttributes attributes) author,
    required TResult Function(String id) creator,
    required TResult Function(String id, CoverArtAttributes? attributes) cover,
    required TResult Function(String id, ScanlationGroupAttributes attributes)
        group,
    required TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)
        customList,
    required TResult Function(String id, int status, String title,
            String? detail, String? context)
        error,
    required TResult Function(String id, TagAttributes attributes) tag,
  }) {
    return tag(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult? Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult? Function(String id, UserAttributes? attributes)? user,
    TResult? Function(String id, AuthorAttributes attributes)? artist,
    TResult? Function(String id, AuthorAttributes attributes)? author,
    TResult? Function(String id)? creator,
    TResult? Function(String id, CoverArtAttributes? attributes)? cover,
    TResult? Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult? Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult? Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult? Function(String id, TagAttributes attributes)? tag,
  }) {
    return tag?.call(id, attributes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ChapterAttributes attributes,
            List<MangaDexEntity> relationships)?
        chapter,
    TResult Function(String id, MangaAttributes? attributes,
            List<MangaDexEntity>? relationships, MangaRelations? related)?
        manga,
    TResult Function(String id, UserAttributes? attributes)? user,
    TResult Function(String id, AuthorAttributes attributes)? artist,
    TResult Function(String id, AuthorAttributes attributes)? author,
    TResult Function(String id)? creator,
    TResult Function(String id, CoverArtAttributes? attributes)? cover,
    TResult Function(String id, ScanlationGroupAttributes attributes)? group,
    TResult Function(String id, CustomListAttributes attributes,
            List<MangaDexEntity> relationships)?
        customList,
    TResult Function(String id, int status, String title, String? detail,
            String? context)?
        error,
    TResult Function(String id, TagAttributes attributes)? tag,
    required TResult orElse(),
  }) {
    if (tag != null) {
      return tag(id, attributes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Chapter value) chapter,
    required TResult Function(Manga value) manga,
    required TResult Function(User value) user,
    required TResult Function(Artist value) artist,
    required TResult Function(Author value) author,
    required TResult Function(CreatorID value) creator,
    required TResult Function(CoverArt value) cover,
    required TResult Function(Group value) group,
    required TResult Function(CustomList value) customList,
    required TResult Function(MDError value) error,
    required TResult Function(Tag value) tag,
  }) {
    return tag(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Chapter value)? chapter,
    TResult? Function(Manga value)? manga,
    TResult? Function(User value)? user,
    TResult? Function(Artist value)? artist,
    TResult? Function(Author value)? author,
    TResult? Function(CreatorID value)? creator,
    TResult? Function(CoverArt value)? cover,
    TResult? Function(Group value)? group,
    TResult? Function(CustomList value)? customList,
    TResult? Function(MDError value)? error,
    TResult? Function(Tag value)? tag,
  }) {
    return tag?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Chapter value)? chapter,
    TResult Function(Manga value)? manga,
    TResult Function(User value)? user,
    TResult Function(Artist value)? artist,
    TResult Function(Author value)? author,
    TResult Function(CreatorID value)? creator,
    TResult Function(CoverArt value)? cover,
    TResult Function(Group value)? group,
    TResult Function(CustomList value)? customList,
    TResult Function(MDError value)? error,
    TResult Function(Tag value)? tag,
    required TResult orElse(),
  }) {
    if (tag != null) {
      return tag(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TagImplToJson(
      this,
    );
  }
}

abstract class Tag implements MangaDexEntity {
  const factory Tag(
      {required final String id,
      required final TagAttributes attributes}) = _$TagImpl;

  factory Tag.fromJson(Map<String, dynamic> json) = _$TagImpl.fromJson;

  @override
  String get id;
  TagAttributes get attributes;

  /// Create a copy of MangaDexEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagImplCopyWith<_$TagImpl> get copyWith =>
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

  /// Serializes this ChapterAPIData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChapterAPIData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ChapterAPIData
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of ChapterAPIData
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterAPIDataImpl &&
            (identical(other.hash, hash) || other.hash == hash) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality()
                .equals(other._dataSaver, _dataSaver));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      hash,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_dataSaver));

  /// Create a copy of ChapterAPIData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ChapterAPIData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this ChapterAPI to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChapterAPI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ChapterAPI
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of ChapterAPI
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of ChapterAPI
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterAPIImpl &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.chapter, chapter) || other.chapter == chapter));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, baseUrl, chapter);

  /// Create a copy of ChapterAPI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ChapterAPI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChapterAPIImplCopyWith<_$ChapterAPIImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MDEntityList _$MDEntityListFromJson(Map<String, dynamic> json) {
  return _MDEntityList.fromJson(json);
}

/// @nodoc
mixin _$MDEntityList {
  String get result => throw _privateConstructorUsedError;
  String get response => throw _privateConstructorUsedError;
  List<MangaDexEntity> get data => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this MDEntityList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MDEntityList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MDEntityListCopyWith<MDEntityList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MDEntityListCopyWith<$Res> {
  factory $MDEntityListCopyWith(
          MDEntityList value, $Res Function(MDEntityList) then) =
      _$MDEntityListCopyWithImpl<$Res, MDEntityList>;
  @useResult
  $Res call(
      {String result,
      String response,
      List<MangaDexEntity> data,
      int limit,
      int offset,
      int total});
}

/// @nodoc
class _$MDEntityListCopyWithImpl<$Res, $Val extends MDEntityList>
    implements $MDEntityListCopyWith<$Res> {
  _$MDEntityListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MDEntityList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? response = null,
    Object? data = null,
    Object? limit = null,
    Object? offset = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<MangaDexEntity>,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MDEntityListImplCopyWith<$Res>
    implements $MDEntityListCopyWith<$Res> {
  factory _$$MDEntityListImplCopyWith(
          _$MDEntityListImpl value, $Res Function(_$MDEntityListImpl) then) =
      __$$MDEntityListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String result,
      String response,
      List<MangaDexEntity> data,
      int limit,
      int offset,
      int total});
}

/// @nodoc
class __$$MDEntityListImplCopyWithImpl<$Res>
    extends _$MDEntityListCopyWithImpl<$Res, _$MDEntityListImpl>
    implements _$$MDEntityListImplCopyWith<$Res> {
  __$$MDEntityListImplCopyWithImpl(
      _$MDEntityListImpl _value, $Res Function(_$MDEntityListImpl) _then)
      : super(_value, _then);

  /// Create a copy of MDEntityList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? response = null,
    Object? data = null,
    Object? limit = null,
    Object? offset = null,
    Object? total = null,
  }) {
    return _then(_$MDEntityListImpl(
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<MangaDexEntity>,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MDEntityListImpl with DiagnosticableTreeMixin implements _MDEntityList {
  const _$MDEntityListImpl(
      {required this.result,
      required this.response,
      required final List<MangaDexEntity> data,
      required this.limit,
      required this.offset,
      required this.total})
      : _data = data;

  factory _$MDEntityListImpl.fromJson(Map<String, dynamic> json) =>
      _$$MDEntityListImplFromJson(json);

  @override
  final String result;
  @override
  final String response;
  final List<MangaDexEntity> _data;
  @override
  List<MangaDexEntity> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int limit;
  @override
  final int offset;
  @override
  final int total;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MDEntityList(result: $result, response: $response, data: $data, limit: $limit, offset: $offset, total: $total)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MDEntityList'))
      ..add(DiagnosticsProperty('result', result))
      ..add(DiagnosticsProperty('response', response))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('limit', limit))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('total', total));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MDEntityListImpl &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.response, response) ||
                other.response == response) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, result, response,
      const DeepCollectionEquality().hash(_data), limit, offset, total);

  /// Create a copy of MDEntityList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MDEntityListImplCopyWith<_$MDEntityListImpl> get copyWith =>
      __$$MDEntityListImplCopyWithImpl<_$MDEntityListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MDEntityListImplToJson(
      this,
    );
  }
}

abstract class _MDEntityList implements MDEntityList {
  const factory _MDEntityList(
      {required final String result,
      required final String response,
      required final List<MangaDexEntity> data,
      required final int limit,
      required final int offset,
      required final int total}) = _$MDEntityListImpl;

  factory _MDEntityList.fromJson(Map<String, dynamic> json) =
      _$MDEntityListImpl.fromJson;

  @override
  String get result;
  @override
  String get response;
  @override
  List<MangaDexEntity> get data;
  @override
  int get limit;
  @override
  int get offset;
  @override
  int get total;

  /// Create a copy of MDEntityList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MDEntityListImplCopyWith<_$MDEntityListImpl> get copyWith =>
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

  /// Serializes this MangaLinks to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MangaLinks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MangaLinks
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaLinks
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaLinksImpl &&
            (identical(other.raw, raw) || other.raw == raw) &&
            (identical(other.al, al) || other.al == al) &&
            (identical(other.mu, mu) || other.mu == mu) &&
            (identical(other.mal, mal) || other.mal == mal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, raw, al, mu, mal);

  /// Create a copy of MangaLinks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MangaLinks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this MangaAttributes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MangaAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
}

/// @nodoc
class _$MangaAttributesCopyWithImpl<$Res, $Val extends MangaAttributes>
    implements $MangaAttributesCopyWith<$Res> {
  _$MangaAttributesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MangaAttributes
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaAttributes
  /// with the given fields replaced by the non-null parameter values.
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
}

/// @nodoc
class __$$MangaAttributesImplCopyWithImpl<$Res>
    extends _$MangaAttributesCopyWithImpl<$Res, _$MangaAttributesImpl>
    implements _$$MangaAttributesImplCopyWith<$Res> {
  __$$MangaAttributesImplCopyWithImpl(
      _$MangaAttributesImpl _value, $Res Function(_$MangaAttributesImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaAttributes
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MangaAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MangaAttributes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MangaAttributesImplCopyWith<_$MangaAttributesImpl> get copyWith =>
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

  /// Serializes this ChapterAttributes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChapterAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
}

/// @nodoc
class _$ChapterAttributesCopyWithImpl<$Res, $Val extends ChapterAttributes>
    implements $ChapterAttributesCopyWith<$Res> {
  _$ChapterAttributesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChapterAttributes
  /// with the given fields replaced by the non-null parameter values.
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
}

/// @nodoc
class __$$ChapterAttributesImplCopyWithImpl<$Res>
    extends _$ChapterAttributesCopyWithImpl<$Res, _$ChapterAttributesImpl>
    implements _$$ChapterAttributesImplCopyWith<$Res> {
  __$$ChapterAttributesImplCopyWithImpl(_$ChapterAttributesImpl _value,
      $Res Function(_$ChapterAttributesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChapterAttributes
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ChapterAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ChapterAttributes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this ScanlationGroupAttributes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScanlationGroupAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ScanlationGroupAttributes
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of ScanlationGroupAttributes
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanlationGroupAttributesImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.discord, discord) || other.discord == discord) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, website, discord, description);

  /// Create a copy of ScanlationGroupAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ScanlationGroupAttributes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this CoverArtAttributes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CoverArtAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of CoverArtAttributes
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of CoverArtAttributes
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, volume, fileName, description, locale);

  /// Create a copy of CoverArtAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of CoverArtAttributes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoverArtAttributesImplCopyWith<_$CoverArtAttributesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserAttributes _$UserAttributesFromJson(Map<String, dynamic> json) {
  return _UserAttributes.fromJson(json);
}

/// @nodoc
mixin _$UserAttributes {
  String get username => throw _privateConstructorUsedError;

  /// Serializes this UserAttributes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of UserAttributes
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of UserAttributes
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAttributesImpl &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username);

  /// Create a copy of UserAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of UserAttributes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this AuthorAttributes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthorAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of AuthorAttributes
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of AuthorAttributes
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of AuthorAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of AuthorAttributes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthorAttributesImplCopyWith<_$AuthorAttributesImpl> get copyWith =>
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

  /// Serializes this TagAttributes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TagAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of TagAttributes
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of TagAttributes
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagAttributesImpl &&
            const DeepCollectionEquality().equals(other._name, _name) &&
            const DeepCollectionEquality()
                .equals(other._description, _description) &&
            (identical(other.group, group) || other.group == group));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_name),
      const DeepCollectionEquality().hash(_description),
      group);

  /// Create a copy of TagAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of TagAttributes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagAttributesImplCopyWith<_$TagAttributesImpl> get copyWith =>
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

  /// Serializes this MangaStatisticsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MangaStatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MangaStatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaStatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaStatisticsResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._statistics, _statistics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_statistics));

  /// Create a copy of MangaStatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MangaStatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MangaStatisticsResponseImplCopyWith<_$MangaStatisticsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChapterStatisticsResponse _$ChapterStatisticsResponseFromJson(
    Map<String, dynamic> json) {
  return _ChapterStatisticsResponse.fromJson(json);
}

/// @nodoc
mixin _$ChapterStatisticsResponse {
  Map<String, ChapterStatistics> get statistics =>
      throw _privateConstructorUsedError;

  /// Serializes this ChapterStatisticsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChapterStatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChapterStatisticsResponseCopyWith<ChapterStatisticsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterStatisticsResponseCopyWith<$Res> {
  factory $ChapterStatisticsResponseCopyWith(ChapterStatisticsResponse value,
          $Res Function(ChapterStatisticsResponse) then) =
      _$ChapterStatisticsResponseCopyWithImpl<$Res, ChapterStatisticsResponse>;
  @useResult
  $Res call({Map<String, ChapterStatistics> statistics});
}

/// @nodoc
class _$ChapterStatisticsResponseCopyWithImpl<$Res,
        $Val extends ChapterStatisticsResponse>
    implements $ChapterStatisticsResponseCopyWith<$Res> {
  _$ChapterStatisticsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChapterStatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statistics = null,
  }) {
    return _then(_value.copyWith(
      statistics: null == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Map<String, ChapterStatistics>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChapterStatisticsResponseImplCopyWith<$Res>
    implements $ChapterStatisticsResponseCopyWith<$Res> {
  factory _$$ChapterStatisticsResponseImplCopyWith(
          _$ChapterStatisticsResponseImpl value,
          $Res Function(_$ChapterStatisticsResponseImpl) then) =
      __$$ChapterStatisticsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, ChapterStatistics> statistics});
}

/// @nodoc
class __$$ChapterStatisticsResponseImplCopyWithImpl<$Res>
    extends _$ChapterStatisticsResponseCopyWithImpl<$Res,
        _$ChapterStatisticsResponseImpl>
    implements _$$ChapterStatisticsResponseImplCopyWith<$Res> {
  __$$ChapterStatisticsResponseImplCopyWithImpl(
      _$ChapterStatisticsResponseImpl _value,
      $Res Function(_$ChapterStatisticsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChapterStatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statistics = null,
  }) {
    return _then(_$ChapterStatisticsResponseImpl(
      null == statistics
          ? _value._statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Map<String, ChapterStatistics>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChapterStatisticsResponseImpl
    with DiagnosticableTreeMixin
    implements _ChapterStatisticsResponse {
  const _$ChapterStatisticsResponseImpl(
      final Map<String, ChapterStatistics> statistics)
      : _statistics = statistics;

  factory _$ChapterStatisticsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterStatisticsResponseImplFromJson(json);

  final Map<String, ChapterStatistics> _statistics;
  @override
  Map<String, ChapterStatistics> get statistics {
    if (_statistics is EqualUnmodifiableMapView) return _statistics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statistics);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChapterStatisticsResponse(statistics: $statistics)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChapterStatisticsResponse'))
      ..add(DiagnosticsProperty('statistics', statistics));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterStatisticsResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._statistics, _statistics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_statistics));

  /// Create a copy of ChapterStatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterStatisticsResponseImplCopyWith<_$ChapterStatisticsResponseImpl>
      get copyWith => __$$ChapterStatisticsResponseImplCopyWithImpl<
          _$ChapterStatisticsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterStatisticsResponseImplToJson(
      this,
    );
  }
}

abstract class _ChapterStatisticsResponse implements ChapterStatisticsResponse {
  const factory _ChapterStatisticsResponse(
          final Map<String, ChapterStatistics> statistics) =
      _$ChapterStatisticsResponseImpl;

  factory _ChapterStatisticsResponse.fromJson(Map<String, dynamic> json) =
      _$ChapterStatisticsResponseImpl.fromJson;

  @override
  Map<String, ChapterStatistics> get statistics;

  /// Create a copy of ChapterStatisticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChapterStatisticsResponseImplCopyWith<_$ChapterStatisticsResponseImpl>
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

  /// Serializes this MangaStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MangaStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MangaStatistics
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaStatistics
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaStatistics
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MangaStatistics
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaStatisticsImpl &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.follows, follows) || other.follows == follows));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, comments, rating, follows);

  /// Create a copy of MangaStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MangaStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MangaStatisticsImplCopyWith<_$MangaStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChapterStatistics _$ChapterStatisticsFromJson(Map<String, dynamic> json) {
  return _ChapterStatistics.fromJson(json);
}

/// @nodoc
mixin _$ChapterStatistics {
  StatisticsDetailsComments? get comments => throw _privateConstructorUsedError;

  /// Serializes this ChapterStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChapterStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChapterStatisticsCopyWith<ChapterStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterStatisticsCopyWith<$Res> {
  factory $ChapterStatisticsCopyWith(
          ChapterStatistics value, $Res Function(ChapterStatistics) then) =
      _$ChapterStatisticsCopyWithImpl<$Res, ChapterStatistics>;
  @useResult
  $Res call({StatisticsDetailsComments? comments});

  $StatisticsDetailsCommentsCopyWith<$Res>? get comments;
}

/// @nodoc
class _$ChapterStatisticsCopyWithImpl<$Res, $Val extends ChapterStatistics>
    implements $ChapterStatisticsCopyWith<$Res> {
  _$ChapterStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChapterStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = freezed,
  }) {
    return _then(_value.copyWith(
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as StatisticsDetailsComments?,
    ) as $Val);
  }

  /// Create a copy of ChapterStatistics
  /// with the given fields replaced by the non-null parameter values.
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
}

/// @nodoc
abstract class _$$ChapterStatisticsImplCopyWith<$Res>
    implements $ChapterStatisticsCopyWith<$Res> {
  factory _$$ChapterStatisticsImplCopyWith(_$ChapterStatisticsImpl value,
          $Res Function(_$ChapterStatisticsImpl) then) =
      __$$ChapterStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StatisticsDetailsComments? comments});

  @override
  $StatisticsDetailsCommentsCopyWith<$Res>? get comments;
}

/// @nodoc
class __$$ChapterStatisticsImplCopyWithImpl<$Res>
    extends _$ChapterStatisticsCopyWithImpl<$Res, _$ChapterStatisticsImpl>
    implements _$$ChapterStatisticsImplCopyWith<$Res> {
  __$$ChapterStatisticsImplCopyWithImpl(_$ChapterStatisticsImpl _value,
      $Res Function(_$ChapterStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChapterStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = freezed,
  }) {
    return _then(_$ChapterStatisticsImpl(
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as StatisticsDetailsComments?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChapterStatisticsImpl
    with DiagnosticableTreeMixin
    implements _ChapterStatistics {
  const _$ChapterStatisticsImpl({this.comments});

  factory _$ChapterStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterStatisticsImplFromJson(json);

  @override
  final StatisticsDetailsComments? comments;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChapterStatistics(comments: $comments)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChapterStatistics'))
      ..add(DiagnosticsProperty('comments', comments));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterStatisticsImpl &&
            (identical(other.comments, comments) ||
                other.comments == comments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, comments);

  /// Create a copy of ChapterStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterStatisticsImplCopyWith<_$ChapterStatisticsImpl> get copyWith =>
      __$$ChapterStatisticsImplCopyWithImpl<_$ChapterStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterStatisticsImplToJson(
      this,
    );
  }
}

abstract class _ChapterStatistics implements ChapterStatistics {
  const factory _ChapterStatistics(
      {final StatisticsDetailsComments? comments}) = _$ChapterStatisticsImpl;

  factory _ChapterStatistics.fromJson(Map<String, dynamic> json) =
      _$ChapterStatisticsImpl.fromJson;

  @override
  StatisticsDetailsComments? get comments;

  /// Create a copy of ChapterStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChapterStatisticsImplCopyWith<_$ChapterStatisticsImpl> get copyWith =>
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

  /// Serializes this StatisticsDetailsComments to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatisticsDetailsComments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of StatisticsDetailsComments
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of StatisticsDetailsComments
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatisticsDetailsCommentsImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.repliesCount, repliesCount) ||
                other.repliesCount == repliesCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, threadId, repliesCount);

  /// Create a copy of StatisticsDetailsComments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of StatisticsDetailsComments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this StatisticsDetailsRating to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatisticsDetailsRating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of StatisticsDetailsRating
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of StatisticsDetailsRating
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatisticsDetailsRatingImpl &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.bayesian, bayesian) ||
                other.bayesian == bayesian));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, average, bayesian);

  /// Create a copy of StatisticsDetailsRating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of StatisticsDetailsRating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatisticsDetailsRatingImplCopyWith<_$StatisticsDetailsRatingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SelfRatingResponse _$SelfRatingResponseFromJson(Map<String, dynamic> json) {
  return _SelfRatingResponse.fromJson(json);
}

/// @nodoc
mixin _$SelfRatingResponse {
  Map<String, SelfRating> get ratings => throw _privateConstructorUsedError;

  /// Serializes this SelfRatingResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SelfRatingResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of SelfRatingResponse
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of SelfRatingResponse
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelfRatingResponseImpl &&
            const DeepCollectionEquality().equals(other._ratings, _ratings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_ratings));

  /// Create a copy of SelfRatingResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of SelfRatingResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this SelfRating to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SelfRating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of SelfRating
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of SelfRating
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelfRatingImpl &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rating, createdAt);

  /// Create a copy of SelfRating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of SelfRating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelfRatingImplCopyWith<_$SelfRatingImpl> get copyWith =>
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

  /// Serializes this CustomListAttributes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomListAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of CustomListAttributes
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of CustomListAttributes
  /// with the given fields replaced by the non-null parameter values.
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomListAttributesImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, visibility, version);

  /// Create a copy of CustomListAttributes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of CustomListAttributes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomListAttributesImplCopyWith<_$CustomListAttributesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return _ErrorResponse.fromJson(json);
}

/// @nodoc
mixin _$ErrorResponse {
  String get result => throw _privateConstructorUsedError;
  List<MDError> get errors => throw _privateConstructorUsedError;

  /// Serializes this ErrorResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ErrorResponseCopyWith<ErrorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorResponseCopyWith<$Res> {
  factory $ErrorResponseCopyWith(
          ErrorResponse value, $Res Function(ErrorResponse) then) =
      _$ErrorResponseCopyWithImpl<$Res, ErrorResponse>;
  @useResult
  $Res call({String result, List<MDError> errors});
}

/// @nodoc
class _$ErrorResponseCopyWithImpl<$Res, $Val extends ErrorResponse>
    implements $ErrorResponseCopyWith<$Res> {
  _$ErrorResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<MDError>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorResponseImplCopyWith<$Res>
    implements $ErrorResponseCopyWith<$Res> {
  factory _$$ErrorResponseImplCopyWith(
          _$ErrorResponseImpl value, $Res Function(_$ErrorResponseImpl) then) =
      __$$ErrorResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String result, List<MDError> errors});
}

/// @nodoc
class __$$ErrorResponseImplCopyWithImpl<$Res>
    extends _$ErrorResponseCopyWithImpl<$Res, _$ErrorResponseImpl>
    implements _$$ErrorResponseImplCopyWith<$Res> {
  __$$ErrorResponseImplCopyWithImpl(
      _$ErrorResponseImpl _value, $Res Function(_$ErrorResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? errors = null,
  }) {
    return _then(_$ErrorResponseImpl(
      null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
      null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<MDError>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorResponseImpl
    with DiagnosticableTreeMixin
    implements _ErrorResponse {
  const _$ErrorResponseImpl(this.result, final List<MDError> errors)
      : _errors = errors;

  factory _$ErrorResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorResponseImplFromJson(json);

  @override
  final String result;
  final List<MDError> _errors;
  @override
  List<MDError> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ErrorResponse(result: $result, errors: $errors)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ErrorResponse'))
      ..add(DiagnosticsProperty('result', result))
      ..add(DiagnosticsProperty('errors', errors));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorResponseImpl &&
            (identical(other.result, result) || other.result == result) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, result, const DeepCollectionEquality().hash(_errors));

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorResponseImplCopyWith<_$ErrorResponseImpl> get copyWith =>
      __$$ErrorResponseImplCopyWithImpl<_$ErrorResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorResponseImplToJson(
      this,
    );
  }
}

abstract class _ErrorResponse implements ErrorResponse {
  const factory _ErrorResponse(
      final String result, final List<MDError> errors) = _$ErrorResponseImpl;

  factory _ErrorResponse.fromJson(Map<String, dynamic> json) =
      _$ErrorResponseImpl.fromJson;

  @override
  String get result;
  @override
  List<MDError> get errors;

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorResponseImplCopyWith<_$ErrorResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FrontPageData _$FrontPageDataFromJson(Map<String, dynamic> json) {
  return _FrontPageData.fromJson(json);
}

/// @nodoc
mixin _$FrontPageData {
  String get staffPicks => throw _privateConstructorUsedError;
  String get seasonal => throw _privateConstructorUsedError;

  /// Serializes this FrontPageData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FrontPageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FrontPageDataCopyWith<FrontPageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrontPageDataCopyWith<$Res> {
  factory $FrontPageDataCopyWith(
          FrontPageData value, $Res Function(FrontPageData) then) =
      _$FrontPageDataCopyWithImpl<$Res, FrontPageData>;
  @useResult
  $Res call({String staffPicks, String seasonal});
}

/// @nodoc
class _$FrontPageDataCopyWithImpl<$Res, $Val extends FrontPageData>
    implements $FrontPageDataCopyWith<$Res> {
  _$FrontPageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FrontPageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffPicks = null,
    Object? seasonal = null,
  }) {
    return _then(_value.copyWith(
      staffPicks: null == staffPicks
          ? _value.staffPicks
          : staffPicks // ignore: cast_nullable_to_non_nullable
              as String,
      seasonal: null == seasonal
          ? _value.seasonal
          : seasonal // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FrontPageDataImplCopyWith<$Res>
    implements $FrontPageDataCopyWith<$Res> {
  factory _$$FrontPageDataImplCopyWith(
          _$FrontPageDataImpl value, $Res Function(_$FrontPageDataImpl) then) =
      __$$FrontPageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String staffPicks, String seasonal});
}

/// @nodoc
class __$$FrontPageDataImplCopyWithImpl<$Res>
    extends _$FrontPageDataCopyWithImpl<$Res, _$FrontPageDataImpl>
    implements _$$FrontPageDataImplCopyWith<$Res> {
  __$$FrontPageDataImplCopyWithImpl(
      _$FrontPageDataImpl _value, $Res Function(_$FrontPageDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of FrontPageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffPicks = null,
    Object? seasonal = null,
  }) {
    return _then(_$FrontPageDataImpl(
      staffPicks: null == staffPicks
          ? _value.staffPicks
          : staffPicks // ignore: cast_nullable_to_non_nullable
              as String,
      seasonal: null == seasonal
          ? _value.seasonal
          : seasonal // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FrontPageDataImpl
    with DiagnosticableTreeMixin
    implements _FrontPageData {
  const _$FrontPageDataImpl({required this.staffPicks, required this.seasonal});

  factory _$FrontPageDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FrontPageDataImplFromJson(json);

  @override
  final String staffPicks;
  @override
  final String seasonal;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FrontPageData(staffPicks: $staffPicks, seasonal: $seasonal)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FrontPageData'))
      ..add(DiagnosticsProperty('staffPicks', staffPicks))
      ..add(DiagnosticsProperty('seasonal', seasonal));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrontPageDataImpl &&
            (identical(other.staffPicks, staffPicks) ||
                other.staffPicks == staffPicks) &&
            (identical(other.seasonal, seasonal) ||
                other.seasonal == seasonal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, staffPicks, seasonal);

  /// Create a copy of FrontPageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FrontPageDataImplCopyWith<_$FrontPageDataImpl> get copyWith =>
      __$$FrontPageDataImplCopyWithImpl<_$FrontPageDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FrontPageDataImplToJson(
      this,
    );
  }
}

abstract class _FrontPageData implements FrontPageData {
  const factory _FrontPageData(
      {required final String staffPicks,
      required final String seasonal}) = _$FrontPageDataImpl;

  factory _FrontPageData.fromJson(Map<String, dynamic> json) =
      _$FrontPageDataImpl.fromJson;

  @override
  String get staffPicks;
  @override
  String get seasonal;

  /// Create a copy of FrontPageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FrontPageDataImplCopyWith<_$FrontPageDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
