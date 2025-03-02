// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MangaFilters implements DiagnosticableTreeMixin {

 Set<Tag> get includedTags; TagMode get includedTagsMode; Set<Tag> get excludedTags; TagMode get excludedTagsMode; Set<MangaStatus> get status; Set<MangaDemographic> get publicationDemographic; Set<ContentRating> get contentRating; FilterOrder get order;
/// Create a copy of MangaFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaFiltersCopyWith<MangaFilters> get copyWith => _$MangaFiltersCopyWithImpl<MangaFilters>(this as MangaFilters, _$identity);

  /// Serializes this MangaFilters to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaFilters'))
    ..add(DiagnosticsProperty('includedTags', includedTags))..add(DiagnosticsProperty('includedTagsMode', includedTagsMode))..add(DiagnosticsProperty('excludedTags', excludedTags))..add(DiagnosticsProperty('excludedTagsMode', excludedTagsMode))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('publicationDemographic', publicationDemographic))..add(DiagnosticsProperty('contentRating', contentRating))..add(DiagnosticsProperty('order', order));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MangaFilters&&const DeepCollectionEquality().equals(other.includedTags, includedTags)&&(identical(other.includedTagsMode, includedTagsMode) || other.includedTagsMode == includedTagsMode)&&const DeepCollectionEquality().equals(other.excludedTags, excludedTags)&&(identical(other.excludedTagsMode, excludedTagsMode) || other.excludedTagsMode == excludedTagsMode)&&const DeepCollectionEquality().equals(other.status, status)&&const DeepCollectionEquality().equals(other.publicationDemographic, publicationDemographic)&&const DeepCollectionEquality().equals(other.contentRating, contentRating)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(includedTags),includedTagsMode,const DeepCollectionEquality().hash(excludedTags),excludedTagsMode,const DeepCollectionEquality().hash(status),const DeepCollectionEquality().hash(publicationDemographic),const DeepCollectionEquality().hash(contentRating),order);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaFilters(includedTags: $includedTags, includedTagsMode: $includedTagsMode, excludedTags: $excludedTags, excludedTagsMode: $excludedTagsMode, status: $status, publicationDemographic: $publicationDemographic, contentRating: $contentRating, order: $order)';
}


}

/// @nodoc
abstract mixin class $MangaFiltersCopyWith<$Res>  {
  factory $MangaFiltersCopyWith(MangaFilters value, $Res Function(MangaFilters) _then) = _$MangaFiltersCopyWithImpl;
@useResult
$Res call({
 Set<Tag> includedTags, TagMode includedTagsMode, Set<Tag> excludedTags, TagMode excludedTagsMode, Set<MangaStatus> status, Set<MangaDemographic> publicationDemographic, Set<ContentRating> contentRating, FilterOrder order
});




}
/// @nodoc
class _$MangaFiltersCopyWithImpl<$Res>
    implements $MangaFiltersCopyWith<$Res> {
  _$MangaFiltersCopyWithImpl(this._self, this._then);

  final MangaFilters _self;
  final $Res Function(MangaFilters) _then;

/// Create a copy of MangaFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? includedTags = null,Object? includedTagsMode = null,Object? excludedTags = null,Object? excludedTagsMode = null,Object? status = null,Object? publicationDemographic = null,Object? contentRating = null,Object? order = null,}) {
  return _then(_self.copyWith(
includedTags: null == includedTags ? _self.includedTags : includedTags // ignore: cast_nullable_to_non_nullable
as Set<Tag>,includedTagsMode: null == includedTagsMode ? _self.includedTagsMode : includedTagsMode // ignore: cast_nullable_to_non_nullable
as TagMode,excludedTags: null == excludedTags ? _self.excludedTags : excludedTags // ignore: cast_nullable_to_non_nullable
as Set<Tag>,excludedTagsMode: null == excludedTagsMode ? _self.excludedTagsMode : excludedTagsMode // ignore: cast_nullable_to_non_nullable
as TagMode,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Set<MangaStatus>,publicationDemographic: null == publicationDemographic ? _self.publicationDemographic : publicationDemographic // ignore: cast_nullable_to_non_nullable
as Set<MangaDemographic>,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as Set<ContentRating>,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as FilterOrder,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MangaFilters extends MangaFilters with DiagnosticableTreeMixin {
  const _MangaFilters({final  Set<Tag> includedTags = const {}, this.includedTagsMode = TagMode.and, final  Set<Tag> excludedTags = const {}, this.excludedTagsMode = TagMode.or, final  Set<MangaStatus> status = const {}, final  Set<MangaDemographic> publicationDemographic = const {}, final  Set<ContentRating> contentRating = const {}, this.order = FilterOrder.relevance_desc}): _includedTags = includedTags,_excludedTags = excludedTags,_status = status,_publicationDemographic = publicationDemographic,_contentRating = contentRating,super._();
  factory _MangaFilters.fromJson(Map<String, dynamic> json) => _$MangaFiltersFromJson(json);

 final  Set<Tag> _includedTags;
@override@JsonKey() Set<Tag> get includedTags {
  if (_includedTags is EqualUnmodifiableSetView) return _includedTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_includedTags);
}

@override@JsonKey() final  TagMode includedTagsMode;
 final  Set<Tag> _excludedTags;
@override@JsonKey() Set<Tag> get excludedTags {
  if (_excludedTags is EqualUnmodifiableSetView) return _excludedTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_excludedTags);
}

@override@JsonKey() final  TagMode excludedTagsMode;
 final  Set<MangaStatus> _status;
@override@JsonKey() Set<MangaStatus> get status {
  if (_status is EqualUnmodifiableSetView) return _status;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_status);
}

 final  Set<MangaDemographic> _publicationDemographic;
@override@JsonKey() Set<MangaDemographic> get publicationDemographic {
  if (_publicationDemographic is EqualUnmodifiableSetView) return _publicationDemographic;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_publicationDemographic);
}

 final  Set<ContentRating> _contentRating;
@override@JsonKey() Set<ContentRating> get contentRating {
  if (_contentRating is EqualUnmodifiableSetView) return _contentRating;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_contentRating);
}

@override@JsonKey() final  FilterOrder order;

/// Create a copy of MangaFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MangaFiltersCopyWith<_MangaFilters> get copyWith => __$MangaFiltersCopyWithImpl<_MangaFilters>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MangaFiltersToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaFilters'))
    ..add(DiagnosticsProperty('includedTags', includedTags))..add(DiagnosticsProperty('includedTagsMode', includedTagsMode))..add(DiagnosticsProperty('excludedTags', excludedTags))..add(DiagnosticsProperty('excludedTagsMode', excludedTagsMode))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('publicationDemographic', publicationDemographic))..add(DiagnosticsProperty('contentRating', contentRating))..add(DiagnosticsProperty('order', order));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MangaFilters&&const DeepCollectionEquality().equals(other._includedTags, _includedTags)&&(identical(other.includedTagsMode, includedTagsMode) || other.includedTagsMode == includedTagsMode)&&const DeepCollectionEquality().equals(other._excludedTags, _excludedTags)&&(identical(other.excludedTagsMode, excludedTagsMode) || other.excludedTagsMode == excludedTagsMode)&&const DeepCollectionEquality().equals(other._status, _status)&&const DeepCollectionEquality().equals(other._publicationDemographic, _publicationDemographic)&&const DeepCollectionEquality().equals(other._contentRating, _contentRating)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_includedTags),includedTagsMode,const DeepCollectionEquality().hash(_excludedTags),excludedTagsMode,const DeepCollectionEquality().hash(_status),const DeepCollectionEquality().hash(_publicationDemographic),const DeepCollectionEquality().hash(_contentRating),order);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaFilters(includedTags: $includedTags, includedTagsMode: $includedTagsMode, excludedTags: $excludedTags, excludedTagsMode: $excludedTagsMode, status: $status, publicationDemographic: $publicationDemographic, contentRating: $contentRating, order: $order)';
}


}

/// @nodoc
abstract mixin class _$MangaFiltersCopyWith<$Res> implements $MangaFiltersCopyWith<$Res> {
  factory _$MangaFiltersCopyWith(_MangaFilters value, $Res Function(_MangaFilters) _then) = __$MangaFiltersCopyWithImpl;
@override @useResult
$Res call({
 Set<Tag> includedTags, TagMode includedTagsMode, Set<Tag> excludedTags, TagMode excludedTagsMode, Set<MangaStatus> status, Set<MangaDemographic> publicationDemographic, Set<ContentRating> contentRating, FilterOrder order
});




}
/// @nodoc
class __$MangaFiltersCopyWithImpl<$Res>
    implements _$MangaFiltersCopyWith<$Res> {
  __$MangaFiltersCopyWithImpl(this._self, this._then);

  final _MangaFilters _self;
  final $Res Function(_MangaFilters) _then;

/// Create a copy of MangaFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? includedTags = null,Object? includedTagsMode = null,Object? excludedTags = null,Object? excludedTagsMode = null,Object? status = null,Object? publicationDemographic = null,Object? contentRating = null,Object? order = null,}) {
  return _then(_MangaFilters(
includedTags: null == includedTags ? _self._includedTags : includedTags // ignore: cast_nullable_to_non_nullable
as Set<Tag>,includedTagsMode: null == includedTagsMode ? _self.includedTagsMode : includedTagsMode // ignore: cast_nullable_to_non_nullable
as TagMode,excludedTags: null == excludedTags ? _self._excludedTags : excludedTags // ignore: cast_nullable_to_non_nullable
as Set<Tag>,excludedTagsMode: null == excludedTagsMode ? _self.excludedTagsMode : excludedTagsMode // ignore: cast_nullable_to_non_nullable
as TagMode,status: null == status ? _self._status : status // ignore: cast_nullable_to_non_nullable
as Set<MangaStatus>,publicationDemographic: null == publicationDemographic ? _self._publicationDemographic : publicationDemographic // ignore: cast_nullable_to_non_nullable
as Set<MangaDemographic>,contentRating: null == contentRating ? _self._contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as Set<ContentRating>,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as FilterOrder,
  ));
}


}

/// @nodoc
mixin _$MangaSearchParameters implements DiagnosticableTreeMixin {

 String get query; MangaFilters get filter;
/// Create a copy of MangaSearchParameters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaSearchParametersCopyWith<MangaSearchParameters> get copyWith => _$MangaSearchParametersCopyWithImpl<MangaSearchParameters>(this as MangaSearchParameters, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaSearchParameters'))
    ..add(DiagnosticsProperty('query', query))..add(DiagnosticsProperty('filter', filter));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MangaSearchParameters&&(identical(other.query, query) || other.query == query)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,query,filter);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaSearchParameters(query: $query, filter: $filter)';
}


}

/// @nodoc
abstract mixin class $MangaSearchParametersCopyWith<$Res>  {
  factory $MangaSearchParametersCopyWith(MangaSearchParameters value, $Res Function(MangaSearchParameters) _then) = _$MangaSearchParametersCopyWithImpl;
@useResult
$Res call({
 String query, MangaFilters filter
});


$MangaFiltersCopyWith<$Res> get filter;

}
/// @nodoc
class _$MangaSearchParametersCopyWithImpl<$Res>
    implements $MangaSearchParametersCopyWith<$Res> {
  _$MangaSearchParametersCopyWithImpl(this._self, this._then);

  final MangaSearchParameters _self;
  final $Res Function(MangaSearchParameters) _then;

/// Create a copy of MangaSearchParameters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? filter = null,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as MangaFilters,
  ));
}
/// Create a copy of MangaSearchParameters
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MangaFiltersCopyWith<$Res> get filter {
  
  return $MangaFiltersCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}


/// @nodoc


class _MangaSearchParameters with DiagnosticableTreeMixin implements MangaSearchParameters {
  const _MangaSearchParameters({required this.query, required this.filter});
  

@override final  String query;
@override final  MangaFilters filter;

/// Create a copy of MangaSearchParameters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MangaSearchParametersCopyWith<_MangaSearchParameters> get copyWith => __$MangaSearchParametersCopyWithImpl<_MangaSearchParameters>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaSearchParameters'))
    ..add(DiagnosticsProperty('query', query))..add(DiagnosticsProperty('filter', filter));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MangaSearchParameters&&(identical(other.query, query) || other.query == query)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,query,filter);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaSearchParameters(query: $query, filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$MangaSearchParametersCopyWith<$Res> implements $MangaSearchParametersCopyWith<$Res> {
  factory _$MangaSearchParametersCopyWith(_MangaSearchParameters value, $Res Function(_MangaSearchParameters) _then) = __$MangaSearchParametersCopyWithImpl;
@override @useResult
$Res call({
 String query, MangaFilters filter
});


@override $MangaFiltersCopyWith<$Res> get filter;

}
/// @nodoc
class __$MangaSearchParametersCopyWithImpl<$Res>
    implements _$MangaSearchParametersCopyWith<$Res> {
  __$MangaSearchParametersCopyWithImpl(this._self, this._then);

  final _MangaSearchParameters _self;
  final $Res Function(_MangaSearchParameters) _then;

/// Create a copy of MangaSearchParameters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? filter = null,}) {
  return _then(_MangaSearchParameters(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as MangaFilters,
  ));
}

/// Create a copy of MangaSearchParameters
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MangaFiltersCopyWith<$Res> get filter {
  
  return $MangaFiltersCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}

MangaDexEntity _$MangaDexEntityFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'chapter':
          return Chapter.fromJson(
            json
          );
                case 'manga':
          return Manga.fromJson(
            json
          );
                case 'user':
          return User.fromJson(
            json
          );
                case 'artist':
          return Artist.fromJson(
            json
          );
                case 'author':
          return Author.fromJson(
            json
          );
                case 'creator':
          return CreatorID.fromJson(
            json
          );
                case 'cover_art':
          return CoverArt.fromJson(
            json
          );
                case 'scanlation_group':
          return Group.fromJson(
            json
          );
                case 'custom_list':
          return CustomList.fromJson(
            json
          );
                case 'error':
          return MDError.fromJson(
            json
          );
                case 'tag':
          return Tag.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'MangaDexEntity',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$MangaDexEntity implements DiagnosticableTreeMixin {

 String get id;
/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaDexEntityCopyWith<MangaDexEntity> get copyWith => _$MangaDexEntityCopyWithImpl<MangaDexEntity>(this as MangaDexEntity, _$identity);

  /// Serializes this MangaDexEntity to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaDexEntity'))
    ..add(DiagnosticsProperty('id', id));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MangaDexEntity&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaDexEntity(id: $id)';
}


}

/// @nodoc
abstract mixin class $MangaDexEntityCopyWith<$Res>  {
  factory $MangaDexEntityCopyWith(MangaDexEntity value, $Res Function(MangaDexEntity) _then) = _$MangaDexEntityCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$MangaDexEntityCopyWithImpl<$Res>
    implements $MangaDexEntityCopyWith<$Res> {
  _$MangaDexEntityCopyWithImpl(this._self, this._then);

  final MangaDexEntity _self;
  final $Res Function(MangaDexEntity) _then;

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class Chapter extends MangaDexEntity with DiagnosticableTreeMixin, ChapterOps {
   Chapter({required this.id, required this.attributes, required final  List<MangaDexEntity> relationships, final  String? $type}): _relationships = relationships,$type = $type ?? 'chapter',super._();
  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);

@override final  String id;
 final  ChapterAttributes attributes;
 final  List<MangaDexEntity> _relationships;
 List<MangaDexEntity> get relationships {
  if (_relationships is EqualUnmodifiableListView) return _relationships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relationships);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterCopyWith<Chapter> get copyWith => _$ChapterCopyWithImpl<Chapter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaDexEntity.chapter'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('attributes', attributes))..add(DiagnosticsProperty('relationships', relationships));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Chapter&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&const DeepCollectionEquality().equals(other._relationships, _relationships));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes,const DeepCollectionEquality().hash(_relationships));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaDexEntity.chapter(id: $id, attributes: $attributes, relationships: $relationships)';
}


}

