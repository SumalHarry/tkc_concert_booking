import 'package:dio/dio.dart';

import '../../../../core/network/as_object_list.dart';
import '../../../../core/network/models/either.dart';
import '../../../../core/network/dio_mapper.dart';
import '../../../../core/network/models/app_exception.dart';
import '../../domain/entities/concert.dart';

abstract class ConcertRemoteDataSource {
  Future<Either<AppException, List<Concert>>> fetchConcerts();

  Future<Either<AppException, Concert>> fetchConcertById(int id);
}

class ConcertRemoteDataSourceImpl implements ConcertRemoteDataSource {
  ConcertRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Either<AppException, List<Concert>>> fetchConcerts() async {
    try {
      final res = await _dio.get<dynamic>('/concert');
      final list = asObjectList(res.data);
      final concerts = list
          .map(
            (raw) => Concert.fromJson(raw),
          )
          .toList();
      return Right(concerts);
    } catch (e, st) {
      return Left(mapDioException(e, st));
    }
  }

  @override
  Future<Either<AppException, Concert>> fetchConcertById(int id) async {
    try {
      final res = await _dio.get<dynamic>('/concert/$id');
      return Right(Concert.fromJson(res.data));
    } catch (e, st) {
      return Left(mapDioException(e, st));
    }
  }
}
