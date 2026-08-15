import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/core/errors/server_errors.dart';
import 'package:ma3refa_mobile/core/services/api_consumer.dart';
import 'package:ma3refa_mobile/core/utils/api_consts.dart';
import 'package:ma3refa_mobile/features/auth/data/models/failuer_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioServices implements ApiConsumer {
  final Dio dio;

  DioServices(this.dio) {
    _initDio();
  }

  void _initDio() {
    dio.options.baseUrl = ApiConsts.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 15);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await CacheHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (DioException e, handler) {
          handler.next(e);
        },
      ),
    );

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
        data: body,
        options: Options(headers: headers),
      );
      return response.data as Map<String, dynamic>;
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
      return response.data as Map<String, dynamic>;
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
      return ServerException(failureModel: FailuerModel(message: e.toString()));
    }
  }

  ServerException _handleDioException(DioException e) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;

    if (e.type == DioExceptionType.badResponse &&
        responseData is Map<String, dynamic>) {
      return ServerException(
        failureModel: FailuerModel.fromJson(responseData),
        statusCode: statusCode,
      );
    }

    String message;
    switch (e.type) {
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
      case DioExceptionType.badResponse:
        message = _extractErrorMessage(responseData) ?? 'An error occurred';
        break;
      default:
        message = 'An unexpected error occurred';
        break;
    }

    return ServerException(
      failureModel: FailuerModel(message: message),
      statusCode: statusCode,
    );
  }

  String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      // فحص errors الخاصة بـ Laravel
      if (data['errors'] is Map<String, dynamic>) {
        final errors = data['errors'] as Map<String, dynamic>;
        if (errors.isNotEmpty) {
          final firstValue = errors.values.first;
          if (firstValue is List && firstValue.isNotEmpty) {
            return firstValue.first.toString();
          }
          return firstValue.toString();
        }
      }
      return data['message']?.toString();
    }
    return null;
  }
}
