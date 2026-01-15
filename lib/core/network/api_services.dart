import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_expectations.dart';
import 'package:hungry/core/network/dio_clint.dart';

class ApiServices {
  final DioClint dioClint = DioClint();

  Future<dynamic> get(String endPoint) async {
    try {
      final response = await dioClint.dio.get(endPoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiExpectations.handleError(e);
    }
  }

  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await dioClint.dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
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

  Future<dynamic> delete(String endPoint) async {
    try {
      final response = await dioClint.dio.delete(endPoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiExpectations.handleError(e);
    }
  }
}
