import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/auth/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/cubit/auth_state.dart';
import 'package:hungry/features/auth/cubit/profile_cubit.dart';
import 'package:hungry/features/auth/cubit/profile_states.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/auth/view/widget/custom_bottom.dart';
import 'package:hungry/features/auth/view/widget/custom_profile_text_filed.dart';
import 'package:hungry/shared/custom_snack.dart';
import 'package:hungry/shared/custom_text.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  Future<void> pickImage(ProfileCubit cubit) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      cubit.setImage(image.path);
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnack(state.message));
        }
      },

      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();

        return BlocListener<AuthCubit, AuthStates>(
          listener: (context, authState) {
            if (authState is LogoutSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginView()),
                    (route) => false,
              );
            }

            if (authState is LogoutError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(customSnack(authState.message));
            }
          },

          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
            ),

            body: SafeArea(

              child: Stack(
                children: [

                Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/sign_up.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),

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
                                onTap: () {
                                  Navigator.popUntil(
                                    context,
                                        (route) => route.isFirst,
                                  );
                                },

                                child: Icon(
                                  Icons.arrow_back,
                                  color: ColorPalette.primaryColor,
                                ),
                              ),

                              const Icon(CupertinoIcons.settings_solid),
                            ],
                          ),


                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(4),

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

                          const Gap(30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              CustomAuthBottom(
                                height: 30,
                                width: 100,
                                onTap: () => pickImage,
                                text: 'Upload Image',
                                fontSize: 12,
                                textColor: Colors.white,
                                color: ColorPalette.primaryColor,
                              ),

                              CustomAuthBottom(
                                height: 30,
                                width: 100,
                                text: 'Clear',
                                fontSize: 12,
                                textColor: Colors.white,
                                color: Colors.red,
                              ),
                            ],
                          ),

                          const Gap(55),

                          CustomProfileTextFiled(
                            controller: cubit.name,
                            label: 'Name',
                          ),

                          const Gap(15),

                          CustomProfileTextFiled(
                            controller: cubit.email,
                            label: 'Email',
                          ),

                          const Gap(15),

                          CustomProfileTextFiled(
                            controller: cubit.address,
                            label: 'Address',
                          ),

                          const Gap(10),

                          Divider(color: ColorPalette.primaryColor),

                          const Gap(10),

                          cubit.userModel?.visa != null
                              ? CustomProfileTextFiled(
                            controller: cubit.visa,
                            label: 'visa',
                            textInputType: TextInputType.number,
                          )
                              : ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),

                            tileColor: Colors.blue.shade900,

                            leading: Image.asset(
                              AssetsPath.Asset,
                              width: 50,
                            ),

                            title: const CustomText(
                              text: 'Debit card',
                              color: Colors.white,
                              fontSize: 18,
                            ),

                            subtitle: CustomText(
                              text: cubit.userModel?.visa ?? '*****1235',
                              color: Colors.white,
                              fontSize: 18,
                            ),

                            trailing: const CustomText(
                              text: 'Default',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Gap(20),

                          Row(
                            children: [
                              Expanded(
                                child: BlocBuilder<ProfileCubit, ProfileState>(
                                  builder: (context, state) {
                                    final cubitProfile = context
                                        .read<ProfileCubit>();

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
//------edit profile
                                      child: Container(
                                        height: 50,

                                        decoration: BoxDecoration(
                                          color: Colors.white,

                                          border: Border.all(
                                            color: ColorPalette.primaryColor,
                                            width: 2,
                                          ),

                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),

                                        child: Center(
                                          child: state is UpdateProfileLoading
                                              ? const CupertinoActivityIndicator()
                                              : Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,

                                            children: [
                                              const CustomText(
                                                text: 'Edit Profile',
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),

                                              const SizedBox(width: 5),

                                              Icon(
                                                Icons.edit_document,
                                                color: ColorPalette
                                                    .primaryColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: BlocBuilder<AuthCubit, AuthStates>(
                                  builder: (context, state) {
                                    return InkWell(
                                      onTap: () {
                                        context.read<AuthCubit>().logout();
                                      },

                                      child: Container(
                                        height: 50,

                                        decoration: BoxDecoration(
                                          color: ColorPalette.primaryColor,

                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),

                                        child: Center(
                                          child: state is LogoutLoading
                                              ? const CupertinoActivityIndicator(
                                            color: Colors.white,
                                          )
                                              : const Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,

                                            children: [
                                              CustomText(
                                                text: 'Logout',
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),

                                              SizedBox(width: 5),

                                              Icon(
                                                Icons.logout,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),

                          const Gap(30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ]
            ),


          ),
          ),
        );
      },
    );
  }
}
