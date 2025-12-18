// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEditState {

 User get originalUser; User get editedUser; bool get isDirty; bool get isSaving; String? get saveError;
/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEditStateCopyWith<ProfileEditState> get copyWith => _$ProfileEditStateCopyWithImpl<ProfileEditState>(this as ProfileEditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditState&&(identical(other.originalUser, originalUser) || other.originalUser == originalUser)&&(identical(other.editedUser, editedUser) || other.editedUser == editedUser)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode => Object.hash(runtimeType,originalUser,editedUser,isDirty,isSaving,saveError);

@override
String toString() {
  return 'ProfileEditState(originalUser: $originalUser, editedUser: $editedUser, isDirty: $isDirty, isSaving: $isSaving, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class $ProfileEditStateCopyWith<$Res>  {
  factory $ProfileEditStateCopyWith(ProfileEditState value, $Res Function(ProfileEditState) _then) = _$ProfileEditStateCopyWithImpl;
@useResult
$Res call({
 User originalUser, User editedUser, bool isDirty, bool isSaving, String? saveError
});


$UserCopyWith<$Res> get originalUser;$UserCopyWith<$Res> get editedUser;

}
/// @nodoc
class _$ProfileEditStateCopyWithImpl<$Res>
    implements $ProfileEditStateCopyWith<$Res> {
  _$ProfileEditStateCopyWithImpl(this._self, this._then);

  final ProfileEditState _self;
  final $Res Function(ProfileEditState) _then;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originalUser = null,Object? editedUser = null,Object? isDirty = null,Object? isSaving = null,Object? saveError = freezed,}) {
  return _then(_self.copyWith(
originalUser: null == originalUser ? _self.originalUser : originalUser // ignore: cast_nullable_to_non_nullable
as User,editedUser: null == editedUser ? _self.editedUser : editedUser // ignore: cast_nullable_to_non_nullable
as User,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get originalUser {
  
  return $UserCopyWith<$Res>(_self.originalUser, (value) {
    return _then(_self.copyWith(originalUser: value));
  });
}/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get editedUser {
  
  return $UserCopyWith<$Res>(_self.editedUser, (value) {
    return _then(_self.copyWith(editedUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileEditState].
extension ProfileEditStatePatterns on ProfileEditState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileEditState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileEditState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileEditState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileEditState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileEditState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileEditState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User originalUser,  User editedUser,  bool isDirty,  bool isSaving,  String? saveError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileEditState() when $default != null:
return $default(_that.originalUser,_that.editedUser,_that.isDirty,_that.isSaving,_that.saveError);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User originalUser,  User editedUser,  bool isDirty,  bool isSaving,  String? saveError)  $default,) {final _that = this;
switch (_that) {
case _ProfileEditState():
return $default(_that.originalUser,_that.editedUser,_that.isDirty,_that.isSaving,_that.saveError);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User originalUser,  User editedUser,  bool isDirty,  bool isSaving,  String? saveError)?  $default,) {final _that = this;
switch (_that) {
case _ProfileEditState() when $default != null:
return $default(_that.originalUser,_that.editedUser,_that.isDirty,_that.isSaving,_that.saveError);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileEditState extends ProfileEditState {
  const _ProfileEditState({required this.originalUser, required this.editedUser, this.isDirty = false, this.isSaving = false, this.saveError}): super._();
  

@override final  User originalUser;
@override final  User editedUser;
@override@JsonKey() final  bool isDirty;
@override@JsonKey() final  bool isSaving;
@override final  String? saveError;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileEditStateCopyWith<_ProfileEditState> get copyWith => __$ProfileEditStateCopyWithImpl<_ProfileEditState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileEditState&&(identical(other.originalUser, originalUser) || other.originalUser == originalUser)&&(identical(other.editedUser, editedUser) || other.editedUser == editedUser)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode => Object.hash(runtimeType,originalUser,editedUser,isDirty,isSaving,saveError);

@override
String toString() {
  return 'ProfileEditState(originalUser: $originalUser, editedUser: $editedUser, isDirty: $isDirty, isSaving: $isSaving, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class _$ProfileEditStateCopyWith<$Res> implements $ProfileEditStateCopyWith<$Res> {
  factory _$ProfileEditStateCopyWith(_ProfileEditState value, $Res Function(_ProfileEditState) _then) = __$ProfileEditStateCopyWithImpl;
@override @useResult
$Res call({
 User originalUser, User editedUser, bool isDirty, bool isSaving, String? saveError
});


@override $UserCopyWith<$Res> get originalUser;@override $UserCopyWith<$Res> get editedUser;

}
/// @nodoc
class __$ProfileEditStateCopyWithImpl<$Res>
    implements _$ProfileEditStateCopyWith<$Res> {
  __$ProfileEditStateCopyWithImpl(this._self, this._then);

  final _ProfileEditState _self;
  final $Res Function(_ProfileEditState) _then;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalUser = null,Object? editedUser = null,Object? isDirty = null,Object? isSaving = null,Object? saveError = freezed,}) {
  return _then(_ProfileEditState(
originalUser: null == originalUser ? _self.originalUser : originalUser // ignore: cast_nullable_to_non_nullable
as User,editedUser: null == editedUser ? _self.editedUser : editedUser // ignore: cast_nullable_to_non_nullable
as User,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get originalUser {
  
  return $UserCopyWith<$Res>(_self.originalUser, (value) {
    return _then(_self.copyWith(originalUser: value));
  });
}/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get editedUser {
  
  return $UserCopyWith<$Res>(_self.editedUser, (value) {
    return _then(_self.copyWith(editedUser: value));
  });
}
}

// dart format on
