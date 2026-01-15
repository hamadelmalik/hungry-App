import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/route/route_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(  Duration (seconds: 2),(){
      if (!mounted) return;

      Navigator.push(context, MaterialPageRoute(builder:  (context) => PageRouteView(),));
    }
    
    );
    super.initState();
  }
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