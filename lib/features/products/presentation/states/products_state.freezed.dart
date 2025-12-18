// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductsState {

 List<Product> get products; Map<String, ProductStatus> get statusMap; bool get isRefreshing; String? get error;
/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductsStateCopyWith<ProductsState> get copyWith => _$ProductsStateCopyWithImpl<ProductsState>(this as ProductsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsState&&const DeepCollectionEquality().equals(other.products, products)&&const DeepCollectionEquality().equals(other.statusMap, statusMap)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(products),const DeepCollectionEquality().hash(statusMap),isRefreshing,error);

@override
String toString() {
  return 'ProductsState(products: $products, statusMap: $statusMap, isRefreshing: $isRefreshing, error: $error)';
}


}

/// @nodoc
abstract mixin class $ProductsStateCopyWith<$Res>  {
  factory $ProductsStateCopyWith(ProductsState value, $Res Function(ProductsState) _then) = _$ProductsStateCopyWithImpl;
@useResult
$Res call({
 List<Product> products, Map<String, ProductStatus> statusMap, bool isRefreshing, String? error
});




}
/// @nodoc
class _$ProductsStateCopyWithImpl<$Res>
    implements $ProductsStateCopyWith<$Res> {
  _$ProductsStateCopyWithImpl(this._self, this._then);

  final ProductsState _self;
  final $Res Function(ProductsState) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? products = null,Object? statusMap = null,Object? isRefreshing = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,statusMap: null == statusMap ? _self.statusMap : statusMap // ignore: cast_nullable_to_non_nullable
as Map<String, ProductStatus>,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductsState].
extension ProductsStatePatterns on ProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductsState value)  $default,){
final _that = this;
switch (_that) {
case _ProductsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductsState value)?  $default,){
final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Product> products,  Map<String, ProductStatus> statusMap,  bool isRefreshing,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that.products,_that.statusMap,_that.isRefreshing,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Product> products,  Map<String, ProductStatus> statusMap,  bool isRefreshing,  String? error)  $default,) {final _that = this;
switch (_that) {
case _ProductsState():
return $default(_that.products,_that.statusMap,_that.isRefreshing,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Product> products,  Map<String, ProductStatus> statusMap,  bool isRefreshing,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that.products,_that.statusMap,_that.isRefreshing,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ProductsState extends ProductsState {
  const _ProductsState({final  List<Product> products = const [], final  Map<String, ProductStatus> statusMap = const {}, this.isRefreshing = false, this.error}): _products = products,_statusMap = statusMap,super._();
  

 final  List<Product> _products;
@override@JsonKey() List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  Map<String, ProductStatus> _statusMap;
@override@JsonKey() Map<String, ProductStatus> get statusMap {
  if (_statusMap is EqualUnmodifiableMapView) return _statusMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_statusMap);
}

@override@JsonKey() final  bool isRefreshing;
@override final  String? error;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductsStateCopyWith<_ProductsState> get copyWith => __$ProductsStateCopyWithImpl<_ProductsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductsState&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._statusMap, _statusMap)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_statusMap),isRefreshing,error);

@override
String toString() {
  return 'ProductsState(products: $products, statusMap: $statusMap, isRefreshing: $isRefreshing, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ProductsStateCopyWith<$Res> implements $ProductsStateCopyWith<$Res> {
  factory _$ProductsStateCopyWith(_ProductsState value, $Res Function(_ProductsState) _then) = __$ProductsStateCopyWithImpl;
@override @useResult
$Res call({
 List<Product> products, Map<String, ProductStatus> statusMap, bool isRefreshing, String? error
});




}
/// @nodoc
class __$ProductsStateCopyWithImpl<$Res>
    implements _$ProductsStateCopyWith<$Res> {
  __$ProductsStateCopyWithImpl(this._self, this._then);

  final _ProductsState _self;
  final $Res Function(_ProductsState) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? products = null,Object? statusMap = null,Object? isRefreshing = null,Object? error = freezed,}) {
  return _then(_ProductsState(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,statusMap: null == statusMap ? _self._statusMap : statusMap // ignore: cast_nullable_to_non_nullable
as Map<String, ProductStatus>,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
