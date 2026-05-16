List<dynamic> asObjectList(dynamic data) {
  if (data is List<dynamic>) return data;
  if (data is Map && data['data'] is List<dynamic>) {
    return data['data'] as List<dynamic>;
  }
  throw const FormatException('Unexpected list payload');
}
