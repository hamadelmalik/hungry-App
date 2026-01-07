import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';
class CardItem extends StatelessWidget {
  final String text,desc,image,rate;
  const CardItem({super.key ,required this.text,required this.desc,required this.image,required this.rate});

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image,width: 150,),
            CustomText(text: text),
            CustomText(text:desc),
            Row(children: [
              CustomText(text: rate),
              Spacer(),
              Icon(CupertinoIcons.heart_fill,color: ColorPalette.primaryColor),
            ],)

          ],
        ),
      ),
    );
  }
}
