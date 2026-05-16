import 'package:dio/dio.dart';

import 'models/app_exception.dart';

AppException mapDioException(Object error, [StackTrace? stackTrace]) {
  if (error is DioException) {
    final data = error.response?.data;
    final message =
        _messageFromResponse(data) ?? error.message ?? error.type.name;
    final code = error.response?.statusCode?.toString();
    return AppException(message, code: code);
  }
  return AppException('$error');
}

String? _messageFromResponse(dynamic data) {
  if (data is Map<String, dynamic> && data['message'] != null) {
    return data['message'] as String?;
  }
  return null;
}
