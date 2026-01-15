import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
class CustomUserTxtField extends StatelessWidget {
  const CustomUserTxtField({
    super.key,
    required this.controller,
    required this.label,
    this.textInputType,
  });
  final TextEditingController controller;
  final String label;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      controller: controller,
      keyboardType: textInputType,
      cursorColor: ColorPalette.primaryColor,
      style: TextStyle(color: ColorPalette.primaryColor, fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        labelText: label,
        labelStyle: TextStyle(color: ColorPalette.primaryColor),
        hintStyle: TextStyle(color: ColorPalette.primaryColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorPalette.primaryColor),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorPalette.primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}