import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_expectations.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/utils/perf_helper.dart';
import 'package:hungry/core/utils/response_parser.dart';
import 'package:hungry/features/auth/data/user_model.dart';

class AuthRepo {
  bool isGuest = false;
  UserModel? _currentUser;

  final ApiServices apiServices = ApiServices();

  //-------- /// Login---------------------------
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiServices.post('/login', {
        'email': email,
        'password': password,
      });

      if (response is! Map<String, dynamic>) {
        throw ApiError(message: 'Unexpected response from server');
      }

      log('📡 Login response: $response');

      final String? token = response['access_token'];
      final Map<String, dynamic>? userJson = response['user'];

      if (token == null || userJson == null) {
        throw ApiError(message: 'Token or user data missing');
      }

      // ✅ token
      await PrefHelper.saveToken(token);
      log('💾 Token saved to storage: $token');

      // ✅ create user
      final user = UserModel.fromJson(userJson);

      isGuest = false;
      _currentUser = user;
      return user;

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

        //----if user has a token-----------------
        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        isGuest = false;
        _currentUser = user;
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


  //------------getaProfileDate-----------//

  Future<UserModel?> getProfileData() async {
    try {
      log('🚀 ENTER getProfileData');

      final token = await PrefHelper.getToken();
      log('🔑 TOKEN VALUE: $token');

      if (token == null || token == 'guest') {
        log('⛔ TOKEN INVALID');
        return null;
      }

      final response = await apiServices.get('/profile');
      log('✅ PROFILE RESPONSE: $response');

      final data = response['data'];
      if (data == null || data is! Map<String, dynamic>) {
        log('⚠️ DATA IS NULL OR INVALID');
        return null;
      }

      return UserModel.fromJson(data);
    } catch (e, s) {
      log('❌ ERROR: $e');
      log('📌 STACK: $s');
      return null;
    }
  }



  //-----------logout-----------//

  Future<void> logout() async {
    try {
      final response = await apiServices.post('/logout', {});
      log("Logout response: $response");

      final code = parseResponseCode(response) ?? 0;


      if (code == 200) {
        // نجاح
        log("✅ Logged out successfully");
      } else {
        // فشل
        log("❌ Logout failed, code: $code");
      }
    } catch (e) {
      log("❌ LOGOUT ERROR: $e");

    }

  }
  //-------continue as guest--------

  Future<void> continueAsGuest() async {
    isGuest = true;
    _currentUser = null;
    await PrefHelper.saveToken('guest');
  }

  //--------autoLogin---------------

  Future<UserModel?> autoLogin() async {
    final token = await PrefHelper.getToken();
    if (token == null || token == 'guest') {
      isGuest = true;
      _currentUser = null;
      return null;
    }
    isGuest = false;
    try {
      final user = await getProfileData();
      _currentUser = user;
      return user;
    } catch (e) {
      await PrefHelper.clearToken();
      isGuest = true;
      _currentUser = null;
      return null;
    }
  }

  /// update profile data
  /// update profile data
  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  }) async {
    try {
      print("🔥 UPDATE PROFILE START");

      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'address': address,
        if (visa != null && visa.isNotEmpty) 'visa': visa, // ✅ صح
        if (imagePath != null && imagePath.isNotEmpty)
          'image': await MultipartFile.fromFile(
            imagePath,
            filename: 'profile.jpg',
          ),
      });

      final response = await apiServices.post('/update-profile', formData);
      print("✅ RESPONSE: $response");

      if (response is ApiError) {
        throw response;
      }

      if (response is! Map<String, dynamic>) {
        throw ApiError(message: 'Invalid response format');
      }

      final code = parseResponseCode(response) ?? 0;
      final msg = response['message'];
      final data = response['data'];

      if (code != 200 && code != 201) {
        throw ApiError(message: msg ?? 'Unknown error');
      }

      // ✅ حماية من الخطأ القاتل
      if (data is! Map<String, dynamic>) {
        log("❌❌❌ DATA TYPE: ${data.runtimeType}");
        log("❌❌❌ DATA VALUE: $data");
        throw ApiError(message: 'Invalid user data format');
      }

      final updatedUser = UserModel.fromJson(data);
      _currentUser = updatedUser;

      log("🎉 PROFILE UPDATED SUCCESS");
      return updatedUser;
    } on DioException catch (e) {
      throw ApiExpectations.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
  UserModel? get currentUser  => _currentUser;

  bool get isLoggedIn => !isGuest && _currentUser != null;
}
