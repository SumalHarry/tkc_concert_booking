import '../../../../core/network/models/either.dart';
import '../../../../core/network/failures/app_exception.dart';
import '../entities/concert.dart';

abstract class ConcertRepository {
  Future<Either<AppException, List<Concert>>> fetchConcerts();

  Future<Either<AppException, Concert>> fetchConcertById(int id);
}
