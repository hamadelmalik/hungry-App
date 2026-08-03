import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/route/route_view.dart';
import 'package:hungry/features/auth/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/cubit/auth_state.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/auth/view/widget/custom_bottom.dart';
import 'package:hungry/shared/custom_snack.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_text_filed.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => PageRouteView()),
          );
        }

        if (state is SignUpError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnack(state.message));
        }
      },

      builder: (context, state) {
        final cubit = context.read<AuthCubit>();

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

          child: Scaffold(
            backgroundColor: ColorPalette.primaryColor,

            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,

                  child: Column(
                    children: [

                     /// Logo
                      Image.asset(
                        'assets/images/last_logo.png',width: 400,height: 250,
                        fit: BoxFit.contain,

                      ),
                      const Gap(8),

                      CustomText(
                        text: "Register to Discover Delicious Meals",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),

                      const Gap(20),

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),

                        padding: const EdgeInsets.all(22),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(30),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 20,

                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [
                            CustomTextFiled(
                              hint: "Full Name",
                              isPassword: false,
                              controller: cubit.regNameController,
                            ),

                            const Gap(15),

                            CustomTextFiled(
                              hint: "Email Address",
                              isPassword: false,
                              controller: cubit.regEmailController,
                            ),

                            const Gap(15),

                            CustomTextFiled(
                              hint: "Password",
                              isPassword: true,
                              controller: cubit.regPassController,
                            ),

                            const Gap(35),

                            state is SignUpLoading
                                ? const SizedBox(
                                    height: 60,
                                    child: Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  )
                                : CustomAuthBottom(
                                    color: ColorPalette.primaryColor,
                                    height: 60,

                                    width: double.infinity,

                                    text: "Create Account",

                                    fontSize: 16,

                                    onTap: () {
                                      cubit.signup();
                                    },
                                  ),

                            const Gap(25),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                const CustomText(
                                  text: "Already have account?",
                                  color: Colors.black54,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LoginView(),
                                      ),
                                    );
                                  },

                                  child: const CustomText(
                                    text: " Sign In",

                                    color: ColorPalette.primaryColor,

                                    fontWeight: FontWeight.bold,

                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const Gap(30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
