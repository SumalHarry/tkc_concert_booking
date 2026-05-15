// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Booking _$BookingFromJson(Map<String, dynamic> json) => _Booking(
  id: (json['id'] as num).toInt(),
  concertId: (json['concertId'] as num).toInt(),
  concert: BookingConcert.fromJson(json['concert'] as Map<String, dynamic>),
  quantity: (json['quantity'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  status: json['status'] as String,
  bookedAt: json['bookedAt'] as String,
);

Map<String, dynamic> _$BookingToJson(_Booking instance) => <String, dynamic>{
  'id': instance.id,
  'concertId': instance.concertId,
  'concert': instance.concert,
  'quantity': instance.quantity,
  'total': instance.total,
  'status': instance.status,
  'bookedAt': instance.bookedAt,
};
