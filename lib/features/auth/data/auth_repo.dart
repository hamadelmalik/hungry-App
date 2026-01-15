
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_expectations.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/utils/perf_helper.dart';
import 'package:hungry/features/auth/data/user_model.dart';

class AuthRepo {

  final ApiServices apiServices = ApiServices();
//--------singIn---------------------------
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiServices.post('/login', {
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = int.tryParse(response['code'].toString()) ?? 0;
        final data = response['data'];

        log('📡 Login response - code: $code, data: $data');

        if (code != 200 && code != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        final user = UserModel.fromJson(data);
        log('🔐 Login successful - User token: ${user.token ?? 'null'}');

        if (user.token != null) {
          await PerfHelper.saveToken(user.token!);
          log('💾 Token saved to storage: ${user.token}');
        } else {
          log('⚠️ No token received from server!');
        }


        return user;
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    } on DioException catch (e) {
      throw ApiExpectations.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
  //--------singUp---------------------------

  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiServices.post('/register', {
        'name': name,
        'password': password,
        'email': email,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final coder = int.tryParse(code);
        final data = response['data'];

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        /// condtion assement
        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PerfHelper.saveToken(user.token!);
        }

        return user;
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    } on DioException catch (e) {
      throw ApiExpectations.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
//------------getaProfileDate

Future<UserModel?>getProfileData()async{

try{
  final response = await apiServices.get('/profile');
  final user = UserModel.fromJson(response['data']);
  return user;

}on DioException catch(e){

  throw ApiExpectations.handleError(e);


}catch (e){
  throw ApiError(message: e.toString());
}

}


}

