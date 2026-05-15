import 'package:dio/dio.dart';

import '../../../../core/network/models/either.dart';
import '../../../../core/network/dio_mapper.dart';
import '../../../../core/network/failures/app_exception.dart';
import '../../../../core/network/models/unit.dart';
import '../../domain/entities/booking.dart';

abstract class BookingRemoteDataSource {
  Future<Either<AppException, Booking>> bookConcert({
    required int concertId,
    required int quantity,
  });

  Future<Either<AppException, List<Booking>>> fetchBookings();

  Future<Either<AppException, Unit>> cancelBooking(int bookingId);
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
      final payload = _unwrapObject(res.data);
      return Right(Booking.fromJson(payload));
    } catch (e, st) {
      return Left(mapDioException(e, st));
    }
  }

  @override
  Future<Either<AppException, List<Booking>>> fetchBookings() async {
    try {
      final res = await _dio.get<dynamic>('/booking');
      final list = _asObjectList(res.data);
      final bookings = list
          .map((raw) => Booking.fromJson(Map<String, dynamic>.from(raw as Map)))
          .toList();
      return Right(bookings);
    } catch (e, st) {
      return Left(mapDioException(e, st));
    }
  }

  @override
  Future<Either<AppException, Unit>> cancelBooking(int bookingId) async {
    try {
      await _dio.delete<void>('/booking/$bookingId');
      return const Right(unit);
    } catch (e, st) {
      return Left(mapDioException(e, st));
    }
  }
}

Map<String, dynamic> _unwrapObject(dynamic data) {
  if (data is Map<String, dynamic>) return data;
  if (data is Map) return Map<String, dynamic>.from(data);
  throw const FormatException('Unexpected booking payload');
}

List<dynamic> _asObjectList(dynamic data) {
  if (data is List<dynamic>) return data;
  if (data is Map && data['data'] is List<dynamic>) {
    return data['data'] as List<dynamic>;
  }
  throw const FormatException('Unexpected booking list payload');
}
