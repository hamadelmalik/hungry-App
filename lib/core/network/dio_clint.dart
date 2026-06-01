
import 'package:dio/dio.dart';
import 'package:hungry/core/utils/perf_helper.dart';

class DioClint{
  final Dio _dio=Dio(
    BaseOptions(
    baseUrl: 'http://192.168.100.9:8000/api',
      headers: {'Content-Type': 'application/json'},
    ),
      );

  DioClint(){

    _dio.interceptors.add(
      InterceptorsWrapper(
          onRequest: (options, handler)async {
            final token=await PrefHelper.getToken();
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