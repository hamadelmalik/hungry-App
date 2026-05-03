

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/route/route_view.dart';
import 'package:hungry/features/auth/repo/auth_repo.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/auth/view/widget/custom_bottom.dart';
import 'package:hungry/shared/custom_snak.dart';
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
  bool isLoading = false;
  final AuthRepo authRepo=AuthRepo();


  Future<void> signup () async {
    if(formKey.currentState!.validate()) {
      try {
        setState(() => isLoading = true);
        final user = await authRepo.signup(nameController.text.trim(), emailController.text.trim(), passController.text.trim());
        if(user != null) {
          Navigator.push(context, MaterialPageRoute(builder: (c) => PageRouteView()));
        }
        setState(() => isLoading = false);

      } catch (e) {
        setState(() => isLoading = false);
        String errMsg = 'Error in Register';
        if(e is ApiError) {
          errMsg = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
      }
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
           Column(
             children: [
               Gap(50),
               SvgPicture.asset(
                 AssetsPath.hungryTex,
                 colorFilter: ColorFilter.mode(
                   ColorPalette.primaryColor,
                   BlendMode.srcIn,
                 ),
               ),
               Gap(10),
               CustomText(
                 text: 'Please Register To discover ',
                 color: ColorPalette.primaryColor,
                 fontSize: 15,
               ),
             ],
           ),
              Gap(50),
             Expanded(
               child: Container(
                 padding: EdgeInsets.all(12),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(30),
                     topRight: Radius.circular(30),
                   ),
                   color: ColorPalette.primaryColor
                 ),

                 child: SingleChildScrollView(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                   
                       Gap(30),
                   
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
                       Gap(20),
                       CustomTextFiled(
                         hint: 'Password',
                         isPassword: true,
                         controller: passController,
                       ),
                       Gap(40),
                       //-----sing Up----------//
                       isLoading? CupertinoActivityIndicator(color: Colors.white,):CustomAuthBottom(
                         height: 60,
                         width: double.infinity,
                         onTap: signup,
                         text: 'SignUp',fontSize: 14,
                       ),
                       Gap(20),
                       Row(children: [
                         CustomText(text: 'Already have an account?',color: Colors.white,fontSize: 14,),
                         GestureDetector(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView(),));
                             },
                             child: CustomText(text: ' Sign In',color: Colors.orangeAccent,
                                 fontSize: 25,fontWeight: FontWeight.bold,))
                   
                       ],),
                   
                     
                     ],
                   ),
                 ),
               ),
             ),



            ],
          ),
        ),
      ),
    );
  }
}