/// @nodoc
abstract mixin class $ChapterCopyWith<$Res> implements $MangaDexEntityCopyWith<$Res> {
  factory $ChapterCopyWith(Chapter value, $Res Function(Chapter) _then) = _$ChapterCopyWithImpl;
@override @useResult
$Res call({
 String id, ChapterAttributes attributes, List<MangaDexEntity> relationships
});


$ChapterAttributesCopyWith<$Res> get attributes;

}
/// @nodoc
class _$ChapterCopyWithImpl<$Res>
    implements $ChapterCopyWith<$Res> {
  _$ChapterCopyWithImpl(this._self, this._then);

  final Chapter _self;
  final $Res Function(Chapter) _then;

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attributes = null,Object? relationships = null,}) {
  return _then(Chapter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as ChapterAttributes,relationships: null == relationships ? _self._relationships : relationships // ignore: cast_nullable_to_non_nullable
as List<MangaDexEntity>,
  ));
}

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChapterAttributesCopyWith<$Res> get attributes {
  
  return $ChapterAttributesCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class Manga extends MangaDexEntity with DiagnosticableTreeMixin, MangaOps {
   Manga({required this.id, this.attributes, final  List<MangaDexEntity>? relationships, this.related, final  String? $type}): _relationships = relationships,$type = $type ?? 'manga',super._();
  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);

@override final  String id;
 final  MangaAttributes? attributes;
 final  List<MangaDexEntity>? _relationships;
 List<MangaDexEntity>? get relationships {
  final value = _relationships;
  if (value == null) return null;
  if (_relationships is EqualUnmodifiableListView) return _relationships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  MangaRelations? related;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaCopyWith<Manga> get copyWith => _$MangaCopyWithImpl<Manga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MangaToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaDexEntity.manga'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('attributes', attributes))..add(DiagnosticsProperty('relationships', relationships))..add(DiagnosticsProperty('related', related));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Manga&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&const DeepCollectionEquality().equals(other._relationships, _relationships)&&(identical(other.related, related) || other.related == related));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes,const DeepCollectionEquality().hash(_relationships),related);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaDexEntity.manga(id: $id, attributes: $attributes, relationships: $relationships, related: $related)';
}


}

/// @nodoc
abstract mixin class $MangaCopyWith<$Res> implements $MangaDexEntityCopyWith<$Res> {
  factory $MangaCopyWith(Manga value, $Res Function(Manga) _then) = _$MangaCopyWithImpl;
@override @useResult
$Res call({
 String id, MangaAttributes? attributes, List<MangaDexEntity>? relationships, MangaRelations? related
});


$MangaAttributesCopyWith<$Res>? get attributes;

}
/// @nodoc
class _$MangaCopyWithImpl<$Res>
    implements $MangaCopyWith<$Res> {
  _$MangaCopyWithImpl(this._self, this._then);

  final Manga _self;
  final $Res Function(Manga) _then;

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attributes = freezed,Object? relationships = freezed,Object? related = freezed,}) {
  return _then(Manga(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as MangaAttributes?,relationships: freezed == relationships ? _self._relationships : relationships // ignore: cast_nullable_to_non_nullable
as List<MangaDexEntity>?,related: freezed == related ? _self.related : related // ignore: cast_nullable_to_non_nullable
as MangaRelations?,
  ));
}

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MangaAttributesCopyWith<$Res>? get attributes {
    if (_self.attributes == null) {
    return null;
  }

  return $MangaAttributesCopyWith<$Res>(_self.attributes!, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class User extends MangaDexEntity with DiagnosticableTreeMixin {
  const User({required this.id, this.attributes, final  String? $type}): $type = $type ?? 'user',super._();
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  String id;
 final  UserAttributes? attributes;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaDexEntity.user'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('attributes', attributes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaDexEntity.user(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res> implements $MangaDexEntityCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@override @useResult
$Res call({
 String id, UserAttributes? attributes
});


$UserAttributesCopyWith<$Res>? get attributes;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attributes = freezed,}) {
  return _then(User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as UserAttributes?,
  ));
}

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserAttributesCopyWith<$Res>? get attributes {
    if (_self.attributes == null) {
    return null;
  }

  return $UserAttributesCopyWith<$Res>(_self.attributes!, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class Artist extends MangaDexEntity with DiagnosticableTreeMixin implements CreatorType {
  const Artist({required this.id, required this.attributes, final  String? $type}): $type = $type ?? 'artist',super._();
  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

@override final  String id;
 final  AuthorAttributes attributes;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArtistCopyWith<Artist> get copyWith => _$ArtistCopyWithImpl<Artist>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArtistToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaDexEntity.artist'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('attributes', attributes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Artist&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaDexEntity.artist(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class $ArtistCopyWith<$Res> implements $MangaDexEntityCopyWith<$Res> {
  factory $ArtistCopyWith(Artist value, $Res Function(Artist) _then) = _$ArtistCopyWithImpl;
@override @useResult
$Res call({
 String id, AuthorAttributes attributes
});


$AuthorAttributesCopyWith<$Res> get attributes;

}
/// @nodoc
class _$ArtistCopyWithImpl<$Res>
    implements $ArtistCopyWith<$Res> {
  _$ArtistCopyWithImpl(this._self, this._then);

  final Artist _self;
  final $Res Function(Artist) _then;

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attributes = null,}) {
  return _then(Artist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as AuthorAttributes,
  ));
}

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthorAttributesCopyWith<$Res> get attributes {
  
  return $AuthorAttributesCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class Author extends MangaDexEntity with DiagnosticableTreeMixin implements CreatorType {
  const Author({required this.id, required this.attributes, final  String? $type}): $type = $type ?? 'author',super._();
  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

@override final  String id;
 final  AuthorAttributes attributes;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthorCopyWith<Author> get copyWith => _$AuthorCopyWithImpl<Author>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthorToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaDexEntity.author'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('attributes', attributes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Author&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaDexEntity.author(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class $AuthorCopyWith<$Res> implements $MangaDexEntityCopyWith<$Res> {
  factory $AuthorCopyWith(Author value, $Res Function(Author) _then) = _$AuthorCopyWithImpl;
@override @useResult
$Res call({
 String id, AuthorAttributes attributes
});


$AuthorAttributesCopyWith<$Res> get attributes;

}
/// @nodoc
class _$AuthorCopyWithImpl<$Res>
    implements $AuthorCopyWith<$Res> {
  _$AuthorCopyWithImpl(this._self, this._then);

  final Author _self;
  final $Res Function(Author) _then;

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attributes = null,}) {
  return _then(Author(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as AuthorAttributes,
  ));
}

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthorAttributesCopyWith<$Res> get attributes {
  
  return $AuthorAttributesCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class CreatorID extends MangaDexEntity with DiagnosticableTreeMixin {
  const CreatorID({required this.id, final  String? $type}): $type = $type ?? 'creator',super._();
  factory CreatorID.fromJson(Map<String, dynamic> json) => _$CreatorIDFromJson(json);

@override final  String id;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatorIDCopyWith<CreatorID> get copyWith => _$CreatorIDCopyWithImpl<CreatorID>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatorIDToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaDexEntity.creator'))
    ..add(DiagnosticsProperty('id', id));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatorID&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaDexEntity.creator(id: $id)';
}


}

/// @nodoc
abstract mixin class $CreatorIDCopyWith<$Res> implements $MangaDexEntityCopyWith<$Res> {
  factory $CreatorIDCopyWith(CreatorID value, $Res Function(CreatorID) _then) = _$CreatorIDCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class _$CreatorIDCopyWithImpl<$Res>
    implements $CreatorIDCopyWith<$Res> {
  _$CreatorIDCopyWithImpl(this._self, this._then);

  final CreatorID _self;
  final $Res Function(CreatorID) _then;

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(CreatorID(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CoverArt extends MangaDexEntity with DiagnosticableTreeMixin {
  const CoverArt({required this.id, this.attributes, final  String? $type}): $type = $type ?? 'cover_art',super._();
  factory CoverArt.fromJson(Map<String, dynamic> json) => _$CoverArtFromJson(json);

@override final  String id;
 final  CoverArtAttributes? attributes;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoverArtCopyWith<CoverArt> get copyWith => _$CoverArtCopyWithImpl<CoverArt>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoverArtToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaDexEntity.cover'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('attributes', attributes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoverArt&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaDexEntity.cover(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class $CoverArtCopyWith<$Res> implements $MangaDexEntityCopyWith<$Res> {
  factory $CoverArtCopyWith(CoverArt value, $Res Function(CoverArt) _then) = _$CoverArtCopyWithImpl;
@override @useResult
$Res call({
 String id, CoverArtAttributes? attributes
});


$CoverArtAttributesCopyWith<$Res>? get attributes;

}
/// @nodoc
class _$CoverArtCopyWithImpl<$Res>
    implements $CoverArtCopyWith<$Res> {
  _$CoverArtCopyWithImpl(this._self, this._then);

  final CoverArt _self;
  final $Res Function(CoverArt) _then;

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attributes = freezed,}) {
  return _then(CoverArt(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as CoverArtAttributes?,
  ));
}

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoverArtAttributesCopyWith<$Res>? get attributes {
    if (_self.attributes == null) {
    return null;
  }

  return $CoverArtAttributesCopyWith<$Res>(_self.attributes!, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class Group extends MangaDexEntity with DiagnosticableTreeMixin {
  const Group({required this.id, required this.attributes, final  String? $type}): $type = $type ?? 'scanlation_group',super._();
  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

@override final  String id;
 final  ScanlationGroupAttributes attributes;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupCopyWith<Group> get copyWith => _$GroupCopyWithImpl<Group>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaDexEntity.group'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('attributes', attributes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Group&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaDexEntity.group(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class $GroupCopyWith<$Res> implements $MangaDexEntityCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) _then) = _$GroupCopyWithImpl;
@override @useResult
$Res call({
 String id, ScanlationGroupAttributes attributes
});


$ScanlationGroupAttributesCopyWith<$Res> get attributes;

}
/// @nodoc
class _$GroupCopyWithImpl<$Res>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._self, this._then);

  final Group _self;
  final $Res Function(Group) _then;

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attributes = null,}) {
  return _then(Group(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as ScanlationGroupAttributes,
  ));
}

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanlationGroupAttributesCopyWith<$Res> get attributes {
  
  return $ScanlationGroupAttributesCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class CustomList extends MangaDexEntity with DiagnosticableTreeMixin, CustomListOps {
   CustomList({required this.id, required this.attributes, required final  List<MangaDexEntity> relationships, final  String? $type}): _relationships = relationships,$type = $type ?? 'custom_list',super._();
  factory CustomList.fromJson(Map<String, dynamic> json) => _$CustomListFromJson(json);

@override final  String id;
 final  CustomListAttributes attributes;
 final  List<MangaDexEntity> _relationships;
 List<MangaDexEntity> get relationships {
  if (_relationships is EqualUnmodifiableListView) return _relationships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relationships);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomListCopyWith<CustomList> get copyWith => _$CustomListCopyWithImpl<CustomList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomListToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaDexEntity.customList'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('attributes', attributes))..add(DiagnosticsProperty('relationships', relationships));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomList&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&const DeepCollectionEquality().equals(other._relationships, _relationships));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes,const DeepCollectionEquality().hash(_relationships));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaDexEntity.customList(id: $id, attributes: $attributes, relationships: $relationships)';
}


}

/// @nodoc
abstract mixin class $CustomListCopyWith<$Res> implements $MangaDexEntityCopyWith<$Res> {
  factory $CustomListCopyWith(CustomList value, $Res Function(CustomList) _then) = _$CustomListCopyWithImpl;
@override @useResult
$Res call({
 String id, CustomListAttributes attributes, List<MangaDexEntity> relationships
});


$CustomListAttributesCopyWith<$Res> get attributes;

}
/// @nodoc
class _$CustomListCopyWithImpl<$Res>
    implements $CustomListCopyWith<$Res> {
  _$CustomListCopyWithImpl(this._self, this._then);

  final CustomList _self;
  final $Res Function(CustomList) _then;

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attributes = null,Object? relationships = null,}) {
  return _then(CustomList(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as CustomListAttributes,relationships: null == relationships ? _self._relationships : relationships // ignore: cast_nullable_to_non_nullable
as List<MangaDexEntity>,
  ));
}

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomListAttributesCopyWith<$Res> get attributes {
  
  return $CustomListAttributesCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class MDError extends MangaDexEntity with DiagnosticableTreeMixin {
  const MDError({required this.id, required this.status, required this.title, this.detail, this.context, final  String? $type}): $type = $type ?? 'error',super._();
  factory MDError.fromJson(Map<String, dynamic> json) => _$MDErrorFromJson(json);

@override final  String id;
 final  int status;
 final  String title;
 final  String? detail;
 final  String? context;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MDErrorCopyWith<MDError> get copyWith => _$MDErrorCopyWithImpl<MDError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MDErrorToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaDexEntity.error'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('detail', detail))..add(DiagnosticsProperty('context', context));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MDError&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.title, title) || other.title == title)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.context, context) || other.context == context));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,title,detail,context);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaDexEntity.error(id: $id, status: $status, title: $title, detail: $detail, context: $context)';
}


}

/// @nodoc
abstract mixin class $MDErrorCopyWith<$Res> implements $MangaDexEntityCopyWith<$Res> {
  factory $MDErrorCopyWith(MDError value, $Res Function(MDError) _then) = _$MDErrorCopyWithImpl;
@override @useResult
$Res call({
 String id, int status, String title, String? detail, String? context
});




}
/// @nodoc
class _$MDErrorCopyWithImpl<$Res>
    implements $MDErrorCopyWith<$Res> {
  _$MDErrorCopyWithImpl(this._self, this._then);

  final MDError _self;
  final $Res Function(MDError) _then;

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? title = null,Object? detail = freezed,Object? context = freezed,}) {
  return _then(MDError(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,context: freezed == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class Tag extends MangaDexEntity with DiagnosticableTreeMixin {
  const Tag({required this.id, required this.attributes, final  String? $type}): $type = $type ?? 'tag',super._();
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

@override final  String id;
 final  TagAttributes attributes;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagCopyWith<Tag> get copyWith => _$TagCopyWithImpl<Tag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TagToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaDexEntity.tag'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('attributes', attributes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tag&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaDexEntity.tag(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class $TagCopyWith<$Res> implements $MangaDexEntityCopyWith<$Res> {
  factory $TagCopyWith(Tag value, $Res Function(Tag) _then) = _$TagCopyWithImpl;
@override @useResult
$Res call({
 String id, TagAttributes attributes
});


$TagAttributesCopyWith<$Res> get attributes;

}
/// @nodoc
class _$TagCopyWithImpl<$Res>
    implements $TagCopyWith<$Res> {
  _$TagCopyWithImpl(this._self, this._then);

  final Tag _self;
  final $Res Function(Tag) _then;

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attributes = null,}) {
  return _then(Tag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as TagAttributes,
  ));
}

/// Create a copy of MangaDexEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagAttributesCopyWith<$Res> get attributes {
  
  return $TagAttributesCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}


