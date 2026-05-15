import '../../../../core/network/models/either.dart';
import '../../../../core/network/failures/app_exception.dart';
import '../../../../core/network/models/unit.dart';
import '../entities/booking.dart';

abstract class BookingRepository {
  Future<Either<AppException, Booking>> bookConcert({
    required int concertId,
    required int quantity,
  });

  Future<Either<AppException, List<Booking>>> fetchMyBookings();

  /// Not documented in the public assignment API spec; supported by many backends.
  /// If your server does not implement this yet, the UI will show an error SnackBar.
  Future<Either<AppException, Unit>> cancelBooking(int bookingId);
}
