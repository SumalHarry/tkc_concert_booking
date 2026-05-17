// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Concert _$ConcertFromJson(Map<String, dynamic> json) => _Concert(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  artist: json['artist'] as String,
  venue: json['venue'] as String,
  location: json['location'] as String,
  dateTime: _readConcertDateTime(json, 'dateTime') as String,
  pricePerTicket: (json['price'] as num).toInt(),
  availableSeats: (json['availableSeats'] as num).toInt(),
  totalSeats: (json['totalSeats'] as num).toInt(),
  imageUrl: json['image'] as String,
);

Map<String, dynamic> _$ConcertToJson(_Concert instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'artist': instance.artist,
  'venue': instance.venue,
  'location': instance.location,
  'dateTime': instance.dateTime,
  'price': instance.pricePerTicket,
  'availableSeats': instance.availableSeats,
  'totalSeats': instance.totalSeats,
  'image': instance.imageUrl,
};
