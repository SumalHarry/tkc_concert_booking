// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_concert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingConcert _$BookingConcertFromJson(Map<String, dynamic> json) =>
    _BookingConcert(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      artist: json['artist'] as String,
      dateTime: json['dateTime'] as String,
      venue: json['venue'] as String,
      pricePerTicket: (json['pricePerTicket'] as num).toInt(),
    );

Map<String, dynamic> _$BookingConcertToJson(_BookingConcert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artist': instance.artist,
      'dateTime': instance.dateTime,
      'venue': instance.venue,
      'pricePerTicket': instance.pricePerTicket,
    };
