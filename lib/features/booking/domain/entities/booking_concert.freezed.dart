// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_concert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingConcert {

 int get id; String get name; String get artist; String get dateTime; String get venue; int get pricePerTicket;
/// Create a copy of BookingConcert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingConcertCopyWith<BookingConcert> get copyWith => _$BookingConcertCopyWithImpl<BookingConcert>(this as BookingConcert, _$identity);

  /// Serializes this BookingConcert to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingConcert&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.pricePerTicket, pricePerTicket) || other.pricePerTicket == pricePerTicket));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,artist,dateTime,venue,pricePerTicket);

@override
String toString() {
  return 'BookingConcert(id: $id, name: $name, artist: $artist, dateTime: $dateTime, venue: $venue, pricePerTicket: $pricePerTicket)';
}


}

/// @nodoc
abstract mixin class $BookingConcertCopyWith<$Res>  {
  factory $BookingConcertCopyWith(BookingConcert value, $Res Function(BookingConcert) _then) = _$BookingConcertCopyWithImpl;
@useResult
$Res call({
 int id, String name, String artist, String dateTime, String venue, int pricePerTicket
});




}
/// @nodoc
class _$BookingConcertCopyWithImpl<$Res>
    implements $BookingConcertCopyWith<$Res> {
  _$BookingConcertCopyWithImpl(this._self, this._then);

  final BookingConcert _self;
  final $Res Function(BookingConcert) _then;

/// Create a copy of BookingConcert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? artist = null,Object? dateTime = null,Object? venue = null,Object? pricePerTicket = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String,pricePerTicket: null == pricePerTicket ? _self.pricePerTicket : pricePerTicket // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingConcert].
extension BookingConcertPatterns on BookingConcert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingConcert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingConcert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingConcert value)  $default,){
final _that = this;
switch (_that) {
case _BookingConcert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingConcert value)?  $default,){
final _that = this;
switch (_that) {
case _BookingConcert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String artist,  String dateTime,  String venue,  int pricePerTicket)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingConcert() when $default != null:
return $default(_that.id,_that.name,_that.artist,_that.dateTime,_that.venue,_that.pricePerTicket);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String artist,  String dateTime,  String venue,  int pricePerTicket)  $default,) {final _that = this;
switch (_that) {
case _BookingConcert():
return $default(_that.id,_that.name,_that.artist,_that.dateTime,_that.venue,_that.pricePerTicket);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String artist,  String dateTime,  String venue,  int pricePerTicket)?  $default,) {final _that = this;
switch (_that) {
case _BookingConcert() when $default != null:
return $default(_that.id,_that.name,_that.artist,_that.dateTime,_that.venue,_that.pricePerTicket);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingConcert implements BookingConcert {
  const _BookingConcert({required this.id, required this.name, required this.artist, required this.dateTime, required this.venue, required this.pricePerTicket});
  factory _BookingConcert.fromJson(Map<String, dynamic> json) => _$BookingConcertFromJson(json);

@override final  int id;
@override final  String name;
@override final  String artist;
@override final  String dateTime;
@override final  String venue;
@override final  int pricePerTicket;

/// Create a copy of BookingConcert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingConcertCopyWith<_BookingConcert> get copyWith => __$BookingConcertCopyWithImpl<_BookingConcert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingConcertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingConcert&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.pricePerTicket, pricePerTicket) || other.pricePerTicket == pricePerTicket));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,artist,dateTime,venue,pricePerTicket);

@override
String toString() {
  return 'BookingConcert(id: $id, name: $name, artist: $artist, dateTime: $dateTime, venue: $venue, pricePerTicket: $pricePerTicket)';
}


}

/// @nodoc
abstract mixin class _$BookingConcertCopyWith<$Res> implements $BookingConcertCopyWith<$Res> {
  factory _$BookingConcertCopyWith(_BookingConcert value, $Res Function(_BookingConcert) _then) = __$BookingConcertCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String artist, String dateTime, String venue, int pricePerTicket
});




}
/// @nodoc
class __$BookingConcertCopyWithImpl<$Res>
    implements _$BookingConcertCopyWith<$Res> {
  __$BookingConcertCopyWithImpl(this._self, this._then);

  final _BookingConcert _self;
  final $Res Function(_BookingConcert) _then;

/// Create a copy of BookingConcert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? artist = null,Object? dateTime = null,Object? venue = null,Object? pricePerTicket = null,}) {
  return _then(_BookingConcert(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String,pricePerTicket: null == pricePerTicket ? _self.pricePerTicket : pricePerTicket // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
