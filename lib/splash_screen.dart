import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/route/route_view.dart';
import 'package:hungry/features/auth/repo/auth_repo.dart';
import 'package:hungry/features/auth/view/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AuthRepo authRepo = AuthRepo();

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Fade: يبقى تدريجي وسلس
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Scale: مع Overshoot / Bounce effect
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
      // لو تحب أكثر Bounce ممكن تستخدم Curves.elasticOut
    );

    _controller.forward();

    // الانتظار قبل فحص تسجيل الدخول
    Future.delayed(const Duration(seconds: 3), _checkLogin);
  }

  Future<void> _checkLogin() async {
    try {
      final user = await authRepo.autoLogin();

     // if (!mounted) return;

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE93918),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/last_logo.png',
                  fit: BoxFit.contain,

                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
