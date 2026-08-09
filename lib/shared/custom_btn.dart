import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';

class CustomBtn extends StatelessWidget {
  final double heightSize;
  final double widthSize;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  final String? text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomBtn({
    super.key,
    required this.heightSize,
    required this.widthSize,
    this.backgroundColor,
    this.borderColor,
    this.onTap,
    this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: heightSize,
        width: widthSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor ?? Colors.white,
          ),
          color: backgroundColor ?? ColorPalette.primaryColor,
        ),
        child: text == null
            ? null
            : Text(
          text!,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? 16,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
        ),
      ),
    );
  }
}