import '../../../../core/network/models/either.dart';
import '../../../../core/network/models/app_exception.dart';
import '../entities/booking.dart';

abstract class BookingRepository {
  Future<Either<AppException, Booking>> bookConcert({
    required int concertId,
    required int quantity,
  });

  Future<Either<AppException, List<Booking>>> fetchMyBookings();
}
