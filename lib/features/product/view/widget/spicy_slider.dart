

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/shared/custom_text.dart';
class SpicySlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  const SpicySlider({super.key,required this.value,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AssetsPath.product1,
          width: 180,
        ),
        Column(children: [
          CustomText(
            text:'Customize Your Burger\n to Your Tastes. \nUltimate Experience',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          CustomText(text: 'Spicy'),
          Slider(
            min: 0,
              max: 1,
              value: value,
              onChanged: onChanged),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: '🥶'),
              Gap(90),
              CustomText(text: '🌶️')

            ],)
        ],)




      ],
    );
  }
}
