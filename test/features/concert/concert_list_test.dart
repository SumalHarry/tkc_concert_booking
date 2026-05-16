import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miniapp_concert/core/network/models/app_exception.dart';
import 'package:miniapp_concert/core/network/models/either.dart';
import 'package:miniapp_concert/features/concert/domain/entities/concert.dart';
import 'package:miniapp_concert/features/concert/domain/providers/concert_providers.dart';
import 'package:miniapp_concert/features/concert/domain/repositories/concert_repository.dart';
import 'package:miniapp_concert/features/concert/presentation/concert_list/providers/concert_list_notifier.dart';
import 'package:miniapp_concert/features/concert/presentation/concert_list/providers/concert_list_state.dart';

Concert _concert(int id) => Concert(
      id: id,
      name: 'Concert $id',
      artist: 'Artist $id',
      venue: 'Venue',
      location: 'Bangkok',
      dateTime: '2026-01-0${id}T20:00:00',
      pricePerTicket: 1000,
      availableSeats: 50,
      totalSeats: 100,
      imageUrl: 'https://example.com/$id.png',
    );

class _FakeConcertRepository implements ConcertRepository {
  Either<AppException, List<Concert>> fetchConcertsResult = const Right([]);

  @override
  Future<Either<AppException, List<Concert>>> fetchConcerts() async =>
      fetchConcertsResult;

  @override
  Future<Either<AppException, Concert>> fetchConcertById(int id) async =>
      Left(const AppException('not used'));
}

void main() {
  group('ConcertListState', () {
    test('initial state has expected defaults', () {
      const state = ConcertListState();
      expect(state.concerts, isEmpty);
      expect(state.hasData, isFalse);
      expect(state.state, ConcertListConcreteState.initial);
      expect(state.message, isEmpty);
      expect(state.isLoading, isFalse);
    });

    test('copyWith updates only specified fields', () {
      const state = ConcertListState();
      final updated = state.copyWith(
        state: ConcertListConcreteState.loading,
        isLoading: true,
      );
      expect(updated.state, ConcertListConcreteState.loading);
      expect(updated.isLoading, isTrue);
      expect(updated.concerts, isEmpty);
    });

    test('copyWith with no args returns equal state', () {
      final state = ConcertListState(concerts: [_concert(1)], hasData: true);
      expect(state.copyWith(), equals(state));
    });

    test('equality is based on props', () {
      final a = ConcertListState(concerts: [_concert(1)]);
      final b = ConcertListState(concerts: [_concert(1)]);
      expect(a, equals(b));
    });
  });

  group('ConcertListNotifier', () {
    late _FakeConcertRepository fakeRepo;
    late ProviderContainer container;

    setUp(() {
      fakeRepo = _FakeConcertRepository();
      container = ProviderContainer(
        overrides: [concertRepositoryProvider.overrideWithValue(fakeRepo)],
      );
    });

    tearDown(() => container.dispose());

    test('initial state is ConcertListConcreteState.initial', () {
      final state = container.read(concertListProvider);
      expect(state.state, ConcertListConcreteState.initial);
    });

    test('load success populates concerts and sets hasData true', () async {
      fakeRepo.fetchConcertsResult = Right([_concert(1), _concert(2)]);

      await container.read(concertListProvider.notifier).load();

      final state = container.read(concertListProvider);
      expect(state.state, ConcertListConcreteState.loaded);
      expect(state.concerts.length, 2);
      expect(state.hasData, isTrue);
      expect(state.isLoading, isFalse);
    });

    test('load with empty result sets hasData false', () async {
      fakeRepo.fetchConcertsResult = const Right([]);

      await container.read(concertListProvider.notifier).load();

      final state = container.read(concertListProvider);
      expect(state.state, ConcertListConcreteState.loaded);
      expect(state.concerts, isEmpty);
      expect(state.hasData, isFalse);
    });

    test('load failure sets failure state with message', () async {
      fakeRepo.fetchConcertsResult =
          const Left(AppException('Server unavailable', code: '503'));

      await container.read(concertListProvider.notifier).load();

      final state = container.read(concertListProvider);
      expect(state.state, ConcertListConcreteState.failure);
      expect(state.message, 'Server unavailable');
      expect(state.isLoading, isFalse);
    });
  });
}
