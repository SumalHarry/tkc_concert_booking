import 'package:freezed_annotation/freezed_annotation.dart';

part 'concert.freezed.dart';
part 'concert.g.dart';

@freezed
abstract class Concert with _$Concert {
  const factory Concert({
    required int id,
    required String name,
    required String artist,
    required String dateTime,
    required String venue,
    required int pricePerTicket,
    required int availableSeats,
    required int totalSeats,
    required String imageUrl,
  }) = _Concert;

  factory Concert.fromJson(Map<String, dynamic> json) =>
      _$ConcertFromJson(json);
}
