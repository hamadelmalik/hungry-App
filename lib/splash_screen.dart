import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/route/route_view.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/view/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthRepo authRepo = AuthRepo();

  Future<void> _checkLogin() async {


    try {
      final user = await authRepo.autoLogin();


      if (!mounted) return;

      if (authRepo.isLoggedIn || authRepo.isGuest) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => PageRouteView()),
        );
      } else if (user != null) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginView()),
        );
      }
    } catch (e) {

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginView()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), _checkLogin);
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
        backgroundColor: Colors.transparent,
        body: Column(
          children: [

            Gap(20),
            Center(child: Image.asset(AssetsPath.appLogo)),
          ],
        ),
      ),
    );
  }
}