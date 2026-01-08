import 'package:flutter/material.dart';
class CustomBtn extends StatelessWidget {
  final double heightSize,widthSize;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final Widget child;
  const CustomBtn({super.key,required this.heightSize,required this.widthSize, required this.backgroundColor, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        height: heightSize,
        width: widthSize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: backgroundColor),
        child:  child,
      ),
    );
  }
}
