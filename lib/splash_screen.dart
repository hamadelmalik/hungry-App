import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 100),
              SvgPicture.asset(AssetsPath.hungryTex),
              SizedBox(height: 5),
              Text("Welcome Back and Discover Fast Food",
                style: TextStyle(fontSize: 16, color: Colors.white),),
               SizedBox(height: 30),
            ],
          ),

          // Bottom logo
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Image.asset(AssetsPath.appLogo),
          ),
        ],
      ),
    );
  }
}