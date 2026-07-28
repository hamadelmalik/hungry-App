
import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_expectations.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/utils/perf_helper.dart';
import 'package:hungry/features/auth/data/user_model.dart';

class ProfileRepo {

  final ApiServices apiServices;

  ProfileRepo({
     required this.apiServices,
  });


  //------getProfileData--------

  Future<UserModel?> getProfileData() async {
    try {

      final token = await PrefHelper.getToken();

      if (token == null || token == 'guest') {
        return null;
      }


      final response = await apiServices.get('/profile');


      final data = response['data'];

      if (data is! Map<String, dynamic>) {
        throw ApiError(
          message: 'Invalid user data',
        );
      }


      return UserModel.fromJson(data);


    } on DioException catch (e) {

      throw ApiExpectations.handleError(e);

    } catch (e) {

      throw ApiError(
        message: e.toString(),
      );

    }
  }



  //------updateProfileData--------

  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  }) async {

    try {

      final formData = FormData.fromMap({

        'name': name,
        'email': email,
        'address': address,

        if (visa != null && visa.isNotEmpty)
          'visa': visa,


        if (imagePath != null && imagePath.isNotEmpty)

          'image': await MultipartFile.fromFile(
            imagePath,
            filename: 'profile.jpg',
          ),

      });



      final response = await apiServices.post(
        '/update-profile',
        formData,
      );


      final code = int.tryParse(
        response['code'].toString(),
      ) ?? 0;


      if(code != 200 && code != 201){

        throw ApiError(
          message: response['message'] ?? 'Update failed',
        );

      }



      final data = response['data'];


      if(data is! Map<String,dynamic>){

        throw ApiError(
          message: 'Invalid user data format',
        );

      }


      return UserModel.fromJson(data);


    } on DioException catch(e){

      throw ApiExpectations.handleError(e);

    } catch(e){

      throw ApiError(
        message: e.toString(),
      );

    }

  }

}