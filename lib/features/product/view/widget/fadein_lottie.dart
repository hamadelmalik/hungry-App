import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FadeLottieScreen extends StatefulWidget {
  const FadeLottieScreen({super.key});

  @override
  State<FadeLottieScreen> createState() => _FadeLottieScreenState();
}

class _FadeLottieScreenState extends State<FadeLottieScreen> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  Future<void> startAnimation() async {
    // Fade In
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    setState(() => opacity = 1.0);

    // Stay visible
    await Future.delayed(const Duration(seconds: 3));

    // Fade Out
    if (!mounted) return;
    setState(() => opacity = 0.0);

    // Optional: navigate or close screen
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    // مثال: إغلاق الشاشة
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Load a Lottie file from your assets
        //  Lottie.asset('assets/LottieLogo1.json'),

          // Load a Lottie file from a remote url
          Lottie.asset(
            'assets/lottie/tt.json'

          ),

          // Load an animation and its images from a zip file
      //    Lottie.asset('assets/lottiefiles/angel.zip'),
        ],
      ),
    );

  }
}