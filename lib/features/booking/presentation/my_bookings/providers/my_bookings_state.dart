import 'package:equatable/equatable.dart';

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
    this.hasData = false,
    this.state = MyBookingsConcreteState.initial,
    this.message = '',
    this.cancelBusyId,
  });

  final List<Booking> bookings;
  final bool hasData;
  final MyBookingsConcreteState state;
  final String message;
  /// While non-null, a cancel attempt is running for this booking ID.
  final int? cancelBusyId;

  MyBookingsState copyWith({
    List<Booking>? bookings,
    bool? hasData,
    MyBookingsConcreteState? state,
    String? message,
    int? cancelBusyId,
    bool resetCancelBusyId = false,
  }) {
    return MyBookingsState(
      bookings: bookings ?? this.bookings,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      message: message ?? this.message,
      cancelBusyId:
          resetCancelBusyId ? null : (cancelBusyId ?? this.cancelBusyId),
    );
  }

  @override
  List<Object?> get props =>
      [bookings, hasData, state, message, cancelBusyId];
}
