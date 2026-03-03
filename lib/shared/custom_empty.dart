
import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';

class CustomEmpty extends StatelessWidget {
  const CustomEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
    color: ColorPalette.aje

    ),
    child: CustomText(text: 'No Data Found', color: Colors.
    white,),);

  }
}
