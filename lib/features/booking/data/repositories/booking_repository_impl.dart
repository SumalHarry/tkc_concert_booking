import '../../domain/repositories/booking_repository.dart';
import '../../domain/entities/booking.dart';
import '../../../../core/network/models/either.dart';
import '../../../../core/network/failures/app_exception.dart';
import '../datasources/booking_remote_datasource.dart';

class BookingRepositoryImpl implements BookingRepository {
  BookingRepositoryImpl(this._remote);

  final BookingRemoteDataSource _remote;

  @override
  Future<Either<AppException, Booking>> bookConcert({
    required int concertId,
    required int quantity,
  }) {
    return _remote.bookConcert(concertId: concertId, quantity: quantity);
  }

  @override
  Future<Either<AppException, List<Booking>>> fetchMyBookings() {
    return _remote.fetchBookings();
  }
}