/// @nodoc
mixin _$ChapterAPIData implements DiagnosticableTreeMixin {

 String get hash; List<String> get data; List<String> get dataSaver;
/// Create a copy of ChapterAPIData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterAPIDataCopyWith<ChapterAPIData> get copyWith => _$ChapterAPIDataCopyWithImpl<ChapterAPIData>(this as ChapterAPIData, _$identity);

  /// Serializes this ChapterAPIData to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChapterAPIData'))
    ..add(DiagnosticsProperty('hash', hash))..add(DiagnosticsProperty('data', data))..add(DiagnosticsProperty('dataSaver', dataSaver));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterAPIData&&(identical(other.hash, hash) || other.hash == hash)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other.dataSaver, dataSaver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hash,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(dataSaver));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChapterAPIData(hash: $hash, data: $data, dataSaver: $dataSaver)';
}


}

/// @nodoc
abstract mixin class $ChapterAPIDataCopyWith<$Res>  {
  factory $ChapterAPIDataCopyWith(ChapterAPIData value, $Res Function(ChapterAPIData) _then) = _$ChapterAPIDataCopyWithImpl;
@useResult
$Res call({
 String hash, List<String> data, List<String> dataSaver
});




}
/// @nodoc
class _$ChapterAPIDataCopyWithImpl<$Res>
    implements $ChapterAPIDataCopyWith<$Res> {
  _$ChapterAPIDataCopyWithImpl(this._self, this._then);

  final ChapterAPIData _self;
  final $Res Function(ChapterAPIData) _then;

/// Create a copy of ChapterAPIData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hash = null,Object? data = null,Object? dataSaver = null,}) {
  return _then(_self.copyWith(
hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<String>,dataSaver: null == dataSaver ? _self.dataSaver : dataSaver // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ChapterAPIData with DiagnosticableTreeMixin implements ChapterAPIData {
  const _ChapterAPIData({required this.hash, required final  List<String> data, required final  List<String> dataSaver}): _data = data,_dataSaver = dataSaver;
  factory _ChapterAPIData.fromJson(Map<String, dynamic> json) => _$ChapterAPIDataFromJson(json);

@override final  String hash;
 final  List<String> _data;
@override List<String> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

 final  List<String> _dataSaver;
@override List<String> get dataSaver {
  if (_dataSaver is EqualUnmodifiableListView) return _dataSaver;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dataSaver);
}


/// Create a copy of ChapterAPIData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterAPIDataCopyWith<_ChapterAPIData> get copyWith => __$ChapterAPIDataCopyWithImpl<_ChapterAPIData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterAPIDataToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChapterAPIData'))
    ..add(DiagnosticsProperty('hash', hash))..add(DiagnosticsProperty('data', data))..add(DiagnosticsProperty('dataSaver', dataSaver));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterAPIData&&(identical(other.hash, hash) || other.hash == hash)&&const DeepCollectionEquality().equals(other._data, _data)&&const DeepCollectionEquality().equals(other._dataSaver, _dataSaver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hash,const DeepCollectionEquality().hash(_data),const DeepCollectionEquality().hash(_dataSaver));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChapterAPIData(hash: $hash, data: $data, dataSaver: $dataSaver)';
}


}

/// @nodoc
abstract mixin class _$ChapterAPIDataCopyWith<$Res> implements $ChapterAPIDataCopyWith<$Res> {
  factory _$ChapterAPIDataCopyWith(_ChapterAPIData value, $Res Function(_ChapterAPIData) _then) = __$ChapterAPIDataCopyWithImpl;
@override @useResult
$Res call({
 String hash, List<String> data, List<String> dataSaver
});




}
/// @nodoc
class __$ChapterAPIDataCopyWithImpl<$Res>
    implements _$ChapterAPIDataCopyWith<$Res> {
  __$ChapterAPIDataCopyWithImpl(this._self, this._then);

  final _ChapterAPIData _self;
  final $Res Function(_ChapterAPIData) _then;

/// Create a copy of ChapterAPIData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hash = null,Object? data = null,Object? dataSaver = null,}) {
  return _then(_ChapterAPIData(
hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<String>,dataSaver: null == dataSaver ? _self._dataSaver : dataSaver // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ChapterAPI implements DiagnosticableTreeMixin {

 String get baseUrl; ChapterAPIData get chapter;
/// Create a copy of ChapterAPI
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterAPICopyWith<ChapterAPI> get copyWith => _$ChapterAPICopyWithImpl<ChapterAPI>(this as ChapterAPI, _$identity);

  /// Serializes this ChapterAPI to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChapterAPI'))
    ..add(DiagnosticsProperty('baseUrl', baseUrl))..add(DiagnosticsProperty('chapter', chapter));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterAPI&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.chapter, chapter) || other.chapter == chapter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl,chapter);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChapterAPI(baseUrl: $baseUrl, chapter: $chapter)';
}


}

/// @nodoc
abstract mixin class $ChapterAPICopyWith<$Res>  {
  factory $ChapterAPICopyWith(ChapterAPI value, $Res Function(ChapterAPI) _then) = _$ChapterAPICopyWithImpl;
@useResult
$Res call({
 String baseUrl, ChapterAPIData chapter
});


$ChapterAPIDataCopyWith<$Res> get chapter;

}
/// @nodoc
class _$ChapterAPICopyWithImpl<$Res>
    implements $ChapterAPICopyWith<$Res> {
  _$ChapterAPICopyWithImpl(this._self, this._then);

  final ChapterAPI _self;
  final $Res Function(ChapterAPI) _then;

/// Create a copy of ChapterAPI
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseUrl = null,Object? chapter = null,}) {
  return _then(_self.copyWith(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,chapter: null == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as ChapterAPIData,
  ));
}
/// Create a copy of ChapterAPI
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChapterAPIDataCopyWith<$Res> get chapter {
  
  return $ChapterAPIDataCopyWith<$Res>(_self.chapter, (value) {
    return _then(_self.copyWith(chapter: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _ChapterAPI extends ChapterAPI with DiagnosticableTreeMixin {
  const _ChapterAPI({required this.baseUrl, required this.chapter}): super._();
  factory _ChapterAPI.fromJson(Map<String, dynamic> json) => _$ChapterAPIFromJson(json);

@override final  String baseUrl;
@override final  ChapterAPIData chapter;

/// Create a copy of ChapterAPI
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterAPICopyWith<_ChapterAPI> get copyWith => __$ChapterAPICopyWithImpl<_ChapterAPI>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterAPIToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChapterAPI'))
    ..add(DiagnosticsProperty('baseUrl', baseUrl))..add(DiagnosticsProperty('chapter', chapter));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterAPI&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.chapter, chapter) || other.chapter == chapter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl,chapter);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChapterAPI(baseUrl: $baseUrl, chapter: $chapter)';
}


}

/// @nodoc
abstract mixin class _$ChapterAPICopyWith<$Res> implements $ChapterAPICopyWith<$Res> {
  factory _$ChapterAPICopyWith(_ChapterAPI value, $Res Function(_ChapterAPI) _then) = __$ChapterAPICopyWithImpl;
@override @useResult
$Res call({
 String baseUrl, ChapterAPIData chapter
});


@override $ChapterAPIDataCopyWith<$Res> get chapter;

}
/// @nodoc
class __$ChapterAPICopyWithImpl<$Res>
    implements _$ChapterAPICopyWith<$Res> {
  __$ChapterAPICopyWithImpl(this._self, this._then);

  final _ChapterAPI _self;
  final $Res Function(_ChapterAPI) _then;

/// Create a copy of ChapterAPI
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,Object? chapter = null,}) {
  return _then(_ChapterAPI(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,chapter: null == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as ChapterAPIData,
  ));
}

/// Create a copy of ChapterAPI
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChapterAPIDataCopyWith<$Res> get chapter {
  
  return $ChapterAPIDataCopyWith<$Res>(_self.chapter, (value) {
    return _then(_self.copyWith(chapter: value));
  });
}
}


/// @nodoc
mixin _$MDEntityList implements DiagnosticableTreeMixin {

 String get result; String get response; List<MangaDexEntity> get data; int get limit; int get offset; int get total;
/// Create a copy of MDEntityList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MDEntityListCopyWith<MDEntityList> get copyWith => _$MDEntityListCopyWithImpl<MDEntityList>(this as MDEntityList, _$identity);

  /// Serializes this MDEntityList to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MDEntityList'))
    ..add(DiagnosticsProperty('result', result))..add(DiagnosticsProperty('response', response))..add(DiagnosticsProperty('data', data))..add(DiagnosticsProperty('limit', limit))..add(DiagnosticsProperty('offset', offset))..add(DiagnosticsProperty('total', total));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MDEntityList&&(identical(other.result, result) || other.result == result)&&(identical(other.response, response) || other.response == response)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,response,const DeepCollectionEquality().hash(data),limit,offset,total);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MDEntityList(result: $result, response: $response, data: $data, limit: $limit, offset: $offset, total: $total)';
}


}

