import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'concert_dio_provider.g.dart';

/// Core App overrides this provider with an authenticated Dio before mounting
/// [ConcertApp].
@Riverpod(keepAlive: true)
Dio concertDio(Ref ref) => throw UnimplementedError(
  'concertDioProvider must be overridden by the Core App before use.',
);
