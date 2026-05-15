// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Concert _$ConcertFromJson(Map<String, dynamic> json) => _Concert(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  artist: json['artist'] as String,
  dateTime: json['dateTime'] as String,
  venue: json['venue'] as String,
  pricePerTicket: (json['pricePerTicket'] as num).toInt(),
  availableSeats: (json['availableSeats'] as num).toInt(),
  totalSeats: (json['totalSeats'] as num).toInt(),
  imageUrl: json['imageUrl'] as String,
);

Map<String, dynamic> _$ConcertToJson(_Concert instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'artist': instance.artist,
  'dateTime': instance.dateTime,
  'venue': instance.venue,
  'pricePerTicket': instance.pricePerTicket,
  'availableSeats': instance.availableSeats,
  'totalSeats': instance.totalSeats,
  'imageUrl': instance.imageUrl,
};
