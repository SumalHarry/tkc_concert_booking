import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../booking/domain/providers/booking_providers.dart';
import '../../../domain/providers/concert_providers.dart';
import 'concert_detail_state.dart';

part 'concert_detail_notifier.g.dart';

@riverpod
class ConcertDetailNotifier extends _$ConcertDetailNotifier {
  @override
  ConcertDetailState build(int concertId) {
    return ConcertDetailState(concertId: concertId);
  }

  Future<void> load() async {
    final id = state.concertId;
    state = state.copyWith(
      state: ConcertDetailConcreteState.loading,
      message: '',
    );

    final result = await ref.read(concertRepositoryProvider).fetchConcertById(id);
    result.fold(
      (failure) {
        state = state.copyWith(
          state: ConcertDetailConcreteState.failure,
          message: failure.message,
        );
      },
      (concert) {
        final maxSeats = concert.availableSeats;
        final nextQty = maxSeats <= 0
            ? 0
            : state.quantity.clamp(1, maxSeats);
        state = state.copyWith(
          concert: concert,
          quantity: nextQty,
          state: ConcertDetailConcreteState.loaded,
        );
      },
    );
  }

  void changeQuantity(int next) {
    final c = state.concert;
    if (c == null || c.availableSeats < 1) return;
    final clamped = next.clamp(1, c.availableSeats);
    state = state.copyWith(quantity: clamped);
  }

  void increment() => changeQuantity(state.quantity + 1);

  void decrement() => changeQuantity(state.quantity - 1);

  Future<bool> book() async {
    final c = state.concert;
    if (c == null || c.availableSeats < 1 || state.bookingBusy) return false;

    state = state.copyWith(bookingBusy: true, message: '');
    final result = await ref.read(bookingRepositoryProvider).bookConcert(
          concertId: c.id,
          quantity: state.clampedQuantity,
        );

    return result.fold(
      (failure) {
        state = state.copyWith(
          bookingBusy: false,
          message: failure.message,
        );
        return false;
      },
      (_) {
        state = state.copyWith(bookingBusy: false);
        return true;
      },
    );
  }
}
