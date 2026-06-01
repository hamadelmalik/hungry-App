import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/route/route_view.dart';
import 'package:hungry/features/auth/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/cubit/auth_state.dart';
import 'package:hungry/features/auth/view/register_view.dart';
import 'package:hungry/features/auth/view/widget/custom_bottom.dart';
import 'package:hungry/shared/custom_btn.dart';
import 'package:hungry/shared/custom_snak.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_text_filed.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {


    return BlocListener<AuthCubit,AuthStates>(
        listener: (context,state){

          if(state is AuthSuccess){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PageRouteView(),
              ),
            );

          }
          if(state is AuthError){
            ScaffoldMessenger.of(context).showSnackBar(
                customSnack(state.message));
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
             backgroundColor: ColorPalette.primaryColor,
            body: Form(
              key: context.read<AuthCubit>().formKey,
              child: Column(
                children: [
                  Gap(20),
                  Image.asset(
                    'assets/images/lastlogo.png',width: 400,height: 200,
                    fit: BoxFit.contain,

                  ),

                  Gap(40),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                        ),
                        color: Colors.white
                      ),

                      child: Column(
                        children: [
                          CustomTextFiled(
                            hint: 'Email Address',
                            isPassword: false,
                            controller: context.read<AuthCubit>().emailController,
                          ),
                          Gap(20),
                          CustomTextFiled(
                            hint: 'Password',
                            isPassword: true,
                            controller: context.read<AuthCubit>().passwordController,
                          ),
                          Gap(20),
                          //----------login------//
                        //  isLoading?CupertinoActivityIndicator(color: ColorPalette.primaryColor,):
                          BlocBuilder<AuthCubit,AuthStates>(
                            builder: (context,state){
                              final loading = state is AuthLoading;
                              return CustomAuthBottom(
                                text: 'Login',
                                height: 60,
                                width: double.infinity,
                                background: ColorPalette.primaryColor,
                                textColor: Colors.white,
                                fontSize: 20,
                                isLoading: loading,
                                onTap: (){
                                  if (!context.read<AuthCubit>().formKey.currentState!.validate()) return;
                                  context.read<AuthCubit>().login(email: context.read<AuthCubit>().emailController.text.trim(), password: context.read<AuthCubit>().passwordController.text.trim());
                                },
                              );
                            },

                          ),


                          Gap(20),
                          Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  text: 'Don’t have an account?',
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
                                      color: ColorPalette.primaryColor,
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
                       heightSize: 50, widthSize: 300, backgroundColor: ColorPalette.darkMocha,borderColor: Colors.transparent, child: CustomText(text: 'Continue As Guest',fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18,))

                        ],
                      ),
                    ),
                  )


                ],
              ),
            ),
          ),
        ),

    );
  }
}
