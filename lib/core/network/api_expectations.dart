import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';


class ApiExpectations {
  static ApiError handleError(DioException error) {
    log('❌ Dio Error Type: ${error.type}');
    log('❌ Dio Error Message: ${error.message}');
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return ApiError(
          message: 'No Internet Connection',
        );

      case DioExceptionType.badResponse:
        return ApiError(
          message: error.response?.data['message'] ?? 'Server error',
          statusCode: error.response?.statusCode,
        );

      default:
        return ApiError(
          message: 'Unexpected error',
        );
    }
  }
}