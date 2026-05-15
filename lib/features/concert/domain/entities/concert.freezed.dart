// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'concert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Concert {

 int get id; String get name; String get artist; String get venue; String get location; String get dateTime; int get pricePerTicket; int get availableSeats; int get totalSeats; String get imageUrl;
/// Create a copy of Concert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConcertCopyWith<Concert> get copyWith => _$ConcertCopyWithImpl<Concert>(this as Concert, _$identity);

  /// Serializes this Concert to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Concert&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.location, location) || other.location == location)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.pricePerTicket, pricePerTicket) || other.pricePerTicket == pricePerTicket)&&(identical(other.availableSeats, availableSeats) || other.availableSeats == availableSeats)&&(identical(other.totalSeats, totalSeats) || other.totalSeats == totalSeats)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,artist,venue,location,dateTime,pricePerTicket,availableSeats,totalSeats,imageUrl);

@override
String toString() {
  return 'Concert(id: $id, name: $name, artist: $artist, venue: $venue, location: $location, dateTime: $dateTime, pricePerTicket: $pricePerTicket, availableSeats: $availableSeats, totalSeats: $totalSeats, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $ConcertCopyWith<$Res>  {
  factory $ConcertCopyWith(Concert value, $Res Function(Concert) _then) = _$ConcertCopyWithImpl;
@useResult
$Res call({
 int id, String name, String artist, String venue, String location, String dateTime, int pricePerTicket, int availableSeats, int totalSeats, String imageUrl
});




}
/// @nodoc
class _$ConcertCopyWithImpl<$Res>
    implements $ConcertCopyWith<$Res> {
  _$ConcertCopyWithImpl(this._self, this._then);

  final Concert _self;
  final $Res Function(Concert) _then;

/// Create a copy of Concert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? artist = null,Object? venue = null,Object? location = null,Object? dateTime = null,Object? pricePerTicket = null,Object? availableSeats = null,Object? totalSeats = null,Object? imageUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as String,pricePerTicket: null == pricePerTicket ? _self.pricePerTicket : pricePerTicket // ignore: cast_nullable_to_non_nullable
as int,availableSeats: null == availableSeats ? _self.availableSeats : availableSeats // ignore: cast_nullable_to_non_nullable
as int,totalSeats: null == totalSeats ? _self.totalSeats : totalSeats // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Concert].
extension ConcertPatterns on Concert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Concert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Concert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Concert value)  $default,){
final _that = this;
switch (_that) {
case _Concert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Concert value)?  $default,){
final _that = this;
switch (_that) {
case _Concert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String artist,  String venue,  String location,  String dateTime,  int pricePerTicket,  int availableSeats,  int totalSeats,  String imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Concert() when $default != null:
return $default(_that.id,_that.name,_that.artist,_that.venue,_that.location,_that.dateTime,_that.pricePerTicket,_that.availableSeats,_that.totalSeats,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String artist,  String venue,  String location,  String dateTime,  int pricePerTicket,  int availableSeats,  int totalSeats,  String imageUrl)  $default,) {final _that = this;
switch (_that) {
case _Concert():
return $default(_that.id,_that.name,_that.artist,_that.venue,_that.location,_that.dateTime,_that.pricePerTicket,_that.availableSeats,_that.totalSeats,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String artist,  String venue,  String location,  String dateTime,  int pricePerTicket,  int availableSeats,  int totalSeats,  String imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _Concert() when $default != null:
return $default(_that.id,_that.name,_that.artist,_that.venue,_that.location,_that.dateTime,_that.pricePerTicket,_that.availableSeats,_that.totalSeats,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Concert implements Concert {
  const _Concert({required this.id, required this.name, required this.artist, required this.venue, required this.location, required this.dateTime, required this.pricePerTicket, required this.availableSeats, required this.totalSeats, required this.imageUrl});
  factory _Concert.fromJson(Map<String, dynamic> json) => _$ConcertFromJson(json);

@override final  int id;
@override final  String name;
@override final  String artist;
@override final  String venue;
@override final  String location;
@override final  String dateTime;
@override final  int pricePerTicket;
@override final  int availableSeats;
@override final  int totalSeats;
@override final  String imageUrl;

/// Create a copy of Concert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConcertCopyWith<_Concert> get copyWith => __$ConcertCopyWithImpl<_Concert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConcertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Concert&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.location, location) || other.location == location)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.pricePerTicket, pricePerTicket) || other.pricePerTicket == pricePerTicket)&&(identical(other.availableSeats, availableSeats) || other.availableSeats == availableSeats)&&(identical(other.totalSeats, totalSeats) || other.totalSeats == totalSeats)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,artist,venue,location,dateTime,pricePerTicket,availableSeats,totalSeats,imageUrl);

@override
String toString() {
  return 'Concert(id: $id, name: $name, artist: $artist, venue: $venue, location: $location, dateTime: $dateTime, pricePerTicket: $pricePerTicket, availableSeats: $availableSeats, totalSeats: $totalSeats, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ConcertCopyWith<$Res> implements $ConcertCopyWith<$Res> {
  factory _$ConcertCopyWith(_Concert value, $Res Function(_Concert) _then) = __$ConcertCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String artist, String venue, String location, String dateTime, int pricePerTicket, int availableSeats, int totalSeats, String imageUrl
});




}
/// @nodoc
class __$ConcertCopyWithImpl<$Res>
    implements _$ConcertCopyWith<$Res> {
  __$ConcertCopyWithImpl(this._self, this._then);

  final _Concert _self;
  final $Res Function(_Concert) _then;

/// Create a copy of Concert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? artist = null,Object? venue = null,Object? location = null,Object? dateTime = null,Object? pricePerTicket = null,Object? availableSeats = null,Object? totalSeats = null,Object? imageUrl = null,}) {
  return _then(_Concert(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as String,pricePerTicket: null == pricePerTicket ? _self.pricePerTicket : pricePerTicket // ignore: cast_nullable_to_non_nullable
as int,availableSeats: null == availableSeats ? _self.availableSeats : availableSeats // ignore: cast_nullable_to_non_nullable
as int,totalSeats: null == totalSeats ? _self.totalSeats : totalSeats // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
