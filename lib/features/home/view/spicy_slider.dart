
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';
class SpicySlider extends StatelessWidget {
  final double value;
  final String? img,title,desc;

  final ValueChanged<double> onChanged;
  const SpicySlider({super.key,required this.value,required this.onChanged, required this.img, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: Image.network(img!),
        ),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 40.0),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 3),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
              trackHeight: 3,
            ),

            child: Slider(
              min: 0,
              max: 1,
              value: value,
              onChanged: onChanged,
              inactiveColor: Colors.grey.shade900.withValues(alpha: 0.2),
              activeColor: ColorPalette.primaryColor.withValues(alpha: 0.7),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 53),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: 'Cold 🥶', fontWeight:  FontWeight.bold,fontSize: 12,),
              Gap(100),
              CustomText(text: '🌶️ Hot', fontWeight: FontWeight.bold, fontSize: 12,),
            ],
          ),
        ),


      ],
    );
  }
}