/// @nodoc
abstract mixin class $MDEntityListCopyWith<$Res>  {
  factory $MDEntityListCopyWith(MDEntityList value, $Res Function(MDEntityList) _then) = _$MDEntityListCopyWithImpl;
@useResult
$Res call({
 String result, String response, List<MangaDexEntity> data, int limit, int offset, int total
});




}
/// @nodoc
class _$MDEntityListCopyWithImpl<$Res>
    implements $MDEntityListCopyWith<$Res> {
  _$MDEntityListCopyWithImpl(this._self, this._then);

  final MDEntityList _self;
  final $Res Function(MDEntityList) _then;

/// Create a copy of MDEntityList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = null,Object? response = null,Object? data = null,Object? limit = null,Object? offset = null,Object? total = null,}) {
  return _then(_self.copyWith(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<MangaDexEntity>,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MDEntityList with DiagnosticableTreeMixin implements MDEntityList {
  const _MDEntityList({required this.result, required this.response, required final  List<MangaDexEntity> data, required this.limit, required this.offset, required this.total}): _data = data;
  factory _MDEntityList.fromJson(Map<String, dynamic> json) => _$MDEntityListFromJson(json);

@override final  String result;
@override final  String response;
 final  List<MangaDexEntity> _data;
@override List<MangaDexEntity> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  int limit;
@override final  int offset;
@override final  int total;

/// Create a copy of MDEntityList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MDEntityListCopyWith<_MDEntityList> get copyWith => __$MDEntityListCopyWithImpl<_MDEntityList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MDEntityListToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MDEntityList'))
    ..add(DiagnosticsProperty('result', result))..add(DiagnosticsProperty('response', response))..add(DiagnosticsProperty('data', data))..add(DiagnosticsProperty('limit', limit))..add(DiagnosticsProperty('offset', offset))..add(DiagnosticsProperty('total', total));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MDEntityList&&(identical(other.result, result) || other.result == result)&&(identical(other.response, response) || other.response == response)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,response,const DeepCollectionEquality().hash(_data),limit,offset,total);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MDEntityList(result: $result, response: $response, data: $data, limit: $limit, offset: $offset, total: $total)';
}


}

/// @nodoc
abstract mixin class _$MDEntityListCopyWith<$Res> implements $MDEntityListCopyWith<$Res> {
  factory _$MDEntityListCopyWith(_MDEntityList value, $Res Function(_MDEntityList) _then) = __$MDEntityListCopyWithImpl;
@override @useResult
$Res call({
 String result, String response, List<MangaDexEntity> data, int limit, int offset, int total
});




}
/// @nodoc
class __$MDEntityListCopyWithImpl<$Res>
    implements _$MDEntityListCopyWith<$Res> {
  __$MDEntityListCopyWithImpl(this._self, this._then);

  final _MDEntityList _self;
  final $Res Function(_MDEntityList) _then;

/// Create a copy of MDEntityList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,Object? response = null,Object? data = null,Object? limit = null,Object? offset = null,Object? total = null,}) {
  return _then(_MDEntityList(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<MangaDexEntity>,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MangaLinks implements DiagnosticableTreeMixin {

 String? get raw; String? get al; String? get mu; String? get mal;
/// Create a copy of MangaLinks
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaLinksCopyWith<MangaLinks> get copyWith => _$MangaLinksCopyWithImpl<MangaLinks>(this as MangaLinks, _$identity);

  /// Serializes this MangaLinks to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaLinks'))
    ..add(DiagnosticsProperty('raw', raw))..add(DiagnosticsProperty('al', al))..add(DiagnosticsProperty('mu', mu))..add(DiagnosticsProperty('mal', mal));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MangaLinks&&(identical(other.raw, raw) || other.raw == raw)&&(identical(other.al, al) || other.al == al)&&(identical(other.mu, mu) || other.mu == mu)&&(identical(other.mal, mal) || other.mal == mal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,raw,al,mu,mal);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaLinks(raw: $raw, al: $al, mu: $mu, mal: $mal)';
}


}

/// @nodoc
abstract mixin class $MangaLinksCopyWith<$Res>  {
  factory $MangaLinksCopyWith(MangaLinks value, $Res Function(MangaLinks) _then) = _$MangaLinksCopyWithImpl;
@useResult
$Res call({
 String? raw, String? al, String? mu, String? mal
});




}
/// @nodoc
class _$MangaLinksCopyWithImpl<$Res>
    implements $MangaLinksCopyWith<$Res> {
  _$MangaLinksCopyWithImpl(this._self, this._then);

  final MangaLinks _self;
  final $Res Function(MangaLinks) _then;

/// Create a copy of MangaLinks
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? raw = freezed,Object? al = freezed,Object? mu = freezed,Object? mal = freezed,}) {
  return _then(_self.copyWith(
raw: freezed == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as String?,al: freezed == al ? _self.al : al // ignore: cast_nullable_to_non_nullable
as String?,mu: freezed == mu ? _self.mu : mu // ignore: cast_nullable_to_non_nullable
as String?,mal: freezed == mal ? _self.mal : mal // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MangaLinks with DiagnosticableTreeMixin implements MangaLinks {
  const _MangaLinks({this.raw, this.al, this.mu, this.mal});
  factory _MangaLinks.fromJson(Map<String, dynamic> json) => _$MangaLinksFromJson(json);

@override final  String? raw;
@override final  String? al;
@override final  String? mu;
@override final  String? mal;

/// Create a copy of MangaLinks
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MangaLinksCopyWith<_MangaLinks> get copyWith => __$MangaLinksCopyWithImpl<_MangaLinks>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MangaLinksToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaLinks'))
    ..add(DiagnosticsProperty('raw', raw))..add(DiagnosticsProperty('al', al))..add(DiagnosticsProperty('mu', mu))..add(DiagnosticsProperty('mal', mal));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MangaLinks&&(identical(other.raw, raw) || other.raw == raw)&&(identical(other.al, al) || other.al == al)&&(identical(other.mu, mu) || other.mu == mu)&&(identical(other.mal, mal) || other.mal == mal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,raw,al,mu,mal);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaLinks(raw: $raw, al: $al, mu: $mu, mal: $mal)';
}


}

/// @nodoc
abstract mixin class _$MangaLinksCopyWith<$Res> implements $MangaLinksCopyWith<$Res> {
  factory _$MangaLinksCopyWith(_MangaLinks value, $Res Function(_MangaLinks) _then) = __$MangaLinksCopyWithImpl;
@override @useResult
$Res call({
 String? raw, String? al, String? mu, String? mal
});




}
/// @nodoc
class __$MangaLinksCopyWithImpl<$Res>
    implements _$MangaLinksCopyWith<$Res> {
  __$MangaLinksCopyWithImpl(this._self, this._then);

  final _MangaLinks _self;
  final $Res Function(_MangaLinks) _then;

/// Create a copy of MangaLinks
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? raw = freezed,Object? al = freezed,Object? mu = freezed,Object? mal = freezed,}) {
  return _then(_MangaLinks(
raw: freezed == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as String?,al: freezed == al ? _self.al : al // ignore: cast_nullable_to_non_nullable
as String?,mu: freezed == mu ? _self.mu : mu // ignore: cast_nullable_to_non_nullable
as String?,mal: freezed == mal ? _self.mal : mal // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MangaAttributes implements DiagnosticableTreeMixin {

 Map<String, String> get title; List<Map<String, String>> get altTitles; Map<String, String> get description; MangaLinks? get links;@LanguageConverter() Language get originalLanguage; String? get lastVolume; String? get lastChapter; MangaDemographic? get publicationDemographic; MangaStatus get status; int? get year; ContentRating get contentRating; List<Tag> get tags; int get version;@TimestampSerializer() DateTime get createdAt;@TimestampSerializer() DateTime get updatedAt;
/// Create a copy of MangaAttributes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaAttributesCopyWith<MangaAttributes> get copyWith => _$MangaAttributesCopyWithImpl<MangaAttributes>(this as MangaAttributes, _$identity);

  /// Serializes this MangaAttributes to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaAttributes'))
    ..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('altTitles', altTitles))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('links', links))..add(DiagnosticsProperty('originalLanguage', originalLanguage))..add(DiagnosticsProperty('lastVolume', lastVolume))..add(DiagnosticsProperty('lastChapter', lastChapter))..add(DiagnosticsProperty('publicationDemographic', publicationDemographic))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('year', year))..add(DiagnosticsProperty('contentRating', contentRating))..add(DiagnosticsProperty('tags', tags))..add(DiagnosticsProperty('version', version))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MangaAttributes&&const DeepCollectionEquality().equals(other.title, title)&&const DeepCollectionEquality().equals(other.altTitles, altTitles)&&const DeepCollectionEquality().equals(other.description, description)&&(identical(other.links, links) || other.links == links)&&(identical(other.originalLanguage, originalLanguage) || other.originalLanguage == originalLanguage)&&(identical(other.lastVolume, lastVolume) || other.lastVolume == lastVolume)&&(identical(other.lastChapter, lastChapter) || other.lastChapter == lastChapter)&&(identical(other.publicationDemographic, publicationDemographic) || other.publicationDemographic == publicationDemographic)&&(identical(other.status, status) || other.status == status)&&(identical(other.year, year) || other.year == year)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.version, version) || other.version == version)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(title),const DeepCollectionEquality().hash(altTitles),const DeepCollectionEquality().hash(description),links,originalLanguage,lastVolume,lastChapter,publicationDemographic,status,year,contentRating,const DeepCollectionEquality().hash(tags),version,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaAttributes(title: $title, altTitles: $altTitles, description: $description, links: $links, originalLanguage: $originalLanguage, lastVolume: $lastVolume, lastChapter: $lastChapter, publicationDemographic: $publicationDemographic, status: $status, year: $year, contentRating: $contentRating, tags: $tags, version: $version, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MangaAttributesCopyWith<$Res>  {
  factory $MangaAttributesCopyWith(MangaAttributes value, $Res Function(MangaAttributes) _then) = _$MangaAttributesCopyWithImpl;
@useResult
$Res call({
 Map<String, String> title, List<Map<String, String>> altTitles, Map<String, String> description, MangaLinks? links,@LanguageConverter() Language originalLanguage, String? lastVolume, String? lastChapter, MangaDemographic? publicationDemographic, MangaStatus status, int? year, ContentRating contentRating, List<Tag> tags, int version,@TimestampSerializer() DateTime createdAt,@TimestampSerializer() DateTime updatedAt
});


$MangaLinksCopyWith<$Res>? get links;

}
/// @nodoc
class _$MangaAttributesCopyWithImpl<$Res>
    implements $MangaAttributesCopyWith<$Res> {
  _$MangaAttributesCopyWithImpl(this._self, this._then);

  final MangaAttributes _self;
  final $Res Function(MangaAttributes) _then;

/// Create a copy of MangaAttributes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? altTitles = null,Object? description = null,Object? links = freezed,Object? originalLanguage = null,Object? lastVolume = freezed,Object? lastChapter = freezed,Object? publicationDemographic = freezed,Object? status = null,Object? year = freezed,Object? contentRating = null,Object? tags = null,Object? version = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Map<String, String>,altTitles: null == altTitles ? _self.altTitles : altTitles // ignore: cast_nullable_to_non_nullable
as List<Map<String, String>>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as Map<String, String>,links: freezed == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as MangaLinks?,originalLanguage: null == originalLanguage ? _self.originalLanguage : originalLanguage // ignore: cast_nullable_to_non_nullable
as Language,lastVolume: freezed == lastVolume ? _self.lastVolume : lastVolume // ignore: cast_nullable_to_non_nullable
as String?,lastChapter: freezed == lastChapter ? _self.lastChapter : lastChapter // ignore: cast_nullable_to_non_nullable
as String?,publicationDemographic: freezed == publicationDemographic ? _self.publicationDemographic : publicationDemographic // ignore: cast_nullable_to_non_nullable
as MangaDemographic?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MangaStatus,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of MangaAttributes
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MangaLinksCopyWith<$Res>? get links {
    if (_self.links == null) {
    return null;
  }

  return $MangaLinksCopyWith<$Res>(_self.links!, (value) {
    return _then(_self.copyWith(links: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _MangaAttributes with DiagnosticableTreeMixin implements MangaAttributes {
  const _MangaAttributes({required final  Map<String, String> title, required final  List<Map<String, String>> altTitles, required final  Map<String, String> description, this.links, @LanguageConverter() required this.originalLanguage, this.lastVolume, this.lastChapter, this.publicationDemographic, required this.status, this.year, required this.contentRating, required final  List<Tag> tags, required this.version, @TimestampSerializer() required this.createdAt, @TimestampSerializer() required this.updatedAt}): _title = title,_altTitles = altTitles,_description = description,_tags = tags;
  factory _MangaAttributes.fromJson(Map<String, dynamic> json) => _$MangaAttributesFromJson(json);

 final  Map<String, String> _title;
@override Map<String, String> get title {
  if (_title is EqualUnmodifiableMapView) return _title;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_title);
}

 final  List<Map<String, String>> _altTitles;
@override List<Map<String, String>> get altTitles {
  if (_altTitles is EqualUnmodifiableListView) return _altTitles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_altTitles);
}

 final  Map<String, String> _description;
@override Map<String, String> get description {
  if (_description is EqualUnmodifiableMapView) return _description;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_description);
}

@override final  MangaLinks? links;
@override@LanguageConverter() final  Language originalLanguage;
@override final  String? lastVolume;
@override final  String? lastChapter;
@override final  MangaDemographic? publicationDemographic;
@override final  MangaStatus status;
@override final  int? year;
@override final  ContentRating contentRating;
 final  List<Tag> _tags;
@override List<Tag> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  int version;
@override@TimestampSerializer() final  DateTime createdAt;
@override@TimestampSerializer() final  DateTime updatedAt;

/// Create a copy of MangaAttributes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MangaAttributesCopyWith<_MangaAttributes> get copyWith => __$MangaAttributesCopyWithImpl<_MangaAttributes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MangaAttributesToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaAttributes'))
    ..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('altTitles', altTitles))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('links', links))..add(DiagnosticsProperty('originalLanguage', originalLanguage))..add(DiagnosticsProperty('lastVolume', lastVolume))..add(DiagnosticsProperty('lastChapter', lastChapter))..add(DiagnosticsProperty('publicationDemographic', publicationDemographic))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('year', year))..add(DiagnosticsProperty('contentRating', contentRating))..add(DiagnosticsProperty('tags', tags))..add(DiagnosticsProperty('version', version))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MangaAttributes&&const DeepCollectionEquality().equals(other._title, _title)&&const DeepCollectionEquality().equals(other._altTitles, _altTitles)&&const DeepCollectionEquality().equals(other._description, _description)&&(identical(other.links, links) || other.links == links)&&(identical(other.originalLanguage, originalLanguage) || other.originalLanguage == originalLanguage)&&(identical(other.lastVolume, lastVolume) || other.lastVolume == lastVolume)&&(identical(other.lastChapter, lastChapter) || other.lastChapter == lastChapter)&&(identical(other.publicationDemographic, publicationDemographic) || other.publicationDemographic == publicationDemographic)&&(identical(other.status, status) || other.status == status)&&(identical(other.year, year) || other.year == year)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.version, version) || other.version == version)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_title),const DeepCollectionEquality().hash(_altTitles),const DeepCollectionEquality().hash(_description),links,originalLanguage,lastVolume,lastChapter,publicationDemographic,status,year,contentRating,const DeepCollectionEquality().hash(_tags),version,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaAttributes(title: $title, altTitles: $altTitles, description: $description, links: $links, originalLanguage: $originalLanguage, lastVolume: $lastVolume, lastChapter: $lastChapter, publicationDemographic: $publicationDemographic, status: $status, year: $year, contentRating: $contentRating, tags: $tags, version: $version, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MangaAttributesCopyWith<$Res> implements $MangaAttributesCopyWith<$Res> {
  factory _$MangaAttributesCopyWith(_MangaAttributes value, $Res Function(_MangaAttributes) _then) = __$MangaAttributesCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String> title, List<Map<String, String>> altTitles, Map<String, String> description, MangaLinks? links,@LanguageConverter() Language originalLanguage, String? lastVolume, String? lastChapter, MangaDemographic? publicationDemographic, MangaStatus status, int? year, ContentRating contentRating, List<Tag> tags, int version,@TimestampSerializer() DateTime createdAt,@TimestampSerializer() DateTime updatedAt
});


@override $MangaLinksCopyWith<$Res>? get links;

}
/// @nodoc
class __$MangaAttributesCopyWithImpl<$Res>
    implements _$MangaAttributesCopyWith<$Res> {
  __$MangaAttributesCopyWithImpl(this._self, this._then);

  final _MangaAttributes _self;
  final $Res Function(_MangaAttributes) _then;

/// Create a copy of MangaAttributes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? altTitles = null,Object? description = null,Object? links = freezed,Object? originalLanguage = null,Object? lastVolume = freezed,Object? lastChapter = freezed,Object? publicationDemographic = freezed,Object? status = null,Object? year = freezed,Object? contentRating = null,Object? tags = null,Object? version = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_MangaAttributes(
title: null == title ? _self._title : title // ignore: cast_nullable_to_non_nullable
as Map<String, String>,altTitles: null == altTitles ? _self._altTitles : altTitles // ignore: cast_nullable_to_non_nullable
as List<Map<String, String>>,description: null == description ? _self._description : description // ignore: cast_nullable_to_non_nullable
as Map<String, String>,links: freezed == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as MangaLinks?,originalLanguage: null == originalLanguage ? _self.originalLanguage : originalLanguage // ignore: cast_nullable_to_non_nullable
as Language,lastVolume: freezed == lastVolume ? _self.lastVolume : lastVolume // ignore: cast_nullable_to_non_nullable
as String?,lastChapter: freezed == lastChapter ? _self.lastChapter : lastChapter // ignore: cast_nullable_to_non_nullable
as String?,publicationDemographic: freezed == publicationDemographic ? _self.publicationDemographic : publicationDemographic // ignore: cast_nullable_to_non_nullable
as MangaDemographic?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MangaStatus,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,contentRating: null == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as ContentRating,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of MangaAttributes
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MangaLinksCopyWith<$Res>? get links {
    if (_self.links == null) {
    return null;
  }

  return $MangaLinksCopyWith<$Res>(_self.links!, (value) {
    return _then(_self.copyWith(links: value));
  });
}
}


/// @nodoc
mixin _$ChapterAttributes implements DiagnosticableTreeMixin {

 String? get title; String? get volume; String? get chapter;@LanguageConverter() Language get translatedLanguage; String? get uploader; String? get externalUrl; int get version;@TimestampSerializer() DateTime get createdAt;@TimestampSerializer() DateTime get updatedAt;@TimestampSerializer() DateTime get publishAt;
/// Create a copy of ChapterAttributes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterAttributesCopyWith<ChapterAttributes> get copyWith => _$ChapterAttributesCopyWithImpl<ChapterAttributes>(this as ChapterAttributes, _$identity);

  /// Serializes this ChapterAttributes to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChapterAttributes'))
    ..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('volume', volume))..add(DiagnosticsProperty('chapter', chapter))..add(DiagnosticsProperty('translatedLanguage', translatedLanguage))..add(DiagnosticsProperty('uploader', uploader))..add(DiagnosticsProperty('externalUrl', externalUrl))..add(DiagnosticsProperty('version', version))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('publishAt', publishAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterAttributes&&(identical(other.title, title) || other.title == title)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.chapter, chapter) || other.chapter == chapter)&&(identical(other.translatedLanguage, translatedLanguage) || other.translatedLanguage == translatedLanguage)&&(identical(other.uploader, uploader) || other.uploader == uploader)&&(identical(other.externalUrl, externalUrl) || other.externalUrl == externalUrl)&&(identical(other.version, version) || other.version == version)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.publishAt, publishAt) || other.publishAt == publishAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,volume,chapter,translatedLanguage,uploader,externalUrl,version,createdAt,updatedAt,publishAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChapterAttributes(title: $title, volume: $volume, chapter: $chapter, translatedLanguage: $translatedLanguage, uploader: $uploader, externalUrl: $externalUrl, version: $version, createdAt: $createdAt, updatedAt: $updatedAt, publishAt: $publishAt)';
}


}

