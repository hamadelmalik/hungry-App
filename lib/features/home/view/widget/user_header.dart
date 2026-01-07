
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AssetsPath.hungryTex,
          width: 150,
          colorFilter: ColorFilter.mode(
            ColorPalette.primaryColor,
            BlendMode.srcIn,
          ),
        ),
        const Spacer(),
        const CircleAvatar(
          backgroundColor: ColorPalette.primaryColor,
            child: Icon(Icons.person ,weight: 88,color: Colors.white,),
            radius: 30),
      ],
    );

  }
}
