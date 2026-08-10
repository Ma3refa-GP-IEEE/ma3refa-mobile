class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic errors;
  ServerException({required this.message, this.statusCode, this.errors});

  @override
  String toString() => message;
}
