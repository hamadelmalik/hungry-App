import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/auth/view/widget/custom_bottom.dart';
import 'package:hungry/features/auth/view/widget/guest_mode.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/view/widget/custom_profile_text_filed.dart';
import 'package:hungry/shared/custom_snak.dart';
import 'package:hungry/shared/custom_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();
  bool isLoading = false;
  bool isLoadingUpdate = false;
  bool isLogoutLoading = false;
  int currentIndex = 0;
  String? selectImage;
  bool isGuest = false;
  final AuthRepo authRepo = AuthRepo();
  UserModel? userModel;

  //--------getProfileData--------------//
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();

      if (!mounted) return;
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMsg = 'Profile Error';

      if (e is ApiError) {
        log(errorMsg.toString());
        errorMsg = e.message.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }

  //--------pickImage--------------//
  Future<void> pickImage() async {
    final imagePicker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (imagePicker != null) {
        selectImage = imagePicker.path;
      }
    });
  }

  //--------updateProfile--------------//

  Future<void> updateProfileData() async {
    try {
      log('updateProfileData in process');
      setState(() => isLoadingUpdate = true);

      // 1. Update profile
      await authRepo.updateProfileData(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        visa: _visa.text.trim(),
        imagePath: selectImage,
      );

      // 2. Fetch updated profile (void)
      await getProfileData();

      if (!mounted) return;
      setState(() {
        selectImage = null;
        isLoadingUpdate = false;
      });

      // 3. Success message
      ScaffoldMessenger.of(context).showSnackBar(
        customSnack(
          'Update Profile Successfully',
          color: Colors.green,
          iconData: CupertinoIcons.check_mark_circled_solid,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoadingUpdate = false);

      String errorMsg = 'Error update profile';
      if (e is ApiError) errorMsg = e.message;
      log(errorMsg.toString());
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }

  //--------logout--------------//
  Future<void> logout() async {
    setState(() => isLogoutLoading = true);

    try {
      await authRepo.logout();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginView()),
      );
    } catch (e, s) {
      log("❌ LOGOUT ERROR: $e");
      log("STACK TRACE: $s");
    } finally {
      if (mounted) {
        setState(() => isLogoutLoading = false);
      }
    }
  }

  void clearImage() {
    setState(() {
      selectImage = null;
    });
  }

  //----------autologin---------..
  Future<void> autoLogin() async {
    final user = await authRepo.autoLogin();
    setState(() => isGuest = authRepo.isGuest);
    if (user != null) {
      setState(() => isGuest = authRepo.isGuest);
    }
  }

  @override
  void initState() {
    super.initState();
    autoLogin();
    // تحميل بيانات المستخدم
    getProfileData()
        .then((v) {
          _name.text = userModel?.name.toString() ?? 'hamad';
          _email.text = userModel?.email.toString() ?? 'Hamad4alll@gmail.com';
          _address.text =userModel?.address.toString() ?? 'sudan';
          _visa.text = userModel?.visa.toString() ?? '';

          // تحديث الواجهة بعد تغيير البيانات

          setState(() {});
        })
        .catchError((e) {
          // التعامل مع أي خطأ في تحميل البيانات
          log('⚠️ Error loading user data: $e');
        });
  }

  @override
  Widget build(BuildContext context) {
    if (!isGuest) {
      return Scaffold(
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
              await getProfileData();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Skeletonizer(
                enabled: userModel == null,
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
                              child: selectImage != null
                                  ? Image.file(
                                      File(selectImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : (userModel?.image != null &&
                                        userModel!.image.isNotEmpty)
                                  ? ClipOval(
                                      child: Image.network(
                                        userModel!.image,
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
                          background: ColorPalette.primaryColor,
                        ),
                        //------clearImage------
                        CustomAuthBottom(
                          height: 30,
                          width: 100,
                          onTap: clearImage,
                          text: 'clear',
                          fontSize: 12,
                          textColor: Colors.white,
                          background: Colors.red,
                        ),
                      ],
                    ),

                    Gap(15),
                    CustomProfileTextFiled(controller: _name, label: 'Name'),
                    Gap(15),
                    CustomProfileTextFiled(controller: _email, label: 'Email'),
                    Gap(15),
                    CustomProfileTextFiled(
                      controller: _address,
                      label: 'Address',
                    ),
                    Gap(10),
                    Divider(color: ColorPalette.primaryColor),
                    Gap(10),

                    //---visa--------------
                    userModel?.visa != null
                        ? CustomProfileTextFiled(
                            controller: _visa,
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
                                final visa = userModel?.visa;

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
                  child: InkWell(
                    onTap: isLoadingUpdate ? null : updateProfileData,
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
                        child: isLoadingUpdate
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
                  ),
                ),
                SizedBox(width: 10), // مسافة بين الزرين
                Expanded(
                  child: InkWell(
                    onTap: logout,

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
                        child: isLogoutLoading
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
    } else if (isGuest) {
      return GuestModeView();
    }
    return SizedBox();
  }
}
