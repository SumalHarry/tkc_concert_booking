import 'package:dio/dio.dart';

import '../../../../core/network/as_object_list.dart';
import '../../../../core/network/models/either.dart';
import '../../../../core/network/dio_mapper.dart';
import '../../../../core/network/models/app_exception.dart';
import '../../domain/entities/booking.dart';

abstract class BookingRemoteDataSource {
  Future<Either<AppException, Booking>> bookConcert({
    required int concertId,
    required int quantity,
  });

  Future<Either<AppException, List<Booking>>> fetchBookings();
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  BookingRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Either<AppException, Booking>> bookConcert({
    required int concertId,
    required int quantity,
  }) async {
    try {
      final res = await _dio.post<dynamic>(
        '/booking',
        data: {'concertId': concertId, 'quantity': quantity},
      );
      return Right(Booking.fromJson(res.data));
    } catch (e, st) {
      return Left(mapDioException(e, st));
    }
  }

  @override
  Future<Either<AppException, List<Booking>>> fetchBookings() async {
    try {
      final res = await _dio.get<dynamic>('/booking');
      final list = asObjectList(res.data);
      final bookings = list.map((raw) => Booking.fromJson(raw)).toList();
      return Right(bookings);
    } catch (e, st) {
      return Left(mapDioException(e, st));
    }
  }
}
