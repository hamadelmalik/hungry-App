import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';

class ApiExpectations{


static ApiError handleError(DioException  error){
  switch (error.type){

    case DioException.connectionTimeout:
      return ApiError(message: 'No Internet Connection ');

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