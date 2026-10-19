// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrackerSyncError {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackerSyncError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TrackerSyncError()';
}


}

/// @nodoc
class $TrackerSyncErrorCopyWith<$Res>  {
$TrackerSyncErrorCopyWith(TrackerSyncError _, $Res Function(TrackerSyncError) __);
}



/// @nodoc


class TrackerRejectedUpdates implements TrackerSyncError {
  const TrackerRejectedUpdates(this.count);
  

 final  int count;

/// Create a copy of TrackerSyncError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackerRejectedUpdatesCopyWith<TrackerRejectedUpdates> get copyWith => _$TrackerRejectedUpdatesCopyWithImpl<TrackerRejectedUpdates>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackerRejectedUpdates&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode {
    return Object.hash(runtimeType,count);
}

@override
String toString() {
    return 'TrackerSyncError.rejected(count: $count)';
}


}

/// @nodoc
abstract mixin class $TrackerRejectedUpdatesCopyWith<$Res> implements $TrackerSyncErrorCopyWith<$Res> {
  factory $TrackerRejectedUpdatesCopyWith(TrackerRejectedUpdates value, $Res Function(TrackerRejectedUpdates) _then) = _$TrackerRejectedUpdatesCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class _$TrackerRejectedUpdatesCopyWithImpl<$Res>
    implements $TrackerRejectedUpdatesCopyWith<$Res> {
  _$TrackerRejectedUpdatesCopyWithImpl(this._self, this._then);

  final TrackerRejectedUpdates _self;
  final $Res Function(TrackerRejectedUpdates) _then;

/// Create a copy of TrackerSyncError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(TrackerRejectedUpdates(
null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class TrackerBatchException implements TrackerSyncError {
  const TrackerBatchException(this.message);
  

 final  String message;

/// Create a copy of TrackerSyncError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackerBatchExceptionCopyWith<TrackerBatchException> get copyWith => _$TrackerBatchExceptionCopyWithImpl<TrackerBatchException>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackerBatchException&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'TrackerSyncError.exception(message: $message)';
}


}

/// @nodoc
abstract mixin class $TrackerBatchExceptionCopyWith<$Res> implements $TrackerSyncErrorCopyWith<$Res> {
  factory $TrackerBatchExceptionCopyWith(TrackerBatchException value, $Res Function(TrackerBatchException) _then) = _$TrackerBatchExceptionCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TrackerBatchExceptionCopyWithImpl<$Res>
    implements $TrackerBatchExceptionCopyWith<$Res> {
  _$TrackerBatchExceptionCopyWithImpl(this._self, this._then);

  final TrackerBatchException _self;
  final $Res Function(TrackerBatchException) _then;

/// Create a copy of TrackerSyncError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TrackerBatchException(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TrackerSyncStatus {

 int get pending; int get dead; bool get running; DateTime? get lastSuccess;/// The tracker's last tracker-wide failure, until a batch succeeds.
 TrackerSyncError? get lastError;/// Tracker-wide backoff after a batch with no successes.
 DateTime? get retryAfter;
/// Create a copy of TrackerSyncStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackerSyncStatusCopyWith<TrackerSyncStatus> get copyWith => _$TrackerSyncStatusCopyWithImpl<TrackerSyncStatus>(this as TrackerSyncStatus, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TrackerSyncStatus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackerSyncStatus&&(identical(other.pending, _this.pending) || other.pending == _this.pending)&&(identical(other.dead, _this.dead) || other.dead == _this.dead)&&(identical(other.running, _this.running) || other.running == _this.running)&&(identical(other.lastSuccess, _this.lastSuccess) || other.lastSuccess == _this.lastSuccess)&&(identical(other.lastError, _this.lastError) || other.lastError == _this.lastError)&&(identical(other.retryAfter, _this.retryAfter) || other.retryAfter == _this.retryAfter));
}


@override
int get hashCode {
  final _this = this as TrackerSyncStatus;
  return Object.hash(runtimeType,_this.pending,_this.dead,_this.running,_this.lastSuccess,_this.lastError,_this.retryAfter);
}

@override
String toString() {
  final _this = this as TrackerSyncStatus;
  return 'TrackerSyncStatus(pending: ${_this.pending}, dead: ${_this.dead}, running: ${_this.running}, lastSuccess: ${_this.lastSuccess}, lastError: ${_this.lastError}, retryAfter: ${_this.retryAfter})';
}


}

/// @nodoc
abstract mixin class $TrackerSyncStatusCopyWith<$Res>  {
  factory $TrackerSyncStatusCopyWith(TrackerSyncStatus value, $Res Function(TrackerSyncStatus) _then) = _$TrackerSyncStatusCopyWithImpl;
@useResult
$Res call({
 int pending, int dead, bool running, DateTime? lastSuccess, TrackerSyncError? lastError, DateTime? retryAfter
});


$TrackerSyncErrorCopyWith<$Res>? get lastError;

}
/// @nodoc
class _$TrackerSyncStatusCopyWithImpl<$Res>
    implements $TrackerSyncStatusCopyWith<$Res> {
  _$TrackerSyncStatusCopyWithImpl(this._self, this._then);

  final TrackerSyncStatus _self;
  final $Res Function(TrackerSyncStatus) _then;

/// Create a copy of TrackerSyncStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pending = null,Object? dead = null,Object? running = null,Object? lastSuccess = freezed,Object? lastError = freezed,Object? retryAfter = freezed,}) {
  return _then(TrackerSyncStatus(
pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,dead: null == dead ? _self.dead : dead // ignore: cast_nullable_to_non_nullable
as int,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,lastSuccess: freezed == lastSuccess ? _self.lastSuccess : lastSuccess // ignore: cast_nullable_to_non_nullable
as DateTime?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as TrackerSyncError?,retryAfter: freezed == retryAfter ? _self.retryAfter : retryAfter // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of TrackerSyncStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrackerSyncErrorCopyWith<$Res>? get lastError {
    if (_self.lastError == null) {
    return null;
  }

  return $TrackerSyncErrorCopyWith<$Res>(_self.lastError!, (value) {
    return _then(_self.copyWith(lastError: value));
  });
}
}



/// @nodoc


class _TrackerSyncStatus implements TrackerSyncStatus {
  const _TrackerSyncStatus({this.pending = 0, this.dead = 0, this.running = false, this.lastSuccess, this.lastError, this.retryAfter});
  

@override@JsonKey() final  int pending;
@override@JsonKey() final  int dead;
@override@JsonKey() final  bool running;
@override final  DateTime? lastSuccess;
/// The tracker's last tracker-wide failure, until a batch succeeds.
@override final  TrackerSyncError? lastError;
/// Tracker-wide backoff after a batch with no successes.
@override final  DateTime? retryAfter;

/// Create a copy of TrackerSyncStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackerSyncStatusCopyWith<_TrackerSyncStatus> get copyWith => __$TrackerSyncStatusCopyWithImpl<_TrackerSyncStatus>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackerSyncStatus&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.dead, dead) || other.dead == dead)&&(identical(other.running, running) || other.running == running)&&(identical(other.lastSuccess, lastSuccess) || other.lastSuccess == lastSuccess)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.retryAfter, retryAfter) || other.retryAfter == retryAfter));
}


@override
int get hashCode {
    return Object.hash(runtimeType,pending,dead,running,lastSuccess,lastError,retryAfter);
}

@override
String toString() {
    return 'TrackerSyncStatus(pending: $pending, dead: $dead, running: $running, lastSuccess: $lastSuccess, lastError: $lastError, retryAfter: $retryAfter)';
}


}

/// @nodoc
abstract mixin class _$TrackerSyncStatusCopyWith<$Res> implements $TrackerSyncStatusCopyWith<$Res> {
  factory _$TrackerSyncStatusCopyWith(_TrackerSyncStatus value, $Res Function(_TrackerSyncStatus) _then) = __$TrackerSyncStatusCopyWithImpl;
@override @useResult
$Res call({
 int pending, int dead, bool running, DateTime? lastSuccess, TrackerSyncError? lastError, DateTime? retryAfter
});


@override $TrackerSyncErrorCopyWith<$Res>? get lastError;

}
/// @nodoc
class __$TrackerSyncStatusCopyWithImpl<$Res>
    implements _$TrackerSyncStatusCopyWith<$Res> {
  __$TrackerSyncStatusCopyWithImpl(this._self, this._then);

  final _TrackerSyncStatus _self;
  final $Res Function(_TrackerSyncStatus) _then;

/// Create a copy of TrackerSyncStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pending = null,Object? dead = null,Object? running = null,Object? lastSuccess = freezed,Object? lastError = freezed,Object? retryAfter = freezed,}) {
  return _then(_TrackerSyncStatus(
pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,dead: null == dead ? _self.dead : dead // ignore: cast_nullable_to_non_nullable
as int,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,lastSuccess: freezed == lastSuccess ? _self.lastSuccess : lastSuccess // ignore: cast_nullable_to_non_nullable
as DateTime?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as TrackerSyncError?,retryAfter: freezed == retryAfter ? _self.retryAfter : retryAfter // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of TrackerSyncStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrackerSyncErrorCopyWith<$Res>? get lastError {
    if (_self.lastError == null) {
    return null;
  }

  return $TrackerSyncErrorCopyWith<$Res>(_self.lastError!, (value) {
    return _then(_self.copyWith(lastError: value));
  });
}
}

// dart format on
