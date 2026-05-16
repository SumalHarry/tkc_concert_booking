import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miniapp_concert/core/network/models/app_exception.dart';
import 'package:miniapp_concert/core/network/models/either.dart';
import 'package:miniapp_concert/features/booking/domain/entities/booking.dart';
import 'package:miniapp_concert/features/booking/domain/providers/booking_providers.dart';
import 'package:miniapp_concert/features/booking/domain/repositories/booking_repository.dart';
import 'package:miniapp_concert/features/concert/domain/entities/concert.dart';
import 'package:miniapp_concert/features/concert/domain/providers/concert_providers.dart';
import 'package:miniapp_concert/features/concert/domain/repositories/concert_repository.dart';
import 'package:miniapp_concert/features/concert/presentation/concert_detail/providers/concert_detail_notifier.dart';
import 'package:miniapp_concert/features/concert/presentation/concert_detail/providers/concert_detail_state.dart';

Concert _concert({int id = 1, int availableSeats = 50, int price = 1000}) =>
    Concert(
      id: id,
      name: 'Concert $id',
      artist: 'Artist',
      venue: 'Venue',
      location: 'Bangkok',
      dateTime: '2026-01-01T20:00:00',
      pricePerTicket: price,
      availableSeats: availableSeats,
      totalSeats: 100,
      imageUrl: 'https://example.com/$id.png',
    );

Booking _booking() => const Booking(
      id: 1,
      userId: 1,
      concertId: 1,
      quantity: 2,
      totalPrice: 2000,
      createdAt: '2026-01-01T10:00:00',
    );

class _FakeConcertRepository implements ConcertRepository {
  Either<AppException, Concert> byIdResult = Right(_concert());

  @override
  Future<Either<AppException, List<Concert>>> fetchConcerts() async =>
      const Right([]);

  @override
  Future<Either<AppException, Concert>> fetchConcertById(int id) async =>
      byIdResult;
}

class _FakeBookingRepository implements BookingRepository {
  Either<AppException, Booking> bookResult = Right(_booking());

  @override
  Future<Either<AppException, Booking>> bookConcert({
    required int concertId,
    required int quantity,
  }) async =>
      bookResult;

  @override
  Future<Either<AppException, List<Booking>>> fetchMyBookings() async =>
      const Right([]);
}

