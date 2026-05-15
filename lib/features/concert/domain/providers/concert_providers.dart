import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/concert_dio_provider.dart';
import '../../data/datasources/concert_remote_datasource.dart';
import '../../data/repositories/concert_repository_impl.dart';
import '../repositories/concert_repository.dart';

part 'concert_providers.g.dart';

@Riverpod(keepAlive: true)
ConcertRemoteDataSource concertRemoteDataSource(Ref ref) {
  return ConcertRemoteDataSourceImpl(ref.watch(concertDioProvider));
}

@Riverpod(keepAlive: true)
ConcertRepository concertRepository(Ref ref) {
  return ConcertRepositoryImpl(ref.watch(concertRemoteDataSourceProvider));
}
