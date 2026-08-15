import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';

class CheckoutWidget extends StatelessWidget {
  final String title;
  final dynamic price;
  final bool isBold;

  const CheckoutWidget({
    super.key,
    required this.title,
    required this.price,
    required this.isBold,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          color: isBold
              ? Colors.black
              : ColorPalette.textColor,
          fontSize: 15,
          fontWeight: isBold
              ? FontWeight.bold
              : FontWeight.w400,
        ),

        CustomText(
          text: '$price\$',
          color: isBold
              ? Colors.black
              : ColorPalette.textColor,
          fontSize: 15,
          fontWeight: isBold
              ? FontWeight.bold
              : FontWeight.w400,
        ),
      ],
    );
  }
}