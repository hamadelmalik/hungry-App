import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/cubit/profile_states.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/repo/profile/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {

  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo)
      : super(ProfileInitial());
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController visa = TextEditingController();

UserModel?userModel;
  bool isGuest = false;
  String? imagePath;

  void setImage(String path) {
    imagePath = path;
    emit(ProfileImageSelected());
  }
  //---------get Profile Data
  Future<void> getProfileData() async {

    emit(ProfileLoading());

    try {

      final user = await profileRepo.getProfileData();

      if (user != null) {
        userModel = user;

        // تعبئة الحقول
        name.text = user.name ;
        email.text = user.email ;
        address.text = user.address ?? '';
        visa.text = user.visa ?? '';

        emit(ProfileSuccess(user));
      }

    } catch (e) {

      emit(ProfileError(e.toString()));

    }
  }


  //---------update Profile
  Future<void> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? selectImage,
  }) async {

    emit(UpdateProfileLoading());

    try {

      final user = await profileRepo.updateProfileData(
        name: name.trim(),
        email:email.trim(),
        address: address.trim(),
        visa: visa?.trim(),
        imagePath: selectImage,
      );


      if(user != null){

        emit(UpdateProfileSuccess(user));

      }


    } catch (e) {

      String errorMsg = 'Error update profile';

      if(e is ApiError){
        errorMsg = e.message;
      }

      emit(UpdateProfileError(errorMsg));

    }
  }

}