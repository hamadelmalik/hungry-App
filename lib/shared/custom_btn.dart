import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
class CustomBtn extends StatelessWidget {
  final double heightSize,widthSize;

  final Color? backgroundColor,borderColor;
  final VoidCallback? onTap;
  final Widget child;
  const CustomBtn({super.key,required this.heightSize,required this.widthSize, required this.backgroundColor, this.onTap, required this.child,  this.borderColor});

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: heightSize,
        width: widthSize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor ?? Colors.white),
            color: backgroundColor ?? ColorPalette.primaryColor),

        child:  child,
      ),
    );
  }
}
