
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/auth/view/widget/custom_bottom.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_text_filed.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorPalette.primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(50),
                  SvgPicture.asset(AssetsPath.hungryTex),
                  Gap(10),
                  CustomText(
                    text: 'Welcome Back and discover  Fast Food',
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  Gap(20),
                  ///////////name -------------------------
                  CustomTextFiled(
                    hint: 'Name',
                    isPassword: false,
                    controller: nameController,
                  ),
                  Gap(10),
                  CustomTextFiled(
                    hint: 'Email Address',
                    isPassword: false,
                    controller: emailController,
                  ),

                  //------------ password--------------
                  Gap(20),

                  CustomTextFiled(
                    hint: 'Password',
                    isPassword: true,
                    controller: passController,
                  ),
                  //------------confirm password--------------
                  Gap(20),
                  CustomTextFiled(
                    hint: 'confirm password',
                    isPassword: true,
                    controller: confirmPassController,
                  ),
                  Gap(20),
                  CustomAuthBottom(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        log("success login");
                      }
                    },
                    text: 'SignUp',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
