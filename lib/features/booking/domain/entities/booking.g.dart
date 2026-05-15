// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Booking _$BookingFromJson(Map<String, dynamic> json) => _Booking(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  concertId: (json['concertId'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
  totalPrice: (json['totalPrice'] as num).toInt(),
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$BookingToJson(_Booking instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'concertId': instance.concertId,
  'quantity': instance.quantity,
  'totalPrice': instance.totalPrice,
  'createdAt': instance.createdAt,
};
