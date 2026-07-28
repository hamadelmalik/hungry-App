import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_expectations.dart';
import 'package:hungry/core/network/dio_clint.dart';

class ApiServices {
  final DioClint dioClint = DioClint();

  Future<dynamic> get(String endPoint,{dynamic param}) async {
    try {
      final response = await dioClint.dio.get(endPoint,queryParameters: param);
      return response.data;
    } on DioException catch (e) {
      throw ApiExpectations.handleError(e);
    }
  }

  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await dioClint.dio.post(
          endPoint,
          data: body,
        options: body is FormData
      ? Options(
      contentType: 'multipart/form-data',
      )
        : null,

      );
      if(response.data is String){
        return response.data;
      }
      return response.data;


    } on DioException catch (e) {
      log("🔥 DIO ERROR RESPONSE: ${e.response?.data}");
      log("🔥 DIO ERROR STATUS: ${e.response?.statusCode}");
      log("🔥 DIO ERROR MESSAGE: ${e.message}");

      throw ApiExpectations.handleError(e);
    }
  }

  Future<dynamic> put(String endPoint, dynamic body) async {
    try {
      final response = await dioClint.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExpectations.handleError(e);
    }
  }

  Future<dynamic> delete(String endPoint,{ dynamic body ,dynamic param}) async {
    try {
      final response = await dioClint.dio.delete(
        endPoint,
        data: body,
        queryParameters: param,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiExpectations.handleError(e);
    }
  }
}
