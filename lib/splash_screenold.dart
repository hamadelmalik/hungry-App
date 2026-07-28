import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/route/route_view.dart';
import 'package:hungry/features/auth/repo/Auth/auth_repo.dart';
import 'package:hungry/features/auth/repo/profile/profile_repo.dart';
import 'package:hungry/features/auth/view/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;


  final apiServices = ApiServices();

  late final profileRepo = ProfileRepo(
    apiServices: apiServices,
  );

  late final authRepo = AuthRepo(
    apiServices: apiServices,
    profileRepo: profileRepo,
  );

  Future<void> _checkLogin() async {
    log('start check Login');
    try {
      final user = await authRepo.autoLogin();
      if (!mounted) return;
      if (authRepo.isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => PageRouteView()),
        );
      } else if (authRepo.isGuest) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => PageRouteView()),
        );
      } else if (user !=null){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => LoginView()),
        );
      }
    } catch (e) {
      debugPrint('Auto login failed: $e');
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) =>  LoginView()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 200),
      () => setState(() => _opacity = 1.0),
    );
    Future.delayed(Duration(milliseconds: 800), _checkLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [


            ColorPalette.primaryColor.withValues(alpha: 0.2),
            ColorPalette.primaryColor.withValues(alpha: 0.1),


          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.green.withValues(alpha: 0.1).withAlpha(1),        body: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 3),
            opacity: _opacity,
            curve: Curves.easeInOut,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                const Gap(280),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.8, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutBack,
                  builder: (context, scale, child) =>
                      Transform.scale(scale: scale, child: child),
                  child: SvgPicture.asset(AssetsPath.appLogo)
                ),

                const Spacer(),

                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 40, end: 0),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) => Transform.translate(
                    offset: Offset(0, value),
                    child: child,
                  ),
                  child: Image.asset(AssetsPath.appLogo),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
