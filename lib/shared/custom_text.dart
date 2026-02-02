import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color ?color;
  final double ? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;

  const CustomText({
    super.key,
    required this.text,
     this.color,
     this.fontSize,
    this.fontWeight, this.overflow ,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}