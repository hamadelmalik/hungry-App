import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';

class CardItem extends StatelessWidget {
  final String name, desc, image, rate;

  const CardItem({
    super.key,
    required this.name,
     required this.desc,
    required this.image,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    String baseUrl = "http://192.168.1.19:8000/";
    String fullImageUrl = image;
    print(fullImageUrl);
    log('📌 $fullImageUrl');


    return Card(
      color: ColorPalette.aje,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,


          children: [
            Center(
              child: Image.network(
                fullImageUrl,

                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              )

            ),
            Spacer(),
            CustomText(text: name,fontSize: 12,),

            Row(
              children: [
                CustomText(text: rate),
              Spacer(),
                Icon(
                  CupertinoIcons.heart_fill,
                  color: ColorPalette.primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
