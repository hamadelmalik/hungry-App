
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hungry/core/constants/api_constants.dart';
import 'package:hungry/core/utils/perf_helper.dart';

class DioClint{
  final Dio _dio=Dio(
    BaseOptions(
      baseUrl: ApiConstants.apiUrl,
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
      );

  DioClint(){

    _dio.interceptors.add(
      InterceptorsWrapper(
          onRequest: (options, handler)async {
            final token=await PrefHelper.getToken();
            log('🔑🔑🔑🔑🔑 TOKEN: $token');

            if(token!= null && token.isNotEmpty && token!='guest' ){

              options.headers["Authorization"] = 'Bearer $token';

            }

            // هنا تقدر تعدل في الـ request قبل ما يتبعت

            return handler.next(options);
          },



      )

    );
  }
  Dio get dio => _dio;
}