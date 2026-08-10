import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ma3refa_mobile/core/errors/server_errors.dart';
import 'package:ma3refa_mobile/core/services/api_consumer.dart';
import 'package:ma3refa_mobile/core/utils/api_consts.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioServices implements ApiConsumer {
  Dio dio;
  DioServices(this.dio) {
    _initDio();
  }
  void _initDio() {
    dio.options.baseUrl = ApiConsts.baseUrl;
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        request: true,
      ),
    );
  }

  @override
  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      var statusCode = response.statusCode!;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
      } else {
        throw ServerException(
          message: response.data['message'] ?? '',
          statusCode: response.statusCode,
          errors: response.data,
        );
      }
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      var statusCode = response.statusCode!;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
      } else {
        throw ServerException(
          message: response.data['message'] ?? '',
          statusCode: response.statusCode,
          errors: response.data,
        );
      }
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic e) {
    if (e is DioException) {
      return _handleDioException(e);
    } else if (e is ServerException) {
      return e;
    } else {
      return ServerException(message: e.toString());
    }
  }

  ServerException _handleDioException(DioException e) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;
    final errorsMap = responseData is Map<String, dynamic>
        ? responseData
        : null;

    String message;

    switch (e.type) {
      case DioExceptionType.badResponse:
        message = _extractErrorMessage(responseData) ?? 'An error occurred';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout';
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad certificate';
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection';
        break;
      default:
        message = 'An error occurred';
        break;
    }

    return ServerException(
      message: message,
      statusCode: statusCode,
      errors: errorsMap,
    );
  }

  String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data['error'] != null) {
        if (data['error'] is List && data['error'].isNotEmpty) {
          return data['error'][0].toString();
        }
        return data['error'].toString();
      }
      return data['message']?.toString();
    }
    return null;
  }
}
