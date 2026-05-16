import 'package:equatable/equatable.dart';

import '../../../domain/entities/concert.dart';

enum ConcertDetailConcreteState {
  initial,
  loading,
  loaded,
  failure,
}

class ConcertDetailState extends Equatable {
  const ConcertDetailState({
    required this.concertId,
    this.concert,
    this.quantity = 1,
    this.state = ConcertDetailConcreteState.initial,
    this.message = '',
    this.bookingBusy = false,
  });

  final int concertId;
  final Concert? concert;
  final int quantity;
  final ConcertDetailConcreteState state;
  final String message;
  final bool bookingBusy;

  int get clampedQuantity {
    final concert = this.concert;
    if (concert == null || concert.availableSeats <= 0) return 0;
    if (quantity < 1) return 1;
    if (quantity > concert.availableSeats) return concert.availableSeats;
    return quantity;
  }

  int get totalPrice {
    final concert = this.concert;
    if (concert == null) return 0;
    final quantity = clampedQuantity;
    if (quantity <= 0) return 0;
    return concert.pricePerTicket * quantity;
  }

  ConcertDetailState copyWith({
    int? concertId,
    Concert? concert,
    int? quantity,
    ConcertDetailConcreteState? state,
    String? message,
    bool? bookingBusy,
  }) {
    return ConcertDetailState(
      concertId: concertId ?? this.concertId,
      concert: concert ?? this.concert,
      quantity: quantity ?? this.quantity,
      state: state ?? this.state,
      message: message ?? this.message,
      bookingBusy: bookingBusy ?? this.bookingBusy,
    );
  }

  @override
  List<Object?> get props =>
      [concertId, concert, quantity, state, message, bookingBusy];
}
