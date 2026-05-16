import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miniapp_concert/core/network/models/app_exception.dart';
import 'package:miniapp_concert/core/network/models/either.dart';
import 'package:miniapp_concert/features/booking/domain/entities/booking.dart';
import 'package:miniapp_concert/features/booking/domain/providers/booking_providers.dart';
import 'package:miniapp_concert/features/booking/domain/repositories/booking_repository.dart';
import 'package:miniapp_concert/features/booking/presentation/my_bookings/providers/my_bookings_notifier.dart';
import 'package:miniapp_concert/features/booking/presentation/my_bookings/providers/my_bookings_state.dart';
import 'package:miniapp_concert/features/concert/domain/entities/concert.dart';
import 'package:miniapp_concert/features/concert/domain/providers/concert_providers.dart';
import 'package:miniapp_concert/features/concert/domain/repositories/concert_repository.dart';

Concert _concert(int id) => Concert(
      id: id,
      name: 'Concert $id',
      artist: 'Artist',
      venue: 'Venue',
      location: 'Bangkok',
      dateTime: '2026-01-01T20:00:00',
      pricePerTicket: 1000,
      availableSeats: 50,
      totalSeats: 100,
      imageUrl: 'https://example.com/$id.png',
    );

Booking _booking(int id, int concertId) => Booking(
      id: id,
      userId: 1,
      concertId: concertId,
      quantity: 2,
      totalPrice: 2000,
      createdAt: '2026-01-0${id}T10:00:00',
    );

class _FakeBookingRepository implements BookingRepository {
  Either<AppException, List<Booking>> myBookingsResult = const Right([]);

  @override
  Future<Either<AppException, List<Booking>>> fetchMyBookings() async =>
      myBookingsResult;

  @override
  Future<Either<AppException, Booking>> bookConcert({
    required int concertId,
    required int quantity,
  }) async =>
      Left(const AppException('not used'));
}

class _FakeConcertRepository implements ConcertRepository {
  Either<AppException, List<Concert>> concertsResult = const Right([]);

  @override
  Future<Either<AppException, List<Concert>>> fetchConcerts() async =>
      concertsResult;

  @override
  Future<Either<AppException, Concert>> fetchConcertById(int id) async =>
      Left(const AppException('not used'));
}

void main() {
  group('MyBookingsState', () {
    test('initial state has expected defaults', () {
      const state = MyBookingsState();
      expect(state.bookings, isEmpty);
      expect(state.concerts, isEmpty);
      expect(state.hasData, isFalse);
      expect(state.state, MyBookingsConcreteState.initial);
    });

    test('concertFor returns the concert matching the id', () {
      final state = MyBookingsState(concerts: {1: _concert(1), 2: _concert(2)});
      expect(state.concertFor(2)!.id, 2);
    });

    test('concertFor returns null for an unknown id', () {
      final state = MyBookingsState(concerts: {1: _concert(1)});
      expect(state.concertFor(99), isNull);
    });

    test('copyWith with no args returns equal state', () {
      final state = MyBookingsState(
        bookings: [_booking(1, 1)],
        concerts: {1: _concert(1)},
        hasData: true,
      );
      expect(state.copyWith(), equals(state));
    });
  });

  group('MyBookingsNotifier', () {
    late _FakeBookingRepository fakeBookingRepo;
    late _FakeConcertRepository fakeConcertRepo;
    late ProviderContainer container;

    setUp(() {
      fakeBookingRepo = _FakeBookingRepository();
      fakeConcertRepo = _FakeConcertRepository();
      container = ProviderContainer(
        overrides: [
          bookingRepositoryProvider.overrideWithValue(fakeBookingRepo),
          concertRepositoryProvider.overrideWithValue(fakeConcertRepo),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('initial state is MyBookingsConcreteState.initial', () {
      expect(
        container.read(myBookingsProvider).state,
        MyBookingsConcreteState.initial,
      );
    });

    test('load success populates bookings and concert map', () async {
      fakeBookingRepo.myBookingsResult =
          Right([_booking(1, 1), _booking(2, 2)]);
      fakeConcertRepo.concertsResult = Right([_concert(1), _concert(2)]);

      await container.read(myBookingsProvider.notifier).load();

      final state = container.read(myBookingsProvider);
      expect(state.state, MyBookingsConcreteState.loaded);
      expect(state.bookings.length, 2);
      expect(state.hasData, isTrue);
      expect(state.concertFor(1), isNotNull);
      expect(state.concertFor(2), isNotNull);
    });

    test('load with no bookings sets hasData false', () async {
      fakeBookingRepo.myBookingsResult = const Right([]);
      fakeConcertRepo.concertsResult = Right([_concert(1)]);

      await container.read(myBookingsProvider.notifier).load();

      final state = container.read(myBookingsProvider);
      expect(state.state, MyBookingsConcreteState.loaded);
      expect(state.hasData, isFalse);
    });

    test('load failure on bookings sets failure state with message', () async {
      fakeBookingRepo.myBookingsResult =
          const Left(AppException('Cannot load bookings', code: '500'));
      fakeConcertRepo.concertsResult = Right([_concert(1)]);

      await container.read(myBookingsProvider.notifier).load();

      final state = container.read(myBookingsProvider);
      expect(state.state, MyBookingsConcreteState.failure);
      expect(state.message, 'Cannot load bookings');
    });

    test('load still succeeds when concert fetch fails', () async {
      fakeBookingRepo.myBookingsResult = Right([_booking(1, 1)]);
      fakeConcertRepo.concertsResult =
          const Left(AppException('concert error'));

      await container.read(myBookingsProvider.notifier).load();

      final state = container.read(myBookingsProvider);
      expect(state.state, MyBookingsConcreteState.loaded);
      expect(state.bookings.length, 1);
      expect(state.concerts, isEmpty);
    });
  });
}
