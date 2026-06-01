import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/cubit/auth_state.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit():super(AuthInitial());

//login function

final AuthRepo authRepo=AuthRepo();
 final  emailController = TextEditingController(text:'hamad@gmail.com');
  final    passwordController = TextEditingController(text: '12345678');
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();
  final formKey = GlobalKey<FormState>();
  UserModel? userModel;

Future<void> login({required String email ,required String password})async{
//emit loading
  emit(AuthLoading());
  try{
    //call function
    await authRepo.login(email, password);
    emit(AuthSuccess());
  }catch (e) {
    String errorMessage = "Something went wrong";
   if(e is ApiError){
  errorMessage=e.message;
}
  emit(AuthError(errorMessage));
  }
}
//getProfileData
Future getProfileData()async{

 userModel= await authRepo.getProfileData();
  try{

    emit(AuthSuccess());
  }catch (e){
    String errorMessage = "Something went wrong";
    if( e is ApiError){
      errorMessage=e.message;
    }
    emit(AuthError(errorMessage));
  }

}
//updateProfileData
Future updateProfileData({required String  name, required String  email,required String  address  ,String? visa,
  String? imagePath})async{

  userModel=await authRepo.updateProfileData(name: name,  email:email,  address:address ,visa: visa,imagePath: imagePath);
  try{
    emit(AuthSuccess());

  }catch (e){
    String errorMessage = "Something went wrong";
    if( e is ApiError){
      errorMessage=e.message;
    }
    emit(AuthError(errorMessage));
  }

}
  }

