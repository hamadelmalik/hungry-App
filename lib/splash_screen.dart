import 'package:flutter/material.dart';
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
    print("CHECK LOGIN START");

    try {
      final user = await authRepo.autoLogin();
      print("USER RESULT: $user");
      print("isLoggedIn: ${authRepo.isLoggedIn}");
      print("isGuest: ${authRepo.isGuest}");

      if (!mounted) return;

      if (authRepo.isLoggedIn || authRepo.isGuest) {
        print("NAVIGATE TO HOME");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => PageRouteView()),
        );
      } else if (user != null) {
        print("NAVIGATE TO LOGIN");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginView()),
        );
      }
    } catch (e) {
      print("ERROR: $e");
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
            ColorPalette.primaryColor.withOpacity(0.2),
            ColorPalette.primaryColor.withOpacity(0.1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Image.asset(
            AssetsPath.appLogo,
            width: 180,
            height: 180,
          ),
        ),
      ),
    );
  }
}