import 'package:freezed_annotation/freezed_annotation.dart';

import 'booking_concert.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

@freezed
abstract class Booking with _$Booking {
  const factory Booking({
    required int id,
    required int concertId,
    required BookingConcert concert,
    required int quantity,
    required int total,
    required String status,
    required String bookedAt,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
}
