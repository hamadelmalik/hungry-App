import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';


class CustomAuthBottom extends StatelessWidget {
  final VoidCallback onTap;
  final Color? background, textColor;
  final double ?fontSize, height, width;

  final String text;

  const CustomAuthBottom(
      {super.key, required this.onTap, required this.text, this.background, this.textColor, this.fontSize, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: background ?? Colors.white,
        ),
        child: CustomText(
          text: text,
          fontSize: fontSize ?? 20,
          color: textColor ?? ColorPalette.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
