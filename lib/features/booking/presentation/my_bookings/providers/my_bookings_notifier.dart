import 'package:riverpod_annotation/riverpod_annotation.dart';

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

    final result = await ref.read(bookingRepositoryProvider).fetchMyBookings();

    result.fold(
      (failure) {
        state = state.copyWith(
          state: MyBookingsConcreteState.failure,
          message: failure.message,
        );
      },
      (items) {
        state = state.copyWith(
          bookings: items,
          hasData: items.isNotEmpty,
          state: MyBookingsConcreteState.loaded,
        );
      },
    );
  }

  Future<String?> cancel(Booking booking) async {
    if (state.cancelBusyId != null) return null;

    final previous = List<Booking>.from(state.bookings);

    /// Optimistic UX (§7.5).
    final filtered =
        previous.where((b) => b.id != booking.id).toList(growable: false);
    state = state.copyWith(bookings: filtered, cancelBusyId: booking.id);

    final repo = ref.read(bookingRepositoryProvider);
    final outcome = await repo.cancelBooking(booking.id);

    return outcome.fold(
      (failure) {
        state = state.copyWith(
          bookings: previous,
          resetCancelBusyId: true,
        );
        return failure.message;
      },
      (_) {
        state = state.copyWith(
          bookings: filtered,
          hasData: filtered.isNotEmpty,
          resetCancelBusyId: true,
        );
        return null;
      },
    );
  }
}
