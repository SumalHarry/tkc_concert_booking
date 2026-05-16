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
      final response = await _dio.post<dynamic>(
        '/booking',
        data: {'concertId': concertId, 'quantity': quantity},
      );
      return Right(Booking.fromJson(response.data));
    } catch (error, stackTrace) {
      return Left(mapDioException(error, stackTrace));
    }
  }

  @override
  Future<Either<AppException, List<Booking>>> fetchBookings() async {
    try {
      final response = await _dio.get<dynamic>('/booking');
      final list = asObjectList(response.data);
      final bookings = list.map((jsonItem) => Booking.fromJson(jsonItem)).toList();
      return Right(bookings);
    } catch (error, stackTrace) {
      return Left(mapDioException(error, stackTrace));
    }
  }
}