/// @nodoc
abstract mixin class $ChapterAttributesCopyWith<$Res>  {
  factory $ChapterAttributesCopyWith(ChapterAttributes value, $Res Function(ChapterAttributes) _then) = _$ChapterAttributesCopyWithImpl;
@useResult
$Res call({
 String? title, String? volume, String? chapter,@LanguageConverter() Language translatedLanguage, String? uploader, String? externalUrl, int version,@TimestampSerializer() DateTime createdAt,@TimestampSerializer() DateTime updatedAt,@TimestampSerializer() DateTime publishAt
});




}
/// @nodoc
class _$ChapterAttributesCopyWithImpl<$Res>
    implements $ChapterAttributesCopyWith<$Res> {
  _$ChapterAttributesCopyWithImpl(this._self, this._then);

  final ChapterAttributes _self;
  final $Res Function(ChapterAttributes) _then;

/// Create a copy of ChapterAttributes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? volume = freezed,Object? chapter = freezed,Object? translatedLanguage = null,Object? uploader = freezed,Object? externalUrl = freezed,Object? version = null,Object? createdAt = null,Object? updatedAt = null,Object? publishAt = null,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as String?,chapter: freezed == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as String?,translatedLanguage: null == translatedLanguage ? _self.translatedLanguage : translatedLanguage // ignore: cast_nullable_to_non_nullable
as Language,uploader: freezed == uploader ? _self.uploader : uploader // ignore: cast_nullable_to_non_nullable
as String?,externalUrl: freezed == externalUrl ? _self.externalUrl : externalUrl // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,publishAt: null == publishAt ? _self.publishAt : publishAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ChapterAttributes with DiagnosticableTreeMixin implements ChapterAttributes {
  const _ChapterAttributes({this.title, this.volume, this.chapter, @LanguageConverter() required this.translatedLanguage, this.uploader, this.externalUrl, required this.version, @TimestampSerializer() required this.createdAt, @TimestampSerializer() required this.updatedAt, @TimestampSerializer() required this.publishAt});
  factory _ChapterAttributes.fromJson(Map<String, dynamic> json) => _$ChapterAttributesFromJson(json);

@override final  String? title;
@override final  String? volume;
@override final  String? chapter;
@override@LanguageConverter() final  Language translatedLanguage;
@override final  String? uploader;
@override final  String? externalUrl;
@override final  int version;
@override@TimestampSerializer() final  DateTime createdAt;
@override@TimestampSerializer() final  DateTime updatedAt;
@override@TimestampSerializer() final  DateTime publishAt;

/// Create a copy of ChapterAttributes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterAttributesCopyWith<_ChapterAttributes> get copyWith => __$ChapterAttributesCopyWithImpl<_ChapterAttributes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterAttributesToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChapterAttributes'))
    ..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('volume', volume))..add(DiagnosticsProperty('chapter', chapter))..add(DiagnosticsProperty('translatedLanguage', translatedLanguage))..add(DiagnosticsProperty('uploader', uploader))..add(DiagnosticsProperty('externalUrl', externalUrl))..add(DiagnosticsProperty('version', version))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('publishAt', publishAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterAttributes&&(identical(other.title, title) || other.title == title)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.chapter, chapter) || other.chapter == chapter)&&(identical(other.translatedLanguage, translatedLanguage) || other.translatedLanguage == translatedLanguage)&&(identical(other.uploader, uploader) || other.uploader == uploader)&&(identical(other.externalUrl, externalUrl) || other.externalUrl == externalUrl)&&(identical(other.version, version) || other.version == version)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.publishAt, publishAt) || other.publishAt == publishAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,volume,chapter,translatedLanguage,uploader,externalUrl,version,createdAt,updatedAt,publishAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChapterAttributes(title: $title, volume: $volume, chapter: $chapter, translatedLanguage: $translatedLanguage, uploader: $uploader, externalUrl: $externalUrl, version: $version, createdAt: $createdAt, updatedAt: $updatedAt, publishAt: $publishAt)';
}


}

/// @nodoc
abstract mixin class _$ChapterAttributesCopyWith<$Res> implements $ChapterAttributesCopyWith<$Res> {
  factory _$ChapterAttributesCopyWith(_ChapterAttributes value, $Res Function(_ChapterAttributes) _then) = __$ChapterAttributesCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? volume, String? chapter,@LanguageConverter() Language translatedLanguage, String? uploader, String? externalUrl, int version,@TimestampSerializer() DateTime createdAt,@TimestampSerializer() DateTime updatedAt,@TimestampSerializer() DateTime publishAt
});




}
/// @nodoc
class __$ChapterAttributesCopyWithImpl<$Res>
    implements _$ChapterAttributesCopyWith<$Res> {
  __$ChapterAttributesCopyWithImpl(this._self, this._then);

  final _ChapterAttributes _self;
  final $Res Function(_ChapterAttributes) _then;

/// Create a copy of ChapterAttributes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? volume = freezed,Object? chapter = freezed,Object? translatedLanguage = null,Object? uploader = freezed,Object? externalUrl = freezed,Object? version = null,Object? createdAt = null,Object? updatedAt = null,Object? publishAt = null,}) {
  return _then(_ChapterAttributes(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as String?,chapter: freezed == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as String?,translatedLanguage: null == translatedLanguage ? _self.translatedLanguage : translatedLanguage // ignore: cast_nullable_to_non_nullable
as Language,uploader: freezed == uploader ? _self.uploader : uploader // ignore: cast_nullable_to_non_nullable
as String?,externalUrl: freezed == externalUrl ? _self.externalUrl : externalUrl // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,publishAt: null == publishAt ? _self.publishAt : publishAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ScanlationGroupAttributes implements DiagnosticableTreeMixin {

 String get name; String? get website; String? get discord; String? get description;
/// Create a copy of ScanlationGroupAttributes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanlationGroupAttributesCopyWith<ScanlationGroupAttributes> get copyWith => _$ScanlationGroupAttributesCopyWithImpl<ScanlationGroupAttributes>(this as ScanlationGroupAttributes, _$identity);

  /// Serializes this ScanlationGroupAttributes to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ScanlationGroupAttributes'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('website', website))..add(DiagnosticsProperty('discord', discord))..add(DiagnosticsProperty('description', description));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanlationGroupAttributes&&(identical(other.name, name) || other.name == name)&&(identical(other.website, website) || other.website == website)&&(identical(other.discord, discord) || other.discord == discord)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,website,discord,description);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ScanlationGroupAttributes(name: $name, website: $website, discord: $discord, description: $description)';
}


}

/// @nodoc
abstract mixin class $ScanlationGroupAttributesCopyWith<$Res>  {
  factory $ScanlationGroupAttributesCopyWith(ScanlationGroupAttributes value, $Res Function(ScanlationGroupAttributes) _then) = _$ScanlationGroupAttributesCopyWithImpl;
@useResult
$Res call({
 String name, String? website, String? discord, String? description
});




}
/// @nodoc
class _$ScanlationGroupAttributesCopyWithImpl<$Res>
    implements $ScanlationGroupAttributesCopyWith<$Res> {
  _$ScanlationGroupAttributesCopyWithImpl(this._self, this._then);

  final ScanlationGroupAttributes _self;
  final $Res Function(ScanlationGroupAttributes) _then;

/// Create a copy of ScanlationGroupAttributes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? website = freezed,Object? discord = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,discord: freezed == discord ? _self.discord : discord // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ScanlationGroupAttributes with DiagnosticableTreeMixin implements ScanlationGroupAttributes {
  const _ScanlationGroupAttributes({required this.name, this.website, this.discord, this.description});
  factory _ScanlationGroupAttributes.fromJson(Map<String, dynamic> json) => _$ScanlationGroupAttributesFromJson(json);

@override final  String name;
@override final  String? website;
@override final  String? discord;
@override final  String? description;

/// Create a copy of ScanlationGroupAttributes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanlationGroupAttributesCopyWith<_ScanlationGroupAttributes> get copyWith => __$ScanlationGroupAttributesCopyWithImpl<_ScanlationGroupAttributes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScanlationGroupAttributesToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ScanlationGroupAttributes'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('website', website))..add(DiagnosticsProperty('discord', discord))..add(DiagnosticsProperty('description', description));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanlationGroupAttributes&&(identical(other.name, name) || other.name == name)&&(identical(other.website, website) || other.website == website)&&(identical(other.discord, discord) || other.discord == discord)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,website,discord,description);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ScanlationGroupAttributes(name: $name, website: $website, discord: $discord, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ScanlationGroupAttributesCopyWith<$Res> implements $ScanlationGroupAttributesCopyWith<$Res> {
  factory _$ScanlationGroupAttributesCopyWith(_ScanlationGroupAttributes value, $Res Function(_ScanlationGroupAttributes) _then) = __$ScanlationGroupAttributesCopyWithImpl;
@override @useResult
$Res call({
 String name, String? website, String? discord, String? description
});




}
/// @nodoc
class __$ScanlationGroupAttributesCopyWithImpl<$Res>
    implements _$ScanlationGroupAttributesCopyWith<$Res> {
  __$ScanlationGroupAttributesCopyWithImpl(this._self, this._then);

  final _ScanlationGroupAttributes _self;
  final $Res Function(_ScanlationGroupAttributes) _then;

/// Create a copy of ScanlationGroupAttributes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? website = freezed,Object? discord = freezed,Object? description = freezed,}) {
  return _then(_ScanlationGroupAttributes(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,discord: freezed == discord ? _self.discord : discord // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CoverArtAttributes implements DiagnosticableTreeMixin {

 String? get volume; String get fileName; String? get description; String? get locale;
/// Create a copy of CoverArtAttributes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoverArtAttributesCopyWith<CoverArtAttributes> get copyWith => _$CoverArtAttributesCopyWithImpl<CoverArtAttributes>(this as CoverArtAttributes, _$identity);

  /// Serializes this CoverArtAttributes to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CoverArtAttributes'))
    ..add(DiagnosticsProperty('volume', volume))..add(DiagnosticsProperty('fileName', fileName))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('locale', locale));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoverArtAttributes&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.description, description) || other.description == description)&&(identical(other.locale, locale) || other.locale == locale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,volume,fileName,description,locale);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CoverArtAttributes(volume: $volume, fileName: $fileName, description: $description, locale: $locale)';
}


}

