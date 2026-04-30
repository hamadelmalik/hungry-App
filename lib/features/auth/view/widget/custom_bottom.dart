import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';


class CustomAuthBottom extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? background, textColor;
  final double? fontSize, height, width;
  final String text;
  final bool isLoading;

  const CustomAuthBottom({
    super.key,
    required this.text,
    this.onTap,
    this.background,
    this.textColor,
    this.fontSize,
    this.height,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: background ?? Colors.white,
        ),
        child: isLoading
            ? const SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : CustomText(
          text: text,
          fontSize: fontSize ?? 20,
          color: textColor ?? ColorPalette.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
