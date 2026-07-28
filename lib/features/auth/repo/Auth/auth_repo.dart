import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_expectations.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/utils/perf_helper.dart';
import 'package:hungry/core/utils/response_parser.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/repo/profile/profile_repo.dart';

class AuthRepo {
  final ApiServices apiServices;
  final ProfileRepo profileRepo;

  AuthRepo({required this.apiServices, required this.profileRepo});

  bool isGuest = false;
  UserModel? _currentUser;

  //------------- Login ----------------//

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

      await PrefHelper.saveToken(token);

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

  //------------- SignUp ----------------//

  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiServices.post('/register', {
        'name': name,
        'email': email,
        'password': password,
      });

      log("REGISTER RESPONSE => $response");

      if (response is! Map<String, dynamic>) {
        throw ApiError(message: 'Unexpected response');
      }

      final code = response['code'];

      final data = response['data'];

      final msg = response['message'];

      final statusCode = code is int ? code : int.tryParse(code.toString());

      if (statusCode != 200 && statusCode != 201) {
        throw ApiError(message: msg ?? 'Register failed');
      }

      final user = UserModel.fromJson(data);

      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }

      isGuest = false;

      _currentUser = user;

      return user;
    } on DioException catch (e) {
      throw ApiExpectations.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //------------- Auto Login ----------------//

  Future<UserModel?> autoLogin() async {
    final token = await PrefHelper.getToken();

    if (token == null || token == 'guest') {
      isGuest = true;

      _currentUser = null;

      return null;
    }

    try {
      final user = await profileRepo.getProfileData();

      _currentUser = user;

      return user;
    } catch (e) {
      await PrefHelper.clearToken();

      isGuest = true;

      _currentUser = null;

      return null;
    }
  }

  //------------- Logout ----------------//

  Future<void> logout() async {
    try {
      final response = await apiServices.post('/logout', {});

      log("Logout response: $response");

      final code = parseResponseCode(response) ?? 0;

      if (code != 200) {
        throw ApiError(message: 'Logout failed');
      }

      await PrefHelper.clearToken();

      _currentUser = null;
      isGuest = false;

      log("✅ Logout success");
    } on DioException catch (e) {
      throw ApiExpectations.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //------------- Guest ----------------//

  Future<void> continueAsGuest() async {
    isGuest = true;

    _currentUser = null;

    await PrefHelper.saveToken('guest');
  }

  //------------- Getter ----------------//

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => !isGuest && _currentUser != null;
}
