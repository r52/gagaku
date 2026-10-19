// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrackedSeriesRef {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackedSeriesRef);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TrackedSeriesRef()';
}


}

/// @nodoc
class $TrackedSeriesRefCopyWith<$Res>  {
$TrackedSeriesRefCopyWith(TrackedSeriesRef _, $Res Function(TrackedSeriesRef) __);
}



/// @nodoc


class WebTrackedSeries extends TrackedSeriesRef {
  const WebTrackedSeries(this.series): super._();
  

 final  WebSeriesRef series;

/// Create a copy of TrackedSeriesRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebTrackedSeriesCopyWith<WebTrackedSeries> get copyWith => _$WebTrackedSeriesCopyWithImpl<WebTrackedSeries>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WebTrackedSeries&&(identical(other.series, series) || other.series == series));
}


@override
int get hashCode {
    return Object.hash(runtimeType,series);
}

@override
String toString() {
    return 'TrackedSeriesRef.web(series: $series)';
}


}

/// @nodoc
abstract mixin class $WebTrackedSeriesCopyWith<$Res> implements $TrackedSeriesRefCopyWith<$Res> {
  factory $WebTrackedSeriesCopyWith(WebTrackedSeries value, $Res Function(WebTrackedSeries) _then) = _$WebTrackedSeriesCopyWithImpl;
@useResult
$Res call({
 WebSeriesRef series
});


$WebSeriesRefCopyWith<$Res> get series;

}
/// @nodoc
class _$WebTrackedSeriesCopyWithImpl<$Res>
    implements $WebTrackedSeriesCopyWith<$Res> {
  _$WebTrackedSeriesCopyWithImpl(this._self, this._then);

  final WebTrackedSeries _self;
  final $Res Function(WebTrackedSeries) _then;

/// Create a copy of TrackedSeriesRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? series = null,}) {
  return _then(WebTrackedSeries(
null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as WebSeriesRef,
  ));
}

/// Create a copy of TrackedSeriesRef
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WebSeriesRefCopyWith<$Res> get series {
  
  return $WebSeriesRefCopyWith<$Res>(_self.series, (value) {
    return _then(_self.copyWith(series: value));
  });
}
}

/// @nodoc


class NativeMangaDexTrackedSeries extends TrackedSeriesRef {
  const NativeMangaDexTrackedSeries(this.mangaId): super._();
  

 final  String mangaId;

/// Create a copy of TrackedSeriesRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NativeMangaDexTrackedSeriesCopyWith<NativeMangaDexTrackedSeries> get copyWith => _$NativeMangaDexTrackedSeriesCopyWithImpl<NativeMangaDexTrackedSeries>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NativeMangaDexTrackedSeries&&(identical(other.mangaId, mangaId) || other.mangaId == mangaId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,mangaId);
}

@override
String toString() {
    return 'TrackedSeriesRef.nativeMangaDex(mangaId: $mangaId)';
}


}

/// @nodoc
abstract mixin class $NativeMangaDexTrackedSeriesCopyWith<$Res> implements $TrackedSeriesRefCopyWith<$Res> {
  factory $NativeMangaDexTrackedSeriesCopyWith(NativeMangaDexTrackedSeries value, $Res Function(NativeMangaDexTrackedSeries) _then) = _$NativeMangaDexTrackedSeriesCopyWithImpl;
@useResult
$Res call({
 String mangaId
});




}
/// @nodoc
class _$NativeMangaDexTrackedSeriesCopyWithImpl<$Res>
    implements $NativeMangaDexTrackedSeriesCopyWith<$Res> {
  _$NativeMangaDexTrackedSeriesCopyWithImpl(this._self, this._then);

  final NativeMangaDexTrackedSeries _self;
  final $Res Function(NativeMangaDexTrackedSeries) _then;

/// Create a copy of TrackedSeriesRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mangaId = null,}) {
  return _then(NativeMangaDexTrackedSeries(
null == mangaId ? _self.mangaId : mangaId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
