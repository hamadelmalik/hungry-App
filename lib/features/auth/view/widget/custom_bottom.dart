import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';


class CustomAuthBottom extends StatelessWidget {
  final VoidCallback onTap;


  final String text;
  const CustomAuthBottom({super.key,required this.onTap,required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                    onTap: onTap,
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: CustomText(
                        text: text,
                        fontSize: 30,
                        color: ColorPalette.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
  }
}
