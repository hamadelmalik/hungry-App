

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/route/route_view.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/view/register_view.dart';
import 'package:hungry/features/auth/view/widget/custom_bottom.dart';
import 'package:hungry/shared/custom_btn.dart';
import 'package:hungry/shared/custom_snak.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_text_filed.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthRepo authRepo=AuthRepo();
  @override
  void initState() {

    emailController.text='balla@gmail.com';
    passwordController.text='11111111';

    super.initState();
  }
  bool isLoading = false;
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => isLoading = true);

    try {
      final user = await authRepo.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
     if(!mounted)return;
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => PageRouteView()));
      }
      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        customSnack(e is ApiError ? e.message : 'Unhandled login error'),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(

        body: Form(
          key: formKey,
          child: Column(
            children: [
              Gap(100),
          SvgPicture.asset(
            AssetsPath.hungryTex,
            colorFilter: ColorFilter.mode(
              ColorPalette.primaryColor,
              BlendMode.srcIn,
            ),),


              Gap(40),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                    ),
                    color: ColorPalette.primaryColor
                  ),

                  child: Column(
                    children: [
                      CustomTextFiled(
                        hint: 'Email Address',
                        isPassword: false,
                        controller: emailController,
                      ),
                      Gap(20),
                      CustomTextFiled(
                        hint: 'Password',
                        isPassword: true,
                        controller: passwordController,
                      ),
                      Gap(20),
                      //----------login------//
                      isLoading?CupertinoActivityIndicator(color: Colors.white,):
                      CustomAuthBottom(

                        height: 60,
                        width: double.infinity,
                        onTap: login,
                        text: 'Login',fontSize: 20,
                      ),
                      Gap(20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: 'Don have Account',
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => RegisterView(),) );
                            },
                            child: CustomText(
                              text: ' Create Account',
                              color: Colors.orangeAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      Gap(20),
               CustomBtn(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder:  (context) {
                       return PageRouteView();
                     },));
                   },
                   heightSize: 50, widthSize: 300, backgroundColor: Colors.orangeAccent,borderColor: Colors.transparent, child: CustomText(text: 'Continue As Guest',fontWeight: FontWeight.bold,color: ColorPalette.primaryColor,fontSize: 22,))

                    ],
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
