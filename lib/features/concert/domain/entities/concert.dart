import 'package:freezed_annotation/freezed_annotation.dart';

part 'concert.freezed.dart';
part 'concert.g.dart';

Object? _readConcertDateTime(Map json, String key) {
  final dateTime = json['dateTime'];
  if (dateTime != null) return dateTime;
  final date = json['date'];
  final time = json['time'];
  if (date is String && time is String) return '${date}T$time';
  if (date is String) return date;
  return '';
}

@freezed
abstract class Concert with _$Concert {
  const factory Concert({
    required int id,
    required String name,
    required String artist,
    required String venue,
    required String location,
    @JsonKey(readValue: _readConcertDateTime) required String dateTime,
    @JsonKey(name: 'price') required int pricePerTicket,
    required int availableSeats,
    required int totalSeats,
    @JsonKey(name: 'image') required String imageUrl,
  }) = _Concert;

  factory Concert.fromJson(Map<String, dynamic> json) =>
      _$ConcertFromJson(json);
}
