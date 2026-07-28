import 'package:hungry/features/auth/data/user_model.dart';

abstract class ProfileState {}
 class ProfileInitial extends ProfileState{}
//get profile
class ProfileLoading extends ProfileState{}
class ProfileSuccess extends ProfileState {

  final UserModel user;

  ProfileSuccess(this.user);

}
class  ProfileError extends ProfileState{
  final String message;
  ProfileError(this.message);
  }
//--- update  profile
class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {

  final UserModel user;

  UpdateProfileSuccess(this.user);

}



class UpdateProfileError extends ProfileState {
  final String message;
  UpdateProfileError(this.message);
}

class ProfileImageSelected extends ProfileState{}