/// @nodoc
abstract mixin class $CoverArtAttributesCopyWith<$Res>  {
  factory $CoverArtAttributesCopyWith(CoverArtAttributes value, $Res Function(CoverArtAttributes) _then) = _$CoverArtAttributesCopyWithImpl;
@useResult
$Res call({
 String? volume, String fileName, String? description, String? locale
});




}
/// @nodoc
class _$CoverArtAttributesCopyWithImpl<$Res>
    implements $CoverArtAttributesCopyWith<$Res> {
  _$CoverArtAttributesCopyWithImpl(this._self, this._then);

  final CoverArtAttributes _self;
  final $Res Function(CoverArtAttributes) _then;

/// Create a copy of CoverArtAttributes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? volume = freezed,Object? fileName = null,Object? description = freezed,Object? locale = freezed,}) {
  return _then(_self.copyWith(
volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as String?,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CoverArtAttributes with DiagnosticableTreeMixin implements CoverArtAttributes {
  const _CoverArtAttributes({this.volume, required this.fileName, this.description, this.locale});
  factory _CoverArtAttributes.fromJson(Map<String, dynamic> json) => _$CoverArtAttributesFromJson(json);

@override final  String? volume;
@override final  String fileName;
@override final  String? description;
@override final  String? locale;

/// Create a copy of CoverArtAttributes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoverArtAttributesCopyWith<_CoverArtAttributes> get copyWith => __$CoverArtAttributesCopyWithImpl<_CoverArtAttributes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoverArtAttributesToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CoverArtAttributes'))
    ..add(DiagnosticsProperty('volume', volume))..add(DiagnosticsProperty('fileName', fileName))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('locale', locale));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoverArtAttributes&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.description, description) || other.description == description)&&(identical(other.locale, locale) || other.locale == locale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,volume,fileName,description,locale);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CoverArtAttributes(volume: $volume, fileName: $fileName, description: $description, locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$CoverArtAttributesCopyWith<$Res> implements $CoverArtAttributesCopyWith<$Res> {
  factory _$CoverArtAttributesCopyWith(_CoverArtAttributes value, $Res Function(_CoverArtAttributes) _then) = __$CoverArtAttributesCopyWithImpl;
@override @useResult
$Res call({
 String? volume, String fileName, String? description, String? locale
});




}
/// @nodoc
class __$CoverArtAttributesCopyWithImpl<$Res>
    implements _$CoverArtAttributesCopyWith<$Res> {
  __$CoverArtAttributesCopyWithImpl(this._self, this._then);

  final _CoverArtAttributes _self;
  final $Res Function(_CoverArtAttributes) _then;

/// Create a copy of CoverArtAttributes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? volume = freezed,Object? fileName = null,Object? description = freezed,Object? locale = freezed,}) {
  return _then(_CoverArtAttributes(
volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as String?,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UserAttributes implements DiagnosticableTreeMixin {

 String get username;
/// Create a copy of UserAttributes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAttributesCopyWith<UserAttributes> get copyWith => _$UserAttributesCopyWithImpl<UserAttributes>(this as UserAttributes, _$identity);

  /// Serializes this UserAttributes to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserAttributes'))
    ..add(DiagnosticsProperty('username', username));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAttributes&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserAttributes(username: $username)';
}


}

/// @nodoc
abstract mixin class $UserAttributesCopyWith<$Res>  {
  factory $UserAttributesCopyWith(UserAttributes value, $Res Function(UserAttributes) _then) = _$UserAttributesCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class _$UserAttributesCopyWithImpl<$Res>
    implements $UserAttributesCopyWith<$Res> {
  _$UserAttributesCopyWithImpl(this._self, this._then);

  final UserAttributes _self;
  final $Res Function(UserAttributes) _then;

/// Create a copy of UserAttributes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UserAttributes with DiagnosticableTreeMixin implements UserAttributes {
  const _UserAttributes({required this.username});
  factory _UserAttributes.fromJson(Map<String, dynamic> json) => _$UserAttributesFromJson(json);

@override final  String username;

/// Create a copy of UserAttributes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAttributesCopyWith<_UserAttributes> get copyWith => __$UserAttributesCopyWithImpl<_UserAttributes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserAttributesToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserAttributes'))
    ..add(DiagnosticsProperty('username', username));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAttributes&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserAttributes(username: $username)';
}


}

/// @nodoc
abstract mixin class _$UserAttributesCopyWith<$Res> implements $UserAttributesCopyWith<$Res> {
  factory _$UserAttributesCopyWith(_UserAttributes value, $Res Function(_UserAttributes) _then) = __$UserAttributesCopyWithImpl;
@override @useResult
$Res call({
 String username
});




}
/// @nodoc
class __$UserAttributesCopyWithImpl<$Res>
    implements _$UserAttributesCopyWith<$Res> {
  __$UserAttributesCopyWithImpl(this._self, this._then);

  final _UserAttributes _self;
  final $Res Function(_UserAttributes) _then;

/// Create a copy of UserAttributes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(_UserAttributes(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AuthorAttributes implements DiagnosticableTreeMixin {

 String get name; String? get imageUrl; Map<String, String> get biography; String? get twitter; String? get pixiv; String? get youtube; String? get website;@TimestampSerializer() DateTime get createdAt;@TimestampSerializer() DateTime get updatedAt;
/// Create a copy of AuthorAttributes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthorAttributesCopyWith<AuthorAttributes> get copyWith => _$AuthorAttributesCopyWithImpl<AuthorAttributes>(this as AuthorAttributes, _$identity);

  /// Serializes this AuthorAttributes to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthorAttributes'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('imageUrl', imageUrl))..add(DiagnosticsProperty('biography', biography))..add(DiagnosticsProperty('twitter', twitter))..add(DiagnosticsProperty('pixiv', pixiv))..add(DiagnosticsProperty('youtube', youtube))..add(DiagnosticsProperty('website', website))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthorAttributes&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.biography, biography)&&(identical(other.twitter, twitter) || other.twitter == twitter)&&(identical(other.pixiv, pixiv) || other.pixiv == pixiv)&&(identical(other.youtube, youtube) || other.youtube == youtube)&&(identical(other.website, website) || other.website == website)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,imageUrl,const DeepCollectionEquality().hash(biography),twitter,pixiv,youtube,website,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthorAttributes(name: $name, imageUrl: $imageUrl, biography: $biography, twitter: $twitter, pixiv: $pixiv, youtube: $youtube, website: $website, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AuthorAttributesCopyWith<$Res>  {
  factory $AuthorAttributesCopyWith(AuthorAttributes value, $Res Function(AuthorAttributes) _then) = _$AuthorAttributesCopyWithImpl;
@useResult
$Res call({
 String name, String? imageUrl, Map<String, String> biography, String? twitter, String? pixiv, String? youtube, String? website,@TimestampSerializer() DateTime createdAt,@TimestampSerializer() DateTime updatedAt
});




}
/// @nodoc
class _$AuthorAttributesCopyWithImpl<$Res>
    implements $AuthorAttributesCopyWith<$Res> {
  _$AuthorAttributesCopyWithImpl(this._self, this._then);

  final AuthorAttributes _self;
  final $Res Function(AuthorAttributes) _then;

/// Create a copy of AuthorAttributes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? imageUrl = freezed,Object? biography = null,Object? twitter = freezed,Object? pixiv = freezed,Object? youtube = freezed,Object? website = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,biography: null == biography ? _self.biography : biography // ignore: cast_nullable_to_non_nullable
as Map<String, String>,twitter: freezed == twitter ? _self.twitter : twitter // ignore: cast_nullable_to_non_nullable
as String?,pixiv: freezed == pixiv ? _self.pixiv : pixiv // ignore: cast_nullable_to_non_nullable
as String?,youtube: freezed == youtube ? _self.youtube : youtube // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AuthorAttributes with DiagnosticableTreeMixin implements AuthorAttributes {
  const _AuthorAttributes({required this.name, this.imageUrl, required final  Map<String, String> biography, this.twitter, this.pixiv, this.youtube, this.website, @TimestampSerializer() required this.createdAt, @TimestampSerializer() required this.updatedAt}): _biography = biography;
  factory _AuthorAttributes.fromJson(Map<String, dynamic> json) => _$AuthorAttributesFromJson(json);

@override final  String name;
@override final  String? imageUrl;
 final  Map<String, String> _biography;
@override Map<String, String> get biography {
  if (_biography is EqualUnmodifiableMapView) return _biography;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_biography);
}

@override final  String? twitter;
@override final  String? pixiv;
@override final  String? youtube;
@override final  String? website;
@override@TimestampSerializer() final  DateTime createdAt;
@override@TimestampSerializer() final  DateTime updatedAt;

/// Create a copy of AuthorAttributes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthorAttributesCopyWith<_AuthorAttributes> get copyWith => __$AuthorAttributesCopyWithImpl<_AuthorAttributes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthorAttributesToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthorAttributes'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('imageUrl', imageUrl))..add(DiagnosticsProperty('biography', biography))..add(DiagnosticsProperty('twitter', twitter))..add(DiagnosticsProperty('pixiv', pixiv))..add(DiagnosticsProperty('youtube', youtube))..add(DiagnosticsProperty('website', website))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthorAttributes&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._biography, _biography)&&(identical(other.twitter, twitter) || other.twitter == twitter)&&(identical(other.pixiv, pixiv) || other.pixiv == pixiv)&&(identical(other.youtube, youtube) || other.youtube == youtube)&&(identical(other.website, website) || other.website == website)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,imageUrl,const DeepCollectionEquality().hash(_biography),twitter,pixiv,youtube,website,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthorAttributes(name: $name, imageUrl: $imageUrl, biography: $biography, twitter: $twitter, pixiv: $pixiv, youtube: $youtube, website: $website, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AuthorAttributesCopyWith<$Res> implements $AuthorAttributesCopyWith<$Res> {
  factory _$AuthorAttributesCopyWith(_AuthorAttributes value, $Res Function(_AuthorAttributes) _then) = __$AuthorAttributesCopyWithImpl;
@override @useResult
$Res call({
 String name, String? imageUrl, Map<String, String> biography, String? twitter, String? pixiv, String? youtube, String? website,@TimestampSerializer() DateTime createdAt,@TimestampSerializer() DateTime updatedAt
});




}
/// @nodoc
class __$AuthorAttributesCopyWithImpl<$Res>
    implements _$AuthorAttributesCopyWith<$Res> {
  __$AuthorAttributesCopyWithImpl(this._self, this._then);

  final _AuthorAttributes _self;
  final $Res Function(_AuthorAttributes) _then;

/// Create a copy of AuthorAttributes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? imageUrl = freezed,Object? biography = null,Object? twitter = freezed,Object? pixiv = freezed,Object? youtube = freezed,Object? website = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_AuthorAttributes(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,biography: null == biography ? _self._biography : biography // ignore: cast_nullable_to_non_nullable
as Map<String, String>,twitter: freezed == twitter ? _self.twitter : twitter // ignore: cast_nullable_to_non_nullable
as String?,pixiv: freezed == pixiv ? _self.pixiv : pixiv // ignore: cast_nullable_to_non_nullable
as String?,youtube: freezed == youtube ? _self.youtube : youtube // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$TagAttributes implements DiagnosticableTreeMixin {

 Map<String, String> get name; Map<String, String> get description; TagGroup get group;
/// Create a copy of TagAttributes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagAttributesCopyWith<TagAttributes> get copyWith => _$TagAttributesCopyWithImpl<TagAttributes>(this as TagAttributes, _$identity);

  /// Serializes this TagAttributes to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TagAttributes'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('group', group));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagAttributes&&const DeepCollectionEquality().equals(other.name, name)&&const DeepCollectionEquality().equals(other.description, description)&&(identical(other.group, group) || other.group == group));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(name),const DeepCollectionEquality().hash(description),group);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TagAttributes(name: $name, description: $description, group: $group)';
}


}

/// @nodoc
abstract mixin class $TagAttributesCopyWith<$Res>  {
  factory $TagAttributesCopyWith(TagAttributes value, $Res Function(TagAttributes) _then) = _$TagAttributesCopyWithImpl;
@useResult
$Res call({
 Map<String, String> name, Map<String, String> description, TagGroup group
});




}
/// @nodoc
class _$TagAttributesCopyWithImpl<$Res>
    implements $TagAttributesCopyWith<$Res> {
  _$TagAttributesCopyWithImpl(this._self, this._then);

  final TagAttributes _self;
  final $Res Function(TagAttributes) _then;

/// Create a copy of TagAttributes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? group = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as Map<String, String>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as Map<String, String>,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as TagGroup,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TagAttributes with DiagnosticableTreeMixin implements TagAttributes {
  const _TagAttributes({required final  Map<String, String> name, required final  Map<String, String> description, required this.group}): _name = name,_description = description;
  factory _TagAttributes.fromJson(Map<String, dynamic> json) => _$TagAttributesFromJson(json);

 final  Map<String, String> _name;
@override Map<String, String> get name {
  if (_name is EqualUnmodifiableMapView) return _name;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_name);
}

 final  Map<String, String> _description;
@override Map<String, String> get description {
  if (_description is EqualUnmodifiableMapView) return _description;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_description);
}

@override final  TagGroup group;

/// Create a copy of TagAttributes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagAttributesCopyWith<_TagAttributes> get copyWith => __$TagAttributesCopyWithImpl<_TagAttributes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TagAttributesToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TagAttributes'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('group', group));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagAttributes&&const DeepCollectionEquality().equals(other._name, _name)&&const DeepCollectionEquality().equals(other._description, _description)&&(identical(other.group, group) || other.group == group));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_name),const DeepCollectionEquality().hash(_description),group);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TagAttributes(name: $name, description: $description, group: $group)';
}


}

/// @nodoc
abstract mixin class _$TagAttributesCopyWith<$Res> implements $TagAttributesCopyWith<$Res> {
  factory _$TagAttributesCopyWith(_TagAttributes value, $Res Function(_TagAttributes) _then) = __$TagAttributesCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String> name, Map<String, String> description, TagGroup group
});




}
/// @nodoc
class __$TagAttributesCopyWithImpl<$Res>
    implements _$TagAttributesCopyWith<$Res> {
  __$TagAttributesCopyWithImpl(this._self, this._then);

  final _TagAttributes _self;
  final $Res Function(_TagAttributes) _then;

/// Create a copy of TagAttributes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? group = null,}) {
  return _then(_TagAttributes(
name: null == name ? _self._name : name // ignore: cast_nullable_to_non_nullable
as Map<String, String>,description: null == description ? _self._description : description // ignore: cast_nullable_to_non_nullable
as Map<String, String>,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as TagGroup,
  ));
}


}


/// @nodoc
mixin _$MangaStatisticsResponse implements DiagnosticableTreeMixin {

 Map<String, MangaStatistics> get statistics;
/// Create a copy of MangaStatisticsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaStatisticsResponseCopyWith<MangaStatisticsResponse> get copyWith => _$MangaStatisticsResponseCopyWithImpl<MangaStatisticsResponse>(this as MangaStatisticsResponse, _$identity);

  /// Serializes this MangaStatisticsResponse to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaStatisticsResponse'))
    ..add(DiagnosticsProperty('statistics', statistics));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MangaStatisticsResponse&&const DeepCollectionEquality().equals(other.statistics, statistics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(statistics));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaStatisticsResponse(statistics: $statistics)';
}


}

/// @nodoc
abstract mixin class $MangaStatisticsResponseCopyWith<$Res>  {
  factory $MangaStatisticsResponseCopyWith(MangaStatisticsResponse value, $Res Function(MangaStatisticsResponse) _then) = _$MangaStatisticsResponseCopyWithImpl;
@useResult
$Res call({
 Map<String, MangaStatistics> statistics
});




}
/// @nodoc
class _$MangaStatisticsResponseCopyWithImpl<$Res>
    implements $MangaStatisticsResponseCopyWith<$Res> {
  _$MangaStatisticsResponseCopyWithImpl(this._self, this._then);

  final MangaStatisticsResponse _self;
  final $Res Function(MangaStatisticsResponse) _then;

/// Create a copy of MangaStatisticsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statistics = null,}) {
  return _then(_self.copyWith(
statistics: null == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as Map<String, MangaStatistics>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MangaStatisticsResponse with DiagnosticableTreeMixin implements MangaStatisticsResponse {
  const _MangaStatisticsResponse(final  Map<String, MangaStatistics> statistics): _statistics = statistics;
  factory _MangaStatisticsResponse.fromJson(Map<String, dynamic> json) => _$MangaStatisticsResponseFromJson(json);

 final  Map<String, MangaStatistics> _statistics;
@override Map<String, MangaStatistics> get statistics {
  if (_statistics is EqualUnmodifiableMapView) return _statistics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_statistics);
}


/// Create a copy of MangaStatisticsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MangaStatisticsResponseCopyWith<_MangaStatisticsResponse> get copyWith => __$MangaStatisticsResponseCopyWithImpl<_MangaStatisticsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MangaStatisticsResponseToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaStatisticsResponse'))
    ..add(DiagnosticsProperty('statistics', statistics));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MangaStatisticsResponse&&const DeepCollectionEquality().equals(other._statistics, _statistics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_statistics));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaStatisticsResponse(statistics: $statistics)';
}


}

/// @nodoc
abstract mixin class _$MangaStatisticsResponseCopyWith<$Res> implements $MangaStatisticsResponseCopyWith<$Res> {
  factory _$MangaStatisticsResponseCopyWith(_MangaStatisticsResponse value, $Res Function(_MangaStatisticsResponse) _then) = __$MangaStatisticsResponseCopyWithImpl;
@override @useResult
$Res call({
 Map<String, MangaStatistics> statistics
});




}
/// @nodoc
class __$MangaStatisticsResponseCopyWithImpl<$Res>
    implements _$MangaStatisticsResponseCopyWith<$Res> {
  __$MangaStatisticsResponseCopyWithImpl(this._self, this._then);

  final _MangaStatisticsResponse _self;
  final $Res Function(_MangaStatisticsResponse) _then;

/// Create a copy of MangaStatisticsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statistics = null,}) {
  return _then(_MangaStatisticsResponse(
null == statistics ? _self._statistics : statistics // ignore: cast_nullable_to_non_nullable
as Map<String, MangaStatistics>,
  ));
}


}


/// @nodoc
mixin _$ChapterStatisticsResponse implements DiagnosticableTreeMixin {

 Map<String, ChapterStatistics> get statistics;
/// Create a copy of ChapterStatisticsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterStatisticsResponseCopyWith<ChapterStatisticsResponse> get copyWith => _$ChapterStatisticsResponseCopyWithImpl<ChapterStatisticsResponse>(this as ChapterStatisticsResponse, _$identity);

  /// Serializes this ChapterStatisticsResponse to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChapterStatisticsResponse'))
    ..add(DiagnosticsProperty('statistics', statistics));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterStatisticsResponse&&const DeepCollectionEquality().equals(other.statistics, statistics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(statistics));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChapterStatisticsResponse(statistics: $statistics)';
}


}

/// @nodoc
abstract mixin class $ChapterStatisticsResponseCopyWith<$Res>  {
  factory $ChapterStatisticsResponseCopyWith(ChapterStatisticsResponse value, $Res Function(ChapterStatisticsResponse) _then) = _$ChapterStatisticsResponseCopyWithImpl;
@useResult
$Res call({
 Map<String, ChapterStatistics> statistics
});




}
/// @nodoc
class _$ChapterStatisticsResponseCopyWithImpl<$Res>
    implements $ChapterStatisticsResponseCopyWith<$Res> {
  _$ChapterStatisticsResponseCopyWithImpl(this._self, this._then);

  final ChapterStatisticsResponse _self;
  final $Res Function(ChapterStatisticsResponse) _then;

/// Create a copy of ChapterStatisticsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statistics = null,}) {
  return _then(_self.copyWith(
statistics: null == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as Map<String, ChapterStatistics>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ChapterStatisticsResponse with DiagnosticableTreeMixin implements ChapterStatisticsResponse {
  const _ChapterStatisticsResponse(final  Map<String, ChapterStatistics> statistics): _statistics = statistics;
  factory _ChapterStatisticsResponse.fromJson(Map<String, dynamic> json) => _$ChapterStatisticsResponseFromJson(json);

 final  Map<String, ChapterStatistics> _statistics;
@override Map<String, ChapterStatistics> get statistics {
  if (_statistics is EqualUnmodifiableMapView) return _statistics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_statistics);
}


/// Create a copy of ChapterStatisticsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterStatisticsResponseCopyWith<_ChapterStatisticsResponse> get copyWith => __$ChapterStatisticsResponseCopyWithImpl<_ChapterStatisticsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterStatisticsResponseToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChapterStatisticsResponse'))
    ..add(DiagnosticsProperty('statistics', statistics));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterStatisticsResponse&&const DeepCollectionEquality().equals(other._statistics, _statistics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_statistics));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChapterStatisticsResponse(statistics: $statistics)';
}


}

/// @nodoc
abstract mixin class _$ChapterStatisticsResponseCopyWith<$Res> implements $ChapterStatisticsResponseCopyWith<$Res> {
  factory _$ChapterStatisticsResponseCopyWith(_ChapterStatisticsResponse value, $Res Function(_ChapterStatisticsResponse) _then) = __$ChapterStatisticsResponseCopyWithImpl;
@override @useResult
$Res call({
 Map<String, ChapterStatistics> statistics
});




}
/// @nodoc
class __$ChapterStatisticsResponseCopyWithImpl<$Res>
    implements _$ChapterStatisticsResponseCopyWith<$Res> {
  __$ChapterStatisticsResponseCopyWithImpl(this._self, this._then);

  final _ChapterStatisticsResponse _self;
  final $Res Function(_ChapterStatisticsResponse) _then;

/// Create a copy of ChapterStatisticsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statistics = null,}) {
  return _then(_ChapterStatisticsResponse(
null == statistics ? _self._statistics : statistics // ignore: cast_nullable_to_non_nullable
as Map<String, ChapterStatistics>,
  ));
}


}