void main() {
  group('ConcertDetailState', () {
    group('clampedQuantity', () {
      test('is 0 when concert is null', () {
        const state = ConcertDetailState(concertId: 1);
        expect(state.clampedQuantity, 0);
      });

      test('is 0 when concert has no available seats', () {
        final state = ConcertDetailState(
          concertId: 1,
          concert: _concert(availableSeats: 0),
          quantity: 5,
        );
        expect(state.clampedQuantity, 0);
      });

      test('clamps up to 1 when quantity is below 1', () {
        final state = ConcertDetailState(
          concertId: 1,
          concert: _concert(availableSeats: 10),
          quantity: 0,
        );
        expect(state.clampedQuantity, 1);
      });

      test('clamps down to available seats when quantity exceeds them', () {
        final state = ConcertDetailState(
          concertId: 1,
          concert: _concert(availableSeats: 3),
          quantity: 10,
        );
        expect(state.clampedQuantity, 3);
      });

      test('returns quantity when within range', () {
        final state = ConcertDetailState(
          concertId: 1,
          concert: _concert(availableSeats: 10),
          quantity: 4,
        );
        expect(state.clampedQuantity, 4);
      });
    });

    group('totalPrice', () {
      test('is 0 when concert is null', () {
        const state = ConcertDetailState(concertId: 1);
        expect(state.totalPrice, 0);
      });

      test('is 0 when no seats are available', () {
        final state = ConcertDetailState(
          concertId: 1,
          concert: _concert(availableSeats: 0, price: 500),
        );
        expect(state.totalPrice, 0);
      });

      test('is pricePerTicket times clamped quantity', () {
        final state = ConcertDetailState(
          concertId: 1,
          concert: _concert(availableSeats: 10, price: 500),
          quantity: 3,
        );
        expect(state.totalPrice, 1500);
      });

      test('uses clamped quantity when quantity exceeds availability', () {
        final state = ConcertDetailState(
          concertId: 1,
          concert: _concert(availableSeats: 2, price: 500),
          quantity: 99,
        );
        expect(state.totalPrice, 1000);
      });
    });
  });

  group('ConcertDetailNotifier', () {
    late _FakeConcertRepository fakeConcertRepo;
    late _FakeBookingRepository fakeBookingRepo;
    late ProviderContainer container;

    setUp(() {
      fakeConcertRepo = _FakeConcertRepository();
      fakeBookingRepo = _FakeBookingRepository();
      container = ProviderContainer(
        overrides: [
          concertRepositoryProvider.overrideWithValue(fakeConcertRepo),
          bookingRepositoryProvider.overrideWithValue(fakeBookingRepo),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('build initializes state with the given concertId', () {
      final state = container.read(concertDetailProvider(42));
      expect(state.concertId, 42);
      expect(state.concert, isNull);
      expect(state.state, ConcertDetailConcreteState.initial);
    });

    test('load success sets concert and loaded state', () async {
      fakeConcertRepo.byIdResult = Right(_concert(id: 1, availableSeats: 20));

      await container.read(concertDetailProvider(1).notifier).load();

      final state = container.read(concertDetailProvider(1));
      expect(state.state, ConcertDetailConcreteState.loaded);
      expect(state.concert, isNotNull);
      expect(state.concert!.availableSeats, 20);
    });

    test('load failure sets failure state with message', () async {
      fakeConcertRepo.byIdResult =
          const Left(AppException('Concert not found', code: '404'));

      await container.read(concertDetailProvider(1).notifier).load();

      final state = container.read(concertDetailProvider(1));
      expect(state.state, ConcertDetailConcreteState.failure);
      expect(state.message, 'Concert not found');
    });

    test('increment raises quantity, clamped to available seats', () async {
      fakeConcertRepo.byIdResult = Right(_concert(availableSeats: 2));
      final notifier = container.read(concertDetailProvider(1).notifier);
      await notifier.load();

      notifier.increment();
      expect(container.read(concertDetailProvider(1)).quantity, 2);

      notifier.increment();
      expect(container.read(concertDetailProvider(1)).quantity, 2);
    });

    test('decrement lowers quantity but not below 1', () async {
      fakeConcertRepo.byIdResult = Right(_concert(availableSeats: 10));
      final notifier = container.read(concertDetailProvider(1).notifier);
      await notifier.load();

      notifier.decrement();
      expect(container.read(concertDetailProvider(1)).quantity, 1);
    });

    test('changeQuantity is a no-op when no concert is loaded', () {
      final notifier = container.read(concertDetailProvider(1).notifier);
      notifier.changeQuantity(5);
      expect(container.read(concertDetailProvider(1)).quantity, 1);
    });

    test('book success returns true and clears bookingBusy', () async {
      fakeConcertRepo.byIdResult = Right(_concert(availableSeats: 10));
      fakeBookingRepo.bookResult = Right(_booking());
      final notifier = container.read(concertDetailProvider(1).notifier);
      await notifier.load();

      final result = await notifier.book();

      expect(result, isTrue);
      expect(container.read(concertDetailProvider(1)).bookingBusy, isFalse);
    });

    test('book failure returns false and sets message', () async {
      fakeConcertRepo.byIdResult = Right(_concert(availableSeats: 10));
      fakeBookingRepo.bookResult =
          const Left(AppException('Sold out', code: '409'));
      final notifier = container.read(concertDetailProvider(1).notifier);
      await notifier.load();

      final result = await notifier.book();

      expect(result, isFalse);
      final state = container.read(concertDetailProvider(1));
      expect(state.message, 'Sold out');
      expect(state.bookingBusy, isFalse);
    });

    test('book returns false when no concert is loaded', () async {
      final notifier = container.read(concertDetailProvider(1).notifier);
      final result = await notifier.book();
      expect(result, isFalse);
    });
  });
}
