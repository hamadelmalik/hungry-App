import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
class CustomProfileTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const CustomProfileTextFiled({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return   TextField(
      controller:controller,
      cursorColor: ColorPalette.primaryColor,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorPalette.primaryColor,
            width: 1.5,
          ), // سمك البوردر لما يكون فوكس
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorPalette.primaryColor,
            width: 1.5,
          ), // سمك البوردر لما يكون فوكس
        ),

      ),
    );
  }
}