/// @nodoc
mixin _$MangaStatistics implements DiagnosticableTreeMixin {

 StatisticsDetailsComments? get comments; StatisticsDetailsRating get rating; int get follows;
/// Create a copy of MangaStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaStatisticsCopyWith<MangaStatistics> get copyWith => _$MangaStatisticsCopyWithImpl<MangaStatistics>(this as MangaStatistics, _$identity);

  /// Serializes this MangaStatistics to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaStatistics'))
    ..add(DiagnosticsProperty('comments', comments))..add(DiagnosticsProperty('rating', rating))..add(DiagnosticsProperty('follows', follows));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MangaStatistics&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.follows, follows) || other.follows == follows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,comments,rating,follows);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaStatistics(comments: $comments, rating: $rating, follows: $follows)';
}


}

/// @nodoc
abstract mixin class $MangaStatisticsCopyWith<$Res>  {
  factory $MangaStatisticsCopyWith(MangaStatistics value, $Res Function(MangaStatistics) _then) = _$MangaStatisticsCopyWithImpl;
@useResult
$Res call({
 StatisticsDetailsComments? comments, StatisticsDetailsRating rating, int follows
});


$StatisticsDetailsCommentsCopyWith<$Res>? get comments;$StatisticsDetailsRatingCopyWith<$Res> get rating;

}
/// @nodoc
class _$MangaStatisticsCopyWithImpl<$Res>
    implements $MangaStatisticsCopyWith<$Res> {
  _$MangaStatisticsCopyWithImpl(this._self, this._then);

  final MangaStatistics _self;
  final $Res Function(MangaStatistics) _then;

/// Create a copy of MangaStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? comments = freezed,Object? rating = null,Object? follows = null,}) {
  return _then(_self.copyWith(
comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as StatisticsDetailsComments?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as StatisticsDetailsRating,follows: null == follows ? _self.follows : follows // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of MangaStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticsDetailsCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $StatisticsDetailsCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}/// Create a copy of MangaStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticsDetailsRatingCopyWith<$Res> get rating {
  
  return $StatisticsDetailsRatingCopyWith<$Res>(_self.rating, (value) {
    return _then(_self.copyWith(rating: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _MangaStatistics with DiagnosticableTreeMixin implements MangaStatistics {
  const _MangaStatistics({this.comments, required this.rating, required this.follows});
  factory _MangaStatistics.fromJson(Map<String, dynamic> json) => _$MangaStatisticsFromJson(json);

@override final  StatisticsDetailsComments? comments;
@override final  StatisticsDetailsRating rating;
@override final  int follows;

/// Create a copy of MangaStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MangaStatisticsCopyWith<_MangaStatistics> get copyWith => __$MangaStatisticsCopyWithImpl<_MangaStatistics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MangaStatisticsToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MangaStatistics'))
    ..add(DiagnosticsProperty('comments', comments))..add(DiagnosticsProperty('rating', rating))..add(DiagnosticsProperty('follows', follows));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MangaStatistics&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.follows, follows) || other.follows == follows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,comments,rating,follows);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MangaStatistics(comments: $comments, rating: $rating, follows: $follows)';
}


}

/// @nodoc
abstract mixin class _$MangaStatisticsCopyWith<$Res> implements $MangaStatisticsCopyWith<$Res> {
  factory _$MangaStatisticsCopyWith(_MangaStatistics value, $Res Function(_MangaStatistics) _then) = __$MangaStatisticsCopyWithImpl;
@override @useResult
$Res call({
 StatisticsDetailsComments? comments, StatisticsDetailsRating rating, int follows
});


@override $StatisticsDetailsCommentsCopyWith<$Res>? get comments;@override $StatisticsDetailsRatingCopyWith<$Res> get rating;

}
/// @nodoc
class __$MangaStatisticsCopyWithImpl<$Res>
    implements _$MangaStatisticsCopyWith<$Res> {
  __$MangaStatisticsCopyWithImpl(this._self, this._then);

  final _MangaStatistics _self;
  final $Res Function(_MangaStatistics) _then;

/// Create a copy of MangaStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? comments = freezed,Object? rating = null,Object? follows = null,}) {
  return _then(_MangaStatistics(
comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as StatisticsDetailsComments?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as StatisticsDetailsRating,follows: null == follows ? _self.follows : follows // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of MangaStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticsDetailsCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $StatisticsDetailsCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}/// Create a copy of MangaStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticsDetailsRatingCopyWith<$Res> get rating {
  
  return $StatisticsDetailsRatingCopyWith<$Res>(_self.rating, (value) {
    return _then(_self.copyWith(rating: value));
  });
}
}


/// @nodoc
mixin _$ChapterStatistics implements DiagnosticableTreeMixin {

 StatisticsDetailsComments? get comments;
/// Create a copy of ChapterStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterStatisticsCopyWith<ChapterStatistics> get copyWith => _$ChapterStatisticsCopyWithImpl<ChapterStatistics>(this as ChapterStatistics, _$identity);

  /// Serializes this ChapterStatistics to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChapterStatistics'))
    ..add(DiagnosticsProperty('comments', comments));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterStatistics&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,comments);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChapterStatistics(comments: $comments)';
}


}

/// @nodoc
abstract mixin class $ChapterStatisticsCopyWith<$Res>  {
  factory $ChapterStatisticsCopyWith(ChapterStatistics value, $Res Function(ChapterStatistics) _then) = _$ChapterStatisticsCopyWithImpl;
@useResult
$Res call({
 StatisticsDetailsComments? comments
});


$StatisticsDetailsCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$ChapterStatisticsCopyWithImpl<$Res>
    implements $ChapterStatisticsCopyWith<$Res> {
  _$ChapterStatisticsCopyWithImpl(this._self, this._then);

  final ChapterStatistics _self;
  final $Res Function(ChapterStatistics) _then;

/// Create a copy of ChapterStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? comments = freezed,}) {
  return _then(_self.copyWith(
comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as StatisticsDetailsComments?,
  ));
}
/// Create a copy of ChapterStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticsDetailsCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $StatisticsDetailsCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _ChapterStatistics with DiagnosticableTreeMixin implements ChapterStatistics {
  const _ChapterStatistics({this.comments});
  factory _ChapterStatistics.fromJson(Map<String, dynamic> json) => _$ChapterStatisticsFromJson(json);

@override final  StatisticsDetailsComments? comments;

/// Create a copy of ChapterStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterStatisticsCopyWith<_ChapterStatistics> get copyWith => __$ChapterStatisticsCopyWithImpl<_ChapterStatistics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterStatisticsToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChapterStatistics'))
    ..add(DiagnosticsProperty('comments', comments));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterStatistics&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,comments);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChapterStatistics(comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$ChapterStatisticsCopyWith<$Res> implements $ChapterStatisticsCopyWith<$Res> {
  factory _$ChapterStatisticsCopyWith(_ChapterStatistics value, $Res Function(_ChapterStatistics) _then) = __$ChapterStatisticsCopyWithImpl;
@override @useResult
$Res call({
 StatisticsDetailsComments? comments
});


@override $StatisticsDetailsCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class __$ChapterStatisticsCopyWithImpl<$Res>
    implements _$ChapterStatisticsCopyWith<$Res> {
  __$ChapterStatisticsCopyWithImpl(this._self, this._then);

  final _ChapterStatistics _self;
  final $Res Function(_ChapterStatistics) _then;

/// Create a copy of ChapterStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? comments = freezed,}) {
  return _then(_ChapterStatistics(
comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as StatisticsDetailsComments?,
  ));
}

/// Create a copy of ChapterStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticsDetailsCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $StatisticsDetailsCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}


/// @nodoc
mixin _$StatisticsDetailsComments implements DiagnosticableTreeMixin {

 int get threadId; int get repliesCount;
/// Create a copy of StatisticsDetailsComments
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticsDetailsCommentsCopyWith<StatisticsDetailsComments> get copyWith => _$StatisticsDetailsCommentsCopyWithImpl<StatisticsDetailsComments>(this as StatisticsDetailsComments, _$identity);

  /// Serializes this StatisticsDetailsComments to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StatisticsDetailsComments'))
    ..add(DiagnosticsProperty('threadId', threadId))..add(DiagnosticsProperty('repliesCount', repliesCount));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsDetailsComments&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.repliesCount, repliesCount) || other.repliesCount == repliesCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,threadId,repliesCount);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StatisticsDetailsComments(threadId: $threadId, repliesCount: $repliesCount)';
}


}

/// @nodoc
abstract mixin class $StatisticsDetailsCommentsCopyWith<$Res>  {
  factory $StatisticsDetailsCommentsCopyWith(StatisticsDetailsComments value, $Res Function(StatisticsDetailsComments) _then) = _$StatisticsDetailsCommentsCopyWithImpl;
@useResult
$Res call({
 int threadId, int repliesCount
});




}
/// @nodoc
class _$StatisticsDetailsCommentsCopyWithImpl<$Res>
    implements $StatisticsDetailsCommentsCopyWith<$Res> {
  _$StatisticsDetailsCommentsCopyWithImpl(this._self, this._then);

  final StatisticsDetailsComments _self;
  final $Res Function(StatisticsDetailsComments) _then;

/// Create a copy of StatisticsDetailsComments
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? threadId = null,Object? repliesCount = null,}) {
  return _then(_self.copyWith(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as int,repliesCount: null == repliesCount ? _self.repliesCount : repliesCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _StatisticsDetailsComments with DiagnosticableTreeMixin implements StatisticsDetailsComments {
  const _StatisticsDetailsComments({required this.threadId, required this.repliesCount});
  factory _StatisticsDetailsComments.fromJson(Map<String, dynamic> json) => _$StatisticsDetailsCommentsFromJson(json);

@override final  int threadId;
@override final  int repliesCount;

/// Create a copy of StatisticsDetailsComments
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticsDetailsCommentsCopyWith<_StatisticsDetailsComments> get copyWith => __$StatisticsDetailsCommentsCopyWithImpl<_StatisticsDetailsComments>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatisticsDetailsCommentsToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StatisticsDetailsComments'))
    ..add(DiagnosticsProperty('threadId', threadId))..add(DiagnosticsProperty('repliesCount', repliesCount));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticsDetailsComments&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.repliesCount, repliesCount) || other.repliesCount == repliesCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,threadId,repliesCount);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StatisticsDetailsComments(threadId: $threadId, repliesCount: $repliesCount)';
}


}

/// @nodoc
abstract mixin class _$StatisticsDetailsCommentsCopyWith<$Res> implements $StatisticsDetailsCommentsCopyWith<$Res> {
  factory _$StatisticsDetailsCommentsCopyWith(_StatisticsDetailsComments value, $Res Function(_StatisticsDetailsComments) _then) = __$StatisticsDetailsCommentsCopyWithImpl;
@override @useResult
$Res call({
 int threadId, int repliesCount
});




}
/// @nodoc
class __$StatisticsDetailsCommentsCopyWithImpl<$Res>
    implements _$StatisticsDetailsCommentsCopyWith<$Res> {
  __$StatisticsDetailsCommentsCopyWithImpl(this._self, this._then);

  final _StatisticsDetailsComments _self;
  final $Res Function(_StatisticsDetailsComments) _then;

/// Create a copy of StatisticsDetailsComments
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? repliesCount = null,}) {
  return _then(_StatisticsDetailsComments(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as int,repliesCount: null == repliesCount ? _self.repliesCount : repliesCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$StatisticsDetailsRating implements DiagnosticableTreeMixin {

 double? get average; double get bayesian;
/// Create a copy of StatisticsDetailsRating
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticsDetailsRatingCopyWith<StatisticsDetailsRating> get copyWith => _$StatisticsDetailsRatingCopyWithImpl<StatisticsDetailsRating>(this as StatisticsDetailsRating, _$identity);

  /// Serializes this StatisticsDetailsRating to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StatisticsDetailsRating'))
    ..add(DiagnosticsProperty('average', average))..add(DiagnosticsProperty('bayesian', bayesian));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsDetailsRating&&(identical(other.average, average) || other.average == average)&&(identical(other.bayesian, bayesian) || other.bayesian == bayesian));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,average,bayesian);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StatisticsDetailsRating(average: $average, bayesian: $bayesian)';
}


}

/// @nodoc
abstract mixin class $StatisticsDetailsRatingCopyWith<$Res>  {
  factory $StatisticsDetailsRatingCopyWith(StatisticsDetailsRating value, $Res Function(StatisticsDetailsRating) _then) = _$StatisticsDetailsRatingCopyWithImpl;
@useResult
$Res call({
 double? average, double bayesian
});




}
/// @nodoc
class _$StatisticsDetailsRatingCopyWithImpl<$Res>
    implements $StatisticsDetailsRatingCopyWith<$Res> {
  _$StatisticsDetailsRatingCopyWithImpl(this._self, this._then);

  final StatisticsDetailsRating _self;
  final $Res Function(StatisticsDetailsRating) _then;

/// Create a copy of StatisticsDetailsRating
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? average = freezed,Object? bayesian = null,}) {
  return _then(_self.copyWith(
average: freezed == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double?,bayesian: null == bayesian ? _self.bayesian : bayesian // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _StatisticsDetailsRating with DiagnosticableTreeMixin implements StatisticsDetailsRating {
  const _StatisticsDetailsRating({this.average, required this.bayesian});
  factory _StatisticsDetailsRating.fromJson(Map<String, dynamic> json) => _$StatisticsDetailsRatingFromJson(json);

@override final  double? average;
@override final  double bayesian;

/// Create a copy of StatisticsDetailsRating
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticsDetailsRatingCopyWith<_StatisticsDetailsRating> get copyWith => __$StatisticsDetailsRatingCopyWithImpl<_StatisticsDetailsRating>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatisticsDetailsRatingToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StatisticsDetailsRating'))
    ..add(DiagnosticsProperty('average', average))..add(DiagnosticsProperty('bayesian', bayesian));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticsDetailsRating&&(identical(other.average, average) || other.average == average)&&(identical(other.bayesian, bayesian) || other.bayesian == bayesian));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,average,bayesian);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StatisticsDetailsRating(average: $average, bayesian: $bayesian)';
}


}

