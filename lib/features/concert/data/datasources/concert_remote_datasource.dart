import 'package:dio/dio.dart';

import '../../../../core/network/models/either.dart';
import '../../../../core/network/dio_mapper.dart';
import '../../../../core/network/failures/app_exception.dart';
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
      final list = _asObjectList(res.data);
      final concerts = list
          .map(
            (raw) => Concert.fromJson(Map<String, dynamic>.from(raw as Map)),
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
      final payload = _unwrapObject(res.data);
      return Right(Concert.fromJson(payload));
    } catch (e, st) {
      return Left(mapDioException(e, st));
    }
  }
}

Map<String, dynamic> _unwrapObject(dynamic data) {
  if (data is Map<String, dynamic>) return data;
  if (data is Map) return Map<String, dynamic>.from(data);
  throw const FormatException('Unexpected concert payload');
}

List<dynamic> _asObjectList(dynamic data) {
  if (data is List<dynamic>) return data;
  if (data is Map && data['data'] is List<dynamic>) {
    return data['data'] as List<dynamic>;
  }
  throw const FormatException('Unexpected concert list payload');
}
