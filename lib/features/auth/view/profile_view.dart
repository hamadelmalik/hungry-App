import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/auth/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/cubit/auth_state.dart';
import 'package:hungry/features/auth/cubit/profile_cubit.dart';
import 'package:hungry/features/auth/cubit/profile_states.dart';
import 'package:hungry/features/auth/view/widget/custom_bottom.dart';
import 'package:hungry/features/auth/view/widget/guest_mode.dart';
import 'package:hungry/shared/custom_snak.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';

import 'package:hungry/features/auth/view/widget/custom_profile_text_filed.dart';
import 'package:hungry/shared/custom_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override

  State<ProfileView> createState() => _ProfileViewState();

}

class _ProfileViewState extends State<ProfileView> {

  @override
  void initState() {
    super.initState();

    context.read<ProfileCubit>().getProfileData();
  }




   Future<void> pickImage() async {
     final image = await ImagePicker().pickImage(
       source: ImageSource.gallery,
     );

    if(image!=null && mounted){
     context.read<ProfileCubit>().setImage(image.path);
    }
   }

  @override



  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    if (!authCubit.isGuest) {
      return BlocConsumer<ProfileCubit,ProfileState>(
        listener: (context, state) {

          if (state is UpdateProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnack(
                "Profile updated successfully",
                color: Colors.green[400],
                iconData: Icons.check_circle,
              ),
            );
          }

          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnack(state.message),
            );
          }

        },
        builder: (context,state){
final cubit=context.read<ProfileCubit>();
return  Scaffold(
            // backgroundColor:  ColorPalette.aje,
            appBar: AppBar(
              toolbarHeight: 0.0,
              scrolledUnderElevation: 0.0,

              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: RefreshIndicator(
                color: ColorPalette.primaryColor,
                onRefresh: () async {
                  await cubit.getProfileData();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Skeletonizer(
                    enabled: cubit.userModel == null,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.popUntil(
                                context,
                                    (route) => route.isFirst,
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: ColorPalette.primaryColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                              child: Icon(CupertinoIcons.settings_solid),
                            ),
                          ],
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: Colors.black),
                              color: Colors.grey.shade300,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(3),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey.shade200,
                                  child: cubit.imagePath != null
                                      ? ClipOval(
                                    child: Image.file(
                                      File(cubit.imagePath!),
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : (cubit.userModel?.image != null &&
                                      cubit.userModel!.image.isNotEmpty)
                                      ? ClipOval(
                                    child: Image.network(
                                     cubit.userModel!.image,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        // لو حصل أي خطأ في التحميل
                                        return const Icon(
                                          Icons.person,
                                          size: 40,
                                        );
                                      },
                                    ),
                                  )
                                      : const Icon(Icons.person, size: 40),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //------uploadImage------
                            CustomAuthBottom(
                              height: 30,
                              width: 100,
                              onTap: pickImage,
                              text: 'Upload Image',
                              fontSize: 12,
                              textColor: Colors.white,
                              color: ColorPalette.primaryColor,
                            ),
                            //------clearImage------
                            CustomAuthBottom(
                              height: 30,
                              width: 100,
                          //    onTap: clearImage,
                              text: 'clear',
                              fontSize: 12,
                              textColor: Colors.white,
                              color: Colors.red,
                            ),
                          ],
                        ),

                        Gap(15),
                        CustomProfileTextFiled(controller: cubit.name, label: 'Name'),
                        Gap(15),
                        CustomProfileTextFiled(controller: cubit.email, label: 'Email'),
                        Gap(15),
                        CustomProfileTextFiled(
                          controller:cubit.address,
                          label: 'Address',
                        ),
                        Gap(10),
                        Divider(color: ColorPalette.primaryColor),
                        Gap(10),

                        //---visa--------------
                        cubit.userModel?.visa != null
                            ? CustomProfileTextFiled(
                          controller: cubit.visa,
                          label: 'visa',
                          textInputType: TextInputType.number,
                        )
                            : ListTile(
                          onTap: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),

                          tileColor: Colors.blue.shade900,
                          leading: Image.asset(AssetsPath.Asset, width: 50),
                          title: const CustomText(
                            text: 'Debit card',
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          subtitle: CustomText(
                            text: (() {
                              final visa = cubit.userModel?.visa;

                              if (visa != null &&
                                  visa.trim().isNotEmpty &&
                                  visa.toLowerCase() != 'null') {
                                return visa; // عرض الرقم كامل
                              }

                              return '*****1235';
                            })(),
                            color: Colors.white,
                            fontSize: 18,
                          ),

                          trailing: CustomText(
                            text: 'Default',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            bottomSheet: Container(
              height: 100,

              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      //updateProfileData
                      child: BlocBuilder<ProfileCubit,ProfileState>(
                        builder: (context,state){
                          final cubitProfile=context.read<ProfileCubit>();
                          return InkWell(
                            onTap: () {
                              cubitProfile.updateProfileData(
                                name: cubitProfile.name.text,
                                email: cubitProfile.email.text,
                                address: cubitProfile.address.text,
                                visa: cubitProfile.visa.text,
                                selectImage: cubitProfile.imagePath,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorPalette.primaryColor,
                                  width: 2,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: state is UpdateProfileLoading
                                    ? CupertinoActivityIndicator(color: Colors.white)
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: 'Edit Profile',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Icon(
                                      Icons.edit_document,
                                      color: ColorPalette.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                      ),
                    ),
                    SizedBox(width: 10), // مسافة بين الزرين
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          context.read<AuthCubit>().logout();
                        },

                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorPalette.primaryColor,
                              width: 2,
                            ),
                            color: ColorPalette.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: state is LogoutLoading
                                ? CupertinoActivityIndicator(color: Colors.white)
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: 'Logout',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                Icon(Icons.logout, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      );
    } else if  (!authCubit.isGuest) {
      return GuestModeView();
    }
    return SizedBox();
  }
}
