
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  UserModel? userModel;
  final AuthRepo authRepo = AuthRepo();
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMsg = 'Profile Error';

      if (e is ApiError) {
        throw errorMsg = e.message.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }
  @override
  void initState() {
    super.initState();

    // تحميل بيانات المستخدم
    getProfileData().then((v) {
      // طباعة للتأكد إن البيانات اتجمعت
      log('🔐 User data loaded successfully');
      log('Name: ${userModel?.name}');
      log('Email: ${userModel?.email}');
      log('Address: ${userModel?.address}');

      // تحديث TextEditingControllers
      _name.text = userModel?.name.toString() ?? 'hamad';
      _email.text = userModel?.email.toString() ?? 'Hamad4alll@gmail.com';
      _address.text = userModel?.address.toString() ?? 'Sudan';

      // تحديث الواجهة بعد تغيير البيانات
      setState(() {});
    }).catchError((e) {
      // التعامل مع أي خطأ في تحميل البيانات
      log('⚠️ Error loading user data: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor:  ColorPalette.aje,
      appBar: AppBar(
    //    backgroundColor:  ColorPalette.aje,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: ColorPalette.primaryColor),
        ),
        actions: [
          SvgPicture.asset(
            AssetsPath.settings,
            colorFilter: ColorFilter.mode(
              ColorPalette.primaryColor,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                    image: DecorationImage(
                      image: NetworkImage(
                        userModel?.image ?? 'https://tse4.mm.bing.net/th/id/OIP.hGSCbXlcOjL_9mmzerqAbQHaHa?pid=Api&P=0&h=220',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              ),
              Gap(15),
              CustomProfileTextFiled(controller: _name, label: 'Name'),
              Gap(15),
              CustomProfileTextFiled(controller: _email, label: 'Email'),
              Gap(15),
              CustomProfileTextFiled(controller: _address, label: 'Address'),
              Gap(10),
              Divider(color: ColorPalette.primaryColor),
              Gap(10),
              ListTile(
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
                subtitle: const CustomText(
                  text: '******2345',
                  color: Colors.white,
                  fontSize: 18,
                ),
                trailing: CustomText(
                  text: 'Default',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(20),
            ],
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
              Container(
                padding: EdgeInsets.all(10),
                height: 60,
                width: 180,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorPalette.primaryColor,
                    width: 2,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Edit Profile',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),

                    SvgPicture.asset(
                      AssetsPath.edit,
                      colorFilter: ColorFilter.mode(
                        ColorPalette.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: 60,
                width: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: ColorPalette.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Log Out',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),

                    Icon(Icons.logout, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