/// @nodoc
abstract mixin class _$StatisticsDetailsRatingCopyWith<$Res> implements $StatisticsDetailsRatingCopyWith<$Res> {
  factory _$StatisticsDetailsRatingCopyWith(_StatisticsDetailsRating value, $Res Function(_StatisticsDetailsRating) _then) = __$StatisticsDetailsRatingCopyWithImpl;
@override @useResult
$Res call({
 double? average, double bayesian
});




}
/// @nodoc
class __$StatisticsDetailsRatingCopyWithImpl<$Res>
    implements _$StatisticsDetailsRatingCopyWith<$Res> {
  __$StatisticsDetailsRatingCopyWithImpl(this._self, this._then);

  final _StatisticsDetailsRating _self;
  final $Res Function(_StatisticsDetailsRating) _then;

/// Create a copy of StatisticsDetailsRating
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? average = freezed,Object? bayesian = null,}) {
  return _then(_StatisticsDetailsRating(
average: freezed == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double?,bayesian: null == bayesian ? _self.bayesian : bayesian // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$SelfRatingResponse implements DiagnosticableTreeMixin {

 Map<String, SelfRating> get ratings;
/// Create a copy of SelfRatingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelfRatingResponseCopyWith<SelfRatingResponse> get copyWith => _$SelfRatingResponseCopyWithImpl<SelfRatingResponse>(this as SelfRatingResponse, _$identity);

  /// Serializes this SelfRatingResponse to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SelfRatingResponse'))
    ..add(DiagnosticsProperty('ratings', ratings));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelfRatingResponse&&const DeepCollectionEquality().equals(other.ratings, ratings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(ratings));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SelfRatingResponse(ratings: $ratings)';
}


}

/// @nodoc
abstract mixin class $SelfRatingResponseCopyWith<$Res>  {
  factory $SelfRatingResponseCopyWith(SelfRatingResponse value, $Res Function(SelfRatingResponse) _then) = _$SelfRatingResponseCopyWithImpl;
@useResult
$Res call({
 Map<String, SelfRating> ratings
});




}
/// @nodoc
class _$SelfRatingResponseCopyWithImpl<$Res>
    implements $SelfRatingResponseCopyWith<$Res> {
  _$SelfRatingResponseCopyWithImpl(this._self, this._then);

  final SelfRatingResponse _self;
  final $Res Function(SelfRatingResponse) _then;

/// Create a copy of SelfRatingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ratings = null,}) {
  return _then(_self.copyWith(
ratings: null == ratings ? _self.ratings : ratings // ignore: cast_nullable_to_non_nullable
as Map<String, SelfRating>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SelfRatingResponse with DiagnosticableTreeMixin implements SelfRatingResponse {
  const _SelfRatingResponse(final  Map<String, SelfRating> ratings): _ratings = ratings;
  factory _SelfRatingResponse.fromJson(Map<String, dynamic> json) => _$SelfRatingResponseFromJson(json);

 final  Map<String, SelfRating> _ratings;
@override Map<String, SelfRating> get ratings {
  if (_ratings is EqualUnmodifiableMapView) return _ratings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ratings);
}


/// Create a copy of SelfRatingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelfRatingResponseCopyWith<_SelfRatingResponse> get copyWith => __$SelfRatingResponseCopyWithImpl<_SelfRatingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelfRatingResponseToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SelfRatingResponse'))
    ..add(DiagnosticsProperty('ratings', ratings));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelfRatingResponse&&const DeepCollectionEquality().equals(other._ratings, _ratings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_ratings));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SelfRatingResponse(ratings: $ratings)';
}


}

/// @nodoc
abstract mixin class _$SelfRatingResponseCopyWith<$Res> implements $SelfRatingResponseCopyWith<$Res> {
  factory _$SelfRatingResponseCopyWith(_SelfRatingResponse value, $Res Function(_SelfRatingResponse) _then) = __$SelfRatingResponseCopyWithImpl;
@override @useResult
$Res call({
 Map<String, SelfRating> ratings
});




}
/// @nodoc
class __$SelfRatingResponseCopyWithImpl<$Res>
    implements _$SelfRatingResponseCopyWith<$Res> {
  __$SelfRatingResponseCopyWithImpl(this._self, this._then);

  final _SelfRatingResponse _self;
  final $Res Function(_SelfRatingResponse) _then;

/// Create a copy of SelfRatingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ratings = null,}) {
  return _then(_SelfRatingResponse(
null == ratings ? _self._ratings : ratings // ignore: cast_nullable_to_non_nullable
as Map<String, SelfRating>,
  ));
}


}


/// @nodoc
mixin _$SelfRating implements DiagnosticableTreeMixin {

 dynamic get expiry; int get rating;@TimestampSerializer() DateTime get createdAt;
/// Create a copy of SelfRating
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelfRatingCopyWith<SelfRating> get copyWith => _$SelfRatingCopyWithImpl<SelfRating>(this as SelfRating, _$identity);

  /// Serializes this SelfRating to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SelfRating'))
    ..add(DiagnosticsProperty('expiry', expiry))..add(DiagnosticsProperty('rating', rating))..add(DiagnosticsProperty('createdAt', createdAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelfRating&&const DeepCollectionEquality().equals(other.expiry, expiry)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(expiry),rating,createdAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SelfRating(expiry: $expiry, rating: $rating, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SelfRatingCopyWith<$Res>  {
  factory $SelfRatingCopyWith(SelfRating value, $Res Function(SelfRating) _then) = _$SelfRatingCopyWithImpl;
@useResult
$Res call({
 int rating,@TimestampSerializer() DateTime createdAt
});




}
/// @nodoc
class _$SelfRatingCopyWithImpl<$Res>
    implements $SelfRatingCopyWith<$Res> {
  _$SelfRatingCopyWithImpl(this._self, this._then);

  final SelfRating _self;
  final $Res Function(SelfRating) _then;

/// Create a copy of SelfRating
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SelfRating extends SelfRating with DiagnosticableTreeMixin {
   _SelfRating({required this.rating, @TimestampSerializer() required this.createdAt}): super._();
  factory _SelfRating.fromJson(Map<String, dynamic> json) => _$SelfRatingFromJson(json);

@override final  int rating;
@override@TimestampSerializer() final  DateTime createdAt;

/// Create a copy of SelfRating
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelfRatingCopyWith<_SelfRating> get copyWith => __$SelfRatingCopyWithImpl<_SelfRating>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelfRatingToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SelfRating'))
    ..add(DiagnosticsProperty('rating', rating))..add(DiagnosticsProperty('createdAt', createdAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelfRating&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,createdAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SelfRating(rating: $rating, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SelfRatingCopyWith<$Res> implements $SelfRatingCopyWith<$Res> {
  factory _$SelfRatingCopyWith(_SelfRating value, $Res Function(_SelfRating) _then) = __$SelfRatingCopyWithImpl;
@override @useResult
$Res call({
 int rating,@TimestampSerializer() DateTime createdAt
});




}
/// @nodoc
class __$SelfRatingCopyWithImpl<$Res>
    implements _$SelfRatingCopyWith<$Res> {
  __$SelfRatingCopyWithImpl(this._self, this._then);

  final _SelfRating _self;
  final $Res Function(_SelfRating) _then;

/// Create a copy of SelfRating
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? createdAt = null,}) {
  return _then(_SelfRating(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CustomListAttributes implements DiagnosticableTreeMixin {

 String get name; CustomListVisibility get visibility; int get version;
/// Create a copy of CustomListAttributes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomListAttributesCopyWith<CustomListAttributes> get copyWith => _$CustomListAttributesCopyWithImpl<CustomListAttributes>(this as CustomListAttributes, _$identity);

  /// Serializes this CustomListAttributes to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CustomListAttributes'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('visibility', visibility))..add(DiagnosticsProperty('version', version));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomListAttributes&&(identical(other.name, name) || other.name == name)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,visibility,version);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CustomListAttributes(name: $name, visibility: $visibility, version: $version)';
}


}

/// @nodoc
abstract mixin class $CustomListAttributesCopyWith<$Res>  {
  factory $CustomListAttributesCopyWith(CustomListAttributes value, $Res Function(CustomListAttributes) _then) = _$CustomListAttributesCopyWithImpl;
@useResult
$Res call({
 String name, CustomListVisibility visibility, int version
});




}
/// @nodoc
class _$CustomListAttributesCopyWithImpl<$Res>
    implements $CustomListAttributesCopyWith<$Res> {
  _$CustomListAttributesCopyWithImpl(this._self, this._then);

  final CustomListAttributes _self;
  final $Res Function(CustomListAttributes) _then;

/// Create a copy of CustomListAttributes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? visibility = null,Object? version = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as CustomListVisibility,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CustomListAttributes with DiagnosticableTreeMixin implements CustomListAttributes {
  const _CustomListAttributes({required this.name, required this.visibility, required this.version});
  factory _CustomListAttributes.fromJson(Map<String, dynamic> json) => _$CustomListAttributesFromJson(json);

@override final  String name;
@override final  CustomListVisibility visibility;
@override final  int version;

/// Create a copy of CustomListAttributes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomListAttributesCopyWith<_CustomListAttributes> get copyWith => __$CustomListAttributesCopyWithImpl<_CustomListAttributes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomListAttributesToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CustomListAttributes'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('visibility', visibility))..add(DiagnosticsProperty('version', version));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomListAttributes&&(identical(other.name, name) || other.name == name)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,visibility,version);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CustomListAttributes(name: $name, visibility: $visibility, version: $version)';
}


}

/// @nodoc
abstract mixin class _$CustomListAttributesCopyWith<$Res> implements $CustomListAttributesCopyWith<$Res> {
  factory _$CustomListAttributesCopyWith(_CustomListAttributes value, $Res Function(_CustomListAttributes) _then) = __$CustomListAttributesCopyWithImpl;
@override @useResult
$Res call({
 String name, CustomListVisibility visibility, int version
});




}
/// @nodoc
class __$CustomListAttributesCopyWithImpl<$Res>
    implements _$CustomListAttributesCopyWith<$Res> {
  __$CustomListAttributesCopyWithImpl(this._self, this._then);

  final _CustomListAttributes _self;
  final $Res Function(_CustomListAttributes) _then;

/// Create a copy of CustomListAttributes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? visibility = null,Object? version = null,}) {
  return _then(_CustomListAttributes(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as CustomListVisibility,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ErrorResponse implements DiagnosticableTreeMixin {

 String get result; List<MDError> get errors;
/// Create a copy of ErrorResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorResponseCopyWith<ErrorResponse> get copyWith => _$ErrorResponseCopyWithImpl<ErrorResponse>(this as ErrorResponse, _$identity);

  /// Serializes this ErrorResponse to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ErrorResponse'))
    ..add(DiagnosticsProperty('result', result))..add(DiagnosticsProperty('errors', errors));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorResponse&&(identical(other.result, result) || other.result == result)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,const DeepCollectionEquality().hash(errors));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ErrorResponse(result: $result, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $ErrorResponseCopyWith<$Res>  {
  factory $ErrorResponseCopyWith(ErrorResponse value, $Res Function(ErrorResponse) _then) = _$ErrorResponseCopyWithImpl;
@useResult
$Res call({
 String result, List<MDError> errors
});




}
/// @nodoc
class _$ErrorResponseCopyWithImpl<$Res>
    implements $ErrorResponseCopyWith<$Res> {
  _$ErrorResponseCopyWithImpl(this._self, this._then);

  final ErrorResponse _self;
  final $Res Function(ErrorResponse) _then;

/// Create a copy of ErrorResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = null,Object? errors = null,}) {
  return _then(_self.copyWith(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<MDError>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ErrorResponse with DiagnosticableTreeMixin implements ErrorResponse {
  const _ErrorResponse(this.result, final  List<MDError> errors): _errors = errors;
  factory _ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

@override final  String result;
 final  List<MDError> _errors;
@override List<MDError> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}


/// Create a copy of ErrorResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorResponseCopyWith<_ErrorResponse> get copyWith => __$ErrorResponseCopyWithImpl<_ErrorResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorResponseToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ErrorResponse'))
    ..add(DiagnosticsProperty('result', result))..add(DiagnosticsProperty('errors', errors));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorResponse&&(identical(other.result, result) || other.result == result)&&const DeepCollectionEquality().equals(other._errors, _errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,const DeepCollectionEquality().hash(_errors));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ErrorResponse(result: $result, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$ErrorResponseCopyWith<$Res> implements $ErrorResponseCopyWith<$Res> {
  factory _$ErrorResponseCopyWith(_ErrorResponse value, $Res Function(_ErrorResponse) _then) = __$ErrorResponseCopyWithImpl;
@override @useResult
$Res call({
 String result, List<MDError> errors
});




}
/// @nodoc
class __$ErrorResponseCopyWithImpl<$Res>
    implements _$ErrorResponseCopyWith<$Res> {
  __$ErrorResponseCopyWithImpl(this._self, this._then);

  final _ErrorResponse _self;
  final $Res Function(_ErrorResponse) _then;

/// Create a copy of ErrorResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,Object? errors = null,}) {
  return _then(_ErrorResponse(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<MDError>,
  ));
}


}


/// @nodoc
mixin _$FrontPageData implements DiagnosticableTreeMixin {

 String get staffPicks; String get seasonal;
/// Create a copy of FrontPageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FrontPageDataCopyWith<FrontPageData> get copyWith => _$FrontPageDataCopyWithImpl<FrontPageData>(this as FrontPageData, _$identity);

  /// Serializes this FrontPageData to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FrontPageData'))
    ..add(DiagnosticsProperty('staffPicks', staffPicks))..add(DiagnosticsProperty('seasonal', seasonal));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FrontPageData&&(identical(other.staffPicks, staffPicks) || other.staffPicks == staffPicks)&&(identical(other.seasonal, seasonal) || other.seasonal == seasonal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,staffPicks,seasonal);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FrontPageData(staffPicks: $staffPicks, seasonal: $seasonal)';
}


}

/// @nodoc
abstract mixin class $FrontPageDataCopyWith<$Res>  {
  factory $FrontPageDataCopyWith(FrontPageData value, $Res Function(FrontPageData) _then) = _$FrontPageDataCopyWithImpl;
@useResult
$Res call({
 String staffPicks, String seasonal
});




}
/// @nodoc
class _$FrontPageDataCopyWithImpl<$Res>
    implements $FrontPageDataCopyWith<$Res> {
  _$FrontPageDataCopyWithImpl(this._self, this._then);

  final FrontPageData _self;
  final $Res Function(FrontPageData) _then;

/// Create a copy of FrontPageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? staffPicks = null,Object? seasonal = null,}) {
  return _then(_self.copyWith(
staffPicks: null == staffPicks ? _self.staffPicks : staffPicks // ignore: cast_nullable_to_non_nullable
as String,seasonal: null == seasonal ? _self.seasonal : seasonal // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FrontPageData with DiagnosticableTreeMixin implements FrontPageData {
  const _FrontPageData({required this.staffPicks, required this.seasonal});
  factory _FrontPageData.fromJson(Map<String, dynamic> json) => _$FrontPageDataFromJson(json);

@override final  String staffPicks;
@override final  String seasonal;

/// Create a copy of FrontPageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FrontPageDataCopyWith<_FrontPageData> get copyWith => __$FrontPageDataCopyWithImpl<_FrontPageData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FrontPageDataToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FrontPageData'))
    ..add(DiagnosticsProperty('staffPicks', staffPicks))..add(DiagnosticsProperty('seasonal', seasonal));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FrontPageData&&(identical(other.staffPicks, staffPicks) || other.staffPicks == staffPicks)&&(identical(other.seasonal, seasonal) || other.seasonal == seasonal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,staffPicks,seasonal);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FrontPageData(staffPicks: $staffPicks, seasonal: $seasonal)';
}


}

/// @nodoc
abstract mixin class _$FrontPageDataCopyWith<$Res> implements $FrontPageDataCopyWith<$Res> {
  factory _$FrontPageDataCopyWith(_FrontPageData value, $Res Function(_FrontPageData) _then) = __$FrontPageDataCopyWithImpl;
@override @useResult
$Res call({
 String staffPicks, String seasonal
});




}
/// @nodoc
class __$FrontPageDataCopyWithImpl<$Res>
    implements _$FrontPageDataCopyWith<$Res> {
  __$FrontPageDataCopyWithImpl(this._self, this._then);

  final _FrontPageData _self;
  final $Res Function(_FrontPageData) _then;

/// Create a copy of FrontPageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? staffPicks = null,Object? seasonal = null,}) {
  return _then(_FrontPageData(
staffPicks: null == staffPicks ? _self.staffPicks : staffPicks // ignore: cast_nullable_to_non_nullable
as String,seasonal: null == seasonal ? _self.seasonal : seasonal // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
