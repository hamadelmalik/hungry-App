import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/auth/repo/Auth/auth_repo.dart';
import 'package:hungry/features/auth/repo/profile/profile_repo.dart';

final ApiServices apiServices = ApiServices();
//profile repo
final ProfileRepo profileRepo = ProfileRepo(
  apiServices: apiServices,
);
//-----auth repo

final AuthRepo authRepo = AuthRepo(
  apiServices: apiServices,
  profileRepo: profileRepo,
);

