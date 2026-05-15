import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/providers/concert_providers.dart';
import 'concert_list_state.dart';

part 'concert_list_notifier.g.dart';

@riverpod
class ConcertListNotifier extends _$ConcertListNotifier {
  @override
  ConcertListState build() => const ConcertListState.initial();

  Future<void> load() async {
    state = state.copyWith(
      state: ConcertListConcreteState.loading,
      isLoading: true,
      message: '',
    );

    final result =
        await ref.read(concertRepositoryProvider).fetchConcerts();
    result.fold(
      (failure) {
        state = state.copyWith(
          state: ConcertListConcreteState.failure,
          message: failure.message,
          isLoading: false,
        );
      },
      (concerts) {
        state = state.copyWith(
          concerts: concerts,
          hasData: concerts.isNotEmpty,
          state: ConcertListConcreteState.loaded,
          isLoading: false,
        );
      },
    );
  }
}
