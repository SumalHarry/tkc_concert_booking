import 'package:equatable/equatable.dart';

import '../../../../concert/domain/entities/concert.dart';
import '../../../domain/entities/booking.dart';

enum MyBookingsConcreteState {
  initial,
  loading,
  loaded,
  failure,
}

class MyBookingsState extends Equatable {
  const MyBookingsState({
    this.bookings = const [],
    this.concerts = const {},
    this.hasData = false,
    this.state = MyBookingsConcreteState.initial,
    this.message = '',
  });

  final List<Booking> bookings;
  final Map<int, Concert> concerts;
  final bool hasData;
  final MyBookingsConcreteState state;
  final String message;

  Concert? concertFor(int concertId) => concerts[concertId];

  MyBookingsState copyWith({
    List<Booking>? bookings,
    Map<int, Concert>? concerts,
    bool? hasData,
    MyBookingsConcreteState? state,
    String? message,
  }) {
    return MyBookingsState(
      bookings: bookings ?? this.bookings,
      concerts: concerts ?? this.concerts,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [bookings, concerts, hasData, state, message];
}
