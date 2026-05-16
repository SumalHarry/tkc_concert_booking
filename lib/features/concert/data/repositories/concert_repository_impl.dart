import '../../domain/repositories/concert_repository.dart';
import '../../domain/entities/concert.dart';
import '../../../../core/network/models/either.dart';
import '../../../../core/network/models/app_exception.dart';
import '../datasources/concert_remote_datasource.dart';

class ConcertRepositoryImpl implements ConcertRepository {
  ConcertRepositoryImpl(this._remote);

  final ConcertRemoteDataSource _remote;

  @override
  Future<Either<AppException, Concert>> fetchConcertById(int id) {
    return _remote.fetchConcertById(id);
  }

  @override
  Future<Either<AppException, List<Concert>>> fetchConcerts() {
    return _remote.fetchConcerts();
  }
}
