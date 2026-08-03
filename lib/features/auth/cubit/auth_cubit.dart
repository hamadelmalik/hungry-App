import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/cubit/auth_state.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/repo/Auth/auth_repo.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  //login function

  // final AuthRepo authRepo = AuthRepo();//login screen controller
  final emailController = TextEditingController(text: 'hamad@gmail.com');
  final passwordController = TextEditingController(text: '12345678');

  UserModel? userModel;
  bool isGuest = false;

  //--------register controller
  final TextEditingController regNameController = TextEditingController();
  final TextEditingController regEmailController = TextEditingController();
  final TextEditingController regPassController = TextEditingController();
  final TextEditingController reConfirmPassController = TextEditingController();

  //-------login
  Future<void> login({required String email, required String password}) async {
    try {
      log("🔥 LOGIN START");

      emit(LoginLoading());

      userModel = await authRepo.login(email, password);

      // المستخدم سجل دخول بنجاح، إذن ليس Guest
      isGuest = false;

      emit(LoginSuccess());
    } catch (e) {
      final errorMessage = e is ApiError ? e.message : "Something went wrong";

      emit(LoginError(errorMessage));
    }
  }

  //signup------------

  Future<void> signup() async {
    emit(SignUpLoading());

    try {
      userModel = await authRepo.signup(
        regNameController.text.trim(),
        regEmailController.text.trim(),
        regPassController.text.trim(),
      );
      isGuest = false;
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpError(e is ApiError ? e.message : "Error in Register"));
    }
  }

  //logout ----------

  Future<void> logout() async {
    // isGuest=false;
    emit(LogoutLoading());

    try {
      await authRepo.logout();
      isGuest = true;
      emit(LogoutSuccess());
    } catch (e) {
      String errorMessage = 'Something went wrong';

      if (e is ApiError) {
        errorMessage = e.message;
      }

      emit(LogoutError(errorMessage));
    }
  }

  //Auto login

  Future<void> autoLogin() async {
    emit(AutoLoginLoading());

    try {
      await authRepo.autoLogin();

      emit(AutoLoginSuccess());
    } catch (e) {
      String errorMessage = 'Something went wrong';

      if (e is ApiError) {
        errorMessage = e.message;
      }

      emit(AutoLoginError(errorMessage));
    }
  }
}
