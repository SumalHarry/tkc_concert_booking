import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_concert.freezed.dart';
part 'booking_concert.g.dart';

@freezed
abstract class BookingConcert with _$BookingConcert {
  const factory BookingConcert({
    required int id,
    required String name,
    required String artist,
    required String dateTime,
    required String venue,
    required int pricePerTicket,
  }) = _BookingConcert;

  factory BookingConcert.fromJson(Map<String, dynamic> json) =>
      _$BookingConcertFromJson(json);
}
