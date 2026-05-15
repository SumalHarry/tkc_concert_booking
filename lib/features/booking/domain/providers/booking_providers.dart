import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/concert_dio_provider.dart';
import '../../data/datasources/booking_remote_datasource.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../repositories/booking_repository.dart';

part 'booking_providers.g.dart';

@Riverpod(keepAlive: true)
BookingRemoteDataSource bookingRemoteDataSource(Ref ref) {
  return BookingRemoteDataSourceImpl(ref.watch(concertDioProvider));
}

@Riverpod(keepAlive: true)
BookingRepository bookingRepository(Ref ref) {
  return BookingRepositoryImpl(ref.watch(bookingRemoteDataSourceProvider));
}
