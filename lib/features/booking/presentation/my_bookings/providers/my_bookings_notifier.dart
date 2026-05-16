import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../concert/domain/entities/concert.dart';
import '../../../../concert/domain/providers/concert_providers.dart';
import '../../../domain/entities/booking.dart';
import '../../../domain/providers/booking_providers.dart';
import 'my_bookings_state.dart';

part 'my_bookings_notifier.g.dart';

@riverpod
class MyBookingsNotifier extends _$MyBookingsNotifier {
  @override
  MyBookingsState build() => const MyBookingsState();

  Future<void> load() async {
    state = state.copyWith(
      state: MyBookingsConcreteState.loading,
      message: '',
    );

    final results = await Future.wait([
      ref.read(bookingRepositoryProvider).fetchMyBookings(),
      ref.read(concertRepositoryProvider).fetchConcerts(),
    ]);

    final bookingResult = results[0] as dynamic;
    final concertResult = results[1] as dynamic;

    List<Booking> bookings = [];
    Map<int, Concert> concertMap = {};

    final concertEither = concertResult;
    concertEither.fold(
      (_) {},
      (concerts) {
        concertMap = {for (final concert in concerts as List<Concert>) concert.id: concert};
      },
    );

    bookingResult.fold(
      (failure) {
        state = state.copyWith(
          state: MyBookingsConcreteState.failure,
          message: failure.message,
        );
      },
      (items) {
        bookings = items as List<Booking>;
        state = state.copyWith(
          bookings: bookings,
          concerts: concertMap,
          hasData: bookings.isNotEmpty,
          state: MyBookingsConcreteState.loaded,
        );
      },
    );
  }

}
